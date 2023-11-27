; *********************************************************************************
; * IST-UL
; * Modulo:    lab6-barra-interrupcao.asm
; * Descri��o: Este programa anima uma barra (8 pixels) que desce verticalmente no ecr�.
; *			A temporiza��o do movimento � feita por interrup��o com um rel�gio de tempo real. 
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
COMANDOS				EQU	6000H			; endere�o de base dos comandos do MediaCenter

DEFINE_LINHA    		EQU COMANDOS + 0AH		; endere�o do comando para definir a linha
DEFINE_COLUNA   		EQU COMANDOS + 0CH		; endere�o do comando para definir a coluna
ESCREVE_8_PIXELS    	EQU COMANDOS + 1CH		; endere�o do comando para escrever 8 pixels
APAGA_AVISO     		EQU COMANDOS + 40H		; endere�o do comando para apagar o aviso de nenhum cen�rio selecionado
APAGA_ECR�	 		EQU COMANDOS + 02H		; endere�o do comando para apagar todos os pixels j� desenhados

N_LINHAS				EQU  32				; n�mero de linhas do �cr�
BARRA				EQU  0FFH				; valor do byte usado para representar a barra

; *********************************************************************************
; * Dados 
; *********************************************************************************
	PLACE       1000H
pilha:
	STACK 100H			; espa�o reservado para a pilha 
						; (200H bytes, pois s�o 100H words)
SP_inicial:				; este � o endere�o (1200H) com que o SP deve ser 
						; inicializado. O 1.� end. de retorno ser� 
						; armazenado em 11FEH (1200H-2)
                              
; Tabela das rotinas de interrup��o
tab:
	WORD rot_int_0			; rotina de atendimento da interrup��o 0

linha_barra:
	WORD 0				; linha em que a barra est�
                              
; *********************************************************************************
; * C�digo
; *********************************************************************************
	PLACE   0				; o c�digo tem de come�ar em 0000H
inicio:
	MOV  SP, SP_inicial		; inicializa SP para a palavra a seguir
						; � �ltima da pilha
                            
	MOV  BTE, tab			; inicializa BTE (registo de Base da Tabela de Exce��es)

	MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cen�rio selecionado (o valor de R1 n�o � relevante)
	MOV  [APAGA_ECR�], R1	; apaga todos os pixels j� desenhados (o valor de R1 n�o � relevante)
     
	EI0					; permite interrup��es 0
	EI					; permite interrup��es (geral)

fim:
	JMP fim				; fica � espera

; **********************************************************************
; ROT_INT_0 - 	Rotina de atendimento da interrup��o 0
;			Faz a barra descer uma linha. A anima��o da barra � causada pela
;			invoca��o peri�dica desta rotina
; **********************************************************************
rot_int_0:
	CALL anima_barra		; faz a barra descer de uma linha. Se chegar ao fundo, passa ao topo
	RFE					; Return From Exception (diferente do RET)

; **********************************************************************
; ANIMA_BARRA - Desenha e faz descer uma barra de 8 pixels no ecr�.
;			 Se chegar ao fundo, passa ao topo.
;			 A linha em que o byte � escrito � guardada na vari�vel linha_barra
; Argumentos: Nenhum
; **********************************************************************
anima_barra:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	MOV  R3, 0			; coluna a partir da qual a barra � desenhada
	MOV  R2, [linha_barra]	; linha em que a barra est�
	MOV  R1, 0			; para apagar a barra
	CALL escreve_byte		; apaga a barra do ecr�
	ADD  R2, 1			; passa � linha abaixo
	MOV  R4, N_LINHAS
	CMP  R2, R4			; j� estava na linha do fundo?
	JLT  escreve
	MOV  R2, 0			; volta ao topo do ecr�
escreve:
	MOV  [linha_barra], R2	; atualiza na vari�vel a linha em que a barra est�
	MOV  R1, BARRA			; valor da barra
	CALL escreve_byte		; escreve a barra na nova linha
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	RET

; **********************************************************************
; ESCREVE_BYTE - Escreve um byte no ecr�, com a cor da caneta
; Argumentos:	R1 - Valor do byte a escrever
;			R2 - Linha onde escrever o byte (entre 0 e N_LINHAS - 1)
;			R3 - Coluna a partir da qual a barra deve ser desenhada 
; **********************************************************************
escreve_byte:
	MOV  [DEFINE_LINHA], R2		; seleciona a linha
	MOV  [DEFINE_COLUNA], R3		; seleciona a coluna
	MOV  [ESCREVE_8_PIXELS], R1	; escreve os 8 pixels correspondentes ao byte
	RET


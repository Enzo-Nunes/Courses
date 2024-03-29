; *********************************************************************************
; * IST-UL
; * Modulo:	lab6-quatro-barras.asm
; * Descri��o: Este programa anima quatro barras que descem verticalmente no ecr�,
; *			cada uma na sua coluna.
; *			As temporiza��es do movimento s�o feitas por ciclos de atraso. 
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
DELAY				EQU  3000H			; valor usado para implementar um atraso temporal    

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
                              
linha_barra:
	WORD 0				; linha em que a 1� barra est�
	WORD 0				; linha em que a 2� barra est�
	WORD 0				; linha em que a 3� barra est�
	WORD 0				; linha em que a 4� barra est�
                              
; *********************************************************************************
; * C�digo
; *********************************************************************************
	PLACE   0				; o c�digo tem de come�ar em 0000H
inicio:
	MOV  SP, SP_inicial		; inicializa SP para a palavra a seguir
						; � �ltima da pilha
                            
	MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cen�rio selecionado (o valor de R1 n�o � relevante)
	MOV  [APAGA_ECR�], R1	; apaga todos os pixels j� desenhados (o valor de R1 n�o � relevante)
     
reinicia:     
	MOV  R3, 0			; coluna a partir da qual a barra � desenhada
	MOV  R1, DELAY			; valor para o atraso (da 1� barra)
ciclo:
	CALL anima_barra		; desenha e faz a barra descer de uma linha. Se chegar ao fundo, passa ao topo
	CALL atraso			; espera algum tempo
	SHR  R1, 1			; passa o atraso para metade (para a pr�xima barra evoluir mais depressa)
						; Cada barra tem metade do atraso da barra anterior
	ADD  R3, 1			; pr�xima barra
	CMP  R3, 4			; j� chegou � �ltima barra?
	JLT  ciclo			; anima a pr�xima barra novamente
	JMP  reinicia			; volta � primeira barra

; **********************************************************************
; ANIMA_BARRA - Desenha e faz descer uma barra de 8 pixels no ecr�.
;			 Se chegar ao fundo, passa ao topo.
;			 A linha em que o byte � escrito � guardada na vari�vel linha_barra, que �
;			 uma tabela de quatro vari�veis simples, uma para cada barra
; Argumentos: R3 - N� da barra (0 a 3)
; **********************************************************************
anima_barra:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	MOV  R5, linha_barra
	MOV  R6, R3			; c�pia de R3 (para n�o destruir R3)
	SHL  R6, 1			; multiplica o n� da barra por 2 (porque a linha_barra � uma tabela de words)
	MOV  R2, [R5+R6]		; linha em que a barra est�
	SHL  R3, 3			; multiplica o n� da barra por 8 para dar a coluna onde desenhar o byte
	MOV  R1, 0			; para apagar a barra
	CALL escreve_byte		; apaga a barra do ecr�
	ADD  R2, 1			; passa � linha abaixo
	MOV  R4, N_LINHAS
	CMP  R2, R4			; j� estava na linha do fundo?
	JLT  escreve
	MOV  R2, 0			; volta ao topo do ecr�
escreve:
	MOV  [R5+R6], R2		; atualiza na tabela a linha em que esta barra est�
	MOV  R1, BARRA			; valor da barra
	CALL escreve_byte		; escreve a barra na nova linha
	POP  R6
	POP  R5
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

; **********************************************************************
; ATRASO - Espera algum tempo
; Argumentos: R1 - Valor a usar no contador para o atraso
; **********************************************************************
atraso:
	PUSH R1
continua:
	SUB  R1, 1				; decrementa o contador de 1 unidade
	JNZ  continua				; s� sai quando o contador chegar a 0
	POP  R1
	RET


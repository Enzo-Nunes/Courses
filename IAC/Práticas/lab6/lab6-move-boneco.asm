; *********************************************************************************
; * IST-UL
; * Modulo:    lab6-move-boneco.asm
; * Descrição: Este programa ilustra o movimento de um boneco no ecrã, com uma interrupção
; *			para estabelecer a velocidade de movimentação.
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
COMANDOS				EQU	6000H			; endereço de base dos comandos do MediaCenter

DEFINE_LINHA    		EQU COMANDOS + 0AH		; endereço do comando para definir a linha
DEFINE_COLUNA   		EQU COMANDOS + 0CH		; endereço do comando para definir a coluna
DEFINE_PIXEL    		EQU COMANDOS + 12H		; endereço do comando para escrever um pixel
APAGA_AVISO     		EQU COMANDOS + 40H		; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 		EQU COMANDOS + 02H		; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO  EQU COMANDOS + 42H		; endereço do comando para selecionar uma imagem de fundo

LINHA        		EQU  16        ; linha do boneco (a meio do ecrã))
COLUNA			EQU  30        ; coluna do boneco (a meio do ecrã)

MIN_COLUNA		EQU  0		; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		EQU  63        ; número da coluna mais à direita que o objeto pode ocupar

LARGURA			EQU	5		; largura do boneco
COR_PIXEL			EQU	0FF00H	; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)

; *********************************************************************************
; * Dados 
; *********************************************************************************
	PLACE       1000H
pilha:
	STACK 100H			; espaço reservado para a pilha 
						; (200H bytes, pois são 100H words)
SP_inicial:				; este é o endereço (1200H) com que o SP deve ser 
						; inicializado. O 1.º end. de retorno será 
						; armazenado em 11FEH (1200H-2)
							
; Tabela das rotinas de interrupção
tab:
	WORD rot_int_0			; rotina de atendimento da interrupção 0

DEF_BONECO:				; tabela que define o boneco (cor, largura, pixels)
	WORD		LARGURA
	WORD		COR_PIXEL, 0, COR_PIXEL, 0, COR_PIXEL		; # # #   as cores podem ser diferentes de pixel para pixel
     
                              

; *********************************************************************************
; * Código
; *********************************************************************************
PLACE   0                     ; o código tem de começar em 0000H
inicio:
	MOV  SP, SP_inicial		; inicializa SP para a palavra a seguir
						; à última da pilha
                            
	MOV  BTE, tab			; inicializa BTE (registo de Base da Tabela de Exceções)

     MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
     MOV  [APAGA_ECRÃ], R1	; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
	MOV	R1, 0			; cenário de fundo número 0
     MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	MOV	R7, 1			; valor a somar à coluna do boneco, para o movimentar
     
posicao_boneco:
     MOV  R1, LINHA			; linha do boneco
	MOV	R2, COLUNA
	MOV	R4, DEF_BONECO		; endereço da tabela que define o boneco
	CALL	desenha_boneco		; desenha o boneco inicialmente (a partir da tabela)
	
	EI0					; permite interrupções 0
	EI					; permite interrupções (geral)

fim:
	JMP fim				; fica à espera


; **********************************************************************
; ROT_INT_0 - 	Rotina de atendimento da interrupção 0
;			Faz o boneco mover-se
; **********************************************************************
rot_int_0:
	CALL	move_boneco		; move o boneco, de acordo com R7
	RFE					; Return From Exception (diferente do RET)


; **********************************************************************
; MOVE_BONECO - Desenha um boneco na linha e coluna indicadas
;			 com a forma e cor definidas na tabela indicada.
; Argumentos:	R1 - linha
;			R2 - coluna
;			R4 - tabela que define o boneco
;			R7 - sentido de movimento do boneco (valor a somar à coluna
;				em cada movimento: +1 para a direita, -1 para a esquerda)
;
; Retorna:	R2 - novo valor da coluna, após o movimento
;			R7 - novo sentido de movimento (pode ser o mesmo)
; **********************************************************************
move_boneco:
	PUSH	R3
	PUSH	R4
	PUSH	R5

	CALL	apaga_boneco		; apaga o boneco na sua posição corrente
	
	MOV	R6, [R4]			; obtém a largura do boneco
	CALL	testa_limites		; vê se chegou aos limites do ecrã e nesse caso inverte o sentido

coluna_seguinte:
	ADD	R2, R7			; para desenhar objeto na coluna seguinte (direita ou esquerda)

	CALL	desenha_boneco		; desenha o boneco a partir da tabela

	POP	R5
	POP	R4
	POP	R3
	RET


; **********************************************************************
; DESENHA_BONECO - Desenha um boneco na linha e coluna indicadas
;			    com a forma e cor definidas na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o boneco
;
; **********************************************************************
desenha_boneco:
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	MOV	R5, [R4]			; obtém a largura do boneco
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
desenha_pixels:       		; desenha os pixels do boneco a partir da tabela
	MOV	R3, [R4]			; obtém a cor do próximo pixel do boneco
	CALL	escreve_pixel		; escreve cada pixel do boneco
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  desenha_pixels      ; continua até percorrer toda a largura do objeto
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	RET

; **********************************************************************
; APAGA_BONECO - Apaga um boneco na linha e coluna indicadas
;			  com a forma definida na tabela indicada.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R4 - tabela que define o boneco
;
; **********************************************************************
apaga_boneco:
	PUSH	R2
	PUSH	R3
	PUSH	R4
	PUSH	R5
	MOV	R5, [R4]			; obtém a largura do boneco
	ADD	R4, 2			; endereço da cor do 1º pixel (2 porque a largura é uma word)
apaga_pixels:       		; desenha os pixels do boneco a partir da tabela
	MOV	R3, 0			; cor para apagar o próximo pixel do boneco
	CALL	escreve_pixel		; escreve cada pixel do boneco
	ADD	R4, 2			; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
     ADD  R2, 1               ; próxima coluna
     SUB  R5, 1			; menos uma coluna para tratar
     JNZ  apaga_pixels      ; continua até percorrer toda a largura do objeto
	POP	R5
	POP	R4
	POP	R3
	POP	R2
	RET


; **********************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; **********************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2		; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET


; **********************************************************************
; TESTA_LIMITES - Testa se o boneco chegou aos limites do ecrã e nesse caso
;			   inverte o sentido de movimento
; Argumentos:	R2 - coluna em que o objeto está
;			R6 - largura do boneco
;			R7 - sentido de movimento do boneco (valor a somar à coluna
;				em cada movimento: +1 para a direita, -1 para a esquerda)
;
; Retorna: 	R7 - novo sentido de movimento (pode ser o mesmo)	
; **********************************************************************
testa_limites:
	PUSH	R5
	PUSH	R6
testa_limite_esquerdo:		; vê se o boneco chegou ao limite esquerdo
	MOV	R5, MIN_COLUNA
	CMP	R2, R5
	JLE	inverte_para_direita
testa_limite_direito:		; vê se o boneco chegou ao limite direito
	ADD	R6, R2			; posição a seguir ao extremo direito do boneco
	MOV	R5, MAX_COLUNA
	CMP	R6, R5
	JGT	inverte_para_esquerda
	JMP	sai_testa_limites	; entre limites. Mantém o valor do R7

inverte_para_direita:
	MOV	R7, 1			; passa a deslocar-se para a direita
	JMP	sai_testa_limites
inverte_para_esquerda:
	MOV	R7, -1			; passa a deslocar-se para a esquerda
sai_testa_limites:	
	POP	R6
	POP	R5
	RET


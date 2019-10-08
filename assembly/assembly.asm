SETUP:
    LEAi US, 0 # Inicializa os Registradores com valores iniciais respectivos
    LEAi DS, 0
    LEAi UM, 9
    LEAi DM, 5
    LEAi UH12, 1
    LEAi DH12, 1
    LEAi UH24, 3
    LEAi DH24, 2
    LEAi AMPM, 11
    LEAi IOSR, 14
    LOAD IOSR, 7AMPM # Carrega 14 no endereço de dois displays para deixa-los apagados
    LOAD IOSR, 7NADA
    JMP COMECA
PRELOOP:
    LEAi IOSR, 1 # Setar o começo do loop da base de tempo
    LOAD IOSR, BaseTempo
LOOP:
	LEA BaseTempo, IOSR # Faz o loop da base de tempo
	CMPe JER, IOSR, 1
	JE COMECA
	JMP LOOP
COMECA:
    LEA SWs, IOSR
    CMPe JER, IOSR, 2 # Checa se a chave 2 esta acionada (Hora)
    JE CONFIGHORA
    LEA SWs, IOSR
    CMPe JER, IOSR, 1 # Checa se a chave 1 esta acionada (Minuto)
    JE CONFIGMIN
    LEA SWs, IOSR
    CMPe JER, IOSR, 4 # Checa se a chave 4 esta acionada (12h / 24h)
    JE 12h
    JMP 24h
TEMPO:
    ADDi US, US, 1 # Loop para os Segundos
    CMPi JLER, US, 9
    JB CDS
TAG1:
    CMPi JLER, DS, 5 # Pula se a dezena do segundo é maior que 5
    JB CUM
TAG2:
    CMPi JLER, UM, 9 # Pula se a unidade do minuto for maior que 9
    JB CDM
TAG3:
    CMPi JLER, DM, 5 # Pula se a dezena do minuto for maior que 5
    JB CUH12
TAG4:
    CMPi JLER, UH12, 2 # Pula se a unidade da hora 12h for maior que 2
    JB CDH12
TAG5:
    CMPi JLER, UH24, 3 # Pula se a unidade da hora 24h for maior que 3
    JB CUH24
TAG6:
    JMP PRELOOP # Volta para o PRELOOP
CDS:
    LEAi US, 0 # Zera o segundo e soma na dezena do segundo
    ADDi DS, DS, 1
    JMP TAG1
CUM:
    LEAi DS, 0 # Zera a dezena e soma na unidade minuto
    ADDi UM, UM, 1
    JMP TAG2
CDM:
    LEAi UM, 0 # Zera a unidade minuto e soma na dezena minuto
    ADDi DM, DM, 1
    JMP TAG3
CUH12:
    LEAi DM, 0 # Zera na dezena minuto e soma na unidade hora de 24h e 12h
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
    JMP TAG4
CDH12:
    CMPi JLER, DH12, 0 # Zera a dezena hora 12h
    JB CDH122
TAG01:
    CMPi JLER, UH12, 9 # Pula s e a unidade hora 12h for maior que 9
    JB CDH123
    JMP TAG5
CDH122:
    LEAi UH12, 1 # Checar o AM PM
    LEAi DH12, 0
    CMPe JLER, AMPM, 10
    JE SETAZERO
    LEAi AMPM, 10
    JMP TAG01
SETAZERO: # Condição para o AMPM
    LEAi AMPM, 11
    JMP TAG01
CDH123: # Zerar unidade hora 12h e somar na dezena hora 12h
    LEAi UH12, 0
    ADDi DH12, DH12, 1
    JMP TAG5
CUH24: # Pula se dezena hora 24h for maior que 1
    CMPi JLER, DH24, 1
    JB CDH24
TAG001: # Pula se unidade hora 24h for maior que 9
    CMPi JLER, UH24, 9
    JB CUH242
    JMP TAG6
CDH24: # Zera a unidade e dezena hora 24h
    LEAi UH24, 0
    LEAi DH24, 0
    JMP TAG001
CUH242: # Zera a unidade hora 24h e soma um na dezena hora 24h
    LEAi UH24, 0
    ADDi DH24, DH24, 1
    JMP TAG6
CDH242: # Zera a dezena hora 24h e volta pro PRELOOP
    LEAi DH24, 0
    JMP PRELOOP
24h: # Carregar no display 24h
    LEAi IOSR, 14
    LOAD IOSR, 7AMPM
    LOAD IOSR, 7NADA
    LOAD US, 7US
    LOAD DS, 7DS
    LOAD UM, 7UM
    LOAD DM, 7DM
    LOAD UH24, 7UH
    LOAD DH24, 7DH
    JMP TEMPO
12h: # Carregar no display 12h
    LEAi IOSR, 12
    LOAD IOSR, 7AMPM
    LOAD AMPM, 7NADA
    LOAD US, 7US
    LOAD DS, 7DS
    LOAD UM, 7UM
    LOAD DM, 7DM
    LOAD UH12, 7UH
    LOAD DH12, 7DH
    JMP TEMPO
CONFIGHORA: # Configurar hora
    LOAD UH24, 7UH
    LOAD DH24, 7DH
    LEA KEYs, IOSR
    CMPe JER, IOSR, 1
    JE PROCUH
    JMP PRELOOP
PROCUH: # Somar na unidade hora 12h e 24h
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
    JMP TAG4
CONFIGMIN: # Configurar o minuto
    LEA KEYs, IOSR
    CMPe JER, IOSR, 1
    JE AJUSTAMD
TAGC01: # Ajustar a unidade minuto
    CMPe JER, IOSR, 2
    JE AJUSTAMU
    JMP PRELOOP
AJUSTAMD: # Fazer a soma para ajustar unidade minuto
    ADDi UM, UM, 1
    CMPi JLER, UM, 9
    JB VOLTARCHECKDM
    JMP ENVIAM7SEG
VOLTARCHECKDM: # Carregar 0 na unidade minuto
    LEAi UM, 0
    JMP ENVIAM7SEG
AJUSTAMU: # Somar na dezena minuto e ver se é maior que 5
    ADDi DM, DM, 1
    CMPi JLER, DM, 5
    JB LABELXY
    JMP ENVIAM7SEG
LABELXY: # Zerar a dezena minuto
    LEAi DM, 0
ENVIAM7SEG: # Enviar para o display a unidade e dezena minuto e volta para o PRELOOP
    LOAD UM, 7UM
    LOAD DM, 7DM
    JMP PRELOOP
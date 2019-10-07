SETUP:
    LEAi US, 0
    LEAi DS, 0
    LEAi UM, 9
    LEAi DM, 5
    LEAi UH12, 1
    LEAi DH12, 1
    LEAi UH24, 3
    LEAi DH24, 2
    LEAi AMPM, 14
    LOAD AMPM, 7AMPM
    LOAD AMPM, 7NADA
    JMP COMECA
PRELOOP:
    LEAi IOSR, 1
    LOAD IOSR, BaseTempo
LOOP:
	LEA BaseTempo, IOSR
	CMPe JER, IOSR, 1
	JE COMECA
	JMP LOOP
COMECA:
    LEA SWs, IOSR
    CMPe JER, IOSR, 1
    JE CONFIGHORA
    LEA SWs, IOSR
    CMPe JER, IOSR, 2
    JE CONFIGMIN
    LEA SWs, IOSR
    CMPe JER, IOSR, 4
    JE 12h
    JMP 24h
TEMPO:
    ADDi US, US, 1
    CMPi JLER, US, 9
    JB CDS
TAG1:
    CMPi JLER, DS, 5
    JB CUM
TAG2:
    CMPi JLER, UM, 9
    JB CDM
TAG3:
    CMPi JLER, DM, 5
    JB CUH12
TAG4:
    CMPi JLER, UH12, 2
    JB CDH12
TAG5:
    CMPi JLER, UH24, 3
    JB CUH24
TAG6:
    JMP PRELOOP
CDS:
    LEAi US, 0
    ADDi DS, DS, 1
    JMP TAG1
CUM:
    LEAi DS, 0
    ADDi UM, UM, 1
    JMP TAG2
CDM:
    LEAi UM, 0
    ADDi DM, DM, 1
    JMP TAG3
CUH12:
    LEAi DM, 0
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
    JMP TAG4
CDH12:
    CMPi JLER, DH12, 0
    JB CDH122
TAG01:
    CMPi JLER, UH12, 9
    JB CDH123
    JMP TAG5
CDH122:
    LEAi UH12, 1
    LEAi DH12, 0
    JMP TAG01
CDH123:
    LEAi UH12, 0
    ADDi DH12, DH12, 1
    JMP TAG5
CUH24:
    CMPi JLER, DH24, 1
    JB CDH24
TAG001:
    CMPi JLER, UH24, 9
    JB CUH242
    JMP TAG6
CDH24:
    LEAi UH24, 0
    LEAi DH24, 0
    JMP TAG001
CUH242:
    LEAi UH24, 0
    ADDi DH24, DH24, 1
    JMP TAG6
CDH242:
    LEAi DH24, 0
    JMP PRELOOP
24h:
    LOAD US, 7US
    LOAD DS, 7DS
    LOAD UM, 7UM
    LOAD DM, 7DM
    LOAD UH24, 7UH
    LOAD DH24, 7DH
    JMP TEMPO
12h:
    LOAD US, 7US
    LOAD DS, 7DS
    LOAD UM, 7UM
    LOAD DM, 7DM
    LOAD UH12, 7UH
    LOAD DH12, 7DH
    JMP TEMPO
CONFIGHORA:
    LEA KEYs, IOSR
    CMPe JER, IOSR, 1
    JE PROCUH
TAGA01:
    CMPe JER, IOSR, 2
    JE AJUSTADH2412
    JMP PRELOOP
PROCUH:
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
    CMPi JLER, UH12, 9
    JB AJUSTAH24
TAGA1:
    CMPi JLER, UH24, 9
    JB CHECKUP2UH
    JMP ENVIAM7SEG
AJUSTAH24:
    LEAi UH12, 0
    JMP TAGA1
CHECKUP2UH:
    LEAi UH24, 0
    JMP ENVIAM7SEG
AJUSTADH2412:
    ADDi DH12, DH12, 1
    ADDi DH24, DH24, 1
    CMPi JLER, DH12, 1
    JB AJUSTAD24H
TAGE1:
    CMPi JLER, DH24, 2
    JB AJUSTAHORA24DEZ
    JMP ENVIAM7SEG
AJUSTAD24H:
    LEAi DH12, 0
    JMP TAGE1
AJUSTAHORA24DEZ:
    LEAi DH24, 0
    JMP ENVIAM7SEG
CONFIGMIN:
    LEA KEYs, IOSR
    CMPe JER, IOSR, 1
    JE AJUSTAMD
TAGC01:
    CMPe JER, IOSR, 2
    JE AJUSTAMU
    JMP PRELOOP
AJUSTAMD:
    ADDi UM, UM, 1
    CMPi JLER, UM, 9
    JB VOLTARCHECKDM
    JMP ENVIAM7SEG
VOLTARCHECKDM:
    LEAi UM, 0
    JMP TAGC01
AJUSTAMU:
    ADDi DM, DM, 1
    CMPi JLER, DM, 5
    JB LABELXY
    JMP ENVIAM7SEG
LABELXY:
    LEAi DM, 0
ENVIAM7SEG:
    LOAD US, 7US
    LOAD DS, 7DS
    LOAD UM, 7UM
    LOAD DM, 7DM
    LOAD UH24, 7UH
    LOAD DH24, 7DH
    JMP PRELOOP
SETUP:
    LEAi US, 0
    LEAi DS, 0
    LEAi UM, 0
    LEAi DM, 0
    LEAi UH12, 2
    LEAi DH12, 0
    LEAi UH24, 1
    LEAi DH24, 0
    LEAi AMPM, 0
    JMP COMECA
LOOP:
	LEA BaseTempo, IOSR
	CMPe IOSR, JER, 1
	JE COMECA
	JMP LOOP
COMECA:
    LEA SWs, IOSR
    CMPe IOSR, JER, 1
    JE CONFIGHORA
    LEA SWs, IOSR
    CMPe IOSR, JER, 2
    JE CONFIGMIN
    LEA SWs, IOSR
    CMPe IOSR, JER, 4
    JE 24h
    JMP 12h
TEMPO:
    ADDi US, US, 1
    CMPi US, JLER, 1
    JLE CDS
    LEAi US, 0
    ADDi DS, DS, 1
CDS:
    CMPi DS, JLER, 5
    JLE CUM
    LEAi DS, 0
    ADDi UM, UM, 1
CUM:
    CMPi UM, JLER, 9
    JLE CDM
    LEAi UM, 1
    ADDi DM, DM, 1
CDM:
    CMPi DM, JLER, 5
    JLE CUH12
    LEAi DM, 0
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
CUH12:
    CMPi UH12, JLER, 2
    JLE CUH24
    CMPi DH12, JLER, 0
    JLE CUH12C9
    LEAi UH12, 1
    LEAi DH12, 0
CUH12C9:
    CMPi UH12, JLER, 9
    JLE CUH24
    LEAi UH12, 0
    ADDi DH12, DH12, 1
CUH24:
    CMPi UH24, JLER, 3
    JLE CDH24
    CMPi DH24, JLER, 1
    JLE UH24C9
    LEAi UH24, 1
    ADDi DH24, DH24, 1
UH24C9:
    CMPi UH24, JLER, 9
    JLE CDH24
    LEAi UH24, 0
    ADDi DH24, DH24, 1
CDH24:
    CMPi DH24, JLER, 2
    JLE LOOP
    LEAi DH24, 0
    JLE LOOP
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
    CMPe IOSR, JER, 1
    JE PROCUH
    JMP CHECKUP2UH
PROCUH:
    ADDi UH12, UH12, 1
    ADDi UH24, UH24, 1
    CMPi UH12, JLER, 9
    JLE AJUSTAH24
    LEAi UH12, 0
AJUSTAH24:
    CMPi UH24, JLER, 9
    JLE CHECKUP2UH
    LEAi UH24, 0
CHECKUP2UH:
    LEA KEYs, IOSR
    CMPe IOSR, JER, 2
    JE AJUSTADH2412
    JMP LOOP
AJUSTADH2412:
    ADDi DH12, DH12, 1
    ADDi DH24, DH24, 1
    CMPi DH12, JLER, 1
    JLE AJUSTAD24H
    LEAi DH12, 0
AJUSTAD24H:
    CMPi DH24, JLER, 2
    JLE ENVIAUP7SEG
    LEAi DH24, 0
ENVIAUP7SEG:
    LEA SWs, IOSR
    CMPe IOSR, JER, 4
    JE ENVIA24H7SEG
    LOAD UH12, 7UH
    LOAD DH12, 7DH
    JMP LOOP
ENVIA24H7SEG:
    LOAD UH24, 7UH
    LOAD DH24, 7DH
    JMP LOOP
CONFIGMIN:
    LEA KEYs, IOSR
    CMPe IOSR, JER, 1
    JE AJUSTAMD
VOLTARCHECKDM:
    LEA KEYs, IOSR
    CMPe IOSR, JER, 2
    JE AJUSTAMU
    JMP LOOP
AJUSTAMD:
    ADDi UM, UM, 1
    CMPi UM, JLER, 9
    JLE VOLTARCHECKDM
    LEAi UM, 0
    JMP VOLTARCHECKDM
AJUSTAMU:
    ADDi DM, DM, 1
    CMPi DM, JLER, 5
    JLE ENVIAM7SEG
    LEAi DM, 0
    JMP ENVIAM7SEG
ENVIAM7SEG:
    LOAD UM, 7UM
    LOAD DM, 7DM
    JMP LOOP
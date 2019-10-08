# Relógio na FPGA

- André Ejzenmesser, Gabriel Monteiro, Vitor Satyro

* [Introdução](#introdução)
  * [Top-Level VHDL](https://github.com/decoejz/relogio_FPGA/blob/master/relogio.vhd)
  * [Vídeo demonstração do projeto](https://www.youtube.com/watch?v=CAV-8p0IIgc&feature=youtu.be)
* [Processador](#processador)
* [I/O](#io)
  * [Mapa de memória](#mapa-de-memória)
* [Modos de endereçamento](#modos-de-endereçamento)
* [Instruções Assembly](#instruções-assembly)
* [Dicionário de endereços e registradores](#dicionário-de-endereços-e-registradores)
* [Assembler](#assembler)
* [Guia de Uso](#guia-de-uso)
   * [Utilizando Assembler](#utilizando-assembler)
   * [Programando relógio na placa](#programando-relógio-na-placa)
   * [Utilizando o Relógio](#utilizando-o-relógio)


## Introdução

O objetivo desse projeto é a criação de um relógio digital em VHDL. As funcionalidades que este relógio possui são:
 - display de horas e minutos(formato 12h e 24h)
 - sistema para acerto de horário
 - sistema de seleção de base de tempo para passar o tempo mais rápido(importante para testes)

Esse projeto foi construído a partir do design de um processador e a ligação dele com os periféricos(I/O). A implementação relógio foi feita em uma placa FPGA Cyclone IV EP4CE115F29C7.

[Top-Level VHDL](https://github.com/decoejz/relogio_FPGA/blob/master/relogio.vhd)

[Vídeo demonstração do projeto](https://www.youtube.com/watch?v=CAV-8p0IIgc&feature=youtu.be)
 
## Processador

A arquitetura do processador é uma arquitetura registrador-registrador. A ROM externa ao processador fornecerá para ele as instruções necessárias para poder fazer o que deve fazer. Nela haverá um banco de registradores, com um total de 32 registradores, uma ULA que será capaz de fazer operações de soma e subtração, uma unidade de controle para poder ativar os pontos de controle referentes a diversos MUX internos, funções da ULA e ativar escrita no banco de registradores. Por fim, ela contará com um program counter, que somará um a cada instrução que passa ou fará com que vá diretamente para alguma linha de comando da ROM. Haverão 5 bits de endereços que serão enviados diretamente da ROM para o decoder. Haverão também dados de saída e de entrada no processador. Todos esses dados serão enviados e pelo banco de registradores e chegarão nele também.


![alt text](https://github.com/decoejz/relogio_FPGA/blob/master/imagens/processador.png)

## IO

Os perífecos do relógio são:

- 6 displays de 7 segmentos (HH:MM AM/PM)
- 3 switches (seleciona base de tempo, ativa editor de horas, ativa editor de minutos)
- 2 botões (edita decimal, edita unidade)
- Base de tempo (converte o clock da placa na base de tempo escolhida)

![alt text](https://github.com/decoejz/relogio_FPGA/blob/master/imagens/io.png)

### Mapa de memória

![alt text](https://github.com/decoejz/relogio_FPGA/blob/master/imagens/mapamemoria.png)

## Modos de endereçamento 

- Tamanho da instrução: 25 bits
- Total de registradores no banco de registradores: 32
- Total de instruções disponíveis: 32

![alt text](https://github.com/decoejz/relogio_FPGA/blob/master/imagens/enderacamento.png)

## Instruções Assembly

- ADD R1, R2, R3 : R1 = R2 + R3
- ADDi R1, R2 Imediato : R1 = R2 + Imediato
- LOAD R1, End : Move o que está em R1 para o Endereço
- JMP Imediato : Pula para a linha da ROM referente ao Imediato
- CMPi R1, R2, Imediato : Compara se o valor de R2 > Imediato e salva em R1
- LEA End, R1 : Le as informações do Endereço e salva em R1
- JB Imediato : Pula para o Imediato baseado na flag indicando se o valor é maior
- LEAi R1, Imediato : Salva o valor imediato no registrador R1
- JE Imediato : Pula para o Imediato baseado na flag indicando se o valor é igual
- JL Imediato : Pula para o Imediato baseado na flag indicando se o valor é menor
- CMPe R1, R2, Imediato : Salva em R1 se R2 = Imediato
- CMPle R1, R2, Imediato : Salva em R1 se R2 < Imediato

[Código Assembly completo](https://github.com/decoejz/relogio_FPGA/blob/master/assembly/assembly.asm)

## Dicionário de endereços e registradores


 | Registradores:    |   Endereços:        |
 | ----------------- | ------------------- |
 | 00 - US           |   00 - 7NADA.       |
 | 01 - DS           |   01 - 7AMPM.       |
 | 02 - UM           |   02 - 7US          |
 | 03 - DM           |   03 - 7DS          |
 | 04 - UH12         |   04 - 7UM          |
 | 05 - DH12         |   05 - 7DM          |
 | 06 - UH24         |   06 - 7UH          |
 | 07 - DH24         |   07 - 7DH          |
 | 08 - AMPM         |   08 - SWs (SWH,SWM,SW2412)        |
 | 09 - JLER         |   09 - KEYs (KEYU,KEYD)         |
 | 0A - IOSR         |   0A - BaseTempo    |
 | 0B - JER          |   0B:FF - Reservado |
 | 0C - JBER         |                     |

## Assembler

Esse projeto também conta com um assembler em python que converte o código assembly de um arquivo .asm para linguagem de máquina de um arquivo .mif que pode ser carregado diretamente na placa FPGA. Esse assembler foi adaptado de um assembler para um processador MIPS feito pelo professor Eduardo Marossi.

[ASSEMBLER](https://github.com/decoejz/relogio_FPGA/blob/master/python/assembler.py)

[Código de máquina gerado](https://github.com/decoejz/relogio_FPGA/blob/master/mif/initROM.mif)

## Guia de uso

### Utilizando Assembler

1. Para utilizar o assembler com seu próprio código é necessário criar um arquivo .asm nos padrões das instruções e endereços listados nesse projeto

2. Para transformar o seu código assembly em código de máquina, rode o seguinte comando no terminal:
```
python3 assembler.py seu_arquivo_assembly.asm -mif > initROM.mif
```
3. O arquivo [initROM.mif](https://github.com/decoejz/relogio_FPGA/blob/master/initROM.mif) deste repositório é o responsável por fazer o relógio funcionar, se seu objeto é apenas reproduzir o projeto **NÃO** altere ele.

### Programando relógio na placa

1. No Windows ou no Linux abra o projeto com o arquivo [relogio.qpf](https://github.com/decoejz/relogio_FPGA/blob/master/relogio.qpf)

2. Compile o projeto em `Compile all` ou `Ctrl-L`

3. Conecte a FPGA no computador e na abra `programmer` configure-a em `Hardware Setup`

4. Clique em `Run` e o relógio estará pronto para uso!

### Utilizando o relógio

- Os displays de 7 segmentos estarão na seguinte ordem HH:MM:SS na base de tempo de 1 segundo.

- Para alterar a base de tempo, basta ativar a chave 17 (SW17) para ter uma base de 0.00001 segundo.

- Para utilizar o modo 12horas, basta ativar a chave 2 (SW2). Note que agora ao lado dos segundos aparace um A(AM) ou P(PM).

- Para ajustar as horas, ative a chave 1 (SW1) e utilize o botão 0 (KEY0) para ajustar a hora.

- Para ajustar os minutos, ative a chave 0 (SW1) e utilize o botão 0 (KEY0) para unidade e o botão 1 (KEY1) para dezena.

__Dicas:__ 
 - Para ajustar a hora pressione o botão por um período até que a mudança seja reproduzida no display de 7 segmentos. 
 - **NÃO** é possível ajustar horas e minutos ao mesmo tempo, ou seja, não ativar as chaves 0 e 1 juntas.

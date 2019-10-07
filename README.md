
# FALTA FAZER

- referenciar assembly

- listar comandos e explicar endereçamentos

- colocar imagens


# Relogio na FPGA

- André Ejzenmesser, Gabriel Monteiro, Vitor Satyro

## Introdução

O objetivo desse projeto é a criação de um relógio digital em VHDL. As funcionalidades que este relógio possui são:
 - display de horas e minutos(formato 12h e 24h)
 - sistema para acerto de horário
 - sistema de seleção de base de tempo para passar o tempo mais rápido(importante para testes)

Esse projeto foi construído a partir do design de um processador e a ligação dele com os periféricos(I/O). A implementação relógio foi feita em uma placa FPGA Cyclone IV EP4CE115F29C7.
 
## Processador

A arquitetura do processador é uma arquitetura registrador-registrador. A ROM externa ao processador fornecerá para ele as instruções necessárias para poder fazer o que deve fazer. Nela haverá um banco de registradores, com um total de 32 registradores, uma ULA que será capaz de fazer operações de soma e subtração, uma unidade de controle para poder ativar os pontos de controle referentes a diversos MUX internos, funções da ULA e ativar escrita no banco de registradores. Por fim, ela contará com um program counter, que somará um a cada instrução que passa ou fará com que vá diretamente para alguma linha de comando da ROM. Haverão 5 bits de endereços que serão enviados diretamente da ROM para o decoder. Haverão também dados de saída e de entrada no processador. Todos esses dados serão enviados e pelo banco de registradores e chegarão nele também.


*IMAGEM PROCESSADOR*


## Modos de endereçamento 

*IMAGEM ENDEREÇAMENTO*

- Tamanho da instrução: 25 bits
- Total de registradores no banco de registradores: 32
- Total de instruções disponíveis: 32

## I/O

Os perífecos do relógio são:

- 6 displays de 7 segmentos (HH:MM AM/PM)
- 3 switches (seleciona base de tempo, ativa editor de horas, ativa editor de minutos)
- 2 botões (edita decimal, edita unidade)
- Base de tempo (converte o clock da placa na base de tempo escolhida)

*IMAGEM I/O*

*MAPA DE MEMORIA*

## Assembler

Esse projeto também conta com um assembler em python que converte o código assembly de um arquivo .asm para linguagem de máquina de um arquivo .mif que pode ser carregado diretamente na placa FPGA. Esse assembler foi adaptado de um assembler para um processador MIPS feito pelo professor Eduardo Marossi.

[ASSEMBLER](https://github.com/decoejz/relogio_FPGA/blob/master/python/assembler.py)





  

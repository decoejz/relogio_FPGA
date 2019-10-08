library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_memoryROM is

    generic
    (
        dataWidth : natural := 8; -- Quantidade de bits que uma instrucao tem
        addrWidth : natural := 8 -- Tamanho da instrucao
    );

    port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0); -- Qual linha deve ser lida
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0) -- Conteudo da linha enviado para o processador
    );
end entity;

architecture initFileROM of my_memoryROM is

type memory_t is array (2**addrWidth -1 downto 0) of std_logic_vector (dataWidth-1 downto 0);
signal content: memory_t;
attribute ram_init_file : string;
attribute ram_init_file of content:
signal is "initROM.mif"; -- Leitura do arquivo initROM.mif com o codigo de maquina

begin
   Dado <= content(to_integer(unsigned(Endereco))); -- Dado enviado para a ROM
end architecture;

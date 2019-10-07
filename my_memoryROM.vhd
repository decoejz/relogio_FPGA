library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_memoryROM is

    generic
    (
        dataWidth : natural := 8;
        addrWidth : natural := 8
    );

    port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture initFileROM of my_memoryROM is

type memory_t is array (2**addrWidth -1 downto 0) of std_logic_vector (dataWidth-1 downto 0);
signal content: memory_t;
attribute ram_init_file : string;
attribute ram_init_file of content:
signal is "initROM.mif";

begin
   Dado <= content(to_integer(unsigned(Endereco)));
end architecture;

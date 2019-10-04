library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_memoryROM IS
    generic (
        dataWidth: natural := 8;
        addrWidth: natural := 10
    );
    port (
        Endereco : IN STD_LOGIC_VECTOR (addrWidth-1 DOWNTO 0);
        Dado : OUT STD_LOGIC_VECTOR (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture sincrona OF my_memoryROM IS

	type memory_t is array (2**addrWidth -1 downto 0) of std_logic_vector (dataWidth-1 downto 0);
	signal content: memory_t;
	attribute ram_init_file : string;
	attribute ram_init_file of content : signal is "initROM.mif";

begin
    Dado <= content(to_integer(unsigned(Endereco)));
end architecture;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_decoder is
    Generic(
		ADD_SIZE: natural := 8
	 );
	 port
    (
       add_in : in std_logic_vector(ADD_SIZE-1 downto 0); -- Endereco de entrada
		 readEnable : in std_logic; -- Ativa o read
		 writeEnable : in std_logic; -- Ativa o write
		 
		 eseg70, eseg71, eseg72, eseg73, eseg74, eseg75, eseg76, eseg77 : out std_logic; -- Habilita cada um dos 7seg
		 esw : out std_logic; -- Habilita os switches
		 ekey : out std_logic; -- Habilita as keys
		 ebt : out std_logic -- Habilita a base de tempo
		 
    );
end entity;

architecture decoderArc of my_decoder is


begin

		eseg70 <= '1' when (add_in = "00000000" AND writeEnable = '1') else '0';
		eseg71 <= '1' when (add_in = "00000001" AND writeEnable = '1') else '0';
		eseg72 <= '1' when (add_in = "00000010" AND writeEnable = '1') else '0';
		eseg73 <= '1' when (add_in = "00000011" AND writeEnable = '1') else '0';
		eseg74 <= '1' when (add_in = "00000100" AND writeEnable = '1') else '0';
		eseg75 <= '1' when (add_in = "00000101" AND writeEnable = '1') else '0';
		eseg76 <= '1' when (add_in = "00000110" AND writeEnable = '1') else '0';
		eseg77 <= '1' when (add_in = "00000111" AND writeEnable = '1') else '0';
		esw <= '1' when (add_in = "00001000" AND readEnable = '1') else '0';
		ekey <= '1' when (add_in = "00001001" AND readEnable = '1') else '0';
		ebt <= '1' when (add_in = "00001010" AND readEnable = '1') else '0';
			
end architecture;
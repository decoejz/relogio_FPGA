library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_decoder is
    Generic(
		ADD_SIZE: natural := 10
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

		eseg70 <= '1' when (add_in = "0000000000" AND writeEnable = '1') else '0'; -- Habilia escrita no display 0
		eseg71 <= '1' when (add_in = "0000000001" AND writeEnable = '1') else '0'; -- Habilia escrita no display 1
		eseg72 <= '1' when (add_in = "0000000010" AND writeEnable = '1') else '0'; -- Habilia escrita no display 2
		eseg73 <= '1' when (add_in = "0000000011" AND writeEnable = '1') else '0'; -- Habilia escrita no display 3
		eseg74 <= '1' when (add_in = "0000000100" AND writeEnable = '1') else '0'; -- Habilia escrita no display 4
		eseg75 <= '1' when (add_in = "0000000101" AND writeEnable = '1') else '0'; -- Habilia escrita no display 5
		eseg76 <= '1' when (add_in = "0000000110" AND writeEnable = '1') else '0'; -- Habilia escrita no display 6
		eseg77 <= '1' when (add_in = "0000000111" AND writeEnable = '1') else '0'; -- Habilia escrita no display 7
		esw <= '1' when (add_in = "0000001000" AND readEnable = '1') else '0';  -- Habilia leitura das chaves 
		ekey <= '1' when (add_in = "0000001001" AND readEnable = '1') else '0';  -- Habilia leitura dos botoes 
		ebt <= '1' when ((add_in = "0000001010" AND readEnable = '1' AND writeEnable='0') OR -- Habilia leitura da base de tempo 
						(add_in = "0000001010" AND readEnable = '0' AND writeEnable='1')) else '0'; -- Habilia escrita na base de tempo 

end architecture;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_somador is
   Generic ( DATA_WIDTH : natural := 8 );
	
	port
	(
		A : in std_logic_vector (DATA_WIDTH-1 downto 0);
		B : in std_logic_vector (DATA_WIDTH-1 downto 0);
		
		Y : out std_logic_vector (DATA_WIDTH-1 downto 0)
    );
end entity;

architecture somadorArc of my_somador is


begin

	Y <= std_logic_vector(unsigned(A) + unsigned(B));
	
end architecture;
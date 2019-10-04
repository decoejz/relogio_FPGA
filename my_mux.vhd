
library IEEE;
use ieee.std_logic_1164.all;

entity my_mux is

	Generic ( DATA_WIDTH : natural := 8 );
	
	-- O mux recebe as entradas A, B e o seletor.
	-- A resposta é dada por Y.
   port
    (
       A : in std_logic_vector(DATA_WIDTH-1 downto 0);
		 B : in std_logic_vector(DATA_WIDTH-1 downto 0);
		 
		 sel : in std_logic;
		 
		 Y : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity;

architecture muxArc of my_mux is


begin
    
	 Y <= A when sel='0' else
			B;
	 
end architecture;
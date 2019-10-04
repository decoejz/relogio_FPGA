
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity my_somador is
   Generic ( 
		DATA_WIDTH : natural := 8;
		increment : natural := 1
	);
	
	port
	(
		A : in std_logic_vector (DATA_WIDTH-1 downto 0);
		clk : in std_logic;
		
		Y : out std_logic_vector (DATA_WIDTH-1 downto 0)
    );
end entity;

architecture somadorArc of my_somador is


begin

			-- Soma A + 1 e o resultado é armazenado em Y.
			-- Transforma os std_logic_vector em inteiros positivos e soma.
			-- Transforma de volta a resposta para std_logic_vector
			Y <= std_logic_vector(unsigned(A) + increment);

	
end architecture;
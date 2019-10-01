
library IEEE;
use ieee.std_logic_1164.all;

entity my_flip_flop is
    port
    (
       A, Clock : in std_logic;
		 B			 : out std_logic
    );
end entity;


architecture flip_flopArc of my_flip_flop is
begin
	
	process(A, Clock)
	begin
	
		if (rising_edge(Clock)) then 
			B <= A;
		end if;
		
	end process;
	
end architecture;
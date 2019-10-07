-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Import all the declarations in a package
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity my_registrador is	
	port
	(
		entrada : in std_logic;
		clk : in std_logic;
		
		saida : out std_logic
	);
end my_registrador;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture regArch of my_registrador is

	
begin
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			saida <= entrada;
		end if;
		
	end process;
	
end regArch;




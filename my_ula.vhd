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




entity my_ula is
	port
	(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		func : in std_logic_vector (3 downto 0);
		
		Y : out std_logic_vector (3 downto 0);
		Z : out std_logic
	);
end my_ula;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture ulaArch of my_ula is

	
begin

	process(A,B,func)
	begin
		-- Add if "add_sub" is 1, else subtract
		if (func = "0000") then
			Y <= std_logic_vector(unsigned(A) + unsigned(B));
		elsif (func = "0001") then
			if (A > B) then
				Z <= '1';
			else 
				Z <= '0';
			end if;
		
		end if;
	end process;

	
end ulaArch;




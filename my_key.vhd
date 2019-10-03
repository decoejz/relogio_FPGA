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




entity my_key is
	Generic ( 
		TOTAL_KEY : natural := 2;
		DATA_SIZE : natural := 8
	);
	
	port
	(
		key_in : in std_logic_vector(TOTAL_KEY-1 downto 0);
		enable : in std_logic;
		
		key_out : out std_logic_vector(DATA_SIZE-1 downto 0)
	);
end my_key;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture keyArch of my_key is

	signal sig_key : std_logic_vector(DATA_SIZE-1 downto 0);
	
begin
	
	sig_key <= ((others=>'0') OR key_in);
	
	key_out <= sig_key when (enable = '1') else (others=>'Z');
	
end keyArch;




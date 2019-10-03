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




entity my_sw is
	Generic ( 
		TOTAL_SW : natural := 3;
		DATA_SIZE : natural := 8
	);
	
	port
	(
		sw_in : in std_logic_vector(TOTAL_SW-1 downto 0);
		enable : in std_logic;
		
		sw_out : out std_logic_vector(DATA_SIZE-1 downto 0)
	);
end my_sw;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture swArch of my_sw is

	signal sig_sw : std_logic_vector(DATA_SIZE-1 downto 0);
	
begin
	
	sig_sw <= ((others=>'0') OR sw_in);
	
	sw_out <= sig_sw when (enable = '1') else (others=>'Z');
	
end swArch;




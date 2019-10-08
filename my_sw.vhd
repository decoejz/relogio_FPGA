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
		TOTAL_SW : natural := 3; --Numero total de chaves que serao utilizadas
		DATA_SIZE : natural := 8 --Tamanho dos dados que devem ser enviados para o processador
	);
	
	port
	(
		sw_in : in std_logic_vector(TOTAL_SW-1 downto 0); -- Entrada das chaves que serao utilizados
		enable : in std_logic; -- Habilita leitura das chaves
		
		indicaLed : out std_logic_vector(TOTAL_SW-1 downto 0); -- Led que indica a chave que esta ligada
		sw_out : out std_logic_vector(DATA_SIZE-1 downto 0) -- Informacao lida que e enviada para o processador
	);
end my_sw;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture swArch of my_sw is

	signal sig_sw : std_logic_vector(DATA_SIZE-1 downto 0);
	
begin
	
	sig_sw <= ( std_logic_vector(to_unsigned(0, sw_out'length - sw_in'length)) & sw_in); -- Transforma a leitura num vetor de data size
	
	sw_out <= sig_sw when (enable = '1') else (others=>'Z'); -- Envia informacao para o processador
	indicaLed <= sw_in; -- Acende os leds
	
end swArch;




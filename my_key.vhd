library ieee;

-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Import all the declarations in a package
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_key is
	Generic ( 
		TOTAL_KEY : natural := 2; -- Numero total de botoes que serao utilizadas
		DATA_SIZE : natural := 8 -- Tamanho dos dados que devem ser enviados para o processador
	);
	
	port
	(
		key_in : in std_logic_vector(TOTAL_KEY-1 downto 0); -- Entrada dos botoes que serao utilizados
		enable : in std_logic; -- Habilita leitura dos botoes
		
		led_in : out std_logic_vector(TOTAL_KEY-1 downto 0); -- Led que indica o botao que esta sendo apertado
		key_out : out std_logic_vector(DATA_SIZE-1 downto 0) -- Informacao lida que e enviada para o processador
	);
end my_key;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture keyArch of my_key is

	signal sig_key : std_logic_vector(DATA_SIZE-1 downto 0);
	
begin
	
	sig_key <= ( std_logic_vector(to_unsigned(0, key_out'length - key_in'length)) & not(key_in)); -- Transforma a leitura num vetor de data size
	
	key_out <= sig_key when (enable = '1') else (others=>'Z'); -- Envia informacao para o processador
	led_in <= not(key_in); -- Acende os leds
	
	
end keyArch;



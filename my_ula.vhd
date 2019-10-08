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
	Generic ( DATA_WIDTH : natural := 8 );
	
	port
	(
		-- Entradas
		A : in std_logic_vector (DATA_WIDTH-1 downto 0);
		B : in std_logic_vector (DATA_WIDTH-1 downto 0);
		
		-- Diz qual funcao sera executada.
		func : in std_logic_vector (2 downto 0);
		
		-- Saida quando tem soma ou subtracao
		Y : out std_logic_vector (DATA_WIDTH-1 downto 0);
		
		-- Flags que indicam comparacoes
		bigger_than : out std_logic;
		iqual_to : out std_logic;
		smaller_than : out std_logic
	);
end my_ula;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture ulaArch of my_ula is
	signal maior_que, igual_que, menor_que : std_logic;

	--Soma A + B
	constant SOMA : std_logic_vector(2 downto 0) := "000";
	
	--Compara se A>B
	constant COMPB : std_logic_vector(2 downto 0) := "001";
	
	--SUBTRAI A - B
	constant SUBTRAI : std_logic_vector(2 downto 0) := "010";
	
	--Retorna o valor de A sem alterar ele
	constant RETA : std_logic_vector(2 downto 0) := "011";
	
	--Compara se A = B
	constant COMPE : std_logic_vector(2 downto 0) := "100";
	
	--Compara se A < B
	constant COMPS : std_logic_vector(2 downto 0) := "101";
	
	--Nao faz nada
	constant NADA : std_logic_vector(2 downto 0) := "111";
begin

	--Faz as comparacoes e salva nos signals
	maior_que <= '1' when (A<B) else '0'; -- Compara se A < B
	igual_que <= '1' when (A=B) else '0'; -- Compara se um botao esta ativado ou nao
	menor_que <= '1' when (A>B) else '0'; -- Compara se A > B
	
	--Salva a saida da ULA
	SAIDA : with func select
	Y <= std_logic_vector(unsigned(A) + unsigned(B)) when SOMA,
		  std_logic_vector(unsigned(A) - unsigned(b)) when SUBTRAI,
		  A when RETA,
		  (std_logic_vector(to_unsigned(0, DATA_WIDTH - 1)) & maior_que) when COMPB,
		  (std_logic_vector(to_unsigned(0, DATA_WIDTH - 1)) & igual_que) when COMPE,
		  (std_logic_vector(to_unsigned(0, DATA_WIDTH - 1)) & menor_que) when COMPS,
		  (std_logic_vector(to_unsigned(0, DATA_WIDTH))) when others;
	
	--Salva a flag maior que
	MAIOR_QUE_select : with func select
	bigger_than <= maior_que when COMPB,
						'0' when others;
	
	--Salva a flag igual que
	IGUAL_QUE_select : with func select
	iqual_to <= igual_que when COMPE,
					'0' when others;
	
	--Salva a flag menor que
	MENOR_QUE_select : with func select
	smaller_than <= menor_que when COMPS,
						 '0' when others;
	
end ulaArch;




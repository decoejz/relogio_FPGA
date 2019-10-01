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
		
		-- Flag que indica se um numero e maior que outro
		bigger_than : out std_logic;
		iqual_to : out std_logic;
		smaller_than : out std_logic
	);
end my_ula;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture ulaArch of my_ula is

	
begin

	-- Funcoes da ULA
	process(A,B,func)
	begin
		-- Soma A + B e o resultado é armazenado em Y.
		if (func = "000") then
			-- Transforma os std_logic_vector em inteiros positivos e soma.
			-- Transforma de volta a resposta para std_logic_vector
			Y <= std_logic_vector(unsigned(A) + unsigned(B));
		
		-- Compara se A > B
		-- Retorna uma flag:
		-- 1 caso seja maior,
		-- 0 caso seja menor.
		elsif (func = "001") then
			if (A > B) then
				bigger_than <= '1';
			else 
				bigger_than <= '0';
			end if;
			
		-- Subtrai A - B e o resultado é armazenado em Y.
		elsif (func = "010") then
			-- Transforma os std_logic_vector em inteiros positivos e subtrai.
			-- Transforma de volta a resposta para std_logic_vector
			Y <= std_logic_vector(unsigned(A) - unsigned(b));
			
		-- Retorna o valor de A, sem fazer nenhum tipo de operacao
		elsif (func = "011") then
			Y <= B;
		
		-- Compara se A = B
		-- Retorna uma flag:
		-- 1 caso seja igual,
		-- 0 caso seja diferente.
		elsif (func = "100") then
			if (A = B) then
				iqual_to <= '1';
			else 
				iqual_to <= '0';
			end if;
			
		-- Compara se A < B
		-- Retorna uma flag:
		-- 1 caso seja menor,
		-- 0 caso seja maior.
		elsif (func = "101") then
			if (A < B) then
				smaller_than <= '1';
			else 
				smaller_than <= '0';
			end if;
		
		end if;
	end process;

	
end ulaArch;




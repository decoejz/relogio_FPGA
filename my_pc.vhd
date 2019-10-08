library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity my_pc is
	generic (DATA_PC_SIZE : natural := 10 --Quantidade de instrucoes que podem ter na ROM
	);
    
	 port
    (
		clk: in std_logic; -- Entrada do clock
		imediate: in std_logic_vector(DATA_PC_SIZE-1 downto 0); -- Valor do imediato, necessario caso instrucao seja algum jump
		uc_enable: in std_logic; -- Enviado para o MUX que decide se vai ser a proxima linha da ROM ou o valor do imediato caso seja algum jump

		instr: out std_logic_vector(DATA_PC_SIZE-1 downto 0) -- Qual a proxima linha que sera lida
    );
end entity;

architecture pcArc of my_pc is

  signal sig_out_mux, sig_somador : std_logic_vector(DATA_PC_SIZE-1 downto 0);
  signal sig_in_soma : std_logic_vector(DATA_PC_SIZE-1 downto 0) := (others=>'0');

begin

	sig_in_soma <= instr;

	-- Port Map que soma 1 na instrucao, indicando qual a proxima linha
	SOMADOR: entity work.my_somador
		Generic Map(DATA_WIDTH=>DATA_PC_SIZE)
		Port Map(A=>sig_in_soma,clk=>clk,Y=>sig_somador);

	-- MUX que define qual instrucao deve ser enviada (Soma ou Jump).
  	MUX: entity work.my_mux
		Generic Map(DATA_WIDTH=> DATA_PC_SIZE)
		Port Map(A=>sig_somador,B=>imediate,sel=>uc_enable,Y=>sig_out_mux);

	process(clk) -- Cria um registrador, salvando qual a proxima instrucao que sera feita
	begin
		if (rising_edge(clk)) then
			instr <= sig_out_mux;
		end if;
	end process;
	  
end architecture;

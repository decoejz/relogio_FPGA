
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity my_pc is
    generic (DATA_PC_SIZE : natural := 10);
    
	 port
    (
		clk: in std_logic;
      imediate: in std_logic_vector(DATA_PC_SIZE-1 downto 0);
      uc_enable: in std_logic;
		
      instr: out std_logic_vector(DATA_PC_SIZE-1 downto 0)
    );
end entity;

architecture pcArc of my_pc is

  signal sig_out_mux, sig_somador : std_logic_vector(DATA_PC_SIZE-1 downto 0);
  signal sig_in_soma : std_logic_vector(DATA_PC_SIZE-1 downto 0) := (others=>'0');

begin

	SOMADOR: entity work.my_somador
	  Generic Map(DATA_WIDTH=>DATA_PC_SIZE)
	  Port Map(A=>sig_in_soma,clk=>clk,Y=>sig_somador);

  MUX: entity work.my_mux
	  Generic Map(DATA_WIDTH=> DATA_PC_SIZE)
	  Port Map(A=>sig_somador,B=>imediate,sel=>uc_enable,Y=>sig_out_mux);

	process(clk)
	  begin
		 if (rising_edge(clk)) then
			  
			  instr <= sig_out_mux;
			  sig_in_soma <= sig_out_mux;
			
		 end if;
	  end process;


end architecture;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Utilizado para o Generic

entity my_pc is
    generic (instr_length : natural := 8);
    
	 port
    (
		pcIn: in std_logic_vector(instr_length downto 0);
      clk: in std_logic;
      imediate: in std_logic_vector(instr_length downto 0);
      uc_enable: in std_logic;
		
      instr: out std_logic_vector(instr_length downto 0)
    );
end entity;

architecture pcArc of my_pc is

  signal sig_somador : std_logic_vector(instr_length downto 0);

begin

	process(clk)
	  begin
		 if (rising_edge(clk)) then
			  
			  SOMADOR: entity work.my_somador
				  Generic Map(DATA_WIDTH=>instr_length)
				  Port Map(A=>pcIn,clk=>clk,Y=>sig_somador);
		 
			  MUX: entity work.my_mux
				  Generic Map(DATA_WIDTH=> instr_length)
				  Port Map(A=>sig_somador,B=>imediate,sel=>uc_enable,Y=>instr);
			
		 end if;
	  end process;


end architecture;


library IEEE;
use ieee.std_logic_1164.all;

entity my_pc is
    generic (instr_length: natural);
    port
    (
      clock: in std_logic;
      imediate: in std_logic_vector(instr_length downto 0);
      uc_enable: in std_logic;
      instr: out std_logic_vector(instr_length downto 0)
    );
end entity;

architecture pcArc of my_pc is
  signal sig_somador,sig_pc_in,sig_pc_out;

  MUX: entity work.my_mux
  generic map(DATA_WIDTH=> instr_length);
  Port Map(
      A=>sig_somador,B=>imediate,sel=>uc_enable,Y=>sig_pc_in);

  SOMADOR : entity work.my_somador
  generic map(DATA_WIDTH=>instr_length);
  Port Map(
      A=>sig_pc_out,clock=>clock,Y=>sig_somador);


begin

process(clock)
  begin
    if rising_edge(clock):
      intr <= sig_pc_out;
    end if;
  end process;


end architecture;

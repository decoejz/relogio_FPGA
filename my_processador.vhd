	
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_processador is
	Generic ( DATA_WIDTH : natural := 8 );
	
	port
		(
			-- Entradas do processador
			data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
			ROM_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
			
			clk : in std_logic;
			
			ROM_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
			data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
			addr : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
end entity;

architecture processadorArc of my_processador is

	signal sig_mux_pc, sig_mux_reg_ula, sig_mux_reg_sai, sig_we, sig_bigger_than : std_logic;
	signal sig_func_ula : std_logic_vector(1 downto 0);
	signal sig_pc : std_logic_vector(XX downto 0);
	signal sig_data_a_br, sig_data_b_br, sig_saida_mux_reg_ula, sig_saida_mux_ula_in, sig_saida_ula : std_logic_vector(DATA_WIDTH-1 downto 0);

begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			
			UC: entity work.my_uc
				Port Map(
					opcode => ROM_in(24 downto 20),
					muxPc => sig_mux_pc,
					muxRegUla => sig_mux_reg_ula,
					funcUla => sig_func_ula,
					muxRegSai => sig_mux_reg_sai,
					weBC => sig_we);
					
			PC: entity work.my_pc
				Port Map(
					pcIn => sig_pc,
					clk => clk,
					imediate => ROM_in(XX downto XX),
					uc_enable => sig_we,					
					instr => sig_pc);
					
			MUX_REG_ULA: entity work.my_mux
				Port Map(
					A => ROM_in(XX downto XX),
					B => sig_data_b_br,
					sel => sig_mux_reg_ula,
					Y => sig_saida_mux_reg_ula);
					
			BR: entity work.my_banco_reg
				Port Map(
					clk => clk,
					enderecoA => ROM_in(19 downto 15),
					enderecoB => ROM_in(14 downto 10),
					enderecoEscrita => ROM_in(9 downto 5),
					dadosEscrita => sig_saida_mux_ula_in,
					we => sig_we,
					saidaA => sig_data_a_br,
					saidaB => sig_data_b_br);
					
			MUX_ULA_IN: entity work.my_mux
				Port Map(
					A => data_in,
					B => sig_saida_ula,
					sel => sig_mux_reg_sai,
					Y => sig_saida_mux_ula_in);
					
			ULA: entity work.my_ula
				Port Map(
					A => sig_data_a_br,
					B => sig_saida_mux_reg_ula,
					func => sig_func_ula,
					Y => sig_saida_ula,
					bigger_than => sig_bigger_than);
					
			ROM_out <= sig_pc;
			data_out <= sig_saida_ula;
			addr <= ROM_in(4 downto 0);
			
		end if;
	end process;
    
end architecture;
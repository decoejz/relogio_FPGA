	
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_processador is
	Generic ( DATA_WIDTH : natural := 8;
				 ADD_SIZE: natural := 5;
				 ADD_OUT_SIZE: natural := 8;
				 DATA_PC_SIZE : natural := 10);
	
	port
		(
			-- Entradas do processador
			data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
			ROM_in : in std_logic_vector(24 downto 0);
			
			clk : in std_logic;
			
			ROM_out : out std_logic_vector(DATA_PC_SIZE-1 downto 0);
			data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
			addr : out std_logic_vector(ADD_OUT_SIZE-1 downto 0);
			readEnableDecoder : out std_logic;
			writeEnableDecoder : out std_logic
		);
end entity;

architecture processadorArc of my_processador is

	signal sig_mux_pc, sig_mux_reg_ula, sig_mux_reg_sai, sig_we, sig_bigger_than, sig_iqual_to, sig_less_than, sig_mux_reg_escrita : std_logic;
	signal sig_func_ula : std_logic_vector(2 downto 0);
	signal sig_pc : std_logic_vector(DATA_PC_SIZE-1 downto 0);
	signal sig_data_a_br, sig_data_b_br, sig_saida_mux_reg_ula, sig_saida_mux_ula_in, sig_saida_ula : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal sig_reg_escrita : std_logic_vector(4 downto 0);
	
begin

		UC: entity work.my_uc
			Port Map(
				opcode => ROM_in(24 downto 20),
				jle => sig_bigger_than,
				je => sig_iqual_to,
				jbe => sig_less_than,
				muxPc => sig_mux_pc,
				muxRegUla => sig_mux_reg_ula,
				funcUla => sig_func_ula,
				muxRegSai => sig_mux_reg_sai,
				weBC => sig_we,
				readEnable => readEnableDecoder,
				writeEnable => writeEnableDecoder,
				muxRegEsc => sig_mux_reg_escrita);
				
		-- Port map do program counter
		-- O valor de imediato, caso seja utilizado sera de 9 bits
		PC: entity work.my_pc
			Generic Map(DATA_PC_SIZE=>DATA_PC_SIZE)
			Port Map(
				clk => clk,
				imediate => ROM_in(DATA_PC_SIZE-1 downto 0),
				uc_enable => sig_we,					
				instr => sig_pc);
				
		MUX_REG_ULA: entity work.my_mux
			Generic Map(DATA_WIDTH=>DATA_WIDTH)
			Port Map(
				A => ROM_in(DATA_WIDTH-1 downto 0),
				B => sig_data_b_br,
				sel => sig_mux_reg_ula,
				Y => sig_saida_mux_reg_ula);
				
		BR: entity work.my_banco_reg
			Generic Map(larguraDados=>DATA_WIDTH,larguraEndBancoRegs=>ADD_SIZE)
			Port Map(
				clk => clk,
				enderecoA => ROM_in(19 downto 15),
				enderecoB => ROM_in(14 downto 10),
				enderecoEscrita => sig_reg_escrita,
				dadosEscrita => sig_saida_mux_ula_in,
				we => sig_we,
				saidaA => sig_data_b_br,
				saidaB => sig_data_a_br);
		
		MUX_ULA_REG_ESC: entity work.my_mux
			Generic Map(DATA_WIDTH=>5)
			Port Map(
				A => ROM_in(9 downto 5),
				B => ROM_in(14 downto 10),
				sel => sig_mux_reg_escrita,
				Y => sig_reg_escrita);
		
		MUX_ULA_IN: entity work.my_mux
			Generic Map(DATA_WIDTH=>DATA_WIDTH)
			Port Map(
				A => data_in,
				B => sig_saida_ula,
				sel => sig_mux_reg_sai,
				Y => sig_saida_mux_ula_in);
				
		ULA: entity work.my_ula
			Generic Map(DATA_WIDTH=>DATA_WIDTH)
			Port Map(
				A => sig_data_a_br,
				B => sig_saida_mux_reg_ula,
				func => sig_func_ula,
				Y => sig_saida_ula,
				bigger_than => sig_bigger_than,
				iqual_to => sig_iqual_to,
				smaller_than => sig_less_than);

	process(clk)
	begin
		if (rising_edge(clk)) then
					
			ROM_out <= sig_pc;
			data_out <= sig_saida_ula;
			addr <= ROM_in(ADD_OUT_SIZE-1 downto 0);
			
		end if;
	end process;
    
end architecture;
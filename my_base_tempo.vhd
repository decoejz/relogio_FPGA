LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity my_base_tempo is
    port(
        clk      :   in std_logic;
        sw_in : in std_logic;
        enable : in std_logic;
        saida_clk :   out std_logic_vector(7 downto 0)
        );
end entity;

architecture divInteiro of my_base_tempo is
    signal tick : std_logic := '0';
    signal divisor : natural := 50000000;
    signal contador : integer range 0 to 100000000 := 0;
begin
    -- sw seleciona o divisor
	 divisor <= 50000000 when sw_in='1' else 100000000;
    process(clk)
    begin
        if rising_edge(clk) then
            -- contador e comparador
            if contador = divisor then
                contador <= 0;
                tick <= not tick;
            else
                contador <= contador + 1;
            end if;
        end if;
	end process;
   -- saida do clock em 8 bits quando enable, no contrário saida é impedância
	saida_clk <= ("0000000" & tick) when (enable='1') else "ZZZZZZZZ";
end architecture divInteiro;
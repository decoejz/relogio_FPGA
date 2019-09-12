library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_memory IS
     generic (
          dataWidth: natural := 16;
          addrWidth: natural := 4
     );
    port (
        clk : IN STD_LOGIC;
            Endereco : IN STD_LOGIC_VECTOR (addrWidth-1 DOWNTO 0);
        Dado : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
end entity;

architecture sincrona OF my_memory IS

   type blocoMemoria IS ARRAY(0 TO 2**addrWidth - 1) OF std_logic_vector(dataWidth-1 DOWNTO 0);

    function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
    begin
            -- Inicializa os endereços:
				--     FUNCAO | REGIS  | IMEDIATO
        tmp(0) := x"0010" & "0000" & "0111" --& x"05";
        tmp(1) := x"0000" & "0000" & "0111" --& x"05";
        tmp(2) := x"32" --& x"03";
        tmp(3) := x"33" --& x"07";
        tmp(4) := x"34" --& x"0B";
        tmp(5) := x"35" --& x"0A";
        tmp(6) := x"36" --& x"05";
        tmp(7) := x"37" --& x"04";
        tmp(8) := x"38" --& x"05";
        tmp(9) := x"39" --& x"05";
        tmp(10) := x"30" --& x"02";
        tmp(11) := x"32" --& x"0C";
        tmp(12) := x"32" --& x"0D";
        tmp(13) := x"20" --& x"05";
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;
	 signal ende : std_logic_vector(7 downto 0) := "00000000" ;
	 signal data : std_logic_vector(7 downto 0);
	 signal completo : std_logic_vector(15 downto 0);

begin
    process(clk)
    begin
    if(rising_edge(clk)) then
	 
			completo <= memROM (to_integer(unsigned(pcOut)));
			
			inst	<= completo(11 downto 8);
			regs <= completo(7 downto 4);
			imediato <=completo(3 downto 0);
			
			pcOut <= pcOut + 1;
         --Dado <= data;
			 
			 
    end if;
    end process;

end architecture;
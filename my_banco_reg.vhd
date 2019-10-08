library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

entity my_banco_reg is
    generic
    (
        larguraDados        : natural := 8;
        larguraEndBancoRegs : natural := 5   --Resulta em 2^5=32 posicoes
    );
-- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    port
    (
        clk             : in std_logic;
--
        enderecoA       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoB       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoEscrita : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
--
        dadosEscrita    : in std_logic_vector((larguraDados-1) downto 0);
--
        we              : in std_logic := '0';
        saidaA          : out std_logic_vector((larguraDados -1) downto 0);
        saidaB          : out std_logic_vector((larguraDados -1) downto 0)
    );
end entity;

--8 Registradores de 8 bits;
--2 portas de leitura;
--1 porta de escrita;
--1 sinal de ativar escrita.

architecture comportamento of my_banco_reg is

    subtype palavra_t is std_logic_vector((larguraDados-1) downto 0);
    type memoria_t is array(2**larguraEndBancoRegs-1 downto 0) of palavra_t;

    -- Declaracao dos registradores:
    shared variable registrador : memoria_t;

begin
    process(clk) is
    begin
		  -- A Cada rising edge escreve o dado no enderecoEscrita
        if (rising_edge(clk)) then
            if (we = '1') then
                registrador(to_integer(unsigned(enderecoEscrita))) := dadosEscrita;
            end if;
        end if;
    end process;
    -- Leva pra saida o que foi escrito no reg referente
    saidaA <= registrador(to_integer(unsigned(enderecoA)));
    saidaB <= registrador(to_integer(unsigned(enderecoB)));
 
end architecture;
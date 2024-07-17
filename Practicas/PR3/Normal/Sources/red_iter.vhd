----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2023 18:22:26
-- Design Name: 
-- Module Name: red_iter - rIterativa
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity red_iter is
generic (cant_num: natural := 4;
         cant_bits: natural := 4
);
  Port (
  clk: in std_logic;
  rst: in std_logic;
  entradas: in std_logic_vector((cant_num*cant_bits) - 1 downto 0);
  salida: out std_logic_vector (cant_bits - 1 downto 0)
   );
end red_iter;

architecture rIterativa of red_iter is
component comparador is
generic (cant_bits: natural);
port (
    a: in std_logic_vector(cant_bits - 1 downto 0);
    b: in std_logic_vector (cant_bits- 1 downto 0);
    c_out: out std_logic_vector (cant_bits- 1 downto 0)
    );
end component comparador;

type nums_comp is array (cant_num - 1 downto 0) of std_logic_vector(cant_bits - 1 downto 0);
signal numeros: nums_comp;
signal salida_reg: std_logic_vector (cant_bits - 1 downto 0);
signal entradas_reg:std_logic_vector (cant_num*cant_bits - 1 downto 0);

begin

entrada_registro: process(clk, rst)
begin
if (rst = '1') then entradas_reg <= (others => '0');
elsif rising_edge(clk) then
    entradas_reg <= entradas;
end if;
end process entrada_registro;


numeros(0) <= entradas_reg(cant_bits - 1 downto 0);
--numeros(0) <= entradas(cant_bits - 1 downto 0);
generar_comparadores: for i in 0 to cant_num - 2 generate 
i_comp: comparador 
generic map (cant_bits => cant_bits)
port map (
    a => entradas_reg(cant_bits*(i + 1) + 3 downto cant_bits*(i + 1)),
--    a => entradas(cant_bits*(i + 1) + 3 downto cant_bits*(i + 1)),
    b => numeros(i),
    c_out => numeros(i + 1)
);
end generate generar_comparadores;


salida_registro: process (clk, rst)
begin
    if rst = '1' then
        salida_reg <= (others => '0');
    elsif rising_edge(clk) then
        salida_reg <= numeros(cant_num - 1);
    end if;

end process;

salida <= salida_reg;
--salida <= numeros(cant_num - 1);

end rIterativa;

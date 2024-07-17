----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2023 21:55:49
-- Design Name: 
-- Module Name: red_arbol - red_arb
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
--use work.log2_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity red_arbol is
generic (cant_num: natural := 4;
         cant_bits: natural := 4
);
  Port (
  entradas: in std_logic_vector((cant_num*cant_bits) - 1 downto 0);
  clk: in std_logic;  
  rst: in std_logic;
  salida: out std_logic_vector (cant_bits - 1 downto 0)
   );
end red_arbol;

architecture redArbol of red_arbol is

function log2 (input: integer) return integer is
    variable tem, log: integer;
 begin
    tem:= input;
    log:= 0;
    while(tem > 1) loop
        tem:= tem/2;
        log:= log+1;
        end loop;
        return log;
end function log2;


component comparador is
generic ( cant_bits: natural
);
port (
    a: in std_logic_vector(cant_bits - 1 downto 0);
    b: in std_logic_vector (cant_bits - 1 downto 0);
    c_out: out std_logic_vector (cant_bits - 1 downto 0)
    );
end component comparador;

type C_type is array (log2(cant_num) downto 0, cant_num - 1 downto 0) of std_logic_vector (cant_bits - 1 downto 0);
signal c: C_type;
signal salida_reg: std_logic_vector(cant_bits - 1 downto 0);
signal entradas_reg: std_logic_vector ((cant_num*cant_bits) - 1 downto 0);

begin

entrada_registro: process(clk, rst)
begin
if (rst = '1') then entradas_reg <= (others => '0');
elsif rising_edge(clk) then
    entradas_reg <= entradas;
end if;
end process entrada_registro;


gen_entradas: for i in 0 to cant_num - 1 generate 
--    c(0, i) <=  entradas((i + 1)*cant_bits - 1 downto cant_bits*i);
    c(0, i) <=  entradas_reg((i + 1)*cant_bits - 1 downto cant_bits*i);
end generate gen_entradas;

gen_niveles: for i in 0 to log2(cant_num) - 1 generate 
    gen_comparadores: for j in 0 to (cant_num/(2*(i + 1))) - 1 generate
        comparador_i: comparador 
            generic map (cant_bits => cant_bits)
            port map (
                a => c(i,2*j),
                b => c(i, 2*j + 1),
                c_out => c(i + 1, j)
            );
     end generate gen_comparadores;
end generate gen_niveles;


salida_registro: process (clk, rst)
begin
    if rst = '1' then
        salida_reg <= (others => '0');
    elsif rising_edge(clk) then
        salida_reg <= c(log2(cant_num), 0);
    end if;

end process;



--salida <= c(log2(cant_num), 0);
salida <= salida_reg;
end redArbol;

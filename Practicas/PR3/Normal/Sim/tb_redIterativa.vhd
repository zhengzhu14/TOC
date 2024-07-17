library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use work.log2_pack.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_redes is
generic (cant_num: natural := 4;
        cant_bits: natural := 4
);
end tb_redes;

architecture tb_red of tb_redes is

component red_iter is

   Port (
        entradas: in std_logic_vector((cant_num*cant_bits) - 1 downto 0);
        salida: out std_logic_vector (cant_bits - 1 downto 0)
   );
end component red_iter;

--component red_arbol is
--    generic (cant_num: natural := 16;
--             cant_bits: natural:= 4
--    );
--    port(
--    entradas: in std_logic_vector(cant_num * cant_bits - 1 downto 0);
--    salida: out std_logic_vector(cant_bits - 1 downto 0)
--);
--end component red_arbol;

signal entradas: std_logic_vector((cant_num * cant_bits) - 1 downto 0);
signal salida: std_logic_vector(cant_bits - 1 downto 0);

begin
    i: red_iter 

    port map(
        entradas => entradas,
        salida => salida
    ); 


--      a: red_arbol 
--        generic map (cant_num => cant_num,
--                    cant_bits => cant_bits
--        )
--        port map(
--            entradas => entradas,
--            salida => salida
--        ); 

testbench: process
begin
    for i in 0 to cant_num-1 loop
            entradas((i+1)*cant_bits -1 downto i*cant_bits) <= std_logic_vector(to_signed(i-(cant_num/2), cant_bits));
        end loop;  
    wait for 50ns;
        for i in 0 to cant_num-1 loop
            entradas((i+1)*cant_bits -1 downto i*cant_bits) <= std_logic_vector(to_signed((cant_num/2) - i, cant_bits));
        end loop;
    wait;
end process testbench;
end tb_red;


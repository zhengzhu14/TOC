----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 12:09:44
-- Design Name: 
-- Module Name: leds - leds_rtl
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity leds is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    op: in std_logic_vector (1 downto 0);
    leds: out std_logic_vector(9 downto 0)
   );
end leds;

architecture leds_rtl of leds is

type state is (s0, s1, s2, s3);
signal estado_actual, estado_siguiente: state;

signal leds_reg: std_logic_vector(9 downto 0);
begin

cambios: process (clk, rst)
begin 
    if rst = '1' then
        estado_actual <= s0;
    elsif rising_edge(clk) then
        estado_actual <= estado_siguiente;
    end if;
end process cambios;

estados_comb: process (op, estado_actual)
begin
    case estado_actual is
        when s0 => 
            if op = "00" then
                estado_siguiente <= s1;
            elsif op = "01" then
                estado_siguiente <= s0;
            elsif op = "10" then
                estado_siguiente <= s2;
            else estado_siguiente <= s3;
            end if;
        when s1 => 
            if op = "00" then
                estado_siguiente <= s1;
            else estado_siguiente <= s0;
            end if;
        when s2 => 
            if op = "00" then
                estado_siguiente <= s0;
            else 
             estado_siguiente <= s3;
            end if;
        when s3 => 
            if op = "00" then
                estado_siguiente <= s0;
            else 
                estado_siguiente <= s3;
            end if;
    end case;
end process estados_comb;


salidas_estados: process (estado_actual, clk, rst)
begin 
    if rst = '1' then
        leds_reg <= (others => '0');
    elsif rising_edge(clk) then
        case estado_actual is
            when s0 => 
                leds_reg <= (others => '0');
            when s1 => 
                leds_reg <=  (not leds_reg(0)) & leds_reg(9 downto 1);
            when s2 => 
                leds_reg <= "0101010101";
            when s3 => 
                leds_reg <= not leds_reg;
        end case;
     end if;
end process salidas_estados;

leds <= leds_reg;

end leds_rtl;

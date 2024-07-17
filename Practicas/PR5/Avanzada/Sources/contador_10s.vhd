----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 11:19:41
-- Design Name: 
-- Module Name: contador_10s - time-rtl
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador_10s is
  Port (
    clk: in std_logic; --reloj de 1hz
    rst: in std_logic;
    ce: in std_logic;
    count_finished: out std_logic
   );
end contador_10s;

architecture time_rtl of contador_10s is
signal count_reg: unsigned(3 downto 0);
signal count_fin_reg: std_logic;
begin

conteo:process(clk, rst)
begin
    if rst = '1' then
        count_reg <= (others => '0');
        count_fin_reg <= '0';
    elsif rising_edge(clk) then
        if ce = '1' then
            if count_reg = "1001" then
                count_reg <= "0000";
                count_fin_reg <= '1';
            else 
                count_reg <= count_reg + 1;
                count_fin_reg <= '0';
            end if;
        else 
            count_reg <= count_reg;
            count_fin_reg <= '0';
        end if;
    end if;
    
end process conteo;

count_finished <= count_fin_reg;

end time_rtl;

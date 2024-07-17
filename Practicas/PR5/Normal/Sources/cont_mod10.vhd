----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2023 22:12:49
-- Design Name: 
-- Module Name: cont_mod10 - cont_rtl
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

entity cont_mod10 is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    ce: in std_logic;
    sal: out std_logic_vector(3 downto 0)
   );
end cont_mod10;

architecture cont_rtl of cont_mod10 is
signal count: unsigned(3 downto 0);
begin

contador:process (clk, rst)
begin
    if rst = '1' then
        count <= (others => '0');
    elsif rising_edge(clk) then
        if ce = '1' then
            if count = "1001" then
                count <= (others => '0');
            else count <= count + 1;
            end if;
        else count <= count;
       end if;
    end if;
end process contador;

sal <= std_logic_vector(count); 

end cont_rtl;

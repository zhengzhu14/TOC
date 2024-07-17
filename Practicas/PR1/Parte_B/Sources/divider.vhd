----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 11:56:09
-- Design Name: 
-- Module Name: divider - clock_divider
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor is
  port (
    rst        : in  std_logic;         -- asynch reset
    clk_100mhz : in  std_logic;         -- 100 MHz input clock
    clk_1hz    : out std_logic          -- 1 Hz output clock
    );
end divisor;

architecture rtl of divisor is
  signal cntr_reg    : unsigned(24 downto 0);
  signal clk_1hz_reg : std_logic;
begin

  p_cntr : process(rst, clk_100mhz)
  begin
    if (rst = '1') then
      cntr_reg    <= (others => '0');
      clk_1hz_reg <= '0';
    elsif rising_edge(clk_100mhz) then
      if cntr_reg = (24 downto 0 => '1') then
        cntr_reg    <= (others => '0');
        clk_1hz_reg <= not clk_1hz_reg;
      else
        cntr_reg    <= cntr_reg + 1;
        clk_1hz_reg <= clk_1hz_reg;
      end if;
    end if;
  end process p_cntr;

  output_clock : clk_1hz <= clk_1hz_reg;
end rtl;
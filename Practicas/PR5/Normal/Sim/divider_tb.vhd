----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 18:16:11
-- Design Name: 
-- Module Name: divider_tb - Behavioral
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

entity divider_tb is
--  Port ( );
end divider_tb;

architecture Behavioral of divider_tb is
component divisor is
  port (
    rst        : in  std_logic;         -- asynch reset
    clk_100mhz : in  std_logic;         -- 100 MHz input clock
    clk_1hz    : out std_logic;         -- 1 Hz output clock
    c_enable1_12hz: out std_logic;      -- count enable de 12 hz
    c_enable2_24hz: out std_logic     -- count enable de 24 hz
    );
end component;
    signal rst :  std_logic;         -- asynch reset
   signal clk_100mhz :   std_logic;         -- 100 MHz input clock
  signal  clk_1hz    :  std_logic;         -- 1 Hz output clock
    signal c_enable1_12hz:  std_logic;      -- count enable de 12 hz
  signal  c_enable2_24hz:  std_logic;
  
constant period: time := 10ns;
begin
dut: divisor 
port map (
    rst => rst,
    clk_100mhz => clk_100mhz,
    c_enable1_12hz => c_enable1_12hz,
    clk_1hz => clk_1hz,
    c_enable2_24hz => c_enable2_24hz
);


flancos: process
begin
    clk_100mhz <= '0';
    wait for period/2;
    clk_100mhz <= '1';
    wait for period/2;
end process flancos;

cambios: process
begin
    rst <= '1';
    wait until rising_edge(clk_100mhz);
    rst <= '0';

    wait;
end process;
end Behavioral;

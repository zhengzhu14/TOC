----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 15:03:50
-- Design Name: 
-- Module Name: leds_tb - tb_luces
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

entity leds_tb is
--  Port ( );
end leds_tb;

architecture tb_luces of leds_tb is

component leds is 
port ( clk: in std_logic;
    rst: in std_logic;
    op: in std_logic_vector (1 downto 0);
    leds: out std_logic_vector(9 downto 0)
);
end component;


signal clk, rst: std_logic;
signal op: std_logic_vector (1 downto 0);
signal sal: std_logic_vector(9 downto 0);

constant period: time := 10ns;
begin

dut: leds 
port map (
    clk => clk,
    rst => rst,
    op => op,
    leds => sal
);

reloj: process
begin
    clk <= '0';
    wait for period/2;
    clk <= '1';
    wait for period/2;
end process;


tb: process
begin
    rst <= '1';
    wait until rising_edge(clk);
    rst <= '0';
    op <= "00";
    wait until rising_edge(clk);
    wait for 90 ns;
    op <= "01";
    wait for 30 ns;
    op <= "10";
    wait until rising_edge(clk);
    wait;

end process;




end tb_luces;

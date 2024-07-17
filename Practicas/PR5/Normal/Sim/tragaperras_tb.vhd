----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 17:18:15
-- Design Name: 
-- Module Name: tragaperras_tb - tb_tragaperras
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

entity tragaperras_tb is
--  Port ( );
end tragaperras_tb;

architecture tb_tragaperras of tragaperras_tb is
component tragaperras is 
  Port (
    clk: in std_logic;
    rst: in std_logic;
    ini: in std_logic;
    fin: in std_logic;
    
    sal1: out std_logic_vector(3 downto 0);
    sal2: out std_logic_vector(3 downto 0);
    luz: out std_logic_vector(9 downto 0)
   );
end component tragaperras;

signal clk, rst, ini, fin: std_logic;
signal sal1,sal2: std_logic_vector(3 downto 0);
signal luz: std_logic_vector(9 downto 0);

constant period: time := 10ns;

begin
dut: tragaperras 
port map(
    clk => clk,
    rst => rst,
    ini => ini,
    fin => fin,
    sal1 => sal1,
    sal2 => sal2,
    luz => luz
);

flancos: process
begin
    clk <= '0';
    wait for period/2;
    clk <= '1';
    wait for period/2;
end process flancos;

tb_trag: process
begin
    rst <= '1';
    ini <= '0';
    fin <= '0';
    wait until rising_edge(clk);
    rst <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    ini <= '1';
    wait until rising_edge(clk);
    ini <= '0';
    wait for 150ns;
    wait until rising_edge(clk);
    fin <= '1';
    wait until rising_edge(clk);
    fin <= '0';
    wait;

end process tb_trag;



end tb_tragaperras;

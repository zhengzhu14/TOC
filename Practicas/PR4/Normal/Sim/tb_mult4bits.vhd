----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2023 00:55:11
-- Design Name: 
-- Module Name: tb_mult4bits - Behavioral
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

entity tb_mult4bits is
--  Port ( );
end tb_mult4bits;

architecture Behavioral of tb_mult4bits is
component mul4bits is 
  Port (
        clk: in std_logic; 
        rst: in std_logic; --boton
        start: in std_logic; --boton
        x: in std_logic_vector (3 downto 0); --op1
        y: in std_logic_vector (3 downto 0); --op2
        sal: out std_logic_vector(7 downto 0); --solucion
        done: out std_logic     --senyal fin
   );
end component mul4bits;

constant clk_period: time := 10ns;


signal rst,clk,start: std_logic;
signal x,y: std_logic_vector(3 downto 0);
signal sal: std_logic_vector(7 downto 0);
signal done: std_logic;

begin
dut: mul4bits 
port map (clk => clk,
            rst => rst,
            start => start,
            x => x,
            y => y,
            sal => sal,
            done => done
);

 p_clk : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process p_clk;
  
  
p_sim: process 
begin
    rst <= '1'; 
    wait until rising_edge(clk);
    rst <= '0';
    x <= "0111";
    y <= "0011";
    start <= '1';
    wait until rising_edge(clk);
    start <= '0';
    wait until done = '1';
    wait until rising_edge(clk);
    x <= "0101";
    y <= "0101";
    start <= '1';
    wait until rising_edge(clk);
    start <= '0';
    wait;
end process p_sim;


end Behavioral;

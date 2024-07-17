----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 18:54:54
-- Design Name: 
-- Module Name: register_pipo_divider - rtl
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
use ieee.numeric_std.all;


---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

entity register_pipo_divider is
  port (en: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        load: in std_logic;
        sal: out std_logic_vector(3 downto 0)
   );
end register_pipo_divider;

architecture rtl of register_pipo_divider is
component registro_pipo
    port(
      rst  : in  std_logic;
      clk  : in  std_logic;
      load : in  std_logic;
      entrada  : in  std_logic_vector(3 downto 0);
      salida   : out std_logic_vector(3 downto 0)
      );
  end component;
  
component divisor is
  port (
    rst        : in  std_logic;         -- asynch reset
    clk_100mhz : in  std_logic;         -- 100 MHz input clock
    clk_1hz    : out std_logic          -- 1 Hz output clock
    );
end component;

signal regclk: std_logic;
begin
div: divisor 
    port map (
        rst => rst,
        clk_100mhz => clk,
        clk_1hz => regclk
    );
reg: registro_pipo
    port map (
        clk=> regclk,
        rst => rst,
        load => load,
        entrada => en,
        salida => sal
    );
    
end rtl;

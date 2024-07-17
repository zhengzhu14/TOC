----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 13:52:39
-- Design Name: 
-- Module Name: registro_pipo - rtl
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

entity registro_pipo is 
    generic (width_reg : natural := 8);
    port(clk: in std_logic;
        rst: in std_logic;
        load: in std_logic;
        entrada: in std_logic_vector(width_reg - 1 downto 0);
        salida: out std_logic_vector (width_reg - 1 downto 0)
    );
end registro_pipo;

architecture rtl of registro_pipo is 

begin

  pipo_process: process(clk, rst, load, entrada)
    begin 
        if (rst = '1') then
            salida <= (others => '0');
        elsif rising_edge(clk) then
            if (load = '1') then 
                salida <= entrada;
            end if;
        end if;
   end process pipo_process;
   
end rtl;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2023 12:40:08
-- Design Name: 
-- Module Name: RD - Behavioral
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

entity RD is
  Port ( 
        clk: in std_logic;
        rst: in std_logic;
        x: in std_logic_vector (3 downto 0); --op1
        y: in std_logic_vector (3 downto 0); --op2
        
        a_ls: in std_logic_vector(1 downto 0); -- 00 ningun cambio, 01 load, 10 shift
        b_ls: in std_logic_vector(1 downto 0); -- 00 ningun cambio, 01 load, 10 shift
        acc_l: in std_logic;
        n_l: in std_logic; 
    
        acc_mux: in std_logic_vector(1 downto 0);
        n_mux: in std_logic;
        
        
        n_i: out std_logic;
        b_i: out std_logic; 
        
        sal: out std_logic_vector(7 downto 0) --solucion
    );
end RD;

architecture RD_rtl of RD is

signal a,b: std_logic_vector(7 downto 0);
signal n: unsigned(2 downto 0);
signal acc: std_logic_vector (7 downto 0);


begin

ruta_datos: process (clk, rst, x, y, a_ls, b_ls, acc_l, n_l, acc_mux,n_mux)
begin
if rst = '1' then 
    a <= (others => '0');
    b <= (others => '0');
    acc <= (others => '0');
    n <= (others => '0');
elsif rising_edge(clk) then
    if a_ls = "01" then
        a <= "0000" & x;
    elsif a_ls = "10" then
        a <= a(6 downto 0) & '0';
    else a <= a;
    end if;
    
    if b_ls = "01" then
        b <= "0000" & y;
    elsif b_ls = "10" then
        b <= '0' & b(7 downto 1);
    else b <= b;
    end if;
    
    if n_l = '1' then 
        if n_mux = '0' then
            n <= "100";
        else 
            n <= n - 1;
        end if;
     end if;
     
     if acc_l = '1' then
        if acc_mux = "00" then
            acc <= (others => '0');
        elsif acc_mux = "01" then
            acc <= std_logic_vector(unsigned(acc) + unsigned(a));
        else acc <= acc;
        end if;
     end if;


end if;
end process ruta_datos;

n_i <= '1' when n = "000" else 
        '0';
b_i <= b(0);
sal <= acc;
end RD_rtl;

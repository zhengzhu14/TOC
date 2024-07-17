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

entity UC is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    start: in std_logic;
    n_i: in std_logic;
    b_i: in std_logic;
    
    done: out std_logic;
     
    a_ls: out std_logic_vector(1 downto 0); -- 00 ningun cambio, 01 load, 10 shift
    b_ls: out std_logic_vector(1 downto 0); -- 00 ningun cambio, 01 load, 10 shift
    acc_l: out std_logic;
    n_l: out std_logic; 
    
    acc_mux: out std_logic_vector(1 downto 0);
    n_mux: out std_logic
  
   );
end UC;


architecture UC_rtl of UC is

type estados is (s0,s1,s2,s3,s4);
signal estado_actual, estado_siguiente: estados;


begin

cambio_estado: process (clk, rst) 
begin 
    if rst = '1' then 
        estado_actual <= s0;
    elsif rising_edge(clk) then
        estado_actual <= estado_siguiente;
    end if;
end process cambio_estado;

siguiente: process(estado_actual, b_i, n_i, start)
begin 
case estado_actual is
    when s0 => 
        if start = '1' then
            estado_siguiente <= s1;
        else estado_siguiente <= s0;
        end if;
    when s1 => 
        estado_siguiente <= s2;
    when s2 => 
        if n_i = '1' then 
            estado_siguiente <= s0;
        else 
            if b_i = '1' then 
                estado_siguiente <= s3;
            else estado_siguiente <= s4;
            end if;
        end if;
    when others => estado_siguiente <= s2;
end case;
end process siguiente;

salidas: process (estado_actual)
begin
case estado_actual is
    when s0 => 
        --Son don't care
        a_ls <= "00";
        b_ls <= "00";
        acc_l <= '0';
        n_l <= '0';
        acc_mux <= "00";
        n_mux <= '0';
        done <= '1';
    when s1 => 
        a_ls <= "01";
        b_ls <= "01";
        acc_l <= '1';
        n_l <= '1';
        acc_mux <= "00";
        n_mux <= '0';  
        done <= '0';

    when s2 => 
        a_ls <= "00";
        b_ls <= "00";
        acc_l <= '0';
        n_l <= '0';
        acc_mux <= "00";
        n_mux <= '0';   
        done <= '0';
  
    when s3 => 
        a_ls <= "10";
        b_ls <= "10";
        acc_l <= '1';
        n_l <= '1';
        acc_mux <= "01";
        n_mux <= '1';
        done <= '0';
    when others => 
        a_ls <= "10";
        b_ls <= "10";
        acc_l <= '1';
        n_l <= '1';
        acc_mux <= "10";
        n_mux <= '1';
        done <= '0';
end case;
end process salidas;

end UC_rtl;

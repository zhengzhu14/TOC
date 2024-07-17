----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2023 20:35:20
-- Design Name: 
-- Module Name: UC - uc_rtl
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

entity UC is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    ini: in std_logic;
    fin: in std_logic;
    
    acierto: in std_logic;
    time_finished: in std_logic;
    
    enable_count: out std_logic;
    leds_op: out std_logic_vector(1 downto 0);
    display_choose: out std_logic;
    time_enable: out std_logic;
    reg_load: out std_logic
   );
end UC;

architecture uc_rtl of UC is


type state is (s0, s1, s2, s3, s4);
signal estado_actual, estado_siguiente: state;

begin
cambiar: process (clk, rst)
begin 
    if rst = '1' then
        estado_actual <= s0;
    elsif rising_edge(clk) then
        estado_actual <= estado_siguiente;
    end if;
end process cambiar;

cambiar_estados: process (ini, fin, acierto, estado_actual, time_finished)
begin
    case estado_actual is
        when s0 => 
            if ini = '1' then
                estado_siguiente <= s1;
            else estado_siguiente <= s0;
            end if;
        when s1 => 
            if fin = '1' then
                estado_siguiente <= s2;
            else estado_siguiente <= s1;
            end if;
        when s2 => 
            if acierto = '1' then
                estado_siguiente <= s4;
            else estado_siguiente <= s3;
            end if;
        when s3 => 
            if time_finished = '1'  then
                estado_siguiente <= s0;
            else estado_siguiente <= s3;
            end if;
        when others => 
            if time_finished = '1' then
                estado_siguiente <= s0;
            else
                estado_siguiente <= s4;
            end if;
    end case;
end process cambiar_estados;

salidas: process (estado_actual)
begin 
    case estado_actual is
        when s0 =>
            enable_count <= '0';
            leds_op <= "00";
            display_choose <= '0';
            reg_load <= '0';
            time_enable <= '0';
        when s1 => 
            enable_count <= '1';
            leds_op <= "01";
            display_choose <= '1';
            reg_load <= '1';
            time_enable <= '0';
        when s2 => 
            enable_count <= '0';
            leds_op <= "01";
            display_choose <= '1';
            reg_load <= '0';
            time_enable <= '0';
        when s3 => 
            enable_count <= '0';
            leds_op <= "10";
            display_choose <= '1';
            reg_load <= '0';
            time_enable <= '1';
        when others => 
            enable_count <= '0';
            leds_op <= "11";
            display_choose <= '1';
            reg_load <= '0';
            time_enable <= '1';
    end case;

end process salidas;


end uc_rtl;

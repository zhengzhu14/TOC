----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.11.2023 09:52:40
-- Design Name: 
-- Module Name: simadd - testbench_arch
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

entity simadd is
--  Port ( );
end simadd;

architecture testbench_arch of simadd is
-- Component declaration
    COMPONENT adder4b
    PORT(
        A : IN std_logic_vector(3 downto 0);
        B : IN std_logic_vector(3 downto 0);
        C : OUT std_logic_vector(3 downto 0)
     );
    END COMPONENT;
-- Inputs
    signal A : std_logic_vector(3 downto 0) := (others => '0');
    signal B : std_logic_vector(3 downto 0) := (others => '0');
-- Outputs
    signal C : std_logic_vector(3 downto 0);
begin
    uut: adder4b PORT MAP (
    A => A,
    B => B,
    C => C );
-- Stimuli process
stim_proc: process
    begin
        A <= "0000"; B <= "0000";
        wait for 100 ns;
        A <= "0101"; B <= "0100";
        wait for 100 ns;
        A <= "0000"; B <= "0111";
        wait for 100 ns;
        A <= "0011"; B <= "1000";
        wait for 100 ns;
        A <= "1011"; B <= "1111";
        wait for 100 ns;
        A <= "1001"; B <= "0110";
        wait;
end process;

end testbench_arch;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2023 17:56:34
-- Design Name: 
-- Module Name: comparador - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparador is
generic (cant_bits: natural := 4);
  port (
  a: in std_logic_vector (cant_bits - 1 downto 0);
  b: in std_logic_vector (cant_bits - 1 downto 0);
  c_out: out std_logic_vector (cant_bits - 1 downto 0)
   );
end comparador;

architecture compara of comparador is

begin

comparacion: process (a, b)
begin
   if signed(a) < signed(b) then c_out <= b; 
   else c_out <= a; 
   end if;
end process comparacion;

end compara;

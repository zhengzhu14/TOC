----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2023 00:36:09
-- Design Name: 
-- Module Name: cerrojo_basico - Behavioral
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

entity sistema is
     Port (
    clk: in std_logic; 
    rst: in std_logic;
    boton: in std_logic;
    clave: in std_logic_vector(7 downto 0);
    bloqueado: out std_logic_vector(9 downto 0);
    ldisplay: out std_logic_vector(6 downto 0)
   );
end sistema;

architecture sistema_rtl of sistema is
    component cerrojo is  
         Port (
            clk: in std_logic; 
            rst: in std_logic;
            boton: in std_logic;
            clave: in std_logic_vector(7 downto 0);
            bloqueado: out std_logic_vector(9 downto 0);
            ldisplay: out std_logic_vector(3 downto 0)
          ); 
     end component cerrojo;
     
     component debouncer is 
        port (
              rst             : in  std_logic;
              clk             : in  std_logic;
              x               : in  std_logic;
              xDeb            : out std_logic;
              xDebFallingEdge : out std_logic;
              xDebRisingEdge  : out std_logic
        );
     end component debouncer;
     
     component conv_7seg is 
        port (
            x       : in  std_logic_vector (3 downto 0);
            display : out std_logic_vector (6 downto 0)
        );
     end component conv_7seg;
   signal entrada_cod: std_logic_vector(3 downto 0);
   signal boton_debounced: std_logic; 
   
begin
   cer: cerrojo 
   port map (
    clk=> clk,
    rst => rst,
    boton => boton_debounced,
    clave => clave,
    bloqueado => bloqueado,
    ldisplay => entrada_cod
   );
   
   deb: debouncer
   port map (
    clk => clk,
    rst => rst,
    x => boton,
    xDebRisingEdge => boton_debounced
   );
   
   conv: conv_7seg 
   port map (
    x => entrada_cod,
    display => ldisplay
   );

end sistema_rtl;

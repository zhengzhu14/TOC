----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2023 18:56:21
-- Design Name: 
-- Module Name: sistema - sist_rtl
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
    start: in std_logic;
    op1: in std_logic_vector(3 downto 0);
    op2: in std_logic_vector(3 downto 0);
    done: out std_logic;
    display: out std_logic_vector (6 downto 0);
    display_enable: out std_logic_vector(3 downto 0)
   );
end sistema;

architecture sist_rtl of sistema is
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

component displays is
    Port ( 
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;       
        digito_0 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
        display : out  STD_LOGIC_VECTOR (6 downto 0);
        display_enable : out  STD_LOGIC_VECTOR (3 downto 0)
     );
end component displays;

signal startDeb: std_logic;
signal salida: std_logic_vector (7 downto 0);


begin
mul: mul4bits port map (
    clk => clk,
    rst => rst,
    start => startDeb,
    x => op1,
    y => op2,
    sal => salida,
    done => done
);

deb: debouncer port map (
    clk => clk,
    rst => rst,
    x => start,
    xDebRisingEdge => startDeb
);
dis: displays port map (
    clk => clk, 
    rst => rst,
    digito_0 => salida(3 downto 0),
    digito_1 => salida(7 downto 4),
    digito_2 => "0000",
    digito_3 => "0000",
    display => display,
    display_enable => display_enable
);

end sist_rtl;

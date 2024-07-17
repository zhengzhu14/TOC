----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2023 20:36:42
-- Design Name: 
-- Module Name: tragaperras - rtl
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

entity tragaperras is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    ini: in std_logic;
    fin: in std_logic;
    numero: in std_logic_vector(3 downto 0);
    modo: std_logic;
    seg: out std_logic_vector (6 downto 0);
    an: out std_logic_vector(3 downto 0);
--    sal1: out std_logic_vector(3 downto 0);
--    sal2: out std_logic_vector(3 downto 0);
    luz: out std_logic_vector(9 downto 0)
   );
end tragaperras;

architecture rtl of tragaperras is
component RD is
    Port (
        clk: in std_logic;
        rst: in std_logic;
        
        enable_count: in std_logic;
        leds_op: in std_logic_vector(1 downto 0);
        display_choose: in std_logic;
        reg_load: in std_logic;
        time_enable: in std_logic;
        
        numero: in std_logic_vector(3 downto 0);
        wea1: in std_logic_vector(0 downto 0);
        mux_choise: in std_logic;
    
        fin_conteo: out std_logic;
        enable_count2: in std_logic;
        
        acierto: out std_logic; --Señal para que cambie de estado la unidad de control
        time_finished: out std_logic;
        
        sal1: out std_logic_vector(3 downto 0);
        sal2: out std_logic_vector(3 downto 0);
        luz: out std_logic_vector(9 downto 0)
   );
end component;

component UC is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        ini: in std_logic;
        fin: in std_logic;
        
        modo: in std_logic;
        wea1: out std_logic_vector(0 downto 0);
        mux_choise: out std_logic;
    
        fin_conteo: in std_logic;
        enable_count2: out std_logic;
        
        acierto: in std_logic;
        time_finished: in std_logic;

        enable_count: out std_logic;
        leds_op: out std_logic_vector(1 downto 0);
        display_choose: out std_logic;
        reg_load: out std_logic;
        time_enable: out std_logic

   );
end component;

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


signal acierto, enable_count, display_choose, reg_load: std_logic;
signal leds_op: std_logic_vector (1 downto 0);
signal dig1, dig2: std_logic_vector(3 downto 0);
signal ini_debounced, fin_debounced: std_logic;
signal time_enable, time_finished: std_logic;

signal enable_count2, mux_choise, fin_conteo: std_logic;
signal wea1: std_logic_vector (0 downto 0);

begin
unidad_control: UC 
port map (
    clk => clk,
    rst => rst,
    ini => ini_debounced,
    fin => fin_debounced,
    
    acierto => acierto,
    time_enable => time_enable,
    time_finished => time_finished,
    enable_count => enable_count,
    leds_op => leds_op,
    display_choose => display_choose,
    reg_load => reg_load,
    
    
    modo => modo,
    enable_count2 => enable_count2,
    mux_choise => mux_choise,
    fin_conteo => fin_conteo,
    wea1 => wea1
);


ruta_datos: RD
port map (
    clk => clk,
    rst => rst,
    enable_count => enable_count,
    leds_op => leds_op,
    display_choose => display_choose,
    reg_load => reg_load,
    acierto => acierto,
    time_enable => time_enable,
    time_finished => time_finished,
    sal1 => dig1,
    sal2 => dig2,
    luz => luz,
    
    numero => numero,
    enable_count2 => enable_count2,
    mux_choise => mux_choise,
    fin_conteo => fin_conteo,
    wea1 => wea1
);

disp: displays
port map (
    clk => clk,
    rst => rst,
    digito_0 => dig1,
    digito_1 => dig2,
    digito_2 => "0000",
    digito_3 => "0000",
    display => seg,
    display_enable => an
);

deb_ini: debouncer
port map (
    clk => clk,
    rst => rst,
    x => ini,
    xDebRisingEdge => ini_debounced
);

deb_fin: debouncer
port map (
    clk => clk,
    rst => rst,
    x => fin,
    xDebRisingEdge => fin_debounced
);

end rtl;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2023 20:36:05
-- Design Name: 
-- Module Name: RD - rd_rtl
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

entity RD is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    numero: in std_logic_vector(3 downto 0);
    wea1: in std_logic_vector(0 downto 0);
    mux_choise: in std_logic;
    
    fin_conteo: out std_logic;
    enable_count2: in std_logic;
    
    enable_count: in std_logic;
    
    leds_op: in std_logic_vector(1 downto 0);
    display_choose: in std_logic;
    reg_load: in std_logic;
    time_enable: in std_logic;
    

    acierto: out std_logic; --Señal para que cambie de estado la unidad de control
    time_finished: out std_logic;
    
    sal1: out std_logic_vector(3 downto 0);
    sal2: out std_logic_vector(3 downto 0);
    luz: out std_logic_vector(9 downto 0)
   );
end RD;

architecture rd_rtl of RD is

component p5_mem_1 is
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
  );
end component;
component p5_mem_2 is
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
  );
end component;

component cont_mod10 is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    ce: in std_logic;
    sal: out std_logic_vector(3 downto 0)
   );
end component;
component divisor is
  port (
    rst        : in  std_logic;         -- asynch reset
    clk_100mhz : in  std_logic;         -- 100 MHz input clock
    clk_1hz    : out std_logic;         -- 1 Hz output clock
    c_enable1_12hz: out std_logic;      -- count enable de 12 hz
    c_enable2_24hz: out std_logic     -- count enable de 24 hz
    );
end component;
component leds is
  Port (
    clk: in std_logic;
    rst: in std_logic;
    op: in std_logic_vector (1 downto 0);
    leds: out std_logic_vector(9 downto 0)
   );
end component;

component contador_10s is
   Port (
        clk: in std_logic; --reloj de 1hz
        rst: in std_logic;
        ce: in std_logic;
        count_finished: out std_logic
   );
end component contador_10s;

signal clk_1hz: std_logic;
signal ce1, ce2: std_logic;
signal cont1,cont2: std_logic_vector(3 downto 0);
signal div1, div2: std_logic;
signal num1,num2: std_logic_vector(3 downto 0);
signal mem_reg1, mem_reg2: std_logic_vector(3 downto 0);

signal choise: std_logic_vector (3 downto 0);
signal sal_cont_mem: std_logic_vector (3 downto 0);

begin
mem1: p5_mem_1 
port map(
    clka => clk,
    wea => wea1,
    addra => choise,
    dina => numero,
    douta => num1
);

mem2: p5_mem_2
port map (
    clka => clk,
    wea => "0",
    addra => cont2,
    dina => "0000",
    douta => num2
);
cont1_sal: cont_mod10
port map (
    clk => clk,
    rst => rst,
    ce => ce1,
    sal => cont1
); 
cont2_sal: cont_mod10
port map (
    clk => clk,
    rst => rst,
    ce => ce2,
    sal => cont2
);
divider: divisor 
port map (
    clk_100mhz => clk,
    rst => rst,
    c_enable1_12hz => div1,
    c_enable2_24hz => div2,
    clk_1hz => clk_1hz
);
luces: leds
port map (
    clk => div1, --hago que el reloj de los leds vaya a 12hz
    rst => rst,
    op => leds_op,
    leds => luz
);

mem_register: process (clk, rst)
begin
    if rst = '1' then
        mem_reg1 <= "0000";
        mem_reg2 <= "0000";
    elsif rising_edge(clk) then
        if reg_load = '1' then
            mem_reg1 <= num1;
            mem_reg2 <= num2;
        else 
            mem_reg1 <= mem_reg1;
            mem_reg2 <= mem_reg2;
        end if;
    end if;
end process mem_register;

contar_10s: contador_10s 
port map (
    clk => clk_1hz,
    rst => rst,
    ce => time_enable,
    count_finished => time_finished
);

cont_escritura: cont_mod10
port map (
    clk => clk,
    rst => rst,
    ce => enable_count2,
    sal => sal_cont_mem
);

senyal_finConteo: process (sal_cont_mem)
begin
    if sal_cont_mem = "1001" then
        fin_conteo <= '1';
        
    else fin_conteo <= '0';
    end if;
end process senyal_finConteo;


elegir_dir: process (mux_choise)
begin
    if mux_choise = '1' then 
        choise <= cont1;
    else 
        choise <= sal_cont_mem;
    end if;
end process elegir_dir;

ce1 <= div1 when (enable_count = '1') else
        '0';
ce2 <= div2 when enable_count = '1' else 
        '0';
acierto <= '1' when mem_reg2 = mem_reg1 else 
        '0';
        
sal1 <= mem_reg1 when display_choose = '1' else
        "0000";
sal2 <= mem_reg2 when display_choose = '1' else
        "0000";


end rd_rtl;

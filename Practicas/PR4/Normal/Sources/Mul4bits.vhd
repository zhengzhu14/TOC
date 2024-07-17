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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mul4bits is
  Port (
        clk: in std_logic; 
        rst: in std_logic; --boton
        start: in std_logic; --boton
        x: in std_logic_vector (3 downto 0); --op1
        y: in std_logic_vector (3 downto 0); --op2
        sal: out std_logic_vector(7 downto 0); --solucion
        done: out std_logic     --senyal fin
   );
end mul4bits;


architecture mul_rtl of mul4bits is
component UC is 
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
end component;

component RD is 
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
end component;

signal a_ls, b_ls,acc_mux : std_logic_vector (1 downto 0);
signal acc_l, n_l, n_mux, n_i, b_i: std_logic;



begin
unidad_control: UC 
    port map (
        clk => clk,
        rst => rst,
        start => start,
        n_i => n_i,
        b_i => b_i,
        done => done,
        a_ls => a_ls,
        b_ls => b_ls,
        acc_l => acc_l,
        n_l => n_l,
        acc_mux => acc_mux,
        n_mux => n_mux
    );

ruta_datos: RD 
        port map (
        clk => clk,
        rst => rst,
        x => x,
        y => y,
        
        a_ls => a_ls,
        b_ls => b_ls,
        acc_l => acc_l,
        n_l => n_l,
        acc_mux => acc_mux,
        n_mux => n_mux,
        
        n_i => n_i,
        b_i => b_i,
        sal => sal
    );
end mul_rtl;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2023 21:24:11
-- Design Name: 
-- Module Name: tb_cerrojo - Behavioral
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

entity tb_cerrojo is
end tb_cerrojo;

architecture test of tb_cerrojo is
    component cerrojo
        Port (
            clk: in std_logic; 
            rst: in std_logic;
            boton: in std_logic;
            clave: in std_logic_vector(7 downto 0);
            bloqueado: out std_logic_vector(9 downto 0);
            ldisplay: out std_logic_vector(6 downto 0)
        );
     end component cerrojo;
        signal clk: std_logic;  
        signal rst: std_logic; 
        signal boton: std_logic;
        signal clave: std_logic_vector(7 downto 0);
        
        
        signal bloqueado: std_logic_vector(9 downto 0);
        signal ldisplay: std_logic_vector(6 downto 0);
        
        
        constant clk_p: time := 50ns;
begin
    cer: cerrojo
        port map (
            clk => clk,
            rst => rst,
            boton => boton,
            clave => clave,
            bloqueado => bloqueado,
            ldisplay => ldisplay
        );
        
    reloj: process 
    begin 
        clk <= '0';
        wait for clk_p/2;
        clk <= '1';
        wait for clk_p/2;
     end process reloj;
     
     
     simulation: process
     begin 
        rst<= '1';
        boton <= '0';
        clave <= "00000000";
        wait until rising_edge(clk);
        rst <= '0';
        clave <= "10101010";
        boton <= '1';
        wait until rising_edge(clk);
        clave <= "10101011";
        boton <= '1';
        wait until rising_edge(clk);
        clave <= "10101010";
        boton <= '1';
        wait until rising_edge(clk);
        boton <= '0';
--        wait until rising_edge(clk);
--        clave <= "10001011";
--        boton <= '1';
--        wait until rising_edge(clk);
--        clave <= "10100010";
--        boton <= '1';
--        wait until rising_edge(clk);
--        clave <= "10001011";
--        boton <= '1'; 

        wait;
        
     end process simulation;
    
    
end test;

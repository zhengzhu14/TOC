----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2023 12:49:55
-- Design Name: 
-- Module Name: cerrojo - comportamiento
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

entity cerrojo is
  Port (
    clk: in std_logic; 
    rst: in std_logic;
    boton: in std_logic;
    clave: in std_logic_vector(7 downto 0);
    bloqueado: out std_logic_vector(9 downto 0);
    ldisplay: out std_logic_vector(3 downto 0)
   );
end cerrojo;

architecture comportamiento of cerrojo is
    component registro_pipo is
    generic (width_reg : natural := 8);
    port(clk: in std_logic;
        rst: in std_logic;
        load: in std_logic;
        entrada: in std_logic_vector(width_reg - 1 downto 0);
        salida: out std_logic_vector (width_reg - 1 downto 0)
    );
    end component registro_pipo;
    
    
    signal es_clave: std_logic; 
    signal clave_correcta: std_logic_vector(7 downto 0);
    type estados is (s0, s1, s2, s3, s4);
    signal estado_actual , estado_siguiente: estados;
        
begin
    registro: registro_pipo
    port map (
        clk => clk,
        rst => rst,
        load => es_clave,
        entrada => clave,
        salida => clave_correcta
    );
    
    cambio_estados: process(clk, rst)
    begin 
        if(rst = '1') then 
            estado_actual <= s0;
        elsif rising_edge(clk) then 
            estado_actual <= estado_siguiente;
        end if;
     end process cambio_estados;
     
     
     estados_comb: process(estado_actual, boton)
        begin
           case estado_actual is 
            when s0 => 
                if (boton = '1') then 
                    estado_siguiente <= s1;
                else
                    estado_siguiente <= s0;
                end if;
            when s1 => 
                if (boton = '1') then
                    if (clave = clave_correcta) then 
                        estado_siguiente <= s0;
                    else estado_siguiente <= s2;
                    end if;
                else 
                    estado_siguiente <= s1;
                end if;
            when s2 =>
                if (boton = '1') then
                    if (clave = clave_correcta) then 
                        estado_siguiente <= s0;
                    else estado_siguiente <= s3;
                    end if;
                else 
                    estado_siguiente <= s2;
                end if;
            when s3 =>  
                if (boton = '1') then
                    if (clave = clave_correcta) then 
                        estado_siguiente <= s0;
                    else estado_siguiente <= s4;
                    end if;
                else 
                    estado_siguiente <= s3;
                end if;
            when others =>        
                estado_siguiente <= s4; 
                -- Solo se sale del bloqueo con el reset.
        end case; 
     end process estados_comb;
      
     salidas: process (estado_actual, boton)
     begin 
        case estado_actual is 
            when s0 => 
                bloqueado <= (others => '1');
                ldisplay <= (others => '0');
                es_clave <= '1';
            when s1 => 
                bloqueado <= (others => '0');
                ldisplay <= "0011";
                es_clave <= '0';
            when s2 =>
                bloqueado <= (others=> '0');
                ldisplay <= "0010";
                es_clave <= '0';
            when s3 =>  
                bloqueado <= (others=> '0');
                ldisplay <= "0001";
                es_clave <= '0';
            when others => 
                bloqueado <= (others=> '0');
                ldisplay <= "0000";
                es_clave <= '0';       
                -- Solo se sale del bloqueo con el reset.
        end case;   
    end process salidas;        
      

end comportamiento;

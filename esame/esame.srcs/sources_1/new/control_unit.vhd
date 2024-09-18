----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 09:22:50
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    Port ( 
           clk : in std_logic;
           
           sel_A,sel_B,en_A,en_B: out std_logic:='0';
           segno: in std_logic;
           
           ab_op: in std_logic;
           ready: out std_logic
           
           );
end control_unit;

architecture Behavioral of control_unit is
type stato is (idle, load, q_waitload, sub, q_waitsub,q_out);
signal stato_corrente: stato:= idle;
begin
 process(clk) 
    begin
        if(clk = '1' and clk'event) then
            case stato_corrente is
                 when idle =>  ready <= '0';
                                if(ab_op = '1') then
                                    stato_corrente <= load;
                               else
                                    stato_corrente <= idle;
                               end if;
                               
                 when load => sel_A <= '1';
                              en_A <= '1';
                              sel_B <= '1';
                              en_B <= '1';
                              stato_corrente <= q_waitload;
                              
                 when q_waitload => stato_corrente <= sub;
                 
                 when sub =>    if(segno = '1') then
                                  sel_A <= '0';
                                  en_A <= '0'; 
                                  sel_B <= '0';
                                  en_B <= '1'; 
                                  ready <= '1';
                                  stato_corrente <= q_out;
                                else
                                  sel_A <= '0';
                                  en_A <= '1';
                                  stato_corrente <= q_waitsub;
                                end if;  
                             
                 when q_waitsub =>  en_A <= '0';
                                   stato_corrente <= sub;
                                                                
                 when q_out =>  ready <= '0'; 
                                en_B <= '0';
                                stato_corrente <= idle;
                                
                 when others => stato_corrente <= idle;
              end case;
            end if;
    end process;


end Behavioral;



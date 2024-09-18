----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 19:41:28
-- Design Name: 
-- Module Name: interfacciaA - Behavioral
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
use IEEE.math_real."log2";
use IEEE.math_real."ceil";
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interfacciaA is
    Port ( 
           clk : in std_logic;
           start : in std_logic;
           
           reset : out std_logic;
           div : in STD_LOGIC;
           incr : out STD_LOGIC;
           
           data_rom: in std_logic_vector(0 to 15);
           data1 : out std_logic_vector (0 to 15);
           syn : out STD_LOGIC;
           ack : in STD_LOGIC;
           
           read : out STD_LOGIC
           );
end interfacciaA;

architecture Behavioral of interfacciaA is

type stato is (q0,q1,q2,q3);
signal stato_prossimo: stato := q0;

begin
    process(clk) 
    begin
        if(clk = '1' and clk'event) then
            case stato_prossimo is
                when q0 =>     if(start = '1') then
                                    reset <= '1';
                                    stato_prossimo <= q1;
                                else
                                    stato_prossimo <= q0;
                                end if;
                                
                 when q1 =>     read <='1';
                                incr <= '0';
                                reset <= '0'; 
                                stato_prossimo <= q2;
                                
                 when q2 =>   if(ack = '0') then
                                read <= '0';
                                data1 <= data_rom;
                                syn <= '1';
                                stato_prossimo <= q2;
                              else
                                syn <= '0';
                                incr <= '1';
                                stato_prossimo <= q3;
                              end if;
                              
                when q3 =>   if(ack = '1') then
                                 incr <= '0';
                                 stato_prossimo <= q3;
                              else
                                 if(div = '1') then
                                    stato_prossimo <= q0;  
                                 else
                                    stato_prossimo <= q1; 
                                 end if;
                              end if;
                              
                 when others => stato_prossimo <= q0;
                 
                end case;
            end if;
    end process;


    

end Behavioral;

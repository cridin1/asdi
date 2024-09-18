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

entity interfacciaB is
    Port ( 
           clk : in std_logic;
           
           
           data1 : in std_logic_vector (0 to 15);
           data_out : out std_logic_vector (0 to 15);
           syn : in STD_LOGIC;
           ack : out STD_LOGIC;
           
           ab_op: out std_logic;
           ready: in std_logic
           
           );
end interfacciaB;

architecture Behavioral of interfacciaB is

type stato is (q0,q1,q2);
signal stato_corrente: stato := q0;
signal temp_vector: std_logic_vector (0 to 15) := (others => '0');

begin
    process(clk) 
    begin
        if(clk = '1' and clk'event) then
            case stato_corrente is
                when q0 =>      ack<= '0';
                                temp_vector <= (others => '0');
                                if(syn = '1') then
                                    ack <= '1';
                                    stato_corrente <= q1;
                                else
                                    stato_corrente <= q0;
                                end if;
                                
                 when q1 =>     temp_vector <= data1; 
                                if(syn = '1') then
                                    stato_corrente <= q1;
                                else
                                    ab_op <= '1';
                                    stato_corrente <= q2;
                                end if; 
                                
                 when q2 =>   if(ready = '0') then
                                    stato_corrente <= q2;
                              else
                                ack <= '0';
                                ab_op <= '0';
                                stato_corrente <= q0;
                              end if;
                              
                              
                 when others => stato_corrente <= q0;
                 
                end case;
            end if;
    end process;

    data_out <= temp_vector;

end Behavioral;

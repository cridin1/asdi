----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 09:11:03
-- Design Name: 
-- Module Name: buffer_dato - Behavioral
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

entity buffer_dato is
    Port ( 
           clk : in std_logic;
           output : out STD_LOGIC_VECTOR (0 to 7);
           op: in STD_LOGIC_VECTOR(0 to 7);
           en: in std_logic
           ); 
end buffer_dato;

architecture Behavioral of buffer_dato is
signal temp_dato: STD_LOGIC_VECTOR (0 to 7):= (others => '0');
begin
    process(clk)
     begin  
        if(clk = '1' and clk'event) then
            if(en = '1') then
                temp_dato <= op;
            end if;
        end if;
    end process;
   
   output <= temp_dato;
end Behavioral;

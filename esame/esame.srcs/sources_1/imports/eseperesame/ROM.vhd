----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2021 12:50:23
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( output : out STD_LOGIC_VECTOR (0 to 15):=(others => '0');
           read, clk: in STD_LOGIC
           ); 
end ROM;

architecture Behavioral of ROM is
type rom_type is array (0 to 3) of std_logic_vector(0 to 15);
signal ROM: rom_type:=("0001000100010001",
                       "0000000000010101",
                       "0001100100010001",
                       "0011111100010001");
                       
signal temp: std_logic_vector(0 to 15) := (others => '0');

begin
    
    mem: process(clk)
    variable count: integer := 0;
    begin
    if(clk='1' and clk'event) then
        if(read ='1') then
             temp <= ROM(count);
             if(count = 3) then 
                count := 0;
             else 
                count:= count+1;
             end if;
        end if;
      end if;
            
    end process;
    
    output <= temp;

end Behavioral;

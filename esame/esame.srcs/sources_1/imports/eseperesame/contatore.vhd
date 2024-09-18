----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2021 14:00:29
-- Design Name: 
-- Module Name: contatore - Behavioral
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
-- use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contatore is
    Generic( N:integer);
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC; 
           ab : in STD_LOGIC:='0'; 
           count: out STD_LOGIC_VECTOR(0 to integer(ceil(log2(real(N))))-1);
           div : out STD_LOGIC:='0'
           );
end contatore;

architecture Behavioral of contatore is
signal tmp: std_logic_vector(0 to integer(ceil(log2(real(N))))-1):=(others =>'0');
signal temp_div:std_logic:='0';
begin
process (clock)
    begin   
        if( clock = '1' and clock'event) then
            --div <= '0';
            if(reset = '1') then
                temp_div<= '0';
                tmp <= (others => '0');
            elsif ( ab = '1') then
                if ( tmp >= N-1) then
                    tmp <= (others => '0');
                    temp_div <= '1';
                else
                    tmp <= tmp + 1;    
                end if;                    
            end if;
        end if;
    end process;
    div <= temp_div;
    count <= tmp;
end Behavioral;

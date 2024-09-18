----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 09:11:03
-- Design Name: 
-- Module Name: sommatore - Behaviora
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sommatore is
    Port ( 
           output : out STD_LOGIC_VECTOR (0 to 7):=(others => '0');
           op1, op2: in STD_LOGIC_VECTOR(0 to 7)
           ); 
end sommatore;

architecture Behavioral of sommatore is

begin
    output <= std_logic_vector((unsigned(op1)) - (unsigned(op2)));
    
end Behavioral;

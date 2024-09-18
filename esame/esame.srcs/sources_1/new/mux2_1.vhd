----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 09:11:03
-- Design Name: 
-- Module Name: mux2_1 - Behavioral
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

entity mux2_1 is
  Port ( 
           output : out STD_LOGIC_VECTOR (0 to 7);
           op1, op2: in STD_LOGIC_VECTOR(0 to 7);
           sel: in std_logic
           );
end mux2_1;

architecture Behavioral of mux2_1 is

begin
    with sel select
    output <= op1 when '0', 
              op2 when '1',
              "--------" when others;

end Behavioral;

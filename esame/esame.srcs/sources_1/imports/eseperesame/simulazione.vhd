----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2022 16:16:56
-- Design Name: 
-- Module Name: simulazione - Behavioral
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

entity simulazione is
--  Port ( 
end simulazione;
architecture Behavioral of simulazione is
component sistemaA is
    Port (
           clk : in std_logic;
           start: in std_logic;
           syn : out STD_LOGIC;
           ack : in STD_LOGIC;
           data1 : out std_logic_vector (0 to 15)
           );
end component;

component sistemaB is
    Port ( 
           clk : in std_logic;
           syn : in STD_LOGIC;
           ack : out STD_LOGIC;
           data1 : in std_logic_vector (0 to 15)
           );
end component;

signal  clk, clk2,syn ,ack, start :  std_logic := '0';
signal data1 : std_logic_vector (0 to 15) := (others => '0');

begin
    sisA: sistemaA 
    port map(
        clk => clk,   
        start => start,       
        syn => syn,                 
        ack => ack,                          
        data1 => data1
    );
    sisB: sistemaB
    port map(
        clk => clk2,           
        syn => syn,            
        ack => ack,                           
        data1 => data1
    );
    
    process
    begin
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
    end process;
    
    process
    begin
    clk2 <= '1';
    wait for 10ns;
    clk2 <= '0';
    wait for 10ns;
    end process;
    
    
      process
    begin
    wait for 50ns;
    start <= '1';
    wait for 30ns;
    start <= '0';
    wait;
    end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 19:41:28
-- Design Name: 
-- Module Name: sistemaA - Behavioral
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

entity sistemaA is
    Port ( 
           clk : in std_logic;
           start: in std_logic;
           syn : out STD_LOGIC;
           ack : in STD_LOGIC;
           data1 : out std_logic_vector (0 to 15)
           );
end sistemaA;

architecture Behavioral of sistemaA is

component interfacciaA is
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
end component;

component contatore is
    Generic( N:integer);
    Port ( clock : in STD_LOGIC;
           ab: in std_logic;
           reset : in STD_LOGIC; 
           count: out STD_LOGIC_VECTOR(0 to 1);
           div : out STD_LOGIC:='0');
end component;

component ROM is
    Port ( output : out STD_LOGIC_VECTOR (0 to 15):=(others => '0');
           read, clk: in STD_LOGIC
           ); 
end component;



signal div,incr,read,reset: std_logic;
signal data_out: STD_LOGIC_VECTOR (0 to 15):=(others => '0');
signal count:  STD_LOGIC_VECTOR(0 to 1);
begin
     int1: interfacciaA 
     port map(
           clk => clk,
           start  => start,
           reset => reset,
           div => div,
           incr => incr,
           syn => syn,
           ack => ack,
           data_rom => data_out,
           data1 => data1,
           read => read
     );

     cont1: contatore 
           Generic map (N => 4)
           Port map ( 
               clock => clk,
               ab => incr,
               count => open,
               reset => reset,
               div => div
            );
     
      
     mem1: ROM
      port map(
        clk => clk,
        read => read,
        output => data_out
        );
        
end Behavioral;

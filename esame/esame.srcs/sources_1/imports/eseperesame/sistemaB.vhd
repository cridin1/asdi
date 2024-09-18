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
use IEEE.math_real."log2";
use IEEE.math_real."ceil";
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sistemaB is
    Port ( 
           clk : in std_logic;
           syn : in STD_LOGIC;
           ack : out STD_LOGIC;
           data1 : in std_logic_vector (0 to 15)
           );
end sistemaB;

architecture Behavioral of sistemaB is

component interfacciaB is
    Port ( 
           clk : in std_logic;
           
           
           data1 : in std_logic_vector (0 to 15);
           data_out : out std_logic_vector (0 to 15);
           syn : in STD_LOGIC;
           ack : out STD_LOGIC;
           
           ab_op: out std_logic;
           ready: in std_logic
           
           );
end component;

component control_unit is
    Port ( 
           clk : in std_logic;
           
           sel_A,sel_B,en_A,en_B: out std_logic;
           segno: in std_logic;
           
           ab_op: in std_logic;
           ready: out std_logic
           
           );
end component;

component sommatore is
    Port ( 
           output : out STD_LOGIC_VECTOR (0 to 7):=(others => '0');
           op1, op2: in STD_LOGIC_VECTOR(0 to 7)
           ); 
end component;

component buffer_dato is
    Port ( 
            clk: in std_logic;
            output : out STD_LOGIC_VECTOR (0 to 7);
           op: in STD_LOGIC_VECTOR(0 to 7);
           en: in std_logic
           ); 
end component;

component mux2_1 is
    Port ( output : out STD_LOGIC_VECTOR (0 to 7);
           op1, op2: in STD_LOGIC_VECTOR(0 to 7);
           sel: in std_logic
           ); 
end component;

signal data_out: std_logic_vector(0 to 15);
signal ab_op,ready: std_logic;
signal op1,op2: std_logic_vector(0 to 7);
signal output_sommatore: std_logic_vector(0 to 7);
signal output_muxA,output_muxB: std_logic_vector(0 to 7);
signal sel_A,sel_B,en_A,en_B: std_logic;

begin
     int1: interfacciaB
     port map(
           clk => clk,
           syn => syn,
           ack => ack,
           data1 => data1,
           data_out => data_out,
           ab_op => ab_op,
           ready => ready
     );

     
     sommatore1: sommatore 
     port map(
        op1 => op1,
        op2 => op2,
        output => output_sommatore
     );
     
     muxA: mux2_1 
     port map(
        sel => sel_A,
        op1 => output_sommatore,
        op2 => data_out(0 to 7),
        output => output_muxA
     );
     
     muxB: mux2_1 
     port map(
        sel => sel_B,
        op1 => (others => '0'),
        op2 => data_out(8 to 15),
        output => output_muxB
     );
     
    bufferA: buffer_dato
    Port map( 
           clk => clk,
           output => op1,
           op => output_muxA,
           en => en_A
           );
      
    bufferB: buffer_dato
    Port map( 
           clk => clk,
           output => op2,
           op => output_muxB,
           en => en_B
           );     
           
     control_unit1: control_unit 
     port map(
           clk => clk,
           sel_A => sel_A,
           sel_B => sel_B,
           en_A => en_A,
           en_B => en_B,
           segno => output_sommatore(0),
           ab_op => ab_op,
           ready => ready
     ); 
     
     
end Behavioral;

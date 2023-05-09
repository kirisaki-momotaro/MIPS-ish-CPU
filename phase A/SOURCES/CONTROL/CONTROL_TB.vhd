--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:57:23 04/18/2021
-- Design Name:   
-- Module Name:   C:/Users/chris/Desktop/ise_projects/HRY302_part_1/CONTROL_TB.vhd
-- Project Name:  HRY302_part_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         instr_type : OUT  std_logic_vector(2 downto 0);
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         ByteOp : OUT  std_logic;
         Mem_WrEn : OUT  std_logic;
         Reset : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALU_Bin_sel : std_logic;
   signal instr_type : std_logic_vector(2 downto 0);
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal ByteOp : std_logic;
   signal Mem_WrEn : std_logic;
   signal Reset : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Instr => Instr,
          ALU_Bin_sel => ALU_Bin_sel,
          instr_type => instr_type,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          Reset => Reset
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Instr<="10000000000000000000000000000000";
      wait for 20 ns;
		Instr<="11100000000000000000000000000000";
      wait for 20 ns;
		Instr<="11100100000000000000000000000000";
      wait for 20 ns;
		Instr<="11000000000000000000000000000000";
      wait for 20 ns;
		Instr<="11001000000000000000000000000000";
      wait for 20 ns;
		Instr<="11001100000000000000000000000000";
      wait for 20 ns;
		Instr<="11111100000000000000000000000000";
      wait for 20 ns;
		Instr<="00000000000000000000000000000000";
      wait for 20 ns;
		Instr<="00000100000000000000000000000000";
      wait for 20 ns;
		Instr<="00001100000000000000000000000000";
      wait for 20 ns;
		Instr<="00011100000000000000000000000000";
      wait for 20 ns;
		Instr<="00111100000000000000000000000000";
      wait for 20 ns;
		Instr<="01111100000000000000000000000000";
      wait for 20 ns;
      -- insert stimulus here 

      wait;
   end process;

END;

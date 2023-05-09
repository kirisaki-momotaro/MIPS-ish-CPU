----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]
-- Lab 5 - 20052020

-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   ALU
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      	
		
		A<="00000000000000000000000000000001";
		B<="00000000000000000000000000000000";
		Op<="0000";		
		wait for 100 ns;
		
		
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000000000111";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000000001010";
		B<="00000000000000000000000000001111";
		Op<="0000";
		wait for 100 ns;
		
		--test overflow
		A<="11111111111111111111111111111111";
		B<="00000000000000000000000000000011";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000011111111";
		B<="00000000000000000000000000001111";
		Op<="0001";
		wait for 100 ns;
		
		
		A<="00000000000000000000000000010101";
		B<="00000000000000000000000000010100";
		Op<="0010";
		wait for 100 ns;
		
		A<="00000000000000000000000000010101";
		B<="00000000000000000000000000001011";
		Op<="0011";
		wait for 100 ns;
		
		A<="00000000000000000000000000011111";
		B<="00000000000000000000000000000000";
		Op<="0100";
		wait for 100 ns;
		
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
		
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		Op<="0000";
		wait for 100 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

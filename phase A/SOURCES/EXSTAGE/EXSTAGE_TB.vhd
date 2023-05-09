LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY EXSTAGE_TB IS
END EXSTAGE_TB;
 
ARCHITECTURE behavior OF EXSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='1';
		ALU_func<="0000";		
		wait for 100 ns;
		
		
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		ALU_func<="0000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000000111";
		RF_B<="00000000000000000000000000000000";
		ALU_func<="0000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000001010";
		RF_B<="00000000000000000000000000001111";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
		
		--test overflow
		RF_A<="11111111111111111111111111111111";
		RF_B<="00000000000000000000000000000011";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000011111111";
		RF_B<="00000000000000000000000000001111";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0001";
		wait for 100 ns;
		
		
		RF_A<="00000000000000000000000000010101";
		RF_B<="00000000000000000000000000010100";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0010";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000010101";
		RF_B<="00000000000000000000000000001011";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0011";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000011111";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0100";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
		
		RF_A<="00000000000000000000000000000000";
		RF_B<="00000000000000000000000000000000";
		Immed<="00000000000000000000000000000001";
		ALU_Bin_sel<='0';
		ALU_func<="0000";
		wait for 100 ns;
      

      -- insert stimulus here 

      wait;
   end process;

END;

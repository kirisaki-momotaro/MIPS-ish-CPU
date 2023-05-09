----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]
-- Lab 5 - 20052020

-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   ALU
----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Decoder_5_32_TB IS
END Decoder_5_32_TB;
 
ARCHITECTURE behavior OF Decoder_5_32_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder_5_32
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Decoder_Out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Decoder_Out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder_5_32 PORT MAP (
          Awr => Awr,
          Decoder_Out => Decoder_Out
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Awr<="00101";
      wait for 100 ns;
		Awr<="11111";
      wait for 100 ns;
		Awr<="00000";
      wait for 100 ns;
		Awr<="10101";
      wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.Numeric_Std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
 
ARCHITECTURE behavior OF MEMSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(10 downto 0);
         MM_WrEn : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrEn : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;			
		ByteOp<='0';
		Mem_WrEn<='1';
		ALU_MEM_Addr<=x"00000000";
		MEM_DataIn<=x"afafafaf";		
       wait for 100 ns;	
		ByteOp<='0';
		Mem_WrEn<='1';
		ALU_MEM_Addr<=x"00000008";
		MEM_DataIn<=x"fafafafa";		
       wait for 100 ns;	
		ByteOp<='1';
		Mem_WrEn<='1';
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<=x"fafafafa";		
       wait for 100 ns;	
		ByteOp<='1';
		Mem_WrEn<='0';
		ALU_MEM_Addr<=x"00000000";
		MEM_DataIn<=x"fafafafa";		
      wait for 100 ns;	
		ByteOp<='1';
		Mem_WrEn<='0';
		ALU_MEM_Addr<=x"00000008";
		MEM_DataIn<=x"fafafafa";		
       wait for 100 ns;	
		ByteOp<='1';
		Mem_WrEn<='0';
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<=x"fafafafa";		
      wait for 100 ns;	
		
		ALU_MEM_Addr<=x"00000000";
		for i in 0 to 30 loop
		ByteOp<='1';
		Mem_WrEn<='0';
		ALU_MEM_Addr<=ALU_MEM_Addr+"100";
		MEM_DataIn<=x"fafafafa";		
       wait for 100 ns;	
		end loop;
      

      -- insert stimulus here 

      wait;
   end process;

END;

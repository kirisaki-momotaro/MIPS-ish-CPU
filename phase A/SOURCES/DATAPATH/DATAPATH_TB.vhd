
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Clk : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         ALU_zero : OUT  std_logic;
         RST : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         instr_type : IN  std_logic_vector(2 downto 0);
         PC : OUT  std_logic_vector(31 downto 0);
         MEM_instruction : IN  std_logic_vector(31 downto 0);
         MEM_write_data_address : OUT  std_logic_vector(10 downto 0);
         MEM_write_enable_data : OUT  std_logic_vector(31 downto 0);
         MEM_return_data : IN  std_logic_vector(31 downto 0);
         MEM_data_to_write : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal instr_type : std_logic_vector(2 downto 0) := (others => '0');
   signal MEM_instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_return_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALU_zero : std_logic;
   signal PC : std_logic_vector(31 downto 0);
   signal MEM_write_data_address : std_logic_vector(10 downto 0);
   signal MEM_write_enable_data : std_logic_vector(31 downto 0);
   signal MEM_data_to_write : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Clk => Clk,
          ALU_Bin_sel => ALU_Bin_sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          ALU_zero => ALU_zero,
          RST => RST,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          instr_type => instr_type,
          PC => PC,
          MEM_instruction => MEM_instruction,
          MEM_write_data_address => MEM_write_data_address,
          MEM_write_enable_data => MEM_write_enable_data,
          MEM_return_data => MEM_return_data,
          MEM_data_to_write => MEM_data_to_write
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST<='1';
      wait for 100 ns;			 
         ALU_Bin_sel<='1';--immed
			instr_type<="001";
         RF_WrEn<='1';
         RF_WrData_sel<='0';
         RF_B_sel<='1'; --dont care
         ImmExt<="00";       
         RST<='0';
			 
			
         PC_sel<='0';--dont care
         PC_LdEn<='0';--dont care
         ByteOp<='0';--dont care
         Mem_WrEn<='0';--dont care
               
         MEM_instruction<="00000000000000010000000000000011";        
         MEM_return_data<=x"00000000";--dont care
      wait for Clk_period*10;
		ALU_Bin_sel<='1';--immed
			instr_type<="001";
         RF_WrEn<='1';
         RF_WrData_sel<='0';
         RF_B_sel<='1'; --dont care
         ImmExt<="00";       
         RST<='0';
			 
			
         PC_sel<='0';--dont care
         PC_LdEn<='0';--dont care
         ByteOp<='0';--dont care
         Mem_WrEn<='0';--dont care
               
         MEM_instruction<="00000000000000110000000000000111";         
         MEM_return_data<=x"00000000";--dont care
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

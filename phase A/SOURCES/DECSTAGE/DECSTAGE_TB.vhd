LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECODE_TB IS
END DECODE_TB;
 
ARCHITECTURE behavior OF DECODE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECODE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECODE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      wait for 100 ns;	
		Instr<="00000000000000010000000000000000"; 
		RF_WrEn<='1';
		ALU_out<=x"aaaaaaaa";		
		MEM_out<=x"ffffffff";
		RF_WrData_sel<='0'; --alu
		RF_B_sel<='1'; --write register
		ImmExt<="11";
      wait for Clk_period*5;
		Instr<="00000000000000110000000000000000"; 
		RF_WrEn<='1';
		ALU_out<=x"aaaaaaaa";		
		MEM_out<=x"ffffffff";
		RF_WrData_sel<='1'; --mem
		RF_B_sel<='1'; --write register
		ImmExt<="11";
      wait for Clk_period*5;
		Instr<="00000000001000111111111111111111"; 
		RF_WrEn<='0';
		ALU_out<=x"aaaaaaaa";		
		MEM_out<=x"ffffffff";
		RF_WrData_sel<='1'; --mem
		RF_B_sel<='1'; --write register
		ImmExt<="00";
      wait for Clk_period*5;
		Instr<="00000000001000111111111111111111"; 
		RF_WrEn<='0';
		ALU_out<=x"aaaaaaaa";		
		MEM_out<=x"ffffffff";
		RF_WrData_sel<='1'; --mem
		RF_B_sel<='1'; --write register
		ImmExt<="01";
      wait for Clk_period*5;
		Instr<="00000000001000111111111111111111"; 
		RF_WrEn<='0';
		ALU_out<=x"aaaaaaaa";		
		MEM_out<=x"ffffffff";
		RF_WrData_sel<='1'; --mem
		RF_B_sel<='1'; --write register
		ImmExt<="10";
      wait for Clk_period*5;
      -- insert stimulus here 

      wait;
   end process;

END;

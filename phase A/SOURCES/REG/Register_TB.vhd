LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Register_TB IS
END Register_TB;
 
ARCHITECTURE behavior OF Register_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cpu_Register
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cpu_Register PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          Datain => Datain,
          Dataout => Dataout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
		RST<='1';
		WE<='1';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='0';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='1';
		Datain<=x"0000aaaf";
      wait for CLK_period*10;
		RST<='0';
		WE<='1';
		Datain<=x"ffffffff";
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

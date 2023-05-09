library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--author--IOANNIDIS CHRISTOS 2018030006

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
signal PC_Immed_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal plus4_out:STD_LOGIC_VECTOR (31 downto 0);
signal immed_out:STD_LOGIC_VECTOR (31 downto 0);
signal PC_out:STD_LOGIC_VECTOR (31 downto 0);
signal MUX_Output:STD_LOGIC_VECTOR (31 downto 0);

component Cpu_Register is
	 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component plus4_Adder is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_2_to_1 is
    Port ( PC_plus_4 : in  STD_LOGIC_VECTOR (31 downto 0);
				PC_sel: in  STD_LOGIC;
           PC_Immed_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC_Immed_Adder is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			PC_plus_four : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
begin
PC_Immed_tmp<=PC_Immed(29 downto 0)&"00";
Program_Counter:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>Reset,WE=>PC_LdEn
	,Datain=>MUX_Output,Dataout=>PC_out);
	
plus4:plus4_Adder
	PORT MAP(input=>PC_out,output=>plus4_out);
	
immed:PC_Immed_Adder
	PORT MAP(PC_Immed=>PC_Immed_tmp,PC_plus_four=>plus4_out
	,output=>immed_out);
MUX:MUX_2_to_1
	PORT MAP(PC_plus_4=>plus4_out,PC_sel=>PC_sel
	,PC_Immed_out=>immed_out,MUX_Output=>MUX_Output);
	
PC<=PC_out;
end Behavioral;


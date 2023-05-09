
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--author--IOANNIDIS CHRISTOS 2018030006

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is
signal MUX_out:STD_LOGIC_VECTOR (31 downto 0);
signal Ovf :STD_LOGIC;
signal Cout :STD_LOGIC;

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

component MUX_ALU is
    Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC);
end component;
begin

ALU_Instance:ALU
	PORT MAP(A=>RF_A,b=>MUX_out,Op=>ALU_func
	,Output=>ALU_out,Zero=>ALU_zero,Cout=>Cout,Ovf=>Ovf);

MUX:MUX_ALU
	PORT MAP(RF_B=>RF_B,Immed=>Immed,MUX_out=>MUX_out
	,ALU_Bin_sel=>ALU_Bin_sel);
end Behavioral;


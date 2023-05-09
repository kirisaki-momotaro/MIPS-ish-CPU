----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]
-- 

-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   RF
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is
--variables
signal Decoder_Output :STD_LOGIC_VECTOR(31 DOWNTO 0);
signal Write_Enable :STD_LOGIC_VECTOR(31 DOWNTO 0);
type Register_Output is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal Reg_Out : Register_Output;


--components
component And_Gate_32 is
	 Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Enable : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Cpu_Register is
	 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Decoder_5_32 is
	Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Decoder_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_32 is
	Port (reg0 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg1 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg2 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg3 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg4 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg5 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg6 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg7 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg8 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg9 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg10 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg11 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg12 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg13 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg14 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg15 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg16 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg17 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg18 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg19 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg20 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg21 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg22 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg23 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg24 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg25 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg26 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg27 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg28 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg29 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg30 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg31 : in  STD_LOGIC_VECTOR (31 downto 0);	 
			  MUX_Output: out  STD_LOGIC_VECTOR (31 downto 0);	
           Ard : in  STD_LOGIC_VECTOR (4 downto 0));
end component;



--initialisations
begin
decoder :Decoder_5_32 
	PORT MAP(Awr=>Awr,Decoder_Out=>Decoder_Output);


and_for_enable:And_Gate_32
	PORT MAP(Input=>Decoder_Output,Enable=>WrEn,Output=>Write_Enable);
	
	
mux1:MUX_32
	PORT MAP(reg0=>Reg_Out(0),
		reg1=>Reg_Out(1),
		reg2=>Reg_Out(2),
		reg3=>Reg_Out(3),
		reg4=>Reg_Out(4),
		reg5=>Reg_Out(5),
		reg6=>Reg_Out(6),
		reg7=>Reg_Out(7),
		reg8=>Reg_Out(8),
		reg9=>Reg_Out(9),
		reg10=>Reg_Out(10),		
		reg11=>Reg_Out(11),
		reg12=>Reg_Out(12),
		reg13=>Reg_Out(13),
		reg14=>Reg_Out(14),
		reg15=>Reg_Out(15),
		reg16=>Reg_Out(16),
		reg17=>Reg_Out(17),
		reg18=>Reg_Out(18),
		reg19=>Reg_Out(19),		
		reg20=>Reg_Out(20),
		reg21=>Reg_Out(21),
		reg22=>Reg_Out(22),
		reg23=>Reg_Out(23),
		reg24=>Reg_Out(24),
		reg25=>Reg_Out(25),
		reg26=>Reg_Out(26),
		reg27=>Reg_Out(27),
		reg28=>Reg_Out(28),
		reg29=>Reg_Out(29),
		reg30=>Reg_Out(30),
		reg31=>Reg_Out(31),
		
		MUX_Output=>Dout1,
		Ard=>Ard1);
		
mux2:MUX_32
	PORT MAP(reg0=>Reg_Out(0),
		reg1=>Reg_Out(1),
		reg2=>Reg_Out(2),
		reg3=>Reg_Out(3),
		reg4=>Reg_Out(4),
		reg5=>Reg_Out(5),
		reg6=>Reg_Out(6),
		reg7=>Reg_Out(7),
		reg8=>Reg_Out(8),
		reg9=>Reg_Out(9),
		reg10=>Reg_Out(10),		
		reg11=>Reg_Out(11),
		reg12=>Reg_Out(12),
		reg13=>Reg_Out(13),
		reg14=>Reg_Out(14),
		reg15=>Reg_Out(15),
		reg16=>Reg_Out(16),
		reg17=>Reg_Out(17),
		reg18=>Reg_Out(18),
		reg19=>Reg_Out(19),		
		reg20=>Reg_Out(20),
		reg21=>Reg_Out(21),
		reg22=>Reg_Out(22),
		reg23=>Reg_Out(23),
		reg24=>Reg_Out(24),
		reg25=>Reg_Out(25),
		reg26=>Reg_Out(26),
		reg27=>Reg_Out(27),
		reg28=>Reg_Out(28),
		reg29=>Reg_Out(29),
		reg30=>Reg_Out(30),
		reg31=>Reg_Out(31),
		
		MUX_Output=>Dout2,
		Ard=>Ard2);
--registers
register0:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(0)
	,Datain=>x"00000000",Dataout=>Reg_Out(0));

register1:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(1)
	,Datain=>Din,Dataout=>Reg_Out(1));
	
register2:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(2)
	,Datain=>Din,Dataout=>Reg_Out(2));
	
register3:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(3)
	,Datain=>Din,Dataout=>Reg_Out(3));
	
register4:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(4)
	,Datain=>Din,Dataout=>Reg_Out(4));
	
register5:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(5)
	,Datain=>Din,Dataout=>Reg_Out(5));
	
register6:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(6)
	,Datain=>Din,Dataout=>Reg_Out(6));
	
register7:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(7)
	,Datain=>Din,Dataout=>Reg_Out(7));
	
register8:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(8)
	,Datain=>Din,Dataout=>Reg_Out(8));
	
register9:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(9)
	,Datain=>Din,Dataout=>Reg_Out(9));
	
register10:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(10)
	,Datain=>Din,Dataout=>Reg_Out(10));	

register11:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(11)
	,Datain=>Din,Dataout=>Reg_Out(11));
	
register12:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(12)
	,Datain=>Din,Dataout=>Reg_Out(12));
	
register13:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(13)
	,Datain=>Din,Dataout=>Reg_Out(13));
	
register14:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(14)
	,Datain=>Din,Dataout=>Reg_Out(14));
	
register15:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(15)
	,Datain=>Din,Dataout=>Reg_Out(15));
	
register16:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(16)
	,Datain=>Din,Dataout=>Reg_Out(16));
	
register17:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(17)
	,Datain=>Din,Dataout=>Reg_Out(17));
	
register18:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(18)
	,Datain=>Din,Dataout=>Reg_Out(18));
	
register19:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(19)
	,Datain=>Din,Dataout=>Reg_Out(19));
	
register20:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(20)
	,Datain=>Din,Dataout=>Reg_Out(20));

register21:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(21)
	,Datain=>Din,Dataout=>Reg_Out(21));
	
register22:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(22)
	,Datain=>Din,Dataout=>Reg_Out(22));
	
register23:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(23)
	,Datain=>Din,Dataout=>Reg_Out(23));
	
register24:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(24)
	,Datain=>Din,Dataout=>Reg_Out(24));
	
register25:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(25)
	,Datain=>Din,Dataout=>Reg_Out(25));
	
register26:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(26)
	,Datain=>Din,Dataout=>Reg_Out(26));
	
register27:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(27)
	,Datain=>Din,Dataout=>Reg_Out(27));
	
register28:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(28)
	,Datain=>Din,Dataout=>Reg_Out(28));
	
register29:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(29)
	,Datain=>Din,Dataout=>Reg_Out(29));
	
register30:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(30)
	,Datain=>Din,Dataout=>Reg_Out(30));
	
register31:Cpu_Register
	PORT MAP(CLK=>CLK,RST=>RST,WE=>Write_Enable(31)
	,Datain=>Din,Dataout=>Reg_Out(31));
	

--Generate_Registers:for n in  31 downto 0 generate Cpu_Registers:Cpu_Register
--	port map(CLK=>CLK,RST=>RST,WE=>Write_Enable(n)
--	,Datain=>Din,Dataout=>Reg_Out(n));
--end generate Generate_Registers;



end Behavioral;


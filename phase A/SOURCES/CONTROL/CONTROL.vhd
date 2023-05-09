
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

entity CONTROL is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			   
				
				
				ALU_Bin_sel : out  STD_LOGIC;--0 RFB,1 IMMED
				instr_type : out STD_LOGIC_VECTOR (2 downto 0); 
				RF_WrEn : out  STD_LOGIC;--write on register
				RF_WrData_sel  : out  STD_LOGIC; --0 write result from,1 write result from memory
				RF_B_sel : out  STD_LOGIC;--0 RB<- rd,1 RB<-rs				
				ImmExt  : out  STD_LOGIC_VECTOR (1 downto 0); --00 sign extend,					
				PC_sel : out  STD_LOGIC;--0 -> pc+4 1-> immediate
				PC_LdEn : out STD_LOGIC;--write in pc register
				ByteOp : out  STD_LOGIC;							
				Mem_WrEn : out  STD_LOGIC;
				
				Reset : out  STD_LOGIC
				
	 
	 );
end CONTROL;


architecture Behavioral of CONTROL is
signal Opcode:STD_LOGIC_VECTOR(5 downto 0);
signal func:STD_LOGIC_VECTOR(5 downto 0);
signal rs:STD_LOGIC_VECTOR(4 downto 0);
signal rt:STD_LOGIC_VECTOR(4 downto 0);
signal rd:STD_LOGIC_VECTOR(4 downto 0);
signal immediate:STD_LOGIC_VECTOR(15 downto 0);
signal instruction:STD_LOGIC_VECTOR(31 downto 0);

begin
	process(Instr,Opcode,func,rs,rd,rt,instruction)
		begin

instruction<=Instr;
Opcode<=instruction(31 downto 26);
rs<=instruction(25 downto 21);
rd<=instruction(20 downto 16);
rt<=instruction(15 downto 11);
func<=instruction(5 downto 0);
immediate<=instruction(15 downto 0);


case Opcode is
	--normal operations
	when "100000"=>
		ALU_Bin_sel<='0';
		instr_type<="111";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--li
	when "111000"=>
		ALU_Bin_sel<='1';
		instr_type<="000";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--lui
	when "111001"=>
		ALU_Bin_sel<='1';
		instr_type<="000";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="10";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--addi
	when "110000"=>
		ALU_Bin_sel<='1';
		instr_type<="001";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--nandi	
	when "110010"=>
		ALU_Bin_sel<='1';
		instr_type<="011";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="10";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';	
	--ori
	when "110011"=>
		ALU_Bin_sel<='1';
		instr_type<="010";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="10";
		PC_sel<='0';
		PC_LdEn<='1';	
		ByteOp<='0';
		Mem_WrEn<='0';
	--branch(b)	
	when "111111"=>
		ALU_Bin_sel<='1';
		instr_type<="111";
		RF_WrEn<='0';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='1';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--beq
	when "000000"=>
		ALU_Bin_sel<='1';
		instr_type<="111";
		RF_WrEn<='0';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="00";
		
		if(rs=rd) then 
			PC_sel<='1'; 
		else 
			PC_sel<='0';
		end if;
		
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--bne
	when "000001"=>
		ALU_Bin_sel<='1';
		instr_type<="111";
		RF_WrEn<='0';
		RF_WrData_sel<='0';
		RF_B_sel<='1';
		ImmExt<="00";
		
		if(rs=rd) then 
			PC_sel<='0';
		else 
			PC_sel<='1'; 
		end if;
		
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--lb
	when "000011"=>
		ALU_Bin_sel<='1';
		instr_type<="001";
		RF_WrEn<='1';
		RF_WrData_sel<='1';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='1';
		Mem_WrEn<='0';
	--sw	
	when "000111"=>
		ALU_Bin_sel<='1';
		instr_type<="001";
		RF_WrEn<='0';
		RF_WrData_sel<='1';
		RF_B_sel<='0';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='1';
		Mem_WrEn<='1';
	--lw	
	when "001111"=>
		ALU_Bin_sel<='1';
		instr_type<="001";
		RF_WrEn<='1';
		RF_WrData_sel<='1';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
	--sw	
	when "011111"=>
		ALU_Bin_sel<='1';
		instr_type<="001";
		RF_WrEn<='0';
		RF_WrData_sel<='1';
		RF_B_sel<='1';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='1';
	
	when others=>
		ALU_Bin_sel<='1';
		instr_type<="000";
		RF_WrEn<='0';
		RF_WrData_sel<='1';
		RF_B_sel<='0';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
		
end case;
	

end process;
end Behavioral;


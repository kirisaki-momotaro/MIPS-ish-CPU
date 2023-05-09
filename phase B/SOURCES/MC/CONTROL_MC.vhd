library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CONTROL_MC is
    Port ( 
				
				
	 Instr : in  STD_LOGIC_VECTOR (31 downto 0);
	 
				--MC
				State : in  STD_LOGIC_VECTOR (3 downto 0);
			   Next_State : out  STD_LOGIC_VECTOR (3 downto 0);
				--MC
				
				
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
				
				Reset : out  STD_LOGIC;
				
				--MC
				instruction_register_write_enable:out STD_LOGIC
				
	 
	 );
end CONTROL_MC;


architecture Behavioral of CONTROL_MC is
signal Opcode:STD_LOGIC_VECTOR(5 downto 0);
signal func:STD_LOGIC_VECTOR(5 downto 0);
signal rs:STD_LOGIC_VECTOR(4 downto 0);
signal rt:STD_LOGIC_VECTOR(4 downto 0);
signal rd:STD_LOGIC_VECTOR(4 downto 0);
signal immediate:STD_LOGIC_VECTOR(15 downto 0);
signal instruction:STD_LOGIC_VECTOR(31 downto 0);


--MC
signal Next_State_tmp : STD_LOGIC_VECTOR (3 downto 0);
signal branch_performed: STD_LOGIC;
--MC



begin
	process(Instr,Opcode,func,rs,rd,rt,instruction,State)
	begin
	branch_performed<='0';
	instruction<=Instr;
	Opcode<=instruction(31 downto 26);
	rs<=instruction(25 downto 21);
	rd<=instruction(20 downto 16);
	rt<=instruction(15 downto 11);
	func<=instruction(5 downto 0);
	immediate<=instruction(15 downto 0);

	if(State="0000") then   --INSTRUCTION TYPE UNKNOWN
		ALU_Bin_sel<='1';
		instr_type<="000";
		RF_WrEn<='0';
		RF_WrData_sel<='1';
		RF_B_sel<='0';
		ImmExt<="00";
		if(branch_performed='1') then
			PC_sel<='1';					
		else
			PC_sel<='0';			
		end if;
		PC_LdEn<='1';
		ByteOp<='0';
		Mem_WrEn<='0';
		instruction_register_write_enable<='1';
		
		Next_State<="0001";
		
	elsif(State="0001") then
		branch_performed<='0';
		ALU_Bin_sel<='1';
		instr_type<="000";
		RF_WrEn<='0';
		RF_WrData_sel<='1';
		RF_B_sel<='0';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='0';--the only change
		ByteOp<='0';
		Mem_WrEn<='0';
		instruction_register_write_enable<='0';	
		if ((Opcode="100000") or (Opcode="111000") or (Opcode="111001") 
		or (Opcode="110000") or (Opcode="110010") or (Opcode="110011")) then--if R-TYPE
			Next_State<="0100";	
		elsif((Opcode="000011") or (Opcode="011111") or (Opcode="001111") or (Opcode="000111")) then
			Next_State<="1100";
		elsif((Opcode="111111") or (Opcode="000001") or (Opcode="000000")) then
			Next_State<="1000";
		end if;

							--INSTRUCTION TYPE KNOWN
		
	elsif(State="0100") then-------(0-1)(INSTRUCTION TYPE)-(0-0)<=step number   (0-1)=>R-TYPE

		case Opcode is
			--normal operations(R_TYPE)
			when "100000"=>
				ALU_Bin_sel<='0';
				instr_type<="111";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';-----
				ByteOp<='0';
				Mem_WrEn<='0';
				
				
			
			--li
			when "111000"=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
			--lui
			when "111001"=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				ImmExt<="10";
				PC_sel<='0';
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
			--addi
			when "110000"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
			--nandi	
			when "110010"=>
				ALU_Bin_sel<='1';
				instr_type<="011";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				ImmExt<="10";
				PC_sel<='0';
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';	
			--ori
			when "110011"=>
				ALU_Bin_sel<='1';
				instr_type<="010";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				ImmExt<="10";
				PC_sel<='0';
				PC_LdEn<='0';	
				ByteOp<='0';
				Mem_WrEn<='0';
			when others=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
			end case;	
				
				
				Next_State<="0101";
				
		
		
		
elsif(State="0101") then
		case Opcode is
	--normal operations(R_TYPE)
	when "100000"=>
		ALU_Bin_sel<='0';
		instr_type<="111";
		RF_WrEn<='1';
		RF_WrData_sel<='0';
		RF_B_sel<='0';
		ImmExt<="00";
		PC_sel<='0';
		PC_LdEn<='0';-----
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
		PC_LdEn<='0';
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
		PC_LdEn<='0';
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
		PC_LdEn<='0';
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
		PC_LdEn<='0';
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
		PC_LdEn<='0';	
		ByteOp<='0';
		Mem_WrEn<='0';
	when others=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
	end case;
		
		
		Next_State<="0000";	--reset cycle

	elsif(State="1000") then------branch
			case Opcode is
				when "111111"=>
				ALU_Bin_sel<='1';
				instr_type<="111";
				RF_WrEn<='0';
				RF_WrData_sel<='0';
				RF_B_sel<='1';
				branch_performed<='1';
				ImmExt<="00";
				PC_sel<='1';
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';
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
					branch_performed<='1';
				else 
					PC_sel<='0';
				end if;
				
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';
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
					branch_performed<='1';
				end if;
				
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';
			when others=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
			end case;
			Next_State<="0000";	--reset cycle
	
	
	
	
	
	elsif(State="1100") then  -------load store
		case Opcode is
		when "000011"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
				ByteOp<='1';
				Mem_WrEn<='0';
			--lw	
			when "001111"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
			when others=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
		end case;
		Next_State<="1101";	

	elsif(State="1101") then
		case Opcode is
		when "000011"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
				ByteOp<='1';
				Mem_WrEn<='1';
			--lw	
			when "001111"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
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
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
		end case;
		Next_State<="1110";	

	elsif(State="1110") then
		case Opcode is
		when "000011"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='1';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
				ByteOp<='1';
				Mem_WrEn<='0';
			--lw	
			when "001111"=>
				ALU_Bin_sel<='1';
				instr_type<="001";
				RF_WrEn<='1';
				RF_WrData_sel<='1';
				RF_B_sel<='1';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';
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
				PC_LdEn<='0';
				ByteOp<='0';
				Mem_WrEn<='0';
			when others=>
				ALU_Bin_sel<='1';
				instr_type<="000";
				RF_WrEn<='0';
				RF_WrData_sel<='1';
				RF_B_sel<='0';
				ImmExt<="00";
				PC_sel<='0';
				PC_LdEn<='0';--the only change
				ByteOp<='0';
				Mem_WrEn<='0';
				instruction_register_write_enable<='0';	
		end case;
		Next_State<="0000";	--reset state
	end if;









	

end process;
end Behavioral;


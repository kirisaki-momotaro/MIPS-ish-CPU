library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity RAM is
	port (
		clk : in std_logic;
		inst_addr : in std_logic_vector(10 downto 0);
		inst_dout : out std_logic_vector(31 downto 0);
		data_we : in std_logic;
		data_addr : in std_logic_vector(10 downto 0);
		data_din : in std_logic_vector(31 downto 0);
		data_dout : out std_logic_vector(31 downto 0);
		byte_operation : in std_logic_vector(31 downto 0));
	end RAM;
	
architecture syn of RAM is
	 type ram_type is array (2047 downto 0) of std_logic_vector (31 downto 0);

	 impure function InitRamFromFile (RamFileName : in string) return ram_type is
	 FILE ramfile : text is in RamFileName;
	 variable RamFileLine : line;
	 variable ram : ram_type;
	 begin
		for i in 0 to 1023 loop
			readline(ramfile, RamFileLine);
			read (RamFileLine, ram(i));
		end loop;
		for i in 1024 to 2047 loop
			ram(i) := x"00000000";
		end loop;
	 return ram;
	 end function;
	 
	 signal RAM: ram_type := InitRamFromFile("rom.data");
	 
	 signal data_contents:std_logic_vector(31 downto 0);
	 signal byte_mask:std_logic_vector(31 downto 0);
	 begin
		process (clk)
			begin
				 data_contents<=((RAM(conv_integer(data_addr))) and ("11111111111111111111111111111111"-byte_operation));			 
				 byte_mask<=data_din and byte_operation;
				 if clk'event and clk = '1' then
				 --if clk = '1' then
				 if data_we = '1' then
				 
 				 
				 RAM(conv_integer(data_addr)) <= data_contents or byte_mask;
				 end if;
				 end if;
				 end process;
				 data_dout <= RAM(conv_integer(data_addr));
				 inst_dout <= RAM(conv_integer(inst_addr));
	end syn;
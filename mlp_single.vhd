LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;
use work.all;

------------------------------------------------------------------
-- define main entity
------------------------------------------------------------------
entity mlp_single is
	generic(N : integer := 3;
			M : integer := 3;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port ( clk : in std_logic;
           nrst : in std_logic;
		   X : in fixedpoint(N-1 downto 0);
		   output : out fixedpoint(N-1 downto 0));
end mlp_single;

architecture Behavioral of mlp_single is

component neuron is
	generic(N : integer;
			intpart : integer;
			fracpart : integer);
    Port ( clk : in std_logic;
           nrst : in std_logic;
           b : in sfixed (intpart-1 downto fracpart);
		   W : in fixedpoint(N-1 downto 0);
		   X : in fixedpoint(N-1 downto 0);
		   result : out sfixed(intpart-1 downto fracpart));
end component;

component fsm is
	generic(N : integer;
			M : integer;
			intpart : integer;
			fracpart : integer);
    Port ( clk : in std_logic;
           nrst : in std_logic;
		   -- output
		   weight_rom_enable : out std_logic;
		   weight_rom_address_M : out integer;
		   weight_rom_address_N : out integer;
		   data_enable : out std_logic;
		   data_address : out integer;
		   feedback_enable : out std_logic;
		   feedback_address_N : out integer;
		   feedback_address_M : out integer;
		   end_state : out std_logic);
end component;

component weight_rom is
	generic(N : integer;
			M : integer;
			intpart : integer;
			fracpart : integer);
    Port ( -- input
		   weight_rom_enable : in std_logic;
		   weight_rom_address_M : in integer;
		   weight_rom_address_N : in integer;
		   -- output
		   weight_output : out fixedpoint(N downto 0));
end component;

component data_ram is
	generic(N : integer;
			M : integer;
			intpart : integer;
			fracpart : integer);
    Port ( -- input
		   X_input : in fixedpoint(N-1 downto 0);
		   data_enable : in std_logic;
		   data_address : in integer;
		   feedback_enable : in std_logic;
		   feedback_address_N : in integer;
		   feedback_address_M : in integer;
		   feedback : in sfixed (intpart-1 downto fracpart);
		   -- output
		   X_output : out fixedpoint(N-1 downto 0));
end component;

signal weight_rom_enable_buf : std_logic;
signal weight_rom_address_M_buf : integer;
signal weight_rom_address_N_buf : integer;
signal data_enable_buf : std_logic;
signal data_address_buf : integer;
signal feedback_enable_buf : std_logic;
signal feedback_address_N_buf : integer;
signal feedback_address_M_buf : integer;
signal end_state_buf : std_logic;

signal weight_output_buf : fixedpoint(N downto 0);

signal feedback_buf : sfixed (intpart-1 downto fracpart);
signal X_output_buf : fixedpoint(N-1 downto 0);

begin

FSM_INS: fsm generic map(N=>N,M=>M,intpart=>intpart,fracpart=>fracpart)
		port map(clk=>clk,nrst=>nrst,
				weight_rom_enable =>weight_rom_enable_buf, 
				weight_rom_address_M => weight_rom_address_M_buf,
				weight_rom_address_N => weight_rom_address_N_buf,
				data_enable => data_enable_buf,
				data_address => data_address_buf,
				feedback_enable => feedback_enable_buf,
				feedback_address_N => feedback_address_N_buf,
				feedback_address_M => feedback_address_M_buf,
				end_state => end_state_buf);

WEIGHT_ROM_INS: weight_rom generic map (N=>N,M=>M,intpart=>intpart,fracpart=>fracpart)
				port map(weight_rom_enable=>weight_rom_enable_buf,
						weight_rom_address_M => weight_rom_address_M_buf,
						weight_rom_address_N => weight_rom_address_N_buf,
						weight_output => weight_output_buf);
						
DATA_RAM_INS: data_ram generic map(N=>N,M=>M,intpart=>intpart,fracpart=>fracpart)
			port map (X_input => X, data_enable=>data_enable_buf,data_address=>data_address_buf,
					feedback_enable=>feedback_enable_buf,feedback_address_N=>feedback_address_N_buf,
					feedback_address_M => feedback_address_M_buf, feedback=>feedback_buf,
					X_output=>X_output_buf);
					
NEURON_INS: neuron generic map(N=>N,intpart=>intpart,fracpart=>fracpart)
			port map(clk=>clk,nrst=>nrst,
					b=>weight_output_buf(0), W=>weight_output_buf(N downto 1), X=>X_output_buf,
					result=>feedback_buf);

output <= X_output_buf when end_state_buf = '1' else (others=> (others=>'0'));

end Behavioral;

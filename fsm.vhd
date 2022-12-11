------------------------------------------------------------------
-- Main program for fsm.vhd
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity fsm is
	generic(N : integer := 3;
			M : integer := 3;
			intpart : integer := 12;
			fracpart : integer := 20);
    Port ( clk : in std_logic;
           nrst : in std_logic;
		   -- input
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
end fsm;

architecture Behavioral of fsm is
type state_type is (init, send_data, store_data, finish); --type of state machine
signal state: state_type := init;

signal data_address_buf, weight_rom_address_M_buf, weight_rom_address_N_buf, feedback_address_N_buf, feedback_address_M_buf : integer;

begin

process(clk, nrst)
begin
	if(nrst = '1') then
		state <= init; -- default state on reset
	elsif (rising_edge(clk)) then
		case state is
			when init =>
				state <= send_data;
				weight_rom_enable <= '0';
				data_enable <= '0';
				feedback_enable <= '0';
				data_address_buf <= 0;
				weight_rom_address_M_buf <= 0;
				weight_rom_address_N_buf <= 0;
				feedback_address_N_buf <= 0;
				feedback_address_M_buf <= 1;
				end_state <= '0';
			when send_data =>
				-- control signal
				weight_rom_enable <= '1';
				data_enable <= '1';
				feedback_enable <= '0';
				-- ouput signal
				data_address <= data_address_buf;
				weight_rom_address_M <= weight_rom_address_M_buf;
				weight_rom_address_N <= weight_rom_address_N_buf;
				
				state <= store_data;
			when store_data => 
				-- control signal
				weight_rom_enable <= '0';
				data_enable <= '0';
				feedback_enable <= '1';
				-- ouput signal
				feedback_address_N <= feedback_address_N_buf;
				feedback_address_M <= feedback_address_M_buf;
				if feedback_address_N_buf < N-1 then
					feedback_address_N_buf <= feedback_address_N_buf + 1;
					weight_rom_address_N_buf <= weight_rom_address_N_buf + 1;
					state <= send_data;
				else
					if feedback_address_M_buf < M-1 then
						feedback_address_N_buf <= 0;
						weight_rom_address_N_buf <= 0;
						feedback_address_M_buf <= feedback_address_M_buf + 1;
						data_address_buf<= data_address_buf + 1;
						weight_rom_address_M_buf <= weight_rom_address_M_buf + 1;
						state <= send_data;
					else
						state <= finish;
					end if;
				end if;
			when finish =>
				end_state <= '1';
				weight_rom_enable <= '0';
				data_enable <= '1';
				feedback_enable <= '0';
				data_address <= data_address_buf+1;
				state <= init;
		end case;
	end if;
end process;

end Behavioral;



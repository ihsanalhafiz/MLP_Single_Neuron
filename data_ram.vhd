------------------------------------------------------------------
-- Main program for fsm.vhd
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity data_ram is
	generic(N : integer := 8;
			M : integer := 8;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port (
		   -- input
		   X_input : in fixedpoint(N-1 downto 0);
		   data_enable : in std_logic;
		   data_address : in integer;
		   feedback_enable : in std_logic;
		   feedback_address_N : in integer;
		   feedback_address_M : in integer;
		   feedback : in sfixed (intpart-1 downto fracpart);
		   -- output
		   X_output : out fixedpoint(N-1 downto 0));
end data_ram;

architecture Behavioral of data_ram is

type matrix is array (natural range <>, natural range <>) of sfixed (intpart-1 downto fracpart);
signal memory_data: matrix(0 to M-1, 0 to N-1) ; -- N data (X and bias)
constant zero : sfixed (intpart-1 downto fracpart) := to_sfixed(0,intpart-1,fracpart);

begin

OUTPUT_PROCESS: process(data_enable)
begin
	if data_enable = '1' then
		for i in 0 to N-1 loop
			if data_address = 0 then
				X_output(i) <= X_input(i);
			else
				X_output(i) <= memory_data(data_address, i);
			end if;
		end loop;
	else
		for i in 0 to N-1 loop
			X_output(i) <= zero;
		end loop;
	end if;
end process OUTPUT_PROCESS;

FEEDBACK_PROCESS: process(feedback_enable,feedback)
begin
	if feedback_enable = '1' then
		memory_data(feedback_address_M, feedback_address_N) <= feedback;
	end if;
end process FEEDBACK_PROCESS;

end Behavioral;
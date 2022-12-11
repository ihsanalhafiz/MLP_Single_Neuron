------------------------------------------------------------------
-- Main program for fsm.vhd
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity weight_rom is
	generic(N : integer := 8;
			M : integer := 8;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port ( 
		   -- input
		   weight_rom_enable : in std_logic;
		   weight_rom_address_M : in integer;
		   weight_rom_address_N : in integer;
		   -- output
		   weight_output : out fixedpoint(N downto 0));
end weight_rom;

architecture Behavioral of weight_rom is

type matrix is array (natural range <>, natural range <>, natural range <>) of sfixed (intpart-1 downto fracpart);
signal memory: matrix(0 to M-1, 0 to N-1, 0 to N) := (others=> (others=> (others=> (others=>'0'))));
constant zero : sfixed (intpart-1 downto fracpart) := to_sfixed(0,intpart-1,fracpart);

begin
-- memory(M,N,i) equal to M is the layer number, N is neuron number, i is the weight array index
GEN_DATA_M: for i in 0 to M-1 generate
	GEN_DATA_N: for j in 0 to N-1 generate
		GEN_DATA_N_0: for k in 0 to N generate
			memory(i,j,k) <= to_sfixed(((0.1*Real(k)) + (1.0*Real(j)) + (10.0*Real(i)) + 1.0),intpart-1,fracpart);
		end generate GEN_DATA_N_0;
	end generate GEN_DATA_N;
end generate GEN_DATA_M;

process(weight_rom_enable)
begin
	if weight_rom_enable = '1' then
		for i in 0 to N loop
			weight_output(i) <= memory(weight_rom_address_M, weight_rom_address_N, i);
		end loop;
	else
		for i in 0 to N loop
			weight_output(i) <= zero;
		end loop;
	end if;
end process;

end Behavioral;
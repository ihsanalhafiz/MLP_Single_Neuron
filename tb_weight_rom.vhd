library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity tb_weight_rom is
end entity tb_weight_rom;

architecture tb of tb_weight_rom is
	constant T : time := 10 ns; -- 100 Mhz
	constant N : integer := 3;
	constant M : integer := 3;
	constant intpart : integer := 12;
	constant fracpart : integer := -20;
	
	signal clk_s, rst_s, Write_s, weight_rom_enable : std_logic;
	
	signal address_M : integer := 0;
	signal address_N : integer := 0;
	signal weight_output : fixedpoint(N downto 0);
begin

DUT: entity work.weight_rom
	generic map(N => N, M => M, intpart => intpart, fracpart => fracpart)
	port map(weight_rom_enable => weight_rom_enable, 
			weight_rom_address_M => address_M, 
			weight_rom_address_N => address_N, 
			weight_output => weight_output);
	
	weight_rom_enable <= '1', '0' after 20 ns, '1' after 40 ns, '0' after 60 ns;
	address_N <= 2, 1 after 15 ns, 0 after 35 ns, 3 after 55 ns;
	address_M <= 0;

	clk_gen : process is
	begin
		clk_s <= '0';
		wait for T/2;
		clk_s <= '1';
		wait for T/2;
	end process clk_gen;

end architecture tb;

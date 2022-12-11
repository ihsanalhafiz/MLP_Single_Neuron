library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity tb_fsm is
end entity tb_fsm;

architecture tb of tb_fsm is
	constant T : time := 10 ns; -- 100 Mhz
	constant N : integer := 3;
	constant M : integer := 3;
	constant intpart : integer := 12;
	constant fracpart : integer := -20;
	
	signal clk_s, rst_s, Write_s, weight_rom_enable : std_logic;
	
	signal address : integer := 0;
	signal data_output : fixedpoint(N-1 downto 0);
	
	signal weight_rom_enable_buf : std_logic;
	signal weight_rom_address_M_buf : integer;
	signal weight_rom_address_N_buf : integer;
	signal data_enable_buf : std_logic;
	signal data_address_buf : integer;
	signal feedback_enable_buf : std_logic;
	signal feedback_address_N_buf : integer;
	signal feedback_address_M_buf : integer;
	
begin

DUT: entity work.fsm
	generic map(N => N, M => M, intpart => intpart, fracpart => fracpart)
	port map(clk => clk_s, nrst => rst_s,
		   weight_rom_enable => weight_rom_enable_buf,
		   weight_rom_address_M => weight_rom_address_M_buf,
		   weight_rom_address_N => weight_rom_address_N_buf,
		   data_enable => data_enable_buf,
		   data_address => data_address_buf,
		   feedback_enable => feedback_enable_buf,
		   feedback_address_N => feedback_address_N_buf,
		   feedback_address_M => feedback_address_M_buf);
	
	rst_s <= '0';

	clk_gen : process is
	begin
		clk_s <= '0';
		wait for T/2;
		clk_s <= '1';
		wait for T/2;
	end process clk_gen;

end architecture tb;


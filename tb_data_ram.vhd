library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity tb_data_ram is
end entity tb_data_ram;

architecture tb of tb_data_ram is
	constant T : time := 10 ns; -- 100 Mhz
	constant N : integer := 3;
	constant M : integer := 3;
	constant intpart : integer := 12;
	constant fracpart : integer := -20;
	
	constant X0 : sfixed (intpart-1 downto fracpart) := to_sfixed(0.3,intpart-1,fracpart);
	constant X1 : sfixed (intpart-1 downto fracpart) := to_sfixed(1.3,intpart-1,fracpart);
	constant X2 : sfixed (intpart-1 downto fracpart) := to_sfixed(2.3,intpart-1,fracpart);
	constant X3 : sfixed (intpart-1 downto fracpart) := to_sfixed(3.3,intpart-1,fracpart);
	
	constant W0 : sfixed (intpart-1 downto fracpart) := to_sfixed(0.7,intpart-1,fracpart);
	constant W1 : sfixed (intpart-1 downto fracpart) := to_sfixed(1.7,intpart-1,fracpart);
	constant W2 : sfixed (intpart-1 downto fracpart) := to_sfixed(2.7,intpart-1,fracpart);
	constant W3 : sfixed (intpart-1 downto fracpart) := to_sfixed(3.7,intpart-1,fracpart);
	
	signal clk_s, rst_s, Write_s, weight_rom_enable : std_logic;
	
	signal address : integer := 0;
	signal data_output : fixedpoint(N-1 downto 0);
	
	signal weight_rom_enable_buf : std_logic;
	signal weight_rom_address_buf : integer;
	signal data_enable_buf : std_logic;
	signal data_address_buf : integer;
	signal feedback_enable_buf : std_logic;
	signal feedback_address_N_buf : integer;
	signal feedback_address_M_buf : integer;
	signal X : fixedpoint(N-1 downto 0) := (X2,X1,X0);
	
	signal feedback_buf : sfixed (intpart-1 downto fracpart);
	signal X_output_buf : fixedpoint(N-1 downto 0);
	
begin

DUT: entity work.data_ram generic map(N=>N,M=>M,intpart=>intpart,fracpart=>fracpart)
			port map (X_input => X, data_enable=>data_enable_buf,data_address=>data_address_buf,
					feedback_enable=>feedback_enable_buf,feedback_address_N=>feedback_address_N_buf,
					feedback_address_M => feedback_address_M_buf, feedback=>feedback_buf,
					X_output=>X_output_buf);
					
	rst_s <= '0';
	
	data_enable_buf <= '0', '1' after 30 ns, '0' after 40 ns, '1' after 80 ns, '0' after 90 ns;
	data_address_buf <= 0, 1 after 80 ns;
	
	feedback_enable_buf <= '0', '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns, '1' after 60 ns, '0' after 70 ns;
	feedback_address_M_buf <= 1;
	feedback_address_N_buf <= 0, 1 after 40 ns, 2 after 60 ns;
	feedback_buf <= W0, W1 after 40 ns, W2 after 60 ns;
	
	clk_gen : process is
	begin
		clk_s <= '0';
		wait for T/2;
		clk_s <= '1';
		wait for T/2;
	end process clk_gen;

end architecture tb;
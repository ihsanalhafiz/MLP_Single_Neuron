library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity tb_neuron is
end entity tb_neuron;

architecture tb of tb_neuron is
	constant T : time := 10 ns; -- 100 Mhz
	constant K : integer := 3;
	constant N : integer := 8;
	
	constant X0 : sfixed (intpart-1 downto fracpart) := to_sfixed(0.3,intpart-1,fracpart);
	constant X1 : sfixed (intpart-1 downto fracpart) := to_sfixed(1.3,intpart-1,fracpart);
	constant X2 : sfixed (intpart-1 downto fracpart) := to_sfixed(2.3,intpart-1,fracpart);
	constant X3 : sfixed (intpart-1 downto fracpart) := to_sfixed(3.3,intpart-1,fracpart);
	constant X4 : sfixed (intpart-1 downto fracpart) := to_sfixed(4.3,intpart-1,fracpart);
	constant X5 : sfixed (intpart-1 downto fracpart) := to_sfixed(5.3,intpart-1,fracpart);
	constant X6 : sfixed (intpart-1 downto fracpart) := to_sfixed(6.3,intpart-1,fracpart);
	constant X7 : sfixed (intpart-1 downto fracpart) := to_sfixed(7.3,intpart-1,fracpart);
	constant X8 : sfixed (intpart-1 downto fracpart) := to_sfixed(8.3,intpart-1,fracpart);
	constant X9 : sfixed (intpart-1 downto fracpart) := to_sfixed(9.3,intpart-1,fracpart);
	constant X10 : sfixed (intpart-1 downto fracpart) := to_sfixed(10.3,intpart-1,fracpart);
	constant X11 : sfixed (intpart-1 downto fracpart) := to_sfixed(11.3,intpart-1,fracpart);
	constant X12 : sfixed (intpart-1 downto fracpart) := to_sfixed(12.3,intpart-1,fracpart);
	constant X13 : sfixed (intpart-1 downto fracpart) := to_sfixed(13.3,intpart-1,fracpart);
	constant X14: sfixed (intpart-1 downto fracpart) := to_sfixed(14.3,intpart-1,fracpart);
	constant X15: sfixed (intpart-1 downto fracpart) := to_sfixed(15.3,intpart-1,fracpart);
	
	constant W0 : sfixed (intpart-1 downto fracpart) := to_sfixed(0.7,intpart-1,fracpart);
	constant W1 : sfixed (intpart-1 downto fracpart) := to_sfixed(1.7,intpart-1,fracpart);
	constant W2 : sfixed (intpart-1 downto fracpart) := to_sfixed(2.7,intpart-1,fracpart);
	constant W3 : sfixed (intpart-1 downto fracpart) := to_sfixed(3.7,intpart-1,fracpart);
	constant W4 : sfixed (intpart-1 downto fracpart) := to_sfixed(4.7,intpart-1,fracpart);
	constant W5 : sfixed (intpart-1 downto fracpart) := to_sfixed(5.7,intpart-1,fracpart);
	constant W6 : sfixed (intpart-1 downto fracpart) := to_sfixed(6.7,intpart-1,fracpart);
	constant W7 : sfixed (intpart-1 downto fracpart) := to_sfixed(7.7,intpart-1,fracpart);
	constant W8 : sfixed (intpart-1 downto fracpart) := to_sfixed(8.7,intpart-1,fracpart);
	constant W9 : sfixed (intpart-1 downto fracpart) := to_sfixed(9.7,intpart-1,fracpart);
	constant W10 : sfixed (intpart-1 downto fracpart) := to_sfixed(10.7,intpart-1,fracpart);
	constant W11 : sfixed (intpart-1 downto fracpart) := to_sfixed(11.7,intpart-1,fracpart);
	constant W12 : sfixed (intpart-1 downto fracpart) := to_sfixed(12.7,intpart-1,fracpart);
	constant W13 : sfixed (intpart-1 downto fracpart) := to_sfixed(13.7,intpart-1,fracpart);
	constant W14 : sfixed (intpart-1 downto fracpart) := to_sfixed(14.7,intpart-1,fracpart);
	constant W15 : sfixed (intpart-1 downto fracpart) := to_sfixed(15.7,intpart-1,fracpart);
	
	constant A0 : sfixed (intpart-1 downto fracpart) := to_sfixed(1.0,intpart-1,fracpart);
	constant A1 : sfixed (intpart-1 downto fracpart) := to_sfixed(2.0,intpart-1,fracpart);
	constant A2 : sfixed (intpart-1 downto fracpart) := to_sfixed(3.0,intpart-1,fracpart);
	constant A3 : sfixed (intpart-1 downto fracpart) := to_sfixed(4.0,intpart-1,fracpart);
	constant A4 : sfixed (intpart-1 downto fracpart) := to_sfixed(5.0,intpart-1,fracpart);
	
	signal clk_s, rst_s : std_logic;
	
	signal bias : sfixed (intpart-1 downto fracpart) := to_sfixed(4.5,intpart-1,fracpart);
	signal W : fixedpoint(N-1 downto 0) := (W7,W6,W5,W4,W3,W2,W1,W0); --W15,W14,W13,W12,W11,W10,W9,W8,
	signal X : fixedpoint(N-1 downto 0) := (X7,X6,X5,X4,X3,X2,X1,X0); --X15,X14,X13,X12,X11,X10,X9,X8,
	
	signal result : sfixed (intpart-1 downto fracpart);
	
component neuron is
	generic(N : integer := 8;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port ( clk : in std_logic;
           nrst : in std_logic;
           b : in sfixed (intpart-1 downto fracpart);
		   W : in fixedpoint(N-1 downto 0);
		   X : in fixedpoint(N-1 downto 0);
		   result : out sfixed(intpart-1 downto fracpart));
end component;

begin
	
	DUT: neuron
		generic map (N=>N, intpart=>intpart, fracpart=>fracpart)
		port map (clk=>clk_s, nrst=>rst_s, 
				-- input
				b=>bias, W=>W, X=>X,
				-- output
				result=>result);
				
	rst_s <= '0';
	
	clk_gen : process is
	begin
		clk_s <= '0';
		wait for T/2;
		clk_s <= '1';
		wait for T/2;
	end process clk_gen;

end architecture tb;



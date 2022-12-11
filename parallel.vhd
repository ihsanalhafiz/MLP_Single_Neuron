LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;
use work.all;

------------------------------------------------------------------
-- define main entity
------------------------------------------------------------------
entity parallel is
	generic(N : integer := 8;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port ( clk : in std_logic;
           nrst : in std_logic;
           b : in sfixed (intpart-1 downto fracpart);
		   W : in fixedpoint(N-1 downto 0);
		   X : in fixedpoint(N-1 downto 0);
		   result : out sfixed(intpart-1 downto fracpart));
end parallel;

architecture Behavioral of parallel is

------------------------------------------------------------------
-- define the components
------------------------------------------------------------------
-- MAC component
component mac is
	generic(intpart: integer := 12;
			fracpart: integer := -20);
    Port (	a : in sfixed (intpart-1 downto fracpart);
			b : in sfixed (intpart-1 downto fracpart);
			c : in sfixed (intpart-1 downto fracpart);
			output : out sfixed (intpart-1 downto fracpart));
end component;

------------------------------------------------------------------
-- define internal signal
------------------------------------------------------------------
signal out_buffer : fixedpoint(N downto 0);
constant one : sfixed (intpart-1 downto fracpart) := to_sfixed(1,intpart-1,fracpart);
constant zero : sfixed (intpart-1 downto fracpart) := to_sfixed(0,intpart-1,fracpart);

begin

------------------------------------------------------------------
-- | generate MAC for K number
-- V
------------------------------------------------------------------
MAC_1 : mac 
			generic map (intpart => intpart,
						fracpart => fracpart)
			port map (	a => one,
						b => b,
						c => zero,
						output => out_buffer(0));
						
MAC_generate: for I in 0 to N-1 generate
	MAC_subgenerate : mac 
			generic map (intpart => intpart,
						fracpart => fracpart)
			port map (	a => W(I),
						b => X(I),
						c => out_buffer(I),
						output => out_buffer(I+1));
end generate MAC_generate;

process(clk,nrst)
begin
	if(nrst = '1') then
		result <= zero;
	elsif (rising_edge(clk)) then
		result <= out_buffer(N);
	end if;
end process;

end Behavioral;


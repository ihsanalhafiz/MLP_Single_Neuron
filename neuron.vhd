LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;
use work.all;

------------------------------------------------------------------
-- define main entity
------------------------------------------------------------------
entity neuron is
	generic(N : integer := 8;
			intpart : integer := 12;
			fracpart : integer := -20);
    Port ( clk : in std_logic;
           nrst : in std_logic;
           b : in sfixed (intpart-1 downto fracpart);
		   W : in fixedpoint(N-1 downto 0);
		   X : in fixedpoint(N-1 downto 0);
		   result : out sfixed(intpart-1 downto fracpart));
end neuron;

architecture Behavioral of neuron is

------------------------------------------------------------------
-- define the components
------------------------------------------------------------------
-- parallel component
component parallel is
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

-- relu activation function component
component relu is
	generic(intpart: integer := 12;
			fracpart: integer := -20);
    Port ( 	input : in sfixed (intpart-1 downto fracpart);
			output : out sfixed (intpart-1 downto fracpart));
end component;
------------------------------------------------------------------
-- define internal signal
------------------------------------------------------------------
signal buffer_mac : sfixed(intpart-1 downto fracpart);
constant zero : sfixed (intpart-1 downto fracpart) := to_sfixed(0,intpart-1,fracpart);

begin

PARALLEL_MAC: parallel generic map (N=>N, intpart=>intpart, fracpart=>fracpart)
              port map( clk => clk, nrst => nrst, 
                        b => b, W => W, X => X,
                        result => buffer_mac);

RELU_AF : relu generic map(intpart=>intpart, fracpart=>fracpart)
            port map( input => buffer_mac, output => result);
                   

end Behavioral;


library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity mac is
	generic(intpart: integer := 12;
			fracpart: integer := -20);
    Port ( 	a : in sfixed (intpart-1 downto fracpart);
			b : in sfixed (intpart-1 downto fracpart);
			c : in sfixed (intpart-1 downto fracpart);
			output : out sfixed (intpart-1 downto fracpart));
end mac;

architecture Behavioral of mac is
signal outbuf : sfixed (intpart-1 downto fracpart);
begin
	output <= resize(((a*b)+c),outbuf);
end Behavioral;

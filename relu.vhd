library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;
use work.array_package.all;

entity relu is
	generic(intpart: integer := 12;
			fracpart: integer := -20);
    Port ( 	input : in sfixed (intpart-1 downto fracpart);
			output : out sfixed (intpart-1 downto fracpart));
end relu;

architecture Behavioral of relu is
begin
	output <= (others => '0') when input(intpart-1)='1' else input; 
end Behavioral;

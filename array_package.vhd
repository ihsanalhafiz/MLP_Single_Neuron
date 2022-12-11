------------------------------------------------------------------
-- define package for array in fixedpoint
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.fixed_pkg.all;

PACKAGE array_package IS
	constant intpart : integer := 12;
	constant fracpart : integer := -20;
    type fixedpoint is array (natural range <>) of sfixed(intpart-1 downto fracpart);
END;
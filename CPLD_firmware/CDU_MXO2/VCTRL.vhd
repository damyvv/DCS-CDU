library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity VCTRL is
	port(
		char_sel : in std_logic_vector(6 downto 0);
		l_sel : in std_logic_vector(4 downto 0);
		data : out std_logic_vector(10 downto 0)
	);
end;

architecture behavior of VCTRL is
begin

end;
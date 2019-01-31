library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VRAM is
	port(
		addr_a, addr_b : in std_logic_vector(8 downto 0) := (others => '0');
		data_a : in std_logic_vector(6 downto 0) := (others => '0');
		we_a : in std_logic := '0';
		clk : in std_logic;
		q_b : out std_logic_vector(6 downto 0)
	);
end;

architecture behavior of VRAM is
type data_type is array(511 downto 0) of std_logic_vector(6 downto 0);
signal data : data_type := (others => B"000" & x"1");
begin

process (clk)
begin
if (clk'event and clk = '1') then
	q_b <= data(to_integer(unsigned(addr_b)));

--	q_b <= addr_b(6 downto 0);
	
	if (we_a = '1') then
		data(to_integer(unsigned(addr_a))) <= data_a;
	end if;
end if;
end process;

end;
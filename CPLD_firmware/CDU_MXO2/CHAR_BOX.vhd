----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:52:58 10/25/2017 
-- Design Name: 
-- Module Name:    CHAR_BOX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CHAR_BOX is
    Port ( x_pos : in  STD_LOGIC_VECTOR (8 downto 0);
           y_pos : in  STD_LOGIC_VECTOR (7 downto 0);
           pix_x_char : out  STD_LOGIC_VECTOR (3 downto 0);
           pix_y_char : out  STD_LOGIC_VECTOR (3 downto 0);
			  num_x_char : out  STD_LOGIC_VECTOR (4 downto 0);
			  num_y_char : out  STD_LOGIC_VECTOR (3 downto 0);
			  ce : out STD_LOGIC
			 );
end CHAR_BOX;

architecture Behavioral of CHAR_BOX is
signal x_ce, y_ce : std_logic;
begin

ce <= x_ce and y_ce;

process(x_pos)
	constant CHAR_WIDTH : integer := 12;
	constant HOR_OFFSET : integer := 16;
	constant CHAR_SPACING : integer := 0;
	variable x_num : integer;
	variable corrected_x_pos : integer;
	variable temp_x_char : integer;
begin
x_num := 0;
corrected_x_pos := to_integer(unsigned(x_pos)) - HOR_OFFSET;
for I in 0 to 23 loop
	if (corrected_x_pos >= I * CHAR_WIDTH and corrected_x_pos < (I+1) * CHAR_WIDTH) then
		x_num := I;
	end if;
end loop;
num_x_char <= std_logic_vector(to_unsigned(x_num, 5));
temp_x_char := corrected_x_pos - x_num * CHAR_WIDTH;
pix_x_char <= std_logic_vector(to_unsigned(temp_x_char - CHAR_SPACING, 4));
if (temp_x_char >= CHAR_SPACING and temp_x_char < CHAR_WIDTH - CHAR_SPACING  -- Character spacing
		and x_num >= 0 and unsigned(x_pos) >= HOR_OFFSET and unsigned(x_pos) < 320 - HOR_OFFSET) then
	x_ce <= '1';
else
	x_ce <= '0';
end if;
end process;


process(y_pos)
	constant CHAR_HEIGHT : integer := 18;
	constant VERT_OFFSET : integer := 30;
	constant CHAR_SPACING : integer := 2;
	variable y_num : integer;
	variable corrected_y_pos : integer;
	variable temp_y_char : integer;
begin
y_num := 0;
corrected_y_pos := to_integer(unsigned(y_pos)) - VERT_OFFSET;
for I in 0 to 9 loop
	if (corrected_y_pos >= I * CHAR_HEIGHT and corrected_y_pos < (I+1) * CHAR_HEIGHT) then
		y_num := I;
	end if;
end loop;
num_y_char <= std_logic_vector(to_unsigned(y_num, 4));
temp_y_char := corrected_y_pos - y_num * CHAR_HEIGHT;
pix_y_char <= std_logic_vector(to_unsigned(temp_y_char - CHAR_SPACING, 4));
if (temp_y_char >= CHAR_SPACING and temp_y_char < CHAR_HEIGHT - CHAR_SPACING  -- Character spacing
		and y_num >= 0 and unsigned(y_pos) >= VERT_OFFSET and unsigned(y_pos) < 240 - VERT_OFFSET) then
	y_ce <= '1';
else
	y_ce <= '0';
end if;
end process;


end Behavioral;


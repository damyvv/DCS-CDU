----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:06 10/24/2017 
-- Design Name: 
-- Module Name:    LCD_CTRL - Behavioral 
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

entity LCD_CTRL is
    Port ( clk : in  STD_LOGIC;
           dot_clk : out  STD_LOGIC;
           nde : out  STD_LOGIC;
			  x_pos : out STD_LOGIC_VECTOR(8 downto 0);
			  y_pos : out STD_LOGIC_VECTOR(7 downto 0)
			 );
end LCD_CTRL;

architecture Behavioral of LCD_CTRL is
signal x_cnt : unsigned(8 downto 0) := (others => '0');
signal y_cnt : unsigned(7 downto 0) := (others => '0');
signal clk_div : unsigned(2 downto 0) := (others => '0');

signal nde_hor, nde_ver : std_logic;
begin

nde <= nde_hor or nde_ver;

x_pos <= std_logic_vector(319 - x_cnt);
y_pos <= std_logic_vector(239 - y_cnt);

dot_clk <= not clk_div(2);

horizontal_period : process (clk_div(2), x_cnt, y_cnt)
begin
if (clk_div(2)'event and clk_div(2) = '1') then
if (x_cnt = 379) then
	x_cnt <= (others => '0');
	if (y_cnt = 250) then
		y_cnt <= (others => '0');
	else
		y_cnt <= y_cnt + 1;
	end if;
else
	x_cnt <= x_cnt + 1;
end if;
end if;

if (y_cnt < 243) then
	nde_ver <= '0';
else
	nde_ver <= '1';
end if;

if (x_cnt < 320) then
	nde_hor <= '0';
else
	nde_hor <= '1';
end if;
end process;

clock_divider : process (clk)
begin
if (clk'event and clk = '1') then
	clk_div <= clk_div + 1;
end if;
end process;

end Behavioral;


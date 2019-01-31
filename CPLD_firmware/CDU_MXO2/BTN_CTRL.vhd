----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Damy van Valenberg
-- 
-- Create Date:    22:35:10 05/04/2018 
-- Design Name: 
-- Module Name:    BTN_CTRL - Behavioral 
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

entity BTN_CTRL is
    Port (  clk : in STD_LOGIC;
			btn_col : in STD_LOGIC_VECTOR(7 downto 0);
			btn_row : out STD_LOGIC_VECTOR(8 downto 0);
			buttons : out STD_LOGIC_VECTOR(71 downto 0) := (others => '0')
			  );
end BTN_CTRL;

architecture Behavioral of BTN_CTRL is
signal btn_reg : STD_LOGIC_VECTOR(71 downto 0) := (others => '0');
signal PC : unsigned(9 downto 0) := (others => '0');
signal row : integer := 0;
begin

buttons <= btn_reg;


btn_reading : process (PC)
begin
if (PC(9)'event and PC(9) = '1') then
	
	if (row = 0) then
		btn_reg(0*8+7 downto 0*8) <= btn_col;
	elsif (row = 1) then
		btn_reg(1*8+7 downto 1*8) <= btn_col;
	elsif (row = 2) then
		btn_reg(2*8+7 downto 2*8) <= btn_col;
	elsif (row = 3) then
		btn_reg(3*8+7 downto 3*8) <= btn_col;
	elsif (row = 4) then
		btn_reg(4*8+7 downto 4*8) <= btn_col;
	elsif (row = 5) then
		btn_reg(5*8+7 downto 5*8) <= btn_col;
	elsif (row = 6) then
		btn_reg(6*8+7 downto 6*8) <= btn_col;
	elsif (row = 7) then
		btn_reg(7*8+7 downto 7*8) <= btn_col;
	elsif (row = 8) then
		btn_reg(8*8+7 downto 8*8) <= btn_col;
	end if;
	
	if (row >= 8) then
		row <= 0;
	else
		row <= row + 1;
	end if;
end if;
end process;

row_driver : process (row)
begin
btn_row <= (others => 'Z');
btn_row(row) <= '1';
end process;

prescale : process (clk)
begin
if (clk'event and clk = '1') then
	PC <= PC + 1;
end if;
end process;

end Behavioral;


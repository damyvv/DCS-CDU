----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:07 10/26/2017 
-- Design Name: 
-- Module Name:    SPI_CTRL - Behavioral 
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

entity SPI_CTRL is
    Port ( spi_clk : in  STD_LOGIC;
           spi_mosi : in  STD_LOGIC;
		   spi_miso : out STD_LOGIC;
           spi_ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
		   in_data : out STD_LOGIC_VECTOR(23 downto 0);
		   out_data : in STD_LOGIC_VECTOR(71 downto 0);
		   we : out STD_LOGIC;
		   nread_bit : out STD_LOGIC
			  );
end SPI_CTRL;

architecture Behavioral of SPI_CTRL is
signal data_latch : STD_LOGIC_VECTOR(23 downto 0) := (others => '1');
signal spi_ce_offset : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
signal first_bit, nread_bit_t, read_bit_t : STD_LOGIC;
signal bit_cnt : unsigned(6 downto 0);
begin

nread_bit <= nread_bit_t;
read_bit_t <= not nread_bit_t;

in_data <= data_latch;

we <= spi_ce and (not spi_ce_offset(1)) and nread_bit_t;

spi_miso <= out_data(to_integer(bit_cnt) - 8) and read_bit_t;

we_ctrl : process(clk)
begin
if (clk'event and clk = '1') then
	spi_ce_offset <= spi_ce_offset(0) & spi_ce;
end if;
end process;

data_ctrl : process(spi_ce, spi_clk)
begin
if (spi_clk'event and spi_clk = '1' and spi_ce = '0') then
	data_latch <= data_latch(22 downto 0) & spi_mosi;
	if (first_bit = '1') then
		nread_bit_t <= spi_mosi;
	end if;
	
end if;
end process;

flank_ctrl : process(spi_ce, spi_clk)
begin
if (spi_ce = '1') then
	first_bit <= '1';
	bit_cnt <= (others => '0');
elsif (spi_clk'event and spi_clk = '0' and spi_ce = '0') then
	first_bit <= '0';
	bit_cnt <= bit_cnt + 1;
end if;
end process;

end Behavioral;


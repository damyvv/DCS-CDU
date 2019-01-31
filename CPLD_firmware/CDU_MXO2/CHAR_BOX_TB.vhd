--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:00:35 10/25/2017
-- Design Name:   
-- Module Name:   D:/Xilinx/Projects/CDU/CHAR_BOX_TB.vhd
-- Project Name:  CDU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CHAR_BOX
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY CHAR_BOX_TB IS
END CHAR_BOX_TB;
 
ARCHITECTURE behavior OF CHAR_BOX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CHAR_BOX
    PORT(
         x_pos : IN  std_logic_vector(8 downto 0);
         y_pos : IN  std_logic_vector(7 downto 0);
         x_char : OUT  std_logic_vector(3 downto 0);
         y_char : OUT  std_logic_vector(3 downto 0);
         ce : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x_pos : std_logic_vector(8 downto 0) := (others => '0');
   signal y_pos : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal x_char : std_logic_vector(3 downto 0);
   signal y_char : std_logic_vector(3 downto 0);
   signal ce : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CHAR_BOX PORT MAP (
          x_pos => x_pos,
          y_pos => y_pos,
          x_char => x_char,
          y_char => y_char,
          ce => ce
        );
	
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
--		for X in 0 to 339 loop
--			x_pos <= std_logic_vector(to_unsigned(X, 9));
--			wait for 10 ns;
--		end loop;
--		x_pos <= (others => '0');
		
		for Y in 0 to 259 loop
			y_pos <= std_logic_vector(to_unsigned(Y, 8));
			wait for 10 ns;
		end loop;
		
      wait;
   end process;

END;

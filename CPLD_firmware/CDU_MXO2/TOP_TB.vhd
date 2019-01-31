--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:16 10/23/2017
-- Design Name:   
-- Module Name:   D:/Xilinx/Projects/CDU/TOP_TB.vhd
-- Project Name:  CDU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
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
--USE ieee.numeric_std.ALL;
 
ENTITY TOP_TB IS
END TOP_TB;
 
ARCHITECTURE behavior OF TOP_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         clk : IN  std_logic;
         ce_in : IN  std_logic;
         c_mode : IN  std_logic;
			reset_in : IN std_logic;
         dot_clk : OUT  std_logic;
         nde : OUT  std_logic;
         reset : OUT  std_logic;
         ce : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ce_in : std_logic := '0';
   signal c_mode : std_logic := '0';
	signal reset_in : std_logic := '0';

 	--Outputs
   signal dot_clk : std_logic;
   signal nde : std_logic;
   signal reset : std_logic;
   signal ce : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          clk => clk,
          ce_in => ce_in,
          c_mode => c_mode,
          dot_clk => dot_clk,
          nde => nde,
          reset => reset,
			 reset_in => reset_in,
          ce => ce
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		c_mode <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

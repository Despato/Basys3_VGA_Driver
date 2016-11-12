----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Thomas Vanek
-- 
-- Create Date: 05/27/2016 03:45:50 PM
-- Design Name: 
-- Module Name: VGAOutputComponents - Behavioral
-- Project Name: Vga-Controller
-- Target Devices: 
-- Tool Versions: 
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
entity HCOUNTER is
   Port( clk            : in STD_LOGIC;
         tc             : buffer STD_LOGIC := '0'; 
         q              : out integer);
end;

architecture Behavioral of HCOUNTER is
   signal count : integer range 0 to 800 := 0;
begin
process (clk)
begin
   if rising_edge(clk) then
      if (count < 800) then
         count <= count + 1;
      elsif (count = 800) then
         count <= 0;
         tc <= not(tc);
      end if;
   end if;
end process;
q <= count;
end Behavioral;





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity VCOUNTER is
   Port( clk            : in STD_LOGIC;
         en             : in STD_LOGIC; 
         q              : out integer);
end;

architecture Behavioral of VCOUNTER is
   signal count : integer range 0 to 515 := 0;
   signal prev_state : STD_LOGIC := '0';
begin
process(clk, en)
begin
if (rising_edge(clk)) then
   if (en /= prev_state) then
      if (count < 515) then
         count <= count + 1;
      elsif (count = 515) then
         count <= 0;
      end if;
      prev_state <= not(prev_state);
   end if;
   else
      count <= count;
end if;
end process;
q <= count;
end Behavioral;






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity COMP is
   Port ( inx           : in integer;
          condition     : in integer;
          q             : out STD_LOGIC);   
end;

architecture Behavioral of COMP is
   signal d             : integer := 0;           
   signal temp          : STD_LOGIC;
begin
process (inx, d, condition)
begin
   d <= inx;
   if (d >= condition) then
      temp <= '1';
   else
      temp <= '0';
   end if;
end process;
q <= temp;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity DISPCOMP is
   Port ( inx           : in integer;
          iny           : in integer;
          q             : out STD_LOGIC);   
end;

architecture Behavioral of DISPCOMP is
   signal d             : integer := 0;           
   signal temp          : STD_LOGIC;
begin
process (inx, iny)
begin
   if ((inx < 137) or (iny < 33)) then
      temp <= '0';
   elsif ((inx < 778) and (iny < 505)) then
      temp <= '1';
   else
      temp <= '0';
   end if;
end process;
q <= temp;
end Behavioral;
   




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MUX is
   Port ( rin           : in STD_LOGIC_VECTOR (3 downto 0);
          gin           : in STD_LOGIC_VECTOR (3 downto 0);
          bin           : in STD_LOGIC_VECTOR (3 downto 0);
          sel           : in STD_LOGIC;
          
          rout          : out STD_LOGIC_VECTOR (3 downto 0);
          gout          : out STD_LOGIC_VECTOR (3 downto 0);
          bout          : out STD_LOGIC_VECTOR (3 downto 0));
          
end;

architecture Behavioral of MUX is

begin
process (sel, rin, gin, bin)
begin
   if (sel = '0') then
      rout <= "0000"; 
      bout <= "0000"; 
      gout <= "0000"; 
   else
      rout <= rin;
      gout <= gin;
      bout <= bin;      
   end if;
end process;
end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Thomas Vanek
-- 
-- Create Date: 05/27/2016 03:29:21 PM
-- Design Name: 
-- Module Name: Vga-Output-Main - Behavioral
-- Project Name: Vga-Controller 
-- Target Devices: Xilinx Basys 3
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
entity VGAOutputMain is
    Port (r                : in STD_LOGIC_VECTOR (3 downto 0);
          g                : in STD_LOGIC_VECTOR (3 downto 0);
          b                : in STD_LOGIC_VECTOR (3 downto 0);
          clk_in           : in STD_LOGIC;
          rout             : out STD_LOGIC_VECTOR (3 downto 0);
          gout             : out STD_LOGIC_VECTOR (3 downto 0);
          bout             : out STD_LOGIC_VECTOR (3 downto 0);
          Hsync            : out STD_LOGIC;
          Vsync            : out STD_LOGIC);
end VGAOutputMain;

architecture Behavioral of VGAOutputMain is
   
   component HCOUNTER
      port (clk            : in STD_LOGIC;
            tc             : buffer STD_LOGIC;
            q              : out integer);
   end component;

   component VCOUNTER
      port (clk            : in STD_LOGIC;
            en             : in STD_LOGIC;
            q              : out integer);
   end component;
   
   component COMP
      port (inx            : in integer;
            condition      : in integer;
            q              : out STD_LOGIC);      
   end component;
   
   component DISPCOMP
      port ( inx          : in integer;
             iny          : in integer;
             q            : out STD_LOGIC);
   end component; 
   
   component MUX
      port (rin           : in STD_LOGIC_VECTOR (3 downto 0);
            gin           : in STD_LOGIC_VECTOR (3 downto 0);
            bin           : in STD_LOGIC_VECTOR (3 downto 0);
            sel           : in STD_LOGIC;
            
            rout          : out STD_LOGIC_VECTOR (3 downto 0);
            gout          : out STD_LOGIC_VECTOR (3 downto 0);
            bout          : out STD_LOGIC_VECTOR (3 downto 0));
   end component; 
   
   signal vc              : integer;
   signal hc              : integer;
   signal vs_inc          : STD_LOGIC;
   signal disp_enable     : STD_LOGIC;


begin
HCOUNT: HCOUNTER port map ( clk        =>     clk_in,
                            tc         =>     vs_inc,
                            q          =>     hc);

VCOUNT: VCOUNTER port map ( clk        =>     clk_in,
                            en         =>     vs_inc,
                            q          =>     vc);
                           
HPULSE: COMP port map ( inx            =>     hc,
                        condition      =>     92,
                        q              =>     Hsync);

VPULSE: COMP port map ( inx            =>     vc,
                        condition      =>     1,
                        q              =>     Vsync);

DISP: DISPCOMP port map ( inx          =>     hc,
                          iny          =>     vc,
                          q            =>     disp_enable);                          
                           
SIGNAL_SELECT: MUX port map( rin       =>     r,
                             gin       =>     g,
                             bin       =>     b,
                             sel       =>     disp_enable,    
                             rout      =>     rout,
                             gout     =>     gout,
                             bout     =>     bout);                        
end Behavioral;
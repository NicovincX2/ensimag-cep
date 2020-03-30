library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is
    signal extension_signe : std_logic;
    signal z : std_logic;
    signal s : std_logic;
begin
    extension_signe <= (not(IR(12)) and not(IR(6)) or (IR(6) and not(IR(13)));
    z <= ((rs1 - alu_y) + extension_signe) nor 0;
    s <= ((rs1 - alu_y) + extension_signe)(31);
    jcond <= (not(IR(14)) and (IR(12) xor z)) or ((s xor IR(12)) and IR(14));
    slt <= s;
end architecture;

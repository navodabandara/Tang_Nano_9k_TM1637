--TODO find a way to remove unused ports
--TODO implement reset (perhaps add a rising edge clock independant reset to submodules)
--TODO rename outputs and inputs called TOBUS, FROMBUS to clearly distinguish between direct outputs/inputs

--TODO POSSIBLE IMPROVEMENTS
--Expand memory which is currently 16 bytes
--reset microcode counter if there are no more microinstructions
--optimize command bus (perhaps by combining instructions, see which instructions are never together
--and bunch them?)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.std_logic_unsigned.ALL;

--52-38-37

ENTITY top_level IS
    PORT (
        i_clock, i_reset : IN STD_LOGIC;
        o_sda, o_scl, o_led : OUT STD_LOGIC
    );
END top_level;

ARCHITECTURE behavioral OF top_level IS
    --SIGNAL microinstruction_counter : STD_LOGIC_VECTOR(2 DOWNTO 0); --3 bit counter
    SIGNAL r_value : std_logic_vector(15 downto 0):= "0000000000000000";
    signal temp : std_logic ;

    CONSTANT c_clock_multiplier : NATURAL := 27000000; --clock frequency --27000000 max
    SIGNAL r_clock_counter : NATURAL RANGE 0 TO c_clock_multiplier; --max range is clock cycles per second
    SIGNAL w_sysclk : STD_LOGIC := '0'; --system clock that the SAP 1 operates at

BEGIN

    sysclk_div : PROCESS (i_clock, i_reset) IS
    BEGIN
        IF rising_edge (i_clock) THEN --on the rising edge of clock
            IF r_clock_counter = c_clock_multiplier - 1 THEN --if the clock is about to overflow
                r_clock_counter <= 0; --set the clock counter back to 0
                w_sysclk <=(NOT w_sysclk);
r_value<=r_value+"0000000000000001";
            ELSE
                r_clock_counter <= r_clock_counter + 1; --else increment the clock counter by 1
            END IF;
        END IF;

        IF i_reset = '0' THEN --if the reset button is 0
            r_clock_counter <= 0; --reset both counters
        END IF;
    END PROCESS sysclk_div;



    PC : ENTITY work.tm1637_standalone PORT MAP(
        clk25 =>  i_clock,
        data =>  r_value,
        scl  =>  o_scl,
        sda  => o_sda,
        clkdivout => temp
    );

o_led <= not o_scl;
    
    --o_sysclk <= w_sysclk; -- show the sysclk on PIN10_IOL15A_LED1
END behavioral;
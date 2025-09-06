entity Test_DFF is end;

architecture Driver of Test_DFF is
    component DFF
        port (
            Preset, Clear, Clock, Data: in Bit;
            Q, Qbar: out Bit
        );
    end component;

    signal Preset: Bit := '1';
    signal Clear: Bit := '1';
    signal Clock, Q, QBar: Bit;
    signal Data: Bit := '1';
begin
    UUT: DFF port map (Preset, Clear, Clock, Data, Q, Qbar);

    Stimulus: process
    begin

        Clock<= '0'; wait for 15 ns;
        Clock<= '1'; wait for 15 ns;
        Clock<= '0'; wait for 15 ns;
        Clock<= '1'; wait for 15 ns;
        Clock<= '0'; wait for 15 ns;
        Clock<= '1'; wait for 15 ns;

        wait; -- termina la simulación
    end process;
end;
--ghdl -a Test_DFF_Ej_a.vhd
--ghdl -e Test_DFF
--ghdl -r Test_DFF --stop-time=100ns --wave=pruebaClock.ghw

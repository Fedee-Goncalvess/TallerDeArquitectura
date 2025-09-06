entity Test_DFF is end;

architecture Driver of Test_DFF is
    component DFF
        port (
            Preset, Clear, Clock, Data: in Bit;
            Q, Qbar: out Bit
        );
    end component;

    signal Preset, Clear: Bit := '1';
    signal Clock, Data, Q, QBar: Bit;
begin
    UUT: DFF port map (Preset, Clear, Clock, Data, Q, Qbar);

    Stimulus: process
    begin
        -- chequeo de preset y clear
        Preset <= '0';                  -- 0 ns
        wait for 5 ns;
        Preset <= '1';                  -- 5 ns
        Clear  <= '0' after 1 ns,'1' after 2 ns;
        wait for 4 ns;                  -- 9 ns

        -- interaccion de preset y clear
        Preset <= '0'; Clear <= '0';
        wait for 1 ns;                  -- 10 ns
        Preset <= '1'; Clear <= '1';
        wait for 1 ns;                  -- 11 ns

        -- limpiar
        Clear <= '0', '1' after 5 ns; wait for 10 ns; -- 40 ns

        -- chequeo de datos y clock
        Data  <= '1' ;
        Clock <= '1' after 5 ns, --Subida en 45 ns
        '0' after 6005 ps ,         --Bajada en 46 ns
        '1' after 7010 ps;          --Subida en 47 ns
        wait for 10 ns;

        -- 50 ns
        Data  <= '0'; wait for 10 ns; -- 60 ns

        -- limpiar
        Clear <= '0', '1' after 5 ns; wait for 10 ns; -- 70 ns

        -- interaccion de preset y clock
        Data   <= '0';
        Preset <= '0', '1' after 10 ns;
        Clock  <= '0', '1' after 5 ns; wait for 10 ns; -- 80 ns

        wait; -- termina la simulación


    end process;
end;

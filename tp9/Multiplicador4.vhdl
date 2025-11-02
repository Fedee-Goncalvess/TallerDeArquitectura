entity Multiplicador4 is 
    port (
        A,B: in Bit_Vector(3 downto 0);
        CLK,STB: in Bit;
        Producto: out Bit_Vector(7 downto 0);
        Done: out Bit
    );
end Multiplicador4;

architecture Estructura of Multiplicador4 is
        signal Init, Shift, Add, Stop : Bit;
        signal outA, outB : Bit_Vector(7 downto 0);

    begin
        RegA: ShiftN port map (
            CLK => CLK, 
            CLR => '0', 
            LD => Init, 
            SH => Shift, 
            DIR => '0', 
            D => A, 
            Q => outA
        ); -- Registro A de 8 bits

        RegB: ShiftN port map (
            CLK => CLK, 
            CLR => '0', 
            LD => Init, 
            SH => Shift, 
            DIR => '1', 
            Q => B, 
            D => outB
        ); -- Registro B de 8 bits

        Acumulador: Latch8 port map (
            D => Sum, 
            Clk => CLK, 
            Pre => Add, 
            Clr => Init, 
            Q => Acc
        ); -- Registro Acumulador de 8 bit

        Adder: Adder8 port map (outB, Acc, Cin, Cout, Sum); -- Sumador de 8 bits

        Stop <= not(outA(7) or outA(6) or outA(5) or outA(4) or outA(3) or outA(2) or outA(1) or outA(0));
        Controlador: Controller port map (STB, CLK, outA & "00000001", Stop, Init, Shift, Add, Done);

        Producto <= Acc;

    end Estructura;
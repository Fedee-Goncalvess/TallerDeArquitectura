entity Multiplicador4 is 
    port (
        A,B: in Bit_Vector(3 downto 0);
        CLK,STB: in Bit;
        Producto: out Bit_Vector(7 downto 0);
        Done: out Bit
    );
end Multiplicador4;

architecture Estructura of Multiplicador4 is

    component ShiftN
        port (CLK: in Bit;
          CLR: in Bit;
          LD: in Bit;
          SH: in Bit;
          DIR: in Bit;
          D: in Bit_Vector;
          Q: out Bit_Vector);
    end component;

    component fulladder
        port (X, Y, Cin: in Bit;
          Cout, Sum: out Bit);
    end component;

    component Adder8
        port (A, B: in Bit_Vector(7 downto 0);
          Cin: in Bit;
          Cout: out Bit;
          Sum: out Bit_Vector(7 downto 0));
    end component;

    component Controller
        port (STB, CLK, LSB, Stop: in Bit;
          Init, Shift, Add, Done: out Bit);
    end component;

        signal Init, Shift, Add, Stop , LSB: Bit;
        signal outA, outB, sum, Acc : Bit_Vector(7 downto 0);
        signal A_8bit, B_8bit : Bit_Vector(7 downto 0);

    begin
        --tuve que agregar ceros para compatibilidad de 4->8bits
        A_8bit <= "0000" & A;
        B_8bit <= "0000" & B;

        RegA: ShiftN port map (
            CLK => CLK, 
            CLR => '0', 
            LD => Init, 
            SH => Shift, 
            DIR => '0', 
            D => A_8bit,  
            Q => outA
        ); -- Registro A de 8 bits

        RegB: ShiftN port map (
            CLK => CLK, 
            CLR => '0', 
            LD => Init, 
            SH => Shift, 
            DIR => '1', 
            D => B_8bit, 
            Q => outB
        ); -- Registro B de 8 bits

        Acumulador: ShiftN port map (
            CLK => CLK, 
            CLR => Init, 
            LD => Add, 
            SH => '0',
            DIR => '0',
            D => Sum, 
            Q => Acc
        ); -- Registro Acumulador de 8 bit

        Adder: Adder8 port map (
            A => outB, 
            B => Acc, 
            Cin => '0', 
            Cout => open, 
            Sum => Sum
        ); -- Sumador de 8 bits

        Stop <= not(outA(7) or outA(6) or outA(5) or outA(4) or outA(3) or outA(2) or outA(1) or outA(0));
        LSB <= outA(0);

        Controlador: Controller port map (
            STB => STB, 
            CLK => CLK, 
            LSB => LSB, 
            Stop => Stop, 
            Init => Init, 
            Shift => Shift, 
            Add => Add, 
            Done => Done
        );

        Producto <= Acc;

    end Estructura;
    
entity Multiplicador4 is 
    port (
        A,B: in Bit_Vector(1 downto 0);
        CLK,STB: in Bit;
        Producto: out Bit_Vector(3 downto 0);
        Done: out Bit;
    );
end Multiplicador4;

architecture Estructura of Multiplicador4 is
    
    begin
        RegA: Latch8 port map (); -- Registro A de 8 bits

        RegB: Latch8 port map (); -- Registro B de 8 bits

        Acumulador: Latch8 port map (); -- Registro Acumulador de 8 bit

        Adder: Adder8 port map (); -- Sumador de 8 bits

        
 
    end Estructura;
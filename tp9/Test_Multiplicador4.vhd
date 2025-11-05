
    
    entity Test_Multiplicador4 is end;
    
    architecture Driver of Test_Multiplicador4 is 
    	component Multiplicador4
    	port (
            A,B: in Bit_Vector(3 downto 0);
            CLK,STB: in Bit;
            Producto: out Bit_Vector(7 downto 0);
            Done: out Bit
        );    	
    	end component;
    	
        signal A_tb, B_tb: Bit_Vector(3 downto 0);
        signal CLK_tb, STB_tb, Done_tb: Bit;
        signal Producto_tb: Bit_Vector(7 downto 0);

    begin

        Prueba: Multiplicador4 port map (
            A => A_tb,
            B => B_tb, 
            CLK => CLK_tb,
            STB => STB_tb,
            Producto => Producto_tb,
            Done => Done_tb
        );

        Clock : process
        begin
            work.Utils.Clock(CLK_tb, 10.416 ns, 10.416 ns);  -- 48MHz
            wait;  
        end process;

    	Stimulus: process
                variable resultado: Natural;
    		begin
    		--Multiplicar 8 x 3 y 3 x 8
    		-- Clock de 48 MHz -> 20.83ns de periodo -> 10.416 en alto y 10.416 en bajo
    		   		
            --Inicializar
            STB_tb <= '0';
            A_tb <= "0000";
            B_tb <= "0000";
            wait for 25 ns;

            -- Test 1: Multiplicar 8 × 3
            A_tb <= work.Utils.Convert(8, 4);  -- utilizo Utils.Convert
            B_tb <= work.Utils.Convert(3, 4);
            resultado := 8 * 3;
        
            wait for 25 ns;
            STB_tb <= '1';  -- Pulso de Inicio
            wait for 20 ns;
            STB_tb <= '0';  

            wait until Done_tb = '1';

            --Verifico el resultado
            assert work.Utils.Convert(Producto_tb) = resultado
            report "Error: 8 * 3 = " & Integer'image(work.Utils.Convert(Producto_tb)) & 
                   ", resultado correcto -> " & Integer'image(resultado)
            severity Error;
        
            report "Resultado fue correcto: 8 * 3 = " & Integer'image(work.Utils.Convert(Producto_tb));
            wait for 100 ns;

            -- Test 2: Multiplicar 3 × 8
            A_tb <= work.Utils.Convert(3, 4);
            B_tb <= work.Utils.Convert(8, 4);
            resultado := 3 * 8;
        
            STB_tb <= '1';
            wait for 20 ns;
            STB_tb <= '0';

            wait until Done_tb = '1';
        
            assert work.Utils.Convert(Producto_tb) = resultado
                report "Error: 3 * 8 = " & Integer'image(work.Utils.Convert(Producto_tb)) & 
                   ", resultado correcto " & Integer'image(resultado)
                severity Error;
        
            report "Resultado fue correcto: 3 * 8 = " & Integer'image(work.Utils.Convert(Producto_tb));
            wait for 100 ns;
            wait;
    	end process;
    end;
    

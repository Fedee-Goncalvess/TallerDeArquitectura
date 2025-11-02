entity Test_Latch8 is end;

architecture Driver of Test_Latch8 is
     component Latch8
        port (D: in Bit_Vector(7 downto 0); Clk: in Bit; Pre: in Bit; Clr: in Bit; Q: out Bit_Vector(7 downto 0));
     end component;
     signal D, Q: Bit_Vector(7 downto 0);
     signal Clk, Pre, Clr: Bit := '1';
begin
      UUT: Latch8 port map (D, Clk, Pre, Clr, Q);
     Stimulus: process
variable Temp: Bit_Vector(7 downto 0);
begin
-- Set the latch
                Pre <= '0', '1' after 5 ns;  -- 0ns
                wait for 10 ns;		     -- 10ns
-- Clear the latch
                Clr <= '0', '1' after 5 ns;
                wait for 10 ns;		     -- 20ns
-- Load the latch
                Temp := "00010011";
		Clk <= '0' after 1 ns, '1' after 5 ns,
			'0' after 9 ns, '1' after 13 ns,
			'0' after 17 ns, '1' after 21 ns;

                for i in 1 to 8 loop
                  D <= Temp;

                  wait for 10 ns;
                  assert Q = Temp report "Load Failed";
                  Temp := Temp(0) & Temp(7 downto 1);
                end loop;
                 wait; -- to terminate simulation
             end process;
end;

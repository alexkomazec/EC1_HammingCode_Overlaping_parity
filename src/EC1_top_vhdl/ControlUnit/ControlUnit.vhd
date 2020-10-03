library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ControlUnit is
Port (
    Clock,Reset                             : in std_logic;
    IRload,PCload,INmux,Aload,JNZmux,Halt   : out std_logic;
    Aneq0                                   : in std_logic;
    IR                                      : in std_logic_vector(2 downto 0);
    States                                  : out std_logic_vector(2 downto 0)
);
end ControlUnit;

architecture Behavioral of ControlUnit is

type mc_state_type is (start,fetch,decode,input,output,dec,jnz,haltt); --Kreirali smo tip �?ije
--vrednosti su dati u zagradi i predstavljaju stanja koja su prikazana na slici 3
signal state_reg, state_next: mc_state_type; --Trenutno i sledeće stanje koji su tipa kreiranog liniiju iznad
signal States_s : std_logic_vector(2 downto 0);
begin
    --Registar stanja
    process (Clock, Reset) is
    begin
    if (Reset = '1') then
        state_reg <= start;
    elsif (Clock'event and Clock = '1') then
        state_reg <= state_next;
    end if;
    end process;
    --Registar stanja prikazuje sinhrono ažuriranje trenutnog stanja

    -- Logika za generisanje narednog stanja i izlazna logika
    process (state_reg,IR)
    begin
        IRload  <='0';
        PCload  <='0';
        INmux   <='0';
        Aload   <='0';
        JNZmux  <='0';
        Halt    <='0';
        --Da bi smo izbegli neženjena stanja, na po�?etku je potrebno izvršiti inicijalizaciju ,to jest
        --sve kontrolne signale staviti na svoju inicijalnu vrednost ,u ovom slu�?aju je to 0.

    case state_reg is --Case predstavlja ispitivanje vrednosti trenutnog stanja (state_reg)
    
    when start =>
        States_s    <="000";
        state_next  <= fetch; --Sledeće stanje je fetch
    when fetch =>
        States_s    <="001";
        state_next  <=decode; --Sledeće stanje je decode
        IRload      <='1';
        PCload      <='1';
        INmux       <='1';
        --Ažuriranje određenih kontrolnih signala prema tabeli 1
    
    when decode =>
            States_s    <="010";
        if (IR ="011") then
            state_next  <=input ;
        elsif(IR="100") then
            state_next  <= output;
        elsif(IR="101") then
            state_next  <= dec;
        elsif(IR="110")  then
            state_next  <=jnz;
        elsif(IR="111")  then
            state_next  <=haltt;
        elsif(IR="000")  then
            state_next  <=start;
        elsif(IR="001")  then
            state_next  <=start;
        elsif(IR="010")  then
            state_next  <=start;
        end if; --U delu kodu iznad se prelazilo iz decode u neko od stanja u zavisnosti od tri bita (IR)
    
    when input =>
        States_s    <="011";
        state_next  <=start;
        INmux       <='1';
        Aload       <='1';
    --Ažuriranje određenih kontrolnih signala prema tabeli 1
    
    when output =>
        States_s    <="100";
        state_next  <=start;
        
    when dec =>
        States_s    <="101";
        state_next  <=start;
        Aload       <='1';
    --Ažuriranje određenih kontrolnih signala prema tabeli 1
    
    when jnz =>
    
        States_s    <="110";
        state_next  <=start;
        
        if(Aneq0='1') then
            PCload<='1';
        else
            PCload<='0';
        end if;
            JNZmux<='1';
        --Ažuriranje određenih kontrolnih signala prema tabeli 1
    
    when haltt =>
    
        States_s    <="111";
        
        if(Reset='1') then
            state_next  <=start;
        else
            IRload      <='0';
            PCload      <='0';
            Aload       <='0';
            Halt        <='1';
        end if;
    --Ažuriranje određenih kontrolnih signala prema tabeli 1
    
    end case;
    end process;
    
    States<=States_s;
    
end Behavioral;
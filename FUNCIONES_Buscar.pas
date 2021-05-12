unit FUNCIONES_Buscar;

interface
uses U_REGISTRO_Proyecto, U_REGISTRO_Clientes, U_ARCHIVO_Clientes, U_ARCHIVO_Proyecto;

function Buscar_Cuit_BBIN(Vect_Cliente: Array_REG_Cliente; Cuit_a_buscar: QWord): LongInt;//Numero maximo de 4 bytes
function Buscar_Cuit_Secuencial_En_Archivo(Var a:Arch_Clientes; Var regCliente:REG_Cliente; Cuit_a_buscar: QWord):LongInt;
function Buscar_idProyecto_Secuencial_En_Archivo(Var a:ARCH_Proyecto; Var regproyecto:REG_Proyecto; id_a_buscar:Integer):LongInt;
implementation
uses crt;


    function Buscar_Cuit_BBIN(Vect_Cliente: Array_REG_Cliente; Cuit_a_buscar: QWord): LongInt;
    VAR 
        Pos, i: LongInt;
        primero,ultimo,medio: LongInt;
    begin
        primero:= 0;
        ultimo:= High(Vect_Cliente);
        Pos := -1;

        While (Pos = -1) AND (primero <= ultimo) Do
        begin
            medio:= (primero + ultimo) div 2;
            
            if Vect_Cliente[medio].cuit = Cuit_a_buscar then 
                Pos:= medio
            else
                if Vect_Cliente[medio].cuit > Cuit_a_buscar then 
                    ultimo:= medio -1
            else 
                primero:= medio +1
        end;

        Buscar_Cuit_BBIN:= Pos;
    end;

    function Buscar_Cuit_Secuencial_En_Archivo(Var a:Arch_Clientes; Var regCliente:REG_Cliente; Cuit_a_buscar: QWord):LongInt;
    Var
         Encontrado:LongInt;
    Begin
         Encontrado :=-1;                                                        
         Seek(a,0);
         While not EOF(a) do                                            
         Begin                                                            
              Read(a,regCliente);                                    
              IF regCliente.Cuit = Cuit_a_buscar then                                    
              Begin
                   Encontrado:=FilePos(a)-1;
                   Seek(a,FileSize(a));                       
              End;
         End;
         IF Encontrado <> -1 then                                          
             Buscar_Cuit_Secuencial_En_Archivo:=Encontrado
         Else
             Buscar_Cuit_Secuencial_En_Archivo:=-1;
    end;


    function Buscar_idProyecto_Secuencial_En_Archivo(Var a:ARCH_Proyecto; Var regproyecto:REG_Proyecto; id_a_buscar:Integer):LongInt;
    Var
         PosicionEncontrado:LongInt;
    Begin
         PosicionEncontrado:=-1;                                                        
         Seek(a,0);
         While not EOF(a) do                                            
         Begin                                                            
              Read(a,regproyecto);                                    
              IF regproyecto.id_proyecto = id_a_buscar then                                    
              Begin
                   PosicionEncontrado:=FilePos(a)-1;
                   Seek(a,FileSize(a));                       
              End;
         End;
         IF PosicionEncontrado <> -1 then                                          
             Buscar_idProyecto_Secuencial_En_Archivo:=PosicionEncontrado
         Else
             Buscar_idProyecto_Secuencial_En_Archivo:=-1;
    end;


end.
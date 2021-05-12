unit U_REGISTRO_Proyecto;

interface
    const
        Salto = #13+#10;
    
    type
        fecha = record
            dia: Byte;
            mes: Byte;
            anio: LongWord;
        end;
        REG_Proyecto = record
            id_proyecto: LongWord;
            titulo: String;
            costo: Double;
            cuit: QWord;
            director: String;
            fecha_de_entrega: fecha;  
            exporta, estado: Boolean;
        end;
        Array_REG_Proyecto = array of REG_Proyecto; 

procedure inicializar_registro_proyecto(Var R_Proyecto: REG_Proyecto);
procedure mostrar_registro_proyecto(R_Proyecto: REG_Proyecto);
procedure inicializar_vector_registro_proyecto(Var Vector_Reg_Proyecto: Array_REG_Proyecto);

procedure Cargar_Titulo_Proyecto(Var Titulo: String);
procedure Cargar_Costo_Proyecto(Var Costo: Double);
procedure Cargar_Cuit(Var Cuit: QWord);
procedure Cargar_Director_Proyecto(Var Director: String);
procedure Cargar_Fecha_de_entrega_Proyecto(Var fecha_de_entrega: fecha);
procedure Cargar_Exporta_Proyecto(Var Exporta: Boolean);
procedure CargarFecha1(Var Dia1: byte; Var Mes1: byte; Var Anio1: LongWord);
Procedure CargarFecha2(Var Dia2: byte; Var Mes2: byte; Var Anio2: LongWord);



implementation
uses U_ARCHIVO_Proyecto, crt;

    procedure inicializar_registro_proyecto(Var R_Proyecto: REG_Proyecto);
    begin
        R_Proyecto.id_proyecto:= 0;
        R_Proyecto.titulo:= '';
        R_Proyecto.costo:= 0;
        R_Proyecto.cuit:= 0;
        R_Proyecto.director:= '';
        R_Proyecto.fecha_de_entrega.dia:= 0;
        R_Proyecto.fecha_de_entrega.mes:= 0;
        R_Proyecto.fecha_de_entrega.anio:= 0;
        R_Proyecto.exporta:= False;
        R_Proyecto.estado:= True;//estado es para ver si esta dado de baja o no.
    end;

    procedure mostrar_registro_proyecto(R_Proyecto: REG_Proyecto);
    begin
        WriteLn('ID: ', R_Proyecto.id_proyecto);
        WriteLn('Titulo: ', R_Proyecto.titulo);
        WriteLn('Costo: ', R_Proyecto.costo:0:2);
        WriteLn('Cuit: ', R_Proyecto.cuit);
        WriteLn('Director: ', R_Proyecto.director);
        WriteLn('Fecha de entrega: ', R_Proyecto.fecha_de_entrega.dia,'/', R_Proyecto.fecha_de_entrega.mes, '/', R_Proyecto.fecha_de_entrega.anio);
        WriteLn('Exporta: ', R_Proyecto.exporta);
        if R_Proyecto.estado = false then 
        begin
            WriteLn('Estado: Inactivo')
        end
        else 
        begin
            WriteLn('Estado: Activo')          
        end;
    end;

    procedure inicializar_vector_registro_proyecto(Var Vector_Reg_Proyecto: Array_REG_Proyecto);
    Var
        Archivo_Proyecto: ARCH_Proyecto;
        i: LongWord;
    begin
        Abrir_archivo_proyecto(Archivo_Proyecto);
    
        if FileSize(Archivo_Proyecto) = 0 then
        begin
            SetLength(Vector_Reg_Proyecto, FileSize(Archivo_Proyecto)+1)//Con SethLength le doy el largo al vector.
        end
        else
        begin
            SetLength(Vector_Reg_Proyecto, FileSize(Archivo_Proyecto));
        end;

        Close(Archivo_Proyecto);
        
        for i:= 0 to High(Vector_Reg_Proyecto) do
        begin
            inicializar_registro_proyecto(Vector_Reg_Proyecto[i]);
        end;
    end;

    procedure Cargar_Titulo_Proyecto(Var Titulo: String);
    begin
        Write('Ingrese el titulo: ');
        ReadLn(Titulo);
    end;

    procedure Cargar_Costo_Proyecto(Var Costo: Double);
    begin
        Write('Ingrese el costo: ');
        ReadLn(Costo);
    end;

    procedure Cargar_Cuit(Var Cuit: QWord);
    begin
        Write('Ingrese el Cuit: ');
        ReadLn(Cuit);
    end;

    procedure Cargar_Director_Proyecto(Var Director: String);
    begin
        Write('Ingrese el director: ');
        ReadLn(Director);
    end;

    Procedure CargarFecha1(Var Dia1: byte; Var Mes1: byte; Var Anio1: LongWord);
Var Activo: Boolean;
begin
Activo:= False;
repeat
clrscr;
    writeln('Ingrese Dia Inicial');
    readln(Dia1);
    writeln('Ingrese Mes Incial');
    readln(Mes1);
    writeln('Ingrese Anio Inicial');
    readln(Anio1);
if ((Dia1  > 0) and (Dia1 < 32) and (Mes1 = 1) or (Mes1 = 3) or (Mes1 = 5) or (Mes1 = 7)  or ( Mes1 = 8) or (Mes1 = 10) or (Mes1 = 12) ) then
begin
    writeln(Dia1);
    writeln(Mes1);
    writeln(Anio1);
    Activo:= True
end
else
if ((Dia1  > 0) and (Dia1< 31) and (Mes1 = 4) or (Mes1 = 6) or (Mes1 = 9) or (Mes1 = 11)) then
begin
    writeln(Dia1);
    writeln(Mes1);
    writeln(Anio1);
    Activo := True
end
else
if ((Dia1 > 0) and (Dia1 < 29) and (Mes1 = 2)) then
begin
    writeln(Dia1);
    writeln(Mes1);
    writeln(Anio1);
    Activo:= True;
end
else
begin
    writeln('Fecha Incorrecta Ingrese Nuevamente');
    Activo:= False;
    readkey;
clrscr;
end;
until Activo = True;

end;


Procedure CargarFecha2(Var Dia2: byte; Var Mes2: byte; Var Anio2: LongWord);
Var Activar: Boolean;
begin
    Activar:= False;
repeat
clrscr;
    writeln('Ingrese Dia Final');
    readln(Dia2);
    writeln('Ingrese Mes Final');
    readln(Mes2);
    writeln('Ingrese Anio Final');
    readln(Anio2);
if ((Dia2  > 0) and (Dia2 < 32) and (Mes2 = 1) or (Mes2 = 3) or (Mes2 = 5) or (Mes2 = 7)  or ( Mes2 = 8) or (Mes2 = 10) or (Mes2 = 12) ) then
begin
    writeln(Dia2);
    writeln(Mes2);
    writeln(Anio2);
    Activar:= True;
end
else
if ((Dia2  > 0) and (Dia2< 31) and (Mes2 = 4) or (Mes2 = 6) or (Mes2 = 9) or (Mes2 = 11)) then
begin
    writeln(Dia2);
    writeln(Mes2);
    writeln(Anio2);
    Activar:= True;
end
else
if ((Dia2 > 0) and (Dia2 < 29) and (Mes2 = 2)) then
begin
    writeln(Dia2);
    writeln(Mes2);
    writeln(Anio2);
    Activar:= True;
end
else
begin
    writeln('Fecha Incorrecta Ingrese Nuevamente');
    Activar:= False;
    readkey;
clrscr;
end;
Until Activar = True;

end;



procedure Cargar_Fecha_de_entrega_Proyecto(Var fecha_de_entrega: fecha);
    {const
        len = 1;
    Var
        i:Integer;
        valida:Boolean;
        begin
            i=0;
            valida:=true;
            while (i < 1) do
            begin
                WriteLn('Ingrese El Dia');
                ReadLn(arr[i].dia);
                if (arr[i].dia > 31) then
                    valida:=false
                WriteLn('Ingrese El Mes');
                ReadLn(arr[i].mes);
                if arr[i].mes >12 then
                    valida:=false;
                WriteLn('Ingrese El Año');
                ReadLn(arr[i].anio);
                i:=inc(i);
                end;
if (valida <> true) then
    WriteLn('Fechas Incorecta Ingrese Nuevamente');
end;
begin
    Cargar_Fecha_de_entrega_Proyecto(fecha_de_entrega)
end;}

    begin
        Write('Ingrese el dia: ');
        ReadLn(fecha_de_entrega.dia);
        Write(Salto, 'Ingrese el mes: ');
        ReadLn(fecha_de_entrega.mes);
        Write(Salto, 'Ingrese el anno: ');
        ReadLn(fecha_de_entrega.anio);

    end;

    procedure Cargar_Exporta_Proyecto(Var Exporta: Boolean);
    Var
        Opcion: char;
    begin
        Write('Exportar Proyecto? (Y/N): ');
        
        repeat
          Opcion:= upcase(readkey);
        until Opcion in ['Y','N'];

        if Opcion = 'Y' then
        begin
            Exporta:= True;
        end
        Else
        begin
            Exporta:= False;
        end;
    end;

end.

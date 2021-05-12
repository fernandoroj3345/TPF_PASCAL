Unit U_VERIFICADORES_Archivos;

interface

procedure Verifico_Y_creo_archivo_Proyecto();
procedure Verifico_Y_creo_archivo_Cliente();

implementation
uses U_ARCHIVO_Clientes, U_ARCHIVO_Proyecto;

    procedure Verifico_Y_creo_archivo_Proyecto();
    Var
        ARCHIVO_Proyecto: ARCH_Proyecto;
    begin
        Abrir_archivo_proyecto(ARCHIVO_Proyecto);

        if IOresult <> 0 then //IOreult para ver si existe un error al abrirlo, si el archivo existe no lo crea y sino lo crea y dps cierro.
        begin
            Rewrite(ARCHIVO_Proyecto);
        end;
    
        Close(ARCHIVO_Proyecto);
    end;

    procedure Verifico_Y_creo_archivo_Cliente();
    Var
        ARCHIVO_Cliente: ARCH_Clientes;
    begin
        Abrir_archivo_clientes(ARCHIVO_Cliente);

        if IOresult <> 0 then
        begin
            Rewrite(ARCHIVO_Cliente);
        end;
    
        Close(ARCHIVO_Cliente);
    end;

end.
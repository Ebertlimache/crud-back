@echo off

REM Configurar variables de entorno

set MYSQL_PWD=root
set MYSQL_USER=root

mysql -u %MYSQL_USER% -e "DROP DATABASE IF EXISTS crud_db;"

timeout /t 5 /nobreak > nul

mysql -u %MYSQL_USER% -e "CREATE DATABASE crud_db;"

timeout /t 5 /nobreak > nul

set MYSQL_DATABASE=crud_db

REM Ejecutar el script SQL con codificación UTF-8
mysql -u %MYSQL_USER% -D %MYSQL_DATABASE% --default-character-set=utf8mb4 -e "source script-mysql.sql"

REM Verificar si el script se ejecutó correctamente
if %ERRORLEVEL% neq 0 (
    echo Ocurrio un error al ejecutar el script SQL.
    exit /b %ERRORLEVEL%
) else (
    echo El script SQL se ejecuto correctamente.
)
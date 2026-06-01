@echo off
echo ============================================
echo  ScanSnap Factura Watcher - Instalacion
echo ============================================
echo.

REM Verificar Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python no esta instalado.
    echo Descargalo de https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [1/4] Creando entorno virtual...
python -m venv venv
call venv\Scripts\activate.bat

echo [2/4] Instalando dependencias Python...
pip install -r requirements.txt

echo [3/4] Creando carpetas...
mkdir "C:\Scans\Facturas" 2>nul
mkdir "C:\Scans\Procesados" 2>nul
mkdir "C:\Scans\Errores" 2>nul

echo [4/4] Verificando dependencias del sistema...
echo.
echo ============================================
echo  IMPORTANTE - Dependencias del sistema
echo ============================================
echo.
echo 1. TESSERACT OCR (para PDFs que son imagenes):
echo    Descarga: https://github.com/UB-Mannheim/tesseract/wiki
echo    Instala con idioma "Spanish" seleccionado
echo    Agrega al PATH: C:\Program Files\Tesseract-OCR
echo.
echo 2. ZBAR (para leer codigos de barras):
echo    Se instala automaticamente con pyzbar en la mayoria de casos.
echo    Si falla, descarga: https://sourceforge.net/projects/zbar/
echo.
echo ============================================
echo  CONFIGURACION
echo ============================================
echo.
echo 1. Edita config.py con tu URL de API
echo 2. En ScanSnap Home, configura la carpeta de destino:
echo    C:\Scans\Facturas
echo 3. Ejecuta: iniciar.bat
echo.
echo ============================================
echo  Instalacion completada!
echo ============================================
echo.
echo Deseas registrar el inicio automatico al encender el equipo? (S/N)
set /p RESP="> "
if /i "%RESP%"=="S" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0registrar_inicio.ps1"
)
echo.
pause

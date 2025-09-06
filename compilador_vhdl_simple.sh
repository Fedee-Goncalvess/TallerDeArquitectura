#!/bin/bash

# Función para solicitar la entrada del usuario si la variable está vacía
get_input_if_empty() {
    local prompt_text="$1"
    local var_name="$2"
    
    if [ -z "${!var_name}" ]; then
        read -p "$prompt_text" "$var_name"
    fi
}

# --- Procesar argumentos con opciones (flags) ---
while getopts "f:n:t:" opt; do
    case ${opt} in
        f )
            VHDL_DIR="$OPTARG"
            ;;
        n )
            top_level_entity="$OPTARG"
            ;;
        t )
            tiempo="$OPTARG"
            ;;
        \? )
            echo "Uso: $0 [-f <carpeta>] [-n <entidad>] [-t <tiempo_ns>]"
            exit 1
            ;;
    esac
done

# --- Solicitar valores si faltan argumentos ---
get_input_if_empty "Ingrese la ruta de la carpeta madre: " VHDL_DIR
get_input_if_empty "Ingrese el nombre de la entidad principal (top-level) a simular: " top_level_entity
get_input_if_empty "Ingrese el tiempo de simulación (en ns, ej: 20): " tiempo

# --- Comprobar la existencia de la carpeta y cambiar de directorio ---
if [ ! -d "$VHDL_DIR" ]; then
    echo "❌ Error: La carpeta '$VHDL_DIR' no existe."
    exit 1
fi

echo -e "\n\e[34mCambiando al directorio $VHDL_DIR...\e[0m"
cd "$VHDL_DIR" || { echo "❌ Error al cambiar de directorio"; exit 1; }

# --- Limpiar compilaciones y verificar archivos ---
echo -e "\e[34mLimpiando compilaciones anteriores...\e[0m"
rm -f *.cf *.o *.ghw

if ! find . -name "*.vhd" | read; then
    echo "❌ Error: No se encontraron archivos .vhd en el directorio especificado o en sus subdirectorios."
    exit 1
fi

# --- Proceso de compilación y simulación ---
echo -e "\n\e[32mBuscando y analizando todos los archivos VHDL recursivamente...\e[0m"
find . -name "*.vhd" -print0 | xargs -0 ghdl -a || { echo "❌ Error al analizar uno o más archivos VHDL"; exit 1; }

echo -e "\n\e[32mElaborando la entidad principal '$top_level_entity'...\e[0m"
ghdl -e "$top_level_entity" || { echo "❌ Error al elaborar $top_level_entity"; exit 1; }

echo -e "\n\e[32mSimulando $top_level_entity por $tiempo ns y generando $top_level_entity.ghw...\e[0m"
echo -e "\e[94mSalida de la consola:\e[0m"
ghdl -r "$top_level_entity" --stop-time="${tiempo}ns" --wave="$top_level_entity.ghw" || { echo "❌ Error en simulación"; exit 1; }
echo -e "\e[94mFin de la consola\e[0m"

# --- Abrir en GTKWave ---
echo -e "\e[32mAbriendo GTKWave con $top_level_entity.ghw...\e[0m"
gtkwave "$top_level_entity.ghw" &

exit 0
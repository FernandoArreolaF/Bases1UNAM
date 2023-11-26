param (
    [switch]$buildFlag
)

# Detener y eliminar los contenedores Docker
docker-compose down

# Construir y levantar los contenedores en segundo plano
docker-compose up -d

# Pausa de 5 segundos
Start-Sleep -Seconds 5

# Verificar si la bandera -b está activada
if ($buildFlag) {
    # Ejecutar yarn build
    yarn build

    # Ejecutar yarn start
    yarn start
} else {
    # Ejecutar yarn dev si la bandera -b no está activada
    yarn dev
}

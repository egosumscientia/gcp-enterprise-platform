# ================================
# CONFIG
# ================================
$PROJECT="1071860532328"
$NETWORK="enterprise-vpc"
$RANGE="mysql-enterprise-private-range"
$PEERING="servicenetworking-googleapis-com"

Write-Host "=== LIMPIEZA + DESTROY (UNIFICADO) ==="

function Cleanup-GCP {
    Write-Host "--- Limpieza de Peerings ---"
    gcloud compute networks peerings delete $PEERING --network=$NETWORK --quiet 2>$null

    Write-Host "--- Limpieza de Rangos ---"
    gcloud compute addresses delete $RANGE --global --quiet 2>$null

    Write-Host "--- Limpiando conexiones en Service Networking ---"
    $TOKEN = gcloud auth print-access-token
    $URL = "https://servicenetworking.googleapis.com/v1/projects/$PROJECT/global/networks/$NETWORK:deleteConnection?force=true"
    curl -X POST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" $URL 2>$null

    Write-Host "--- Limpiando Cloud SQL ---"
    $SQL = gcloud sql instances list --format="value(name)"
    foreach ($i in $SQL) {
        gcloud sql instances delete $i --quiet 2>$null
    }

    Write-Host "--- Cleanup finalizado ---"
}

function Check-Residuals {
    $peer = gcloud compute networks peerings list --format="value(name)" 2>$null
    $range = gcloud compute addresses list --global --filter="purpose=VPC_PEERING" --format="value(name)" 2>$null
    $sql = gcloud sql instances list --format="value(name)" 2>$null

    if ($peer -or $range -or $sql) { return $true }
    else { return $false }
}

# ================================
# FASE 1: Limpieza inicial
# ================================
Write-Host ">>> Fase 1: Limpieza inicial"
Cleanup-GCP

# ================================
# FASE 2: Destroy
# ================================
Write-Host ">>> Fase 2: terraform destroy"
terraform destroy -auto-approve

# ================================
# FASE 3: Verificación
# ================================
Write-Host ">>> Fase 3: Verificando residuos..."
$residuals = Check-Residuals

if ($residuals) {
    Write-Host ">>> Detectados residuos. Ejecutando limpieza otra vez..."
    Cleanup-GCP

    Write-Host ">>> Ejecutando terraform destroy nuevamente..."
    terraform destroy -auto-approve
} else {
    Write-Host ">>> Sin residuos. Infraestructura destruida limpiamente."
}

Write-Host "=== COMPLETADO ==="

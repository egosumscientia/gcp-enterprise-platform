# GCP Enterprise Platform – Infraestructura con Terraform

Este proyecto despliega y destruye una arquitectura completa en Google Cloud Platform utilizando módulos de Terraform. Incluye red VPC personalizada, subredes, NAT, bastion host, grupo de instancias administrado (MIG), balanceador de carga y base de datos Cloud SQL.

## Arquitectura

* **VPC privada** con subred pública y subred privada.
* **Cloud NAT** para salida a Internet desde la subred privada.
* **Bastion host** como punto de acceso controlado.
* **Managed Instance Group (MIG)** con plantilla de máquina.
* **HTTP Load Balancer** con regla global.
* **Cloud SQL (MySQL)** accesible solo desde la subred privada.
* Todo administrado mediante módulos estructurados.

## Despliegue

```powershell
pwsh ./deploy.ps1
```

El script ejecuta:

1. Inicialización y validación de Terraform.
2. `terraform apply`.
3. Verificación automática de recursos creados.

Al finalizar, se muestran los valores de salida generados por Terraform (subnets, instancias, IP privada SQL, nombres de recursos, etc.).

## Destrucción

```powershell
pwsh ./destroy_clean.ps1
```

El script realiza:

1. `terraform destroy`.
2. Verificación de residuos.
3. Confirmación de que no quedan instancias, discos, MIGs, LBs ni redes personalizadas.

El sistema queda únicamente con los elementos “default” de GCP.

## Sobre el conteo de recursos

Terraform normalmente reporta cantidades distintas entre recursos creados y destruidos. Esto es normal por:

* Recursos internos creados por Google Cloud que no quedan en el estado.
* Eliminaciones en cadena que GCP realiza automáticamente.
* Diferencias entre “componentes” y “recursos” del estado de Terraform.

No indica errores ni fugas de infraestructura.

## Estado final

* Infraestructura desplegada y destruida correctamente.
* Sin recursos huérfanos.
* Solo permanece la VPC `default` generada por GCP.

## Estructura de directorios

```
/modules
  /vpc
  /sql
  /bastion
  /monolith
/scripts
  deploy.ps1
  destroy_clean.ps1
main.tf
variables.tf
outputs.tf
```

## Requisitos

* Terraform >= 1.5
* PowerShell 7
* Google Cloud SDK
* Proyecto GCP configurado con permisos adecuados

---

Este repositorio sirve como base extensible para arquitecturas mayores en entornos empresariales con Terraform y Google Cloud.

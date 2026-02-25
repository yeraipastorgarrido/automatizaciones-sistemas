# Security Lab: Auditoría y Hardening

Este módulo se centra en la implementación de medidas de seguridad proactivas para reducir la superficie de ataque de los servidores desplegados.

## 🛡️ Herramientas
* **`hardening.sh`**: Script de endurecimiento del kernel y servicios. Deshabilita protocolos obsoletos y asegura que el firewall (UFW) esté configurado con una política de denegación por defecto.

## 📋 Checklist de Seguridad
- [ ] Cambio de puertos por defecto (SSH).
- [ ] Deshabilitar login de root.
- [ ] Aplicación de parches de seguridad críticos mediante el script de puesta a punto.
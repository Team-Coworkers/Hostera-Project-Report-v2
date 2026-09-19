workspace "Hostera" "Plataforma web administrativa para gestión hotelera - Team Coworkers" {

    model {
        staff = person "Personal del Hotel" "Administrador o recepcionista que gestiona reservas, habitaciones, inventario y accesos desde el panel web."

        hostera = softwareSystem "HOSTERA" "Plataforma web administrativa que centraliza la gestión de reservas, disponibilidad de habitaciones, inventario y control de accesos físicos mediante RFID, con panel de monitoreo en tiempo real." {

            webapp = container "Aplicación Web" "Interfaz web (SPA) para gestionar reservas, habitaciones, inventario, accesos y visualizar el dashboard en tiempo real." "React / TypeScript" {
                authUI = component "Autenticación UI" "Pantallas de inicio de sesión y gestión de sesión."
                reservasUI = component "Reservas UI" "Creación y seguimiento de reservas."
                habitacionesUI = component "Habitaciones UI" "Visualización y gestión del estado de habitaciones."
                inventarioUI = component "Inventario UI" "Gestión de stock del almacén."
                accesosUI = component "Accesos UI" "Administración de tarjetas y permisos RFID."
                dashboardUI = component "Dashboard UI" "Panel de monitoreo en tiempo real."
            }

            auth = container "Gestión de Autenticación" "Registra e inicia sesión al personal del hotel y administra roles y permisos." "Node.js / Express" {
                registro = component "Registro de Usuarios" "Procesa el alta de nuevas cuentas del staff."
                validadorCred = component "Validador de Credenciales" "Valida usuario y contraseña."
                sesiones = component "Generador de Sesiones" "Crea y gestiona tokens de sesión (JWT)."
                roles = component "Gestor de Roles" "Administra permisos según el rol (admin, recepción, almacén)."
            }

            reservas = container "Gestión de Reservas y Habitaciones" "Crea y administra reservas; controla la disponibilidad y el estado de las habitaciones." "Node.js / Express" {
                creadorReservas = component "Creador de Reservas" "Registra nuevas reservas y valida los datos del huésped."
                verificadorDisp = component "Verificador de Disponibilidad" "Consulta y bloquea habitaciones disponibles para evitar sobreventa."
                calculadorTarifas = component "Calculador de Tarifas" "Calcula el costo de la reserva según fechas y habitación."
                estadoHabitaciones = component "Gestor de Estado de Habitaciones" "Actualiza el estado de cada habitación (disponible, ocupada, mantenimiento)."
            }

            inventario = container "Gestión de Inventario" "Controla el stock del almacén y genera alertas de reposición." "Node.js / Express" {
                gestorStock = component "Gestor de Stock" "Registra entradas y salidas de insumos del almacén."
                alertasReposicion = component "Generador de Alertas" "Notifica cuando un insumo alcanza el stock mínimo."
                movimientos = component "Registro de Movimientos" "Guarda el historial de movimientos de inventario."
            }

            accesos = container "Gestión de Accesos RFID" "Valida tarjetas RFID, sincroniza eventos con los lectores y mantiene el historial de accesos." "Node.js / Express" {
                validadorTarjeta = component "Validador de Tarjetas" "Verifica que la tarjeta esté activa y autorizada."
                sincronizadorIoT = component "Sincronizador de Eventos IoT" "Recibe y traduce las lecturas enviadas por los lectores RFID."
                permisosAcceso = component "Gestor de Permisos de Acceso" "Asocia tarjetas con habitaciones y define su vigencia."
                historialAccesos = component "Historial de Accesos" "Registra cada evento de acceso concedido o denegado."
            }

            dashboard = container "Servicio de Dashboard" "Agrega y expone datos en tiempo real de reservas, habitaciones, inventario y accesos." "Node.js / WebSocket" {
                agregadorMetricas = component "Agregador de Métricas" "Consulta y combina datos de los demás módulos."
                publicadorEventos = component "Publicador de Eventos en Tiempo Real" "Envía actualizaciones al frontend vía WebSocket."
            }

            db = container "Base de Datos" "Almacena usuarios, reservas, habitaciones e inventario." "PostgreSQL" "Database"
            dbAccesos = container "BD de Accesos" "Almacena el historial de eventos de acceso RFID." "PostgreSQL" "Database"
        }

        rfid = softwareSystem "Sistema de Lectores RFID" "Hardware IoT: lectores y tarjetas RFID instalados en las habitaciones y accesos del hotel." "Existing System"
        notificaciones = softwareSystem "Servicio de Notificaciones" "Servicio externo de correo/SMS usado para confirmaciones y alertas." "Existing System"

        # Relaciones a nivel de contexto y contenedor
        staff -> webapp "Usa" "HTTPS"

        authUI -> auth "Inicia sesión / valida token" "JSON/HTTPS"
        reservasUI -> reservas "Gestiona reservas" "JSON/HTTPS"
        habitacionesUI -> reservas "Gestiona habitaciones" "JSON/HTTPS"
        inventarioUI -> inventario "Gestiona inventario" "JSON/HTTPS"
        accesosUI -> accesos "Gestiona accesos" "JSON/HTTPS"
        dashboardUI -> dashboard "Consulta métricas en tiempo real" "WebSocket"

        auth -> db "Lee/escribe usuarios y roles" "SQL"
        reservas -> db "Lee/escribe reservas y habitaciones" "SQL"
        inventario -> db "Lee/escribe inventario" "SQL"
        accesos -> dbAccesos "Lee/escribe eventos de acceso" "SQL"
        dashboard -> db "Consulta datos agregados" "SQL"
        dashboard -> dbAccesos "Consulta datos agregados" "SQL"

        reservas -> notificaciones "Envía confirmación de reserva" "SMTP/API"
        accesos -> rfid "Envía comandos de autorización/revocación" "MQTT"
        rfid -> accesos "Reporta eventos de lectura de tarjeta" "MQTT"

        # Relaciones a nivel de componente (Autenticación)
        validadorCred -> db "Consulta credenciales" "SQL"
        registro -> db "Crea usuario" "SQL"
        sesiones -> db "Guarda sesión" "SQL"
        validadorCred -> sesiones "Solicita token"
        registro -> validadorCred "Verifica datos"
        roles -> db "Consulta permisos" "SQL"

        # Relaciones a nivel de componente (Reservas y Habitaciones)
        creadorReservas -> verificadorDisp "Verifica disponibilidad"
        verificadorDisp -> estadoHabitaciones "Consulta estado"
        creadorReservas -> calculadorTarifas "Calcula costo"
        creadorReservas -> db "Guarda reserva" "SQL"
        estadoHabitaciones -> db "Actualiza estado" "SQL"
        creadorReservas -> notificaciones "Notifica confirmación"

        # Relaciones a nivel de componente (Inventario)
        gestorStock -> db "Actualiza stock" "SQL"
        gestorStock -> alertasReposicion "Dispara alerta de stock mínimo"
        gestorStock -> movimientos "Registra movimiento"
        movimientos -> db "Guarda historial" "SQL"

        # Relaciones a nivel de componente (Accesos RFID)
        rfid -> sincronizadorIoT "Envía lectura de tarjeta" "MQTT"
        sincronizadorIoT -> validadorTarjeta "Solicita validación"
        validadorTarjeta -> permisosAcceso "Consulta permisos vigentes"
        validadorTarjeta -> sincronizadorIoT "Autoriza/deniega acceso"
        sincronizadorIoT -> rfid "Envía comando de apertura/denegación" "MQTT"
        permisosAcceso -> dbAccesos "Lee/escribe permisos" "SQL"
        validadorTarjeta -> historialAccesos "Notifica resultado"
        historialAccesos -> dbAccesos "Registra evento" "SQL"

        # Relaciones a nivel de componente (Dashboard)
        agregadorMetricas -> db "Consulta reservas, habitaciones e inventario" "SQL"
        agregadorMetricas -> dbAccesos "Consulta accesos" "SQL"
        agregadorMetricas -> publicadorEventos "Envía datos actualizados"
    }

    views {
        systemContext hostera "ContextoHostera" {
            include staff hostera rfid notificaciones
            autoLayout
            description "Diagrama de Contexto del sistema HOSTERA"
        }

        container hostera "ContenedoresHostera" {
            include staff webapp auth reservas inventario accesos dashboard db dbAccesos rfid notificaciones
            autoLayout
            description "Diagrama de Contenedores del sistema HOSTERA"
        }

        component webapp "ComponentesAplicacionWeb" {
            include *
            autoLayout
            description "Componentes de la Aplicación Web"
        }

        component auth "ComponentesAutenticacion" {
            include *
            autoLayout
            description "Componentes de Gestión de Autenticación"
        }

        component reservas "ComponentesReservas" {
            include *
            autoLayout
            description "Componentes de Gestión de Reservas y Habitaciones"
        }

        component inventario "ComponentesInventario" {
            include *
            autoLayout
            description "Componentes de Gestión de Inventario"
        }

        component accesos "ComponentesAccesos" {
            include *
            autoLayout
            description "Componentes de Gestión de Accesos RFID"
        }

        component dashboard "ComponentesDashboard" {
            include *
            autoLayout
            description "Componentes del Servicio de Dashboard"
        }

        styles {
            element "Person" {
                shape Person
                background #1168bd
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
        }
    }
}

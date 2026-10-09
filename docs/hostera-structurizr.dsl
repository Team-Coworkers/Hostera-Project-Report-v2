/*
 * Hostera - C4 model (TB1): system context, containers and components.
 * Angular web application, one Spring Boot RESTful API organised by bounded context, and MySQL.
 * The web application components follow the bounded contexts of the hostera-frontend repository.
 */
workspace "Hostera" "C4 model of Hostera, the hotel operations platform designed by Team Coworkers." {

    model {
        admin = person "Hotel Administrator" "Owner or administrator of an independent hotel who supervises its daily operation."
        ops = person "Operations Manager" "Person responsible for the operation of a small hotel chain with two to five properties."
        staff = person "Hotel Staff" "Front desk, inventory and security operators who run the daily operation of a property."
        rfid = softwareSystem "RFID Lock System" "Door readers and front desk key-card encoder installed in the hotel." {
            tags "External"
        }
        sendgrid = softwareSystem "Twilio SendGrid" "Cloud e-mail delivery service." {
            tags "External"
        }
        holidays = softwareSystem "Nager.Date API" "Free public holidays API of each country." {
            tags "External"
        }
        hostera = softwareSystem "Hostera" "Lets independent hotels and small hotel chains manage bookings, rooms, inventory and RFID room access from one web platform." {
            landing = container "Landing Page" "Static website that presents the plans to each segment and leads visitors to the web application." "HTML, CSS and JavaScript"
            webapp = container "Web Application" "Single-page application with sign-in, the overview, bookings, rooms, inventory and access control features." "Angular 19, TypeScript and Angular Material" {
                shell = component "App Shell" "app.routes.ts and the application shell with the sidebar, the language switcher and the footer." "Angular Router and Angular Material"
                i18n = component "Localization" "I18nService and the en and es-419 message files of every context." "ngx-translate"
                m_iam = component "IAM Module" "Sign-in and sign-up views with the subscription plans." "Angular components and domain model"
                m_overview = component "Overview Module" "Property overview, revenue and occupancy, room status and today's arrivals." "Angular components, signal store and API gateway"
                m_bookings = component "Bookings Module" "Bookings, payments, check-in, check-out and cancellation." "Angular components, signal store and API gateway"
                m_rooms = component "Rooms Module" "Rooms, room types, availability with public holidays, rate plans and daily rates." "Angular components, signal store and API gateways"
                m_inventory = component "Inventory Module" "Inventory items, storage locations and stock adjustments." "Angular components, signal store and API gateway"
                m_access = component "Access Control Module" "Guest and staff credentials, key-card encoding and access events." "Angular components, signal store and API gateway"
                shared = component "Shared Infrastructure" "BaseApiService and BaseEndpoint build every endpoint from the configured API URL." "Angular HttpClient"
            }
            demoapi = container "Demo API" "Serves demonstration data with the same resources while the RESTful API is built." "Node.js and json-server"
            api = container "RESTful API" "Provides the hotel operations functionality through a JSON/HTTPS API organised by bounded context, documented with OpenAPI." "Java 21 and Spring Boot 3" {
                group "IAM" {
                    iamController = component "Authentication Controller" "Endpoints to register an account with its plan, sign in and invite staff members." "Spring REST Controller (interfaces layer)"
                    iamCommands = component "Account Command Service" "Registers organizations and users, signs users in and issues their tokens." "Spring Service (application layer)"
                    iamQueries = component "User Query Service" "Returns users and the properties each one can access." "Spring Service (application layer)"
                    iamDomain = component "User and Organization" "Aggregates with the subscription plan, the role and the allowed properties." "Java classes (domain layer)"
                    iamRepository = component "User Repositories" "Persist users and organizations." "Spring Data JPA Repository (infrastructure layer)"
                    iamAdapter = component "Token and Hashing Services" "Issue JWT tokens and hash passwords with Spring Security." "Spring Component (infrastructure, ACL)"
                }
                group "Overview" {
                    overviewController = component "Overview Controller" "Endpoints for the property overview, daily performance, room status and arrivals." "Spring REST Controller (interfaces layer)"
                    overviewQueries = component "Overview Query Service" "Builds the overview of the active property for a period." "Spring Service (application layer)"
                    overviewDomain = component "Overview Read Models" "Property overview, daily performance and arrival summaries." "Java classes (domain layer)"
                    overviewRepository = component "Overview Read Repository" "Reads bookings, rooms and status periods of the property." "Spring Data JPA Repository (infrastructure layer)"
                }
                group "Bookings" {
                    bookingsController = component "Bookings Controller" "Endpoints for bookings, payments, check-in, check-out and cancellation." "Spring REST Controller (interfaces layer)"
                    bookingsCommands = component "Booking Command Service" "Creates and cancels bookings, records payments and runs check-in and check-out." "Spring Service (application layer)"
                    bookingsQueries = component "Booking Query Service" "Finds bookings by guest, stay period, room and status." "Spring Service (application layer)"
                    bookingsDomain = component "Booking and Payment" "Aggregates with the booking lifecycle and the payments received." "Java classes (domain layer)"
                    bookingsRepository = component "Booking Repositories" "Persist bookings and payments." "Spring Data JPA Repository (infrastructure layer)"
                    bookingsAdapter = component "Context Facades (ACL)" "Ask the Rooms context for availability and rates, and the Access Control context for guest key cards." "Spring Component (infrastructure, ACL)"
                }
                group "Rooms" {
                    roomsController = component "Rooms Controller" "Endpoints for rooms, room types, rate plans, daily rates and status periods." "Spring REST Controller (interfaces layer)"
                    roomsCommands = component "Room Command Service" "Creates rooms and room types, sets daily rates and room status." "Spring Service (application layer)"
                    roomsQueries = component "Availability Query Service" "Returns room availability and status for a period." "Spring Service (application layer)"
                    roomsDomain = component "Room, Room Type and Rate Plan" "Aggregates with the room configuration, rates and status periods." "Java classes (domain layer)"
                    roomsRepository = component "Room Repositories" "Persist rooms, room types, rate plans, daily rates and status periods." "Spring Data JPA Repository (infrastructure layer)"
                }
                group "Inventory" {
                    inventoryController = component "Inventory Controller" "Endpoints for inventory items, storage locations and stock adjustments." "Spring REST Controller (interfaces layer)"
                    inventoryCommands = component "Inventory Command Service" "Registers items and locations and adjusts stock; detects low stock." "Spring Service (application layer)"
                    inventoryQueries = component "Inventory Query Service" "Returns items and their stock condition by storage location." "Spring Service (application layer)"
                    inventoryDomain = component "Inventory Item and Storage Location" "Aggregates with the stock by location and its adjustments." "Java classes (domain layer)"
                    inventoryRepository = component "Inventory Repositories" "Persist items, storage locations and stock adjustments." "Spring Data JPA Repository (infrastructure layer)"
                    inventoryAdapter = component "Notification Gateway" "Sends low-stock alerts by e-mail." "Spring Component (infrastructure, ACL)"
                }
                group "Access Control" {
                    accessController = component "Access Control Controller" "Endpoints for credentials, staff members and access events, including events reported by the readers." "Spring REST Controller (interfaces layer)"
                    accessCommands = component "Credential Command Service" "Issues guest key cards and staff credentials, and revokes or replaces them." "Spring Service (application layer)"
                    accessQueries = component "Access Event Query Service" "Returns access events by room, credential and period." "Spring Service (application layer)"
                    accessDomain = component "Credential and Access Event" "Aggregates with the credential validity and each access attempt." "Java classes (domain layer)"
                    accessRepository = component "Access Control Repositories" "Persist credentials, staff members and access events." "Spring Data JPA Repository (infrastructure layer)"
                    accessAdapter = component "RFID Encoder Adapter" "Writes credentials through the front desk encoder." "Spring Component (infrastructure, ACL)"
                }
            }
            db = container "Database" "Stores accounts, properties, bookings, payments, rooms, rates, inventory, credentials and access events." "MySQL 8" {
                tags "Database"
            }
        }

        admin -> hostera "Supervises bookings, rooms, inventory and room access using"
        ops -> hostera "Monitors every property of the chain using"
        staff -> hostera "Registers bookings, stays, stock movements and key cards using"
        hostera -> rfid "Encodes key cards and updates access rights using"
        rfid -> hostera "Reports door access events to"
        hostera -> sendgrid "Sends low-stock alerts using"
        hostera -> holidays "Reads the public holidays of the country from"
        admin -> landing "Reviews the plans in"
        ops -> landing "Reviews the plans in"
        admin -> webapp "Supervises the operation using"
        ops -> webapp "Monitors every property using"
        staff -> shell "Runs the daily operation using"
        landing -> m_iam "Opens the sign-in and plan views of"
        shell -> i18n "Translates the labels with"
        shell -> m_iam "Routes to"
        shell -> m_overview "Routes to"
        m_overview -> shared "Uses"
        shell -> m_bookings "Routes to"
        m_bookings -> shared "Uses"
        shell -> m_rooms "Routes to"
        m_rooms -> shared "Uses"
        shell -> m_inventory "Routes to"
        m_inventory -> shared "Uses"
        shell -> m_access "Routes to"
        m_access -> shared "Uses"
        shared -> demoapi "Sends requests to" "JSON/HTTPS"
        shared -> api "Sends requests to" "JSON/HTTPS"
        m_rooms -> holidays "Reads public holidays from" "JSON/HTTPS"
        m_access -> rfid "Encodes key cards through" "Simulated in this version"
        api -> db "Reads from and writes to" "JDBC"
        webapp -> iamController "Makes API requests to" "JSON/HTTPS"
        iamController -> iamCommands "Sends commands to"
        iamCommands -> iamDomain "Applies the business rules of"
        iamCommands -> iamRepository "Reads and writes through"
        iamController -> iamQueries "Sends queries to"
        iamQueries -> iamRepository "Reads through"
        iamRepository -> db "Reads from and writes to" "JDBC"
        iamCommands -> iamAdapter "Uses"
        webapp -> overviewController "Makes API requests to" "JSON/HTTPS"
        overviewController -> overviewQueries "Sends queries to"
        overviewQueries -> overviewRepository "Reads through"
        overviewRepository -> db "Reads from and writes to" "JDBC"
        webapp -> bookingsController "Makes API requests to" "JSON/HTTPS"
        bookingsController -> bookingsCommands "Sends commands to"
        bookingsCommands -> bookingsDomain "Applies the business rules of"
        bookingsCommands -> bookingsRepository "Reads and writes through"
        bookingsController -> bookingsQueries "Sends queries to"
        bookingsQueries -> bookingsRepository "Reads through"
        bookingsRepository -> db "Reads from and writes to" "JDBC"
        bookingsCommands -> bookingsAdapter "Uses"
        webapp -> roomsController "Makes API requests to" "JSON/HTTPS"
        roomsController -> roomsCommands "Sends commands to"
        roomsCommands -> roomsDomain "Applies the business rules of"
        roomsCommands -> roomsRepository "Reads and writes through"
        roomsController -> roomsQueries "Sends queries to"
        roomsQueries -> roomsRepository "Reads through"
        roomsRepository -> db "Reads from and writes to" "JDBC"
        webapp -> inventoryController "Makes API requests to" "JSON/HTTPS"
        inventoryController -> inventoryCommands "Sends commands to"
        inventoryCommands -> inventoryDomain "Applies the business rules of"
        inventoryCommands -> inventoryRepository "Reads and writes through"
        inventoryController -> inventoryQueries "Sends queries to"
        inventoryQueries -> inventoryRepository "Reads through"
        inventoryRepository -> db "Reads from and writes to" "JDBC"
        inventoryCommands -> inventoryAdapter "Uses"
        inventoryAdapter -> sendgrid "Calls" "HTTPS"
        webapp -> accessController "Makes API requests to" "JSON/HTTPS"
        accessController -> accessCommands "Sends commands to"
        accessCommands -> accessDomain "Applies the business rules of"
        accessCommands -> accessRepository "Reads and writes through"
        accessController -> accessQueries "Sends queries to"
        accessQueries -> accessRepository "Reads through"
        accessRepository -> db "Reads from and writes to" "JDBC"
        accessCommands -> accessAdapter "Uses"
        accessAdapter -> rfid "Calls" "HTTPS"
        rfid -> accessController "Reports access events to" "HTTPS"
    }

    views {
        systemContext hostera "SystemContext" {
            include *
            autoLayout tb
        }
        container hostera "Containers" {
            include *
            autoLayout tb
        }
        component webapp "WebApplicationComponents" {
            include *
            autoLayout tb
        }
        component api "ApiIamComponents" {
            include ->iamController-> webapp db
            autoLayout tb
        }
        component api "ApiOverviewComponents" {
            include ->overviewController-> webapp db
            autoLayout tb
        }
        component api "ApiBookingsComponents" {
            include ->bookingsController-> webapp db
            autoLayout tb
        }
        component api "ApiRoomsComponents" {
            include ->roomsController-> webapp db
            autoLayout tb
        }
        component api "ApiInventoryComponents" {
            include ->inventoryController-> webapp db
            autoLayout tb
        }
        component api "ApiAccessControlComponents" {
            include ->accessController-> webapp db
            autoLayout tb
        }
        styles {
            element "Person" {
                shape Person
                background #08427B
                color #ffffff
            }
            element "Software System" {
                background #1168BD
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438DD5
                color #ffffff
            }
            element "Component" {
                background #85BBF0
                color #000000
            }
            element "Database" {
                shape Cylinder
            }
        }
    }
}

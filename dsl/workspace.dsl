workspace "Macetech - Smart Gardening Platform" "An IoT-based platform to monitor and care for plants automatically, modeled similarly to Big Bank plc example." {


    model {

        // Personas
        hobbyistUser = person "Enthusiastic Gardener" "Cares for their plants casually at home."
        expertUser = person "Experienced Gardener" "Cares for many or exotic plants, wants more control."

        // Dispositivo y servicios externos
        smartPot = softwareSystem "Macetech Smart Pot Hardware" "Smart pot with sensors and actuator for irrigation." "Hardware" {
            tags "External System"
        }
        firebaseExternalService = softwareSystem "Firebase" "Cloud service for user 2FA authentication and email verification." "External Service" {
            tags "External System"
        }
        geoAPI = softwareSystem "GeoAPI" "Provides geolocation services." "External Service" {
            tags "External System"
        }
        plantAPI = softwareSystem "PlantAPI" "Provides plant identification services." "External Service" {
            tags "External System"
        }
        stripeExternalService = softwareSystem "Stripe" "Payment processing service." "External Service" {
            tags "External System"
        }

        macetechPlatform = softwareSystem "Macetech Platform" "An IoT-based platform to monitor and care for plants automatically." {

            // Contenedor Landing Page
            landingPageWebsite = container "Macetech Landing Page" "Landing page for the Macetech platform." "HTML5/CSS/JavaScript" {
                uiWeb = component "Web UI" "Shows plant care features, team members, contact information and contains a call to action." "HTML5/CSS/JavaScript"
            }

            // Contenedor Web Client App (WCA)
            webClientApp = container "Macetech Single Page Client App" "Client-Side Angular frontend application executed in user's browser that consumes backend APIs." "Angular" "Web Browser" {
                wcaAuth = component "WCA Login Component" "Handles login and session state." "Angular"
                wcaHome = component "WCA Home Component" "Displays the rest of components and has a toolbar to navigate through the application." "Angular"
                wcaDashboard = component "WCA Dashboard Component" "Displays a list of smart pots linked to the users profile." "Angular"
                wcaPotDetails = component "WCA Pot Details Component" "Displays detailed information about a specific smart pot." "Angular"
                wcaSettings = component "WCA Settings Component" "Manages user preferences and configurations for smart pots like irrigation, report generation, etc." "Angular"
                wcaProfile = component "WCA Profile Component" "Manages user profile." "Angular"
            }

            // Contenedor Mobile App
            mobileApp = container "Mobile Application" "Flutter-based mobile app consuming backend APIs." "Flutter" "Mobile App" {
                mobLogin = component "Mobile Login Screen" "Authenticates the user and initializes session." "Flutter"
                mobPotRegister = component "Mobile Pot Register Screen" "Sends the user to the camera to scan the QR." "Flutter"
                mobPasswordRecovery = component "Mobile Password Recovery Screen" "Handles password recovery for users." "Flutter"
                mobPotDetails = component "Mobile Pot Details Screen" "Modifies settings, preferences, etc. for smart pots like irrigation, report generation, etc." "Flutter"
                mobPlantIdentification = component "Mobile Plant Identification Screen" "Identifies plants using user inputs." "Flutter"
                mobHome = component "Mobile Home Screen" "Displays the rest of components and has a toolbar to navigate through the application." "Flutter"
                mobDashboard = component "Mobile Dashboard" "Displays a list of smart pots linked to the users profile." "Flutter"
                mobGardeningRecommendation = component "Mobile Gardening Recommendation Screen" "Provides gardening recommendations based on Plant Identification." "Flutter"
                mobNotifications = component "Mobile Notifications Component" "Shows recommendations and alerts." "Flutter" 
                mobSensorsAlert = component "Mobile Sensors Alert Component" "Handles alerts from sensors." "Flutter"      
                mobSettings = component "Mobile Settings Component" "User preferences and configurations." "Flutter"      
                mobProfile = component "Mobile Profile Component" "User profile management." "Flutter"        
            }

            // Bases de datos
            plantDB = container "Plant Database" "Stores all persistent domain data across all backend components." "MySQL" "Database"
            edgeDB = container "Edge SQLite Database" "Stores all edge application information." "SQLite" "Database"
            mobileDB = container "Mobile SQLite Database" "Stores mobile application data for performance on the device." "SQLite" "Database"

            // App de borde (edge)
            edgeApp = container "Edge Application" "Edge software for plant analytics." "Python" {
                edgeMonitoring = component "Edge Monitoring" "Monitors pot sensors data." "Python"
                edgeWatering = component "Edge Watering" "Controls irrigation based on sensor data." "Python"
                edgeNoticeSystem = component "Notification System" "Sends a notice to the user with the reports and recommendations." "Python"
            }

            // App embebida
            embeddedApp = container "Embedded Application" "Embedded software controlling the Smart Pot Hardware." "C++" {
                embParameterManager = component "Harvesting Parameter Manager" "Manages plant parameters." "C++"
                embDeviceController = component "Device Controller" "Interacts with sensors." "C++"
            }

            // API Monolítica
            monolithApp = container "Monolithic API Application" "Domain-driven monolith exposing HTTP APIs for plant care automation." "C# .NET" {
                
                group "Care Intelligence Bounded Context Components (Core BC)" {
                    coreCareIntelligenceController = component "Care Intelligence Controller" "Handles care intelligence-related requests. " "C# .NET Controller"
                    coreCareIntelligenceAggregate = component "Recommendation Aggregate" "Root aggregate for care intelligence. " "C# .NET Domain Model"
                    coreRecommendationRepo = component "Recommendation Repository" "Handles recommendation persistence. " "C# .NET Repository"
                }

                group "Watering Bounded Context Components (Core BC)" { 
                    coreWateringController = component "Watering Controller" "Handles watering requests. " "C# .NET Controller"
                    coreWateringRepo = component "Watering Repository" "Stores watering data. " "C# .NET Repository"
                    coreWateringCondition = component "Watering Condition" "Represents watering conditions. " "C# .NET Domain Model"
                }

                group "Pot Management Bounded Context Components (Support BC)" {
                    sptPotController = component "Pot Controller" "Handles pot-related requests. " "C# .NET Controller"
                    sptPotRepo = component "Pot Repository" "Stores pot data. " "C# .NET Repository"
                    sptPotAggregate = component "Pot Aggregate" "Represents a smart pot. " "C# .NET Domain Model"
                }

                group "Plant Bounded Context Components (Support BC)" {
                    sptPlantController = component "Plant Controller" "Handles /plants endpoints. " "C# .NET Controller"
                    sptPlantRepo = component "Plant Repository" "Persists species and tolerance data. " "C# .NET Repository"
                    sptPlantApiIntegration = component "PlantAPI Integration" "Client for external plant API. " "C# .NET Integration"
                    sptPlantAggregate = component "Plant Aggregate" "Root aggregate for plant entity. " "C# .NET Domain Model"
                }

                group "System Monitoring & Control Bounded Context Components (Support BC)" {
                    sptAlertController = component "Alert Controller" "Handles /alerts endpoints. " "C# .NET Controller"
                    sptAlertRepo = component "Alert Repository" "Persists system alerts. " "C# .NET Repository"
                    sptAlertAggregate = component "Alert Aggregate" "Root for sensor alerts. " "C# .NET Domain Model"
                    sptNotificationAggregate = component "Notification Aggregate" "Scheduled push/email notifications. " "C# .NET Domain Model"
                }

                group "Data Insights & Reporting Bounded Context (Support BC)" {
                    sptReportController = component "Report Controller" "Handles /reports endpoints. " "C# .NET Controller"
                    sptSensorController = component "Sensor Controller" "Handles /sensor-data endpoints. " "C# .NET Controller"
                    sptReportRepo = component "Report Repository" "Stores generated reports. " "C# .NET Repository"
                    sptSensorRepo = component "Sensor Repository" "Persists raw sensor data. " "C# .NET Repository"
                    sptReportAggregate = component "Report Aggregate" "Container for metrics and analysis. " "C# .NET Domain Model"
                    sptSensorDataVO = component "Sensor Data Value Object" "Sensor readings with metadata. " "C# .NET Domain Model"
                }

                group "Identification Authentication Management Bounded Context (Commodity BC)" {
                    genUserController = component "Auth Controller" "Handles user-related requests. " "C# .NET Controller"
                    genUserManagementController = component "User Management Controller" "Handles user management requests. " "C# .NET Controller"
                    genTwoFAService = component "2FA Service" "Handles two-factor authentication. " "C# .NET Service"
                    genFirebaseIntegration = component "Firebase Integration" "Integrates with Firebase for 2FA. " "C# .NET Integration"
                    genUserRepo = component "User Repository" "Handles user data storage. " "C# .NET Repository"
                    genUserAggregate = component "User Aggregate" "Represents a user in the system. " "C# .NET Domain Model"
                    genUserRoleEntity = component "User Role Entity" "Defines user roles and permissions. " "C# .NET Domain Model"
                }

                group "Profiles and Personal Data Bounded Context (Commodity BC)" {
                    genProfileController = component "Profile Controller" "Handles profile-related requests. " "C# .NET Controller"
                    genProfileRepo = component "Profile Repository" "Handles profile data storage. " "C# .NET Repository"
                    genGeoApiIntegration = component "GeoAPI Integration" "Integrates with GeoAPI for geolocation. " "C# .NET Integration"
                    genProfileAggregate = component "Profile Aggregate" "Represents a user profile. " "C# .NET Domain Model"
                }
                
                

                group "Subscription Bounded Context Components (Commodity BC)" {
                    genSubscriptionController = component "Subscription Controller" "Handles subscription requests. " "C# .NET Controller"
                    genSubscriptionRepo = component "Subscription Repository" "Stores subscription data. " "C# .NET Repository"
                    genStripeIntegration = component "Stripe Integration" "Handles payment integration with Stripe. " "C# .NET Integration"
                    genSubscriptionAggregate = component "Subscription Aggregate" "Represents a user subscription. " "C# .NET Domain Model"
                    genPaymentAggregate = component "Payment Aggregate" "Represents a payment. " "C# .NET Domain Model"
                }
            }
        }

        // Relationships
        hobbyistUser -> uiWeb "Browses marketing and informational content" "HTTPS"
        expertUser -> uiWeb "Browses marketing and informational content" "HTTPS"

        uiWeb -> webClientApp "Navigates to web client application" "HTTPS"

        hobbyistUser -> wcaAuth "Authenticates to access web application" "HTTPS"
        expertUser -> wcaAuth "Authenticates to access web application" "HTTPS"
        wcaAuth -> wcaHome "Redirects user to home view after login"
        wcaHome -> wcaDashboard "Navigates to dashboard to view linked smart pots"
        wcaHome -> wcaSettings "Navigates to settings to manage pot configurations"
        wcaHome -> wcaProfile "Navigates to user profile"

        // Relaciones entre Bounded Contexts (Solo mediante controllers)
        // Web Client → Monolith
        wcaProfile -> genProfileController "Updates profile via API" "JSON/HTTPS"
        wcaDashboard -> sptPlantController "Gets user's plants" "JSON/HTTPS"
        wcaSettings -> coreWateringController "Updates configurations" "JSON/HTTPS"
        wcaAuth -> genUserController "Authenticates via JWT" "JSON/HTTPS"

        // Mobile App relationships
        hobbyistUser -> mobLogin "Accesses mobile application login"
        expertUser -> mobLogin "Accesses mobile application login"
        mobLogin -> mobPotRegister "Navigates to register new pot"
        mobPotRegister -> mobLogin "Returns to login after registration"
        mobLogin -> mobHome "Accesses mobile home screen after login"
        mobLogin -> mobPasswordRecovery "Recovers user password"
        mobHome -> mobDashboard "Navigates to dashboard"
        mobHome -> mobSettings "Navigates to app or pot settings"
        mobHome -> mobProfile "Navigates to user profile"
        mobPotRegister -> mobPotDetails "Navigates to detailed view"
        mobPotDetails -> mobPlantIdentification "Triggers plant identification"
        mobPotDetails -> mobGardeningRecommendation "Requests recommendations"
        mobHome -> mobNotifications "Displays notifications"
        mobHome -> mobSensorsAlert "Displays sensor alerts"

        // Mobile local storage
        mobPotDetails -> mobileDB "Caches pot data" "SQLite"
        mobGardeningRecommendation -> mobileDB "Stores suggestions" "SQLite"
        mobSettings -> mobileDB "Persists preferences" "SQLite"
        mobProfile -> mobileDB "Caches profile" "SQLite"
        mobNotifications -> mobileDB "Stores alerts" "SQLite" 
        mobSensorsAlert -> mobileDB "Reads sensor history" "SQLite"

        // === Estructura Base por BC (Aggregate → Repo → Controller) ===
        // User BC
        genUserAggregate -> genUserRepo "Stores user data" "SQL/TCP"
        genUserRepo -> genUserController "Manages user operations" "SQL/TCP"

        // Profile BC
        genProfileAggregate -> genProfileRepo "Stores profile/weather data" "SQL/TCP"
        genProfileRepo -> genProfileController "Manages profile operations" "SQL/TCP"

        // Plant BC
        sptPlantAggregate -> sptPlantRepo "Stores species data" "SQL/TCP"
        sptPlantRepo -> sptPlantController "Manages plant operations" "SQL/TCP"

        // Monitoring BC (Sensores/Alertas)
        sptSensorRepo -> sptSensorController "Manages sensors" "SQL/TCP"
        sptAlertAggregate -> sptAlertRepo "Stores alerts" "SQL/TCP"
        sptAlertRepo -> sptAlertController "Triggers notifications" "SQL/TCP"

        // Data Insights BC (Reportes)
        sptReportAggregate -> sptReportRepo "Persists analytics" "SQL/TCP"
        sptReportRepo -> sptReportController "Generates reports" "SQL/TCP"

        // Pot Management BC
        sptPotAggregate -> sptPotRepo "Stores pot configurations" "SQL/TCP"
        sptPotRepo -> sptPotController "Manages pots" "SQL/TCP"

        // Watering BC
        coreWateringRepo -> coreWateringController "Controls watering" "SQL/TCP"

        // Care Intelligence ↔ Weather/Reports/Sensores/Plant
        coreCareIntelligenceController -> genProfileController "Requests weather data" "JSON/HTTPS"
        coreCareIntelligenceController -> sptReportController "Analiza reportes históricos" "JSON/HTTPS"
        coreCareIntelligenceController -> sptSensorController "Obtiene métricas en tiempo real" "JSON/HTTPS"
        coreCareIntelligenceController -> sptPlantController "Consulta especies registradas" "JSON/HTTPS"

        // User → Profile (Creación vinculada)
        genUserController -> genProfileController "Crea perfil al registrar usuario" "JSON/HTTPS"

        // Alertas → Reportes
        sptAlertController -> sptReportController "Genera reporte técnico de alerta" "JSON/HTTPS"

        // Pot Management → Watering
        sptPotController -> coreWateringController "Ajusta programación de riego" "JSON/HTTPS"


        // === Relaciones con Externos (Mantenidas) ===
        genStripeIntegration -> stripeExternalService "Processes payments" "API Call/HTTPS"
        genGeoApiIntegration -> geoAPI "Gets location" "API Call/HTTPS"

        // External Services ↔ Integrations (Obligatorias)
        sptPlantApiIntegration -> sptPlantController "Identifies species" "API Call/HTTPS"
        genFirebaseIntegration -> firebaseExternalService "Verifies 2FA, Sends Email Verification" "API Call/HTTPS"
        sptPlantApiIntegration -> plantAPI "Identifies species" "API Call/HTTPS"

        // Aggregates ↔ Repos (Obligatorias)
        genUserRoleEntity -> genUserRepo "Stores user roles" "SQL/TCP"
        genPaymentAggregate -> genSubscriptionRepo "Stores payment data" "SQL/TCP"
        genSubscriptionAggregate -> genSubscriptionRepo "Stores subscription data" "SQL/TCP"
        coreWateringCondition -> coreWateringRepo "Stores watering conditions" "SQL/TCP"
        sptReportAggregate -> sptReportRepo "Stores report data" "SQL/TCP"
        sptNotificationAggregate -> sptAlertRepo "Stores notification data" "SQL/TCP"
        sptAlertAggregate -> sptAlertRepo "Stores alert data" "SQL/TCP"
        sptPotAggregate -> sptPotRepo "Stores pot data" "SQL/TCP"        
        genProfileAggregate -> genProfileRepo "Stores profile data" "SQL/TCP"
        sptPlantAggregate -> sptPlantRepo "Stores plant data" "SQL/TCP"

        // Repos ↔ Controllers
        coreRecommendationRepo -> coreCareIntelligenceController "Stores recommendations" "SQL/TCP"
        genSubscriptionRepo -> genSubscriptionController "Manages subscription data" "SQL/TCP"
        sptReportRepo -> sptReportController "Manages report data" "SQL/TCP"
        sptSensorRepo -> sptSensorController "Manages sensor data" "SQL/TCP"
        sptPotRepo -> sptPotController "Manages pot data" "SQL/TCP"
        sptAlertRepo -> sptAlertController "Manages alert data" "SQL/TCP"
        genUserRepo -> genUserController "Manages user data" "SQL/TCP"
        sptPlantRepo -> sptPlantController "Manages plant data" "SQL/TCP"
        coreWateringRepo -> coreWateringController "Manages watering data" "SQL/TCP"
        genProfileRepo -> genProfileController "Manages profile data" "SQL/TCP"
        genUserRepo -> genUserManagementController "Manages user data" "SQL/TCP"
        genUserRepo -> genTwoFAService "Manages 2FA data" "SQL/TCP"
        genUserRepo -> genUserAggregate "Manages user data" "SQL/TCP"
        genProfileRepo -> genProfileAggregate "Manages profile data" "SQL/TCP"
        
        // Integrations ↔ Controllers
        genStripeIntegration -> genSubscriptionController "Processes payments" "API Call/HTTPS"
        genGeoApiIntegration -> genProfileController "Gets location" "API Call/HTTPS"
        genFirebaseIntegration -> genUserController "Verifies 2FA code" "API Call/HTTPS"

        // Mobile → Monolith
        mobPlantIdentification -> sptPlantController "Submits plant data" "JSON/HTTPS"
        mobProfile -> genProfileController "Syncs profile" "JSON/HTTPS"
        mobLogin -> genUserController "Authenticates" "JSON/HTTPS"
        mobSettings -> coreWateringController "Saves settings" "JSON/HTTPS"

        // Comunicación entre componentes del propio bounded context (válidas)
        sptSensorDataVO -> sptReportAggregate "Stores sensor data" "SQL/TCP"
        genSubscriptionController -> genProfileRepo "Changes User Subscription" "SQL/TCP"
        sptPlantController -> sptPlantRepo "Stores plant data" "SQL/TCP"
        coreWateringController -> coreWateringRepo "Stores watering data" "SQL/TCP"

        // Edge computing
        edgeMonitoring -> sptSensorController "Monitors sensor data" "HTTPS"
        edgeWatering -> coreWateringController "Controls irrigation" "HTTPS"
        edgeNoticeSystem -> sptNotificationAggregate "Sends notifications" "HTTPS"
        edgeNoticeSystem -> mobileApp "Sends notifications" "HTTPS"
        edgeApp -> sptSensorController "Streams sensor data" "HTTPS"
        edgeApp -> edgeDB "Caches analytics" "SQLite"
        embDeviceController -> smartPot "Controls hardware" "Direct Connection"
        embDeviceController -> embParameterManager "Sends sensor data" "Direct Connection"
        sptPlantAggregate -> plantAPI "Identifies plant species" "API Call/HTTPS"

        // Embedded system flow
        smartPot -> embDeviceController "Sends sensor readings" "Sensor Interface"
        embParameterManager -> edgeMonitoring "Sends plant parameters" "Sensor Interface"
        embParameterManager -> edgeNoticeSystem "Sends alerts" "Sensor Interface"
        embDeviceController -> edgeWatering "Sends irrigation commands" "Sensor Interface"


        deploymentEnvironment "Development"{
            deploymentNode "Developer Laptop" "Local Development Environment" "Microsoft Windows 10 or Apple macOS" {
                deploymentNode "Web Browser" "User's Browser" "Chrome, Firefox, Safari, or Edge" {
                    devWebClientInstance = containerInstance webClientApp
                    devLandingPageInstance = containerInstance landingPageWebsite 
                }
                deploymentNode "Docker Engine" "Local Docker Environment" "Docker Desktop" {
                    deploymentNode "Backend Services Container Group" "Simulated Backend" "Docker Compose" {
                        devMonolithInstance = containerInstance monolithApp
                        devPlantDBInstance = containerInstance plantDB
                        devEdgeAppInstance = containerInstance edgeApp 
                        devEdgeDBInstance = containerInstance edgeDB
                    }
                }
                deploymentNode "Mobile Emulator" "Simulated Mobile Device" "Android Studio Emulator or iOS Simulator" {
                    devMobileAppInstance = containerInstance mobileApp
                    devMobileDBInstance = containerInstance mobileDB 
                }
                deploymentNode "Embedded Simulator" "Simulated SmartPot firmware" "QEMU or custom simulator" {
                    devEmbeddedAppInstance = containerInstance embeddedApp
                }
            }
    
        }
        deploymentEnvironment "Production Environment" {
    
            deploymentNode "User Devices" "End-user devices" {
                deploymentNode "Web Browser" "Chrome/Firefox/Safari" "Browser" {
                    containerInstance webClientApp
                }
        
                deploymentNode "Mobile Device" "iOS/Android" "Mobile" {
                    containerInstance mobileApp
                    containerInstance mobileDB
                }
            }
    
            deploymentNode "SmartPot Hardware" "Physical IoT Device" "ARM Cortex-M4" {
                deploymentNode "Embedded Firmware" "FreeRTOS" {
                    containerInstance embeddedApp
                }
            }
    
            deploymentNode "Azure Cloud" {
                deploymentNode "Azure App Service" "Landing Page Hosting" {
                    containerInstance landingPageWebsite
                }
        
                deploymentNode "AKS Cluster" "Kubernetes Cluster" {
                    deploymentNode "API Pod" ".NET Core" {
                        containerInstance monolithApp {
                            description "Domain-driven monolith with 12 bounded contexts"
                            tags "Monolith"
                        }
                    }
            
                    deploymentNode "Edge Service Pod" "Python" {
                        containerInstance edgeApp
                        containerInstance edgeDB
                    }
                }
        
                deploymentNode "Azure Database" "Managed MySQL" {
                    containerInstance plantDB
                }
        
                deploymentNode "Azure Cosmos DB" "NoSQL for Edge Cache" {
                    containerInstance edgeDB
                }
        
                deploymentNode "Infrastructure Services" {
                    deploymentNode "Azure Load Balancer" "Traffic distribution" {
                        tags "Infrastructure"
                    }
            
                    deploymentNode "Azure DNS" "Domain management" {
                        tags "Infrastructure"
                    }
            
                    deploymentNode "MQTT Broker" "IoT Communication" "Azure IoT Hub" {
                        tags "Infrastructure"
                    }
                    deploymentNode "External Services" {
                        softwareSystemInstance firebaseExternalService
                        softwareSystemInstance geoAPI
                        softwareSystemInstance plantAPI
                        softwareSystemInstance stripeExternalService
                    }

                    # Relaciones clave
                    edgeApp -> edgeDB "Local caching" "SQLite"
                    mobileApp -> monolithApp "API Calls" "HTTPS/JSON"
                    webClientApp -> monolithApp "API Calls" "HTTPS/JSON"
                    monolithApp -> firebaseExternalService "Auth integration" "HTTPS"
                    monolithApp -> stripeExternalService "Payments" "HTTPS"
                }
            }
        }
    }

    views {
        systemLandscape "MacetechLandscape" {
            include *
            autolayout lr
            description "The System Landscape diagram for the Macetech Smart Gardening Platform."
            properties {
                structurizr.groups false
            }
        }

        systemContext macetechPlatform "SystemContext" {
            include *
            // Adding animation similar to BigBank example
            animation {
                macetechPlatform
                hobbyistUser expertUser
                smartPot firebaseExternalService geoAPI plantAPI stripeExternalService
            }
            autolayout lr
            description "The System Context diagram for the Macetech Smart Gardening Platform."
            properties {
                structurizr.groups false
            }
        }

        container macetechPlatform "Containers" { 
            include *
            // Adding animation similar to BigBank example
            animation {
                hobbyistUser expertUser smartPot firebaseExternalService geoAPI plantAPI stripeExternalService
                landingPageWebsite webClientApp mobileApp monolithApp
                edgeApp embeddedApp
                plantDB edgeDB mobileDB
            }
            autolayout lr
            description "The Container diagram for the Macetech Smart Gardening Platform."
        }

        component monolithApp "MonolithComponents" {
            include *
            // Animation for key interactions, can be expanded
            animation {
                webClientApp mobileApp edgeApp plantDB firebaseExternalService geoAPI plantAPI stripeExternalService 
                // Key controllers
                coreWateringController sptPlantController genUserController genProfileController
                // Key services and repositories
                coreWateringRepo sptPlantRepo genUserRepo 
            }
            autolayout lr
            description "The Component diagram for the Monolithic API Application."
        }

        deployment macetechPlatform "Production Environment" {
            include *
            autolayout tb
            description "Despliegue en ambiente productivo Azure"
            
            animation {
                webClientApp
                mobileApp
                embeddedApp
                monolithApp
                edgeApp
                plantDB
                firebaseExternalService
                stripeExternalService
            }
        }

        component webClientApp "WCAComponents" { 
            include *
            autolayout lr
            description "The Component diagram for the Macetech Web Client Application."
        }

        component mobileApp "MobileAppComponents" { 
            include *
            autolayout lr
            description "The Component diagram for the Mobile Application."
        }
        
        component edgeApp "EdgeComponents" { 
            include *
            autolayout lr
            description "The Component diagram for the Edge Application."
        }

        component embeddedApp "EmbeddedComponents" { 
            include *
            autolayout lr
            description "The Component diagram for the Embedded Application."
        }

        component landingPageWebsite "LandingPageComponents" {
            include *
            autolayout lr
            description "The Component diagram for the Landing Page Website."
        }
        
        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
                fontSize 22
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" { 
                shape WebBrowser
            }
            element "Mobile App" { 
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
                background #6db33f
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Hardware" {
                shape RoundedBox
                background #666666
                color #ffffff
            }
            element "Controller" {
                background #D3D3D3
                color #000000
                shape RoundedBox
            }
            element "Service" {
                background #E6E6FA
                color #000000
                shape RoundedBox
            }
            element "Repository" {
                background #FFFACD
                color #000000
                shape RoundedBox
            }
            element "Integration" {
                background #ADD8E6
                color #000000
                shape RoundedBox
            }
            element "Facade" {
                background #F0E68C
                color #000000
                shape RoundedBox
            }
            element "Domain Model" {
                background #FFFFFF
                color #000000
                shape Component
            }
            element "Core BC" { 
                background #2e7d32 
                color #ffffff
                shape RoundedBox
            }
            element "Support BC" { 
                background #fbc02d
                color #000000
                shape RoundedBox
            }
            element "Generic BC" { 
                background #9e9e9e
                color #000000
                shape RoundedBox
            }

        }
    }
}
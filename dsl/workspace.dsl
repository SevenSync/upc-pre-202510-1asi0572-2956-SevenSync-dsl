workspace "Macetech - Smart Gardening Platform" "DDD Strategic Bounded Contexts in a .NET MVC monolithic architecture with frontend clients" {

    model {

// PLEASE REMEMBER, AN OUTBOUND SERVICE IS A SERVICE THAT A BOUNDED CONTEXT USES TO COMMUNICATE WITH ANOTHER BOUNDED CONTEXT

        // Personas
        hobbyistUser = person "Enthusiastic Gardener" "Cares for their plants casually at home."
        expertUser = person "Experienced Gardener" "Cares for many or exotic plants, wants more control."

        // Dispositivo y servicios externos
        smartPot = softwareSystem "Macetech Smart Pot Hardware" "Smart pot with sensors and actuator for irrigation." "Hardware"

        firebaseExternalService = softwareSystem "Firebase" "Cloud service for user 2FA authentication and email verification." "External Service"
        geoAPI = softwareSystem "GeoAPI" "Provides geolocation services." "External Service"
        plantAPI = softwareSystem "PlantAPI" "Provides plant identification services." "External Service"
        stripeExternalService = softwareSystem "Stripe" "Payment processing service." "External Service"

        macetechPlatform = softwareSystem "Macetech Platform" "An IoT-based platform to monitor and care for plants automatically." {

            LandingPageWebsite = container "Macetech Landing Page" "Landing page for the Macetech platform." "HTML5/CSS/JavaScript" {
                uiWeb = component "Web UI" "Shows plant care features, team members, contact information and contains a call to action." "HTML5/CSS/JavaScript"
            }

            // Contenedor WCA
            WebClientApp = container "Macetech Web Client App" "Client-Side Angular frontend application executed in user's browser that consumes backend APIs." "Angular" {
                uiWCAAuth = component "WCA Login Component" "Handles login and session state." "Angular"
                uiWCAHome = component "WCA Home Component" "Displays the rest of components and has a toolbar to navigate through the application." "Angular"
                uiWCADashboard = component "WCA Dashboard Component" "Displays a list of smart pots linked to the users profile." "Angular"
                uiWCAPotDetails = component "WCA Pot Details Component" "Displays detailed information about a specific smart pot." "Angular"
                uiWCASettings = component "WCA Settings Component" "Manages user preferences and configurations for smart pots like irrigation, report generation, etc." "Angular"
                uiWCAProfile = component "WCA Profile Component" "Manages user profile." "Angular"                
            }

            // Contenedor Mobile App
            mobileApp = container "Mobile Application" "Flutter-based mobile app consuming backend APIs." "Flutter" {
                uiMobileLogin = component "Mobile Login Screen" "Authenticates the user and initializes session." "Flutter"
                uiMobilePotRegister = component "Mobile Pot Register Screen" "Sends the user to the camera to scan the QR." "Flutter"                                
                uiMobilePasswordRecovery = component "Mobile Password Recovery Screen" "Handles password recovery for users." "Flutter"                
                uiMobilePotDetails = component "Mobile Pot Details Screen" "Modifies settings, preferences, etc. for smart pots like irrigation, report generation, etc.." "Flutter"                
                uiPlantIdentification = component "Mobile Plant Identification Screen" "Identifies plants using user inputs." "Flutter"                
                uiMobileHome = component "Mobile Home Screen" "Displays the rest of components and has a toolbar to navigate through the application." "Flutter"
                uiMobileDashboard = component "Mobile Dashboard" "Displays a list of smart pots linked to the users profile." "Flutter"
                uiMobileGardeningRecommendation = component "Mobile Gardening Recommendation Screen" "Provides gardening recommendations based on Plant Identification." "Flutter"                               
                uiMobileNotifications = component "Mobile Notifications" "Shows recommendations and alerts." "Flutter"
                uiMobileSensorsAlert = component "Mobile Sensors Alert" "Handles alerts from sensors." "Flutter"
                uiMobileSettings = component "Mobile Settings" "User preferences and configurations." "Flutter"
                uiMobileProfile = component "Mobile Profile" "User profile management." "Flutter"
            }

            // Bases de datos
            plantDB = container "Plant Database" "Stores all persistent domain data across all backend components." "MySQL" "Database"
            edgeDB = container "Edge SQLite Database" "Stores all edge application information." "SQLite" "Database"
            mobileDB = container "Mobile SQLite Database" "Stores mobile application data for performance on the device." "SQLite" "Database"

            // App de borde (edge)
            edgeApp = container "Edge Application" "Edge software for plant analytics." "Python" {
                plantContext = component "Plant Context" "Generates plant reports from parameters." "Python"
                plantIdentification = component "Plant Identification" "Sets information of the plant inside the Smart Pot." "Python"    
                noticeSystem = component "Notification System" "Sends a notice to the user with the reports and recommendations." "Python"
            }

            // App embebida
            embeddedApp = container "Embedded Application" "Embedded software controlling the Smart Pot Hardware." "C++" {
                parameterManager = component "Harvesting Parameter Manager" "Manages plant parameters." "C++"
                deviceController = component "Device Controller" "Interacts with sensors." "C++"                
            }

            // API monolítica
            monolithApp = container "Single unified software application" "Domain-driven monolith exposing HTTP APIs for plant care automation." "C# .NET" {

                // Bounded Contexts de dominio, que son el enfoque del negocio, conteniendo los procesos clave del negocio
                group "Core Bounded Contexts" {

                    
                    // --- Care Intelligence ---
                    //  - Plant Registration: Registro de plantas, tolerancias, etc.
                    component "Care Intelligence Controller" "Handles care intelligence-related requests." "C# .NET" {
                    tags "CareIntelligence", "Interface Layer"
                    }

                    component "Care Intelligence Anti Corruption Layer" "Facade for other Bounded Contexts." "C# .NET" {
                        tags "CareIntelligence", "Interface Layer"
                    }

                    component "Recommendation Query Service" "Handles recommendation queries." "C# .NET" {
                        tags "CareIntelligence", "Application Layer"
                    }

                    component "Recommendation Command Service" "Handles recommendation commands." "C# .NET" {
                        tags "CareIntelligence", "Application Layer"
                    }

                    component "External Report Service" "Integrates with external reporting." "C# .NET" {
                        tags "CareIntelligence", "Application Layer"
                    }

                    component "External Profile Service" "Integrates with external profile services." "C# .NET" {
                        tags "CareIntelligence", "Application Layer"
                    }

                    component "External Plant Service" "Integrates with external plant services." "C# .NET" {
                        tags "CareIntelligence", "Application Layer"
                    }

                    component "Recommendation Repository" "Handles recommendation persistence." "C# .NET" {
                        tags "CareIntelligence", "Infrastructure Layer"
                    }

                    component "User" "Represents a user in the system." "C# .NET" {
                        tags "CareIntelligence", "Domain Layer"
                    }

                    component "User Role" "Defines user roles." "C# .NET" {
                        tags "CareIntelligence", "Domain Layer"
                    }

                    component "Report Id Value Object" "Represents a report ID." "C# .NET" {
                        tags "CareIntelligence", "Domain Layer"
                    }

                    component "Profile Id Value Object" "Represents a profile ID." "C# .NET" {
                        tags "CareIntelligence", "Domain Layer"
                    }

                    component "Plant Id Value Object" "Represents a plant ID." "C# .NET" {
                        tags "CareIntelligence", "Domain Layer"
                    }

                    // --- Watering Management ---
                    //  - Watering: Manejo de riego, condiciones, etc.
                    component "Watering Controller" "Handles watering requests." "C# .NET" {
                        tags "WateringManagement", "Interface Layer"
                    }

                    component "Watering Anti Corruption Layer" "Facade for watering logic." "C# .NET" {
                        tags "WateringManagement", "Interface Layer"
                    }

                    component "Watering Query Service" "Handles watering queries." "C# .NET" {
                        tags "WateringManagement", "Application Layer"
                    }

                    component "Watering Command Service" "Handles watering commands." "C# .NET" {
                        tags "WateringManagement", "Application Layer"
                    }

                    component "Watering Repository" "Stores watering data." "C# .NET" {
                        tags "WateringManagement", "Infrastructure Layer"
                    }

                    component "Watering Schedule" "Represents watering schedules." "C# .NET" {
                        tags "WateringManagement", "Domain Layer"
                    }

                    component "Watering Condition" "Represents watering conditions." "C# .NET" {
                        tags "WateringManagement", "Domain Layer"
                    }
                }

                // Bounded Contexts de soporte, que no son el enfoque del negocio pero son necesarios para el funcionamiento de la plataforma
                group "Support Bounded Contexts" {

                    // --- Plant Management ---
                    //  - Plant Registration: Registro de plantas, tolerancias, etc.
                    component "User Controller" "Handles user requests." "C# .NET" {
                        tags "PlantManagement", "Interface Layer"
                    }

                    component "IAM Access Control List" "Manages access and roles." "C# .NET" {
                        tags "PlantManagement", "Interface Layer"
                    }

                    component "User Query Service" "Handles user queries." "C# .NET" {
                        tags "PlantManagement", "Application Layer"
                    }

                    component "User Command Service" "Handles user commands." "C# .NET" {
                        tags "PlantManagement", "Application Layer"
                    }

                    component "2FA Service" "Handles two-factor authentication." "C# .NET" {
                        tags "PlantManagement", "Application Layer"
                    }

                    component "User Repository" "Stores user data." "C# .NET" {
                        tags "PlantManagement", "Infrastructure Layer"
                    }

                    component "Firebase Integration" "Firebase for auth/2FA." "C# .NET" {
                        tags "PlantManagement", "Infrastructure Layer"
                    }

                    component "User" "Represents a user." "C# .NET" {
                        tags "PlantManagement", "Domain Layer"
                    }

                    component "User Role" "Defines user roles." "C# .NET" {
                        tags "PlantManagement", "Domain Layer"
                    }

                    // --- Plant Registration ---
                    //  - Plant Registration: Registro de plantas, tolerancias, etc.
                    component "Alert Controller" "Handles alert requests." "C# .NET" {
                        tags "SystemMonitoring", "Interface Layer"
                    }

                    component "Notification Controller" "Handles notification requests." "C# .NET" {
                        tags "SystemMonitoring", "Interface Layer"
                    }

                    component "Alert Anti Corruption Layer" "Facade for alerts." "C# .NET" {
                        tags "SystemMonitoring", "Interface Layer"
                    }

                    component "Notification Anti Corruption Layer" "Facade for notifications." "C# .NET" {
                        tags "SystemMonitoring", "Interface Layer"
                    }

                    component "Alert Query Service" "Queries alerts." "C# .NET" {
                        tags "SystemMonitoring", "Application Layer"
                    }

                    component "Alert Command Service" "Commands for alerts." "C# .NET" {
                        tags "SystemMonitoring", "Application Layer"
                    }

                    component "Notification Query Service" "Queries notifications." "C# .NET" {
                        tags "SystemMonitoring", "Application Layer"
                    }

                    component "Notification Command Service" "Commands for notifications." "C# .NET" {
                        tags "SystemMonitoring", "Application Layer"
                    }

                    component "Alert Repository" "Stores alerts." "C# .NET" {
                        tags "SystemMonitoring", "Infrastructure Layer"
                    }

                    component "Notification Repository" "Stores notifications." "C# .NET" {
                        tags "SystemMonitoring", "Infrastructure Layer"
                    }

                    component "Alert" "Represents an alert." "C# .NET" {
                        tags "SystemMonitoring", "Domain Layer"
                    }

                    component "Notification" "Represents a notification." "C# .NET" {
                        tags "SystemMonitoring", "Domain Layer"
                    }

                    // --- Report Management ---
                    //  - Report Management: Generación de reportes, métricas, etc.
                    component "Report Controller" "Handles report requests." "C# .NET" {
                        tags "DataInsights", "Interface Layer"
                    }

                    component "Sensor Controller" "Handles sensor requests." "C# .NET" {
                        tags "DataInsights", "Interface Layer"
                    }

                    component "Report Anti Corruption Layer" "Facade for reporting." "C# .NET" {
                        tags "DataInsights", "Interface Layer"
                    }

                    component "Report Query Service" "Handles report queries." "C# .NET" {
                        tags "DataInsights", "Application Layer"
                    }

                    component "Report Command Service" "Handles report commands." "C# .NET" {
                        tags "DataInsights", "Application Layer"
                    }

                    component "External Sensor Service" "Integrates with sensors." "C# .NET" {
                        tags "DataInsights", "Application Layer"
                    }

                    component "Report Repository" "Stores reports." "C# .NET" {
                        tags "DataInsights", "Infrastructure Layer"
                    }

                    component "Sensor Repository" "Stores sensor data." "C# .NET" {
                        tags "DataInsights", "Infrastructure Layer"
                    }

                    component "Report Aggregate" "Represents a report." "C# .NET" {
                        tags "DataInsights", "Domain Layer"
                    }

                    component "Report Metrics" "Represents metrics." "C# .NET" {
                        tags "DataInsights", "Domain Layer"
                    }

                    component "Sensor Data" "Sensor measurements." "C# .NET" {
                        tags "DataInsights", "Domain Layer"
                    }

                    component "Sensor" "Represents a sensor." "C# .NET" {
                        tags "DataInsights", "Domain Layer"
                    }
                }
                // Bounded Contexts Genericos, no relacionados con el dominio ni enfoque del negocio
                group "Generic/Commodity Bounded Contexts" {

                    // --- User Management ---
                    //  - User Management: Manejo de usuarios, autenticación, etc.
                    component "User Management Controller" "Handles user management requests." "C# .NET" {
                        tags "IAM", "Interface Layer"
                    }

                    component "User Management Anti Corruption Layer" "Facade for user management." "C# .NET" {
                        tags "IAM", "Interface Layer"
                    }
                   component "User Controller" "Handles user-related requests." "C# .NET" {
                        tags "IAM", "Interface Layer"
                    }

                    component "IAM Access Control List" "Manages user roles and permissions." "C# .NET" {
                        tags "IAM", "Interface Layer"
                    }

                    component "User Query Service" "Handles user-related queries." "C# .NET" {
                        tags "IAM", "Application Layer"
                    }

                    component "User Command Service" "Handles user-related commands." "C# .NET" {
                        tags "IAM", "Application Layer"
                    }

                    component "2FA Service" "Handles two-factor authentication." "C# .NET" {
                        tags "IAM", "Application Layer"
                    }

                    component "User Repository" "Handles user data storage." "C# .NET" {
                        tags "IAM", "Infrastructure Layer"
                    }

                    component "Firebase Integration" "Integrates with Firebase for 2FA and verification." "C# .NET" {
                        tags "IAM", "Infrastructure Layer"
                    }

                    component "User Aggregate" "Represents a user in the system." "C# .NET" {
                        tags "IAM", "Domain Layer"
                    }

                    component "User Role Entity" "Defines user roles and permissions." "C# .NET" {
                        tags "IAM", "Domain Layer"
                    }

                    // --- Profile Management ---
                    //  - Profile Management: Manejo de perfiles, preferencias, etc.
                    component "Profile Controller" "Handles profile-related requests." "C# .NET" {
                        tags "Profiles", "Interface Layer"
                    }

                    component "Profile Anti Corruption Layer" "Facade to process profile-related requests." "C# .NET" {
                        tags "Profiles", "Interface Layer"
                    }

                    component "Profile Query Service" "Handles profile-related queries." "C# .NET" {
                        tags "Profiles", "Application Layer"
                    }

                    component "Profile Command Service" "Handles profile-related commands." "C# .NET" {
                        tags "Profiles", "Application Layer"
                    }

                    component "Profile Repository" "Handles profile data storage." "C# .NET" {
                        tags "Profiles", "Infrastructure Layer"
                    }

                    component "GeoAPI Integration" "Integrates with GeoAPI for geolocation." "C# .NET" {
                        tags "Profiles", "Infrastructure Layer"
                    }

                    component "Profile Aggregate" "Represents a user profile in the system." "C# .NET" {
                        tags "Profiles", "Domain Layer"
                    }

                    component "Subscription Controller" "Handles subscription requests." "C# .NET" {
                        tags "Subscriptions", "Interface Layer"
                    }

                    // --- Subscription Management ---
                    // - Subscription Management: Manejo de suscripciones, pagos, etc.
                    component "Subscription Anti Corruption Layer" "Facade for subscriptions." "C# .NET" {
                        tags "Subscriptions", "Interface Layer"
                    }

                    component "Subscription Query Service" "Handles subscription queries." "C# .NET" {
                        tags "Subscriptions", "Application Layer"
                    }

                    component "Subscription Command Service" "Handles subscription commands." "C# .NET" {
                        tags "Subscriptions", "Application Layer"
                    }

                    component "2FA Service" "Handles two-factor auth." "C# .NET" {
                        tags "Subscriptions", "Application Layer"
                    }

                    component "External Payment Service" "Integrates with Stripe." "C# .NET" {
                        tags "Subscriptions", "Application Layer"
                    }

                    component "Subscription Repository" "Stores subscription data." "C# .NET" {
                        tags "Subscriptions", "Infrastructure Layer"
                    }

                    component "Stripe Integration" "Handles payment integration with Stripe." "C# .NET" {
                        tags "Subscriptions", "Infrastructure Layer"
                    }

                    component "Subscription Aggregate" "Represents a user subscription." "C# .NET" {
                        tags "Subscriptions", "Domain Layer"
                    }

                    component "Payment Aggregate" "Represents a payment." "C# .NET" {
                        tags "Subscriptions", "Domain Layer"
                    } 
                }
            }
        }

        // Relaciones usuario → UI
        hobbyistUser -> uiWeb "Browses marketing and informational content"
        expertUser -> uiWeb "Browses marketing and informational content"

        hobbyistUser -> uiWCAAuth "Authenticates to access web application"
        expertUser -> uiWCAAuth "Authenticates to access web application"
        uiWCAAuth -> uiWCAHome "Redirects user to home view after login"
        uiWCAHome -> uiWCADashboard "Navigates to dashboard to view linked smart pots"
        uiWCAHome -> uiWCASettings "Navigates to settings to manage pot configurations"
        uiWCAHome -> uiWCAProfile "Navigates to user profile"

        uiWCAProfile -> monolithApp "Updates and retrieves user profile information"
        uiWCADashboard -> monolithApp "Retrieves list of smart pots for the user"
        uiWCASettings -> monolithApp "Saves and loads pot configuration data"
        uiWCAAuth -> monolithApp "Performs login and session handling"

        hobbyistUser -> uiMobileLogin "Accesses mobile application login"
        expertUser -> uiMobileLogin "Accesses mobile application login"
        uiMobileLogin -> uiMobilePotRegister "Navigates to register new pot"
        uiMobilePotRegister -> uiMobileLogin "Returns to login after registration"
        uiMobileLogin -> uiMobileHome "Accesses mobile home screen after login"
        uiMobileLogin -> uiMobilePasswordRecovery "Recovers user password"
        uiMobileHome -> uiMobileDashboard "Navigates to dashboard"
        uiMobileHome -> uiMobileSettings "Navigates to app or pot settings"
        uiMobileHome -> uiMobileProfile "Navigates to user profile"
        uiMobilePotRegister -> uiMobilePotDetails "Navigates to detailed view of registered pot"
        uiMobilePotDetails -> uiPlantIdentification "Triggers plant identification based on pot data"
        uiMobilePotDetails -> uiMobileGardeningRecommendation "Requests recommendations for identified plant"
        uiMobileHome -> uiMobileNotifications "Displays system notifications and alerts"
        uiMobileHome -> uiMobileSensorsAlert "Displays sensor-based alerts"

        uiMobilePotDetails -> mobileDB "Reads and stores pot-specific local data"
        uiMobileGardeningRecommendation -> mobileDB "Stores and retrieves plant care suggestions"
        uiMobileSettings -> mobileDB "Persists user-defined settings"
        uiMobileProfile -> mobileDB "Stores profile data locally"
        uiMobileNotifications -> mobileDB "Stores and retrieves notifications"
        uiMobileSensorsAlert -> mobileDB "Reads alerts from local storage"

        uiPlantIdentification -> monolithApp "Sends plant data for backend identification"
        uiMobileGardeningRecommendation -> monolithApp "Requests AI-based recommendations"
        uiMobileProfile -> monolithApp "Syncs profile updates with backend"
        uiMobileLogin -> monolithApp "Authenticates user via backend"
        uiMobileSettings -> monolithApp "Stores pot or app settings centrally"
        uiMobilePotRegister -> monolithApp "Registers new smart pot"



        // Backend general
        monolithApp -> plantDB "Reads and writes persistent plant-related data"
        profiles -> plantDB "Reads and updates user roles and profile data"
        profiles -> userManagement "Fetches user identity and account data"
        aiService -> externalGemini "Requests AI-based plant care insights"
        aiService -> gardeningRecommendation "Enhances recommendations with AI insights"

        // Edge ↔ Backend ↔ Embedded
        edgeApp -> monolithApp "Sends processed plant data and analytics"
        edgeApp -> edgeDB "Stores intermediate edge data locally"
        embeddedApp -> edgeApp "Sends sensor data and receives configuration commands"

        // Componentes internos
        edgeApp -> plantRegistration "Requests plant tolerance data for analysis"
        edgeApp -> reportManagement "Sends data to be transformed into reports"
        gardeningRecommendation -> edgeApp "Requests raw plant analytics for recommendation logic"
        plantRegistration -> gardeningRecommendation "Provides plant-specific thresholds and traits"
        reportManagement -> gardeningRecommendation "Supplies recent plant condition reports"
        gardeningRecommendation -> plantDB "Persists generated recommendations"
        userManagement -> plantDB "Stores and validates user credentials and accounts"
        reportManagement -> plantDB "Persists generated and historical reports"
        plantRegistration -> plantDB "Stores species and tolerance data"

        // Componentes de la app embebida
        embeddedApp -> plantContext "Requests processing of real-time plant parameters"
        plantContext -> monolithApp "Communicates with backend for data sync or config"
        monolithApp -> plantContext "Sends control commands or parameters for edge app"

        plantIdentification -> monolithApp "Registers identified plant to user account"
        monolithApp -> plantIdentification "Pushes plant identification request to edge"

        plantContext -> edgeDB "Stores parameter results and reports locally"
        plantIdentification -> careIntelligence "Supplies identified plant info for analysis"
        plantContext -> careIntelligence "Supplies parameter data for care analysis"
        careIntelligence -> noticeSystem "Triggers notifications with actionable care advice"

        parameterManager -> edgeApp "Receives configuration parameters"
        deviceController -> parameterManager "Applies settings and manages hardware interfaces"
        smartPot -> deviceController "Sends raw sensor data to be interpreted"

    }
    

    views {
        systemLandscape macetechPlatform "MacetechLandscape" {
            include *
            autolayout lr
        }

        systemContext macetechPlatform "SystemContext" {
            include *
            autolayout lr
        }

        container macetechPlatform "ContainerView" {
            include *
            autolayout lr
        }

        component edgeApp "EdgeApplicationDiagram" {
            include *
            autolayout lr
        }

        component embeddedApp "EmbeddedApplicationDiagram" {
            include *
            autolayout lr
        }

        component monolithApp "MonolithComponentsDiagram" {
            include *
            autolayout lr
        }

        component WebClientApp "WCAComponentsDiagram" {
            include *
            autolayout lr
        }

        component mobileApp "MobileAppComponentsDiagram" {
            include *
            autolayout lr
        }

        component LandingPageWebsite "LandingPageComponentsDiagram" {
            include *
            autolayout lr
        }

        styles {
            element "Person" {
                shape Person
            }

            element "Software System" {
                background #1168bd
                color #ffffff
            }

            element "Container" {
                background #438dd5
                color #ffffff
            }

            element "Component" {
                background #85bbf0
                color #000000
            }

            element "Database" {
                shape Cylinder
                background #438dd5
                color #ffffff
            }

            element "Hardware" {
                shape RoundedBox
                background #666666
                color #ffffff
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

            element "Commodity BC" {
                background #9e9e9e
                color #000000
                shape RoundedBox
            }

            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}

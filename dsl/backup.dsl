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

                    //  - Caring Intelligence: Generación de recomendaciones y generacion de reportes.
                    careIntelligence = container "Care Intelligence Bounded Context" "Creates personalized recommendations from plant type and reports." "Core BC" {
                        group "Interface Layer" {
                            careIntelligenceController = component "Care Intelligence Controller" "Handles care intelligence-related requests." "C# .NET"
                            careIntelligenceACL = component "Care Intelligence Anti Corruption Layer" "Facade to process care intelligence-related requests for other bounded contexts." "C# .NET"
                        }
                        group "Application Layer" {
                            recommendationQueryService = component "Recommendation Query Service" "Handles recommendation-related queries." "C# .NET"
                            recommendationCommandService = component "Recommendation Command Service" "Handles recommendation-related commands." "C# .NET"
                            externalReportService = component "External Report Service" "Integrates with external reporting services." "C# .NET"
                            externalProfileService = component "External Profile Service" "Integrates with external profile services." "C# .NET"
                            externalPlantService = component "External Plant Service" "Integrates with external plant services." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            recommendationRepository = component "Recommendation Repository" "Handles recommendation data storage." "C# .NET"
                        }
                        group "Domain Layer" {
                            user = component "User" "Represents a user in the system." "C# .NET"
                            userRole = component "User Role" "Defines roles and permissions for users." "C# .NET"
                            reportId = component "Report Id Value Object" "Represents a report identification." "C# .NET"
                            profileId = component "Profile Id Value Object" "Represents a user profile identification." "C# .NET"
                            plantId = component "Plant Id Value Object" "Represents a plant identification." "C# .NET"                           
                        }
                    }

                    //  - Watering Management: Support de Pot Management, configura el sistema de riego pues es un proceso demasiado complejo como para ponerlo solo en pot management       
                    wateringManagement = component "Watering Management Bounded Context" "Manages irrigation and watering schedules." "Support BC" {
                        group "Interface Layer" {
                            wateringController = component "Watering Controller" "Handles watering-related requests." "C# .NET"
                            wateringACL = component "Watering Anti Corruption Layer" "Facade to process watering-related requests for other bounded contexts." "C# .NET"
                        }
                        group "Application Layer" {
                            wateringQueryService = component "Watering Query Service" "Handles watering-related queries." "C# .NET"
                            wateringCommandService = component "Watering Command Service" "Handles watering-related commands." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            wateringRepository = component "Watering Repository" "Handles watering data storage." "C# .NET"
                        }
                        group "Domain Layer" {
                            wateringSchedule = component "Watering Schedule" "Represents a watering schedule for a plant." "C# .NET"
                            wateringCondition = component "Watering Condition" "Defines conditions for watering." "C# .NET"
                        }
                    }
                }

                // Bounded Contexts de soporte, que no son el enfoque del negocio pero son necesarios para el funcionamiento de la plataforma
                group "Support Bounded Contexts" {

                    //  - Plant Management: CRUD de plantas, configuracion de plantas (nombre, id, tolerancias, etc.)
                    plantManagement = component "Plant Management Bounded Context" "Expert knowledge base of plant species and their tolerances." "Core BC" {
                        group "Interface Layer" {
                            userController = component "User Controller" "Handles user-related requests." "C# .NET"
                            iamACL = component "IAM Access Control List" "Manages user permissions and roles." "C# .NET"
                        }
                        group "Application Layer" {
                            userQueryService = component "User Query Service" "Handles user-related queries." "C# .NET"
                            userCommandService = component "User Command Service" "Handles user-related commands." "C# .NET"
                            2FAService = component "2FA Service" "Handles two-factor authentication." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            userRepository = component "User Repository" "Handles user data storage." "C# .NET"
                            firebaseIntegration = component "Firebase Integration" "Integrates with Firebase for email verification and 2FA Multifactor." "C# .NET"
                        }
                        group "Domain Layer" {
                            user = component "User" "Represents a user in the system." "C# .NET"
                            userRole = component "User Role" "Defines roles and permissions for users." "C# .NET"                             
                        }
                    }

                    //  - Pot Management: CRUD de macetas, configuracion de macetas (nombre, id, etc.)
                    potManagement = component "Pot Management Bounded Context" "Manages smart pot configurations and settings." "Core BC" {
                        group "Interface Layer" {
                            userController = component "User Controller" "Handles user-related requests." "C# .NET"
                            iamACL = component "IAM Access Control List" "Manages user permissions and roles." "C# .NET"
                        }
                        group "Application Layer" {
                            userQueryService = component "User Query Service" "Handles user-related queries." "C# .NET"
                            userCommandService = component "User Command Service" "Handles user-related commands." "C# .NET"
                            2FAService = component "2FA Service" "Handles two-factor authentication." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            userRepository = component "User Repository" "Handles user data storage." "C# .NET"
                            firebaseIntegration = component "Firebase Integration" "Integrates with Firebase for email verification and 2FA Multifactor." "C# .NET"
                        }
                        group "Domain Layer" {
                            user = component "User" "Represents a user in the system." "C# .NET"
                            userRole = component "User Role" "Defines roles and permissions for users." "C# .NET"                             
                        }
                    }

                    // - System Monitoring & Control: alertas y notificaciones criticas de los sensores, como por ejemplo si la maceta se queda sin agua o si la planta no tiene suficiente luz
                    systemMonitoring = component "System Monitoring & Control Bounded Context" "Manages Critical Alerts and Notifications from sensors analysis/responses." "Support BC" {
                        group "Interface Layer" {
                            alertController = component "Alert Controller" "Handles alert-related requests." "C# .NET"
                            notificationController = component "Notification Controller" "Handles notification-related requests." "C# .NET"
                            alertACL = component "Alert Anti Corruption Layer" "Facade to process alert-related requests for other bounded contexts." "C# .NET"
                            notificationACL = component "Notification Anti Corruption Layer" "Facade to process notification-related requests for other bounded contexts." "C# .NET"
                        }
                        group "Application Layer" {
                            alertQueryService = component "Alert Query Service" "Handles alert-related queries." "C# .NET"
                            alertCommandService = component "Alert Command Service" "Handles alert-related commands." "C# .NET"
                            notificationQueryService = component "Notification Query Service" "Handles notification-related queries." "C# .NET"
                            notificationCommandService = component "Notification Command Service" "Handles notification-related commands." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            alertRepository = component "Alert Repository" "Handles alert data storage." "C# .NET"
                            notificationRepository = component "Notification Repository" "Handles notification data storage." "C# .NET"
                        }
                        group "Domain Layer" {    
                            alert = component "Alert" "Represents an alert in the system." "C# .NET"
                            notification = component "Notification" "Represents a notification in the system." "C# .NET"
                        }
                    }
                    
                    // - Data Insights & Reporting: Recopilacion e interpretacion de datos de sensores mediante reportes y metricas,
                    datainsights&reporting = component "Data Insights & Reporting Bounded Context" "Generates reports and insights from plant data." "Support BC" {
                        group "Interface Layer" {
                            reportController = component "Report Controller" "Handles report-related requests." "C# .NET"
                            sensorController = component "Sensor Controller" "Handles sensor-related requests." "C# .NET"
                            reportACL = component "Report Anti Corruption Layer" "Facade to process report-related requests for other bounded contexts." "C# .NET"
                        }
                        group "Application Layer" {
                            reportQueryService = component "Report Query Service" "Handles report-related queries." "C# .NET"
                            reportCommandService = component "Report Command Service" "Handles report-related commands." "C# .NET"
                            externalSensorService = component "External Sensor Service" "Integrates with external sensor services." "C# .NET"}
                        group "Infrastructure Layer" {
                            reportRepository = component "Report Repository" "Handles report data storage." "C# .NET"
                            sensorRepository = component "Sensor Repository" "Handles sensor data storage." "C# .NET"
                        }
                        group "Domain Layer" {
                            report = component "Report Aggregate" "Represents a report in the system." "C# .NET"
                            reportMetrics = component "Report Metrics" "Handles metrics related to reports." "C# .NET" 
                            sensorData = component "Sensor Data" "Represents sensor data in the system." "C# .NET"
                            sensor = component "Sensor" "Represents a sensor in the system." "C# .NET"
                        }
                    }
                }
                
                // Bounded Contexts Genericos, no relacionados con el dominio ni enfoque del negocio
                group "Generic/Commodity Bounded Contexts" {

                    //  - IAM: Logeo y creación de usuario, Gestion de usuarios (CRUD), eliminación de cuenta, password recovery,
                    iamManagement = component "Identification Authentication Management Bounded Context" "Handles user identification and registration." "Commodity BC"{
                        group "Interface Layer" {
                            authController = component "User Controller" "Handles user-related requests." "C# .NET"
                            iamACL = component "IAM Access Control List" "Manages user permissions and roles." "C# .NET"
                        }
                        group "Application Layer" {
                            authQueryService = component "User Query Service" "Handles user-related queries." "C# .NET"
                            authCommandService = component "User Command Service" "Handles user-related commands." "C# .NET"
                            2FAService = component "2FA Service" "Handles two-factor authentication." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            authRepository = component "User Repository" "Handles user data storage." "C# .NET"
                            firebaseIntegration = component "Firebase Integration" "Integrates with Firebase for email verification and 2FA Multifactor." "C# .NET"
                        }
                        group "Domain Layer" {
                            user = component "User Aggregate" "Represents a user in the system." "C# .NET"
                            userRole = component "User Role Entity" "Defines roles and permissions for users." "C# .NET"                         
                        }
                    }

                    //  - Profile and Personal Data: Datos relacionados al usuario que no son sensibles, solo de referencia/contacto (Telefono, Adress, etc.) 
                    profiles&PersonalData = component "Profiles and Personal Data Bounded Context" "Manages Personal Data for user like reference and contact (Phone Number, Adress, etc.)." "Commodity BC" {
                        group "Interface Layer" {
                            profileController = component "Profile Controller" "Handles profile-related requests." "C# .NET"
                            profileACL = component "Profile Anti Corruption Layer" "Facade to process profile-related requests for other bounded contexts." "C# .NET"
                            
                        }
                        group "Application Layer" {
                            profileQueryService = component "Profile Query Service" "Handles profile-related queries." "C# .NET"
                            profileCommandService = component "Profile Command Service" "Handles profile-related commands." "C# .NET"
                            
                        }
                        group "Infrastructure Layer" {
                            profileRepository = component "Profile Repository" "Handles profile data storage." "C# .NET"
                            geoAPIIntegration = component "GeoAPI Integration" "Integrates with GeoAPI for geolocation services." "C# .NET"
                        }
                        group "Domain Layer" {
                            profile = component "Profile Aggregate" "Represents a user profile in the system." "C# .NET"
                        }
                    }

                    //  - Suscriptions & Payments: Para membresias y pagos de servicios premium, como por ejemplo la visa de datos sensores en tiempo real
                    suscriptions&Payments = component "Suscriptions and Payments Bounded Context" "Handles user subscriptions and payments." "Commodity BC" {
                        group "Interface Layer" {
                            subscriptionController = component "Subscription Controller" "Handles subscription-related requests." "C# .NET"
                            subscriptionACL = component "Subscription Anti Corruption Layer" "Facade to process subscription-related requests for other bounded contexts." "C# .NET"
                        }
                        group "Application Layer" {
                            subscriptionQueryService = component "Subscription Query Service" "Handles subscription-related queries." "C# .NET"
                            subscriptionCommandService = component "Subscription Command Service" "Handles subscription-related commands." "C# .NET"
                            2FAService = component "2FA Service" "Handles two-factor authentication." "C# .NET"
                            externalPaymentService = component "External Payment Service" "Integrates with external payment services." "C# .NET"
                        }
                        group "Infrastructure Layer" {
                            subscriptionRepository = component "Subscription Repository" "Handles subscription data storage." "C# .NET"
                            stripeIntegration = component "Stripe Integration" "Integrates with Stripe for payment processing." "C# .NET"
                        }
                        group "Domain Layer" {
                            subscription = component "Subscription Aggregate" "Represents a user subscription in the system." "C# .NET"
                            payment = component "Payment Aggregate" "Represents a payment transaction in the system." "C# .NET"
                        }
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

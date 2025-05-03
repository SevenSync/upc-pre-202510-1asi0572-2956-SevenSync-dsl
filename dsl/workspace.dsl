workspace "Macetech - Smart Gardening Platform" "DDD Strategic Bounded Contexts in a .NET MVC monolithic architecture with frontend clients" {

    model {

        // Personas
        hobbyistUser = person "Enthusiastic Gardener" "Cares for their plants casually at home."
        expertUser = person "Experienced Gardener" "Cares for many or exotic plants, wants more control."

        // Dispositivo y servicios externos
        smartPot = softwareSystem "Macetech Smart Pot Hardware" "Smart pot with sensors and actuator for irrigation." "Hardware"
        externalGemini = softwareSystem "Gemini API" "External AI model for insights." "External"

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
                careIntelligence = component "Caring Intelligence" "Analyzes reports and plant type to provide recommendations, irrigation techniques, reports generation, etc." "Python"
                noticeSystem = component "Notification System" "Sends a notice to the user with the reports and recommendations." "Python"
            }

            // App embebida
            embeddedApp = container "Embedded Application" "Embedded software controlling the Smart Pot Hardware." "C++" {
                parameterManager = component "Harvesting Parameter Manager" "Manages plant parameters." "C++"
                deviceController = component "Device Controller" "Interacts with sensors." "C++"                
            }

            // Backend monolito
            monolithApp = container "Single unified software application" "Domain-driven monolith exposing HTTP APIs for plant care automation." "C# .NET" {

                group "Core Bounded Contexts" {
                    gardeningRecommendation = component "Gardening recommendation" "Creates personalized recommendations from plant type and reports." "Core BC"
                    plantRegistration = component "Plant Registration" "Expert knowledge base of plant species and their tolerances." "Core BC"
                }

                group "Support Bounded Contexts" {
                    reportManagement = component "Report Management" "Analyzes reports delivered from edge app that contains plant context." "Core BC"
                    aiService = component "AI Service" "Uses external Gemini API to generate AI-based insights." "Support BC"
                }
                group "Generic/Commodity Bounded Contexts" {
                    userManagement = component "User Management" "Handles user identification, password recovery and user registration." "Commodity BC"
                    profiles = component "Profiles" "Manages identities, roles, and access control." "Commodity BC"
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

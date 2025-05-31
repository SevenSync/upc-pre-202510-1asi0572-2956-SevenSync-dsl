workspace "Macetech - Smart Gardening Platform" "An IoT-based platform to monitor and care for plants automatically, modeled similarly to Big Bank plc example." {


model {

    // Users
    hobbyistUser = person "Enthusiastic Gardener" "Cares for their plants casually at home."
    expertUser = person "Experienced Gardener" "Cares for many or exotic plants, wants more control."

    // Software Systems
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

        // Landing Page
        landingPageWebsite = container "Macetech Landing Page" "Landing page for the Macetech platform." "HTML5/CSS/JavaScript" {
            landingUI = component "Web UI" "Shows plant care features, team members, contact information and contains a call to action." "HTML5/CSS/JavaScript"
        }

        // Web Application
        webApp = container "Web Application" "Delivers the static content and the macetech single page application." {
            tags "Web Application"
        }

        // Single Page Application
        singlePageApplication = container "Macetech Single Page Application" "Single Page Application (SPA) installed locally into user's browser." "Angular" "Web Browser" {
            group "Web Components" {
                spaApp = component "Web App Principal Component" "Angular application that provides the user interface for the Macetech platform." "Angular" "Web Component"
                spaIAM = component "IAM Component" "Handles user authentication and registration." "Angular" "Web Component"
                spaHome = component "Home Component" "Displays a list of smart pots linked to the user's profile, a toolbar to navigate in the app and notifications." "Angular" "Web Component"
                spaPotAddition = component "Pot Addition Component" "Handles the addition of new smart pots." "Angular" "Web Component"
                spaPlantIdentification = component "Plant Identification Component" "Identifies plant species." "Angular" "Web Component"
                spaNotifications = component "Notifications Component" "Displays notifications and alerts." "Angular" "Web Component"
                spaPotAndPlantDashboard = component "Pot & Plant Monitoring Component" "Monitors pot and plant health, including alerts and sensor data like ph, temperature, water level." "Angular" "Web Component"
                spaPotConfiguration = component "Pot Configuration Component" "Manages pot details, watering system, addition and removal." "Angular" "Web Component"
                spaCheckout = component "Checkout Component" "Handles subscription payments and plan selection." "Angular" "Web Component"
                spaMembership = component "Membership Component" "Displays membership information and plan details." "Angular" "Web Component"
                spaSettings = component "Settings Component" "Manages user preferences and configurations for smart pots like irrigation, report generation, etc." "Angular" "Web Component"
                spaProfile = component "Profile Management Component" "Manages user profile." "Angular" "Web Component"        
            }
            group "Web Service Management" {
                spaFacade = component "Web Facade" "Provides a simplified interface for web client to interact with backend services." "Angular" "Web Component"
            }
        }

        // Mobile App
        mobileApp = container "Mobile Application" "Flutter-based mobile app consuming backend APIs." "Dart / Flutter" "Mobile App" {
            
            group "Mobile Components" {
                mobIAM = component "Identification and Authentication" "Handles user authentication and registration." "Dart" "Web Component"
                mobHome = component "Home Page" "Displays a list of smart pots linked to the user's profile, a toolbar to navigate in the app and notifications." "Dart" "Web Component"
                mobPotAddition = component "Pot Addition UI" "Handles the addition of new smart pots." "Dart" "Web Component"
                mobPlantIdentification = component "Plant Identification UI" "Identifies plant species." "Dart" "Web Component"
                mobNotifications = component "Notifications UI" "Displays notifications and alerts." "Dart" "Web Component"
                mobPotAndPlantDashboard = component "Pot & Plant Monitoring UI" "Monitors pot and plant health, including alerts and sensor data like ph, temperature, water level." "Dart" "Web Component"
                mobPotConfiguration = component "Pot Configuration Component" "Manages pot details, watering system, addition and removal." "Dart" "Web Component"
                mobCheckout = component "Payment Transaction" "Handles subscription payments and plan selection." "Dart" "Web Component"
                mobMembership = component "Membership UI" "Displays membership information and plan details." "Dart" "Web Component"
                mobSettings = component "Settings Component" "Manages user preferences and configurations for smart pots like irrigation, report generation, etc." "Dart" "Web Component"
                mobProfile = component "Profile Management Component" "Manages user profile." "Dart" "Web Component"
            }
            group "Mobile Service Management" {
                mobBlocState = component "Bloc State Management" "Manages state across the mobile application." "Dart" "Mobile Component"
                mobFacade = component "Mobile Facade" "Provides a simplified interface for mobile app to interact with backend services." "Dart" "Mobile Component"
            }
        }

        // Databases
        plantDB = container "Plant Database" "Stores all persistent domain data across all backend components." "MySQL" "Database"
        edgeDB = container "Edge SQLite Database" "Stores all edge application information." "SQLite" "Database"
        mobileDB = container "Mobile SQLite Database" "Stores mobile application data for performance on the device." "SQLite" "Database"

        // Edge Application
        edgeApp = container "Edge Application" "Edge software for plant analytics." "Python" {
            edgeAnalytics = component "Edge Analytics" "Analyzes plant data at the edge." "Python"
            edgeMonitoring = component "System Monitoring" "Monitors sensor data and handles alerts." "Python"
            edgeWatering = component "Watering System" "Handles watering system with the given sensor data." "Python"
            edgeLocalFileSystemStorage = component "Local File System Storage" "Caches sensor data locally." "Python"
            edgeOperation = component "Smart Care" "Analyzes plant data and provides care recommendations." "Python"
        }

        // Embedded Application
        embeddedApp = container "Embedded Application" "Embedded software controlling the Smart Pot Hardware." "C++" {
            embParameterManager = component "Harvesting Parameter Manager" "Manages plant parameters." "C++"
            embDeviceController = component "Device Controller" "Interacts with sensors." "C++"
        }

        // Monolith Application
        monolithApp = container "Cloud API" "Domain-driven-designed monolith that exposes HTTP APIs for plant care automation." "C# .NET" {

            // ====== CORE DOMAINS ======
            group "Service Design & Planning BC (Core)" {
                coreSdpController = component "Service Design Controller" "Orchestrates care plan creation (plants, pots, schedules)" "C# .NET Controller"
                coreSdpPlanAggregate = component "Plantation Plan Aggregate" "Root aggregate for full service configuration" "C# .NET Domain Model"
                coreSdpPlanRepository = component "Plantation Plan Repository" "Persists service configurations" "C# .NET Repository"
                coreSdpSchedulerService = component "Scheduler Service" "Manages watering/monitoring schedules" "C# .NET Domain Service"
                coreSdpGeoIntegration = component "Geolocation Integration" "Provides weather data for care plans" "C# .NET Integration"
            }

            group "Service Operation & Monitoring BC (Core)" {
                coreOpAlertController = component "Alert Controller" "Handles alert notifications" "C# .NET Controller"
                coreOpDeviceController = component "Device Controller" "Manages device operations" "C# .NET Controller"
                coreOpAlertService = component "Alert Service" "Manages alerts and notifications" "C# .NET Domain Service"
                coreOpDeviceService = component "Device Service" "Handles device operations" "C# .NET Domain Service"
                coreOpDeviceRepository = component "Device Repository" "Stores device data" "C# .NET Repository"
                coreOpAlertRepository = component "Alert Repository" "Stores alert data" "C# .NET Repository"
                coreOpAlertAggregate = component "Alert Aggregate" "Manages system alerts" "C# .NET Domain Model"
                coreOpDeviceAggregate = component "Device Aggregate" "Represents smart pot device" "C# .NET Domain Model"
                coreOpDeviceParametersEntity = component "Device Parameters Entity" "Defines device parameters" "C# .NET Domain Model"
            }

            // ====== SUPPORTING DOMAINS ======
            group "Asset Management BC (Support)" {
                sptAssetPotController = component "Asset Management Controller" "Handles smart pot CRUD operations" "C# .NET Controller"
                sptAssetPotAggregate = component "Pot Aggregate" "Represents smart pot with sensors" "C# .NET Domain Model"
                sptAssetPotRepository = component "Asset Management Repository" "Persists pot data" "C# .NET Repository"
                sptAssetPotService = component "Asset Management Service" "Business logic for pot management" "C# .NET Domain Service"
            }

            group "Plant Catalog BC (Support)" {
                sptPlantController = component "Plant Controller" "Manages plant species data" "C# .NET Controller"
                sptPlantRepository = component "Plant Repository" "Persists plant data" "C# .NET Repository"
                sptPlantService = component "Plant Service" "Business logic for plant management" "C# .NET Domain Service"
                sptPlantAggregate = component "Plant Aggregate" "Models plant species parameters" "C# .NET Domain Model"
                sptPlantApiIntegration = component "PlantAPI Integration" "Fetches external plant data" "C# .NET Integration"
            }

            group "Data Analytics BC (Support)" {
                sptAnalyticsController = component "Analytics Controller" "Provides KPIs and reports" "C# .NET Controller"
                sptAnalyticsRepository = component "Analytics Repository" "Stores analytics data" "C# .NET Repository"
                sptAnalyticsService = component "Analytics Service" "Business logic for analytics" "C# .NET Domain Service"
                sptAnalyticsEngineAggregate = component "Analytics Engine Aggregate" "Generates insights/recommendations" "C# .NET Domain Service"
            }

            // ====== GENERIC DOMAINS ======
            group "IAM BC (Commodity)" {
                genIamAuthController = component "Auth Controller" "Handles login/registration/2FA" "C# .NET Controller"
                genIamUserController = component "User Management Controller" "Manages user accounts" "C# .NET Controller"
                genIamService = component "IAM Service" "Business logic for user management" "C# .NET Domain Service"
                genIamUserAggregate = component "User Aggregate" "Represents system user" "C# .NET Domain Model"
                genIamUserRoleEntity = component "User Role Entity" "Defines permissions" "C# .NET Domain Model"
                genIamFirebaseIntegration = component "Firebase Integration" "External auth provider" "C# .NET Integration"
                genIamUserRepository = component "User Repository" "Stores user data" "C# .NET Repository"
            }

            group "Profile & Preferences BC (Commodity)" {
                genProfileController = component "Profile Controller" "Manages personal data" "C# .NET Controller"
                genProfileAggregate = component "Profile Aggregate" "Represents user profile" "C# .NET Domain Model"
                genProfileService = component "Profile Service" "Business logic for profile management" "C# .NET Domain Service"
                genProfileRepository = component "Profile Repository" "Stores profile data" "C# .NET Repository"
            }

            group "Subscription & Payments BC (Commodity)" {
                genSubController = component "Subscription Controller" "Handles membership flows" "C# .NET Controller"
                genSubSubscriptionAggregate = component "Subscription Aggregate" "Models user subscriptions" "C# .NET Domain Model"
                genSubPaymentAggregate = component "Payment Aggregate" "Represents payment transactions" "C# .NET Domain Model"
                genSubStripeIntegration = component "Stripe Integration" "Payment gateway" "C# .NET Integration"
                genSubService = component "Subscription Service" "Business logic for subscription management" "C# .NET Domain Service"
                genSubRepository = component "Subscription Repository" "Stores subscription data" "C# .NET Repository"
            }
        }
    }

    //Landing Page relationships
    hobbyistUser -> landingUI "Browses marketing and informational content" "HTTPS"
    expertUser -> landingUI "Browses marketing and informational content" "HTTPS"
    landingUI -> webApp "Requests web application" "HTTPS"

    // Web App relationships
    hobbyistUser -> webApp "Visits web application" "HTTPS"
    expertUser -> webApp "Visits web application" "HTTPS"
    webApp -> singlePageApplication "Delivers to the customer's browser" "HTTPS"

    // Single Page Application relationships
    hobbyistUser -> spaApp "Views smart pot information"
    expertUser -> spaApp "Views smart pot information"
    spaApp -> spaIAM "Sends to web application IAM component to login, register or recover password"
    spaIAM -> spaHome "Redirects user to home view after login"
    spaApp -> spaHome "Navigates to home view if already logged in"
    spaHome -> spaPotAddition "Navigates to pot addition view"
    spaPotAddition -> spaPlantIdentification "Continues with the process to plant identification"
    spaPlantIdentification -> spaPotAndPlantDashboard "Generates new pot and plant dashboard"
    spaPotAndPlantDashboard -> spaPotConfiguration "Manages smart pots"
    spaHome -> spaPotAndPlantDashboard "Navigates to dashboard to view linked smart pots"
    spaHome -> spaMembership "Navigates to membership information"
    spaMembership -> spaCheckout "Navigates to checkout for subscription"
    spaHome -> spaSettings "Navigates to settings to manage pot configurations"
    spaHome -> spaProfile "Navigates to user profile"
    spaHome -> spaNotifications "Displays notifications and alerts"
    spaApp -> spaFacade "Fetches data from backend services"
    spaFacade -> monolithApp "Sends requests to the backend API" "JSON/HTTPS"
    
    // Mobile App relationships
    hobbyistUser -> mobileApp "Views smart pot information"
    expertUser -> mobileApp "Views smart pot information"
    hobbyistUser -> mobIAM "Accesses mobile application IAM to login, register or recover password"
    expertUser -> mobIAM "Accesses mobile application IAM to login, register or recover password"
    expertUser -> mobHome "Accesses directly to the home view if logged in"
    hobbyistUser -> mobHome "Accesses directly to the home view if logged in"
    mobIAM -> mobHome "Redirects user to home view after login"
    mobHome -> mobPotAddition "Navigates to pot addition view"
    mobPotAddition -> mobPlantIdentification "Continues with the process to plant identification"
    mobPlantIdentification -> mobPotAndPlantDashboard "Generates new pot and plant dashboard"
    mobPotAndPlantDashboard -> mobPotConfiguration "Manages smart pots"
    mobHome -> mobPotAndPlantDashboard "Navigates to dashboard to view linked smart pots"
    mobHome -> mobMembership "Navigates to membership information"
    mobMembership -> mobCheckout "Navigates to checkout for subscription"
    mobHome -> mobSettings "Navigates to settings to manage pot configurations"
    mobHome -> mobProfile "Navigates to user profile"
    mobHome -> mobNotifications "Displays notifications and alerts"
    mobBlocState -> mobFacade "Fetches data from backend services"
    mobFacade -> monolithApp "Sends requests to the backend API" "JSON/HTTPS"

    // Mobile local storage
    mobSettings -> mobileDB "Persists preferences" "SQLite"
    mobProfile -> mobileDB "Caches profile" "SQLite"
    mobNotifications -> mobileDB "Stores alerts" "SQLite" 

    // ====== RELACIONES INTERNAS ======
    // IAM BC
    genIamUserRoleEntity -> genIamUserAggregate "Defines user roles and permissions" "SQL/TCP"
    genIamAuthController -> genIamUserController "Manages user accounts" "JSON/HTTPS"
    genIamService -> genIamUserController "Reads/Writes user data" "SQL/TCP"
    genIamService -> genIamFirebaseIntegration "Verifies 2FA codes" "SQL/TCP"
    genIamUserAggregate -> genIamUserRepository "Stores user data" "SQL/TCP"
    genIamUserRepository -> genIamService "Persists user data" "SQL/TCP"

    // Profile BC
    genProfileAggregate -> genProfileRepository "Stores user profile" "SQL/TCP"
    genProfileRepository -> genProfileService "Handles profile logic" "SQL/TCP"
    genProfileService -> genProfileController "Provides profile data" "SQL/TCP"

    // Plant Catalog BC
    sptPlantService -> sptPlantController "Stores/retrieves plant data" "SQL/TCP"
    sptPlantService -> sptPlantApiIntegration "Identifies the plant"
    sptPlantRepository -> sptPlantService "Provides plant data" "SQL/TCP"
    sptPlantAggregate -> sptPlantRepository "Stores plant species parameters" "SQL/TCP"

    // Service Operation & Monitoring BC
    coreOpAlertAggregate -> coreOpAlertRepository "Stores alert data" "SQL/TCP"
    coreOpDeviceAggregate -> coreOpDeviceRepository "Stores device data" "SQL/TCP"
    coreOpDeviceParametersEntity -> coreOpDeviceAggregate "Stores device parameters"
    coreOpDeviceRepository -> coreOpDeviceService "Provides device data" "SQL/TCP"
    coreOpDeviceService -> coreOpDeviceController "Handles device operations" "SQL/TCP"
    coreOpAlertRepository -> coreOpAlertService "Provides alert data" "SQL/TCP"
    coreOpAlertService -> coreOpAlertController "Manages alert notifications" "SQL/TCP"

    // Data Analytics BC
    sptAnalyticsEngineAggregate -> sptAnalyticsRepository "Stores analytics data" "SQL/TCP"
    sptAnalyticsRepository -> sptAnalyticsService "Provides analytics data" "SQL/TCP"
    sptAnalyticsService -> sptAnalyticsController "Handles analytics operations" "SQL/TCP"

    // Asset Management BC
    sptAssetPotAggregate -> sptAssetPotRepository "Stores smart pot data" "SQL/TCP"
    sptAssetPotRepository -> sptAssetPotService "Provides pot data" "SQL/TCP"
    sptAssetPotService -> sptAssetPotController "Handles pot management logic" "SQL/TCP"

    // Subscription & Payments BC
    genSubSubscriptionAggregate -> genSubRepository "Stores subscription data" "SQL/TCP"
    genSubPaymentAggregate -> genSubRepository "Stores payment transactions" "SQL/TCP"
    genSubRepository -> genSubService "Provides subscription data" "SQL/TCP"
    genSubService -> genSubController "Handles subscription operations" "SQL/TCP"
    genSubService -> genSubStripeIntegration "Processes payments" "Stripe API/HTTPS"

    // Service Design & Planning BC
    coreSdpPlanAggregate -> coreSdpPlanRepository "Stores care plans" "SQL/TCP"
    coreSdpPlanRepository -> coreSdpSchedulerService "Provides care plan data" "SQL/TCP"
    coreSdpSchedulerService -> coreSdpController "Schedules watering/monitoring" "JSON/HTTPS"
    coreSdpGeoIntegration -> coreSdpSchedulerService "Provides weather data" "API Call/HTTPS"

    // ====== RELACIONES CRUZADAS ENTRE BCs ======
    // Diseño -> Catálogo de Plantas
    coreSdpController -> sptPlantController "Consults plant species" "JSON/HTTPS"

    // Análisis -> Operaciones
    sptAnalyticsController -> coreOpAlertController "Triggers notifications" "Domain Event"

    // Usuario -> Perfil
    genIamAuthController -> genProfileController "Creates profile upon user registration" "JSON/HTTPS"

    // Macetas -> Operaciones
    sptAssetPotController -> coreOpDeviceController "Updates watering schedule" "JSON/HTTPS"

    // Análisis -> Diseño
    sptAnalyticsController -> coreSdpController "Provides recommendations" "JSON/HTTPS"

    // Suscripciones -> Perfil
    genSubController -> genProfileRepository "Updates subscription status" "SQL/TCP"

    // Repositories -> PlantDb
    monolithApp -> plantDB "Saves System Data" "SQL/TCP"
    genIamUserRepository -> plantDB "Stores user data" "SQL/TCP"
    genProfileRepository -> plantDB "Stores profile data" "SQL/TCP"
    sptPlantRepository -> plantDB "Stores plant species data" "SQL/TCP"
    sptAssetPotRepository -> plantDB "Stores smart pot data" "SQL/TCP"
    genSubRepository -> plantDB "Stores subscription data" "SQL/TCP"
    sptAnalyticsRepository -> plantDB "Stores sensor data" "SQL/TCP"
    coreSdpPlanRepository -> plantDB "Stores care plans" "SQL/TCP"

    // ====== RELACIONES EXTERNAS ======
    // Integraciones con servicios externosz
    coreSdpGeoIntegration -> geoAPI "Fetches geolocation data" "GeoAPI/HTTPS"
    genSubStripeIntegration -> stripeExternalService "Processes payments" "Stripe API/HTTPS"
    sptPlantApiIntegration -> plantAPI "Queries species" "PlantAPI/HTTPS"
    genIamFirebaseIntegration -> firebaseExternalService "External Authentication" "Firebase API/HTTPS"
    
    // Edge computing
    edgeAnalytics -> monolithApp "Sends analytics data" "JSON/HTTPS"
    edgeAnalytics -> edgeLocalFileSystemStorage "Caches analytics data" "SQL/TCP"
    edgeLocalFileSystemStorage -> edgeOperation "Caches operation data" "SQL/TCP"
    edgeOperation -> edgeWatering "Caches watering data" "SQL/TCP"
    edgeOperation -> edgeMonitoring "Caches monitoring data" "SQL/TCP"
    edgeApp -> edgeDB "Reads/Writes edge data" "SQL/TCP"
    edgeOperation -> edgeDB "Caches recommendations" "SQL/TCP"
    edgeAnalytics -> edgeDB "Caches analytics data" "SQL/TCP"
    edgeWatering -> edgeDB "Caches watering schedules" "SQL/TCP"
    edgeMonitoring -> edgeDB "Caches monitoring data" "SQL/TCP"
    embDeviceController -> smartPot "Controls hardware" "Direct Connection"
    embDeviceController -> embParameterManager "Sends sensor data" "Direct Connection"

    // Embedded system flow
    smartPot -> embDeviceController "Sends sensor readings" "Sensor Interface"
    embParameterManager -> edgeAnalytics "Sends plant parameters" "Sensor Interface"
    edgeWatering -> embDeviceController "Receives irrigation commands" "Sensor Interface"

    // Deployment Environment
    deploymentEnvironment "Deployment Environment" {

        deploymentNode "User Devices" "End-user devices" {
            deploymentNode "Web Browser" "Browser" "Chrome/Firefox/Safari/Edge/Opera" {
                containerInstance singlePageApplication
            }
    
            deploymentNode "Mobile Device" "Mobile" "iOS/Android" {
                containerInstance mobileApp
                containerInstance mobileDB
            }
        }

        deploymentNode "SmartPot Hardware" "Physical IoT Device" {
            deploymentNode "Embedded Firmware" "Embedded Application" "C++ Firmware" {
                containerInstance embeddedApp
            }
        }

        deploymentNode "Macetech Platform" "Cloud Infrastructure" "Macetech Data Center" {

            deploymentNode "Macetech Landing Page" "Static Website Hosting" {
                deploymentNode "Github Pages" "Landing Page Hosting" {
                    containerInstance landingPageWebsite
                }
            }

            deploymentNode "Macetech Web Client Hosting" "Web Client Hosting" {
                deploymentNode "Netlify" "Web Client Hosting" {
                    containerInstance singlePageApplication
                }
            }

            deploymentNode "Macetech Cloud API Hosting" "API Hosting" {
                deploymentNode "Azure App Service" ".NET Core" {
                    containerInstance monolithApp
                }
            }

            deploymentNode "Edge Service Pod" "Edge Computing" {
                deploymentNode "Azure IoT Hub" "Python" {
                    containerInstance edgeApp 
                    containerInstance edgeDB
                }
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
            landingPageWebsite singlePageApplication mobileApp monolithApp
            edgeApp embeddedApp
            plantDB edgeDB mobileDB
        }
        autolayout lr
        description "The Container diagram for the Macetech Smart Gardening Platform."
    }

    component monolithApp "MonolithComponents" {
        include *
        // Animation for key interactions, can be expanded
        autolayout lr
        description "The Component diagram for the Monolithic API Application."
    }

    deployment macetechPlatform "Deployment Environment" {
        include *
        autolayout tb
        description "Deployment diagram for the Macetech Smart Gardening Platform in production."
    }

    component singlePageApplication "WCAComponents" { 
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
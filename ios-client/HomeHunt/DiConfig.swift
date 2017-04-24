import Foundation
import Swinject
import SwinjectStoryboard

let baseUrl = "http://192.168.0.102:8000/api";

class DiConfigHttp {
    public static func setup(container: Container) {
        container.register(HttpRequesterBase.self){_ in HttpRequester() }
    }
}

class DiConfigData {
    public static func setup(container: Container) {
        // Users data
        container.register(UsersData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = UsersData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)"
            
            return data
        }
        
        // Agents data
        container.register(AgentsData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = AgentsData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)/agents"
            
            return data
        }
        
        // Add data
        container.register(AddData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = AddData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)/adds"
            
            return data
        }
        
        // Image data
        container.register(ImageData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = ImageData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)/public/images"
            
            return data
        }
        
        // Appointment data
        container.register(AppointmentData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = AppointmentData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)/appointments"
            
            return data
        }
        
        // Review data
        container.register(ReviewData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = ReviewData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)/reviews"
            
            return data
        }
    }
}

class DiConfigViewContorller {
    public static func setup(container: Container) {
        // Register VC
        container.storyboardInitCompleted(RegisterViewController.self) { resolver, vc in
            let usersData = resolver.resolve(UsersData.self)
            vc.usersData = usersData
            usersData?.delegate = vc
        }
        
        // Login VC
        container.storyboardInitCompleted(LoginViewController.self) { resolver, vc in
            let usersData = resolver.resolve(UsersData.self)
            vc.usersData = usersData
            usersData?.delegate = vc
        }
        
        // Agents Master VC
        container.storyboardInitCompleted(AgentsMasterViewController.self) { resolver, vc in
            let agentsData = resolver.resolve(AgentsData.self)
            vc.agentsData = agentsData
            agentsData?.delegate = vc
        }
        
        // Agents Details VC
        container.storyboardInitCompleted(AgentDetailsViewController.self) { resolver, vc in
            let agentsData = resolver.resolve(AgentsData.self)
            vc.agentData = agentsData
            agentsData?.delegate = vc
        }
        
        // Add Master VC
        container.storyboardInitCompleted(AddsMasterViewController.self) { resolver, vc in
            let addsData = resolver.resolve(AddData.self)
            vc.addsData = addsData
            addsData?.delegate = vc
        }
        
        // Add Details VC
        container.storyboardInitCompleted(AddDetailsViewController.self) { resolver, vc in
            let addsData = resolver.resolve(AddData.self)
            vc.addData = addsData
            addsData?.delegate = vc
        }
        
        // Appointment Create VC
        container.storyboardInitCompleted(CreateAppointmentViewController.self) { resolver, vc in
            let appointmentData = resolver.resolve(AppointmentData.self)
            vc.appointmentData = appointmentData
            appointmentData?.delegate = vc
        }
        
        // Appointment Master VC
        container.storyboardInitCompleted(AppointmentsMasterViewController.self) { resolver, vc in
            let appointmentData = resolver.resolve(AppointmentData.self)
            vc.appointmentData = appointmentData
            appointmentData?.delegate = vc
        }
        
        // Appointment Details VC
        container.storyboardInitCompleted(AppointmentDetailsViewController.self) { resolver, vc in
            let appointmentData = resolver.resolve(AppointmentData.self)
            vc.appointmentData = appointmentData
            appointmentData?.delegate = vc
        }
        
        // Appointment Details VC
        container.storyboardInitCompleted(SubmitReviewViewController.self) { resolver, vc in
            let reviewDate = resolver.resolve(ReviewData.self)
            vc.reviewData = reviewDate
            reviewDate?.delegate = vc
        }
    }
}

extension SwinjectStoryboard {
    public static func setup() {
        DiConfigHttp.setup(container: defaultContainer)
        DiConfigData.setup(container: defaultContainer)
        DiConfigViewContorller.setup(container: defaultContainer)
    }
}

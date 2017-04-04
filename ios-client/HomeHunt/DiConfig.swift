import Foundation
import Swinject
import SwinjectStoryboard

let baseUrl = "http://192.168.0.103:8000/api";

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
    }
}

extension SwinjectStoryboard {
    public static func setup() {
        DiConfigHttp.setup(container: defaultContainer)
        DiConfigData.setup(container: defaultContainer)
        DiConfigViewContorller.setup(container: defaultContainer)
    }
}

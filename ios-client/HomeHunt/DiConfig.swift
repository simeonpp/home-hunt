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
        container.register(UsersData.self) { resolver in
            var httpRequester = resolver.resolve(HttpRequesterBase.self)
            let data = UsersData()
            
            httpRequester?.delegate = data
            
            data.httpRequester = httpRequester
            data.url = "\(baseUrl)"
            
            return data
        }
    }
}

class DiConfigViewContorller {
    public static func setup(container: Container) {
        container.storyboardInitCompleted(RegisterViewController.self) { resolver, vc in
            let usersData = resolver.resolve(UsersData.self)
            vc.usersData = usersData
            usersData?.delegate = vc
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

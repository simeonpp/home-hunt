import Foundation

class AppointmentData: BaseData, HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: AppointmentDataDelegate?
    
    func create(appointment: Appointment, cookie: String) {
        self.httpRequester?.postJson(toUrl: self.url!, withBody: appointment.toDict(), andHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func getAll(cookie: String) {
        self.httpRequester?.getAll(fromUrl: self.url!, withHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func get(appointmentId: Int, cookie: String) {
        let newUrl = "\(self.url!)/\(appointmentId)"
        self.httpRequester?.getDetails(fromUrl: newUrl, withHeaders: getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func delete(appointmentId: Int, cookie: String) {
        let newUrl = "\(self.url!)/\(appointmentId)"
        self.httpRequester?.delete(fromUrl: newUrl, withHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func didCompletePostJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            self.delegate?.didCreate(error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didCreate(error: apiError)
        }
    }
    
    func didCompleteGetAllJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let appointments = (resultAsDict["result"] as! [Dictionary<String, Any>])
                .map(){ Appointment(withDict: $0) }
            self.delegate?.didReceiveAppointments(appointments: appointments, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAppointments(appointments: [], error: apiError)
        }
    }
    
    func didCompleteGetJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let appointment = Appointment(withDict: resultAsDict["result"] as! Dictionary<String, Any>)
            self.delegate?.didReceiveAppointment(appointment: appointment, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAppointment(appointment: nil, error: apiError)
        }
    }
    
    func didCompleteDeleteJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            self.delegate?.didDelete(error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didDelete(error: apiError)
        }
    }
}

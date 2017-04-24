import Foundation

protocol AppointmentDataDelegate {
    func didCreate(error: ApiError?)
    func didReceiveAppointments(appointments: [Appointment], error: ApiError?)
    func didReceiveAppointment(appointment: Appointment?, error: ApiError?)
    func didDelete(error: ApiError?)
}

extension AppointmentDataDelegate {
    func didCreate(error: ApiError?) {
        
    }
    
    func didReceiveAppointments(appointments: [Appointment], error: ApiError?) {
        
    }
    
    func didReceiveAppointment(appointment: Appointment?, error: ApiError?) {
        
    }
    
    func didDelete(error: ApiError?) {
        
    }
}

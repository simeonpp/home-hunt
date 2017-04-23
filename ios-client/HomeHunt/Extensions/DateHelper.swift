import Foundation

class DateHelper {    
    public static func toString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    public static func toStringUTC(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let result = dateFormatter.string(from: date)
        return result
    }
    
    public static func toDate(_ dateString: String) -> Date {
        // 01/01/2017 11:11
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let result = dateFormatter.date(from: dateString)
        return result!
    }
}
		

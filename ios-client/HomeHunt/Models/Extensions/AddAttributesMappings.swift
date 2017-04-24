extension AddAttributes {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let type = dict["type"] as! String
        let displayName = dict["displayName"] as! String
        let value = dict["value"] as! String
        
        self.init(withType: type,
                  andDisplayName: displayName,
                  andValue: value)
    }
}

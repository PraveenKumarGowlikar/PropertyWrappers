import UIKit

@propertyWrapper
struct EmailPropertyWrapper
{
    private var _value: String
    var wrappedValue: String?
    {
        get
        {
            
            let failedCase = _value.isEmpty ? "" : nil
            return isValidEmail(email: _value) ? _value : failedCase
        }
        set
        {
            _value = newValue ?? ""
        }
    }
    
    init(_emailValue: String) {
        _value = _emailValue
    }
    
    private func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
}

@propertyWrapper
struct MobilePropertyWrapper
{
    private var _value: String
    
    var wrappedValue: String?
    {
        get {
            
            let failedCase = _value.isEmpty ? "" : nil
            return isValidMobile(value: _value) ? _value : failedCase
        }
        
        set {
            
            _value = newValue ?? ""
        }
    }
    
    init(_mobile: String) {
        
        _value = _mobile
    }
    
    private func isValidMobile(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
}

struct RegistrationValidation {
    
    @EmailPropertyWrapper var email: String?
    @MobilePropertyWrapper var mobile: String?
    
    func validate() -> Bool
    {
        
        if email?.isEmpty ?? false
        {
            debugPrint("Valid email is required and cannot be empty")
            return false
        }
        if email == nil {
            
            debugPrint("Valid email is required.")
            return false
        }
        if mobile?.isEmpty ?? false
        {
            debugPrint("Valid mobile is required and cannot be empty")
            return false
        }
        if mobile == nil {

            debugPrint("Valid mobile is required.")
            return false
        }
        return true
    }
    
    func registerUser()
    {
        if(validate())
        {
            //saving user records code...
            debugPrint("User data saved")
        }
    }
}

let _registrationValidation = RegistrationValidation.init(email: EmailPropertyWrapper(_emailValue: "pk@pg.com"), mobile: MobilePropertyWrapper.init(_mobile: "9876543210"))
_registrationValidation.registerUser()


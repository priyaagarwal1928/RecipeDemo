

import Foundation
import Alamofire

class APIManager {
    
    typealias Completion = (Response) -> ()
    static let shared = APIManager()
    
    func getRequest(withApi api : Router , completion : @escaping Completion ){
        
        let fullPath = api.baseURL + api.route
        print(fullPath)
    
        CommonClass.shared.startLoader()
        
        Alamofire.request(fullPath, method: api.method, parameters: [:], encoding: JSONEncoding.prettyPrinted, headers: nil ).responseJSON { (response) in
            
            CommonClass.shared.removeLoader()

            switch response.result {
                
            case .success(let data):
                
                print(data)
                let object : AnyObject?
                object = api.handle(data: data)
                completion(Response.success(object))
                
            case .failure(let error):
                
                  CommonClass.showAlertViewOnWindow(titleStr: "", messageStr: /error.localizedDescription, okBtnTitleStr: "OK")
            }
        }
    }
    
    
}


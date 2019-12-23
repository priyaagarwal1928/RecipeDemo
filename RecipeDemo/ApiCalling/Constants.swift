
import UIKit
import Foundation
import NVActivityIndicatorView

internal struct APIConstants {
    
    static let baseUrl = "https://cdn.contentful.com/"
    
    static let recipeList = "spaces/kk2bw5ojx476/environments/master/entries/?access_token=7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c&select=sys.id,fields.title,fields.photo,fields.description,fields.chef,fields.tags&content_type=recipe"
    
}

enum Response {
    case success(AnyObject?)
    case Warning(String?)
    case failure(String?)
    
}

class CommonClass: NSObject,NVActivityIndicatorViewable
{
    static let shared = CommonClass()
  
    override init() {
        super.init()
    }

    //MARK: Loader
    func startLoader()  {
        
        DispatchQueue.main.async {
            let size = CGSize(width: 40, height:40)
            self.startAnimating(size, message: "", messageFont: nil, type: NVActivityIndicatorType.ballGridPulse, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil, fadeInAnimation: nil)
        }
    }
    
    func removeLoader()
    {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
    
    class func showAlertViewOnWindow(titleStr: String, messageStr: String, okBtnTitleStr:String)
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okBtnTitleStr, style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = UIColor.black
        AppDelegate.sharedDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}


protocol StringType { var get: String { get } }

extension String: StringType { var get: String { return self } }

extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}


prefix operator /
prefix func /(value : String?) -> String {
    return value.unwrap()
}
    

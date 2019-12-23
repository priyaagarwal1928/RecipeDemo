

import UIKit
import Alamofire
import ObjectMapper

protocol Router {
    
    var baseURL : String { get }
    var route : String { get }
    var method : Alamofire.HTTPMethod { get }
    func handle(data : Any) -> AnyObject?
}



enum RecipeEndPoints {
    
    case recipeList
    
}


extension RecipeEndPoints : Router{
    
    func handle(data: Any) -> AnyObject? {
        
        switch self {
            
        case .recipeList:
            let object = Mapper<RecipesModal>().map(JSONObject: data)
            return object as AnyObject?
        }
    }
    
    var baseURL: String{
        
        return APIConstants.baseUrl
    }
    
    var route : String  {
        
        switch self {
    
        case .recipeList: return APIConstants.recipeList
            
        }
  
    }

    var method : Alamofire.HTTPMethod {
        
        switch self {
            
        case .recipeList: return .get
            
        }
    }
}
    
  


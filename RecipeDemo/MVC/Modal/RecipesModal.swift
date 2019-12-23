
import UIKit
import ObjectMapper


class RecipesModal: Mappable
{
    var title: String?
    var photoId: String?
    var description: String?
    var chefId: String?
    var tagsId: String?
    
    var entryId : String?
    var entryName : String?
    var entryContentType : String?

    var assetId : String?
    var assetUrl : String?
    
    var arrEntry = [RecipesModal]()
    var arrAssets = [RecipesModal]()
    var arrItems = [RecipesModal]()
    var arrTags = [RecipesModal]()
    
    required init?(map: Map)
    {
    }
    
    func mapping(map: Map)
    {
        arrItems <- map["items"]
        title <- map["fields.title"]
        photoId <- map["fields.photo.sys.id"]
        description <- map["fields.description"]
        chefId <- map["fields.chef.sys.id"]
       
        arrTags <- map["fields.tags"]
        tagsId <- map["sys.id"]
        
        arrEntry <- map["includes.Entry"]
        entryId <- map["sys.id"]
        entryName <- map["fields.name"]
        entryContentType <- map["sys.contentType.sys.id"]
        
        arrAssets <- map["includes.Asset"]
        assetId <- map["sys.id"]
        assetUrl <- map["fields.file.url"]
       
    }

}


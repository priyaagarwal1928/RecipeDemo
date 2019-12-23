

import UIKit
import TagListView

class RecipeDetailVC: UIViewController,TagListViewDelegate {
    
    @IBOutlet weak var vwOuterChef: UIView!
    @IBOutlet weak var vwTag: TagListView!
    @IBOutlet weak var lblChefNm: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblRecipeNm: UILabel!
    @IBOutlet weak var vwChef: UIView!
    @IBOutlet weak var vwDesc: UIView!
    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var vwOuterTag: UIView!
    
    var dictRecipe:RecipesModal?
    var arrEntryList = [RecipesModal]()
    var arrAssets = [RecipesModal]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.vwDesc.layer.cornerRadius = 4
        self.vwDesc.clipsToBounds = true
        self.vwDesc.layer.masksToBounds = true
        self.vwDesc.layer.shadowRadius = 2
        self.vwDesc.layer.shadowOpacity = 1
        self.vwDesc.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.4).cgColor
        self.vwDesc.layer.shadowOffset = CGSize(width: 0, height:0)
        self.vwDesc.generateOuterShadow()
        
        
        
        self.vwOuterChef.layer.cornerRadius = 4
        self.vwOuterChef.clipsToBounds = true
        self.vwOuterChef.layer.masksToBounds = true
        self.vwOuterChef.layer.shadowRadius = 2
        self.vwOuterChef.layer.shadowOpacity = 1
        self.vwOuterChef.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.4).cgColor
        self.vwOuterChef.layer.shadowOffset = CGSize(width: 0, height:0)
        self.vwOuterChef.generateOuterShadow()
        
        if let font = UIFont(name: "Mark Pro", size: 14)
        {
            vwTag.textFont = font
        }
        
        setUpUIData()
        
    }
    
    func setUpUIData()
    {
        if let modal = dictRecipe
        {
            let arrFilter = arrAssets.filter({$0.assetId == modal.photoId})
            if arrFilter.count > 0
            {
                let modalPhoto = arrFilter[0]
                if modalPhoto.assetUrl != ""
                {
                    imgRecipe.kf.indicatorType = .activity
                    let width = UIScreen.main.bounds.width
                    let height = UIScreen.main.bounds.height * 0.5
                    
                    if let urlStr = URL.init(string:"https:\(/modalPhoto.assetUrl)?h=\(height)&w=\(width)")
                    {
                        imgRecipe.kf.setImage(with: urlStr)
                        
                    }
                }
            }
            
            lblRecipeNm.text = modal.title
            lblDesc.text = modal.description
            
            if modal.chefId != "" ||  modal.chefId != nil
            {
                let arrFilter = arrEntryList.filter({$0.entryId == modal.chefId})
                if arrFilter.count > 0
                {
                    let modalChef = arrFilter[0]
                    lblChefNm.text = modalChef.entryName
                }
                else
                {
                    vwChef.isHidden = true
                }
            }
            else
            {
                vwChef.isHidden = true
            }
            
            if modal.arrTags.count > 0
            {
                for dictTag in modal.arrTags
                {
                    let arrFilter = arrEntryList.filter({$0.entryId == dictTag.tagsId})
                    if arrFilter.count > 0
                    {
                        let modalTag = arrFilter[0]
                        self.vwTag.addTag(/modalTag.entryName)
                    }
                }
            }
            else
            {
                vwOuterTag.isHidden = true
                
            }
            
        }
        
    }
    
    @IBAction func btnBAckHandler(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

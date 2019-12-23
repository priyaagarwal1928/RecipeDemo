
import UIKit
import Kingfisher

class RecipesListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tblVw: UITableView!
    var arrRecipeList = [RecipesModal]()
    var arrEntryList = [RecipesModal]()
    var arrAssets = [RecipesModal]()

    //MARK:- UIViewControllerMethods -
    override func viewDidLoad() {
        super.viewDidLoad()

        //Call APi to get recipe list
        self.callAPIToGetAllRecipeList()
        
    }
    
    //MARK:- UITableviewDataSource -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrRecipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListCell", for: indexPath) as? RecipeListCell
        {
            let modal = arrRecipeList[indexPath.row]
            cell.lblRecipeNm.text = modal.title
            let arrFilter = arrAssets.filter({$0.assetId == modal.photoId})
            if arrFilter.count > 0
            {
                let modalPhoto = arrFilter[0]
                if modalPhoto.assetUrl != ""
                {
                    cell.imgRecipe.kf.indicatorType = .activity
                    let width = UIScreen.main.bounds.width
                    if let urlStr = URL.init(string:"https:\(/modalPhoto.assetUrl)?h=\(width)&w=\(width)")
                    {
                        cell.imgRecipe.kf.setImage(with: urlStr)
                        
                    }
                }
            }
            return cell

        }
        
        return UITableViewCell()
    }
    
    //MARK:- UITableviewDelegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let modal = arrRecipeList[indexPath.row]
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as? RecipeDetailVC
        {
            vc.arrEntryList = self.arrEntryList
            vc.dictRecipe = modal
            vc.arrAssets = self.arrAssets
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.width * 0.6
    }


}

//MARK:- RecipeCell -
class RecipeListCell: UITableViewCell  {
    
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var lblRecipeNm: UILabel!
    @IBOutlet weak var imgRecipe: UIImageView!
    
    override func awakeFromNib() {
        
        self.imgRecipe.layer.cornerRadius = 4
        self.imgRecipe.clipsToBounds = true
        self.imgRecipe.layer.masksToBounds = true
        self.imgRecipe.layer.shadowRadius = 2
        self.imgRecipe.layer.shadowOpacity = 1
        self.imgRecipe.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5).cgColor
        self.imgRecipe.layer.shadowOffset = CGSize(width: 0, height:0)
        self.imgRecipe.generateOuterShadow()
        
        self.vwBlur.clipsToBounds = true
        self.vwBlur.layer.cornerRadius = 4
        self.vwBlur.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
}

//MARK:- API Calls -
extension RecipesListVC
{
    func callAPIToGetAllRecipeList()
    {
        APIManager.shared.getRequest(withApi: RecipeEndPoints.recipeList) { [weak self](response) in
            
            self?.handleCallAPIToGetAllRecipeListResponse(response: response)
        }
    }
    
    func handleCallAPIToGetAllRecipeListResponse(response:Response)
    {
        switch response {
            
        case .success(let response):
            
            if let modal = response as? RecipesModal
            {
                self.arrRecipeList = modal.arrItems
                self.arrEntryList = modal.arrEntry
                self.arrAssets = modal.arrAssets
                tblVw.dataSource = self
                tblVw.delegate = self
                
                DispatchQueue.main.async {
                    
                    self.tblVw.reloadData()
                }
            }
            
            break
            
        case .failure(let msg):
            
            CommonClass.showAlertViewOnWindow(titleStr: "", messageStr: /msg, okBtnTitleStr: "OK")
            
        case .Warning(let msg):
            
            CommonClass.showAlertViewOnWindow(titleStr: "", messageStr: /msg, okBtnTitleStr: "OK")
        }
    }
}


//
//  ViewController.swift
//  Autodoc
//
//  Created by Sergei Kovalev on 25.07.2022.
//

import UIKit

protocol CustomLayoutDelegate {
      //This method accept the height for your cell.
      func heightFor(index : Int) -> CGFloat
   }

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FeedModelProtocol, CustomLayoutDelegate {
    
    
    
    
    

    var feedItems: NSArray = NSArray()
    var selectedStock : News = News()
    
    @IBOutlet weak var stockResultsFeed: UICollectionView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        up1()
    }
    
    
    
    
    
    
    
    
    
    
    

    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        //configureLayout()
    }
    
    
    func configureLayout() {
      // 1
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
      // 2
        stockResultsFeed.collectionViewLayout =
        UICollectionViewCompositionalLayout.list(using: configuration)
    }

    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.stockResultsFeed.reloadData()
    }
    
    func heightFor(index: Int) -> CGFloat {

        //Implement your own logic to return the height for specific cell
        return CGFloat(max(1, index) * 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "stockCell"
        switch indexPath.section {
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailCollectionViewCell
           // cell.layer.borderWidth = Constants.borderWidth
                
                //let user = allPartyUserArr![index]
                //cell.config(withUser: user)
            let item1: News = feedItems[indexPath.item] as! News
            cell.Label.lineBreakMode = .byCharWrapping
            cell.Label.numberOfLines = 1
            
            guard let imageURL = URL(string: item1.titleImageUrl!) else { return UICollectionViewCell()}
            
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.Image.image = image
                }
            }
            

            cell.Label.text = item1.title!
            //let titleStr: String = item1.title!
                return cell
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Show") as? DetailViewController
        let selectedToDo: News = feedItems[indexPath.item] as! News
        vc?.todo = selectedToDo
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
       
    
    
    func up1 () {
       self.stockResultsFeed.delegate = self
        self.stockResultsFeed.dataSource = self
        
        let feedModel = FeedModel()
        feedModel.delegate = self
        feedModel.downloadItems()
    }


}



// MARK: - Constants


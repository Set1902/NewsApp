//
//  DetailViewController.swift
//  AutodocNews
//
//  Created by Sergei Kovalev on 25.07.2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UICollectionViewDelegate {
    
    
    

    @IBOutlet weak var date: UILabel!
    

    @IBOutlet weak var titttle: UILabel!
    
    
    @IBOutlet weak var image101: UIImageView!
    
    
    @IBOutlet weak var desc: UILabel!
    var todo: News?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        desc.lineBreakMode = .byWordWrapping
        desc.numberOfLines = 2
        
        // Do any additional setup after loading the view.
        
        if let todo1 = todo{
            self.title = todo1.title!
            titttle.text = todo1.categoryType!
            date.text = todo1.publishedDate!
            desc.text = todo1.description1! + "."
            guard let imageURL = URL(string: todo1.titleImageUrl!) else { return }
            
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.image101.image = image
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
        
}


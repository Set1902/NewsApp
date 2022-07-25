import Foundation


protocol FeedModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class FeedModel :  NSObject, URLSessionDataDelegate {
    
    weak var delegate: FeedModelProtocol!
    private let urlPath = "https://webapi.autodoc.ru/api/news/1/15"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            //lll
            if error != nil {
                print("Error")
            }else {
                print("stocks downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    
    
    func parseJSON(_ data:Data) {
            
            var jsonResult = NSDictionary()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                let firstKey: String = (
                    try! JSONSerialization.jsonObject(
                        with: data,
                        options: .mutableContainers
                    ) as! [String: Any]).first!.key
                
                print("kkk\(firstKey)")

                
                
            } catch let error as NSError {
                print(error)
                
            }
        print(jsonResult)
            
            var jsonElement = NSArray()
            let stocks = NSMutableArray()
        var jsonElement2 = NSDictionary()
        
        
            
        for (key, value) in jsonResult
            {
            if key as! String == "news" {
                print("iii\(key)")
            jsonElement = value as! NSArray
                print("iii\(jsonElement)")
                
                
                for i in 0 ..< jsonElement.count
                {
                    
                    jsonElement2 = jsonElement[i] as! NSDictionary
                    
                    let stock = News()
                    
                    //the following insures none of the JsonElement values are nil through optional binding
                    if  let categoryType = jsonElement2["categoryType"] as? String,
                        let description1 = jsonElement2["description"] as? String,
                        let fullUrl = jsonElement2["fullUrl"] as? String,
                        let id = jsonElement2["id"] as? Int,
                        let publishedDate = jsonElement2["publishedDate"] as? String,
                        let title = jsonElement2["title"] as? String,
                        let titleImageUrl = jsonElement2["titleImageUrl"] as? String,
                         
                        let url = jsonElement2["url"] as? String
                         
                         
                         
                    {
                        
                        stock.categoryType = categoryType
                        stock.description1 = description1
                        stock.fullUrl = fullUrl
                        stock.id = id
                        stock.publishedDate = publishedDate
                        stock.title = title
                        stock.titleImageUrl = titleImageUrl
                        
                        stock.url = url
                        
                        
                        
                        print("jjj\(stock.categoryType)")
                    }
                    
                    
                    stocks.add(stock)
                    
                }

                
            }
                
                
            
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: stocks)
                
            })
        }
    
    
    
    
}

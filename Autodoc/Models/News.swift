//
//  News.swift
//  Autodoc
//
//  Created by Sergei Kovalev on 25.07.2022.
//

import Foundation



class News: NSObject {
    var id: Int?
    var title: String?
    var description1: String?
    var publishedDate: String?
    var url: String?
    var fullUrl: String?
    var titleImageUrl: String?
    var categoryType: String?
    
    override init()
    {
        
    }
    
    init(id: Int, title: String, description1: String, publishedDate: String, url: String, fullUrl: String, titleImageUrl: String, categoryType: String) {
        
        self.id = id
        self.title = title
        self.description1 = description1
        self.publishedDate = publishedDate
        self.url = url
        self.fullUrl = fullUrl
        self.titleImageUrl = titleImageUrl
        self.categoryType = categoryType
       
        
    }
    
}



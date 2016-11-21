//
//  Topstory.swift
//  NYTTopStories
//
//  Created by Tong Lin on 11/20/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

class TopStory {
    /*
     "results": [
     {
     "section": "Briefing",
     "subsection": "",
     "title": "Aleppo, Donald Trump, Asia-Pacific Economic Cooperation: Your Monday Briefing",
     "abstract": "Here’s what you need to know to start your day.",
     "url": "http://www.nytimes.com/2016/11/21/briefing/asia-briefing.html",
     "byline": "By CHARLES McDERMID",
     "item_type": "Article",
     "updated_date": "2016-11-20T14:21:23-05:00",
     "created_date": "2016-11-20T14:21:25-05:00",
     "published_date": "2016-11-20T14:21:25-05:00",
     "material_type_facet": "",
     */
    
    let title: String
    let abstract: String
    let byline: String
    let url: String
    
    init(title: String, abstract: String, byline: String, url: String) {
        self.title = title
        self.abstract = abstract
        self.byline = byline
        self.url = url
    }
    
    static func getTopStories(data: Data) -> [TopStory]?{
        do {
            var finalData = [TopStory]()
            let json: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            guard let results: [AnyObject] = json["results"] as? [AnyObject] else { return nil  }
            for rawData in results{
                guard let title: String = rawData["title"] as? String else { return nil }
                guard let abstract: String = rawData["abstract"] as? String else { return nil }
                guard let byline: String = rawData["byline"] as? String else { return nil }
                guard let url: String = rawData["url"] as? String else { return nil }
                finalData.append(TopStory(title: title, abstract: abstract, byline: byline, url: url))
            }
            
            return finalData
        } catch {
            print("what's error?")
        }
        
        return nil
    }
}

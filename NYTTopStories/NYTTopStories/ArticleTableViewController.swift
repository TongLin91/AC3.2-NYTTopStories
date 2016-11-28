//
//  ArticleTableViewController.swift
//  NYTTopStories
//
//  Created by Tong Lin on 11/22/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    let NYTAPIKey = "328b4e49772e49c5baad566091616130"
    let cellIdentifier = "ArticleCellIdentifier"
    var allArticles = [Article]()
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(NYTAPIKey)") { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        self.allArticles = Article.parseArticles(from: records)
                        
                        // start off with everything
                        self.articles = self.allArticles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.titleLabel.text = article.title
        cell.bylineLabel.text = article.byline
        cell.abstractLabel.text = article.abstract
        return cell
    }

    
    func applyPredicate(search: String) {
        //let predicate = NSPredicate(format:"abstract contains[c] %@ or title contains[c] %@", search, search)
        let predicate = NSPredicate(format:"ANY per_facet contains[c] %@", search) // Trump, Donald J
        
        self.articles = self.allArticles.filter { predicate.evaluate(with: $0) }
        self.tableView.reloadData()
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.characters.count > 0 {
                applyPredicate(search: text)
            }
            else {
                self.articles = self.allArticles
                self.tableView.reloadData()
            }
        }
        return true
    }

}

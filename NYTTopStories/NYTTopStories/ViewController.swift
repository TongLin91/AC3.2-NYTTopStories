//
//  ViewController.swift
//  NYTTopStories
//
//  Created by Tong Lin on 11/20/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

let NYTAPIKey = "328b4e49772e49c5baad566091616130"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    lazy var tableView = UITableView()
    var stories = [TopStory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
        loadData()
    }

    func loadTableView(){
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.lightGray
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        //tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        view.addSubview(tableView)
        
    }
    
    func loadData(){
        APIRequestManager.manager.getData(urlString: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(NYTAPIKey)"){
            (someThing: Data?) in
            if someThing != nil {
                DispatchQueue.main.async {
                    if let nytStories = TopStory.getTopStories(data: someThing!){
                        self.stories = nytStories
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as! TableViewCell
        
        cell.story = stories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: stories[indexPath.row].url)!
        UIApplication.shared.open(url)
    }
}


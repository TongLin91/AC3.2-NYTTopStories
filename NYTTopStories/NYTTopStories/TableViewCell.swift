//
//  TableViewCell.swift
//  NYTTopStories
//
//  Created by Tong Lin on 11/21/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let cellIdentifier = "NYTTopStoriesCellIdentifier"
    
    var title: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.white
        lb.font = .systemFont(ofSize: 17)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    var byline: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.white
        lb.font = .systemFont(ofSize: 10)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    var abstract: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = UIColor.white
        lb.font = .systemFont(ofSize: 12)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    var story: TopStory? {
        didSet{
            guard let info = story else { return  }
            setupInfo(info: info)
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        addSubview(title)
        addSubview(byline)
        addSubview(abstract)
        
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: -8).isActive = true
        
        byline.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        byline.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        byline.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        
        abstract.topAnchor.constraint(equalTo: byline.bottomAnchor, constant: 10).isActive = true
        abstract.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        abstract.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        abstract.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        
    }
    
    func setupInfo(info: TopStory){
        title.text = info.title
        byline.text = info.byline
        abstract.text = info.abstract
    }
}

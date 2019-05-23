//
//  TableViewCell.swift
//  Assignment
//
//  Created by test on 22/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:80).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        //containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0)   //constraint(equalToConstant:0).isActive = true
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        //containerView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        //descriptionLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        
        
        //containerView.bottomAnchor.constraint(equalTo:self.descriptionLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor =  UIColor.white
        label.textColor =  UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  UIColor.black
        label.backgroundColor =  UIColor.white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    var cellDetails:Rows? {
        didSet {
            guard let cellItem = cellDetails else {return}

            if let cellTitle = cellItem.title {
                titleLabel.text = " \(cellTitle) "
            }
            if let cellDescription = cellItem.description {
                descriptionLabel.text = " \(cellDescription) "
                
                let height = self.heightForLabel(text: " \(cellDescription) ", font: UIFont.boldSystemFont(ofSize: 14), width: 280)
               
                descriptionLabel.heightAnchor.constraint(equalToConstant:height).isActive = true
                containerView.bottomAnchor.constraint(equalTo:self.descriptionLabel.bottomAnchor).isActive = true
            }
            if let img = cellItem.imageHref {
                profileImageView.downloadImageFrom(link: img, contentMode: UIView.ContentMode.scaleAspectFit)
            }
        }
    }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label = UILabel()
        label.frame.size = CGSize(width: width, height:CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
        
    }
}

//to Download images from link
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        
        if self.image == nil{
            self.image = UIImage(named: "ios-application-placeholder.png")
        }
        
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

//
//  TableViewCell.swift
//  Assignment
//
//  Created by test on 22/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var labelHeight : CGFloat?
    
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
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:80).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:topAnchor, constant:5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant:-10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo:topAnchor, constant:30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant:-10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Label creation
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
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
    
    //MARK: Other methods
    var cellDetails:FactsModel? {
        didSet {
            guard let cellItem = cellDetails else {return}

            if let cellTitle = cellItem.title {
                titleLabel.text = " \(cellTitle) "
            } else {
                titleLabel.text = ""
            }
            
            if let cellDescription = cellItem.description {
                descriptionLabel.text = " \(cellDescription) "
                
                let height = self.heightForLabel(text: " \(cellDescription) ", font: UIFont.boldSystemFont(ofSize: 14), width: UIScreen.main.bounds.size.width - 100)
                labelHeight = height
                
                descriptionLabel.heightAnchor.constraint(equalToConstant:height).isActive = true
                //containerView.bottomAnchor.constraint(equalTo:self.descriptionLabel.bottomAnchor).isActive = true
                //containerView.bottomAnchor.constraint(equalTo:self.descriptionLabel.bottomAnchor, constant:0).isActive = true
            } else {
                descriptionLabel.text = ""
            }
            
            //call function to download images from internet
            if let img = cellItem.imageHref {
                profileImageView.downloadImageFrom(link: img, contentMode: UIView.ContentMode.scaleAspectFit)
            } else {
                profileImageView.image = UIImage(named: "Image-1.png")
            }
        }
    }
    
    //calculate height for label with dynamic text
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
            self.image = UIImage(named: "Image-1.png")
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

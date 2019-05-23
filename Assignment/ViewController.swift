//
//  ViewController.swift
//  Assignment
//
//  Created by test on 21/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

let jsonData = """
{
"title":"About Canada",
"rows":[
    {
    "title":"Beavers",
    "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
    "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
    },
    {
    "title":"Flag",
    "description":null,
    "imageHref":"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
    },
    {
    "title":"Transportation",
    "description":"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
    "imageHref":"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"
    },
    {
    "title":"Hockey Night in Canada",
    "description":"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.",
    "imageHref":"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
    },
    {
    "title":"Eh",
    "description":"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.",
    "imageHref":null
    },
    {
    "title":"Housing",
    "description":"Warmer than you might think.",
    "imageHref":"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
    },
    {
    "title":"Public Shame",
    "description":" Sadly it's true.",
    "imageHref":"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg"
    },
    {
    "title":null,
    "description":null,
    "imageHref":null
    },
    {
    "title":"Space Program",
    "description":"Canada hopes to soon launch a man to the moon.",
    "imageHref":"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg"
    },
    {
    "title":"Meese",
    "description":"A moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you.",
    "imageHref":"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg"
    },
    {
    "title":"Geography",
    "description":"It's really big.",
    "imageHref":null
    },
    {
    "title":"Kittens...",
    "description":"Éare illegal. Cats are fine.",
    "imageHref":"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg"
    },
    {
    "title":"Mounties",
    "description":"They are the law. They are also Canada's foreign espionage service. Subtle.",
    "imageHref":"http://3.bp.blogspot.com/__mokxbTmuJM/RnWuJ6cE9cI/AAAAAAAAATw/6z3m3w9JDiU/s400/019843_31.jpg"
    },
    {
    "title":"Language",
    "description":"Nous parlons tous les langues importants.",
    "imageHref":null
    }
]
}
""".data(using: .utf8)!

var tableRows = [Rows]()


struct tableData : Codable {
    var title : String?
    var rows : [Rows]?

}

struct Rows : Codable {
    var title : String?
    var description : String?
    var imageHref: String?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var myTableView : UITableView = UITableView()
    var tableArray = [String] ()
    var images = [String]()
    var navTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
        
        parseData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//table View delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        //cell.textLabel?.text = tableRows[indexPath.row].title
        cell.cellDetails = tableRows[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
     func parseData() {
        guard let imageUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
            else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            
            guard let dataString = String(bytes: data!, encoding: String.Encoding.isoLatin1) else { return }
            print("responseString = \(dataString)")
            
            //guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let viewData = try decoder.decode(tableData.self, from: dataString.data(using: .utf8)!)
                //let viewData = try decoder.decode(tableData.self, from: Data(dataString.utf8))
               // let viewData = try decoder.decode(tableData.self, from: data)
                print("title: ", viewData.title!)
                if let navigationTitle = viewData.title {
                    self.navTitle = navigationTitle
                }else {
                    self.navTitle = ""
                }
                
                for row in viewData.rows!{
                    let values = Rows(title: row.title,  description:row.description, imageHref: row.imageHref)
                    tableRows.append(values)
                    if (row.imageHref != nil) {
                        //self.images.append(row.imageHref!.absoluteString)
                        self.images.append(row.imageHref!)
                    } else {
                        self.images.append("")
                    }
                }
                
                DispatchQueue.main.async {
                    self.createTableView()
                    self.myTableView.reloadData()
                }

            } catch let err {
                print("Err", err)
            }
            }.resume()
        
        
    }
    
    func createTableView () {
        
        self.navigationItem.title = self.navTitle
        
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        myTableView.frame.size = CGSize(width: screenWidth, height: screenHeight)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
        
        self.view.addSubview(myTableView)
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        myTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }

    //Refresh Table view
    @objc func refresh() {
        self.myTableView.reloadData()
    }
    
}


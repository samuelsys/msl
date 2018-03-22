//
//  ViewController.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import UIKit
import CoreData

let kScreenTitle = "MY FAMILY"
let kScreenSubtitle = "FAMILIA MOSILY"
let kCellIdentifier = "groupCellIdentifier"
let kDefaultTitleFont = "GurmukhiMN-Bold"
let kDefaultSubtitleFont = "GurmukhiMN-Bold"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var navigationItem2: UINavigationItem!
    @IBOutlet weak var groupTableView: UITableView!
    
    var members = [NSManagedObject](){
        didSet {
            self.groupTableView.reloadData()
        }
    }
    
    private lazy var manager = {
        return GroupManager()
    }()
    
    var bg:DispatchQueue = {
        return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup () {
        self.groupTableView.delegate = self
        self.groupTableView.dataSource = self
        
        self.setTitle(kScreenTitle, subtitle: kScreenSubtitle)
        
        self.members = MemberAccess.listMembers(filter: "")
        
        bg.async {
            sleep(4)
            if (self.members.count == 0) {
                self.fetchGroupAndSaveAtDatabase()
            }
        }
        
        self.setupLeftNavItem()
    }
    
    func fetchGroupAndSaveAtDatabase () {
        manager.fetchGroup {[weak self](result) in
            
            guard let _self = self else { return }
            
            do {
                guard let group = try result() else {
                    throw Errors.invalidValue
                }
                
                guard let members = group.members else {
                    throw Errors.invalidValue
                }
               
                if (_self.members.count == 0) {
                    MemberAccess.saveMembers(members: members)
                    _self.members = MemberAccess.listMembers(filter: "")
                }
                
            } catch {
                print ("error")
            }
        }
    }
    
    func setupLeftNavItem () {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 5, width:5, height: 5)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! GroupTableViewCell
        
        cell.setup(member: members[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            members.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension UIViewController {
    func setTitle(_ title: String, subtitle: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: kDefaultTitleFont, size: 16)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.lightText
        subtitleLabel.font = UIFont(name: kDefaultSubtitleFont, size: 14)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        self.navigationItem.titleView = titleView
    }
}



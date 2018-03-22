//
//  GroupTableViewCell.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 18/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//
import UIKit
import Kingfisher
import CoreData

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRoundedView(roundedView: memberImage)
    }
    
    func setup(member: NSManagedObject) {
        let placeholder = UIImage(named: "claquete")
        let urlPhoto = member.value(forKeyPath: "url_photo") as? String
        let memberName = member.value(forKeyPath: "member_name") as? String
        let type = member.value(forKeyPath: "type") as? String
        
        self.memberImage.contentMode = .center
        
        guard let validUrl = urlPhoto else {
            print("something went wrong with urlPhoto")
            return
        }
        
        if let url = URL(string: validUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            self.memberImage.kf.setImage(with: url,
                                         placeholder: placeholder,
                                         completionHandler: { [weak self] (image, _, _, _) in
                                            guard let _self = self else { return }
                                            
                                            if image != nil {
                                                _self.memberImage.contentMode = .scaleAspectFill
                                            }
            })
        }
        
        self.title.text = memberName
        self.subtitle.text =  type
    }
    
    func setRoundedView (roundedView:UIView) {
        let saveCenter = roundedView.center
        let newFrame:CGRect = CGRect(origin: CGPoint(x: roundedView.frame.origin.x,y :roundedView.frame.origin.y), size: CGSize(width: roundedView.frame.size.width, height: roundedView.frame.size.height))
        roundedView.layer.cornerRadius = roundedView.frame.height/2
        roundedView.frame = newFrame;
        roundedView.center = saveCenter
        roundedView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        title.text = ""
        subtitle.text = ""
        self.memberImage.kf.cancelDownloadTask()
    }
}


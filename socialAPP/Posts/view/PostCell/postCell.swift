//
//  postCell.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import UIKit

protocol AddToFavProtocol {
    func addPostToFav(postID:Int)
}
class postCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var delegate:AddToFavProtocol?
    var postID = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post:PostElement){
        self.titleLbl.text       = post.title
        self.descriptionLbl.text = post.body
    }
    
    func configureCell(comment:Comment){
        self.titleLbl.text       = comment.name
        self.descriptionLbl.text = comment.body
        favBtn.isHidden          = true
    }
    
    @IBAction func addToFavBtnPressed(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.delegate?.addPostToFav(postID: postID)
    }
}

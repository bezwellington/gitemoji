//
//  AppleRepoTableViewCell.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

import UIKit

final class AppleRepoTableViewCell: UITableViewCell {

    @IBOutlet weak private var repoNameLabel: UILabel!
    @IBOutlet weak private var repoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.repoView.layer.cornerRadius =  self.repoView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.repoNameLabel.text = ""
    }
    
    func setUp(repoName: String) {
        self.repoNameLabel.text = repoName
    }
}

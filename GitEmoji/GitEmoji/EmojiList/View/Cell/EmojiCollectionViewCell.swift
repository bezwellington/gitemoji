//
//  EmojiCollectionViewCell.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

import UIKit

final class EmojiCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak private var emojiImageview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        self.emojiImageview.sd_setImage(with: url)
    }
}

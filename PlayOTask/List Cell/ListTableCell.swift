//
//  ListTableCell.swift
//  PlayOTask
//
//  Created by sunil biloniya on 14/05/22.
//

import UIKit
import SDWebImage
class ListTableCell: UITableViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var lbl_author: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var img_news: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getConfige(_ data: Article?) {
        lbl_author.text = data?.author ?? ""
        lbl_title.text = data?.title ?? ""
        lbl_desc.text = data?.articleDescription ?? ""
        img_news.sd_setImage(with: URL(string: data?.urlToImage ?? ""), placeholderImage: UIImage(named: ""))
    }
    
}

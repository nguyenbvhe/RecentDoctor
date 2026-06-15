//
//  IntroCollectionCell.swift
//  RecentDoctor
//
//  Created by minhnguyen on 12/6/26.
//

import UIKit

class IntroCollectionCell: UICollectionViewCell , SummaryMethod {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var imageIntro: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.backgroundColor = .clear
    }
    func configure(with introModel: IntroModel) {
        labelTitle.text = introModel.title
        labelQuote.text = introModel.quote
        imageIntro.image = UIImage(named: introModel.image)
    }

}

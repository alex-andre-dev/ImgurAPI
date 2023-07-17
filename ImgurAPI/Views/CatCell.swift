//
//  CatsCell.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 14/07/23.
//

import UIKit
import SDWebImage

class CatCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var representedIndentifier: String = ""
    
    public let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    public let catImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func loadImages(data: Data?) {
        if let data = data {
            catImageView.image = UIImage(data: data)
            placeholderLabel.isHidden = true
            layer.borderWidth = 0
        }
    }
    
    
    func loadMedias(media: CatImage?){
        if let media = media {
            if let url = URL(string: media.link){
                catImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
    //MARK: - ViewProtocol
extension CatCell: ViewProtocol {
    func setupUI() {
        placeholderLabel.text = "Imgur \nCat \npic"
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupHierarchy() {
        addSubview(placeholderLabel)
        addSubview(catImageView)

    }
    
    func setupConstraints() {
        placeholderLabel.fillEntireView(view: self, padding: .init(top: 10, left: 20, bottom: 20, right: 10))
        catImageView.fillEntireView(view: self)
    }
    
    
}

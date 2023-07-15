//
//  CatsCell.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 14/07/23.
//

import UIKit

class CatCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    private let CatImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
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
}

extension CatCell: ViewProtocol {
    func setupUI() {
        placeholderLabel.text = "Imgur \nCat \npic"
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupHierarchy() {
        addSubview(placeholderLabel)
        addSubview(CatImageView)
    }
    
    func setupConstraints() {
        placeholderLabel.fillEntireView(view: self, padding: .init(top: 10, left: 20, bottom: 20, right: 10))
        CatImageView.fillEntireView(view: self)
    }
    
    
}

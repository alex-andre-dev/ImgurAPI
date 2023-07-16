//
//  CatsCollectionViewController.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 14/07/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class CatsCollectionViewController: UICollectionViewController {
    
    //MARK: - ViewModel
    private var viewModel: CatsCollectionViewModel
    
    
    //MARK: - Initializers
    init(collectionViewLayout layout: UICollectionViewLayout, viewModel: CatsCollectionViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchCatMedias()
    }
    //MARK: - Helpers
    
    private func fetchCatMedias() {
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.backgroundColor = .red
                print("foi")
            }
        }
    }

    //MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CatsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.height / 10
        let height = collectionView.bounds.height / 6
        return .init(width: width, height: height)
    }
    
}

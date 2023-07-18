//
//  CatsCollectionViewController.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 14/07/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class CatsCollectionViewController: UICollectionViewController, ViewProtocol {

    //MARK: - Properties
    
    private var viewModel: CatsCollectionViewModel
    
    //Indicador que da o feedback visual de que as imagens estão carregando
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //Alerta que aparece quando da algum erro ao carregar as imagens
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Erro", message: "Houve um erro ao tentar carregar as imagens de gatinhos", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Tentar Novamente", style: .default) {_ in
            self.fetchCatMedias()
        }
        alertController.addAction(closeAction)
        return alertController
    }()
    
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
        //Funcão criada no ViewProtocol que chama outras tres funções setupUI, setupHierarchy, setupConstraints
        setupView()
        setupCollectionView()
        fetchCatMedias()
    }
    
    //MARK: - Helpers
    
    func setupUI() {
        setupNavigationBar()
    }
    
    func setupHierarchy() {
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator.center = view.center
    }
    
    //Carrega as imagens e apresenta um alerta em caso de erro
    @objc func fetchCatMedias() {
        viewModel.cleanCatImage()
        activityIndicator.startAnimating()
        collectionView.reloadData()
        viewModel.fetchCatMedias { [weak self] error in
            DispatchQueue.main.async {
                if error != nil {
                    self?.presentAlert()
                }
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func presentAlert(){
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Galeria"
        let addButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchCatMedias))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupCollectionView() {
        collectionView.register(CatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    //MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCatImages
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatCell
        let catImage = viewModel.catImage(at: indexPath.item)
        //Define o id da celula igual ao id da imagem
        cell.representedIndentifier = catImage.id
        //Esse if com esse id serve para garantir que nenhuma celula carregue a imagem errada
        if cell.representedIndentifier == catImage.id {
            cell.loadMedias(media: catImage)
        }
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




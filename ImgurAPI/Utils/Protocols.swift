//
//  Protocols.swift
//  Instagram
//
//  Created by Alexandre  Machado on 12/07/23.
//

protocol ViewProtocol {
    func setupUI()
    func setupHierarchy()
    func setupConstraints()
    
}
extension ViewProtocol{
    func setupView(){
        setupUI()
        setupHierarchy()
        setupConstraints()
    }
}

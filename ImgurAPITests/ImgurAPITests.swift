//
//  ImgurAPITests.swift
//  ImgurAPITests
//
//  Created by Alexandre  Machado on 17/07/23.
//
@testable import ImgurAPI

import XCTest

class ImgurAPITests: XCTestCase {
    var mainVC: CatsCollectionViewController!
    var mainVM: CatsCollectionViewModel!
    
    override func setUp() {
        mainVM = CatsCollectionViewModel()
        mainVC = CatsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), viewModel: mainVM)
    }
    
    func testInitialProperties(){
        XCTAssertEqual(0,(mainVC.collectionView.numberOfItems(inSection: 0)))
        XCTAssertEqual(0,(mainVM.numberOfCatImages))
    }

}

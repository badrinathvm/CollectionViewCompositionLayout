//
//  ViewController.swift
//  CollectionViewCompositionLayout
//
//  Created by Venkatnarayansetty, Badarinath on 11/6/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import UIKit

enum Section {
    case main
}

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section , Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view Controller Loaded")
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        configureDataSource()
    }
}

extension ViewController {
    //Components - item , group , section , layout
    func createLayout() -> UICollectionViewCompositionalLayout {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        //layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ListCell.reuseIdentifier,
                for: indexPath) as? ListCell else { fatalError("Cannot create new cell") }
            
            // Populate the cell with our item description.
            cell.label.text = "\(identifier)"
            
            // Return the cell.
            return cell
        })
        
        //initial Data
        var snapShot = NSDiffableDataSourceSnapshot<Section,Int>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0..<94))
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}


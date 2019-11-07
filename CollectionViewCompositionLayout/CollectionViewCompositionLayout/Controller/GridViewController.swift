//
//  GridViewController.swift
//  CollectionViewCompositionLayout
//
//  Created by Venkatnarayansetty, Badarinath on 11/6/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import Foundation
import UIKit

class GridViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        return collectionView
    }()
    
    var dataSource:UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        configureDataSource()
    }
}

extension GridViewController {
    // items, group , section , layout
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        //Notes:  in order to be square item width should be equal to group height
        
        // .fractionalWidth(0.2) - 20% of the width of the container ( so that u can see 5 components )
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //group - Represents row
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [items])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell else { fatalError("Could not create new cell") }
            
            // Populate the cell with our item description.
            cell.label.text = "\(identifier)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
            
            // Return the cell.
            return cell
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0..<94))
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}

extension UIColor {
    static var cornflowerBlue: UIColor {
        return UIColor(displayP3Red: 100.0 / 255.0, green: 149.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
}

//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by 최민섭 on 22/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var numberOfCell = 20 {
        didSet {
            if numberOfCell > 50 {
                numberOfCell = 50
            } else if numberOfCell < 0{
                numberOfCell = 0
            }
        }
    }
    
    private var pokemons: [UIImage] {
        var pokemons:[UIImage] = []
        for i in 0...50 {
            let index = i % 16
            let image = UIImage(named: "pokemon\(index)")!
            pokemons.append(image)
        }
        return pokemons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MonsterCell", bundle: nil), forCellWithReuseIdentifier: "MonsterCell")
        collectionView.register(UINib(nibName: "FooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        
        setupFlowLayout()
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 3
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: halfWidth * 0.9)
        flowLayout.footerReferenceSize = CGSize(width: halfWidth * 3, height: 70)
        flowLayout.sectionFootersPinToVisibleBounds = true
        self.collectionView.collectionViewLayout = flowLayout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath) as? FooterView else {
            return UICollectionReusableView()
        }
        
        footerView.action = { (state: ButtonState) in
            switch state {
            case .plus:
                self.numberOfCell += 1
            case .minus:
                self.numberOfCell -= 1
            default:
                break
            }
            self.collectionView.reloadData()
        }
        
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonsterCell", for: indexPath) as? MonsterCell else {
            return UICollectionViewCell()
        }
    
        cell.imageView.image = pokemons[indexPath.row]
        return cell
    }
}

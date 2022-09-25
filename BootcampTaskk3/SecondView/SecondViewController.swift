//
//  SecondViewController.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 23.09.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = PhotosListViewModel()
    private var items: [PhotosCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCellIdentifier")

        self.view.backgroundColor = .white
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
        PhotosListModel().fetchData()
        
    }
    
}
extension SecondViewController: PhotosListViewModelViewProtocol {
    func showEmptyView() {
    
    }
    
    func hideEmptyView() {
        
    }
    
    
    func didCellItemFetch(_ items: [PhotosCellViewModel]) {
        self.items = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SecondViewController: UICollectionViewDelegate {
    
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCellIdentifier", for: indexPath) as! PhotosCollectionViewCell
        let url = items[indexPath.row].thumbnailUrl
        cell.setup(url: url)

        return cell
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView.frame.width > 340 {
            let width = (collectionView.frame.width - 40) / 4
            let height = width
            
            return CGSize(width: width, height: height)
        }
        let width = (collectionView.frame.width - 35) / 3
        let height = width
        
        return CGSize(width: width, height: height)
    
    }
}

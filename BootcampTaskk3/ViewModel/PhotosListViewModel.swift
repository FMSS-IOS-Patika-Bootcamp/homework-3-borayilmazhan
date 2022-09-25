//
//  PhotosListViewModel.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 24.09.2022.
//

import Foundation

protocol PhotosListViewModelViewProtocol: AnyObject {
    func didCellItemFetch(_ items: [PhotosCellViewModel])
    func showEmptyView()
    func hideEmptyView()
}

class PhotosListViewModel {
    
    private let model = PhotosListModel()
    
    weak var viewDelegate:  PhotosListViewModelViewProtocol?
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
    
    func didClickItem(at index: Int) {
        let selectedItem = model.photos[index]
        // TODO: NAVIGATe
    }
    
}
private extension PhotosListViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ photos: [Photos]) -> [PhotosCellViewModel] {
        return photos.map {.init(title: $0.title, url: $0.url, thumbnailUrl: $0.thumbnailUrl) }
    }
}

extension PhotosListViewModel: PhotosListModelProtocol {
    
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let photos = model.photos
            let cellModels = makeViewBasedModel(photos)
            viewDelegate?.didCellItemFetch(cellModels)
            viewDelegate?.hideEmptyView()
        } else {
            viewDelegate?.showEmptyView()
        }
        
    }
}

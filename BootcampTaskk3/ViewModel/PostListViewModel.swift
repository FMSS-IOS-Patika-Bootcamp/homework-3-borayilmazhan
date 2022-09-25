//
//  PostListViewModel.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 22.09.2022.
//

import Foundation

protocol PostListViewModelViewProtocol: AnyObject {
    func didCellItemFetch(_ items: [PostCellViewModel])
    func showEmptyView()
    func hideEmptyView()

}

class PostListViewModel {
    
    private let model = PostListModel()
    
    weak var viewDelegate:  PostListViewModelViewProtocol?
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
    
    func didClickItem(at index: Int) {
        let selectedItem = model.posts[index]
        // TODO: NAVIGATe
    }
}

private extension PostListViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: [Post]) -> [PostCellViewModel] {
        return posts.map {.init(title: $0.title, desc: $0.body) }
    }
}

//MARK: - PostListModelProtocol
extension PostListViewModel: PostListModelProtocol {
    
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts)
            viewDelegate?.didCellItemFetch(cellModels)
            viewDelegate?.hideEmptyView()
        } else {
            viewDelegate?.showEmptyView()
        }
        
    }
}

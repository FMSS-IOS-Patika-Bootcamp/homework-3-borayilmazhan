//
//  PhotosListModel.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 23.09.2022.
//

import Foundation

protocol PhotosListModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class PhotosListModel {
    
    weak var delegate:  PhotosListModelProtocol?
    
    var photos: [Photos] = []
    
    func fetchData() {
        
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/photos") else {
            delegate?.didDataFetchProcessFinish(false)
            return
        }
        
        
        
        
//
//        let queryItems = [URLQueryItem(name: "limit", value: "5")]
//        var urlComp = URLComponents(string: "https://jsonplaceholder.typicode.com/photos")!
//        urlComp.queryItems = queryItems
//
//        var request = URLRequest(url: urlComp.url!)
//
        
        
        
        
        
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
//            guard let self = self else { return }
            
            guard
                 error == nil
            else {
                self.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            guard
                statusCode >= 200,
                statusCode < 300
            else {
                self.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            guard let data = data else {
                self.delegate?.didDataFetchProcessFinish(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                self.photos = try jsonDecoder.decode([Photos].self, from: data)
                print(self.photos)
                self.delegate?.didDataFetchProcessFinish(true)
            } catch {
                self.delegate?.didDataFetchProcessFinish(false)

            }
        }
        
        task.resume()
    }
}


//
//  MainViewModel.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/29/21.
//

import Foundation

final class MainViewModel {
    let service = NewsService()
    
    var news: [News] = []
    
    var didStartRequest: (() -> Void)?
    var didEndRequest: (() -> Void)?
    var didSucessLoadNews: (() -> Void)?
    var showErrorAlert: ((Error) -> Void)?
    
    func getNews() {
        didStartRequest?()
        service.getNewsList(success: { [weak self] news in
            self?.news = news
            self?.didSucessLoadNews?()
            self?.didEndRequest?()
        }, failure: { [weak self] error in
            self?.didEndRequest?()
            self?.showErrorAlert?(error)
        })
    }
}

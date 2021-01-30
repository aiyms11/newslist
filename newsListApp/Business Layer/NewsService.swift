//
//  NewsService.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/30/21.
//

import Foundation

final class NewsService {
    func getNewsList(success: @escaping (([News]) -> Void),
                     failure:  @escaping ((Error) -> Void)) {
        guard let url = URL(string: "http://newsapi.org/v2/everything?q=apple&from=2021-01-29&to=2021-01-29&sortBy=popularity&apiKey=09d2fd3a29bf4831a2b05a84e54e657c") else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil{
                    failure(error as! Error)
                }
                if let safeData = data{
                    if let newsWrapper = self.parseJSON(safeData){
                        let data = newsWrapper.articles
                        success(data)
                    }
                }
            }
            task.resume()
    }
    private func parseJSON(_ data: Data) -> NewsWrapper? {
        let decoder = JSONDecoder()
        do{
        let decodedData = try decoder.decode(NewsWrapper.self, from: data)
            return decodedData
        }catch{
            return nil
        }
    }
}

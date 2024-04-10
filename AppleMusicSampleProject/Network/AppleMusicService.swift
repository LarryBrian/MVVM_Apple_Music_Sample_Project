//
//  AppleMusicService.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import Foundation
import UIKit

protocol AppleMusicServiceProtocol {
    func fetchTopAlbumsFromAppleMusic(from url: String, completion: @escaping (Result <AppleMusicResponse, Error>) -> Void)
}

struct AppleMusicResponse: Codable {
    var feed: Feed?
}

final class AppleMusicService: AppleMusicServiceProtocol {
    func fetchTopAlbumsFromAppleMusic(from url: String, completion: @escaping (Result<AppleMusicResponse, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let jsonData = data, error == nil else {
                print("something went wrong with fetching the albums")
                completion(.failure(error!))
                return
            }
            
            let result = Result(catching: {try JSONDecoder().decode(AppleMusicResponse.self, from: jsonData)})
            
            completion(result)
        })
        
        task.resume()
    }
}

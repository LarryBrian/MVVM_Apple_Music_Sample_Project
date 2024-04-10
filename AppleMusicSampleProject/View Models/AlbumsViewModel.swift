//
//  AlbumsViewModel.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import Foundation

class AlbumsViewModel {
    
    // MARK: - VARIABLES
    var topAlbumsURL = Constants().appleMusicTopAlbumsURL
    var isFetchedAlbumsSuccessful = false
    private let appleMusicService: AppleMusicServiceProtocol
    
    
    // MARK: - LIFECYCLE
    init(appleMusicService: AppleMusicServiceProtocol = AppleMusicService()) {
        self.appleMusicService = appleMusicService
    }
    
    // MARK: - FUNCTIONS
    func fetchTopAlbumsFromAppleMusic(completion: @escaping (Result <AppleMusicResponse, Error>) -> Void) {
        
        appleMusicService.fetchTopAlbumsFromAppleMusic(from: topAlbumsURL, completion: { [weak self] results in
                                    
            switch results {
            case .success:
                // included for testing
                self?.isFetchedAlbumsSuccessful = true
            case .failure:
                // included for testing
                self?.isFetchedAlbumsSuccessful = false
            }
            
            // passing results to albums VC to update the UI
            completion(results)
        })
    }
}

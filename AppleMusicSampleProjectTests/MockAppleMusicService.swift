//
//  MockAppleMusicService.swift
//  AppleMusicSampleProjectTests
//
//  Created by Brian King on 5/16/21.
//

import Foundation
@testable import AppleMusicSampleProject

final class MockAppleMusicService: AppleMusicServiceProtocol {
    func fetchTopAlbumsFromAppleMusic(from url: String, completion: @escaping (Result<AppleMusicResponse, Error>) -> Void) {
        completion(.success(AppleMusicResponse.init(feed: nil)))
    }
}

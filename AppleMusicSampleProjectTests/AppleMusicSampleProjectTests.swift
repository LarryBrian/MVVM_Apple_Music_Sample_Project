//
//  AppleMusicSampleProjectTests.swift
//  AppleMusicSampleProjectTests
//
//  Created by Brian King on 5/16/21.
//

import XCTest
@testable import AppleMusicSampleProject

class AppleMusicSampleProjectTests: XCTestCase {

    var viewModel: AlbumsViewModel!
    var mockAppleMusicService: MockAppleMusicService!
    
    override func setUp() {
        mockAppleMusicService = MockAppleMusicService()
        viewModel = .init()
    }
    
    func testAppleMusicTopAlbumsUrlIsCorrect() {
        XCTAssertEqual(viewModel.topAlbumsURL, Constants().appleMusicTopAlbumsURL)
    }
    
    
    func testWhenFetchedAlbumResultsToSuccess() {
        viewModel = .init(appleMusicService: mockAppleMusicService!)
        viewModel.fetchTopAlbumsFromAppleMusic(completion: {result in
        })
        
        XCTAssertTrue(viewModel.isFetchedAlbumsSuccessful == true)
    }

    
    func testFetchAppleMusicSuccessCall() {
        viewModel.fetchTopAlbumsFromAppleMusic(completion: { result in
            switch result {
            case .success(let result):
                if let _albums = result.feed?.results {
                    XCTAssertGreaterThanOrEqual(_albums.count, 1)
                }
            case .failure(let error):
                print("There was an error with fetching the feed: \(error)")
                XCTFail()
            }
        })
    }
    
    func testFetchAppleMusicFailureCall() {
        viewModel.topAlbumsURL = "https://www.google.com"
        viewModel.fetchTopAlbumsFromAppleMusic(completion: { result in
            switch result {
            case .success(let result):
              print("successful call: \(result)")
                XCTFail()
            case .failure(let error):
                print("There was an error with fetching the feed: \(error)")
                XCTAssertNotNil(error)
            }
        })
    }
}

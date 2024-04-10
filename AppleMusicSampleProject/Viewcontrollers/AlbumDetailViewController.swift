//
//  AlbumDetailViewController.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var iTunesStoreButton: UIButton!
    
    // MARK: - VARIABLES
    var album: Album?
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIAttributesForAlbum()
    }
    
    
    // MARK: - FUNCTIONS
    func setUIAttributesForAlbum() {
        if let _album = album {
            albumNameLabel.text = _album.name
            artistNameLabel.text = _album.artistName
            genreLabel.text = _album.genres?.first?.name
            releasedDateLabel.text = "Released: \(_album.releaseDate ?? "")"
            
            if let _imageURL = _album.artworkUrl100 {
                backgroundImageView.loadImage(from: _imageURL)
            }
            self.iTunesStoreButton.isEnabled = true
        } else {
            self.iTunesStoreButton.isEnabled = false
        }
        
        self.iTunesStoreButton.layer.cornerRadius = 4.0
        self.iTunesStoreButton.clipsToBounds = true
    }
    
    // MARK: - IBACTIONS
    @IBAction func seeInStoreButtonTapped(_ sender: UIButton) {
        if let _album = album, let _urlString = _album.url {
            if let url = URL(string: _urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}

//
//  AlbumTableViewCell.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // MARK: - VARIABLES
    var album: Album? {
        didSet {
            if let _album = album {
                albumNameLabel.text = _album.name
                artistNameLabel.text = _album.artistName
                
                if let _artWorkUrl = _album.artworkUrl100 {
                    self.albumArtImageView.loadImage(from: _artWorkUrl)
                }
            }
        }
    }
    
    // MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadiusToImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCornerRadiusToImage() {
        self.albumArtImageView.layer.cornerRadius = 6.0
        self.albumArtImageView.clipsToBounds = true
    }
}

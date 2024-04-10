//
//  ViewController.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import UIKit
class AlbumsViewController: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var albumsTableView: UITableView!
    
    // MARK: - VARIABLES
    var selectedAlbum: Album?
    var albums = [Album]() {
        didSet {
            DispatchQueue.main.async {
                self.albumsTableView.reloadData()
            }
        }
    }
    let viewModel = AlbumsViewModel()
    let activityIndicator = ActivityIndicatorViewController()
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDatasources()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createActivityIndicator()
        fetchAlbums()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumDetailsVC" {
            let detailsVC = segue.destination as! AlbumDetailViewController
            detailsVC.album = selectedAlbum
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setDelegatesAndDatasources() {
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }
    
    private func fetchAlbums() {
        viewModel.fetchTopAlbumsFromAppleMusic(completion: { [weak self] result in               
                switch result {
                case .success(let result):
                    if let _albums = result.feed?.results {
                        self?.albums = _albums
                        
                        DispatchQueue.main.async {
                            self?.activityIndicator.willMove(toParent: nil)
                            self?.activityIndicator.view.removeFromSuperview()
                            self?.activityIndicator.removeFromParent()
                        }
                    }
                case .failure(let error):
                    print("There was an error with fetching the feed: \(error)")
                    DispatchQueue.main.async {
                        let alert = UIAlertController.init(title: "Oops!", message: "There was a problem loading the top albums from Apple Music.", preferredStyle: .alert)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    
    
    private func createActivityIndicator() {
        addChild(activityIndicator)
        activityIndicator.view.frame = view.frame
        view.addSubview(activityIndicator.view)
        activityIndicator.didMove(toParent: self)
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as! AlbumTableViewCell
        
        cell.album = albums[indexPath.row]
        
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlbum = albums[indexPath.row]
        performSegue(withIdentifier: "showAlbumDetailsVC", sender: self)
    }
}


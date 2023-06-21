//
//  ViewController.swift
//  Rest API
//
//  Created by DA MAC M1 157 on 2023/06/18.
//

import UIKit

class MovieViewController: UIViewController {
    
    private var viewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    // for testing the url
    //var webService = Webservice()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularMoviesData()
        // for testing url after writing webservice
//        webService.getPopularMovies { result in
//            print(result)
//        }
    }
    
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMovies {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }

}


//MARK: - TableView Methods

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(movie)
        return cell
    }
}

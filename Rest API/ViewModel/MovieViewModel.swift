//
//  MovieViewModel.swift
//  Rest API
//
//  Created by DA MAC M1 157 on 2023/06/18.
//

import Foundation

class MovieViewModel {
    
    private var webService = Webservice()
    private var popularMovies = [Movie]()
    
    func fetchPopularMovies(completion: @escaping () -> ()) {
        
        webService.getPopularMovies { [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies ?? []
                completion()
            case .failure(let error):
                print("Error processing JSONData: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(_ section: Int)-> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}

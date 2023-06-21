//
//  Webservice.swift
//  Rest API
//
//  Created by DA MAC M1 157 on 2023/06/18.
//

import Foundation


class Webservice {
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
   
        
        let popularMovies = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        
        guard let url = URL(string: popularMovies) else { return }
        
        
        //Create URLSession - work on the background
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
     
            // Handle Error
            
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }
            print("Response status cose: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Movies.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error{
                completion(.failure(error))
            }
        }
        dataTask?.resume()
        
    }
}



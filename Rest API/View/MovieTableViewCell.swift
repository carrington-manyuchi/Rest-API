//  MovieTableViewCell.swift
//  Rest API
//  Created by DA MAC M1 157 on 2023/06/18.

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString = ""
    
    // Setup movies values
    
    func setCellWithValueOf(_ movie: Movie){
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        self.movieYear.text = convertDateFormater(releaseDate)
        self.movieOverview.text = overview
        
        guard let rate = rating else { return }
        self.movieRate.text = String(rate)
    
        guard let posterString = poster else { return }
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
         guard let posterImageUrl = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        //Before we download the image, we clear out the old one
        self.moviePoster.image = nil
        getImageDataFrom(url: posterImageUrl)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Data TAsk error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Image data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}

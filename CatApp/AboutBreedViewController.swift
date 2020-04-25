//
//  AboutBreedViewController.swift
//  CatApp
//
//  Created by Алексей Павлюк on 24.04.2020.
//  Copyright © 2020 CocoaOneLove. All rights reserved.
//

import UIKit

class AboutBreedViewController: UIViewController {

    var selectedBreedName: String?
    var selectedBreedID: String?
    var selectedbreedDescr: String?
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageBreed: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newImagebutton: UIButton!
    
    @IBAction func newImg(_ sender: UIButton) {
        imageBreed.isHidden = true
        fetchBreedImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedBreedName
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        newImagebutton.layer.cornerRadius = 17

        fetchBreedImage()
        descriptionLabel.text = selectedbreedDescr
        
    }
    
    func fetchBreedImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
            
    let headers = ["x-api-key": "b447e7b7-c6b2-4128-b0a9-1c67f5f81539"]

    let request = NSMutableURLRequest(url: NSURL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(selectedBreedID!)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let imgURL = try decoder.decode([BreedImage].self, from: data)
                    guard let url = URL(string: imgURL[0].url!) else {return}
                    DispatchQueue.main.async {
                        let img = try? Data(contentsOf: url)
                        self.activityIndicator.stopAnimating()
                        self.imageBreed.isHidden = false
                        self.imageBreed.image = UIImage(data: img!)
                    }
                } catch let error {
                    print("Error serialization json", error)
                }
                
            }.resume()
        }
    
    
    


}

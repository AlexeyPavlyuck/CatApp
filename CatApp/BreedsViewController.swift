//
//  BreedsViewController.swift
//  CatApp
//
//  Created by Алексей Павлюк on 23.04.2020.
//  Copyright © 2020 CocoaOneLove. All rights reserved.
//

import UIKit
class BreedsTableViewController: UITableViewController {
    
    @IBOutlet weak var activIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBreedsData()
    }
    
    private var breeds = [Breeds]()
    private var breedName: String?
    private var breedID: String?
    private var breedDescr: String?
    private var breedWeight: String?
    private var breedTemperament: String?
    private var breedOrigin: String?
    private var breedLifeSpan: String?
    
    func fetchBreedsData() {
            
    let headers = ["x-api-key": "b447e7b7-c6b2-4128-b0a9-1c67f5f81539"]

    let request = NSMutableURLRequest(url: NSURL(string: "https://api.thecatapi.com/v1/breeds")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    self.breeds = try decoder.decode([Breeds].self, from: data)

                    DispatchQueue.main.async {
                        self.activIndicator.stopAnimating()
                        self.activIndicator.isHidden = true
                        self.activIndicator.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                        self.tableView.reloadData()
                        
                        
                    }
                } catch let error {
                    print("Error serialization json", error)
                }
                
            }.resume()
        }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell") as! BreedCell
            let breed = breeds[indexPath.row]
            cell.breedLabel.text = breed.name
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

     let breed = breeds[indexPath.row]
     breedName = breed.name
     breedID = breed.id
     breedDescr = breed.description
     breedWeight = breed.weight.metric
     breedTemperament = breed.temperament
     breedOrigin = breed.origin
     breedLifeSpan = breed.life_span
    
     performSegue(withIdentifier: "AboutSegue", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    let aboutBreedViewController = segue.destination as! AboutBreedViewController
        aboutBreedViewController.selectedBreedName = breedName
        aboutBreedViewController.selectedBreedID = breedID
        aboutBreedViewController.selectedbreedDescr = breedDescr
        aboutBreedViewController.selectedBreedWeight = breedWeight
        aboutBreedViewController.selectedBreedTemperament = breedTemperament
        aboutBreedViewController.selectedBreedOrigin = breedOrigin
        aboutBreedViewController.selectedBreedLifeSpan = breedLifeSpan
    }
    
}

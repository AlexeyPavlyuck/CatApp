//
//  BreedsViewController.swift
//  CatApp
//
//  Created by Алексей Павлюк on 23.04.2020.
//  Copyright © 2020 CocoaOneLove. All rights reserved.
//

import UIKit

class BreedsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private var breeds = [Breeds]()
    private var breedName: String?
    
    func fetchData() {
            
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
    
//   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//     let breed = breeds[indexPath.row]
//     breedName = breed.name
//    }
}

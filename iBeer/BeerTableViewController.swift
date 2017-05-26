//
//  BeerTableViewController.swift
//  iBeer
//
//  Created by Marcelo Pavani on 24/05/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BeerTableViewController: UITableViewController {
    
    var arrayBeers: NSArray = []
    var indicator:ProgressIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      indicator = ProgressIndicator(inview: self.view, messsage: "Aguarde.....")
        self.view.addSubview(indicator!)
    
        getBeers()
    }
    
    
    func getBeers()
    {
        
        indicator!.start()
        
        let urlString = "https://api.punkapi.com/v2/beers"
        
        Alamofire.request(urlString, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    if let result = response.result.value {
                        
                        print("erro: \(result)")
                        self.indicator!.stop()
                    }
                    
                default:
                    
                    let Result = response.result.value
                    self.arrayBeers = (Result as? NSArray)!
                    self.tableView.reloadData()
                    
                    self.indicator!.stop()
                
                    break
                    
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayBeers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell

        cell.labelNome.text = (self.arrayBeers[indexPath.row] as AnyObject).value(forKey: "name") as? String
        let abv: Double = (self.arrayBeers[indexPath.row] as AnyObject).value(forKey: "abv") as! Double
        cell.labelAbv.text =  String(abv)
        cell.imgBeer.downloadedFrom(link: ((self.arrayBeers[indexPath.row] as AnyObject).value(forKey: "image_url") as? String)!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        var beerSelected: Array<Any>
        
        if segue.identifier == "detailBeer"{
        
            if let x = self.tableView.indexPathForSelectedRow {
                beerSelected = [self.arrayBeers[x.row]]
                let vc = segue.destination as! BeerDetailUIViewController
                vc.arryBeerDetail = beerSelected as NSArray
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

//
//  BeerDetailUIViewController.swift
//  iBeer
//
//  Created by Marcelo Pavani on 25/05/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

class BeerDetailUIViewController: UIViewController {

    @IBOutlet weak var labelTagLine: UILabel!
    @IBOutlet weak var imgBeer: UIImageView!
    @IBOutlet weak var labelAbv: UILabel!
    @IBOutlet weak var labelIbu: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var arryBeerDetail: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadScreen()
    }
    
    
    func loadScreen () {
        
        
        self.title =  (self.arryBeerDetail[0] as AnyObject).value(forKey: "name") as? String
        let img: String = ((self.arryBeerDetail[0] as AnyObject).value(forKey: "image_url") as? String)!
        self.imgBeer.downloadedFrom(link: img)
        self.labelTagLine.text = (self.arryBeerDetail[0] as AnyObject).value(forKey: "tagline") as? String
        let abv: Double = (self.arryBeerDetail[0] as AnyObject).value(forKey: "abv") as! Double
        self.labelAbv.text = String(abv)
        let ibu: Double = (self.arryBeerDetail[0] as AnyObject).value(forKey: "ibu") as! Double
        self.labelIbu.text = String(ibu)
        self.labelDescription.text = (self.arryBeerDetail[0] as AnyObject).value(forKey: "description") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

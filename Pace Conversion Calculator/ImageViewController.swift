//
//  ImageViewController.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 9/10/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var mapImage = UIImage()
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = mapImage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

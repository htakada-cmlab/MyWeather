//
//  DetailViewController.swift
//  MyWeather
//
//  Created by Hideyuki Takada on 2017/11/06.
//  Copyright © 2017年 Hideyuki Takada. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var detailItem: [String: String]!
   
/*
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard detailItem != nil else { return }

        let urlString = "https://openweathermap.org/img/w/" + detailItem!["icon"]! + ".png"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
            }
        }

        label.numberOfLines = 2
        label.text = "Weather: " + detailItem!["weather"]! + "\n" + "Temperature: " + detailItem!["temp"]! + "℃"
        title = detailItem!["city"]
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

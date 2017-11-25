//
//  ViewController.swift
//  MyWeather
//
//  Created by Hideyuki Takada on 2017/11/06.
//  Copyright © 2017年 Hideyuki Takada. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var cities: [String] = ["Kyoto,JP", "Tokyo,JP", "Sapporo-shi,JP", "Honolulu,US"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Weather", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=" + cities[indexPath.row] + "&appid=d01ed74f13d285ba9f785fb49335bf3a"
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    print(json)
                    
                    let weather = json["weather"][0]["description"].stringValue
                    let icon = json["weather"][0]["icon"].stringValue
                    let temp = Int(json["main"]["temp"].floatValue - 273.15)
                    vc.detailItem = ["weather": weather, "icon": icon, "temp": "\(temp)"]
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  ViewController.swift
//  MyWeather
//
//  Created by Hideyuki Takada on 2017/11/06.
//  Copyright © 2017年 Hideyuki Takada. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var addButton: UIBarButtonItem!
    var cities: [String] = UserDefaults.standard.object(forKey:"SavedCities") as? [String] ?? ["Kyoto,JP", "Tokyo,JP", "Sapporo-shi,JP", "Honolulu,US"]

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
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=" + cities[indexPath.row] + "&appid=d01ed74f13d285ba9f785fb49335bf3a&units=metric"
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    print(json)
                    
                    let city = json["name"].stringValue
                    let weather = json["weather"][0]["description"].stringValue
                    let icon = json["weather"][0]["icon"].stringValue
                    let temp = Int(json["main"]["temp"].floatValue)
                    vc.detailItem = ["city": city, "weather": weather, "icon": icon, "temp": "\(temp)"]
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            UserDefaults.standard.set(self.cities, forKey: "SavedCities")
           tableView.reloadData()
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a city", message: "Enter a city name with a country code", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                    let name = alertController.textFields?[0].text
                    self.cities.append(name!)
                    self.tableView.reloadData()
                    UserDefaults.standard.set(self.cities, forKey: "SavedCities")
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "City,Country"
        }

        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


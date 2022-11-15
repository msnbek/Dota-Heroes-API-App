//
//  ViewController.swift
//  Dota Heroes API App
//
//  Created by Mahmut Şenbek on 15.11.2022.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heroes = [HeroStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
    }
}
//MARK: - TableView
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let hero = heroes[indexPath.row]
        cell.textLabel?.text = hero.localized_name.capitalized
        cell.detailTextLabel?.text = hero.primary_attr.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSecondVC", sender: self)
    }
    
}
//MARK: - Segue
extension  ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroDetailsViewController {
            destination.heroesTwo = heroes[tableView.indexPathForSelectedRow!.row]
        }
    }

}

//MARK: - Gettin data from JSON
extension ViewController {
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStruct].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
    
}

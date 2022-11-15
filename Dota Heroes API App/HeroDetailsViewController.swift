//
//  HeroDetailsViewController.swift
//  Dota Heroes API App
//
//  Created by Mahmut Şenbek on 15.11.2022.
//

//For gettin image for ethernet.
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

import UIKit

class HeroDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var heroesTwo : HeroStruct?
    @IBOutlet weak var legs: UILabel!
    @IBOutlet weak var attackType: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        nameLabel.text = "Name: \((heroesTwo?.localized_name.capitalized)!)"
        attackType.text = "Attribute: \((heroesTwo?.primary_attr.capitalized)!)"
        titleLabel.text = "Attack Type: \((heroesTwo?.attack_type.capitalized)!)"
        legs.text = "Legs:\((heroesTwo?.legs)!)"
        getImage()
    }
    func getImage() {
        let imgUrl = "https://api.opendota.com" + (heroesTwo?.img)!
        print(imgUrl)
        imageView.downloaded(from: imgUrl)
    }
  

}



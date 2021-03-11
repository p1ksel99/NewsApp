//
//  MyTableViewCell.swift
//  NewsApp
//
//  Created by Rostyslav Shmorhun on 11.02.2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifir = "MyTableViewCell"
    

    static func nib() -> UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!

    func configure(author: String?, title: String?, image: String?) {
        authorLabel.text = author
        titleLabel.text = title
        if image != nil{
            urlImage.downloaded(from: URL(string: image!)!)
        }else{
            urlImage.image = nil
        }
    
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}





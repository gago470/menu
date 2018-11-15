//
//  Realm+extention.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/15/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
}

extension RealmSwift.List {
    
    func toArray<T: Any>() -> [T] {
        return self.filter{ $0 is T }.map{ $0 as! T }
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

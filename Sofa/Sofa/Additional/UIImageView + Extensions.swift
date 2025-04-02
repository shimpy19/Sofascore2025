//
//  UIImageView + Extensions.swift
//  Sofa
//
//  Created by Akademija on 18.03.2025..
//

import Foundation
import UIKit

 extension UIImageView {
    func loadImage(from url: URL) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }
        }
    }
     
    func setImage(with urlString: String?) {
         guard let urlString = urlString, let url = URL(string: urlString) else {
             self.image = nil
             return
         }
         self.loadImage(from: url)
     }

}

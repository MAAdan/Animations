//
//  OptionsViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

enum Options {
    case bear
    case cat
    case dog
    case fox
    case panda
    case racoon
    
    var description: String {
        switch self {
        case .bear:
            return "bear"
        case .cat:
            return "cat"
        case .dog:
            return "dog"
        case .fox:
            return "fox"
        case .panda:
            return "panda"
        case .racoon:
            return "racoon"
        }
    }
}

class OptionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OptionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
        return cell
        
    }
}

extension OptionsViewController: UICollectionViewDelegate {
    
}

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    
}

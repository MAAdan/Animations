//
//  OptionsViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

protocol OptionsDelegate: class {
    func didSelect(option: Options)
    func didSelect(imageView: UIImageView?)
}

enum Options: Int, EnumSequence {
    typealias T = Options
    
    case bear, cat, dog, fox, panda, racoon
    
    var description: String {
        switch self {
        case .bear: return "bear"
        case .cat: return "cat"
        case .dog: return "dog"
        case .fox: return "fox"
        case .panda: return "panda"
        case .racoon: return "racoon"
        }
    }
    
    var color: UIColor {
        switch self {
        case .bear: return UIColor(red: 238.0/255.0, green: 166.0/255.0, blue: 4.0/255.0, alpha: 1.0)
        case .cat: return UIColor(red: 214.0/255.0, green: 76.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        case .dog: return UIColor(red: 59.0/255.0, green: 156.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        case .fox: return UIColor(red: 38.0/255.0, green: 81.0/255.0, blue: 115.0/255.0, alpha: 1.0)
        case .panda: return UIColor(red: 89.0/255.0, green: 152.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        case .racoon: return UIColor(red: 0.0, green: 165.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        }
    }
    
    var scientificName: String {
        switch self {
        case .bear: return "Ursus horribilis"
        case .cat: return "Felis catus"
        case .dog: return "Canis lupus"
        case .fox: return "Vulpes vulpes"
        case .panda: return "Ailuropoda melanoleuca"
        case .racoon: return "Procyon"
        }
    }
}

class OptionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let options = Array(Options.all())
    
    weak var optionsDelegate: OptionsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OptionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
        let index = indexPath.row % options.count
        cell.customImageView.image = UIImage(named: options[index].description)
        
        return cell
        
    }
}

extension OptionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedItem = collectionView.cellForItem(at: indexPath) as? OptionCollectionViewCell {
            optionsDelegate?.didSelect(imageView: selectedItem.customImageView)
        }
        
        let index = indexPath.row % options.count
        optionsDelegate?.didSelect(option: options[index])
    }
}

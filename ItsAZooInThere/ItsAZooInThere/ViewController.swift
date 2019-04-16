//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Landon on Apr 11, 2019.
//  Copyright © 2019 Landon Mitchell. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var speciesLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var animals = [Animal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 1125, height: 500)
        scrollView.delegate = self
    
        
        let lion = Animal(name: "Lambert", species: "Lion", age: 33, image: UIImage(named: "lion")!, soundPath: "lionSound" )
        
        let flamingo = Animal(name: "Phil", species: "Flamingo", age: 42, image: UIImage(named: "flamingo")!, soundPath: "flamingoSound" )
        
        let rhino = Animal(name: "Ryan", species: "Rhinoceros", age: 22, image: UIImage(named: "rhino")!, soundPath: "rhinoSound" )
        
        animals.append(lion)
        animals.append(flamingo)
        animals.append(rhino)
        
        animals.shuffle()
        
        speciesLabel.text = animals[0].species
        
        addButtons()
        addImageViews()
    }
    
    func addButtons() {
        var xPos = 0
        let yPos = 375
        for (index, animal) in animals.enumerated() {
            let button = UIButton(type: .system)
            
            // consulted: stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically/40139569#40139569
            
            button.frame = CGRect(x: xPos, y: yPos, width: 375, height: 100)
            button.setTitle(animal.name, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            scrollView.addSubview(button)
            
            xPos += 375
        }
    }
    
    func addImageViews() {
        var xPos = 0
        let yPos = 0
        for animal in animals {
            let imageView = UIImageView(image: animal.image)
            imageView.frame = CGRect(x: xPos, y: yPos, width: 375, height: 375)

            scrollView.addSubview(imageView)
            
            xPos += 375
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let index = sender.tag
        
        let alertController = UIAlertController(title: animals[index].name, message: "Species: \(animals[index].species)\nAge: \(animals[index].age)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
        /* Referenced https://www.ioscreator.com/tutorials/play-music-avaudioplayer-ios-tutorial */
        
        let audioPath = Bundle.main.path(forResource: animals[index].soundPath, ofType: "mp3")!
        let url = URL(fileURLWithPath: audioPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("Audio File Not Found")
        }
        
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    let index = Int(((scrollView.contentOffset.x + 187.5) / 375))
    speciesLabel.text = animals[index].species
        
    // trig help provided by friend Clare
    let z = (scrollView.contentOffset.x/375) * (2 * CGFloat.pi)
    speciesLabel.alpha = (0.5 * cos(z)) + 0.5

        
    }
    
}

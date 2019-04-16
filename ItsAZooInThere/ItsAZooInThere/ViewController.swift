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
    
    // Mark Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var speciesLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var animals = [Animal]()
    
    // Mark Lifecycle
    
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
    
    // Mark Button and View Creation
    
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
    
    // Mark Actions
    
    @objc func buttonTapped(sender: UIButton) {
        let index = sender.tag
        
        let alertController = UIAlertController(title: animals[index].name, message: "Species: \(animals[index].species)\nAge: \(animals[index].age)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
        /* Referenced https://www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer */
        
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

// Mark Scroll View Delegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    let index = Int(((scrollView.contentOffset.x + 187.5) / 375))
    speciesLabel.text = animals[index].species
        
    // trig refresher/help provided by friend Clare
    // (I had a working version previously, but it was not pretty)
        
    let z = (scrollView.contentOffset.x/375) * (2 * CGFloat.pi)
    speciesLabel.alpha = (0.5 * cos(z)) + 0.5

    }
}

//
//  Animal.swift
//  ItsAZooInThere
//
//  Created by Landon on Apr 11, 2019.
//  Copyright © 2019 Landon Mitchell. All rights reserved.
//

import Foundation
import UIKit

class Animal {
    
    //MARK: Properties
    
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String) {
        
        // Initialize stored properties.
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
}

extension Animal: CustomStringConvertible {
    var description: String {
        return "Animal: name = (\(self.name), species = \(self.species), age = \(self.age))"
    }
}

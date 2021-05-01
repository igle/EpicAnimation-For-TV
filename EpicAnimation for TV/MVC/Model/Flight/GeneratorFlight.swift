//
//  GeneratorFlight.swift
//  EpicAnimation for TV
//
//  Created by Jules Dubois on 01/05/2021.
//

import Foundation
import UIKit

struct GeneratorFlight {
    
    private var frame: CGRect!
    private var imageValue: UIImage!
    private var numberFlightValue: Int!
    
    private var numberFlight: Int {
        get {
            return numberFlightValue == 0 ? Int.random(in: 20..<250) : numberFlightValue
        }
        set {
            numberFlightValue = newValue
        }
    }
    
    
    // MARK: - Initialisation
    public init(frame: CGRect, imageValueCustom: UIImage = #imageLiteral(resourceName: "epic"), numberFlightCustom: Int = 0) {
        self.frame = frame
        self.imageValue = imageValueCustom
        self.numberFlight = numberFlightCustom
    }
    
    
    // MARK: - Generation des flights
    public func generate(belowLayer: CALayer? = nil, toView: UIView) {
    
        // Génération des flights
        for _ in 0..<numberFlight {
            // Initialisation du CALayer
            let flightEpic = CALayer()
            flightEpic.contents = imageValue.cgImage
            flightEpic.frame = CGRect(x: -50.0, y: 0.0, width: 100, height: 100)
            flightEpic.name = "layerFlight"
            
            // Ajout du CALayer
            toView.layer.insertSublayer(flightEpic, below: belowLayer)
            
            // Ajout du flight
            let flight = Flight(parentFrame: frame)
            let newFlight = flight.flight()
            flightEpic.add(newFlight, forKey: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + newFlight.duration, execute: {
                flightEpic.removeFromSuperlayer()
            })
        }
    }
}

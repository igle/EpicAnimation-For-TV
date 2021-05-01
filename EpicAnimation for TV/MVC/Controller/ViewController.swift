//
//  ViewController.swift
//  EpicAnimation for TV
//
//  Created by Jules Dubois on 01/05/2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changement de la couleur de fond
        view.backgroundColor = UIColor(rgb: 0xfff200)
        
        // Ajout de la détection de mouvement
        self.becomeFirstResponder()
    }
    
    
    // MARK: - canBecomeFirstResponder
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // MARK: - motionEnded
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            startGenerateFlights()
        }
    }
    
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        delayGenerate(firstTime: true)
    }
    
    
    //MARK: - startGenerateFlights
    func delayGenerate(firstTime: Bool = false) {
        if !firstTime {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                let numberLayerFlightInView = self.view.layer.sublayers!.filter({ $0.name == "layerFlight"}).count
                if numberLayerFlightInView <= 200 {
                    self.startGenerateFlights()
                }
                self.delayGenerate()
            })
        } else {
            startGenerateFlights()
            delayGenerate()
        }
    }
    
    func startGenerateFlights() {
        // Génération des flights
        let generator = GeneratorFlight(frame: view.frame)
        generator.generate(toView: view)
    }
}

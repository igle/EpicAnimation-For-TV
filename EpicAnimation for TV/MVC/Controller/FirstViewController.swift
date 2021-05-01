//
//  FirstViewController.swift
//  EpicAnimation for TV
//
//  Created by Jules Dubois on 01/05/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    lazy var imageFlash : UIImageView = {
        let image : UIImageView = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "flash")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    // MARK: - ViwDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajouter l'image
        view.addSubview(imageFlash)
        
        // Ajout des constraint
        NSLayoutConstraint.activate([
            imageFlash.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageFlash.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageFlash.widthAnchor.constraint(equalToConstant: 256),
            imageFlash.heightAnchor.constraint(equalTo: imageFlash.widthAnchor),
        ])
        
        // Activation de l'animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animateSplashView()
        }
    }
    
    
    // MARK: - Animation de l'image et perform
    func animateSplashView() {
        
        // Modification de la contrainte width (par relation de la contraint height aussi)
        let imageFlashWidth = self.imageFlash.constraints.filter({ $0.firstAttribute == .width && $0.firstItem === self.imageFlash }).last!
        imageFlashWidth.constant = 22000
        
        // Animation de l'agrandissement de l'image
        UIView.animate(withDuration: 1.2) {
            self.view.layoutIfNeeded()
        }
        
        // Animation pour la 5 vers ViewController
        UIView.animate(withDuration: 0.6, animations: {
            self.view.backgroundColor = UIColor(rgb: 0xfff200)
        }) { (done) in
            if done {
                let vc = ViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

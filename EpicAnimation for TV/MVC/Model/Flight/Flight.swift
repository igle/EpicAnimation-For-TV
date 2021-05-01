//
//  Flight.swift
//  EpicAnimation for TV
//
//  Created by Jules Dubois on 01/05/2021.
//

import Foundation
import UIKit

struct Flight {
    
    public var parentFrame: CGRect
    
    public func flight() -> CAKeyframeAnimation {
        let flight = CAKeyframeAnimation(keyPath: "position")
        
        flight.duration = CFTimeInterval.random(in: 30.0..<50)

        let values = flightValues()
        flight.values = values.map { NSValue(cgPoint: $0) }

        return flight
    }
    
    private func flightValues() -> [CGPoint] {
        var values : [CGPoint] = []
        var element = 0
        let randomElement = Int.random(in: 3..<10)
        
        repeat {
            let vX : CGFloat = values.count > 0 ? values[element-1].x : CGFloat(Int.random(in: 0..<2))*16
            values.append( CGPoint(x: valueX(old: vX, num: element, last: element == randomElement-1), y: randomY()) )
            
            element += 1
        } while element < randomElement
        
        return values
    }
    
    private func randomY() -> CGFloat {
        let randomY = Int.random(in: 0..<3)
        let diff = parentFrame.midY - parentFrame.minY
        
        switch randomY {
        case 0:
            // MinY
            return parentFrame.minY + CGFloat.random(in: -50.0..<diff)
        case 1:
            // MidY
            return parentFrame.midY + CGFloat.random(in: -diff..<diff)
        case 2:
            // MaxY
            return parentFrame.maxY + CGFloat.random(in: -diff..<diff)
    
        default:
            // Never executed
            return parentFrame.minY
        }
    }
    
    private func valueX(old: CGFloat, num: Int, last: Bool) -> CGFloat {
        switch num {
        case 0:
            let margin = CGFloat.random(in: 20..<100)
            return old == 16.0 ? parentFrame.maxX+margin : parentFrame.minX-margin
        default:
            if last {
                return (old < 100.0) ? parentFrame.maxX+40 : parentFrame.minX-40
            }
            return (old < 100.0) ? parentFrame.maxX-16 : parentFrame.minX+16
        }
    }
    
}

//
//  CustomCellAnimations.swift
//  Note
//
//  Created by Евгений on 14.12.2020.
//

import UIKit

extension CustomCell {
    
    //MARK: - Animation cell element
    func isDoneAnimation(in cell: UIView) {
        markAnimation()
        headAnimation()
        bodyAnimation()
    }
    
    
    //MARK: - Mark
    func markAnimation() {
        
        UIView.animate(withDuration: 0.7, delay: 0.3,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1,
                       options: .curveEaseIn ) { [self] in
            
            mark.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.8,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1,
                       options: .curveEaseIn ){ [self] in
            
            mark.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            mark.alpha = 0
        }
    }
    
    
    //MARK: - Head
    func headAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.2,
                       options: .curveEaseIn ) { [self] in
            headLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.7,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0,
                       options: .curveEaseIn ){ [self] in
            headLabel.transform = .identity
        }
    }
    
    
    //MARK: - Body
    func bodyAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.3,
                       options: .curveEaseIn ) { [self] in
            noteLabel.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.8,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0,
                       options: .curveEaseIn ){ [self] in
            noteLabel.transform = .identity
        }
    }
    
}

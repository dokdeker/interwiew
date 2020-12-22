//
//  CustomCell.swift
//  Table&Collection
//
//  Created by Евгений on 09.12.2020.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var mark: UIView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var headYCenterConst: NSLayoutConstraint!
    
    
    //MARK: - SetUp cell
    func setup(headText: String,
               noteText: String,
               markColor: String,
               isDone: Bool,
               isFold: Bool,
               cell:UITableViewCell) {
        
        headLabel.text = headText
        noteLabel.text = noteText
        
        //MARK: - MarkColor
        switch markColor {
        
        case ColorMark.red:
            mark.backgroundColor = .systemRed
            
        case ColorMark.orange:
            mark.backgroundColor = .systemOrange
            
        case ColorMark.gray:
            mark.backgroundColor = .systemGray
            
        default:
            break
        }
        
        
//        
//        if noteLabel.text?.isEmpty == true {
//            headYCenterConst.constant = 0
//        } else {
//            headYCenterConst.constant = -10
//        }
        
        
        //MARK: - Check cell note IsDone
        if isDone == true {
            
            //mark.backgroundColor = .systemGreen
            UIView.animate(withDuration: 1.4, delay: 0,
                           usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                           options: .curveEaseIn ) { [self] in
                
//                switch markColor {
//                case ColorMark.red:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemRed)
//
//                case ColorMark.orange:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemOrange)
//
//                case ColorMark.gray:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemGray)
//
//                default:
//                    break
//                }
                
                
                checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemGreen)
                
                checkMark.alpha = 1
                checkMark.transform = .identity
                
                headLabel.alpha = 0.5
                noteLabel.alpha = 0.4
                
                mark.alpha = 0
            }
            
        } else {
            
            UIView.animate(withDuration: 1.4, delay: 0,
                           usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                           options: .curveEaseIn ) { [self] in
                
                checkMark.alpha = 0
                checkMark.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                
                headLabel.alpha = 0.85
                noteLabel.alpha = 0.55
                
                
                mark.transform = .identity
                mark.alpha = 1
            }
        }
        
        //MARK: - Check cell noteIsFold
        if isFold == false {
            noteLabel.numberOfLines = 1
        } else {
            
            //print(noteLabel.calculateMaxLines())
            noteLabel.numberOfLines = noteLabel.calculateMaxLines()
            
        }
        
    }

}






//MARK: - Count amount line In Label
extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}


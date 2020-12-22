//
//  patternNote.swift
//  Note
//
//  Created by Евгений on 11.12.2020.
//
import UIKit

var patternNoteView = String()

//MARK: - Load Pattern Note
extension NoteViewController {
    func loadPatternNote() {
        
        switch patternNoteView {
        
        case StatusNote.create:
            
            setColor(pressed: greyMarkButton, set: ColorMark.gray)
            isModalInPresentation = true
            pointMarkActiveStatus = false
            
            textView.isEditable = true
            headTextFieldOutlet.isEnabled = true
            
            readyButtonOutlet.isHidden = true
            editbuttonOutlet.isHidden = true
            
            stackViewMarks.isHidden = false
            headViewLabel.isHidden = false
            
            createButtonOutlet.isHidden = false
            canselButtonOutlet.isHidden = false
            
            slider.alpha = 0
            
        case StatusNote.edit:
            
            setColor(pressed: greyMarkButton, set: NoteData.colorMark[usedIndexCell])
            isModalInPresentation = true
            
            pointMarkActiveStatus = false
            
            readyButtonOutlet.isHidden = false
            editbuttonOutlet.isHidden = true
            
            stackViewMarks.isHidden = false
            headViewLabel.isHidden = false
            
            createButtonOutlet.isHidden = true
            canselButtonOutlet.isHidden = true
            
            textView.isEditable = true
            textView.becomeFirstResponder()
            headTextFieldOutlet.isEnabled = true
            
            
            
            
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn ){ [self] in
                headLabelTopConst.constant = -30
                slider.alpha = 0
                view.layoutIfNeeded()
            }
            
            
            
            
            
        case StatusNote.read:
            setColor(pressed: greyMarkButton, set: NoteData.colorMark[usedIndexCell])
            isModalInPresentation = false
            
            editbuttonOutlet.isHidden = false
            
            pointMarkActiveStatus = false
            
            headViewLabel.isHidden = true
            
            createButtonOutlet.isHidden = true
            canselButtonOutlet.isHidden = true
            
            textView.text = Note.body
            headTextFieldOutlet.text = Note.head
            
            
            textView.isEditable = false
            headTextFieldOutlet.isEnabled = false
            
            
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: { [self] in
                headLabelTopConst.constant = -80
                slider.alpha = 1
                view.layoutIfNeeded()
            }) { [self] (completed) in
                readyButtonOutlet.isHidden = true
                stackViewMarks.isHidden = true
            }
        default:
            
            break
        }
    }
}

//
//  File.swift
//  Note
//
//  Created by Евгений on 10.12.2020.
//

import UIKit

struct Note {
    static var head = String()
    static var body = String()
    static var colorMark = String()
    static var amountLine = Int()
}

enum StatusNote {
    static var create = "create"
    static var edit = "edit"
    static var read = "read"
}





class NoteViewController: UIViewController {
    

    
    var pointMarkActiveStatus: Bool = false
    weak var updateDelegate: MethodDelegate?
    
    // MARK: - OUTLETS
    @IBOutlet weak var stackViewMarks: UIStackView!
    @IBOutlet weak var headViewLabel: UILabel!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var createButtonOutlet: UIButton!
    @IBOutlet weak var readyButtonOutlet: UIButton!
    @IBOutlet weak var editbuttonOutlet: UIButton!
    @IBOutlet weak var canselButtonOutlet: UIButton!
    @IBOutlet weak var headTextFieldOutlet: UITextField!
    @IBOutlet weak var headLabelTopConst: NSLayoutConstraint!
    @IBOutlet weak var markNumberOutlet: UIButton!
    @IBOutlet weak var markPointOutlet: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        loadPatternNote()
        checkEmptyNote()
        checkPlaceholderNote()
        createAdaptiveAreaSizeTextView()
        
        
    }
    
    
    // MARK: - Action Button
    @IBAction func createButton(_ sender: Any) {
        if textView.text == "Введите вашу заметку" {
            textView.text = ""
            textView.alpha = 0.7
            Note.body  = textView.text!
        } else {
            Note.body  = textView.text!
        }
        
        checkEmptyHead()
        
        NoteData.head.insert(Note.head, at: 0)
        NoteData.body.insert(Note.body, at: 0)
        NoteData.colorMark.insert(Note.colorMark, at: 0)
        NoteData.isDone.insert(false, at: 0)
        NoteData.isFold.insert(false, at: 0)
        NoteData.amountLine.insert(textView.calcAmountOfLines(), at: 0)
        self.dismiss(animated: true)
        
        updateDelegate?.reloadTable()
        
        if Note.body.isEmpty == false {
            
        }
    }
    
    
    @IBAction func readyButton(_ sender: Any) {
        if textView.text == "Введите вашу заметку" {
            textView.text = ""
            textView.alpha = 0.7
        }

        NoteData.amountLine.remove(at: usedIndexCell)
        NoteData.amountLine.insert(Note.amountLine, at: usedIndexCell)
        
        rewriteEditedCell()
        pointMark(isActive: false)
        patternNoteView = StatusNote.read
        loadPatternNote()
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        
        patternNoteView = StatusNote.edit
        loadPatternNote()
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func markNumberButton(_ sender: Any) {
        
    }
    
    
    @IBAction func markPointButton(_ sender: UIButton) {
        
        if pointMarkActiveStatus == false {
            pointMark(isActive: true)
        } else if pointMarkActiveStatus == true {
            pointMark(isActive: false)
        }
        
    }
    
    //MARK: - Edit note: pointMark
    func pointMark(isActive: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                       options: .curveEaseIn ) { [self] in
            if isActive == true {
                
                
                if textView.text.contains("Введите вашу заметку") || textView.text.isEmpty == true  {
                    textView.alpha = 0.7
                    textView.text = "    ●    "
                    
                    textView.becomeFirstResponder()
                    
                } else {
                    textView.text += "\n\n    ●    "
                    textView.becomeFirstResponder()
                }
                
                
                
                markPointOutlet.backgroundColor = .systemBlue
                markPointOutlet.layer.cornerRadius = 4
                
                markPointOutlet.setImage(UIImage(systemName: "list.bullet",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16)),for: .normal)
                
                markPointOutlet.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                markPointOutlet.tintColor = .white
                pointMarkActiveStatus = true
                
                UIView.animate(withDuration: 0.4, delay: 0.4,
                               usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                               options: .curveEaseIn ) { [self] in
                    markPointOutlet.transform = .identity
                }
                
            } else if isActive == false {
                markPointOutlet.backgroundColor = .none
                markPointOutlet.setImage(UIImage(systemName: "list.bullet", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
                markPointOutlet.transform = .identity
                markPointOutlet.tintColor = .systemBlue
                
                pointMarkActiveStatus = false
            }
        }
    }
    
    
    //MARK: - Rewrite Edited Cell
    func rewriteEditedCell() {
        Note.body = textView.text
        Note.head = headTextFieldOutlet.text!
        
        if NoteData.body.count >= 1 && NoteData.head.count >= 1 && NoteData.colorMark.count >= 1 {
            
            NoteData.body.remove(at: usedIndexCell)
            NoteData.head.remove(at: usedIndexCell)
            NoteData.colorMark.remove(at: usedIndexCell)
            NoteData.amountLine.remove(at: usedIndexCell)
            
            NoteData.body.insert(Note.body, at: usedIndexCell)
            NoteData.head.insert(Note.head, at: usedIndexCell)
            NoteData.colorMark.insert(Note.colorMark, at: usedIndexCell)
            NoteData.amountLine.insert(textView.calcAmountOfLines(), at: usedIndexCell)
            updateDelegate?.reloadTable()
        }
    }
    
    
    //MARK: - COLORMARK
    @IBOutlet weak var orangeMarkButton: UIButton!
    @IBOutlet weak var redMarkButton: UIButton!
    @IBOutlet weak var greyMarkButton: UIButton!
    
    @IBAction func tappedMark(_ sender: Any) {
        let mark = sender as! UIButton
        
        if mark.restorationIdentifier == "red" {
            setColor(pressed: mark, set: ColorMark.red)
        }
        if mark.restorationIdentifier == "orange" {
            setColor(pressed: mark, set: ColorMark.orange)
        }
        if mark.restorationIdentifier == "gray" {
            setColor(pressed: mark, set: ColorMark.gray)
        }
    }
    
    
    func setColor(pressed mark: UIButton, set color: String) {
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4,
                       options: .curveEaseIn ) { [self] in
            redMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            orangeMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            greyMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            
            redMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            orangeMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            greyMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            
            switch color {
            
            case ColorMark.red:
                headTextFieldOutlet.textColor = .systemRed
                redMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                redMarkButton.transform = .identity
                
            case ColorMark.orange:
                headTextFieldOutlet.textColor = .systemOrange
                orangeMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                orangeMarkButton.transform = .identity
                
            case ColorMark.gray:
                headTextFieldOutlet.textColor = .gray
                greyMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                greyMarkButton.transform = .identity
                
            default:
                break
            }
            
        }
        
        Note.colorMark = color
    }
    
    
    
}


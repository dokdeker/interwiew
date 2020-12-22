//
//  TodayViewController.swift
//  Note
//
//  Created by Евгений on 10.12.2020.
//

import UIKit

protocol MethodDelegate: class {
    func reloadTable()
    func fadeOutBlackBG()
}


struct NoteData {
    static var head: [String] = []
    static var body: [String] = []
    static var colorMark: [String] = []
    static var isDone: [Bool] = []
    static var isFold: [Bool] = []
}


struct ColorMark {
    static var red = "red"
    static var orange = "orange"
    static var gray = "gray"
    static var green = "green"
}


class TodayViewController: UIViewController {
    
    let darkView = UIView()
    let userDefaults = UserDefaults.standard
    let createNoteViewController = NoteViewController()
    var headerStatus:String = Header.free
    var currentLitDate = String()
    
    private let noteViewId = "noteViewId"
    private let sortViewId = "sortViewId"
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var todayTabBar: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var createNoteButtonOutlet: UIButton!
    @IBOutlet weak var editTableButtonOutlet: UIButton!
    
    @IBOutlet weak var sortButtonOutlet: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    // MARK: - OUTLETS: Fold/Unfold Header Animation
    @IBOutlet weak var headerOutlet: UIView!
    @IBOutlet weak var todayButStackRightConst: NSLayoutConstraint!
    @IBOutlet weak var todayButtonStackViewOutlet: UIStackView!
    @IBOutlet weak var todayLabelLeftConst: NSLayoutConstraint!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTodayData()
        
        checkHideEditTableButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableCell1", bundle: nil), forCellReuseIdentifier: "FirstCustomCell")
        checkDate()
        
    }
    
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == noteViewId {
            if let createVC = segue.destination as? NoteViewController {
                createVC.updateDelegate = self
            }
        }
        
        if segue.identifier == sortViewId {
            if let createVCSort = segue.destination as? SortViewController {
                createVCSort.updateDelegate = self
            }
        }
        
        
    }
    
    
    
    
    
    func loadTodayData() {
        if UserDefaults.standard.stringArray(forKey: "h") != nil &&
            UserDefaults.standard.stringArray(forKey: "b") != nil &&
            UserDefaults.standard.stringArray(forKey: "c") != nil &&
            UserDefaults.standard.array(forKey: "d") != nil &&
            UserDefaults.standard.array(forKey: "f") != nil
        {
            
            NoteData.head = userDefaults.object(forKey: "h") as! [String]
            NoteData.body = userDefaults.object(forKey: "b") as! [String]
            NoteData.colorMark = userDefaults.object(forKey: "c") as! [String]
            NoteData.isDone = userDefaults.object(forKey: "d") as! [Bool]
            NoteData.isFold = userDefaults.object(forKey: "f") as! [Bool]
            
            print("Loaded DATA")
        }
    }
    
    
    @IBAction func editTableButton(_ sender: Any) {
        tableView.isEditing.toggle()
        
        if tableView.isEditing == false {
            reloadTable()
            editTableButtonOutlet.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            editTableButtonOutlet.tintColor = .systemBlue
            createNoteButtonOutlet.isEnabled = true
            sortButtonOutlet.isEnabled = true
            
        } else {
            editTableButtonOutlet.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
            editTableButtonOutlet.tintColor = .systemRed
            createNoteButtonOutlet.isEnabled = false
            sortButtonOutlet.isEnabled = false
        }
        
    }
    
    
    @IBAction func createNoteButton(_ sender: Any) {
        patternNoteView = StatusNote.create
    }
    
    
    @IBAction func sortButton(_ sender: UIButton) {
        
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        darkView.frame = self.view.frame
        self.view.addSubview(darkView)
        UIView.animate(withDuration: 0.3, delay: 0,
                       options: .curveEaseIn ){ [self] in
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
        }
    }
    
    
    func checkHideEditTableButton() {
        if NoteData.body.count >= 2 {
            editTableButtonOutlet.isHidden = false
            sortButtonOutlet.isHidden = false
        } else {
            editTableButtonOutlet.isHidden = true
            sortButtonOutlet.isHidden = true
        }
    }
    
    
}


// MARK: - UITableViewDataSource
extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NoteData.head.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as! CustomCell
        
        cell.setup(headText: NoteData.head[indexPath.row],
                   noteText: NoteData.body[indexPath.row],
                   markColor: NoteData.colorMark[indexPath.row],
                   isDone: NoteData.isDone[indexPath.row],
                   isFold: NoteData.isFold[indexPath.row],
                   cell: cell)
        
        return cell
    }
    
    
}




// MARK: - MethodDelegate
extension TodayViewController: MethodDelegate {
    
    func saveTodayData() {
        userDefaults.set(NoteData.head, forKey: "h")
        userDefaults.set(NoteData.body, forKey: "b")
        userDefaults.set(NoteData.colorMark, forKey: "c")
        userDefaults.set(NoteData.isDone, forKey: "d")
        userDefaults.set(NoteData.isFold, forKey: "f")
    }
    
    
    func reloadTable() {
        tableView.reloadData()
        checkHideEditTableButton()
        saveTodayData()
    }
    
    
    func fadeOutBlackBG() {
        UIView.animate(withDuration: 0.3, delay: 0,
                       options: .curveEaseIn, animations:{ [self] in
                        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                       }) { (completed) in
            self.darkView.removeFromSuperview()
        }
    }
    
    
}


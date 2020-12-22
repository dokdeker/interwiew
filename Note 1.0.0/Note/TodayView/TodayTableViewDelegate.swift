//
//  TodayDelegate.swift
//  Note
//
//  Created by Евгений on 14.12.2020.
//

import UIKit
//MARK: UITableViewDelegate
var usedIndexCell = Int()
extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if NoteData.isFold[indexPath.row] == true {
        //            return 120
        //        } else {
        //            return 60
        //        }
        
        //        if NoteData.body[indexPath.row].count <= 50 {
        //            return 60
        //        } else {
        //            return 163
        //        }
        switch NoteData.isFold[indexPath.row] {
        //        case nil:
        //            NoteData.isFold[indexPath.row] = false
        //            return 53.0
        
        case true:
            return 145
            
        default:
            return 60
        }
        
    }
    
    
    //MARK: - Edit Style
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         return .none
    }
    
    
    //MARK: - TableView willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
    }
    
    
    //MARK: -> swipe cell - Note is DONE
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if NoteData.isDone[indexPath.row] == false {
            let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                let cell = tableView.cellForRow(at: indexPath) as! CustomCell
                cell.setup(headText: NoteData.head[indexPath.row],
                           noteText: NoteData.body[indexPath.row],
                           markColor: ColorMark.green,
                           isDone: true,
                           isFold: NoteData.isFold[indexPath.row],
                           cell: cell)
                
                cell.isDoneAnimation(in: cell)
                NoteData.isDone[indexPath.row] = true
                self.saveTodayData()
                completionHandler(true)
            }
            
            doneAction.image = UIImage(named: "check-mark")?.withTintColor(.white)
            doneAction.backgroundColor = .systemGreen
            
            let configuration = UISwipeActionsConfiguration(actions: [doneAction])
            return configuration
            
        } else {
            
            let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                let cell = tableView.cellForRow(at: indexPath) as! CustomCell
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn ){ [] in
                    cell.setup(headText: NoteData.head[indexPath.row],
                               noteText: NoteData.body[indexPath.row],
                               markColor: NoteData.colorMark[indexPath.row],
                               isDone: false,
                               isFold: NoteData.isFold[indexPath.row],
                               cell: cell)
                }
                
                NoteData.isDone[indexPath.row] = false
                self.saveTodayData()
                completionHandler(true)
                
            }
            
            doneAction.image = UIImage(systemName: "multiply")
            doneAction.backgroundColor = .systemGray
            
            let configuration = UISwipeActionsConfiguration(actions: [doneAction])
            return configuration
            
        }
    }
    
    
    
    // MARK: - <- swipe cell - DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            NoteData.head.remove(at: indexPath.row)
            NoteData.body.remove(at: indexPath.row)
            NoteData.colorMark.remove(at: indexPath.row)
            NoteData.isDone.remove(at: indexPath.row)
            NoteData.isFold.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .left)
            self.checkHideEditTableButton()
            self.saveTodayData()
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        
        
        switch NoteData.isFold[indexPath.row] {
        
        case true:
            let foldCell = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                NoteData.isFold[indexPath.row] = false
                print(NoteData.isFold[indexPath.row])
                tableView.reloadRows(at: [indexPath], with: .fade)
                completionHandler(true)
                
            }
            
            foldCell.image = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward")
            foldCell.backgroundColor = .systemGray
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction, foldCell])
            return configuration
            
        case false:
            
            let foldCell = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                NoteData.isFold[indexPath.row] = true
                print(NoteData.isFold[indexPath.row])
                tableView.reloadRows(at: [indexPath], with: .fade)
                completionHandler(true)
                
            }
            
            foldCell.image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
            foldCell.backgroundColor = .systemGray
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction, foldCell])
            return configuration
        }
        
        
        
        
        
    }
    
    
    
    // MARK: - EDIT: Move sells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let headCell = NoteData.head[sourceIndexPath.row]
        let bodyCell = NoteData.body[sourceIndexPath.row]
        let colorMarkCell = NoteData.colorMark[sourceIndexPath.row]
        let doneCell = NoteData.isDone[sourceIndexPath.row]
        let foldCell = NoteData.isFold[sourceIndexPath.row]
        
        NoteData.head.remove(at: sourceIndexPath.row)
        NoteData.body.remove(at: sourceIndexPath.row)
        NoteData.colorMark.remove(at: sourceIndexPath.row)
        NoteData.isDone.remove(at: sourceIndexPath.row)
        NoteData.isFold.remove(at: sourceIndexPath.row)
        
        NoteData.head.insert(headCell, at: destinationIndexPath.row)
        NoteData.body.insert(bodyCell, at: destinationIndexPath.row)
        NoteData.colorMark.insert(colorMarkCell, at: destinationIndexPath.row)
        NoteData.isDone.insert(doneCell, at: destinationIndexPath.row)
        NoteData.isFold.insert(foldCell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    
    
    // MARK: - Tapped Cell -> Start action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        patternNoteView = StatusNote.read
        
        Note.head = NoteData.head[indexPath.row]
        Note.body = NoteData.body[indexPath.row]
        Note.colorMark = NoteData.colorMark[indexPath.row]
        usedIndexCell = indexPath.row
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        performSegue(withIdentifier: "noteViewId", sender: nil)
    }
}

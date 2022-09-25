//
//  ThirdViewController.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 24.09.2022.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    func reloadTable() {
        viewModel.refreshData()
        self.tableViewThirdVC.reloadData()
    }

    @IBOutlet weak var tableViewThirdVC: UITableView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    var selectedIndex: Int?
    let viewModel = ToDoViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
    }
    
    
    @IBAction func actionButton(_ sender: Any) {
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthVC") as! FourthViewController
        fourthVC.isAdding = true
        fourthVC.delegate = self
        navigationController?.pushViewController(fourthVC, animated: true)
        
    }
}
private extension ThirdViewController {
    func makeUI() {
        tableViewThirdVC.delegate = self
        tableViewThirdVC.dataSource = self
        registerCell()
    }
    
    func registerCell() {
        tableViewThirdVC.register(.init(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
    }
}

extension ThirdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthVC") as! FourthViewController
        fourthVC.isAdding = false
        fourthVC.delegate = self
        fourthVC.toDoObject = viewModel.todoAtIndex(selectedIndex!)
        self.navigationController?.pushViewController(fourthVC, animated: true)
        
    
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue ) in
//        }
//        
//        let updateAction = UIContextualAction(style: .normal, title: "Update") { (contextualAction, view, boolValue ) in
//        }
//        
//       return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
//        
//    }
    
}

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! TodoTableViewCell
        let item = viewModel.todoAtIndex(indexPath.row)

        cell.nameLabel.text = item.name
        if(item.isEvaluated == true) {
           cell.checkImage.image = UIImage(named: "check")
        } else {
            cell.checkImage.image = UIImage(named: "uncheck")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Careful", message: "Selected item will be deleted.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                print("canceled")
                 }))
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                self.viewModel.deleteTask(indexPath.row) { (_) in
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                 }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
}

extension ThirdViewController: FourthVCDelegate {
}

extension ThirdViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableViewThirdVC.indexPathForSelectedRow {
        tableViewThirdVC.deselectRow(at: indexPath, animated: true)
        tableViewThirdVC.reloadData()
    }
  }
  
}

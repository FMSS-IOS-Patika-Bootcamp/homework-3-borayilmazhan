//
//  FourthViewController.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 24.09.2022.
//

import UIKit
import CoreData

protocol FourthVCDelegate: AnyObject {
    func reloadTable()
}

class FourthViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var teamText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var completedButton: UIButton!
    
    var isAdding = true;
    var toDoObject: ToDo?
    
    weak var delegate: FourthVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if(isAdding == false) {
            nameText.text = toDoObject?.name
            teamText.text = toDoObject?.team
            cityText.text = toDoObject?.city
            
            if(toDoObject?.isEvaluated == true) {
                isDoneSwitch.setOn(true, animated: true)
            } else {
                isDoneSwitch.setOn(false, animated: true)
            
        }
    }
        

    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if(nameText.text != "") {
        if(isAdding) {
            let vm = AddNewToDoViewModel(name: nameText.text ?? "", team: teamText.text ?? "" , city: cityText.text ?? "", isEvaluated: isDoneSwitch.isOn)
            vm.saveTask()
             _ = navigationController?.popViewController(animated: true)
            self.delegate?.reloadTable()
        } else {
            let vm = AddNewToDoViewModel(name: nameText.text ?? "", team: teamText.text ?? "" , city: cityText.text ?? "", isEvaluated: isDoneSwitch.isOn)
                vm.uptadeTask(v: toDoObject!)
               _ = navigationController?.popViewController(animated: true)
                self.delegate?.reloadTable()
        }
        } else {
            let alert = UIAlertController(title: "Warning", message: "To do title cannot be empty.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
                 }))
            self.present(alert, animated: true, completion: nil)
        }
    
        
    }

}

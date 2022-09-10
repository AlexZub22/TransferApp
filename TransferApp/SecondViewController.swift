//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Alexander Zub on 09.09.2022.
//

import UIKit

class SecondViewController: UIViewController, UpdatingDataController {
    var handleUpdateDataDelegate: DataUpdateProtocol?
    @IBOutlet var dataTextField: UITextField!
    var updatingData: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
   /* @IBAction func saveDataWithClosure(_ sender: UIButton) {
        let updateData = dataTextField.text ?? ""
        completionHandler?(updateData)
        
        navigationController?.popViewController(animated: true)
    } */
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdateDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
}

protocol UpdatingDataController: AnyObject {
    var updatingData: String { get set }
}

//
//  ViewController.swift
//  TransferApp
//
//  Created by Alexander Zub on 09.09.2022.
//

import UIKit

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    
    var updatedData: String = "Test data"
    @IBOutlet var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        editScreen.updatingData = dataLabel.text ?? ""
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
  /*  @IBAction func editDataWithClosure(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        self.navigationController?.pushViewController(editScreen, animated: true)
    } */
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.handleUpdateDataDelegate = self
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
}

protocol UpdatableDataController {
    var updatedData: String { get set }
}


//
//  ViewController.swift
//  PlistDataTest
//
//  Created by Arif Demirkoparan on 23.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var saveTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(PlistDataMenager.plistShared.dataFilePath!)
        PlistDataMenager.shared.loadData()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let newItem = PlistDataModel()
        if saveTextfield.text == "" {
            print("Null value")
        }else {
            if let text = saveTextfield.text {
                newItem.text = text
                PlistDataMenager.shared.textArray.append(newItem)
            }
        }
        PlistDataMenager.shared.saveData()
        tableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlistDataMenager.shared.textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let item  = PlistDataMenager.shared.textArray[indexPath.row]
        content.text = item.text
        content.textProperties.color =  .darkGray
        content.textProperties.font = UIFont(name: "Gill Sans", size: 20)!
        cell.contentConfiguration = content
        return cell
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { action,sourceView,handler in
            let item  = PlistDataMenager.shared.textArray[indexPath.row].text
            PlistDataMenager.shared.deleteData(text: item)
            PlistDataMenager.shared.textArray.remove(at: indexPath.row)
            PlistDataMenager.shared.saveData()
            tableView.reloadData()
        })
        delete.backgroundColor = .darkText
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
}


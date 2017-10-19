//
//  CalculationMethodsViewController.swift
//  Fajr Wake
//
//  Created by Ali Mir on 10/18/17.
//  Copyright © 2017 com.AliMir. All rights reserved.
//

import UIKit

internal class CalculationMethodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Stored Properties
    
    private var calcMethods = [CalculationMethod]()
    private var selectedIndexPath: IndexPath?

    // MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcMethods = [.jafari, .karachi, .isna, .mwl, .makkah, .egypt, .tehran]
    }
    
    
    // MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calcMethodCell", for: indexPath)
        cell.textLabel?.text = calcMethods[indexPath.row].description
        
        if calcMethods[indexPath.row] == Alarm.shared.praytime.setting.calcMethod {
            selectedIndexPath = indexPath
        }
        
        cell.accessoryType = indexPath == selectedIndexPath ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcMethods.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let newlySelectedCell = tableView.cellForRow(at: indexPath) else { return }
        
        // Add checkmark to newly selected cell
        if newlySelectedCell.accessoryType == .none {
            newlySelectedCell.accessoryType = .checkmark
        }
        
        // Remove checkmark from old cell
        
        if let oldSelectedIndexPath = selectedIndexPath, let oldCell = tableView.cellForRow(at: oldSelectedIndexPath) {
            if oldCell.accessoryType == .checkmark {
                oldCell.accessoryType = .none
            }
        }
        
        // Save newly selected indexPath
        selectedIndexPath = indexPath
        
        Alarm.shared.setCalcMethod(calcMethods[indexPath.row])
        
    }
    
}
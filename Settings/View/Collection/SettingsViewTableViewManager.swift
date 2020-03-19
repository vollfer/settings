//
//  SettingsViewTableViewManager.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 01.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import UIKit

protocol SettingsViewTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with settingsTitleText: [SettingsCellType])
    func reloadData()
}

final class SettingsViewTableViewManager: NSObject {
    
    private weak var cellDelegate: SettingsTableViewCellDelegat?
    private weak var tableView: UITableView?
    
    var settingsTitleText: [SettingsCellType] = []
    
    init(cellDelegate: SettingsTableViewCellDelegat) {
        self.cellDelegate = cellDelegate
    }
}

// MARK: - SettingsViewTableViewManagerInput

extension SettingsViewTableViewManager: SettingsViewTableViewManagerInput {
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    func update(with settingsTitleText: [SettingsCellType]) {
        self.settingsTitleText = settingsTitleText
        tableView?.reloadData()
    }
    
    
    func setup(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.className)
        
        self.tableView = tableView
    }
}

extension SettingsViewTableViewManager: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTitleText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.className, for: indexPath)
        let cellType = settingsTitleText[indexPath.row]
        
        (cell as? SettingsTableViewCell)?.delegat = cellDelegate
        (cell as? SettingsTableViewCell)?.cellType = cellType
        
        cell.textLabel?.text = cellType.title
        cell.textLabel?.systemTextColor()
        
        return cell
    }
}

extension SettingsViewTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    }


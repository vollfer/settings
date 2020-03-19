//
//  SettingsView.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 24.10.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import UIKit

protocol SettingsViewOutput: ViewOutput {
}

final class SettingsView: UIViewController {
    var presenter: SettingsViewOutput?
    var settingsViewTableViewManager: SettingsViewTableViewManagerInput?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
    }
    
    // MARK: - Draw Self
    
    private func drawSelf() {
        
        title = R.string.localizable.settingsTitle()
        
        view.systemBackground()
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.systemBackground()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        settingsViewTableViewManager?.setup(tableView: tableView)
        tableView.tableFooterView = UIView()
        
        presenter?.viewIsReady()
    }
}


    // MARK: - MenuViewInput

extension SettingsView: SettingsViewInput {
    
    func updateView(with settingsTitleText: [SettingsCellType]) {
        settingsViewTableViewManager?.update(with: settingsTitleText)
    }
    
    func showAlert(title: String, subtitle: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction)
        
        present(viewController: alert, animated: true)
    }
}

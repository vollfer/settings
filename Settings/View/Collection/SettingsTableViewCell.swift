//
//  SettingsTableViewCell.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 08.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegat: class {
    func didSelectCell(with type: SettingsCellType)
}

final class SettingsTableViewCell: UITableViewCell {
    weak var delegat: SettingsTableViewCellDelegat?
    var cellType: SettingsCellType? {
        didSet {
            switch cellType {
            case .onboarding:
                accessoryType = .none
            case .restorePurchases:
                accessoryType = .disclosureIndicator
            case .aboutApp:
                accessoryType = .disclosureIndicator
            case .feedback:
                accessoryType = .none
            case .none:
                break
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        systemBackground()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        guard selected, let cellType = cellType else { return }
        
        switch cellType {
        case .restorePurchases:
            NotificationCenter.default.addObserver(self, selector: #selector(didStartRestore), name: .didStartRestorePurchase, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didRestore), name: .didRestore, object: nil)
        default:
            break
        }
        
        delegat?.didSelectCell(with: cellType)
    }
    
    @objc private func didStartRestore() {
        let activityIndicator = UIActivityIndicatorView(frame: accessoryView?.frame ?? .zero)
        activityIndicator.tag = 1
        contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.autoAlignAxis(toSuperviewAxis: .horizontal)
        activityIndicator.autoPinEdge(toSuperviewEdge: .right, withInset: 12)
        accessoryType = .none
    }
    
    @objc private func didRestore() {
        let activityIndicator = viewWithTag(1) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        accessoryType = .disclosureIndicator
    }
}

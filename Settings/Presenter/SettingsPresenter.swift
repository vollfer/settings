//
//  SettingsPresenter.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 28.10.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import Foundation
import UIKit

public enum SettingsCellType {
    case onboarding
    case restorePurchases
    case aboutApp
    case feedback

    var title: String {
        
        switch self {
        case .onboarding:
            return R.string.localizable.settingsShowOnboarding()
        case .restorePurchases:
            return R.string.localizable.settingsRestorePurchases()
        case .aboutApp:
            return R.string.localizable.settingsAboutApp()
        case .feedback:
            return R.string.localizable.settingsFeedback()
        }
    }
}

protocol SettingsViewInput: class {
    func updateView(with settingsTitleText: [SettingsCellType])
    func showAlert(title: String, subtitle: String, buttonTitle: String)
}

final class SettingsPresenter {
    
    // MARK: - Properties
    
    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?
    
    var purchaseService: PurchaseServece
    
    init(purchaseService: PurchaseServece) {
        self.purchaseService = purchaseService
    }
}


// MARK: - SettingsPresener

extension SettingsPresenter: SettingsViewOutput {
    
    func viewIsReady() {
        let settingsTitleText: [SettingsCellType] = [.onboarding, .restorePurchases, .aboutApp, .feedback]
        view?.updateView(with: settingsTitleText)
    }
}


//MARK: - SettingsTableViewCellDelegat
extension SettingsPresenter: SettingsTableViewCellDelegat {
    
    func didSelectCell(with type: SettingsCellType) {
        
        switch type {
        case .onboarding:
            router?.openOnboarding()
        case .aboutApp:
            router?.openApplication()
        case .restorePurchases:
            purchaseService.isPurchasedAnything { [weak self] isPurchased in
                self?.purchaseService.restorePurchases()
            }
        case .feedback:
            router?.openFeedback()
        }
    }
}


// MARK: - PurchaseServeceDelegate
extension SettingsPresenter: PurchaseServeceDelegate {
    
    
    
    func didCancel() {}
    
    func didSuccessToBuy() {}
    
    func didFailureToBuy(with error: String) {}
    
    func didRestore(productCount: Int) {
        
        guard productCount == 0 else {
            view?.showAlert(title: R.string.localizable.purchaseRestoreSuccessTitle(),
                            subtitle: R.string.localizable.purchaseRestoreSuccessDescription(String(productCount)),
                            buttonTitle: R.string.localizable.purchaseRestoreSuccessButton())
            return
        }
        
        view?.showAlert(title: R.string.localizable.purchaseRestoreUpsTitle(),
                              subtitle: R.string.localizable.purchaseRestoreUpsDescription(),
                              buttonTitle: R.string.localizable.purchaseRestoreUpsButton())
        
    }
    
}

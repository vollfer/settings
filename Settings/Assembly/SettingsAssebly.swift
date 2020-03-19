//
//  SettingsAssebly.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 24.10.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import Foundation

final class SettingsAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        var purchaseService = CompositionFactory.shared.service.purchaseService
        
        let module = SettingsView()
        let presenter = SettingsPresenter(purchaseService: purchaseService)
        let router = SettingsRouter(transition: module)
        let settingsViewTableViewManager = SettingsViewTableViewManager(cellDelegate: presenter)
        
        module.presenter = presenter
        module.settingsViewTableViewManager = settingsViewTableViewManager
        
        purchaseService.delegate = presenter
        
        presenter.view = module
        presenter.router = router
        
        return module
    }
}

extension SettingsAssembly {
    
    struct Model: TransitionModel {
    
    }
}

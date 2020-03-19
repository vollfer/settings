//
//  ApplicationAssembly.swift
//  ForFriends
//
//  Created by Александр  Бровков  on 11.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import Foundation

final class AboutApplicationAssembly: Assembly {
    
    static func assembleModule() -> Module {
        
        let module = AboutApplicationView()
        let presenter = AboutApplicationPresenter()
        let router = AboutApplicationRouter(transition: module)
        
        module.presenter = presenter
        
        presenter.view = module
        presenter.router = router
        
        return module
    }
}

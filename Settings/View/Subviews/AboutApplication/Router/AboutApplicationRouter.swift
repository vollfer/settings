//
//  ApplicationRouter.swift
//  ForFriends
//
//  Created by Александр  Бровков  on 11.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

protocol ApplicationRouterInput {
    
}

final class AboutApplicationRouter {
    
    //MARK: - Properties
    
    unowned let transition: ModuleTransitionHandler
    
    //MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
}

extension AboutApplicationRouter: ApplicationRouterInput {
    
}

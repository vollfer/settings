//
//  SettingsRouter.swift
//  WhoIsTheSpy
//
//  Created by Александр  Бровков  on 28.10.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import UIKit

protocol SettingsRouterInput {
    func openOnboarding()
    func openApplication()
    func openFeedback()
}

final class SettingsRouter {
    
    //MARK: - Properties
    
    unowned let transition: ModuleTransitionHandler
    
    //MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
}

    //MARK: - SettingsInput

extension SettingsRouter: SettingsRouterInput {
    func openOnboarding() {
        transition.present(animated: true, moduleType: OnboardingAssembly.self)
    }
    func openApplication() {
        transition.push(moduleType: AboutApplicationAssembly.self)
    }
    func openFeedback() {
        let supportEmail = "Thesvich@yandex.ru"
        if let emailURL = URL(string: "mailto:\(supportEmail)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }
}

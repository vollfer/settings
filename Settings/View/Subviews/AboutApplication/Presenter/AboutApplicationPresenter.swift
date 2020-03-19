//
//  ApplicationPresenter.swift
//  ForFriends
//
//  Created by Александр  Бровков  on 11.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import Foundation

protocol ApplicationViewInput: class {
    func versionTitleLabel(with text: String )
}

final class AboutApplicationPresenter {
    
    // MARK: - Properties
    
    weak var view: ApplicationViewInput?
    var router: ApplicationRouterInput?
    
}

extension AboutApplicationPresenter: ApplicationViewOutput {
    func viewIsReady() {
        let labelText = R.string.localizable.aboutAppVersion(Constants.Application.fullVersion)
        view?.versionTitleLabel(with: labelText)
    }
}

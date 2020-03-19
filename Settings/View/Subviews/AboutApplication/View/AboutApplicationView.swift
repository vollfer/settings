//
//  ApplicationView.swift
//  ForFriends
//
//  Created by Александр  Бровков  on 11.11.2019.
//  Copyright © 2019 Potapov Anton. All rights reserved.
//

import UIKit

protocol ApplicationViewOutput: ViewOutput {
    
}

final class AboutApplicationView: UIViewController {
    
     //MARK: - Properties
    
    var presenter: ApplicationViewOutput?
    var cornerRadius: CGFloat {
        return Constants.isPortrait ? 42 : 19
    }
    
    let titleImageView: UIImageView = {
        
        let imageView = UIImageView(image: R.image.logo())
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let imageContainerView: UIView = {
        let imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.layer.cornerRadius = Constants.isPortrait ? 42 : 19
        imageContainerView.clipsToBounds = true
        return imageContainerView
    }()
    
    let titleTextView: UITextView = {
        
        let textView = UITextView()
        let text = R.string.localizable.aboutAppDescription()
        let attributedString = NSMutableAttributedString(string: text)
        
        let attributes: [NSAttributedString.Key : Any] = [
            .link: URL(string: "https://www.instagram.com/grafmarti/")!
        ]
        
        let edgarStrgin = "@grafmarti(instagram)"
        let rangeFrom = (text.indexDistance(of: edgarStrgin) ?? 176) + 5
        attributedString.setAttributes(attributes, range: NSRange(location: rangeFrom, length: edgarStrgin.count))
        
        textView.text = text
        textView.attributedText = attributedString
        
        if #available(iOS 13.0, *) {
            textView.linkTextAttributes = [
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            ]
        } else {
            textView.linkTextAttributes = [
                .foregroundColor: UIColor.white,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            ]
        }
        
        textView.systemTextColor()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let versionLabel = UILabel()
    let titleLabel = UILabel()
    
    let topImageConteinerView: UIView = {
        let conteinerView = UIView()
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        return conteinerView
    }()
        
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageContainerView.layer.cornerRadius = cornerRadius
    }
    
    func drawSelf() {
        
        title = R.string.localizable.settingsAboutApp()
        
        versionLabel.systemTextColor()
        
        titleTextView.systemBackground()
        if #available(iOS 13.0, *) {
            titleTextView.textColor = .label
        } else {
            titleTextView.textColor = .white
        }
        
        titleLabel.systemTextColor()
        titleLabel.text = R.string.localizable.appName()
        
        view.systemBackground()
        view.addSubview(topImageConteinerView)
        view.addSubview(titleTextView)
        view.addSubview(versionLabel)
        
        imageContainerView.addSubview(titleImageView)
        
        topImageConteinerView.addSubview(titleLabel)
        topImageConteinerView.addSubview(imageContainerView)
        
        versionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        titleLabel.textAlignment = .center
        
        imageContainerView.autoCenterInSuperview()
        imageContainerView.autoMatch(.height, to: .height, of: topImageConteinerView, withMultiplier: 0.5)
        imageContainerView.autoMatch(.width, to: .height, of: topImageConteinerView, withMultiplier: 0.5)
        
        titleImageView.autoCenterInSuperview()
        titleImageView.autoPinEdgesToSuperviewEdges()
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        topImageConteinerView.autoPinEdgesToSuperviewSafeArea(with: insets, excludingEdge: .bottom)
        topImageConteinerView.autoMatch(.height, to: .height, of: view, withMultiplier: 0.4)
        
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: topImageConteinerView)
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageContainerView, withOffset: 12)
        
        NSLayoutConstraint.activate([
            
            //MARK: - UITextView
        
            titleTextView.topAnchor.constraint(equalTo: topImageConteinerView.bottomAnchor),
            titleTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            titleTextView.bottomAnchor.constraint(equalTo: versionLabel.topAnchor),
        
            // MARK: - Lable
            versionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 0),
            versionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            versionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

extension AboutApplicationView: ApplicationViewInput {
    
    func versionTitleLabel(with text: String) {
        versionLabel.text = text
    }
   
}

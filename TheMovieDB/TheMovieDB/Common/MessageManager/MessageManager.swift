//
//  MessageManager.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 15/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import SwiftMessages

class MessageManager {
    
    static let shared = MessageManager()
    
    private init() {}
    
    func show(title: String, body: String, imageName: String, colorName: String) {
        
        var config = SwiftMessages.Config()

        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = false
        
        
        
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureTheme(.info)

        // Add a drop shadow.
        view.configureDropShadow()
        view.configureContent(title: title, body: body)
        view.iconImageView?.image = UIImage(named: imageName)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.button?.isHidden = true
        view.backgroundColor = UIColor(named: "gold")

        SwiftMessages.show(config: config, view: view)
        
    }
}

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
    
    func present(error: Error) {
        if let remote = error as? RemoteFetchError, remote == .noInternet {
           presentError(title: "NO INTERNET CONNECTION", subtitle: "Check your network settings and try again.", seconds: 5)
            return
        }
        
        if let dataBase = error as? DataBaseError, dataBase == .alreadyExists {
            presentError(title: "Error", subtitle: "The movie is already in your favorite list.", seconds: 2)
            return
        }
        presentError(title: "ERROR", subtitle: "Something went wrong !", seconds: 5)
    }
    
    private func presentError(title: String, subtitle: String, seconds: TimeInterval) {
        let config = getConfig(seconds: seconds)
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureContent(title: title, body: subtitle)
        view.button?.isHidden = true
        view.configureTheme(.error)
        SwiftMessages.show(config: config, view: view)
    }
    
    func presentSuccess(title: String) {
        let config = getConfig(seconds: 2)
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureContent(title: "SUCCESS", body: title)
        view.button?.isHidden = true
        view.configureTheme(.success)
        SwiftMessages.show(config: config, view: view)
    }
    
    private func getConfig(seconds: TimeInterval) -> SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .seconds(seconds: seconds)
        config.dimMode = .gray(interactive: true)
        return config
    }
}

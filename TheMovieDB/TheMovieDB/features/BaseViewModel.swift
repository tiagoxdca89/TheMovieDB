//
//  BaseViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocol

protocol BaseViewModelProtocol {
    var bag: DisposeBag { get }
    func viewDidLoad()
    func viewWillAppear()
    func presentError(error: Error)
    func presentSuccess(title: String)
}

// MARK: Class

class BaseViewModel: BaseViewModelProtocol {
    
    // MARK: Public properties
    
    var bag: DisposeBag = DisposeBag()
    
    // MARK: Public methods
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    
}

//MARK: Extension

extension BaseViewModelProtocol {
    func presentError(error: Error) {
        MessageManager.shared.present(error: error)
    }
    
    func presentSuccess(title: String) {
        MessageManager.shared.presentSuccess(title: title)
    }
}

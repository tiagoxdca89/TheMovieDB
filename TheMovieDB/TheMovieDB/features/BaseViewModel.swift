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
    
    var bag: DisposeBag = DisposeBag()
    func viewDidLoad() {}
    func viewWillAppear() {}
    
}

extension BaseViewModelProtocol {
    func presentError(error: Error) {
        MessageManager.shared.present(error: error)
    }
    
    func presentSuccess(title: String) {
        MessageManager.shared.presentSuccess(title: title)
    }
}

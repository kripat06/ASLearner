//
//  PopUpManager.swift
//  ASLearner
//
//  Created by admin on 10/25/22.
//

import Foundation

final class PopUpManager: ObservableObject {
    
    enum Action{
        case na
        case present
        case dismiss
    }
    
    @Published private(set) var action: Action = .na
    
    func present(){
        guard !action.isPresented else { return }
        self.action = .present
    }
    
    func dismiss(){
        self.action = .dismiss
    }
}

extension PopUpManager.Action {
    var isPresented: Bool { self == .present}
}

//
//  WeakComponent+Subscriptions.swift
//  Example
//
//  Created by Chris Nevin on 09/02/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation
import Render

extension WeakComponent {
    func subscribe<U>(_ keyPath: KeyPath<AppState, U>, callback: @escaping (U) -> Void) {
        references.append(store.subscribe { state in
            callback(state[keyPath: keyPath])
        })
    }

    func unsubscribe() {
        references.compactMap { $0 as? String }.forEach(store.unsubscribe)
        debugPrint("Unsubscribe \(self)")
    }
}

extension WeakComponent: Deallocatable {
    public func deallocate() {
        unsubscribe()
    }
}

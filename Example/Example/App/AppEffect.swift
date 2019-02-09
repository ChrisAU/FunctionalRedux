//
//  AppEffect.swift
//  Example
//
//  Created by Chris Nevin on 31/01/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation
import Core

enum AppEffect {
    case sequence([AppEffect])
    case api(ApiEndpoint)
    case log(String)
    case save
    case track(AnalyticsEvent)
}

extension AppEffect: Monoid {
    static var identity: AppEffect { return .sequence([]) }
    
    func combine(with other: AppEffect) -> AppEffect {
        switch (self, other) {
        case let (.sequence(a), .sequence(b)): return .sequence(a + b)
        case let (.sequence(a), _): return .sequence(a + [other])
        case let (_, .sequence(b)): return .sequence([self] + b)
        default: return .sequence([self, other])
        }
    }
}

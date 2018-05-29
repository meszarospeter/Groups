//
//  ErrorDisplayManager.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Foundation

class ErrorDisplayManager {
    
    static func displayableInfo(for error: Error) -> (title: String, message: String) {
        let title = L10n.error
        let message = self.message(for: error)
        return (title, message)
    }

    fileprivate static func message(for error: Error) -> String {
        switch error {
            case .unknownError:
                return L10n.somethingStrangeHasHappenedMaybeTryTryingAgain
        }
    }
}

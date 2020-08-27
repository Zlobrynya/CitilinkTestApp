//
//  HideKeyboard.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import SwiftUI

public struct HideKeyboard: ViewModifier {
    
    // MARK: - Private Properties
    
    private let gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }
    
    // MARK: - Body

    public func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

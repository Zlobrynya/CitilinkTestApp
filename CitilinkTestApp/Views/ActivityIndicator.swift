//
//  ActivityIndicator.swift
//  CitilinkTestApp
//
//  Created by Nikitin Nikita on 27.08.2020.
//  Copyright © 2020 Nikita Nikitin. All rights reserved.
//

import UIKit
import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
    
    // MARK: - Private Properties

    @Binding private var isAnimating: Bool
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor?
    
    // MARK: - Lifecycle
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        self._isAnimating = isAnimating
        self.style = style
        self.color = color
    }

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        if let color = color {
            indicator.color = color
        }
        return indicator
        
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

//
//  CheckboxStyle.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            if configuration.isOn {
                Circle()
                    .strokeBorder(Color.collieRoxo, lineWidth: 1)
                    .background(Circle().fill(Color.collieBranco))
                    .frame(width: 14, height: 14)
                    .overlay(Circle().fill(Color.collieRoxo).frame(width: 10, height: 10))
            } else {
                Circle()
                    .strokeBorder(.gray, lineWidth: 1)
                    .background(Circle().fill(Color.collieBranco))
                    .frame(width: 14, height: 14)
            }
            configuration.label
        }
        .onTapGesture {
            withAnimation() {
                configuration.isOn.toggle()
            }
        }

    }
}

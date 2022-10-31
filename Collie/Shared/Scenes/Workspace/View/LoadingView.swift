//
//  LoadingView.swift
//  Collie
//
//  Created by Pablo Penas on 24/10/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Loading...")
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

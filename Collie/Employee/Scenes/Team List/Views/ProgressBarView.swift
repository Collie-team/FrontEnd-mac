//
//  ProgressBarView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

struct ProgressBarView: View {
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 295, height: 12)
                    .foregroundColor(.gray)
                    .cornerRadius(6)
                Rectangle()
                    .frame(width: 100, height: 12)
                    .foregroundColor(.red)
                    .cornerRadius(6)
            }
                
            Text("30%")
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}

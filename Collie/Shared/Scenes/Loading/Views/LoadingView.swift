//
//  LoadingView.swift
//  Collie
//
//  Created by Pablo Penas on 24/10/22.
//

import SwiftUI

struct LoadingView: View {
    var animation: Animation {
        Animation.easeInOut(duration: 2.2)
    }
    @State var angle = Angle.degrees(0)
    var body: some View {
        Image("loadingSprite")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(angle)
            .animation(animation.repeatForever(autoreverses: false), value: angle)
            .onAppear {
                angle -= Angle.degrees(1080)
            }
            .padding(200)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.collieBranco)
        
//        ZStack {
//            GeometryReader { geometry in
//                ZStack(alignment: .top) {
//                    HStack {
//                        VStack {
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//                    Circle()
//                        .trim(from: 0, to: 0.75)
//                        .stroke(AngularGradient(colors: [Color.collieBranco, Color.collieRoxo], center: .center, angle: Angle(degrees: -90)) ,style: StrokeStyle(lineWidth: 30, lineCap: .round))
//                        .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
//                    Circle()
//                        .fill(Color.collieRoxo)
//                        .frame(width: 30, height: 30)
//                        .alignmentGuide(.top) { d in d[VerticalAlignment.center] }
//                }
//                .padding(.bottom, 15)
//                .rotationEffect(angle)
//            }
//            .padding(.bottom, 30)
//        }
//        .background(Color.collieBranco)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .animation(animation.repeatForever(autoreverses: false), value: angle)
//        .onAppear {
//            angle += Angle.degrees(1080)
//        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

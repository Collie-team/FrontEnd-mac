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
    @State var trim: CGFloat = 0
    
    var body: some View {
//        Image("loadingSprite")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .rotationEffect(angle)
//            .animation(animation.repeatForever(autoreverses: false), value: angle)
//            .onAppear {
//                angle -= Angle.degrees(1080)
//            }
//            .padding(200)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.collieBranco)
        
        ZStack {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    HStack {
                        VStack {
                            Spacer()
                        }
                        Spacer()
                    }
                    Circle()
                        .trim(from: trim, to: 0.75)
                        .stroke(AngularGradient(colors: [Color.collieRoxo.opacity(0), Color.collieRoxo.opacity(0.8)], center: .center, angle: Angle(degrees: -90)) ,style: StrokeStyle(lineWidth: 30, lineCap: .round))
                        .frame(width: min(geometry.size.width, geometry.size.height)/4, height: min(geometry.size.width, geometry.size.height)/4)
                        .overlay(
                            Circle()
                                .fill(Color.collieRoxo)
                                .frame(width: 30, height: 30)
                                .offset(x: 0, y: -min(geometry.size.width, geometry.size.height)/8)
                        )
                }
                .rotationEffect(angle)
            }
        }
        .background(Color.collieBranco.opacity(0.5))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(animation.repeatForever(autoreverses: false), value: angle)
        .onAppear {
            angle += Angle.degrees(1080)
            withAnimation(.easeInOut(duration: 1.1).repeatForever()) {
                trim = 0.5
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

//
//  InspectEmployeeTaskFullView.swift
//  Collie
//
//  Created by Pablo Penas on 28/11/22.
//

import SwiftUI

struct InspectEmployeeTaskFullView: View {
    @ObservedObject var inspectViewModel: InspectViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var category: TaskCategory
    var handleClose: () -> ()
    var handleCheckToggle: () -> ()
    
//    var responsibleName: String = ""
//    var responsibleEmail: String = ""
    
    private let green = Color(red: 108/255, green: 217/255, blue: 125/255)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Tarefa")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    Text(inspectViewModel.chosenTaskModel?.task.name ?? "")
                        .collieFont(textStyle: .title)
                        .foregroundColor(.black)
                    Spacer()

                }
                Text(category.name)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(category.color)
                    .cornerRadius(16)
                    .collieFont(textStyle: .subtitle, textSize: 12)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            VStack(spacing: 24) {
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString((inspectViewModel.chosenTaskModel?.task.startDate) ?? Date()))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de entrega")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString((inspectViewModel.chosenTaskModel?.task.endDate) ?? Date()))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }

                
                HStack(alignment: .top) {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                        .frame(width: 200)
                    Text(inspectViewModel.chosenTaskModel?.task.description ?? "")
                        .collieFont(textStyle: .regularText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .foregroundColor(.black)
            
        }
        .padding(.leading, 90)
        .padding(.trailing, 60)
        .padding(.vertical, 45)
        .frame(maxWidth: .infinity)
        .background(
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(category.color)
                    .frame(width: 30)
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.collieBranco)
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                inspectViewModel.unselectTask()
                                handleClose()
                            } label: {
                                Image(systemName: "xmark")
                                    .collieFont(textStyle: .title)
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                    }
                    .padding(16)
                }
            }
        )
        .cornerRadius(8)
    }
}

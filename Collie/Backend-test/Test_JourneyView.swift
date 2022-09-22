//
//  Test_JourneyView.swift
//  Collie
//
//  Created by Pablo Penas on 14/09/22.
//

import SwiftUI

struct Test_JourneyView: View {
    @StateObject var manager = Test_JourneyViewModel()
    var body: some View {
        VStack {
            Spacer()
            Text("Seja bem vindo ao teste do backend!")
                .font(.title)
                .padding()
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Text("Inserir nova jornada")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.bottom)
                    HStack {
                        Text("Nome:")
                        Spacer()
                    }
                    TextField("name", text: $manager.editingJourney.name)
                    HStack {
                        Text("Descrição:")
                        Spacer()
                    }
                    TextField("description", text: $manager.editingJourney.description)
                    Button(action: {
                        manager.registerJourney()
                    }) {
                        Text("Criar jornada")
                    }
                    Button(action: {
                        manager.fetchJourneys() { response in
                            manager.availableJourneys = response
                        }
                    }) {
                        Text("Carregar jornadas")
                    }
                    List {
                        ForEach(manager.availableJourneys, id: \.self) { journey in
                            HStack {
                                Text("Jornada: ")
                                Text(journey.name)
                                Spacer()
                                Text("Descrição: ")
                                Text(journey.description)
                            }
                        }
                    }
                }
                .frame(width: 400)
                Spacer()
            }
            Spacer()
        }
    }
}

struct Test_JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        Test_JourneyView()
    }
}

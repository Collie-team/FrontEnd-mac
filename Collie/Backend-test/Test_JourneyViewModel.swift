//
//  Test_JourneyViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 14/09/22.
//

import Foundation
import SwiftUI

class Test_JourneyViewModel: ObservableObject {
    @Published var editingJourney = JourneyModel(name: "asdasda", description: "adasdas")
    @Published var availableJourneys: [JourneyModel] = []

    func registerJourney() {
        
        let string = "https://backend-python-5hjoj8lzc-collie.vercel.app/create/?name=\(editingJourney.name)&description=\(editingJourney.description)"
//        let url = URL(string: "https://backend-python-5hjoj8lzc-collie.vercel.app/create/?name=\(editingJourney.name)&description=\(editingJourney.description)")
//        let myURL = URL(fileURLWithPath: "https://backend-python-5hjoj8lzc-collie.vercel.app/create/?name=\(editingJourney.name)&description=\(editingJourney.description)")
        let myURL = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: myURL!)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            // your code here
            if let error = error {
                print("Error with creating journey: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            if let data = data {
                print(data)
                let message = try? JSONDecoder().decode(String.self, from: data)
                print(message)
//                completionHandler(filmSummary.results ?? [])
            }
        })
        task.resume()
    }
    
    func updateJourneys(journeys: [JourneyModel]) {
        availableJourneys = journeys
    }
    
    func fetchJourneys(_ completion: @escaping ([JourneyModel]) -> Void) {
        let url = URL(string: "https://backend-python-5hjoj8lzc-collie.vercel.app/fetch/")
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            // your code here
            if let error = error {
                print("Error with fetching journeys: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data {
                print(data)
//                let journeys = try! JSONDecoder().decode(JourneyModel.self, from: data)
//                let response = try! container.decode([JourneyModel].self, forKey: )
                let response = try! JSONDecoder().decode(JourneyDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(response.journeys)
                }
//                self.updateJourneys(journeys: response.journeys)
//                completionHandler(filmSummary.results ?? [])
            }
        })
        task.resume()
    }
}

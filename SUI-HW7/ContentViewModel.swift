//
//  ContentViewModel.swift
//  SUI-HW7
//
//  Created by Dim on 08.07.2025.
//

import Foundation
internal import Combine

class ContentViewModel: ObservableObject {    
    @Published var news: [News] = []

    func fetchData() {
        let service = NetworkService(urlString: "https://api.unsplash.com")
        service.sendRequest(for: .list, params: ["Content-Type": "application/json"], headers: ["Authorization": "Client-ID 6PgiFLKinDxM6Ebz502_NRQ-X_Ay_txIRoF1mYysqb0"], responseType: [PhotoShortInfo].self) { response in
            var news: [News] = []
            response.forEach {
                var title = "!non!"
                if let alt_description = $0.alt_description {
                    title = alt_description
                } else if let description = $0.description {
                    title = description
                }
                
                news.append(News(id: $0.id, title: title, thumbImageStringUrl: $0.urls.thumb))
            }
            
            DispatchQueue.main.async {
                self.news = news
            }
        }
    }
}

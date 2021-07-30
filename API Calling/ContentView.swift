//
//  ContentView.swift
//  API Calling
//
//  Created by James on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var searchResults = [Result]()
    
    var body: some View {
        NavigationView {
            List (searchResults) { result in
                Text(result.title)
            }
            .navigationTitle("Google Search")
        }
        .onAppear(perform: {
            getSearch()
        })
    }
    
    func getSearch() {
        let apiKey = "?rapidapi-key=0a1cfe84e9msh52abeacda017807p1a74c5jsn30e27789404c"
        let query = "https://google-search3.p.rapidapi.com/api/v1/search/q=funny+meme&num=100\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                print(json)
                let contents = json["results"].arrayValue
                if contents.isEmpty == false {
                    for item in contents {
                        let title = item["title"].stringValue
                        let link = item["link"].stringValue
                        let description = item["description"].stringValue
                        let result = Result(title: title, link: link, description: description)
                        searchResults.append(result)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Result: Identifiable {
    var id = UUID()
    var title : String
    var link : String
    var description : String
}

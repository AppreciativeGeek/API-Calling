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
            List {
                ForEach (searchResults) { result in
                    NavigationLink(
                        destination: ZStack {
                            Color(UIColor(red: 0.96, green: 0.68, blue: 0.80, alpha: 1.00)).ignoresSafeArea()
                            VStack {
                                Text(result.description).padding()
                                Link("Further info...", destination: URL(string: result.link)!)
                            }
                        },
                        label: {
                            Text(result.title)
                        })
                }
                .listRowBackground(Color(UIColor(red: 0.96, green: 0.68, blue: 0.80, alpha: 1.00)))
            }
            .navigationTitle("Google Search")
        }
        .onAppear(perform: {
            getSearch()
        })
    }
    
    func getSearch() {
        let apiKey = "?rapidapi-key=0a1cfe84e9msh52abeacda017807p1a74c5jsn30e27789404c"
        let query = "https://google-search3.p.rapidapi.com/api/v1/search/q=olympics&num=100\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
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

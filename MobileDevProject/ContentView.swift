//
//  ContentView.swift
//  MobileDevProject
//
//  Created by Baptiste Keunebroek on 22/01/2024.
//

import SwiftUI

struct Record: Codable {
    var id: String
    var createdTime: String
    var fields: Fields
}



struct Fields: Codable {
    var Start: String
    var Location: String
    var Notes: String?
    var Activity: String
    var End: String
    var `Type`: String
    var Speaker: [String]?
}

struct Response: Codable {
    var records: [Record]
}

struct TalkRowView: View {
    var talk: Fields

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(talk.Activity)
                .font(.headline)
                .foregroundColor(.blue)

            HStack {
                Image(systemName: "location.circle")
                    .foregroundColor(.green)
                Text(talk.Location)
                    .font(.subheadline)
            }

            if let notes = talk.Notes, !notes.isEmpty {
                Text(notes)
                    .font(.caption)
                    .italic()
            }

            HStack {
                Text("Start: \(talk.Start)")
                Spacer()
                Text("End: \(talk.End)")
            }
            .font(.footnote)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding([.top, .horizontal])
    }
}




struct AllActivitiesView: View {
    @State private var allFields: [Fields] = []

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("All Program")) {
                    ForEach(allFields, id: \.Activity) { talk in
                        TalkRowView(talk: talk)
                    }
                }

               
            }
            .padding(.top, 0)
            .navigationTitle("All the Programs")
            .onAppear {
                NetworkManager().fetchTalks { fetchedTalks in
                    self.allFields = fetchedTalks
                }
            }
        }
    }
}

struct AllActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllActivitiesView()
    }
}


struct HomePageView: View {
    @State private var fields: [Fields] = []
    @State private var todayActivities: [Fields] = []

    var body: some View {
        NavigationView {
            List {
                if todayActivities.isEmpty {
                    Text("No activities today")
                        .font(.title)
                        .foregroundColor(.gray)
                } else {
                    Section(header: Text("Today's Program")
                                .font(.title2)
                                .foregroundColor(.green)) {
                        ForEach(todayActivities, id: \.Activity) { talk in
                            TalkRowView(talk: talk)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Security Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AllActivitiesView()) {
                        Text("All Activities")
                    }
                }
                
            }
            .onAppear(perform: fetchTodayTalks)
        }
    }


    private func fetchTodayTalks() {
        NetworkManager().fetchTalks { fetchedTalks in
            self.fields = fetchedTalks
            self.todayActivities = self.fields.filter { isToday(dateString: $0.Start) }
        }
    }

    private func isToday(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return false }

        return Calendar.current.isDateInToday(date)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}




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
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    .padding([.top, .horizontal])
                }
            }



struct AllActivitiesView: View {
    @State private var allFields: [Fields] = []

    var body: some View {
        List {
            Section(header: Text("All Program")) {
                ForEach(allFields, id: \.Activity) { talk in
                    TalkRowView(talk: talk)
                }
            }
        }
        .padding(.top, 0)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
            NetworkManager().fetchTalks { fetchedTalks in
                self.allFields = fetchedTalks
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
    @State private var nextActivityDate: String = ""

    var body: some View {
        List {
            ZStack {
                
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                
                if todayActivities.isEmpty {
                    VStack(spacing: 10) {
                        Text("No activities today")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Today's date: \(formattedTodayDate())")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        if !nextActivityDate.isEmpty {
                            Text("Next activity on \(nextActivityDate)")
                                .font(.headline)
                                .foregroundColor(.blue)
                        } else {
                            Text("No upcoming activities")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    
                } else {
                    activityList
                }
            }
        }
        .onAppear(perform: fetchTodayTalks)

    }

    private var activityList: some View {
        Section(header: Text("Today's Program")
                    .font(.title2)
                    .foregroundColor(.green)) {
            ForEach(todayActivities, id: \.Activity) { talk in
                TalkRowView(talk: talk)
            }
        }
    }

    private func fetchTodayTalks() {
        NetworkManager().fetchTalks { fetchedTalks in
            self.fields = fetchedTalks
            self.todayActivities = self.fields.filter { isToday(dateString: $0.Start) }
            determineNextActivityDate()
        }
    }

    private func determineNextActivityDate() {
        let sortedActivities = fields.filter { !isToday(dateString: $0.Start) }
                                      .sorted { $0.Start < $1.Start }
        if let nextActivity = sortedActivities.first {
            nextActivityDate = nextActivity.Start
        }
    }

    private func isToday(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return false }

        return Calendar.current.isDateInToday(date)
    }

    private func formattedTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}






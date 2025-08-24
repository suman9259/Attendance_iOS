//
//  HomeView.swift
//  Attendance
//
//  Created by Prince on 22/08/25.
//

import SwiftUI
import InteriorAbsherSDK

// MARK: - HomeView
struct HomeView: View, LocationDelegate {
    
    // MARK: - LocationDelegate
    /// Copied from old HomeVC Implementation
    func onLocationFetched(latitude: Double, longitude: Double) {
        print("latitude ::: \(latitude)  ::: \(longitude)")
    }
    
    // MARK: - Properties
    /// Tabs displayed at the top of the view.
    let tabs = ["mark attendance", "permission application"]
    
    /// View model responsible for fetching user data.
    private let viewmodel = HomeViewModel()
    
    /// User’s current shift name.
    @State private var shiftName: String = "Standard Shift"
    /// User’s current shift timing.
    @State private var shiftTime: String = "07:00 AM - 12:00 PM"

    /// Currently selected tab index.
    @State private var selectedTab: Int = 0
    /// Controls Punch Out full-screen view presentation.
    @State private var showPunchOut = false
    
    // MARK: - Body
    var body: some View {
        MOIBaseUIView(
            configuration: BaseUIConfiguration(
                headerType: .Small,
                headerImage: nil,
                title: "Time Attendance",
                onEditClicked: nil,
                onShareClicked: nil,
                onMenuClicked: { print("Menu tapped") },
                onTitleClicked: { print("Title tapped") },
                showNotification: false,
                showBack: true
            ),
            header: EmptyView(),
            footer: EmptyView()
        ) {
            VStack(spacing: 0) {
                
                // MARK: - Tab Selection
                MOITabView(tabs: self.tabs, selectedIndex: $selectedTab)
                    .frame(height: 60)
                    .padding(.top, -30)
                    .background(Color.background)
                
                // MARK: - Tab Content
                if selectedTab == 0 {
                    // Attendance tab
                    attendanceView
                    Spacer()
                } else if selectedTab == 1 {
                    // Permission application tab
                    Spacer()
                }
            }
        }
        .onAppear {
            // Fetch user’s assigned shift details on load
            viewmodel.authenticateUserApi { name, time in
                self.shiftName = name
                self.shiftTime = time
            }
        }
    }
    
    // MARK: - Attendance View
    /// UI shown when user selects "mark attendance" tab.
    private var attendanceView: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Text("Your Assigned Shift")
                .font(Typography.Small.bold)
                .foregroundColor(.black)
            
            Text(shiftName)
                .font(Typography.Small.regular)
                .foregroundColor(.gray)
            
            Text(shiftTime)
                .font(Typography.Small.regular)
                .foregroundColor(.yellow)
            
            HStack(spacing: 16) {
                // Punch In button
                Button(action: {
                    print("Punch In tapped")
                }) {
                    VStack {
                        Image("ic_punch_in")
                        Text("Punch in")
                            .font(Typography.XSmall.bold)
                    }
                }
                .buttonStyle(ThemeButtonStyle(dimens: .Large, colorStyle: .green(.solid)))
                
                // Punch Out button
                Button(action: {
                    print("Punch Out tapped")
                    showPunchOut = true
                }) {
                    VStack {
                        Image("ic_punch_out")
                        Text("Punch out")
                            .font(Typography.XSmall.bold)
                    }
                }
                .buttonStyle(ThemeButtonStyle(dimens: .Large, colorStyle: .gold(.solid)))
                .fullScreenCover(isPresented: $showPunchOut) {
                    PunchOutView()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.top, 16)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

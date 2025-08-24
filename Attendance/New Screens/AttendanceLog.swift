//
//  AttendanceLog.swift
//  Attendance
//
//  Created by Prince on 23/08/25.
//

import SwiftUI
import InteriorAbsherSDK

// MARK: - Data Model
/// Represents a single attendance record with punch-in/out details.
struct AttendanceLog: Identifiable {
    let id = UUID()
    let day: String
    let date: String
    let punchIn: String
    let punchOut: String
    let workingHours: String
}

// MARK: - Attendance Logs Screen
/// Displays a list of attendance logs with tab-based navigation.
struct AttendanceLogsView: View {
    
    // MARK: - Sample Data (mocked for now)
    let logs: [AttendanceLog] = [
        AttendanceLog(day: "الخميس", date: "15", punchIn: "09:15am", punchOut: "05:45pm", workingHours: "08h30m"),
        AttendanceLog(day: "الخميس", date: "15", punchIn: "09:15am", punchOut: "05:45pm", workingHours: "08h30m"),
        AttendanceLog(day: "الخميس", date: "15", punchIn: "09:15am", punchOut: "05:45pm", workingHours: "08h30m"),
        AttendanceLog(day: "الخميس", date: "15", punchIn: "09:15am", punchOut: "05:45pm", workingHours: "08h30m")
    ]
    
    // MARK: - Tabs
    let tabs = ["mark attendance", "permission application"]
    @State private var selectedTab: Int = 0
    
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
                
                // MARK: - Tab Navigation
                MOITabView(tabs: self.tabs, selectedIndex: $selectedTab)
                    .frame(height: 60)
                    .padding(.top, -30)
                    .background(Color.background)
                
                // MARK: - Tab Content
                if self.selectedTab == 0 {
                    // Attendance log screen
                    attendanceLogSection
                } else if selectedTab == 1 {
                    // Permission application screen
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Attendance Log Section
    private var attendanceLogSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Table Header
            HStack {
                Text("Date")
                    .frame(width: 80, alignment: .center)
                Text("punch in")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("punch out")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("working Hours")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(Typography.Small.bold)
            }
            .font(Typography.Small.bold)
            .foregroundColor(.black)
            .padding(.horizontal)
            
            // Table Rows
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(logs) { log in
                        AttendanceRow(log: log)
                    }
                }
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Row Component
    /// Displays a single attendance record row in the table.
    struct AttendanceRow: View {
        let log: AttendanceLog
        
        var body: some View {
            HStack(spacing: 12) {
                
                // Date Button (day + date)
                Button(action: {
                    print("datetapped")
                }) {
                    VStack {
                        Text(log.day)
                            .font(Typography.XSmall.bold)
                        Text(log.date)
                            .font(Typography.XSmall.bold)
                    }
                }
                .buttonStyle(ThemeButtonStyle(dimens: .Large, colorStyle: .green(.solid)))
                .frame(width: 80)
                
                // Punch In / Punch Out / Hours
                HStack(spacing: 4) {
                    // Punch In
                    HStack(spacing: 4) {
                        Image("punch_in_arrow")
                        Text(log.punchIn)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(Typography.XSmall.bold)
                    
                    Spacer()
                    
                    // Punch Out
                    HStack(spacing: 4) {
                        Image("punch_out_arrow")
                        Text(log.punchOut)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(Typography.XSmall.bold)
                    
                    Spacer()
                    
                    // Working Hours
                    Text(log.workingHours)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(Typography.XSmall.bold)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}

// MARK: - Preview
#Preview {
    AttendanceLogsView()
}

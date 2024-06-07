//
//  Todo_ListApp.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - manages single data point
 View - manages the UI
 ViewModel = manages data (models) for views
 
 */

@main
struct TodoListApp: App {
    
    // @StateObject ใช้สำหรับสร้างและเก็บ instance ของ ListViewModel ซึ่งจะถูกดำเนินการด้วย SwiftUI และจะไม่ถูกทำลายหรือสร้างใหม่เมื่อมีการอัปเดตหน้าวิว
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        
        // ใช้สร้างหน้าต่างหลักของแอปพลิเคชัน ซึ่งในที่นี้ใช้ NavigationView เป็นเนื้อหา และกำหนด
        WindowGroup {
            NavigationView {
                ListView()
            }
            // เพื่อให้ NavigationView ใช้รูปแบบการนำทางแบบ stack และใช้ environmentObject
            // เพื่อให้ ListViewModel สามารถเข้าถึงได้ในทุก ๆ วิวที่อยู่ภายใน NavigationView
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}

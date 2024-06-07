//
//  ListView.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import SwiftUI

// ประกาศ struct ชื่อ ListView ซึ่ง conform กับโปรโตคอล View เพื่อสร้างมุมมองใน SwiftUI
struct ListView: View {
    
    // ใช้ @EnvironmentObject เพื่อเข้าถึง ListViewModel ที่แชร์ข้อมูลระหว่างมุมมองต่างๆ
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        
        // ใช้ ZStack เพื่อซ้อนทับมุมมองหลายๆ ชั้น
        ZStack {
            
            // ตรวจสอบว่ารายการใน listViewModel.items ว่างหรือไม่
            if listViewModel.items.isEmpty {
                
                // ถ้าใช่ แสดง NoItemsView() พร้อมกับการเปลี่ยนผ่านแบบ opacity
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
                
            // ถ้าไม่ใช่ แสดงรายการในรูปแบบ List
            } else {
                List {
                    
                    // วนซ้ำผ่าน listViewModel.items เพื่อแสดง ListRowView สำหรับแต่ละรายการ
                    ForEach(listViewModel.items) { item in
                        
                        // แสดง ListRowView สำหรับรายการแต่ละรายการ
                        ListRowView(item: item)
                        
                            // กำหนดการกระทำเมื่อกดที่รายการ
                            .onTapGesture {
                                
                                // ใช้ withAnimation(.linear) เพื่อทำให้การอัปเดตสถานะของรายการมีการเปลี่ยนผ่านแบบ linear
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    // กำหนดการกระทำเมื่อมีการลบรายการ
                    .onDelete(perform: listViewModel.deleteItem)
                    
                    // กำหนดการกระทำเมื่อมีการย้ายตำแหน่งของรายการ
                    .onMove(perform: listViewModel.moveItem)
                }
                // แสดงผลรายการแบบเรียบง่าย ไม่มีเส้นแบ่งระหว่างกลุ่มรายการ
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        
        // กำหนดปุ่มใน Navigation Bar
        .navigationBarItems(
            
            // แสดงปุ่ม Edit สำหรับแก้ไขรายการ
            leading: EditButton(),
            
            // แสดงปุ่ม Add ที่นำไปยังมุมมอง AddView
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    // ส่งผ่าน ListViewModel เป็น EnvironmentObject
    .environmentObject(ListViewModel())
}

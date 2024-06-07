//
//  ListRowView.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import SwiftUI

struct ListRowView: View {
    
    // ประกาศตัวแปรคงที่ item ซึ่งเป็น ItemModel เพื่อใช้แสดงข้อมูลในแต่ละแถวของรายการ
    let item: ItemModel
    
    var body: some View {
        
        //จัดเรียงองค์ประกอบภายในแนวนอน
        HStack {
            
            // แสดงไอคอน ถ้า item.isCompleted เป็น true จะแสดงไอคอน "checkmark.circle" ถ้า false จะแสดงไอคอน "circle"
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
            
                // กำหนดสีของไอคอน ถ้า item.isCompleted เป็น true สีจะเป็นสีเขียว ถ้า false สีจะเป็นสีแดง
                .foregroundColor(item.isCompleted ? .green : .red)
            
            // แสดงข้อความของรายการ
            Text(item.title)
            
            // สร้างช่องว่างเพื่อดันเนื้อหาให้อยู่ทางซ้าย
            Spacer()
        }
        // กำหนดขนาดของฟอนต์
        .font(.title2)
        
        // กำหนดการเว้นระยะห่างแนวตั้ง 8 พิกเซล
        .padding(.vertical, 8)
    }
}

// ประกาศ struct สำหรับการแสดงตัวอย่างมุมมอง ListRowView
struct ListRowView_Previews: PreviewProvider {
    
    // ประกาศตัวแปรคงที่ item1 ที่เป็น ItemModel ซึ่งมี title เป็น "First item!" และ isCompleted เป็น false
    static var item1 = ItemModel(title: "First item!", isCompleted: false)
    
    // ประกาศตัวแปรคงที่ item2 ที่เป็น ItemModel ซึ่งมี title เป็น "Second Item." และ isCompleted เป็น true
    static var item2 = ItemModel(title: "Second Item.", isCompleted: true)
    
    // คำนิยามของมุมมองตัวอย่าง
    static var previews: some View {
        
        // กลุ่มของมุมมองตัวอย่าง
        Group {
            
            // แสดงตัวอย่าง ListRowView โดยใช้ข้อมูลจาก item1
            ListRowView(item: item1)
            
            // แสดงตัวอย่าง ListRowView โดยใช้ข้อมูลจาก item2
            ListRowView(item: item2)
        }
        
        //กำหนดให้ตัวอย่างมุมมองปรับขนาดให้พอดีกับเนื้อหาภายใน
        .previewLayout(.sizeThatFits)
        
    }
}

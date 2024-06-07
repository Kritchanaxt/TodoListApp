//
//  NoItemsView.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import SwiftUI

// นำเข้าไลบรารี SwiftUI และประกาศ struct ที่ชื่อ NoItemsView ซึ่ง conform กับโปรโตคอล View เพื่อสร้างมุมมองใน SwiftUI
struct NoItemsView: View {
    
    // ประกาศตัวแปรสถานะ animate เพื่อใช้ควบคุมการทำแอนิเมชัน
    @State var animate: Bool = false
    
    // ประกาศค่าคงที่ secondaryAccentColor ที่กำหนดให้เป็นสีที่ดึงมาจาก Assets
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        
        // มุมมองแบบเลื่อนที่บรรจุองค์ประกอบภายใน
        ScrollView {
            
            // จัดเรียงองค์ประกอบในแนวตั้งโดยมีระยะห่างระหว่างองค์ประกอบ 10
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom)
                
                // ปุ่มที่จะแสดงข้อความและลิงก์ไปยัง AddView เพื่อเพิ่มรายการใหม่
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("Add Something 🥳")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(26)
                    })
                
                // การปรับแต่งการเว้นระยะห่างตามแนวนอน
                .padding(.horizontal, animate ? 30 : 50)
                
                // การปรับแต่งเงาของปุ่ม
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
                
                // การปรับแต่งขนาดของปุ่ม
                .scaleEffect(animate ? 1.1 : 1.0)
                
                // การปรับตำแหน่งปุ่มในแนวตั้ง
                .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth:  400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        
        // การกำหนดให้มุมมองยืดขยายเต็มพื้นที่ที่สามารถใช้งานได้
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        
        // ตรวจสอบสถานะ animate หากเป็น true ให้หยุดการทำงาน
        guard !animate else { return }
        
        // หน่วงเวลา 1.5 วินาทีแล้วค่อยทำการแอนิเมชัน
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            // กำหนดแอนิเมชันด้วยเอฟเฟกต์ easeOut นาน 2 วินาทีและทำซ้ำตลอดไป
            withAnimation(
                Animation
                    .easeOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    
    // แสดงตัวอย่างมุมมอง NoItemsView ภายใน NavigationView พร้อมกับตั้งชื่อ navigationTitle เป็น "Title"
    NavigationView {
        NoItemsView()
            .navigationTitle("Title")
    }
}

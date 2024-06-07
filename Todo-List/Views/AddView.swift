//
//  AddView.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import SwiftUI

// ประกาศ struct ชื่อ AddView ซึ่ง conform กับโปรโตคอล View เพื่อสร้างมุมมองใน SwiftUI
struct AddView: View {
    
    // MARK: PROPERTIES
    
    // ใช้ @Environment เพื่อจัดการกับการนำเสนอและการยกเลิกมุมมองปัจจุบัน
    @Environment(\.presentationMode) var presentationMode
    
    // ใช้ @EnvironmentObject เพื่อเข้าถึง ListViewModel ที่แชร์ข้อมูลระหว่างมุมมองต่างๆ
    @EnvironmentObject var listViewModel: ListViewModel
    
    // สร้างตัวแปรสถานะ textFieldText เพื่อเก็บข้อความจาก TextField
    @State var textFieldText: String = ""
    
    // สร้างตัวแปรสถานะ alertTitle เพื่อเก็บข้อความของ Alert
    @State var alertTitle: String = ""
    
    // สร้างตัวแปรสถานะ showAlert เพื่อควบคุมการแสดง Alert
    @State var showAlert: Bool = false
    
    // MARK: BODY
    
    var body: some View {
        ScrollView {
            VStack {
                
                // สร้าง TextField ให้ผู้ใช้สามารถป้อนข้อความได้ โดยเชื่อมโยงกับ textFieldText
                TextField("Type somting here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                // สร้างปุ่มที่มีการกระทำเมื่อกดปุ่มคือ saveButtonPressed
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                    
                        // กำหนดความกว้างสูงสุดของปุ่มให้เต็มพื้นที่
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            // กำหนดการเว้นระยะห่างของ VStack 14
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        
        //กำหนดให้แสดง Alert เมื่อ showAlert เป็น true
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    // MARK: FUNCTIONS
    
    func saveButtonPressed() {
        
        /*
         ถ้า textIsAppropriate() คืนค่าเป็น true ให้เรียก listViewModel.addItem(title: textFieldText)
         เพื่อเพิ่มรายการใหม่ใน ListViewModel และยกเลิกการนำเสนอหน้าโดยเรียก presentationMode.wrappedValue.dismiss()
         */
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // ตรวจสอบความยาวของข้อความใน textFieldText
    func textIsAppropriate() -> Bool {
        
        // ถ้าข้อความน้อยกว่า 3 ตัวอักษร จะกำหนดข้อความของ alertTitle และสลับสถานะของ showAlert เป็น true เพื่อแสดง Alert
        if textFieldText.count < 3 {
            alertTitle = "You new todo item must be at least 3 character long!!! 😱😨😰"
            showAlert.toggle()
            return false
        }
        
        // การใช้ return ทำให้ฟังก์ชันสามารถส่งค่ากลับและสิ้นสุดการทำงานได้ทันที เมื่อมีเงื่อนไขที่ตรงตามเงื่อนไขที่กำหนด
        return true
    }
    
    //  คืนค่า Alert ที่มีข้อความจาก alertTitle
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

// MARK: RREVIEW

#Preview {
    Group {
        // แสดง AddView ใน NavigationView
        NavigationView {
            AddView()
        }
        
        // กำหนดธีมของมุมมองเป็นแบบสว่าง
        .preferredColorScheme(.light)
        
        // ส่งผ่าน ListViewModel เป็น EnvironmentObject
        .environmentObject(ListViewModel())
        
    }
}

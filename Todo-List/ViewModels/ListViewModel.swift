//
//  ListViewModel.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import Foundation

/*
 CRUD FUNCTIONS:
 
 Create
 Read
 Updata
 Delete
 
 */

// ประกาศคลาส ListViewModel ที่ conform กับโปรโตคอล ObservableObject เพื่อให้สามารถใช้ร่วมกับ SwiftUI ในการแจ้งเตือนการเปลี่ยนแปลงของข้อมูลให้กับ UI
class ListViewModel: ObservableObject {
    
    // ประกาศตัวแปร items ซึ่งเป็นอาร์เรย์ของ ItemModel:
    // @Published: ระบุว่าตัวแปรนี้จะส่งการแจ้งเตือนเมื่อค่ามีการเปลี่ยนแปลง ทำให้ SwiftUI สามารถอัปเดต UI ได้อัตโนมัติ 
    @Published var items: [ItemModel] = [] {
        
        // เรียกฟังก์ชัน saveItems ทุกครั้งที่ items มีการเปลี่ยนแปลง เพื่อบันทึกข้อมูล
        didSet {
            saveItems()
        }
    }
    
    // ประกาศค่าคงที่ itemsKey เพื่อใช้เป็นคีย์ในการจัดเก็บและดึงข้อมูลจาก UserDefaults
    let itemsKey: String = "items_list"
    
    // เรียกฟังก์ชัน getItems เมื่อตัวแปร ListViewModel ถูกสร้างขึ้นมา เพื่อดึงข้อมูลที่จัดเก็บไว้ใน UserDefaults มาใช้
    init() {
        getItems()
    }
    
    func getItems() {
        
        // ใช้ guard เพื่อดึงข้อมูลที่จัดเก็บไว้ใน UserDefaults ด้วยคีย์ itemsKey
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            
                // ใช้ JSONDecoder เพื่อถอดรหัสข้อมูลที่จัดเก็บในรูปแบบ JSON กลับมาเป็นอาร์เรย์ของ ItemModel
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        // ถ้าสามารถดึงข้อมูลและถอดรหัสได้สำเร็จ จะกำหนดค่าให้กับ items
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet){
        
        // ลบ item ที่ตำแหน่งที่กำหนดใน indexSet จากอาร์เรย์ items
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        
        // ย้าย item จากตำแหน่งที่กำหนดใน from ไปยังตำแหน่ง to ในอาร์เรย์ items
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        
        // สร้าง instance ใหม่ของ ItemModel ด้วย title ที่ระบุและ isCompleted เป็น false
        let newItem = ItemModel(title: title, isCompleted: false)
        
        // เพิ่ม item ใหม่เข้าไปในอาร์เรย์ items
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        // หา index ของ item ที่ต้องการอัปเดตในอาร์เรย์ items โดยใช้ id
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            
            // ถ้าพบ item ที่ต้องการอัปเดต จะสลับค่าของ isCompleted โดยเรียก updateCompletion และกำหนดค่าใหม่ให้กับ item นั้นในอาร์เรย์
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        
        // ใช้ JSONEncoder เพื่อเข้ารหัสอาร์เรย์ items เป็นข้อมูล JSON
        if let encodedData = try? JSONEncoder().encode(items) {
            
            // ถ้าสามารถเข้ารหัสได้สำเร็จ จะจัดเก็บข้อมูล JSON นั้นลงใน UserDefaults ด้วยคีย์ itemsKey
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

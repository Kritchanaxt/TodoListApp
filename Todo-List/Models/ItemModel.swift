//
//  ItemModel.swift
//  Todo-List
//
//  Created by Kritchanat on 7/6/2567 BE.
//

import Foundation

// Immutable Struct has only 'let' constants
/*
 MARK: struct ItemModel:
 - Identifiable: ช่วยให้สามารถระบุแต่ละ instance ของ struct ได้ด้วยค่าที่ไม่ซ้ำกัน (id)
 - Codable: เป็นโปรโตคอลที่รวม Encodable และ Decodable เพื่อช่วยในการเข้ารหัสและถอดรหัสข้อมูล (เช่น การแปลงเป็น JSON)
 */
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String // เป็นสตริงที่เก็บชื่อหรือรายละเอียดของ item
    let isCompleted: Bool // เป็นบูลีนที่ระบุว่า item นั้นเสร็จสิ้นแล้วหรือยัง
    
    /*
     
     MARK: ประกาศ initializer ซึ่งเป็นฟังก์ชันที่ใช้สำหรับสร้าง instance ของ ItemModel:
     - id: มีค่าเริ่มต้นเป็น UUID ใหม่ที่แปลงเป็นสตริง (UUID().uuidString), ถ้าไม่ใส่ค่าให้ id ก็จะใช้ค่าเริ่มต้นนี้
     title และ isCompleted: ต้องระบุค่าเมื่อสร้าง instance
     ภายใน initializer จะกำหนดค่าให้กับตัวแปร id, title, และ isCompleted ของ instance นั้นๆ
     
     */
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    /*
     MARK: ประกาศฟังก์ชัน updateCompletion ซึ่งไม่รับพารามิเตอร์และคืนค่าเป็น ItemModel:
     - ฟังก์ชันนี้สร้าง instance ใหม่ของ ItemModel โดยใช้ค่า id และ title เดิม แต่สลับค่าของ isCompleted (จาก true เป็น false หรือจาก false เป็น true)
     - return ItemModel(id: id, title: title, isCompleted: !isCompleted): คืนค่า instance ใหม่ที่มีการสลับค่าของ isCompleted
     */
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }


}


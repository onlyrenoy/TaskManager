//
//  TaskView.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 01/10/25.
//
import SwiftUI

struct TaskView: View {
    @State var item: TaskItem
    
    var body: some View {
        HStack {
            VStack {
                Text("\(item.title)")
                Text("category")
            }
            Spacer()
            Image(uiImage: .checkmark)
        }
        .padding()
    }
}

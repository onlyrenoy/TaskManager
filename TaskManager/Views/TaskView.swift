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
            VStack(alignment: .leading) {
                Text("\(item.title)")
                    .fontWeight(.semibold)
                Text("category")
            }
            Spacer()
            Image(uiImage: item.isDone ? .checkmark : .strokedCheckmark)
        }
        .padding()
    }
}

#Preview {
    TaskView(item: TaskItem(title: "test"))
}

import SwiftUI

struct TodoList: View {
    @State var todos: [Todo]
    
    var body: some View {
        List {
            ForEach (todos) { todo in
                TodoRow(todo: todo, done: .constant(false))
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(todos: [
            TodoFixtures.get(0),
            TodoFixtures.get(1),
        ])
    }
}

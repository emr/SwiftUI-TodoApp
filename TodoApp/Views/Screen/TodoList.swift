import SwiftUI

struct TodoList: View {
    @State var todos: [Todo]
    
    var body: some View {
        NavigationView {
            List {
                ForEach (todos) { todo in
                    NavigationLink(destination: TodoDetail(todo: todo)) {
                        TodoRow(todo: todo, done: .constant(false))
                    }
                }
            }
                .navigationBarTitle(Text("Todos"))
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

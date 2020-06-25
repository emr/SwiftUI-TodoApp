import SwiftUI

struct EventRow: View {
    var icon: Image
    var label: Text
    var value: Text
    var description: Text?
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                icon
                label
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                value
                if description != nil {
                    description!
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventRow(
                icon: Image(systemName: "bag.badge.plus"),
                label: Text("Label"),
                value: Text("Value with description"),
                description: Text("This row has both value and description")
            )
            EventRow(
                icon: Image(systemName: "bag.badge.plus"),
                label: Text("Label"),
                value: Text("Value without description")
            )
        }
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

import SwiftUI

struct EventRow: View {
    var icon: Image
    var label: String
    var value: String
    var description: String?
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                icon
                Text(label)
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(value)
                if description != nil {
                    Text(description!)
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
                label: "Label",
                value: "Value with description",
                description: "This row has both value and description"
            )
            EventRow(
                icon: Image(systemName: "bag.badge.plus"),
                label: "Label",
                value: "Value without description"
            )
        }
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

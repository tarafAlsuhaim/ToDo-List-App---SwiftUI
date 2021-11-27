
import SwiftUI

struct UpdateTaskyView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var tasky: Tasky? 
    @State var title: String = ""
    @State var descriptionToDo: String = ""
    @State var isFavorite: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(tasky: Tasky? = nil){
        self.tasky = tasky
        _title = State(initialValue: tasky?.title ?? "")
        _descriptionToDo = State(initialValue: tasky?.descriptionToDo ?? "")
        _isFavorite = State(initialValue: tasky?.isFavorite ?? false)
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 50){
                TextField("Enter title", text: $title)
                TextField("Enter description", text: $descriptionToDo)
                Toggle(isOn: $isFavorite) {}
                .labelsHidden()
                Button {
                    do {
                        if let tasky = tasky {
                            tasky.title = title
                            tasky.descriptionToDo = descriptionToDo
                            tasky.isFavorite = isFavorite
                            try viewContext.save()
                        }
                    } catch { }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Update Task")
                }.padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                
            }
        }
        
    }
}

struct UpdateTaskyView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManager.shared.persistantContainer
        
        UpdateTaskyView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}



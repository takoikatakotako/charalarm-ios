import Foundation

class AlarmDetailViewModel: ObservableObject {
    @Published var alarm: Alarm

    init(uid: String) {
        alarm = Alarm(uid: uid, token: "")
    }

    func saveButton() {
        AlarmStore.save(alarm: alarm) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

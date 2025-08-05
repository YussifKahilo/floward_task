import SwiftUI
import Flutter

struct ProfileView: View {
    @State private var showAlert = false
    @State private var feedbackMessage = ""
    @State private var hasSentData = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 20) {
                Text("User Profile")
                    .font(.title)
                    .bold()

                Image("profile_pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)

                Text("Yussif Kahilo").foregroundColor(.black)
                Text("yusufkahilo@icloud.com")

                if !hasSentData {
                    Button("Send user data to dashboard") {
                        MethodChannelManager.shared.sendUserData()
                        hasSentData = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            MethodChannelManager.shared.setFeedbackHandler { message in
               self.feedbackMessage = message
               self.showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Feedback from dashboard"),
                message: Text(feedbackMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
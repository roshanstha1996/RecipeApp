import SwiftUI
import CoreData

struct FavouriteListView: View {
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.favouriteViewModel.favourites) { favourite in
                    // Removed the NavigationLink to disable navigation
                    HStack {
                        if let imageURLString = favourite.strMealThumb,
                           let imageURL = URL(string: imageURLString) {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                default:
                                    Image("empty_image")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                }
                            }
                        } else {
                            // Placeholder image if no URL is available
                            Image("empty_image")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                        }

                        VStack(alignment: .leading) {
                            Text(favourite.strMeal ?? "NA")
                                .font(.headline)
                        }
                    } // End of HStack
                } // End of ForEach
                .onDelete { indexSet in
                    for index in indexSet {
                        let favourite = self.favouriteViewModel.favourites[index]
                        if self.favouriteViewModel.removeFavouriteById(idMeal: favourite.idMeal ?? "") {
                            self.alertTitle = "Success"
                            self.alertMessage = "Successfully removed from Favorites"
                        } else {
                            self.alertTitle = "Failure"
                            self.alertMessage = "Can't remove from Favorites"
                        }

                        self.showAlert = true
                    }
                } // End of onDelete
            } // End of List
            .navigationTitle("Favourites")
            .alert(isPresented: self.$showAlert) {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text("Okay"))
                )
            }
        }
        .onAppear {
            self.favouriteViewModel.fetchFavourites()
        }
    }
}

#Preview {
    FavouriteListView()
}

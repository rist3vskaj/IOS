

class WishMakerViewModel {
    
    // This could hold more properties as necessary, such as user wishes.
    
    // This can contain a method to be called when the button is pressed
    var addWishButtonTapped: (() -> Void)?

    func onAddWishButtonPressed() {
        addWishButtonTapped?()
    }
    
}

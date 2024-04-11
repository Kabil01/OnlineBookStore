$(document).ready(function() {
    // Load cart items and calculate total price
    loadCart();

    // Purchase button click event
    $("#purchase-button").click(function() {
        // Send an AJAX request to a servlet to process the purchase
        $.ajax({
            type: "POST",
            url: "ProcessPurchaseServlet", // Create a servlet to handle purchases
            dataType: "json",
            success: function(data) {
                if (data.success) {
                    alert("Purchase successful!"); // Show a success message
                    loadCart(); // Reload cart items after the purchase
                } else {
                    alert("Purchase failed. Please try again."); // Handle purchase failure
                }
            }
        });
    });

    // Function to load cart items and calculate total price
    function loadCart() {
        $.ajax({
            type: "GET",
            url: "GetCartItemsServlet", // Create a servlet to fetch cart items
            dataType: "json",
            success: function(data) {
                var cartItems = data.cartItems;
                var totalPrice = 0;

                // Clear the existing cart items
                $("#cart-items").empty();

                $.each(cartItems, function(index, item) {
                    // Create a div for each cart item
                    var cartItemDiv = $("<div class='cart-item'>");
                    cartItemDiv.append("<p>" + item.bookName + " - $" + item.price + "</p>");
                    cartItemDiv.append("<button class='remove-button' data-id='" + item.cartId + "'>Remove</button>");
                    $("#cart-items").append(cartItemDiv);

                    totalPrice += parseFloat(item.price);
                });

                // Update the total price
                $("#total-price").text(totalPrice.toFixed(2));

                // Remove button click event
                $(".remove-button").click(function() {
                    var cartId = $(this).data("id");
                    removeCartItem(cartId);
                });
            }
        });
    }

    // Function to remove a cart item
    function removeCartItem(cartId) {
        $.ajax({
            type: "POST",
            url: "RemoveCartItemServlet", // Create a servlet to remove cart items
            data: { cartId: cartId },
            success: function() {
                loadCart(); // Reload cart items after removal
            }
        });
    }
});

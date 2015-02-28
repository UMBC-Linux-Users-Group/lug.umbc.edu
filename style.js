// Enable the side navbar.
function navbarOn() {
    window.location.hash = "sidenav";
    $("#overlay").addClass("overlay-on");
}

// Disable the side navbar.
function navbarOff() {
    window.location.hash = " ";
    $("#overlay").removeClass("overlay-on");
}

$(function() {
    // Hide the side navbar by default.

    // Clicking anywhere in the document will close the navbar, except on the navbar itself.
    $("#overlay").click(function() {
      navbarOff();
    })
    $("#sidenav").click(function(e) {
      // Don't send the click event to the document if it landed on the navbar.
      e.stopPropagation();
    })

    // Bind the menu button to opening the navbar.
    $("#appbar-sidenav-toggle").click(function(e) {
      // Don't send the click onward past the button.
      navbarOn();
      e.stopPropagation();
    });
});

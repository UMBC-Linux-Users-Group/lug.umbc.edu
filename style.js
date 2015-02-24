// Enable the side navbar.
function navbarOn() {
    $("body").addClass("mui-overlay-on");
    $("#mui-overlay").show();
}

// Disable the side navbar.
function navbarOff() {
    $("body").removeClass("mui-overlay-on");
    $("#mui-overlay").hide();
}

$(function() {
    // Hide the side navbar by default.
    $("#mui-overlay").hide();

    // Clicking anywhere in the document will close the navbar, except on the navbar itself.
    $(document).click(function() {
      navbarOff();
    })
    $("#sidenav").click(function(e) {
      // Don't send the click event to the document if it landed on the navbar.
      e.stopPropagation();
      return false;
    })

    // Bind the menu button to opening the navbar.
    $("#appbar-sidenav-toggle").click(function(e) {
      // Don't send the click onward past the button.
      navbarOn();
      e.stopPropagation();
      return false;
    });
});

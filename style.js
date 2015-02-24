function navbarOn() {
    alert("Here");
    $("body").addClass("mui-overlay-on");
}

$(function() {
    $("#appbar-sidenav-toggle").click(navbarOn);
});

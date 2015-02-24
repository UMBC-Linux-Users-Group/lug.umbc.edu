function navbarOn() {
    $("body").addClass("mui-overlay-on");
    $("#mui-overlay").show();
}

function navbarOn() {
    $("body").removeClass("mui-overlay-on");
    $("#mui-overlay").hide();
}

$(function() {
    $("#mui-overlay").hide();
    $("#appbar-sidenav-toggle").click(navbarOn);
});

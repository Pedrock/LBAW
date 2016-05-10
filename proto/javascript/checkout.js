$("#same").change(function (e) {
    if (this.checked) {
        $("#billing_box").slideUp();
        $("#same_as_shipping").slideDown();
    } else {
        $("#billing_box").slideDown();
        $("#same_as_shipping").slideUp();
    }
});

function isNumeric(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
function isDecimal(evt) {
    var keyCode = evt.keyCode || evt.which;
    var char = String.fromCharCode(keyCode);

    // Allow digits and a single decimal point
    if (!char.match(/[0-9.]/)) {
        return false; // Block non-numeric characters and more than one dot
    }

    // Check if there's already a decimal point in the input
    var input = evt.target.value;
    if (char === "." && input.includes(".")) {
        return false; // Block additional decimal points
    }

    return true;
}
function isAlphaNumeric(e) { // Alphanumeric only
    var keyCode = e.keyCode || e.which;
    var regex = /^[a-zA-Z0-9\s]+$/;
    var isValid = regex.test(String.fromCharCode(keyCode));
    if (!isValid) {
        return isValid;
    }

    return isValid;
}
function isAlphaNumericSpecial(e) {
    var keyCode = e.keyCode || e.which;
    var char = String.fromCharCode(keyCode);

    // Allow alphanumeric characters, parentheses, and dot
    if (!char.match(/[a-zA-Z0-9().\s]/)) {
        e.preventDefault(); // Block the input if it doesn't match
        return false;
    }

    return true; // Allow the key press
}
function isPassword(e) {
    var keyCode = e.keyCode || e.which;
    var char = String.fromCharCode(keyCode);

    // Allow alphanumeric characters and special characters @, #, $, &, *, !
    if (!char.match(/[a-zA-Z0-9@#$&*!]/)) {
        e.preventDefault(); // Block the input if it doesn't match
        return false;
    }

    return true; // Allow the key press
}
function isAlphabet(evt) {
    var keyCode = (evt.which) ? evt.which : evt.keyCode
    if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

        return false;
    return true;
}
function isEmailId(e) {
    var keyCode = e.keyCode || e.which;
    var regex = /^[a-z0-9@.]+$/;
    var isValid = regex.test(String.fromCharCode(keyCode));
    if (!isValid) {
        //lblError.innerHTML = "Only Alphabets and Numbers allowed.";
    }

    return isValid;
}
function isDate(e) {
    var keyCode = e.keyCode || e.which;
    var regex = /^[0-9-]+$/;
    var isValid = regex.test(String.fromCharCode(keyCode));
    if (!isValid) {
        //lblError.innerHTML = "Only Alphabets and Numbers allowed.";
    }

    return isValid;
}
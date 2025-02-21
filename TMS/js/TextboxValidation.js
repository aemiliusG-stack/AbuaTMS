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
    var regex = /^[a-zA-Z0-9\s\/]+$/;
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
function validateAmountPaste(e) {
    // Get the clipboard data
    var clipboardData = e.clipboardData || window.clipboardData;
    var pastedText = clipboardData.getData('Text');

    // Define the allowed pattern (only numeric characters)
    var regex = /^[0-9]+$/;

    // Test the pasted text against the regex
    if (!regex.test(pastedText)) {
        e.preventDefault(); // Prevent the paste if it doesn't match the numeric pattern
        alert("Only numeric values are allowed.");
    }
}
function isNumericValueOnly(event) {
    debugger;
    var keyCode = event.keyCode || event.which;
    var key = String.fromCharCode(keyCode);
    // Allow backspace, delete, tab, and other control keys
    if (keyCode === 8 || keyCode === 9 || keyCode === 46 || keyCode === 37 || keyCode === 39) {
        return true;
    }
    // Prevent alphabetic characters (A-Z, a-z)
    if (/^[a-zA-Z]$/.test(key)) {
        return false;
    }
    // Allow only numeric and decimal point
    if (/^[0-9.]$/.test(key)) {
        var currentValue = event.target.value;

        // Ensure only one decimal point is allowed
        if (key === '.' && currentValue.indexOf('.') !== -1) {
            return false;
        }
        return true;
    }
    return false; // Block other keys
}function isDate(e) {
    var keyCode = e.keyCode || e.which;
    var regex = /^[0-9-]+$/;
    var isValid = regex.test(String.fromCharCode(keyCode));
    if (!isValid) {
        //lblError.innerHTML = "Only Alphabets and Numbers allowed.";
    }
    return isValid;
}
function validatePaste(e) {
    var clipboardData = e.clipboardData || window.clipboardData;
    var pastedText = clipboardData.getData('Text');
    var regex = /^[a-zA-Z0-9\s\/]+$/;
    if (!regex.test(pastedText)) {
        e.preventDefault();
        alert("Only alphanumeric characters and spaces are allowed.");
    }
}
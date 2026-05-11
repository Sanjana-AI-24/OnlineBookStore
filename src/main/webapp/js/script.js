// =========================================
// PageTurner Bookstore — Main JS
// =========================================

// ---- Form Validation ----
function validateRegisterForm() {
    let valid = true;
    clearErrors();

    const fullName = document.getElementById('fullName');
    const username = document.getElementById('username');
    const email    = document.getElementById('email');
    const phone    = document.getElementById('phone');
    const password = document.getElementById('password');
    const confirm  = document.getElementById('confirmPassword');

    if (!fullName || fullName.value.trim() === '') {
        showError('fullNameError', 'Full name is required.');
        markInvalid(fullName); valid = false;
    }

    if (!username || username.value.trim().length < 8) {
        showError('usernameError', 'Username must be at least 8 characters.');
        markInvalid(username); valid = false;
    }

    if (!email || !isValidEmail(email.value.trim())) {
        showError('emailError', 'Please enter a valid email address (must contain @ and .).');
        markInvalid(email); valid = false;
    }

    if (!phone || !/^\d{10}$/.test(phone.value.trim())) {
        showError('phoneError', 'Phone number must be exactly 10 digits.');
        markInvalid(phone); valid = false;
    }

    if (!password || password.value.length < 6) {
        showError('passwordError', 'Password must be at least 6 characters.');
        markInvalid(password); valid = false;
    }

    if (!confirm || confirm.value !== password.value) {
        showError('confirmError', 'Passwords do not match.');
        markInvalid(confirm); valid = false;
    }

    return valid;
}

function validateLoginForm() {
    let valid = true;
    clearErrors();

    const username = document.getElementById('username');
    const password = document.getElementById('password');

    if (!username || username.value.trim() === '') {
        showError('usernameError', 'Username is required.');
        markInvalid(username); valid = false;
    }
    if (!password || password.value === '') {
        showError('passwordError', 'Password is required.');
        markInvalid(password); valid = false;
    }
    return valid;
}

function validateCheckoutForm() {
    let valid = true;
    clearErrors();

    const address = document.getElementById('address');
    const phone   = document.getElementById('checkoutPhone');

    if (!address || address.value.trim().length < 10) {
        showError('addressError', 'Please enter a complete address (at least 10 characters).');
        markInvalid(address); valid = false;
    }
    if (!phone || !/^\d{10}$/.test(phone.value.trim())) {
        showError('phoneError', 'Phone number must be exactly 10 digits.');
        markInvalid(phone); valid = false;
    }
    return valid;
}

// Helpers
function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
function showError(id, msg) {
    const el = document.getElementById(id);
    if (el) { el.textContent = msg; el.classList.add('show'); }
}
function markInvalid(el) {
    if (el) el.classList.add('invalid');
}
function clearErrors() {
    document.querySelectorAll('.field-error').forEach(e => e.classList.remove('show'));
    document.querySelectorAll('.invalid').forEach(e => e.classList.remove('invalid'));
}

// ---- Real-time input feedback ----
document.addEventListener('DOMContentLoaded', function () {

    const usernameInput = document.getElementById('username');
    if (usernameInput && document.getElementById('usernameError')) {
        usernameInput.addEventListener('input', function () {
            if (this.value.length > 0 && this.value.length < 8) {
                showError('usernameError', 'Username must be at least 8 characters.');
                markInvalid(this);
            } else {
                clearFieldError('usernameError', this);
            }
        });
    }

    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('input', function () {
            if (this.value.length > 3 && !isValidEmail(this.value)) {
                showError('emailError', 'Must contain @ and a valid domain.');
                markInvalid(this);
            } else {
                clearFieldError('emailError', this);
            }
        });
    }

    const phoneInput = document.getElementById('phone');
    if (phoneInput) {
        phoneInput.addEventListener('input', function () {
            this.value = this.value.replace(/\D/g, '').slice(0, 10);
        });
    }

    const checkoutPhone = document.getElementById('checkoutPhone');
    if (checkoutPhone) {
        checkoutPhone.addEventListener('input', function () {
            this.value = this.value.replace(/\D/g, '').slice(0, 10);
        });
    }

    const confirm = document.getElementById('confirmPassword');
    const pass    = document.getElementById('password');
    if (confirm && pass) {
        confirm.addEventListener('input', function () {
            if (this.value && this.value !== pass.value) {
                showError('confirmError', 'Passwords do not match.');
                markInvalid(this);
            } else {
                clearFieldError('confirmError', this);
            }
        });
    }
});

function clearFieldError(errorId, input) {
    const el = document.getElementById(errorId);
    if (el) el.classList.remove('show');
    if (input) input.classList.remove('invalid');
}

// ---- Cart quantity update helper ----
function updateQty(bookId, delta) {
    const input = document.getElementById('qty-' + bookId);
    if (!input) return;
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    if (val > 99) val = 99;
    input.value = val;
}

// ---- Confirm delete ----
function confirmDelete(msg) {
    return confirm(msg || 'Are you sure you want to delete this item?');
}

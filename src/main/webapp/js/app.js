function closeAlert(button) {
    const alert = button.closest('.alert');
    if (alert) {
        alert.style.display = 'none';
    }
}

function openModalById(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.add('show');
    }
}

function closeModalById(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.remove('show');
    }
}

function confirmDelete(url, name) {
    const link = document.getElementById('deleteLink');
    const label = document.getElementById('deleteName');

    if (link) {
        link.href = url;
    }

    if (label) {
        label.textContent = name;
    }

    openModalById('deleteModal');
}

function selectRole(role) {
    const input = document.getElementById('roleInput');
    const admin = document.getElementById('roleAdmin');
    const student = document.getElementById('roleStudent');

    if (input) input.value = role;
    if (admin) admin.classList.toggle('active', role === 'ADMIN');
    if (student) student.classList.toggle('active', role === 'STUDENT');
}

function togglePassword() {
    const field = document.getElementById('passwordField');
    const icon = document.getElementById('eyeIcon');

    if (!field) return;

    if (field.type === 'password') {
        field.type = 'text';
        if (icon) icon.className = 'bi bi-eye-slash';
    } else {
        field.type = 'password';
        if (icon) icon.className = 'bi bi-eye';
    }
}

document.addEventListener('click', function (event) {
    const closeButton = event.target.closest('[data-dismiss="modal"], [data-bs-dismiss="modal"]');
    if (closeButton) {
        const modal = closeButton.closest('.modal');
        if (modal) {
            modal.classList.remove('show');
        }
    }

    const dismissAlert = event.target.closest('.btn-close');
    if (dismissAlert && dismissAlert.closest('.alert')) {
        closeAlert(dismissAlert);
    }


});

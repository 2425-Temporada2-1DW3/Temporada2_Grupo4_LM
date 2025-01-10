document.getElementById('contacto-form').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const nombre = document.getElementById('nombre').value;
    const email = document.getElementById('email').value;
    const mensaje = document.getElementById('mensaje').value;
    
    console.log('Nombre:', nombre);
    console.log('Email:', email);
    console.log('Mensaje:', mensaje);
    
    // Vaciar los campos del formulario
    document.getElementById('nombre').value = '';
    document.getElementById('email').value = '';
    document.getElementById('mensaje').value = '';
    
    // Crear y mostrar el mensaje de éxito
    const successMessage = document.createElement('div');
    successMessage.classList.add('success-message');
    successMessage.innerHTML = `
        <span class="close-btn">&times;</span>
        <p>Formulario enviado con éxito</p>
    `;
    document.body.appendChild(successMessage);
    
    // Añadir evento para cerrar el mensaje
    document.querySelector('.close-btn').addEventListener('click', function() {
        successMessage.remove();
    });
});
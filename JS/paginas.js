document.addEventListener("DOMContentLoaded", () => {
  const enlaces = document.querySelectorAll("nav a");
  const contenido = document.getElementById("contenido");
  const navLinks = document.querySelectorAll('nav ul li a');

  enlaces.forEach(enlace => {
    enlace.addEventListener("click", (e) => {
      e.preventDefault();
      const pagina = enlace.getAttribute("data-page");
      cargarPagina(pagina);
      contenido.setAttribute('data-page', pagina); // Actualiza el atributo data-page
      updateActiveLink(); // Llama a la función para actualizar el enlace activo
    });
  });

  function cargarPagina(pagina) {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", `PAGINAS/${pagina}.html`, true);
    xhr.onload = () => {
      if (xhr.status === 200) {
        contenido.innerHTML = xhr.responseText;
      } else {
        contenido.innerHTML = "<h1>Error al cargar la página</h1>";
      }
    };
    xhr.onerror = () => {
      contenido.innerHTML = "<h1>Error en la solicitud AJAX</h1>";
    };
    xhr.send();
  }

  function updateActiveLink() {
    const currentPage = contenido.getAttribute('data-page');
    navLinks.forEach(link => {
      if (link.getAttribute('data-page') === currentPage) {
        link.classList.add('active');
      } else {
        link.classList.remove('active');
      }
    });
  }

  // Cargar la página por defecto
  cargarPagina("inicio");
  contenido.setAttribute('data-page', 'inicio'); // Establece la página por defecto
  updateActiveLink(); // Llama a la función para actualizar el enlace activo
});
document.addEventListener("DOMContentLoaded", () => {
    const enlaces = document.querySelectorAll("nav a");
    const contenido = document.getElementById("contenido");
  
    enlaces.forEach(enlace => {
      enlace.addEventListener("click", (e) => {
        e.preventDefault();
        const pagina = enlace.getAttribute("data-page");
        cargarPagina(pagina);
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
  
    // Cargar la página por defecto
    cargarPagina("inicio");
  });
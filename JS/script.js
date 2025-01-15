document.addEventListener("DOMContentLoaded", () => {
    document.getElementById('year').textContent = new Date().getFullYear();

    const enlaces = document.querySelectorAll("nav a");
    const contenido = document.getElementById("contenido");
    const navLinks = document.querySelectorAll('nav ul li a');

    let temporadaSeleccionada = 'Activa';

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
        xhr.open("GET", `${pagina}.html`, true);
        xhr.onload = () => {
            if (xhr.status === 200) {
                contenido.innerHTML = xhr.responseText;
                if (pagina === "equipos" || pagina === "clasificacion") {
                    cargarXSL(pagina); // Cargar y aplicar XSL después de cargar el HTML
                }
            } else {
                contenido.innerHTML = "<h1>Error al cargar la página</h1>";
            }
        };
        xhr.onerror = () => {
            contenido.innerHTML = "<h1>Error en la solicitud AJAX</h1>";
        };
        xhr.send();
    }

    function cargarXSL(pagina) {
        const xslFile = `XML/${pagina}.xsl`;
        const xmlFile = "XML/temporadas.xml";
        
        const xsltProcessor = new XSLTProcessor();
        const outputDiv = document.getElementById("contenido");
        
        // Cargar el archivo XSL
        fetch(xslFile)
            .then(response => response.text())
            .then(xslText => {
                const parser = new DOMParser();
                const xslDoc = parser.parseFromString(xslText, "application/xml");
                xsltProcessor.importStylesheet(xslDoc);
        
                if (pagina === "equipos" || pagina === "clasificacion") {
                    return fetch(xmlFile)
                        .then(response => response.text())
                        .then(xmlText => {
                            const parser = new DOMParser();
                            const xmlDoc = parser.parseFromString(xmlText, "application/xml");
    
                            if (temporadaSeleccionada === 'Activa') {
                                const xpathResult = xmlDoc.evaluate(
                                    "//temporada[estado='Activa']/nombre", 
                                    xmlDoc, 
                                    null, 
                                    XPathResult.FIRST_ORDERED_NODE_TYPE, 
                                    null
                                );
                                const activaTemporada = xpathResult.singleNodeValue;
                                if (activaTemporada) {
                                    temporadaSeleccionada = activaTemporada.textContent;
                                }
                            }
    
                            xsltProcessor.setParameter(null, "temporadaSeleccionada", temporadaSeleccionada);
        
                            return xmlDoc;
                        });
                }
            })
            .then(xmlDoc => {
                const resultDocument = xsltProcessor.transformToFragment(xmlDoc, document);
        
                outputDiv.innerHTML = "";
                outputDiv.appendChild(resultDocument);
        
                configurarCambioTemporada(pagina);
                agregarEventosEquipos();  // Añadir los eventos de clic para los equipos
            })
            .catch(error => {
                console.error("Error cargando XSL/XML:", error);
            });
    }

    function configurarCambioTemporada(pagina) {
        const temporadaSelect = document.getElementById("temporadaSelect");
        if (temporadaSelect) {
            temporadaSelect.value = temporadaSeleccionada;
    
            temporadaSelect.addEventListener("change", (e) => {
                const nuevaTemporada = e.target.value;
                temporadaSeleccionada = nuevaTemporada;
                cargarXSL(pagina);
            });
        }
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

    function mostrarDetallesEquipo(nombreEquipo) {
        document.getElementById('equipos').style.display = 'none';
        document.querySelector('.temporada-header').style.display = 'none';
    
        const detallesEquipo = document.getElementById('detalle-' + nombreEquipo);
        if (detallesEquipo) {
            detallesEquipo.style.display = 'block';
        }
    }

    function agregarEventosEquipos() {
        // Asignar eventos de clic a los equipos
        const equipos = document.querySelectorAll('.equipo');
        equipos.forEach(equipo => {
            equipo.addEventListener('click', () => {
                const nombreEquipo = equipo.querySelector('strong').textContent;
                mostrarDetallesEquipo(nombreEquipo);
            });
        });
    }

    // Cargar la página por defecto
    cargarPagina("inicio");
    contenido.setAttribute('data-page', 'inicio'); // Establece la página por defecto
    updateActiveLink(); // Llama a la función para actualizar el enlace activo

    // FORMULARIO DE CONTACTO
    if (document.body.classList.contains('contacto')) {
        const form = document.getElementById('contacto-form');

        // Agregamos el evento submit
        form.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevenimos el comportamiento por defecto del formulario

            // Mostramos la alerta
            alert('¡Hemos recibido tu mensaje! Recibirás una respuesta a la mayor brevedad posible.');

            // Limpiamos los campos del formulario
            form.reset();
        });
    }
});

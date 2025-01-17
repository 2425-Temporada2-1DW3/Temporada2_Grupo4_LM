document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('year').textContent = new Date().getFullYear();

    const enlaces = document.querySelectorAll("nav a");
    const contenido = document.getElementById("contenido");
    const navLinks = document.querySelectorAll('nav ul li a');

    let temporadaSeleccionada = 'Activa';
    let jornadaSeleccionada = '1';

    enlaces.forEach(enlace => {
        enlace.addEventListener("click", (e) => {
            e.preventDefault();
            const pagina = enlace.getAttribute("data-page");
            cargarPagina(pagina);
            contenido.setAttribute('data-page', pagina); // Actualiza el atributo data-page
            updateActiveLink(); // Llama a la función para actualizar el enlace activo
        });
    });

    function cargarPagina(pagina, equipoSeleccionado = null) {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", `${pagina}.html`, true);
        xhr.onload = () => {
            if (xhr.status === 200) {
                contenido.innerHTML = xhr.responseText;
                if (pagina === "equipos" || pagina === "clasificacion" || pagina === "calendario") {
                    cargarXSL(pagina, equipoSeleccionado); // Cargar y aplicar XSL después de cargar el HTML
                }

                if (pagina === "contacto") {
                    agregarEventosContacto();
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

    function cargarXSL(pagina, equipoSeleccionado = null) {
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
        
                if (pagina === "equipos" || pagina === "clasificacion" || pagina === "calendario") {
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
                            xsltProcessor.setParameter(null, "jornadaSeleccionada", jornadaSeleccionada);
        
                            return xmlDoc;
                        });
                }
            })
            .then(xmlDoc => {
                const resultDocument = xsltProcessor.transformToFragment(xmlDoc, document);
        
                outputDiv.innerHTML = "";
                outputDiv.appendChild(resultDocument);
        
                cambiarTemporada(pagina);
                cambiarJornada(pagina);
                agregarEventosEquipos();  // Añadir los eventos de clic para los equipos
                agregarEventosClasificacion();  // Añadir los eventos de clic para la clasificación

                if (equipoSeleccionado) {
                    mostrarDetallesEquipo(equipoSeleccionado);
                }
            })
            .catch(error => {
                console.error("Error al cargar el archivo XSL", error);
            });
    }

    function cambiarTemporada(pagina) {
        const temporadaSelect = document.getElementById("temporadaSelect");
        if (temporadaSelect) {
            temporadaSelect.value = temporadaSeleccionada;
    
            temporadaSelect.addEventListener("change", (e) => {
                const nuevaTemporada = e.target.value;
                temporadaSeleccionada = nuevaTemporada;
                cargarXSL(pagina, null);
            });
        }
    }

    function cambiarJornada(pagina) {
        const jornadaSelect = document.getElementById("jornadaSelect");
        if (jornadaSelect) {
            jornadaSelect.value = jornadaSeleccionada;
    
            jornadaSelect.addEventListener("change", (e) => {
                const nuevaJornada = e.target.value;
                jornadaSeleccionada = nuevaJornada;
                cargarXSL(pagina, null);
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
        const equipos = document.querySelectorAll('.equipo');
        equipos.forEach(equipo => {
            equipo.addEventListener('click', () => {
                const nombreEquipo = equipo.querySelector('strong').textContent;
                mostrarDetallesEquipo(nombreEquipo);
            });
        });
    }

    function agregarEventosClasificacion() {
        const enlacesEquipos = document.querySelectorAll('.enlace-clasificacion');
        enlacesEquipos.forEach(enlace => {
            enlace.addEventListener("click", (e) => {
                e.preventDefault();
                const pagina = enlace.getAttribute("data-page");
                const equipo = enlace.getAttribute("data-equipo");
    
                cargarPagina(pagina, equipo);

                contenido.setAttribute('data-page', pagina); // Actualiza el atributo data-page
                updateActiveLink(); // Llama a la función para actualizar el enlace activo
            });
        });
    }

    function agregarEventosContacto() {
        const form = document.getElementById('contacto-form');
        form.addEventListener('submit', function (event) {
            event.preventDefault(); // Prevenir envío
            alert('¡Hemos recibido tu mensaje! Recibirás una respuesta a la mayor brevedad posible.');
            form.reset(); // Limpiar campos
        });
    }

    // Cargar la página por defecto
    cargarPagina("inicio");
    contenido.setAttribute('data-page', 'inicio'); // Establece la página por defecto
    updateActiveLink(); // Llama a la función para actualizar el enlace activo
});

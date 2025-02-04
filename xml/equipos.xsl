<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:param name="temporadaSeleccionada" />
    <xsl:param name="equipoSeleccionado" />

    <xsl:template match="/">
        <div class="contenedor-equipos">
            <div class="temporada-header">
                <h1>Temporada <xsl:value-of select="$temporadaSeleccionada" /></h1>
                <div class="temporada-select">
                    <label for="temporadaSelect">Selecciona la Temporada:</label>
                    <select id="temporadaSelect">
                        <xsl:for-each select="temporadas/temporada">
                            <option value="{nombre}">
                                <xsl:choose>
                                    <xsl:when test="nombre = $temporadaSeleccionada">
                                        <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:value-of select="nombre" />
                            </option>
                        </xsl:for-each>
                    </select>
                </div>
            </div>

            <!-- Lista de equipos -->
            <div class="equipos" id="equipos">
                <xsl:choose>
                    <xsl:when test="count(temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo) > 0">
                        <xsl:for-each select="temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo">
                            <div class="equipo" tabindex="0">
                                <img class="logo" src="img/temporadas/Temporada {$temporadaSeleccionada}/{nombre}/{nombre}.png" alt="Logo del equipo" />
                                <strong><xsl:value-of select="nombre" /></strong>
                            </div>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>No hay equipos disponibles.</p>
                    </xsl:otherwise>
                </xsl:choose>
            </div>

            <!-- Detalles de los equipos -->
            <xsl:for-each select="temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo">
                <div class="detalles-equipo" id="detalle-{nombre}" style="display: none;">
                    <div class="equipo-header">
                        <div class="equipo-logo">
                            <img src="img/temporadas/Temporada {$temporadaSeleccionada}/{nombre}/{nombre}.png" alt="Logo del equipo" />
                            <h1><xsl:value-of select="nombre" /></h1>
                        </div>
                        <div class="equipo-info">
                            <p><strong>Entrenador: </strong> <xsl:value-of select="entrenador" /></p>
                            <p><strong>Estadio: </strong> <xsl:value-of select="estadio" /></p>
                        </div>
                    </div>

                    <div class="jugadores">
                        <h2>Plantilla</h2>
                        <div class="jugadores-grid">
                            <xsl:for-each select="jugadores/jugador">
                                <xsl:variable name="rutaImagen" select="concat('img/temporadas/Temporada ', $temporadaSeleccionada, '/', ../../nombre, '/', nombre, ' ', apellidos, '.png')" />
                                
                                <xsl:message select="$rutaImagen" />

                                <div class="jugador">
                                    <img class="jugador-foto" src="{$rutaImagen}" alt="{nombre}" />
                                    <div class="jugador-info">
                                        <p><strong><xsl:value-of select="concat(nombre, ' ', apellidos)" /></strong></p>
                                        <p>Dorsal: <xsl:value-of select="dorsal" /></p>
                                        <p>Posición: <xsl:value-of select="posicion" /></p>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>

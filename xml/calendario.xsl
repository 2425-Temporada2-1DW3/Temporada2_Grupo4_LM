<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:param name="temporadaSeleccionada" />
    <xsl:param name="jornadaSeleccionada" select="1" />

    <xsl:template match="/">
        <div class="contenedor-calendario">
            <h1>Calendario</h1>

            <!-- Selector de temporadas -->
            <div class="temporada-jornada">
                <div class="temporada-selector">
                    <label for="temporadaSelect">Selecciona una temporada: </label>
                    <select id="temporadaSelect">
                        <xsl:for-each select="temporadas/temporada">
                            <option value="{nombre}">
                                <xsl:if test="estado = 'Activa' and not($temporadaSeleccionada)">
                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:if test="nombre = $temporadaSeleccionada">
                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="nombre" />
                            </option>
                        </xsl:for-each>
                    </select>
                </div>

                <!-- Selector de jornadas -->
                <xsl:choose>
                    <xsl:when test="count(temporadas/temporada[nombre = $temporadaSeleccionada or (estado = 'Activa' and not($temporadaSeleccionada))]/jornadas/jornada) > 0">
                        <!-- Mostrar selector de jornadas -->
                        <div class="jornada-selector">
                            <label for="jornadaSelect">Selecciona una jornada: </label>
                            <select id="jornadaSelect">
                                <xsl:for-each select="temporadas/temporada[nombre = $temporadaSeleccionada or (estado = 'Activa' and not($temporadaSeleccionada))]/jornadas/jornada">
                                    <option value="{numero}">
                                        <xsl:if test="numero = $jornadaSeleccionada">
                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        Jornada <xsl:value-of select="numero" />
                                    </option>
                                </xsl:for-each>
                            </select>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Si no hay jornadas, mostrar mensaje -->
                        <p>No se han encontrado datos para la temporada seleccionada.</p>
                    </xsl:otherwise>
                </xsl:choose>
            </div>

            <!-- Lista de partidos -->
            <xsl:for-each select="temporadas/temporada[nombre = $temporadaSeleccionada or (estado = 'Activa' and not($temporadaSeleccionada))]/jornadas/jornada[numero = $jornadaSeleccionada]/partidos/partido">
                <div class="partido">
                    <div class="detalles-partido">
                        <p><strong>Fecha: </strong> 
                            <xsl:value-of select="fecha" />
                        </p>
                        <p><strong>Hora: </strong> 
                            <xsl:value-of select="hora" />
                        </p>
                        <p><strong>Estadio: </strong>
                            <xsl:value-of select="/temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo[nombre = current()/equipo1]/estadio" />
                        </p>
                    </div>
                    <div class="calendario-equipos">
                        <a href="equipos.html" data-page="equipos" data-equipo="{equipo1}" class="enlace-clasificacion">
                            <img src="img/temporadas/Temporada {$temporadaSeleccionada}/{equipo1}/{equipo1}.png" alt="{equipo1}" />
                        </a>
                        <a href="equipos.html" data-page="equipos" data-equipo="{equipo1}" class="enlace-clasificacion">
                            <p><strong class="partido-equipos"><xsl:value-of select="equipo1" /></strong></p>
                        </a>
                        <p><strong class="partido-equipos">Vs.</strong></p>
                        <a href="equipos.html" data-page="equipos" data-equipo="{equipo2}" class="enlace-clasificacion">
                            <p><strong class="partido-equipos"><xsl:value-of select="equipo2" /></strong></p>
                        </a>
                        <a href="equipos.html" data-page="equipos" data-equipo="{equipo2}" class="enlace-clasificacion">
                            <img src="img/temporadas/Temporada {$temporadaSeleccionada}/{equipo2}/{equipo2}.png" alt="{equipo2}" />
                    </a>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>

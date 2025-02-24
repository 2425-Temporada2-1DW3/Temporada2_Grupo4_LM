<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <div class="contenedor-clasificacion">
            <h1>Clasificación de Equipos</h1>
            <div class="temporada-select">
                <label for="temporadaSelect">Selecciona la Temporada:</label>
                <select id="temporadaSelect">
                    <xsl:for-each select="temporadas/temporada[estado != 'En creación']">
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
            <xsl:choose>
                <xsl:when test="count(temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo) > 0">
                    <div class="clasificacion-contenido">
                        <table border="1">
                            <tr>
                                <th>Posición</th>
                                <th>Equipo</th>
                                <th title="Puntos">Ptos.</th>
                                <th title="Partidos jugados">PJ</th>
                                <th title="Partidos ganados">PG</th>
                                <th title="Partidos perdidos">PP</th>
                                <th title="Puntos a favor">PF</th>
                                <th title="Puntos en contra">PC</th>
                                <th title="Diferencia de puntos">DP</th>
                            </tr>

                            <xsl:for-each select="temporadas/temporada[nombre = $temporadaSeleccionada]/equipos/equipo">
                                <xsl:sort select="puntos" order="descending" data-type="number"/>
                                <xsl:sort select="DiferenciaPuntos" order="descending" data-type="number"/>
                                <xsl:sort select="PuntosFavor" order="descending" data-type="number"/>
                                
                                <tr>
                                    <td><xsl:value-of select="position()"/></td>
                                    <td>
                                        <div class="clasificacion-equipo">
                                            <a href="equipos.html" data-page="equipos" data-equipo="{nombre}" class="enlace-clasificacion">
                                                <img src="img/temporadas/Temporada {$temporadaSeleccionada}/{nombre}/{nombre}.png" alt="Logo de {nombre}" class="clasificacion-logo"/>
                                                <xsl:value-of select="nombre"/>
                                            </a>
                                        </div>
                                    </td>
                                    <td><xsl:value-of select="puntos"/></td>
                                    <td><xsl:value-of select="partidosJugados"/></td>
                                    <td><xsl:value-of select="partidosGanados"/></td>
                                    <td><xsl:value-of select="partidosPerdidos"/></td>
                                    <td><xsl:value-of select="puntosFavor"/></td>
                                    <td><xsl:value-of select="puntosContra"/></td>
                                    <td><xsl:value-of select="diferenciaPuntos"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <p>No se han encontrado resultados para la temporada seleccionada.</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
</xsl:stylesheet>

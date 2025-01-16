<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <div class="contenedor-clasificacion">
            <h1>Clasificación de Equipos</h1>
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

                    <xsl:for-each select="temporadas/temporada/equipos/equipo">
                        <xsl:sort select="puntos" order="descending" data-type="number"/>
                        <xsl:sort select="DiferenciaPuntos" order="descending" data-type="number"/>
                        <xsl:sort select="PuntosFavor" order="descending" data-type="number"/>
                        
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td>
                                <div class="clasificacion-equipo">
                                    <a href="equipos.html" data-page="equipos" data-equipo="{nombre}" class="enlace-clasificacion">
                                        <img src="img/temporadas/{$temporadaSeleccionada}/{nombre}/{nombre}.png" alt="Logo de {nombre}" class="clasificacion-logo"/>
                                        <xsl:value-of select="nombre"/>
                                    </a>
                                </div>
                            </td>
                            <td><xsl:value-of select="puntos"/></td>
                            <td><xsl:value-of select="PartidosJugados"/></td>
                            <td><xsl:value-of select="PartidosGanados"/></td>
                            <td><xsl:value-of select="PartidosPerdidos"/></td>
                            <td><xsl:value-of select="PuntosFavor"/></td>
                            <td><xsl:value-of select="PuntosContra"/></td>
                            <td><xsl:value-of select="DiferenciaPuntos"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>

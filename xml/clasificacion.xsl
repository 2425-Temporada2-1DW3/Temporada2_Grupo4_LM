<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <div class="clasificacion-contenido">
            <h1>Clasificación de Equipos</h1>
            <table border="1">
                <tr>
                    <th>Posición</th>
                    <th>Equipo</th>
                    <th>Puntos</th>
                </tr>
                <xsl:for-each select="temporadas/temporada/equipos/equipo">
                    <tr>
                        <td><xsl:value-of select="position()"/></td>
                        <td><xsl:value-of select="nombre"/></td>
                        <td><xsl:value-of select="puntos"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>

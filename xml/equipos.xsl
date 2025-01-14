<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <div class="contenedor-equipos">
            <xsl:for-each select="temporadas/temporada[estado='Activa']">
                <div class="equipos-contenido">
                    <div class="temporada-header">
                        <h1>Temporada <xsl:value-of select="nombre"/></h1>

                        <div class="temporada-select">
                            <label for="temporadaSelect">Selecciona la Temporada:</label>
                            <select id="temporadaSelect">
                                <xsl:for-each select="../temporada">
                                    <option value="{nombre}">
                                        <xsl:value-of select="nombre"/>
                                    </option>
                                </xsl:for-each>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="equipos">
                    <xsl:for-each select="equipos/equipo">
                        <xsl:variable name="temporada" select="../../nombre"/>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('equipo.html?equipo=', nombre)"/>
                            </xsl:attribute>
                            <div class="equipo" tabindex="0">
                                <img class="logo" src="img/temporadas/{$temporada}/{nombre}/{nombre}.png" alt="Logo del equipo"/>
                                <strong><xsl:value-of select="nombre"/></strong>
                            </div>
                        </a>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>

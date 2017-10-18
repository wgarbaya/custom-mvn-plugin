<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
	<xsl:output indent="yes" />
	<xsl:template match="/">
		<xsl:comment>
			XSLT Version =
			<xsl:copy-of select="system-property('xsl:version')" />
			XSLT Vendor =
			<xsl:copy-of select="system-property('xsl:vendor')" />
			XSLT Vendor URL =
			<xsl:copy-of select="system-property('xsl:vendor-url')" />
 			
 						<xsl:copy-of select="document-uri(/)" />
 						
 			
		</xsl:comment>
		<test>
			<files>
				<!--xsl:for-each select="collection('../a?select=*.xml')">
					<file>
						<xsl:value-of select="document-uri(.)" />
					</file>
				</xsl:for-each-->
			</files> 
			<!--grouped> <xsl:for-each-group select="collection('../a?select=*.xml')|collection('../b?select=*.xml')" group-by="/*/@xsi:noNamespaceSchemaLocation"> <group schema="{current-grouping-key()}"> <xsl:for-each select="current-group()"> <file> <xsl:value-of select="document-uri(.)" /> </file> </xsl:for-each> </group> </xsl:for-each-group> </grouped -->
		</test>
	</xsl:template>
</xsl:stylesheet>


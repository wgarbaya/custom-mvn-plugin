<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" />

	<xsl:template match="/">
		<Article>
			<titre>
				<xsl:value-of select="/Article/Title" />
			</titre>
		</Article>
	</xsl:template>

</xsl:stylesheet>
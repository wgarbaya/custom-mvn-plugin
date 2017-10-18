<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:datasourcemodel="http://www.tibco.com/mdm/datasourcemodel/1.0"
	xmlns:xmi="http://www.omg.org/XMI" xmlns:xalan="http://xml.apache.org/xalan"
	exclude-result-prefixes="xalan xmi datasourcemodel xsl">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" xalan:indent-amount="3"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"></xsl:variable>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="datasourcemodel:DataSource">
		<CIMMetaData xmlns="http://www.tibco.com/mdm/repository"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.tibco.com/mdm/repository metaDataSchema/RepositorySchema.xsd"
			MetaDataVersion="9.0">
			<xsl:element name="DataSources">				
				<DataSourceRef>
					<xsl:element name="DataSourceInfo">
						<xsl:element name="Name">
							<xsl:value-of select="@Name"/>
						</xsl:element>
						<xsl:element name="Description">
							<xsl:value-of select="@Description"/>
						</xsl:element>
						<xsl:element name="UseTitlesFlag">
							<xsl:choose>
								<xsl:when test="@UseColumnNames">
									<xsl:choose>
										<xsl:when test="@UseColumnNames = 'true'">Y</xsl:when>
										<xsl:otherwise>N</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="Delimiter">
							<xsl:choose>
								<xsl:when test="@DelimiterCharacter">
									<xsl:value-of select="@DelimiterCharacter"/>
								</xsl:when>
								<xsl:otherwise>44</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="HeaderLineCount">
							<xsl:choose>
								<xsl:when test="@StartImportAtRowNumber">
									<xsl:value-of
										select="number(@StartImportAtRowNumber) - 1"/>
								</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="TextQualifier">
							<xsl:choose>
								<xsl:when test="@DatasourceFormat ='SQL'"/>
								<xsl:when test="@DatasourceFormat ='FixedLength'">
									<xsl:choose>
										<xsl:when test="@TextQualifierCharacter">
											<xsl:value-of
												select="@TextQualifierCharacter"/>
										</xsl:when>
										<xsl:otherwise>"</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="@TextQualifierCharacter">
									<xsl:value-of select="@TextQualifierCharacter"/>
								</xsl:when>
								<xsl:otherwise>"</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="DecimalSymbol">
							<xsl:text>.</xsl:text>
						</xsl:element>
						<xsl:element name="ThousandSeparator">
							<xsl:text>,</xsl:text>
						</xsl:element>
						<xsl:element name="TransportProtocol">
							<xsl:text>MANUAL</xsl:text>
						</xsl:element>
						<xsl:element name="TransportProtocolAddressID">
							<xsl:text>0</xsl:text>
						</xsl:element>
						<xsl:element name="QueueName"/>
						<xsl:element name="Keyword"/>
						<xsl:element name="XSLTFileName"/>
						<xsl:element name="SourceTableName">
							<xsl:choose>
								<xsl:when test="@SourceQuery">
								</xsl:when>
								<xsl:when test="@DatasourceFormat='SQL'">
									<xsl:variable name="reference">
										<xsl:call-template name="getTableName">
											<xsl:with-param name="reference" select="@Reference"/>
										</xsl:call-template>
									</xsl:variable>
									<xsl:value-of select="$reference"/>
								</xsl:when>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="DateFormat">
							<xsl:choose>
								<xsl:when test="@DateFormat"><xsl:value-of select="@DateFormat"></xsl:value-of></xsl:when> 
								<xsl:otherwise>DD-MM-YY</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:element name="TimestampFormat">
							<xsl:choose>
								<xsl:when test="@TimestampFormat">
									<xsl:value-of select="@TimestampFormat"></xsl:value-of>
								</xsl:when>
								<xsl:otherwise>YYYY-MM-DD HH:mm:ss.S</xsl:otherwise>
								</xsl:choose>
						</xsl:element>
						<xsl:element name="CatalogFormat">
							<xsl:choose>
								<xsl:when test="@DatasourceFormat='SQL'">SQL</xsl:when>
								<xsl:when test="@DatasourceFormat='FixedLength'">
									<xsl:text>ASCII_FIXEDLENGTH</xsl:text>
								</xsl:when>
								<xsl:otherwise>ASCII_DELIMITED</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
						<xsl:if test="@DatasourceFormat='SQL' and @SourceQuery">
							<xsl:element name="SourceSql">
								<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
									<xsl:value-of select="@SourceQuery" disable-output-escaping="yes"/>
									<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
							</xsl:element>
						</xsl:if>
					</xsl:element>
					<xsl:element name="DataSourceAttributes">
						<xsl:for-each select="Attributes">
							<xsl:element name="DataSourceAttribute">
								<xsl:element name="Name">
									<xsl:value-of select="translate(@Name,$smallcase,$uppercase)"/>
								</xsl:element>
								<xsl:element name="Description">
									<xsl:choose>
										<xsl:when test="@Description and translate(@Description,' ','')!= ''">
											<xsl:value-of select="@Description"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="@Name"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
								<xsl:element name="Required">
									<xsl:text>N</xsl:text>
								</xsl:element>
								<xsl:element name="Length">
									<xsl:choose>										
										<xsl:when test="@Length">
											<xsl:value-of select="@Length"/>
										</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
								<xsl:element name="Position">
									<xsl:value-of select="@Position"/>
								</xsl:element>
								<xsl:element name="DataType">
									<xsl:choose>
										<xsl:when test="@Type ='Custom Decimal'">CUSTOM_DECIMAL</xsl:when>
										<xsl:when test="@Type ='Decimal'">DECIMAL</xsl:when>
										<xsl:when test="@Type ='String'">STRING</xsl:when>
										<xsl:when test="@Type"><xsl:value-of select="translate(@Type,$smallcase,$uppercase)"/></xsl:when>
										<xsl:otherwise>STRING</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</DataSourceRef>
			</xsl:element>
		</CIMMetaData>
	</xsl:template>

	<xsl:template name="getTableName">
		<xsl:param name="reference"/>
		<xsl:choose>
			<xsl:when test="contains($reference, '/')= false">
				<xsl:value-of select="$reference"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="getTableName">
					<xsl:with-param name="reference" select="substring-after($reference,'/' )"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs xd" version="3.0">
    <xsl:strip-space elements="*"/>
    <xsl:output encoding="UTF-8" omit-xml-declaration="no" indent="yes" method="xml"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 18, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> pmgreen</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="datetime" select="substring(string(current-dateTime()),1,10)"/>
    <xsl:template match="/" name="root">
        <Repository xmlns="http://www.openarchives.org/OAI/2.0/static-repository"
            xmlns:oai="http://www.openarchives.org/OAI/2.0/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/static-repository     http://www.openarchives.org/OAI/2.0/static-repository.xsd">
            <Identify>
                <oai:repositoryName>Nineteenth-century sheet music collection</oai:repositoryName>
                <oai:baseURL>http://oaigateway.library.ucla.edu/gatewaynet/oai.aspx/library.princeton.edu/departments/tsd/sheetmusic/pudl0020.xml</oai:baseURL>
                <oai:protocolVersion>2.0</oai:protocolVersion>
                <oai:adminEmail>pmgreen@princeton.edu</oai:adminEmail>
                <oai:earliestDatestamp>
                    <xsl:value-of select="$datetime"/>
                </oai:earliestDatestamp>
                <oai:deletedRecord>no</oai:deletedRecord>
                <oai:granularity>YYYY-MM-DD</oai:granularity>
            </Identify>
            <ListMetadataFormats>
                <oai:metadataFormat>
                    <oai:metadataPrefix>mods3.4</oai:metadataPrefix>
                    <oai:schema>http://www.loc.gov/standards/mods/v3/mods-3-4.xsd</oai:schema>
                    <oai:metadataNamespace>http://www.loc.gov/mods/v3/</oai:metadataNamespace>
                </oai:metadataFormat>
            </ListMetadataFormats>
            <ListRecords metadataPrefix="mods3.4">
                <!-- generate new collection file for each batch and change the value below (e.g. 'batch02.xml', 'batch03.xml', etc.) -->
                <xsl:for-each select="collection('../collections/batch01.xml')">
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:for-each>
                <xsl:apply-templates/>
            </ListRecords>
        </Repository>
    </xsl:template>
    <xsl:template match="element()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*,node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy copy-namespaces="no"/>
    </xsl:template>
    <xsl:template match="processing-instruction()"/>
    <xsl:template match="mods:mods">
        <xsl:variable name="vol" select="tokenize(base-uri(.),'/')[last() - 1]"/>
        <xsl:variable name="file"
            select="replace(tokenize(tokenize(base-uri(.),'/')[last()],'-')[1],'.mods','')"/>
        <xsl:variable name="id" select="concat($vol,'_',$file)"/>
        <oai:record>
            <oai:header>
                <oai:identifier>
                    <xsl:value-of select="$id"/>
                </oai:identifier>
                <oai:datestamp>
                    <xsl:value-of select="$datetime"/>
                </oai:datestamp>
            </oai:header>
            <oai:metadata>
                <xsl:copy copy-namespaces="yes">
                    <xsl:apply-templates select="@*,node()"/>
                </xsl:copy>
            </oai:metadata>
        </oai:record>
    </xsl:template>
    <xsl:template match="@xlink:type" />
    <!-- scm validation is oddly rejecting records with mods:holdingSimple, apparently validating against < 3.3. Taking it out for now. -->
    <xsl:template match="mods:holdingSimple" />

</xsl:stylesheet>

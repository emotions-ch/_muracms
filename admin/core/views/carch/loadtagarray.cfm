<cfset request.layout=false>
<cfset tags=$.getBean('contentGateway').getTagCloud(siteid=$.event('siteID'),taggroup=$.event('taggroup')) />
<cfcontent type="application/json; charset=utf-8" reset="true"><cfoutput>[<cfloop query="tags">{id: '#encodeForJavascript(tags.tag)#', toString: function() { return '#encodeForJavascript(tags.tag)#'; } }<cfif tags.currentrow lt tags.recordcount>,</cfif></cfloop>]</cfoutput><cfabort>
xquery version "1.0";

(: generates a saxon collection catalog from the folder defined in $COLLECTION :)

declare namespace mods="http://www.loc.gov/mods/v3";
import module namespace functx="http://www.functx.com" 
    at "http://www.xqueryfunctions.com/xq/functx-1.0-doc-2007-01.xq";

declare variable $COLLECTION as document-node()* := collection("/home/pmgreen/Documents/working/svn/pudl0020/?select=*.mods;recurse=yes;on-error=ignore")/doc(document-uri(.));

<collection>{
for $ead in $COLLECTION
let $uri :=$ead/document-uri(.)
return
<doc href="{$uri}" />
(: the functions below can be used to make the uri relative. Adjust as needed. :)
(:<doc href="{ replace($uri,'^[\D\d]+/([\D\d\.])',concat('..','$1') )}" />:)
(:<doc href="{functx:substring-after-last(string($uri),'/')}" />:)
}</collection>
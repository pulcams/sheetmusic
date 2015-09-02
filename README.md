sheetmusic
==========
We're contributing data from our Nineteenth-century Sheet Music Collection ([pudl0020](http://pudl.princeton.edu/collections/pudl0020)) to the [Sheet Music Consortium](http://digital2.library.ucla.edu/sheetmusic/).

Steps to create an *OAI static repository*...
* Make a collection file using ./xq/make-collection.xq
* Transform using ./xsl/pul2oai.xsl
* Insert mods:url using ./xq/insert-urls.xqu
* Post file to server (sheetmusic dir on tsd site)
* Register file: http://oaigateway.library.ucla.edu/submit.html

Details on participation: [http://digital2.library.ucla.edu/sheetmusic/aboutProject.html#Participation](http://digital2.library.ucla.edu/sheetmusic/aboutProject.html#Participation)

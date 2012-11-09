To scrape anchor tags in beer.friscogrille.com and parse data to return list of beers

<pre>
AnalystLib.fetch_list('http://beer.friscogrille.com')

Example result =>
 ["Bear Republic Racer V", "Blue Point Toasted Lager", "Boulder Hoopla Pale Ale (N2)", "Boulevard Double Wide IPA", "Boulevard Tank 7 Farmhouse Ale", "Boulevard/Pretty Things Stingo", "Brewer's Art Resurrection", "Brooklyn Post Road Pumpkin Ale", "Burley Oak Rude Boy", "Dogfish Head Chicory Stout", "Xingu Black Beer"]
</pre>

To get beer metadata:

<pre>
AnalystLib.fetch_metadata("Burley Oak Rude Boy")

Example result =>
 <AnalystLib::Metadata:0x78a02404 @rating_score="89", @rating_desc="CANNOT FIND", @abv="9.00", @description="CANNOT FIND"> 
 
</pre>

----
TODO:
- capture failures

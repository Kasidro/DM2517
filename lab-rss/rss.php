<?php header("Content-type: text/xml; charset=utf-8"); ?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://purl.org/rss/1.0/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:syn="http://purl.org/rss/1.0/modules/syndication/">
<channel rdf:about="http://www.nada.kth.se/media/Theses/">
<title>Examensarbeten medieteknik</title>
<link>http://www.nada.kth.se/media/Theses/</link>
<description>Examensarbeten inom medieteknik.</description>
<dc:language>sv</dc:language>
<dc:rights>Copyright KTH/Nada/Media</dc:rights>
<dc:date><?php echo(date("c")); ?></dc:date>
<dc:publisher>KTH/Nada/Media</dc:publisher>
<dc:creator>bjornh@kth.se</dc:creator>
<syn:updatePeriod>daily</syn:updatePeriod>
<syn:updateFrequency>1</syn:updateFrequency>
<syn:updateBase>2006-01-01T00:00+00:00</syn:updateBase>
<items>
<rdf:Seq>

<?php
    // Connect using host, username, password and databasename
    $link = mysqli_connect('localhost', 'rsslab', 'rsslab', 'rsslab');

    // Check connection
    if (mysqli_connect_errno()) {
        printf("Connect failed: %s\n", mysqli_connect_error());
        exit();
    }

    // The SQL query
    $query = "SELECT link, title, description, creator, feeddate
            FROM exjobbsfeed
            ORDER BY feeddate ASC";

    // Execute the query
    if (($result = mysqli_query($link, $query)) === false) {
       printf("Query failed: %s<br />\n%s", $query, mysqli_error($link));
       exit();
    }
    $returnstring = '';
     while ($line = $result->fetch_object()) {
        $link = $line->link;
        $returnstring .= "<rdf:li rdf:resource='$link'/>";
     }
     $returnstring .= "</rdf:Seq></items><image rdf:resource='http://www.nada.kth.se/media/images/kth.png'/></channel>";
    //fulhack för att reseta pointer i resultset
    mysqli_data_seek($result, 0);
    // Loop over the resulting lines
    while ($line = $result->fetch_object()) {
        
        $title = $line->title;
        //remove dots from titles
        $title = preg_replace('/[.]/', '', $title);
        $link = $line->link;
        //replace whitespaces in links
        $link = preg_replace('/\s+/', '%20', $link);
        $link = htmlentities($link);

        $description = $line->description;
        //replace & in descrptions
        $description = str_replace('&', '&amp;', $description);

        $creator = $line->creator;
        $date = $line->feeddate;
        //convert to ISO-8601 date
        $date = date("c",strtotime($date)); 

        // Store the result we want by appending strings to the variable $returnstring
        $returnstring .= "<item rdf:about='$link'>";
        $returnstring .= "<title>$title</title>";
        $returnstring .= "<link>$link</link>";
        $returnstring .= "<description>$description</description>";
        $returnstring .= "<dc:creator>$creator</dc:creator>";
        $returnstring .= "<dc:date>$date</dc:date>";
        $returnstring .= "</item>";
    }
    // Free result and just in case encode result to utf8 before returning
    mysqli_free_result($result);
    print utf8_encode($returnstring);
?>
</rdf:RDF>
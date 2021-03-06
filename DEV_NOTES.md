# Developer Notes

## LibraryCloud API documentation discrepancies

(*ref: [The LibraryCloud API documentation](https://wiki.harvard.edu/confluence/display/LibraryStaffDoc/LibraryCloud+Item+API) *)

* **start** : default is **0**, not **1**
* **facet_size** is **NOT** supported; the number of facets returned is dependent on the number of facets found, and cannot be limited
* **language_code** is keyworded, indexed, stored, **NOT** **languageText**


## Other LibraryCloud issues

* A lot of the values in the field data is "dirty" -- containing line feeds and white space.  This makes taking a facet value, e.g.: 

  `"\n      Roda, Beno \n      \n         creator\n         \n       \n   "`
  
  just about impossible to use for the **_exact** syntax

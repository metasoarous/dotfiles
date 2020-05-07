
* Update `+version+` flags in corresponding `build.boot` files
* Download corresponding packages and regenerate externs

```
  wget https://github.com/vega/vega-lite/archive/v2.2.0.zip
  unzip v2.2.0.zip
  generate-extern -f vega-lite-2.2.0/build/vega-lite.js -n vl -o vega-lite.ext.js
  # Check the diff, and make sure it makes sense; if so move into place
  diff vega-lite.ext.js resources/cljsjs/common/vega-lite.ext.js
  mv vega-lite.ext.js resources/cljsjs/common/vega-lite.ext.js
```

* build and install for testing

```
  boot package install target
```

  

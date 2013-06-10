# `nls` is for Language Support

Use this directory to provide language-specific strings that can be used by controllers.

How to use:

1. Add the appropriate `i18n` abbreviated language named folder to the `nls` subdirectory.
2. Inject the language configuration file into your RequireJS compatible component:

```
define ['l18n!nls/my-lang-conf'], (lang) ->
	'use strict'
	
	# Use the language config as needed.
	
	console.log "#{lang.hello} User!"
```

3.  Or better yet, bind the appropriate language to your controller:

```
###
	Assume "lang" is the following object:

	lang =
		hello: "Bonjour"
		goodbye: "Au Revoir"
###

define ['c/controllers', 'l18n!nls/my-lang-conf', 'lodash'], (controllers, lang, _) ->
	'use strict'
	
	class MyController
		
		lang: 
			hello: "Hello"
			goodbye: "Good Bye"
		
		constructor: (lang) ->
			_.extend @lang, lang
	
	# The return is implicit
	new MyController(lang)
```

And in your template:

```
<div>{{lang.hello}} User.</div>
```
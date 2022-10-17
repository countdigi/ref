# Cascading Style Sheets

## Selectors

- `*` - any
- `e`- any e element
- `e f` - any f a descendant of e
- `e > f` - any f element thats a child of e
- `e:first-child` - any element whose is first child of its parent
- `e#myid` - any e with ID equal to "myid".  ID selectors
- `e.class`
- `e:link` - any element with src anchor not visited
- `e:visited` - matches element with src anchor visited
- `e + f` - any f immediately preceded by sibling e (adjacent)
- `e[foo]` - any e with "foo" attribute set
- `e[foo="warning"]` - any e whose "foo" attr == "warning"
- `e[foo~="warning"]` - any e whose "foo" attr == a list of space-separated values
- `e[lang|="en"]` - any e element whose "lang" attr has hyphen-separated list of values beginning (from the left) with "en"
- `e:active`
- `e:hover`
- `e:focus`

## Attributes

- `border:           1px solid|none #000;`
- `background-color: #444;`
- `color:            #fff;`
- `font:             font: 14px/1.4 helvetica, san-serif;`
- `font-size:        14px|em;`
- `height:           26px;`
- `width:            96px;`
- `padding-left:     1px;`
- `padding-right:    1px;`
- `padding-bottom:   1px;`
- `padding-top:      1px;`
- `text-align:       right|left|center;`
- `padding[-{left,right,top,bottom}:  1px;`
- `margin[-{left,right,top,bottom}:  1px;`
- `list-style-image:url('sqpurple.gif');`
-  `h1 {text-decoration:overline}`
-  `h2 {text-decoration:line-through}`
-  `h3 {text-decoration:underline}`
-  `h4 {text-decoration:blink}`

Shadow
- `border-radius         :2px;`
- `-moz-border-radius    :2px;`
- `-webkit-border-radius :2px;`
- `-moz-box-shadow:      inset 0 1px #c0c0c0, inset 0 -2px 5px #404040, 0 0 0 4px rgba(255,255,255,0.65);`
- `-webkit-box-shadow:   inset 0 1px #c0c0c0, inset 0 -2px 5px #404040, 0 0 0 4px rgba(255,255,255,0.65);`
- `-moz-linear-gradient(top, #909090, #c0c0c0);`
- `-webkit-gradient(linear, 0 0, 0 100%, from(#909090), to(#c0c0c0));`

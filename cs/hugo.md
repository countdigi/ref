# Hugo

## Scratch

```
{{ if or (isset .Params "alt") (isset .Params "caption") }} Caption {{ end }}

{{ if or
  (isset .Params "alt")
  (isset .Params "caption")
}}

{{ $msg := `Line one.
Line two.` }}

{{ if .IsHome }}
    {{ $var = "Hugo Home" }}
{{ end }}

{{ add 1 2 }}


{{ partial "header.html" . }}

{{ range $array }}
    {{ . }} <!-- The . represents an element in $array -->
{{ end }}

{{ range $elem_val := $array }}
    {{ $elem_val }}
{{ end }}

{{ range $elem_index, $elem_val := $array }}
   {{ $elem_index }} -- {{ $elem_val }}
{{ end }}

{{ range $elem_key, $elem_val := $map }}
   {{ $elem_key }} -- {{ $elem_val }}
{{ end }}

{{ range $array }}
    {{ . }}
{{else}}
    <!-- This is only evaluated if $array is empty -->
{{ end }}

with rebinds the context . within its scope (just like in range).

{{ with .Params.title }}
    <h4>{{ . }}</h4>
{{ end }}

{{ with .Param "description" }}
    {{ . }}
{{ else }}
    {{ .Summary }}
{{ end }}

The following two examples are functionally the same:
{{ shuffle (seq 1 5) }}
{{ (seq 1 5) | shuffle }}


Looks up the index(es) or key(s) of the data structure passed into it.
{{ $slice := slice "a" "b" "c" }}
{{ index $slice 1 }} => b
{{ $map := dict "a" 100 "b" 200 }}
{{ index $map "b" }} => 200

The function takes multiple indices as arguments, and this can be used to get nested values, e.g.:
{{ $map := dict "a" 100 "b" 200 "c" (slice 10 20 30) }}
{{ index $map "c" 1 }} => 20
{{ $map := dict "a" 100 "b" 200 "c" (dict "d" 10 "e" 20) }}
{{ index $map "c" "e" }} => 20



```


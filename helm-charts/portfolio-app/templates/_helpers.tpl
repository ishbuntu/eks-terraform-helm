{{/*
App name
*/}}
{{- define "portfolio-app.name" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Full name for resources
*/}}
{{- define "portfolio-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}

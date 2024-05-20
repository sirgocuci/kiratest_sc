# templates/_helpers.tpl
{{- define "my-application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default .Chart.Name .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "my-application.labels" -}}
app.kubernetes.io/name: {{ include "my-application.name" . }}
helm.sh/chart: {{ include "my-application.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "my-application.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "my-application.chart" -}}
{{- .Chart.Name }}-{{ .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{- define "my-application.fullname" -}}
{{- printf "%s-%s" .Release.Namespace .Chart.Name -}}
{{- end -}}

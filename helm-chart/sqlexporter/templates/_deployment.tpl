{{- define "securitycontext" }}
  securityContext:
{{ toYaml .Values.securityContext | indent 4 }}
{{- end }}
{{- if .Values.enabled }}
{{- if .Values.certs.enabled }}
{{- range .Values.certs.certs }}
{{- if .enabled }}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ .name | quote }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "3"
    {{- if $.Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  secretName: {{ .name | quote }}
  commonName: {{ .commonName | quote }}
  dnsNames:
    {{- range .dnsNames }}
    - "{{ . }}"
    {{- end }}
  issuerRef:
    name: {{ .issuer | quote }}
    kind: issuer
{{- end }}
{{- end }}
{{- end }}
{{- end }}
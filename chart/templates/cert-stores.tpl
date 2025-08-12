{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.stores }}
{{- if .enabled }}
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-9"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  provider:
    onepasswordSDK:
      vault: {{ .vault | quote }}
      auth:
        serviceAccountSecretRef:
          name: {{ .secretName | quote }}
          {{- if .secretField }}
          key: {{ .secretField | quote }}
          {{- else }}
          key: token
          {{- end }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

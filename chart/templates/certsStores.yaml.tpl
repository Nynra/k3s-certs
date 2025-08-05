{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.secretStores }}
{{- if .enabled | default true }}
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
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .storeName | quote }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ $.Values.certStores.connectToken.name | quote }}
            key: token
{{- end }}
{{- end }}
{{- end }}{{- end }}

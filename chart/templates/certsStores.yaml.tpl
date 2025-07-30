{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.secretStores }}
{{- if .enabled | default true }}
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
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

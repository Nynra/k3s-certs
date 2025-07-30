{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.secretStores }}
{{- $connectTokenName := .connectToken.name | default $.Values.certStores.connectToken.name | quote }}
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
            name: {{ $connectTokenName }}
            key: token
{{- end }}
{{- end }}{{- end }}

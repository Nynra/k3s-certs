{{- if .Values.enableExternalSecrets }}{{- if .Values.certsPushVaults.enabled }}
{{- range .Values.certsPushVaults.secretStores }}
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  namespace: {{ $.Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .vaultName | quote }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ .connectToken.name | default $.Values.certsPushVaults.connectToken.name | quote }}
            key: token
            namespace: {{ .connectToken.namespace | default $.Values.certsPushVaults.connectToken.namespace | quote }}
{{- end }}
{{- end }}{{- end }}

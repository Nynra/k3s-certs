{{- if .Values.enableExternalSecrets }}{{- if .Values.certsPullVault.enabled }}
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .Values.certsPullVault.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .Values.certsPullVault.vaultName | quote }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ .Values.certsPullVault.connectToken.name | quote }}
            key: token
            namespace: {{ .Values.certsPullVault.connectToken.namespace | quote }}
{{- end }}{{- end }}


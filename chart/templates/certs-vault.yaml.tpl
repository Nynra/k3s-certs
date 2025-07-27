{{- if .Values.enableCertsVault }}
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .Values.certsVault.name }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .Values.certsVault.vaultName }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ .Values.certsVault.connectTokenSecretName }}
            key: token
            namespace: {{ .Values.certsVault.connectTokenNamespace }}
{{- end }}

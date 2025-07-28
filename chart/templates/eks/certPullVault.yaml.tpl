{{- if .Values.enableExternalSecrets }}{{- if .Values.certsPullVault.enabled }}
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .Values.certsPullVault.name | quote }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.certsPullVault.commonLabels }}
    {{- toYaml .Values.certsPullVault.commonLabels | nindent 4 }}
    {{- end }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.certsPullVault.commonAnnotations }}
    {{- toYaml .Values.certsPullVault.commonAnnotations | nindent 4 }}
    {{- end }}
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


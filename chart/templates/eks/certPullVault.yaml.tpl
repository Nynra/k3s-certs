{{- if .Values.enableExternalSecrets }}{{- if .Values.certPullVault.enabled }}
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .Values.certPullVault.name | quote }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.certPullVault.commonLabels }}
    {{- toYaml .Values.certPullVault.commonLabels | nindent 4 }}
    {{- end }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.certPullVault.commonAnnotations }}
    {{- toYaml .Values.certPullVault.commonAnnotations | nindent 4 }}
    {{- end }}
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .Values.certPullVault.vaultName | quote }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ .Values.certPullVault.connectToken.name | quote }}
            key: token
            namespace: {{ .Values.certPullVault.connectToken.namespace | quote }}
{{- end }}{{- end }}


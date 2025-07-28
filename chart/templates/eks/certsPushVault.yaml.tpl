{{- if .Values.enableExternalSecrets }}{{- if .Values.certPushVaults.enabled }}
{{- range .Values.certPushVaults.secretStores }}
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  namespace: {{ $.Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-15"
    # Custom annotations
    {{- if .commonAnnotations }}
    {{- toYaml .commonAnnotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if global.commonAnnotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  labels:
    # Custom labels
    {{- if .commonLabels }}
    {{- toYaml .commonLabels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if global.commonLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{ .vaultName | quote }}: 1
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ .connectToken.name | default $.Values.certPushVaults.connectToken.name | quote }}
            key: token
            namespace: {{ .connectToken.namespace | default $.Values.certPushVaults.connectToken.namespace | quote }}
{{- end }}
{{- end }}{{- end }}

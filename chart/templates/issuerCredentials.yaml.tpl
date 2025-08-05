{{- if .Values.enableExternalSecrets }}{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .externalSecret.enabled }}
{{- $secretStoreType := .externalSecret.secretStoreType | default "ClusterSecretStore" }}
{{- $secretStore := .externalSecret.secretStore | default $.Values.clusterIssuers.secretStore | quote }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .secretName | quote }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
  secretStoreRef:
    kind: {{ $secretStoreType }}
    name: {{ $secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: token
      remoteRef:
        key: {{ .externalSecret.secretName | quote }}
        property: {{ .externalSecret.tokenPropertyName | default "password" | quote }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

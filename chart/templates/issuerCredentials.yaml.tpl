{{- if .Values.enableExternalSecrets }}{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .externalSecret.enabled }}
{{- $secretStoreType := .externalSecret.secretStoreType | default "ClusterSecretStore" }}
{{- $secretStore := .externalSecret.secretStore | default $.Values.clusterIssuers.secretStore | quote }}
{{- $secretName := .externalSecret.secretName | default .name | quote }}
{{- $tokenPropertyName := .externalSecret.tokenPropertyName | default "password" | quote }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: "{{ .name }}-token"
  namespace: {{ $.Values.namespace.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
spec:
  secretStoreRef:
    kind: {{ $secretStoreType }}
    name: {{ $secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: token
      remoteRef:
        key: {{ $secretName }}
        property: {{ $tokenPropertyName }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

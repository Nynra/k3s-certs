{{- if .Values.enableExternalSecrets }}{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .externalSecret.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .secretName | quote }}
  # Argocd cannot add secrets to the default namespace but issuers look
  # in the cert-manager namespace automatically
  namespace: {{ $.Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{ toYaml $.Values.global.commonAnnotations | indent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if $.Values.global.commonLabels }}
    {{ toYaml $.Values.global.commonLabels | indent 4 }}
    {{- end }}
spec:
  secretStoreRef:
    kind: {{ .externalSecret.secretStoreType | default "ClusterSecretStore" | quote }}
    name: {{ .externalSecret.secretStore | quote }}
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

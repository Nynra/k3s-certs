{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.certStores.connectToken.name | quote }}
  namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
spec:
  secretStoreRef:
    kind: {{ .Values.certStores.connectToken.secretStoreType | quote }}
    name: {{ .Values.certStores.connectToken.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: token
      remoteRef:
        key: {{ .Values.certStores.connectToken.secretName | quote }}
        property: {{ .Values.certStores.connectToken.property | quote }}
{{- end }}{{- end }}

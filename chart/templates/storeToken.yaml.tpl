{{- if .Values.enableExternalSecrets }}{{- if .Values.certStores.enabled }}
{{- if .Values.certStores.connectToken.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.certStores.connectToken.name | quote }}
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  secretStoreRef:
    kind: {{ .Values.certStores.connectToken.secretStoreType | quote }}
    name: {{ .Values.certStores.connectToken.secretStore | quote }} 
  target:
    creationPolicy: Owner
  data: 
    - secretKey: token
      remoteRef:
        key: {{ .Values.certStores.connectToken.remoteName | quote }}
        property: {{ .Values.certStores.connectToken.remoteProperty | quote }}
{{- end }}
{{- end }}{{- end }}

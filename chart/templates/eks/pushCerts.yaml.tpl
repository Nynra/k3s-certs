{{- if .Values.enableExternalSecrets }}{{- if .Values.certs.enabled }}{{- if .Values.certs.push.enabled }}
{{- range .Values.certs }}
{{- if .push.enabled | default false }}
{{- $remoteName := .push.secretName | default .name }}
---
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: {{ .name | quote }}-push-secret
  namespace: {{ $.Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-7"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{ toYaml $.Values.global.commonAnnotations | indent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .push.annotations }}
    {{ toYaml .push.annotations | indent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if $.Values.global.commonLabels }}
    {{ toYaml $.Values.global.commonLabels | indent 4 }}
    {{- end }}
    # Custom labels
    {{- if .push.labels }}
    {{ toYaml .push.labels | indent 4 }}
    {{- end }}
spec:
  deletionPolicy: Delete
  updatePolicy: Replace
  refreshInterval: {{ .push.refreshInterval | default $.Values.certs.push.refreshInterval | quote }}
  secretStoreRefs:
    - name: {{ .push.secretStore | default $.Values.certs.push.secretStore | quote }}
      kind: SecretStore
  selector:
    secret:
      name: {{ .name | quote }}
  data:
    - match:
        secretKey: tls.crt 
        remoteRef:
            remoteKey: {{ $remoteName }}
            property: tls_crt
    - match:
        secretKey: tls.key
        remoteRef:
            remoteKey: {{ $remoteName }}
            property: tls_key
{{- end }}
{{- end }}
{{- end }}{{- end }}{{- end }}

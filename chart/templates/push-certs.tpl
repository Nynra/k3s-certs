{{- if .Values.enabled }}
{{- if .Values.certs.push.enabled }}
{{- range .Values.certs.certs }}
{{- if .push.enabled | default $.Values.certs.push.enabled }}
{{- $secretName := .name }}
{{- $remoteName := .push.secretName | default .name }}
{{- $refreshInterval := .push.refreshInterval | default $.Values.certs.push.refreshInterval }}
{{- range .push.secretStores }}
{{- $secretStore := . }}
---
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: "{{ $secretName }}-to-{{ $secretStore }}-push-secret"
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "4"
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
  deletionPolicy: Delete
  updatePolicy: Replace
  refreshInterval: {{ $refreshInterval | quote }}
  secretStoreRefs:
    - name: {{ $secretStore | quote }}
      kind: SecretStore
  selector:
    secret:
      name: {{ $secretName | quote }}
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
{{- end }}
{{- end }}
{{- end }}
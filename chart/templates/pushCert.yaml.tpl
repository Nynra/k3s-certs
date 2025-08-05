
{{- if .Values.enableExternalSecrets }}{{- if .Values.certs.push.enabled }}
{{- range .Values.certs.certs }}
{{- if .push.enabled | default false }}
{{- $remoteName := .push.secretName | default .name }}
{{- $pushSecretName := .push.secretName | default .name }}
{{- $refreshInterval := .push.refreshInterval | default $.Values.certs.push.refreshInterval | quote }}
{{- $secretStore := .push.secretStore | default $.Values.certs.push.secretStore | quote }}
---
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: "{{ $pushSecretName }}-push-secret"
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
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
  deletionPolicy: Delete
  updatePolicy: Replace
  refreshInterval: {{ $refreshInterval }}
  secretStoreRefs:
    - name: {{ $secretStore }}
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
{{- end }}{{- end }}
{{- if .Values.enablePushCerts }}{{- if .Values.enableCertsVault }}
{{- range .Values.certs }}
---
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: {{ .name }}-push-secret
  namespace: {{ $.Values.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "-7"
spec:
  deletionPolicy: Delete
  updatePolicy: Replace
  # refreshInterval: 1h
  secretStoreRefs:
    - name: {{ $.Values.certsVault.name }}
      kind: ClusterSecretStore
  selector:
    secret:
      name: {{ .secretName }}
  data:
    - match:
        secretKey: tls.crt 
        remoteRef:
            remoteKey: {{ .secretName }}
            property: tls_crt
    - match:
        secretKey: tls.key
        remoteRef:
            remoteKey: {{ .secretName }}
            property: tls_key
{{- end }}
{{- end }}{{- end }}

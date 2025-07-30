{{- if .Values.certs.enabled }}
{{- range .Values.certs.certs }}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ .name | quote }}
  namespace: {{ $.Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-8"
spec:
  secretName: {{ .name | quote }}
  commonName: {{ .commonName | quote }}
  dnsNames:
    {{- range .dnsNames }}
    - "{{ . }}"
    {{- end }}
  issuerRef:
    name: {{ .clusterIssuer | quote }}
    kind: ClusterIssuer
{{- end }}
{{- end }}

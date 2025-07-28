{{- if .Values.enableCertManager }}{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-9"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{ toYaml $.Values.global.commonAnnotations | indent 4 }}
    {{- end }}
    # Custom annotations
    {{- if $.Values.clusterIssuers.commonAnnotations }}
    {{ toYaml $.Values.clusterIssuers.commonAnnotations | indent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if $.Values.global.commonLabels }}
    {{ toYaml $.Values.global.commonLabels | indent 4 }}
    {{- end }}
    # Custom labels
    {{- if $.Values.clusterIssuers.commonLabels }}
    {{ toYaml $.Values.clusterIssuers.commonLabels | indent 4 }}
    {{- end }}
spec:
  acme:
    server: {{ .server | quote }}
    privateKeySecretRef:
      name: {{ .name | quote }}-private-key
      key: token
    solvers:
      - dns01:
          cloudflare:
            apiTokenSecretRef:
              name: {{ .secretName | quote }}
              key: token
        selector:
          dnsZones:
          {{- range .domains }}
          - "{{ . }}"
          {{- end }} 
{{- end }}
{{- end }}{{- end }}
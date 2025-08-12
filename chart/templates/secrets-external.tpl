{{- if .Values.enabled }}{{- if .Values.issuers.enabled }}
{{- range .Values.issuers.issuers }}
{{- if .externalSecret.enabled }}
{{- $secretStoreType := .externalSecret.secretStoreType | default "ClusterSecretStore" }}
{{- $secretStore := .externalSecret.secretStore | quote }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .secretName | quote }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
  secretStoreRef:
    kind: {{ $secretStoreType }}
    name: {{ $secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: token
      remoteRef:
        key: {{ .externalSecret.secretName | quote }}
        property: {{ .externalSecret.secretField | default "password" | quote }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

{{- if .Values.enabled }}{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .externalSecret.enabled }}
{{- $secretStoreType := .externalSecret.secretStoreType | default "ClusterSecretStore" }}
{{- $secretStore := .externalSecret.secretStore | quote }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .secretName | quote }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
  secretStoreRef:
    kind: {{ $secretStoreType }}
    name: {{ $secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: token
      remoteRef:
        key: {{ .externalSecret.secretName | quote }}
        property: {{ .externalSecret.secretField | default "password" | quote }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

{{- if .Values.enabled -}}{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.stores }}
{{- if .enabled }}{{- if .externalSecret.enabled }}
{{- $secretStoreType := .externalSecret.secretStoreType | default "ClusterSecretStore" }}
{{- $secretStore := .externalSecret.secretStore | quote }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .secretName | quote }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
  secretStoreRef:
    kind: {{ .externalSecret.storeType | default "ClusterSecretStore" | quote }}
    name: {{ .externalSecret.storeName | quote }} 
  target:
    creationPolicy: Owner
  data: 
    - secretKey: token
      remoteRef:
        key: {{ .externalSecret.secretName | quote }}
        property: {{ .externalSecret.secretField | quote }}
{{- end }}{{- end }}
{{- end }}
{{- end }}{{- end }}
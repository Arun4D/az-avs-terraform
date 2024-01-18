output "policy_segment_id" {
  value = [for l_segment in nsxt_policy_segment.segment : l_segment.id]
}

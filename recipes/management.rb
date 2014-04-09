#
# Cookbook Name:: systrack_agent
# Recipe:: management_agent
#
# Copyright (C) 2014 Todd Pigram
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

windows_package "management" do
  source node['management']['url']
  options "ALLUSERS=1 REBOOT=R MASTERNAME=DA-SQL01.daas.local PORTNUMBER=57632"
  action :install
  not_if {::File.exists?(node['man']['file'])}
  not_if {reboot_pending?}
end

windows_reboot 60 do
  reason 'reboot needed'
  only_if {reboot_pending?}
end 
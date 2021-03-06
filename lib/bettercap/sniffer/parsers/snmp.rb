# encoding: UTF-8
=begin

BETTERCAP

Author : Simone 'evilsocket' Margaritelli
Email  : evilsocket@gmail.com
Blog   : https://www.evilsocket.net/

SNMP community string parser:
  Author : Matteo Cantoni
  Email  : matteo.cantoni@nothink.org

This project is released under the GPL 3 license.

Todo: SNMPv2

=end

module BetterCap
module Parsers
# SNMP community string parser.
class SNMP < Base
  def on_packet( pkt )
    return unless pkt.udp_dst == 161

    packet = Network::Protos::SNMP::Packet.parse( pkt.payload )

    return if packet.nil?

    if packet.snmp_version_number.to_i == 0
      snmp_version = 'v1'
    else
      snmp_version = 'n/a'
    end

    msg = "[#{'Version:'.green} #{snmp_version}] [#{'Community:'.green} #{packet.snmp_community_string.map { |x| x.chr }.join.yellow}]"

    StreamLogger.log_raw( pkt, 'SNMP', msg )
  rescue
  end
end
end
end

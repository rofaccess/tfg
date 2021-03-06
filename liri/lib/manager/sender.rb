require 'socket'

module Liri
  module Manager
    class Sender
      def initialize(udp_port, tcp_port)
        @udp_port = udp_port
        @udp_socket = UDPSocket.new
        @tcp_socket = TCPServer.new(tcp_port)
      end

      def load_agents_addresses
        wait_agents_connection_responses
        start_connection_with_agents
      end

      private
      def start_connection_with_agents
        request_msg = "¿Algún LiriAgent escuchando y con ganas de trabajar?"
        puts "LiriManager(#{Liri::Common.current_host_ip_address}): #{request_msg}"

        @udp_socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
        @udp_socket.send(request_msg, 0, '<broadcast>', @udp_port)
      end

      def wait_agents_connection_responses
        # el servidor corre infinitamente, hay que ver como pararlo al terminar el proceso de testeo
        # tambien hay que parar el hilo
        loop {
          Thread.start(@tcp_socket.accept) do |agent|
            request_msg = "LiriAgent(#{agent_ip_address(agent)}): #{agent_message(agent)}"
            puts request_msg
            response_msg = "En breve te informo LiriAgent(#{agent_ip_address(agent)})"
            puts "LiriManager(#{Liri::Common.current_host_ip_address}): #{response_msg}"

            agent.puts response_msg
            agent.close # se desconecta el cliente
          end
        }
      end

      def agent_ip_address(agent)
        agent.remote_address.ip_address
      end

      def agent_message(agent)
        agent.recvfrom(100).first
      end
    end
  end
end
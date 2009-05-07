require 'rubygems'
require 'xmpp4r'
require 'xmpp4r/version'
require 'xmpp4r/muc'
require 'rexml/document'

module Dropio
  module XMPP
    VERSION = '0.1'
    class CallbackList
      def initialize
        @items = []
      end

      def <<(cb)
        @items << cb
      end

      def notify_event(*event)
        @items.each do |i|
          i.call event
        end
      end
    end

    class Client

      def initialize(jid, password, drop_name, muc_password, nick)
        @jid = jid
        @password = password
        @drop_name = drop_name
        @muc_password = muc_password
        @nick = nick
        @asset_added_cblist = CallbackList.new
        @asset_deleted_cblist = CallbackList.new
        @self_join_cblist = CallbackList.new
        @join_cblist = CallbackList.new
        @leave_cblist = CallbackList.new
        @message_received_cblist = CallbackList.new
      end

      def on_asset_added(&block)
        @asset_added_cblist << block
      end

      def on_asset_removed(&block)
        @asset_deleted_cblist << block
      end

      def on_self_join(&block)
        @self_join_cblist << block
      end

      def on_join(&block)
        @join_cblist << block
      end

      def on_leave(&block)
        @leave_cblist << block
      end

      def on_message_received(&block)
        @message_received_cblist << block
      end

      def self.notify(title, msg)
        begin
          require 'growl'
          Growl.notify msg, :title => title; sleep 0.2
        rescue
          puts "#{title}: #{msg}"
        end
      end

      def connect
        @xmpp_client = Jabber::Client.new(Jabber::JID.new(@jid))
        Jabber::Version::SimpleResponder.new(@xmpp_client, 'drop.io xmpp rubyclient', Dropio::XMPP::VERSION, "XMPP4R-#{Jabber::XMPP4R_VERSION} on Ruby-#{RUBY_VERSION}")
        @xmpp_client.connect
        @xmpp_client.auth @password
        @muc_client = Jabber::MUC::SimpleMUCClient.new(@xmpp_client)
        @muc_client.on_message do |time,nick,text|
          @message_received_cblist.notify_event time, nick, text
        end
        @muc_client.on_join do |time,nick|
          @join_cblist.notify_event [time, nick]
        end
        @muc_client.on_leave do |time,nick|
          @leave_cblist.notify_event [time, nick]
        end
        @muc_client.add_message_callback do |m|
          doc = REXML::Document.new(m.to_s)
          begin
            if not REXML::XPath.match(doc, "message/x/attribute::xmlns").empty?
              next
            end
          rescue Exception => e
            puts e.message
          end
          begin
            parse_message(doc)
          rescue Exception => e
            puts e.message
          end
        end
        @muc_client.join("#{@drop_name}@conference.drop.io/#{@nick}", @muc_password)
      end

      private
      def parse_message(doc)
        doc.elements.each "message/body" do |e|
        end
        doc.elements.each "message/dropEventData" do |e|
          parse_drop_event(doc)
        end
      end

      def parse_drop_event(doc)
        evt = REXML::XPath.match(doc, "message/dropEventData/event").first.text
        case evt
        when  'assetAdded'
          asset_name = REXML::XPath.match(doc, "message/dropEventData/params/name").first.text
          @asset_added_cblist.notify_event asset_name
        when 'assetDeleted'
          m = REXML::XPath.match(doc, "message/body").first.text
          @asset_deleted_cblist.notify_event m
        else
        end
      end
    end
  end
end

module Vero
  module Trackable
    module Interface
      def track(event_name, event_data = {}, extras = {})
        track!(event_name, event_data, extras)
      end

      def track!(event_name, event_data = {}, extras = {})
        with_default_vero_context.track!(event_name, event_data, extras)
      end

      def identify!
        with_default_vero_context.identify!
      end

      def unsubscribe!
        with_default_vero_context.unsubscribe!
      end

      def reidentify! previous_id
        with_default_vero_context.reidentify! previoud_id
      end

      def update_user!
        with_default_vero_context.update_user!
      end

      def update_user_tags!(add = [], remove = [])
        with_default_vero_context.update_user_tags! add, remove
      end
    end
  end
end

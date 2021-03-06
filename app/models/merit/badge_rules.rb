# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
      grant_on 'image_annotations#create', badge: 'Newbie Annotator', to: :action_user do |image_annotation|
        image_annotation.user.image_annotations.count == 1
      end
      grant_on 'image_annotations#create', badge: 'Bronze Annotator', to: :action_user do |image_annotation|
        image_annotation.user.image_annotations.count == 5
      end
      grant_on 'image_annotations#create', badge: 'Silver Annotator', to: :action_user do |image_annotation|
        image_annotation.user.image_annotations.count == 20
      end
      grant_on 'image_annotations#create', badge: 'Gold Annotator', to: :action_user do |image_annotation|
        image_annotation.user.image_annotations.count == 100
      end
      grant_on 'image_annotations#create', badge: 'Star Gazer', to: :action_user do |image_annotation|
        image_annotation.text =~ /sky|star|moon/
      end
      grant_on 'image_annotations#create', badge: 'Rover Lover', to: :action_user do |image_annotation|
        image_annotation.text =~ /wheel|rover/
      end      
    end
  end
end

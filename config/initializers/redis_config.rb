# frozen_string_literal: true

require 'redis'

REDIS = Redis.new(Rails.application.config_for('cable'))

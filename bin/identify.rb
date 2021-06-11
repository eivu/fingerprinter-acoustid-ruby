# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'net/http/post/multipart'

requrl = ENV['ACR_CLOUD_REQUEST_URL']
access_key = ENV['ACR_CLOUD_ACCESS_KEY']
access_secret = ENV['ACR_CLOUD_ACCESS_SECRET']


http_method = 'POST'
http_uri = '/v1/identify'
# data_type = 'fingerprint'
data_type = 'audio'
signature_version = '1'
timestamp = Time.now.utc.to_i.to_s

string_to_sign = "#{http_method}\n#{http_uri}\n#{access_key}\n#{data_type}\n#{signature_version}\n#{timestamp}"

digest = OpenSSL::Digest.new('sha1')
signature = Base64.encode64(OpenSSL::HMAC.digest(digest, access_secret, string_to_sign))

file_name = ARGV[0]

sample_bytes = File.size(file_name)

url = URI.parse(requrl)
File.open(file_name) do |file|
  req = Net::HTTP::Post::Multipart.new url.path,
    'sample' => UploadIO.new(file, 'audio/mp3', file_name),
                             'access_key' =>access_key,
                             'data_type'=> data_type,
                             'signature_version'=> signature_version,
                             'signature'=>signature,
                             'sample_bytes'=>sample_bytes,
                             'timestamp' => timestamp
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
  puts(res.body)
end

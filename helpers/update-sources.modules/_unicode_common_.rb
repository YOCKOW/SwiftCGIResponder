=begin
 
 _unicode_common_.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module UNICODE_COMMON
  @@unicode_license_agreement = nil
  def unicode_license_agreement
    if !@@unicode_license_agreement
      require File.realpath('./UnicodeLicenseAgreement.rb', File.dirname(__FILE__))
      filename = (($ROOT) ? $ROOT : File.realpath('../..', File.dirname(__FILE__))) + "/#{UnicodeLicenseAgreement.const_get(:PATH)}"
      File.open(filename) {|file| @@unicode_license_agreement = file.read }
    end
    return @@unicode_license_agreement
  end
end


require 'rails_helper'

RSpec.describe "UnnecessaryRoutes", type: :routing do
  
  it "does not define unnecessary planets routes" do
    expect(post: "/planets").not_to be_routable
    expect(get: "/planets/1").not_to be_routable
    expect(patch: "/planets/1").not_to be_routable
    expect(delete: "/planets/1").not_to be_routable
  end
  
  it "does not define unnecessary missions routes" do
    expect(get: "/missions").not_to be_routable
    expect(get: "/missions/1").not_to be_routable
    expect(patch: "/missions/1").not_to be_routable
    expect(delete: "/missions/1").not_to be_routable
  end

end

module Spec
  module DSL
    describe SupportsPending do
      
      it 'should raise an ExamplePendingError if no block is supplied' do
        lambda {
          include SupportsPending
          pending "TODO"
        }.should raise_error(ExamplePendingError, /TODO/)
      end
      
      it 'should raise an ExamplePendingError if a supplied block fails as expected' do
        lambda {
          include SupportsPending
          pending "TODO" do
            raise "oops"
          end
        }.should raise_error(ExamplePendingError, /TODO/)
      end
      
      it 'should raise a PendingFixedError if a supplied block starts working' do
        lambda {
          include SupportsPending
          pending "TODO" do
            # success!
          end
        }.should raise_error(PendingFixedError, /TODO/)
      end
    end
  end
end

require 'spec_helper'

describe ApplicationHelper do
  describe "#tab_link_to" do
    subject { helper.tab_link_to('My Link', {:controller => 'sobre'}) }

    context "matching params" do
      before(:each) do
        params[:controller] = 'sobre'
        params[:junk] = 'junk'
      end
      it { should have_tag('a[class=menu_select]') }
    end

    context "non-matching params" do
      before(:each) do
        params[:controller] = 'eventos'
        params[:junk] = 'junk'
      end
      it { should have_tag('a[class=menu_inicial]') }
    end

    context "url with both controller and action matching" do
      subject { helper.tab_link_to('My Link', {:controller => 'sobre', :action => 'colaboradores'}) }
      before(:each) do
        params[:controller] = 'sobre'
        params[:action] = 'colaboradores'
        params[:junk] = 'junk'
      end
      it { should have_tag('a[class=menu_select]') }
    end

    context "url with both controller and action, but action doesn't match" do
      subject { helper.tab_link_to('My Link', {:controller => 'sobre', :action => 'colaboradores'}) }
      before(:each) do
        params[:controller] = 'sobre'
        params[:action] = 'index'
        params[:junk] = 'junk'
      end
      it { should have_tag('a[class=menu_inicial]') }

    end
  end
end

# require 'rails_helper'
#
# describe TasksController do
#
#   before do
#     User.delete_all
#     Project.delete_all
#   end
#
#   include ObjectCreationMethods
#
#
#   describe "#index" do
#
#     it "redirects visitors to the login page" do
#       get :index
#       expect(response).to redirect_to(signin_path)
#     end
#
#     it "allows users to view index" do
#       @user = create_user
#       session[:user_id] = @user.id
#       get :index
#       expect(response).to render_template("index")
#     end
#   end
#
#   describe "#new" do
#
#     it "does not allow visitors to create a project" do
#       project = create_project
#       get :new, project: project
#       expect(response).to redirect_to(signin_path)
#     end
#
#     it "allows users to create a task" do
#       user = create_user
#       project = create_project
#       create_membership(user: user, project: project)
#       session[:user_id] = user.id
#       get :new
#       expect(response.status).to eq(200)
#     end
#
#   end
#
#   describe "#create" do
#
#     it "does not allow visitors to create a project" do
#       get :create
#       expect(response).to redirect_to(signin_path)
#     end
#
#     it "allows users to create a project" do
#       user = create_user
#       session[:user_id] = user.id
#       post :create, {project: {name: "Test"}}
#       expect(response.status).to eq(302)
#     end
#
#   end
#
#   describe "#show" do
#
#     it "allows members to view show page" do
#       @user = create_user
#       @project = create_project
#       create_membership
#       session[:user_id] = @user.id
#       get :show, id: @project.id
#       expect(response).to render_template("show")
#     end
#
#   end
#
#   describe "#update" do
#
#     it "does not allow non-owners to edit" do
#       user = create_user
#       project = create_project
#       session[:user_id] = user.id
#       put :update, {project: {name: "test"}, id: project.id}
#       expect(response.status).to eq(404)
#     end
#
#     it "allows owners to edit" do
#       user = create_user
#       project = create_project
#       session[:user_id] = user.id
#       create_ownership(user: user, project: project)
#       put :update, {project: {name: "test"}, id: project.id}
#       expect(response.status).to eq(302)
#     end
#
#   end
#
#   describe "#destroy" do
#
#     it "allows owners to destroy projects" do
#       user1 = create_user
#       user2 = create_user
#       project = create_project
#       create_ownership(user: user1, project: project)
#       create_ownership(user: user2, project: project)
#       session[:user_id] = user1.id
#       get :destroy, id: project.id
#       expect(response.status).to eq(302)
#     end
#     it "does not allow members to destroy projects" do
#       user1 = create_user
#       user2 = create_user
#       project = create_project
#       create_membership(user: user1, project: project)
#       create_ownership(user: user2, project: project)
#       session[:user_id] = user1.id
#       get :destroy, id: project.id
#       expect(response.status).to eq(404)
#     end
#
#   end
#
#   describe "#edit" do
#
#     it "allows owners to edit projects" do
#       user = create_user
#       project = create_project
#       create_ownership(user: user, project: project)
#       session[:user_id] = user.id
#       get :edit, id: project.id
#       expect(response.status).to eq(200)
#     end
#     it "does not allow members to edit projects" do
#       user = create_user
#       project = create_project
#       create_membership(user: user, project: project)
#       session[:user_id] = user.id
#       get :edit, id: project.id
#       expect(response.status).to eq(404)
#     end
#
#   end
#
# end

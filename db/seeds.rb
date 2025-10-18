# db/seeds.rb
puts "Limpando dados antigos..."
UserRole.destroy_all
Role.destroy_all
User.destroy_all

puts "Criando papéis (Roles)..."
admin_role = Role.create!(title: "admin")
moderator_role = Role.create!(title: "moderator")
student_role = Role.create!(title: "student")
puts "Papéis criados."

puts "Criando usuários..."
admin_user = User.create!(
  name: "Administrador",
  email: "admin@gmail.com",
  password: "senha123",
  password_confirmation: "senha123"
)
admin_user.roles << admin_role

moderator_user = User.create!(
  name: "Moderador",
  email: "moderator@gmail.com",
  password: "senha123",
  password_confirmation: "senha123"
)
moderator_user.roles << moderator_role

student_user = User.create!(
  name: "Estudante",
  email: "student@gmail.com",
  password: "senha123",
  password_confirmation: "senha123"
)
student_user.roles << student_role

puts "Usuários e papéis criados com sucesso!"
puts "---"
puts "Admin: admin@gmail.com | Senha: senha123"
puts "Moderador: moderator@gmail.com | Senha: senha123"
puts "Estudante: student@gmail.com | Senha: senha123"
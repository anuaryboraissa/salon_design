class LoginUser {
	String? firstName;
	String? lastName;
	String? email;
	String? type;
	int? id;


	LoginUser({
		this.firstName, 
		this.lastName, 
		this.email, 
		this.type, 
    this.id
	});

	factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				email: json['email'] as String?,
				type: json['type'] as String?,
				id: json['id'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'first_name': firstName,
				'last_name': lastName,
				'email': email,
				'type': type,
        "id":id
			};
}

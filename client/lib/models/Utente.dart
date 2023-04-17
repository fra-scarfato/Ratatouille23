class Utente{

  late int _id;
  late String _nome;
  late String _cognome;
  late String _email;
  late String _password;
  late String _ruolo;
  late int _id_ristorante;

  Utente(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante){
    _id=id;
    _nome=nome;
    _cognome=cognome;
    _email=email;
    _password=password;
    _ruolo=ruolo;
    _id_ristorante=id_ristorante;

  }

  Utente.senzaId(String nome, String cognome, String email, String password, String ruolo, int id_ristorante){
    _nome=nome;
    _cognome=cognome;
    _email=email;
    _password=password;
    _ruolo=ruolo;
    _id_ristorante=id_ristorante;

  }

  Utente.fromJson(Map<String, dynamic> json):
    _id=json['id'],
    _nome=json['nome'],
    _cognome=json['cognome'],
    _email=json['email'],
    _password=json['password'],
    _ruolo=json['ruolo'],
    _id_ristorante=json['id_ristorante'];


  Map<String,dynamic> toJson(){
    return {
      'id':_id,
      'nome':_nome,
      'cognome':_cognome,
      'email':_email,
      'password':_password,
      'ruolo':_ruolo,
      'idRistorante':_id_ristorante
    };
  }

  Map<String,dynamic> toJsonWithoutId(){
    return {
      'nome':_nome,
      'cognome':_cognome,
      'email':_email,
      'password':_password,
      'ruolo':_ruolo,
      'idRistorante':_id_ristorante
    };
  }

    void set_id(int id){_id=id;}
    void set_nome(String name){_nome=name;}
    void set_cognome(String cognome){_cognome=cognome;}
    void set_email(String email){_email=email;}
    void set_password(String password){_password=password;}
    void set_ruolo(String ruolo){_ruolo=ruolo;}
    void set_id_ristorante(int id_ristorante){_id_ristorante=id_ristorante;}

    int get_id(){return _id;}
    String get_name(){return _nome;}
    String get_cognome(){return _cognome;}
    String get_email(){return _email;}
    String get_password(){return _password;}
    String get_ruolo(){return _ruolo;}
    int get_id_ristorante(){return _id_ristorante;}
  }

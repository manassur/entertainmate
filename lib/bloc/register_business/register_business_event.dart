import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterBusinessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisteringBusinessEvent extends RegisterBusinessEvent {
  String name, type, description, slogan, phone, email, location, time, website, more;
  File image;

  RegisteringBusinessEvent({@required this.name, this.type,
    this.description, this.more,
    this.location, this.email, this.phone,
    this.slogan, this.time, this.website,this.image});
  @override
  List<Object> get props => [];
}



import 'package:flutter/material.dart';

import 'package:totp_flutter/pages/home.dart';
import 'package:totp_flutter/style.dart';

void main() => runApp(const App());

class App extends StatelessWidget
{
	static const String appTitle = 'TOTP Generator';
	const App({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) 
	{
		return MaterialApp(
			title: 'Flutter App',
			home: const HomePage(title: appTitle),
			theme: ThemeData(primarySwatch: appColor), 
		);
	}
}


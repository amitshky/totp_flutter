import 'dart:async';
import 'package:flutter/material.dart';

import 'package:totp_flutter/api/totp.dart';

class HomePage extends StatefulWidget 
{
	final String title;
	const HomePage({Key? key, required this.title}) : super(key: key);

	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
	Timer? timer;
	// TODO: stop timer when not needed and initialize timer and totp and stuff when needed
	int unixTime = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
	String totp  = TOTP.generateTOTP((DateTime.now().millisecondsSinceEpoch / 1000).floor());
	int timeRemaining = 30 - ((DateTime.now().millisecondsSinceEpoch / 1000).floor() % 30);

	@override
	Widget build(BuildContext context) 
	{
		return Scaffold(
			appBar: AppBar(title: const Text('TOTP Generator'), centerTitle: true),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						buildTOTP(),
					],
				),
			),
		);
	}

	Widget buildTOTP()
	{
		timer = Timer.periodic(const Duration(seconds: 1), (_)
		{
			setState(()
			{
				unixTime = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
				if ((unixTime % 30) == 0)
				{
					totp = TOTP.generateTOTP(unixTime);
				}
				timeRemaining = 30 - (unixTime % 30);
			});
		});
		
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				Text(totp, style: Theme.of(context).textTheme.headline2), 
				SizedBox(
					width : 35,
					height: 35,
					child: Stack(
						fit: StackFit.expand,
						children: [
							Center(child: Text('$timeRemaining')),
							CircularProgressIndicator(
								value: 1 - (timeRemaining / 30),
								backgroundColor: Colors.grey[300],
							)
						],
					),
				),
			],
		);
	}

	void stopTimer()
	{
		setState(() => timer?.cancel());
	}
}
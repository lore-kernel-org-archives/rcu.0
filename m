Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3936F917;
	Sat, 10 Oct 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621826; cv=fail; b=HJDmWQBxNqhf8JVd45Ow9s/8Jbtx8Ci/ZnrnuMyQpY9lq1t4TXtmwGEAfSnLHnYzCWvOTLDajcC0P7gVCcQ0Fv5QLK91SAE1iAK6tMCyddwUDbbP4zj8JERow2Mul6dkQsZRwnlo5Ac8/LEevrsK90uZtNNg8i0iMzpwgxj/wxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621826; c=relaxed/simple;
	bh=2OhHqY2+KkP5WJM7oPwEZQOVNgH+sG3AJimLo80562Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GnnIyxR9IqFOhMjn6t8Xtjn+w3FFXzq7C29xKalE6jeAVSXW2YweKU0X9HYePGVXwAdhcjUVP2tPDjmeDGuM6FKJd0+nsUOg5kzCppfdkiZYTVggJrbgmh8XYpMfsZssMBtITLA5m8Cxjw1/slITAUa3raT6XUjL0ya5VfpzoA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIeWCuT1; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIeWCuT1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiRJ+n8gAcXr9g1jSaqqY+SA483x2eog8SzTOZVmfZTva2qXeR+ZVSXhkBvbkgDHlUPgZysG/lEB6/tpBmIgc1UCbw21WTf5tt9u9g4aTSkShMpG8QEec+Xke3juLxeJ6OwhBOz5Cr5lYpB6d/4tbWmls7IfrzVesZCvW/yk2Fp7yrU8fp5UtaEtQdXfSVxWWu8k7psQmQEvS6OiWtuCvCpsqYGVjIVX6EzGvCZFQ798syonhLkstmB7ILBLiFETgBmUO7t3as9Kpe9xElkFdOMF8RqAFJaoe/aSgWCMmUB42DIP1VuYiKEcJkXJo9LJV7CHspsKawG9mUOatEu5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OhHqY2+KkP5WJM7oPwEZQOVNgH+sG3AJimLo80562Y=;
 b=KF+/I2F/FIBU9yZbeZMXzvSrSGlIQJDvNDXjsMW8rIFVRCBgTEN01gpIJQrJvgZmGoNDTHdN94/YcfTF1BjvojOLWSay8i8eQfQsWq6bsH6ZJwhvBwGZKfLVUq4fOmMtQhNG26mN+33pc6aHvshxBOXHqrdMJ7C+BHnoxdLJtXBO19wwkQ1cZtWtqMOYJNI+2Zps46gaNG1mM6jmo05lIydF/UxyYkYbqA+wSKvmDbBY9h7aQar4/Rl6LPwiZ8gQsPsUKSrhbyI0n7kPATZpKY/WbMm4Y84hgUcfDEMm4iOSh3aTLWqmlAzts4i5F28iYagO1Hh9OCYzyGSMqjetwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OhHqY2+KkP5WJM7oPwEZQOVNgH+sG3AJimLo80562Y=;
 b=ZIeWCuT1D8XInAWL0cHv/LBc6OfVXjXQlr/+NjLOH9tZf+xy5DDqvmk4PTiM60/tFL2Ja3KqcmYYGiZVTzz6WVTBYRocaAjzzG8pfFa7q2ZLKpTLB7liKPqI/NtPKsyvQRF8t4E/X0DngWeOdaHtfe2CMMkfRj3KvAuxrIKhBb0MY69ZjXtTHmSAKwVvXNfZOWl7eeO53d4u4bcTdnZ7FIAbD5HumS9BAPC0+8+srYQyobmv+k0XvAS2zuX5tr6RIpz4seWYut3gE2N3EhveV4SvDnj9TppDDzhUbdIcmBAc9ndBWUcIF400OffgoYraRtNiJZehcFH0gSWl9EodGA==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 08:43:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 08:43:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"boqun@kernel.org" <boqun@kernel.org>, "kunwu.chan@gmail.com"
	<kunwu.chan@gmail.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>
Subject: Re: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
Thread-Topic: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
Thread-Index: AQHdWJG6Xx8gGSqCpkCFZk3+o60zu7b2db5M
Date: Sat, 10 Oct 2026 08:43:38 +0000
Message-ID: <FCDF3652-74F1-4EA4-B39E-3F74F1EAF5B5@nvidia.com>
References: <20261010083107.15086-1-qiang.zhang@linux.dev>
In-Reply-To: <20261010083107.15086-1-qiang.zhang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|MW4PR12MB7168:EE_
x-ms-office365-filtering-correlation-id: e798eda8-459e-41bf-9533-08df26aa9450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|22082099003|261009223027099003|3023799007|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 ph1kLfduhZ//WaYekubF1/x6Ry1B2YcdtzN8Xk4XAo6IFyA/+/oaZmKLiE8n6pukWkkOcFOZtNJmka8nlx98kO8MsZyCH1OT4/ZleTvc1+8x6qtuY0PBvwmY+8yA+GMYTigD6/zxemvLyFHhjyGr88pgU82KU1ujVo7JXIQxnaHzim/pfEQfwEuUgl3XzHULOTmiVG7YuuZ/Q1SYOLh7+Le++oHImYuts5Dlgs45IRalLiI9jud8cg6Sznxq2Ny3lko0Vqcr2MyBdJc3mUHshPLPL8qXQZQKsEjcA+AJLOMQ0liwgShfOESQCnfPlWgtOw53/Q7yfcIW+hsN470QamnkI8cZNrxqVTviihDFhwj5Ob2F4HUI3aucs9ceOFE8ARcoGdo+UvBRi4GD15/NDWPmCT7+8smT1D6PBDC57+w0FRlXlDsHwljxSSSrVY4K6nq3CdwtoiL3abclt4gVNm2hboafBJ1xcyG4sP4Pei9soQXaM15WzH88DONTNCFhB4Qk5OVg4UaoP4Nl4bZ3bW2DGM1g7N+L72/ravmRG3yOQBUXi1qNz2Vx1jXIb4j4YrK0HKiHy7aaoUuAKKN1gSE+ZkmSpzqt3KUW2dxVzfhoiEOdZWZ12336yn5zFBSR6mWgt9VB2ImY2UNkpyqccqk8xDj8t6ffj7kFyYJvsjYVfcri1/u1Nx4u0lHv6FWFbquamWdkV2X8Iox2dgBmn62fJSDSFtr+d/XeElh1JNw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(3023799007)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWhqSDgrOEF1YWF0ZUVYUVlmU3Z3K1hXQitZTkE3MEtiWWdwd2hjY0VJYnBD?=
 =?utf-8?B?cGt6aXdnaEQrQnFqR29SbDc2OGk4KzR4bGFOekJTWHBML2l2MU1BYmwxNU8z?=
 =?utf-8?B?ZkxpYTJQTkxHYi9Kb01XYlAwQnZjbzZaeWZOYTd5N0taRWt6WEl3c05pc0c0?=
 =?utf-8?B?a3hZM0dFQnJLMXdQd1R4K3lWcTFIYmxNVUdpaFYzQWx3T0w3a3liV0ZiTkQz?=
 =?utf-8?B?bC84NWVvdUtNVXRSOHZOTUNlc0cwS291dE9rWEtOM2U5c3lNcks4TVl6OWNl?=
 =?utf-8?B?SE9VOTN2WTV5Vm53Z3N1RFhKNWVwR3h1S1hEZnJLZ2Nvb2hSUkYrRnV2UmhV?=
 =?utf-8?B?WFBPa3Bja1Rjb0dwNFc0N3B4QUlLWmF2Nk5ia0tZN2o5VHUzL05kRURCdjNw?=
 =?utf-8?B?VDVTWVBmZERlcDk0QXFwMi8ydHJiL09vQ1ZrZUJWZXVja1dyMmNmUk5QWVk4?=
 =?utf-8?B?eGQyNVg4K3VaT09HRmlDam9UMi9EdHp0S25yTmovTmV6aFpKMi9BaVQzUmk1?=
 =?utf-8?B?RHgvVU9VajlPKzNzMXhLOVBJRFFMdDl0KzdCU1NVUjZwOStjYVVMSGhJRFl6?=
 =?utf-8?B?YUxQRFhoVW82NzZNYlVVZnpPODFzVkt4ZHIxL2Rzb1d2aW1sSVJiL3BiZUx2?=
 =?utf-8?B?eWYwZWRlSnhQRXJ4dUJDZlN6NXc0bDNESzAzaG9NR2pTeUExZTNSWmVjMlpM?=
 =?utf-8?B?bzJmRnlpU1RTb3pqTmpJSElqRnBhWnROZXlTQXcxbUhMRTNwbUxhdzdxNS9t?=
 =?utf-8?B?aGVqVWtGVnM2OWY0SjdHa045c25WNzZtOFlvOVh4Rkp1QnFxTGFiZ2R2Mk5i?=
 =?utf-8?B?eXptRldaZ1oyS212b2owK3U5clVJdmtpQ2E4VVRRY0IvWTVUbDIxOWg4aWx4?=
 =?utf-8?B?c2U4bmRUTnlIcSt4dkFnMG44clpJUzdVUENMRnBFVCtQOXRBRUFncncvNFVz?=
 =?utf-8?B?UzVjOTNBM0c2Mld4WW1XamszZitCNm5yQmJUTW9lMmdZdE1wUnVmdWFrT1hv?=
 =?utf-8?B?MmZhREMxN1BMNGpNTncvVTVFQnAwOFlXai9MSWRGTzlZbDhtQlJuSDliUTdl?=
 =?utf-8?B?aTVpbWZJaHpUZ1BKRmJXUEZMMTdLN1k5ZkhIWWd2VDRYd2V5ZzNOL0RaTFRl?=
 =?utf-8?B?Zy9Sd3J1aFNYd3JvL1FBRjdHM0VLNFdGWlEvYzhBZVBsRWVVUGVib2xNZzNB?=
 =?utf-8?B?akFjQ3MwMUlPbXhsTFNYajU4bm8yVHBIV21GbndFdUZQQXFBY3JneFY5cXlG?=
 =?utf-8?B?bCtMcWM0K0hqRmtUak14dUVIVDdNR29WbmxEeTk1d3Nibkh3NkE5TDd3eWRY?=
 =?utf-8?B?dWdDS01KZ05Rak9DaDg5c2VCcGdJZzVJb01oUThUek9aUEt6elpHZGF3QmpU?=
 =?utf-8?B?cEQ1QVNTcVhjR3V6YTVnd05DWjNuNzVmWWJWSmZkZXJxTjZaa1FFU1UvYXJt?=
 =?utf-8?B?RmR4OWpndXBHdzNpb3JaQjN4YXZ5cWsvYnhOS3lpMzh6YjJTdFhnaEZjVEhZ?=
 =?utf-8?B?VU5oQlpUOHZKajN5M2krRVM1VXRCYXltNHZEZEllZ0ZiTVZTWkJXN0lPTjNV?=
 =?utf-8?B?VFo4eUEzOXFyQmpFWDE2UXQvOWo2WWc0WUhTcjRPU2JJcDJmNE8xZytDaWNh?=
 =?utf-8?B?bk10MFVkUnIxZXVseUFvK0hWRlZpYm1JZVVZc2FCL1BBbjlRa0Z4TFpKWnhC?=
 =?utf-8?B?WForWkp1Z2d6MDRvUFRyTHgrS0VMaXFSWDdJM0hZOEE0ZDhWZnkrdnJMakM4?=
 =?utf-8?B?Y2pyYzUzc1ZrVDJHdjVxWGIvMi9Rd0FBWFMyR1RBVml2aVY0cWkvbGFJSkxV?=
 =?utf-8?B?anN4MWlVMGdLWTJ2dGo1VmNmbkE5UFJMajJFc3VCay9nNFkrSXNSUUFRVW5Z?=
 =?utf-8?B?RDVqZUtETHQxRldZY0Z6Slp5aVZiWlpHa1FDeWhCRzV6L2FkUHpMdzZIbVZt?=
 =?utf-8?B?MGlzZS9qc3VlQzBlY1VKaVJBdFRJRmVTLzZ0QmNOeGZSRS91KytZek8va2N0?=
 =?utf-8?B?azIwbFp5bWpxNTQ0c0lyYlBPc0RnQkszOGRKTkZnRy9NUENndktZVU1RczBm?=
 =?utf-8?B?ZmM0R3VWTkRsTlUrYW15eDFMY2lSVWM2a3NKb3ZHcVUvY1hsOTBvT20ybUNl?=
 =?utf-8?B?M09ZeDlJS05LQTdyTDJSMUZpWUVIZ0s5UVpnZ01JcVY2ZXRMdWwvdEVNb0FY?=
 =?utf-8?B?eXVxY3FBa2M5S0lmZDFpcjdoMlNueWJ3bW1jUHF5eEFBenpqZ2JHMkxBeVZF?=
 =?utf-8?B?eEVVOWlBV2NWSFdOZ0d6SUVzcmJTZ3lsOUZQeSs3OG9EcklvbzVtMzAvZ0lG?=
 =?utf-8?B?ekpKYUlCM3QrTFlEVUVPZHdpWUtzMmZuVXB2WGhkenR2ZDFpMTNBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e798eda8-459e-41bf-9533-08df26aa9450
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 08:43:38.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZ6whe3R9VUobkJbA/tZ1Rysfgn1o/QxorxCCOGpMB/TQp4PdktYY/CekY1ZKupWXP1M/puzqChmQkeLCZAZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

DQoNCj4gT24gT2N0IDEwLCAyMDI2LCBhdCA0OjMx4oCvQU0sIFpxaWFuZyA8cWlhbmcuemhhbmdA
bGludXguZGV2PiB3cm90ZToNCj4gDQo+IO+7v1RoZSBmb2xsb3dpbmcgY29tbWl0IGludHJvZHVj
ZXMgc29tZSBuZXcgQVBJczoNCj4gDQo+IGNvbW1pdCAnZGFiMDZkNmY5Mzc5ICgic3JjdXRyZWU6
IEFkZCBhbiBhdG9taWMgVHJlZSBTUkNVIiknDQo+IGNvbW1pdCAnOGRmMTNmMDE2MDhlICgicmN1
OiBBZGQgZnVsbC1zaXplZCBwb2xsaW5nIGZvciBjb25kX3N5bmNfZXhwX2Z1bGwoKSIpJw0KPiBj
b21taXQgJ2Q5NmM1MmZlNDkwNyAocmN1OiBBZGQgcG9sbGVkIGV4cGVkaXRlZCBncmFjZS1wZXJp
b2QgcHJpbWl0aXZlcyknDQo+IA0KPiBzeW5jaHJvbml6ZV9zcmN1X2F0b21pYygpLCBjb25kX3N5
bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBhbmQNCj4gY29uZF9zeW5jaHJvbml6ZV9yY3VfZXhw
ZWRpdGVkX2Z1bGwoKS4NCj4gDQo+IFNhbXBsZSBvdXRwdXQgd2hlbiBydW5uaW5nIHJjdXRvcnR1
cmU6DQo+IA0KPiBAY291bnRzW3N5bmNocm9uaXplX3NyY3VdOiA0OA0KPiBAY291bnRzW3N5bmNo
cm9uaXplX3JjdV9leHBlZGl0ZWRdOiA3NA0KPiBAY291bnRzW3N5bmNocm9uaXplX3JjdV06IDEw
Mg0KPiBAY291bnRzW3BvbGxfc3RhdGVfc3luY2hyb25pemVfcmN1X2Z1bGxdOiA0NDMNCj4gQGNv
dW50c1tjYWxsX3JjdV06IDI0OTgNCj4gQGNvdW50c1tzeW5jaHJvbml6ZV9zcmN1X2F0b21pY106
IDg3MTcNCj4gQGNvdW50c1twb2xsX3N0YXRlX3N5bmNocm9uaXplX3NyY3VdOiAxNDg0OQ0KPiAN
Cj4gQGNvdW50c1tjYWxsX3NyY3VdOiAyMg0KPiBAY291bnRzW3N5bmNocm9uaXplX3JjdV06IDEw
Mw0KPiBAY291bnRzW3N0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1XTogMTA5Mw0KPiBAY291bnRz
W2NvbmRfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZF06IDUzMzkNCj4gQGNvdW50c1tjb25kX3N5
bmNocm9uaXplX3JjdV9leHBlZGl0ZWRfZnVsbF06IDUzNzUNCj4gQGNvdW50c1tzeW5jaHJvbml6
ZV9yY3VfZXhwZWRpdGVkXTogODEzNA0KPiBAY291bnRzW2dldF9zdGF0ZV9zeW5jaHJvbml6ZV9y
Y3VfZnVsbF06IDE3MjQ4DQo+IEBjb3VudHNbZ2V0X3N0YXRlX3N5bmNocm9uaXplX3JjdV06IDE3
MjY2DQo+IEBjb3VudHNbY2FsbF9yY3VdOiAxMTkxNjgNCj4gDQo+IFRoaXMgY29tbWl0IHRoZXJl
Zm9yZSBhZGQgdGhlbXMgdG8gcmN1LXVwZGF0ZXJzLnNoIHNjcmlwdC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAbGludXguZGV2Pg0KPiAtLS0NCg0KTmljZSwgVGhh
bmtzISwgQ291bGQgeW91IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiB0b28gYW5kIGluY2x1ZGUg
aW4gdGhpcyBzZXJpZXM/DQoNCj4gdG9vbHMvcmN1L3JjdS11cGRhdGVycy5zaCB8IDMgKysrDQo+
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29s
cy9yY3UvcmN1LXVwZGF0ZXJzLnNoIGIvdG9vbHMvcmN1L3JjdS11cGRhdGVycy5zaA0KPiBpbmRl
eCA4YTVkZjNmMjI1NTAuLmEwZjAzYTE0NGY2YSAxMDA3NTUNCj4gLS0tIGEvdG9vbHMvcmN1L3Jj
dS11cGRhdGVycy5zaA0KPiArKysgYi90b29scy9yY3UvcmN1LXVwZGF0ZXJzLnNoDQo+IEBAIC0z
NCw2ICszNCw3IEBAIGJwZnRyYWNlIC1lICdrcHJvYmU6a3ZmcmVlX2NhbGxfcmN1LA0KPiAgICAg
ICAgIGtwcm9iZTpzeW5jaHJvbml6ZV9yY3VfdGFza3NfdHJhY2UsDQo+ICAgICAgICAga3Byb2Jl
OnN5bmNocm9uaXplX3NyY3UsDQo+ICAgICAgICAga3Byb2JlOnN5bmNocm9uaXplX3NyY3VfZXhw
ZWRpdGVkLA0KPiArICAgICAgICAga3Byb2JlOnN5bmNocm9uaXplX3NyY3VfYXRvbWljLA0KPiAg
ICAgICAgIGtwcm9iZTpnZXRfc3RhdGVfc3luY2hyb25pemVfcmN1LA0KPiAgICAgICAgIGtwcm9i
ZTpnZXRfc3RhdGVfc3luY2hyb25pemVfcmN1X2Z1bGwsDQo+ICAgICAgICAga3Byb2JlOnN0YXJ0
X3BvbGxfc3luY2hyb25pemVfcmN1LA0KPiBAQCAtNDQsNiArNDUsOCBAQCBicGZ0cmFjZSAtZSAn
a3Byb2JlOmt2ZnJlZV9jYWxsX3JjdSwNCj4gICAgICAgICBrcHJvYmU6cG9sbF9zdGF0ZV9zeW5j
aHJvbml6ZV9yY3VfZnVsbCwNCj4gICAgICAgICBrcHJvYmU6Y29uZF9zeW5jaHJvbml6ZV9yY3Us
DQo+ICAgICAgICAga3Byb2JlOmNvbmRfc3luY2hyb25pemVfcmN1X2Z1bGwsDQo+ICsgICAgICAg
ICBrcHJvYmU6Y29uZF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkLA0KPiArICAgICAgICAga3By
b2JlOmNvbmRfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZF9mdWxsLA0KPiAgICAgICAgIGtwcm9i
ZTpzdGFydF9wb2xsX3N5bmNocm9uaXplX3NyY3UsDQo+ICAgICAgICAga3Byb2JlOnBvbGxfc3Rh
dGVfc3luY2hyb25pemVfc3JjdSwNCj4gICAgICAgICBrcHJvYmU6cmN1X2dwX2luaXQNCg0KQWNr
IG9uIHRoaXMgcGF0Y2guDQoNCg0KPiAtLQ0KPiAyLjE3LjENCj4gDQo=

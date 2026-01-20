Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D435BDDE;
	Tue, 20 Jan 2026 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949143; cv=fail; b=PJbd8MvZpCLGDZyybowuGPQlPa6fo24XE07so5IwUUPdOX9ivN7dTslTERMV8TxZ2DkLP+F1cIFaAeEmI/26J1XP23UfXgtbi8LWbMmsclaSI7WH8riXwDcKNvoaWqY0Ewx7TRlEWVcCbLWt1Xhxu3EEr+exV5wKlFNqFmuoOTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949143; c=relaxed/simple;
	bh=xiZBPGKwlDm3ASXJJCn6oh1a6+mYYECGtD0T+3+ZLYk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FWx1oubWequL5g8BSWAsON5kCne9CA+A48dfnQFmpw5LzzG9uH7ndyuRYiZT+2/PEjk77+MoGhJpZNzQtACiihWVSno1c/EvXfQRbfSg2RwCiYu7bDlymF5LWIORleec22pejN6BN7cr1SE6uNy0WCxw2UD2nlPC3baJ1nEumq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dSVZaeZQ; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dSVZaeZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuDSQ+Rt3Ps52cBalvzFCPr2epfryXLtiCigOy2lEFbT02G51hWaZJ5XuzA43gkXHgPT5NNI+GuLVDb/z09eyO/yrlpuDa+XgmxwIUqQ+XLJO+uIWTl7V9RE+YL0PMSaeQFcMv/Np10S5E4VyR+O7mj2gkqn0lLw4JsYQ0KjLPzTyyPNpNoVCjnxT0/TkuLSEbP+eoQ1jzRLYc4I+2QEB4HU3VRGoaTku+uxx4whNd4HgWbR0txvgJGTnJvRy9oPGe7/xhHO0hWw3B7NghpLrFwBh3NXPOzuvT6EyAqgbJAeZgpenzLHcks8oqPc53Kw1HeAP13vhLVa7q7YHSGIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwDcvpxf4ioWmV+WqYfpqfywgqYHY/Guc4MGkzGrI94=;
 b=He4ccvz+Q+Rx9H3dwMLV+8JCAv6IVF/r2ewRxUnE/m4h+8xilfzy0eCzPyGJkVRusiJI5wQWQeUI3blu9mYtTSpeUYxMrouDnw5EFsdVgqkxnJCXwIPut43aIpxyS2OmdkBnNTaKtY/NAzZ2g1PapLssjdonIsgC6G7WUsfF7kWa8sQonCOvUAOVWy5OCJRSvfqF6DRS8BVHEkZuieulFRc6IDPhVsQisqHrDuleGTr/SU3JXZfaod+QpUzAzYz+ScRt1BvNd1BAfcYDda5sBxF/F9GzPvbagvz9Xo9gLdxrO0pI2wJmQdu1sr+FxG9fkp6T0y/py0v8Jt1118fwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwDcvpxf4ioWmV+WqYfpqfywgqYHY/Guc4MGkzGrI94=;
 b=dSVZaeZQQeJy+NSodjcBec4Kq/yDCEGi9uWRMTIucjfo1ipabsWWOmgZQYyqAg05gja6T7Gq+KN7P1DHBii9V0vjFCuiUxLsvbMNapBrFTDxf8+dkwty/4VHYGeJR1PKjqkztIO1TACOwmFa7oBcikz9GsqFs9U/bzADJZF5c9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8737.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 22:45:37 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:45:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 22:45:36 +0000
Message-Id: <DFTS4UL18RUZ.18Z42RM6T7E9E@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Dirk Behme" <dirk.behme@de.bosch.com>, "Dirk
 Behme" <dirk.behme@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: sync: atomic: Clarify the need of
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260120140503.62804-1-boqun.feng@gmail.com>
 <20260120140503.62804-2-boqun.feng@gmail.com>
 <DFTKOAJE7DSB.1QJWJVC4FJY0O@garyguo.net> <aW_ttGVK11On-SIW@tardis-2.local>
In-Reply-To: <aW_ttGVK11On-SIW@tardis-2.local>
X-ClientProxiedBy: LO2P265CA0467.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: a5668e30-01b5-421d-1412-08de5875a128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmpvSjZHRlpwcWFCSTA3VklOTCtYTGZPWUZqK0xndVl2R0cvWFhjS0QrT2dk?=
 =?utf-8?B?ekhYTDVoWkZuZXcrbFZWY1dRbG5nQ0I3WlZXaG5Ic2l3L252SGo4cEpEYzRT?=
 =?utf-8?B?bC9VL2FZay9nZk5LN1VjTVhTT1c3b0JRelRaZFdQRGt3Qm1zcjJMUWU0UnJH?=
 =?utf-8?B?c2RneHd4VzhtUlFCTUFDVGppQ3JLeURHWmhZU3pMWjFYOU5qaHBBOVhpMjA5?=
 =?utf-8?B?c3VIQk5pVms5QU5qOWw3ZjAvZXNZbXNBWk5PY0tGa3F2TG1wYXJxTUlhTnVp?=
 =?utf-8?B?dG5ZdHRIK3FtL0d1cTZrdjdndmxoMldlMDBKUHJnQk10bGhrNUNTZDlWNExL?=
 =?utf-8?B?eCtRekRoOG01TTFBRmlFcWZNSmQyK0pOcWNxYjg2aCtxYi9CTDdRa0xOMHNl?=
 =?utf-8?B?d1c5anpMSmZEZFBWc2djSENLOXBjM0h5cFAyWEVBelVSMjlrQmlkSnYzRmk5?=
 =?utf-8?B?MkdtQkh3Vm1qWGhXYVg2M1dyUGZiZUVEV2Z0c1RxWWVrY2J5Wm5jZ1hSYWR2?=
 =?utf-8?B?RVN2OGUxN1JTTlRTTjNIcklvNHhXNTVDWXJPbFlGZi9rVWFkb2xXQjEyV1Vi?=
 =?utf-8?B?c0htektmN0JWYUsvdEJ0TjVZRmxBVHhDUk8zaWIyV0hRTlFiU0tZajJtL1Jp?=
 =?utf-8?B?WlhtYTQzRW0wekl6MlY1TXN1eG41VVhseUxmSmZKMFNUSnNqeHNUcUp0ajgy?=
 =?utf-8?B?dGU0VDJOZ0tIajJSaEc1S00zRjZCK25DVHdwRC9jam1kL0J2Um5FYS90THhI?=
 =?utf-8?B?cTlsOU80azBNSGFJd1E2WVlmSUpWSFZkZWQvc2oxMHdCbjgybnJJV0JDcU1W?=
 =?utf-8?B?bURYMldYTnc5SmFWNHB4WGxEQ0JMSW1OS2ZGdTBIVFY1MEJOb3FaWktWQWdm?=
 =?utf-8?B?M0FsZnBCb1U2WDVhUStpVWhKeGVTWFArMjRJeXEvMFFrT20wWEYwT0NocWd2?=
 =?utf-8?B?SmJiNngzdnYxODNVWDFsSXF5eVlhMU9ucTN4SmxZaFQ1TmZmMFplUm1iRkdT?=
 =?utf-8?B?eGdGdVN0bWhNYkdtQ0NFUnRvK1RPclBoSXliUjRCaTkwc2JjVi9EcHl3Yk1N?=
 =?utf-8?B?K0NqWmtjTUcwZ0l4Qk4ydUpkUFpGZnlUbFF3RXRrZDg3TGk5ZVIyOFlUSnBr?=
 =?utf-8?B?SUFUL1hNN2VBUkt6TjcxMjZYa29DOW9nbEFSRjUrTE4xRlM2a2ZXbk1OQmV6?=
 =?utf-8?B?UjZyMVVQUlFTa3JDY0FiSHVrcnBRY2hhTFBPdkZRUDhMM0FXeXFSUkdnV0gy?=
 =?utf-8?B?emlnVGRGNXZYc0ZKYzJsODF3VUhwd21vcTZNaWRudDBxK2k1dlRVelRtZWJy?=
 =?utf-8?B?eTFVdytFeDFVRFpTWndVYjV3VkJ0ZENyZXgxa3oyclI4KzVlZjdmaDVDdWtY?=
 =?utf-8?B?VUlJeURqcUk0NmQyMkZiTnhKV1A1b2hEaE52Z2F2SzFsWEdlZEpYTzd5aEpO?=
 =?utf-8?B?ZFpEUWQ5TGJaYml1dFlVUTZ0QkhHaVA2cm1sVzJaSko1a0c1UmFqd2M4THRY?=
 =?utf-8?B?bDVqeWh6ZXRLem1KcFYzWUpISkRCUE9aVWxBSXpZU21Zamw4aVI2dDFOM1Ir?=
 =?utf-8?B?eUdDZkJSV1FqSWdaeGtGWHJWS2MxRWh1RU91WDVKT3dQVjZyazZqU0gyL0FQ?=
 =?utf-8?B?RTZQaHAvZlRxOGRzZ3ZwSW04bnpvclg2bWErWk5kK1daWi9XWUNlQ014WFg1?=
 =?utf-8?B?WTRESnFMZlhJRHJVTTkxMlp1U0pUTHdFUU1xLzdBMm4xUkExWm56NTcxMTlq?=
 =?utf-8?B?MnR3S0EvTnYvdlNqQ2NQek1Nemc1SDl0US9GY0JIQmVlcnpEYWgxTVBLQnQ3?=
 =?utf-8?B?RklyeFljblkzRjlJUE81RjlqYjJ5emFDNHg0Mm5DaEJabER5R2pTOTNvN1li?=
 =?utf-8?B?dTlkbW42aDkxVlZ0WFl2cGtNdFpXT1lFNXo4UDlTNDc1ZHRuWFdqK2k2L0Vn?=
 =?utf-8?B?WFlhc3JQRnZuV2RxRXhFSUVEbldZLytnM2ZSa21aRzNsd0JBOFJWOE1vOTAy?=
 =?utf-8?Q?JuvBNwIQe8nmI50rLgMT/ACEIeGpg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFg0TGtjQXhkei9Rc0F3Z2NQVkxsWjRmVEVyYkwrREhYamtaZUNzbHpWRWNk?=
 =?utf-8?B?bG1Cc3JzRnJFYmtpM1hXYjNvZEkxempxRGxjSFJTWXdXRElyYzJ0SS9kalNa?=
 =?utf-8?B?OEpZblFneEptalBtVXVlNURsdWl1ZEc4aUFLQTg2L0xxaDZKbVhRWDN0dUV6?=
 =?utf-8?B?bnIvSkVrODZZeCtGVWltT3NyQ3JVTGVwZHY1dDBGQlBOMDByamhHREZ2ZC9j?=
 =?utf-8?B?YnVienF4dUh6WW1wN1cydGZQYUVyeW0rbUY0b1ZQZk54K25md3l0VStiTXhO?=
 =?utf-8?B?Y1BNWjV6a09JK2xNTXNxWitMUUU0UlBCcisvVGJkOFVGaXBGYzR4Ukh5U2tM?=
 =?utf-8?B?bzUwS1ZpdXBCNmpERXM0UGdHc295SE5ZM0oxbFhLS3hGc3ROZTE3NmxwdkMx?=
 =?utf-8?B?QURHNDlabU9KWjdQOXlGN2VVMWtKaDZFYVhjTktCdU52d1M5Rit3SXZ4ZWhT?=
 =?utf-8?B?QjVBajJtM3EyODRxMFhueWN6eFFTU2o3elRWd0YwRkRPWlZCNFp1S2JkRXlq?=
 =?utf-8?B?bFpsa2ltRVViRHNwL2I5aUlycWk1OUhMTXZ2TmdIQVVIVVczOFNZNW5Ma2NT?=
 =?utf-8?B?c2JMdEtYMkh3cGsvMnIrckVhZ3lMVHF6UXUwRDZqcTFhdyszQmluaVNZUGVj?=
 =?utf-8?B?UTJzemZWaFFWODJ1T3lzb1o1RTFucXJ2ZmYremNqQ3QvTmNKaWwvSld1Wk1D?=
 =?utf-8?B?YmIzd0hmVDJuemFaZEwyNVloTWNGRmZaUUlyU3VYRzZoa0E4d2NNR2grN3dD?=
 =?utf-8?B?cXBHQUVsZHYwMmN4VUcxNXdyZlZaWUNTNHhPSE1aQzg1eFRnZytsM3dqc1Va?=
 =?utf-8?B?TWRDTHBKUWJwc2xjd05GNDZqWDBVK1psQUw2dHNvNEYvbkN5amU2UkpaeFVr?=
 =?utf-8?B?THVMcXl3ZWhqdXJDbTUzWlBjUnU4QS9hUzBRMWp5Z1RoTmJWNGFnZXlvOVFy?=
 =?utf-8?B?Vmp2S05kcWJBclZmRExYZ0V2NDFoWTJialc1dDZHdlkyQ3ZXcHEzbmFkMXFG?=
 =?utf-8?B?RnJyaDZpRFlPMGFaWldkSU9JV25uK1NxZzlKUUZiOTRTL2xDbWpJUmpIbkoz?=
 =?utf-8?B?TzVhQUFUNUNNemFpZmVMa1ZUV2laOFZZWjdsb0VaVHJJcldJRmRPOHJRRzFv?=
 =?utf-8?B?c1lYZCtiQmhISStRaXVLKy9xdU45WGlNZlFUUVB1OVl4aGZhUGhXOXp4ZmxM?=
 =?utf-8?B?ZEQ1Qy9qY2lCNmczWEszN0RaMTBwb1g1Qm5lcytTN0VSc2ZLandZMDI3RmRY?=
 =?utf-8?B?aVV0aDdKbFg5MEVGWVdxYThpYnZWaUxVYi9LclJzaDY0ZFdSR0xHZDRBSVB3?=
 =?utf-8?B?SlgzTTFzN2VrRGg3WVkxU1RnM0Nac2tTU2JoWG9jWmxSUnlsUnJheTd3L1U3?=
 =?utf-8?B?Ni81RExiVHRmdHpjMGRaS1FLbHNkTjJEdy9pbzRYbjB6TDdhLzdaalJSOUVJ?=
 =?utf-8?B?WU1SUndyU2FKQXdtUi9GanVIdC9VTjRWYVRjS3Nxb0ozOSs5eEN3U1IzbVk2?=
 =?utf-8?B?ck9kQkdzaVJTczR0NzZEYlZwS2FTV1d5Q1pOcnZkNUZyQVBLTU1GOWFCaVFS?=
 =?utf-8?B?MFRESzFQbThaYnArL0ZMT2RnMUdTQ0NpN3lBSDYwNDQza29TZjFXN3VPTFlN?=
 =?utf-8?B?NE1BdkpoOWVPejJ2WHI5dHhPcTdJa2YxaHB5WXpqSWloL2x3ZjhYMStVMVpJ?=
 =?utf-8?B?ZzhxQXJzVzdmMkNjYkoxTlRiWFV6bVVZa1NOc2FMNzhTeCt0WTlld29kWk5x?=
 =?utf-8?B?S3ZJZ29MeVhIb1dFVGVJS3RNSUVQeDhlRjdTb2tMeE85UjY2NkJhRzZaRy9j?=
 =?utf-8?B?UVBlMnlMSEZ6d2YwQmc0TWoxMXFHQnpJaW1td2RkRFVma0kvUkhpdzZwMlVB?=
 =?utf-8?B?MGVudmdxOTRjWVdTejRuZThIM1h3TTAyUFNYTUxRVHBFbU1heDkzOVg5M2g2?=
 =?utf-8?B?L0U1SlpDbTgvY2h5b3ZwekoydjRTQzFvU3NIbGxTbXdwV0NJZzlyN0xRUWpu?=
 =?utf-8?B?N2trb0V3dy9oK3d3VUlEOW8xVG42Ujl1Nlg3Ynh4RXpWOWJpVkM3RDlSUHFt?=
 =?utf-8?B?LzNvb1RuSWg5Y0hndHZhdXl1azVxK2dvWFIxYXpWQTRvTHJFRnlEc3EyZHRI?=
 =?utf-8?B?SG5Wdk5zaG0xM2Fsa0lscjY5NkNmTWREcnI1NmdYNEorMTY4MXN3UlZNOUo3?=
 =?utf-8?B?N1FoMm1FMmp1czM2RVhIL3NDcm5XZEtZNWRKcHZzWWVmdDZ4eUVFWWJ5RllV?=
 =?utf-8?B?RTlSQ3FvTlJLeHBZdENYNnpZWkVBVFd5OGdmU0R4NE8xZWd1cVd2cFB6MUVW?=
 =?utf-8?B?WXhqMzNjOU1ES3U2anJ3dytLMTBkOXlzQXd6bkRKQ2pPc21xTmFTdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a5668e30-01b5-421d-1412-08de5875a128
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:45:37.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1cTFTwfmtN6n4Cn2bJrXdudBzL14Vo8iIkhfESamPk8nLhc8ke6b0KueCNBGGINqfbUaucUTFwazYWESzAV/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8737

On Tue Jan 20, 2026 at 9:03 PM GMT, Boqun Feng wrote:
> On Tue, Jan 20, 2026 at 04:54:51PM +0000, Gary Guo wrote:
>> On Tue Jan 20, 2026 at 2:05 PM GMT, Boqun Feng wrote:
>> > Currently, since all the architectures that support Rust all have
>> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW selected, the helpers of atomic
>> > load/store on i8 and i16 relies on CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy=
.
>> > It's generally fine since most of architectures support that.
>> >
>> > The plan for CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architectures is addi=
ng
>> > their (probably lock-based) atomic load/store for i8 and i16 as their
>> > atomic_{read,set}() and atomic64_{read,set}() counterpart when they
>> > plans to support Rust.
>> >
>> > Hence use a statis_assert!() to check this and remind the future us th=
e
>> > need of the helpers. This is more clear than the #[cfg] on impl blocks
>> > of i8 and i16.
>> >
>> > Suggested-by: Dirk Behme <dirk.behme@gmail.com>
>> > Suggested-by: Benno Lossin <lossin@kernel.org>
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>=20
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>=20
>
> Thanks!
>
>> > ---
>> >  rust/kernel/sync/atomic/internal.rs | 19 +++++++++++++------
>> >  1 file changed, 13 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/at=
omic/internal.rs
>> > index 0dac58bca2b3..ef516bcb02ee 100644
>> > --- a/rust/kernel/sync/atomic/internal.rs
>> > +++ b/rust/kernel/sync/atomic/internal.rs
>> > @@ -37,16 +37,23 @@ pub trait AtomicImpl: Sized + Send + Copy + privat=
e::Sealed {
>> >      type Delta;
>> >  }
>> > =20
>> > -// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence=
 the atomicity is only
>> > -// guaranteed against read-modify-write operations if the architectur=
e supports native atomic RmW.
>> > -#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>> > +// The current helpers of load/store of atomic `i8` and `i16` use `{W=
RITE,READ}_ONCE()` hence the
>> > +// atomicity is only guaranteed against read-modify-write operations =
if the architecture supports
>> > +// native atomic RmW.
>> > +//
>> > +// In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architect=
ure plans to support Rust, the
>> > +// load/store helpers that guarantee atomicity against RmW operations=
 (usually via a lock) need to
>> > +// be added.
>> > +crate::static_assert!(
>> > +    cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
>> > +    "The current implementation of atomic i8/i16/ptr relies on the ar=
chitecure being \
>> > +    ARCH_SUPPORTS_ATOMIC_RMW"
>>=20
>> The printed string when assertion fails will have 5 spaces between "bein=
g" and
>> "ARCH", although it probably doesn't matter..
>>=20
>
> Are you sure? My test result shows:
>
> ERROR:root:error[E0080]: evaluation panicked: The current implementation =
of atomic i8/i16/ptr relies on the architecure being ARCH_SUPPORTS_ATOMIC_R=
MW
>
> similar is the following playground example:
>
> https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2024&=
gist=3D5dd0098247503be792bc35cda8f2630f

TIL! I thought Rust and C has the same behaviour with this respect.

I have been using `indoc!` to strip the additional whitespaces, but I suppo=
se
it's only for multiline strings but no line continuation.

Best,
Gary

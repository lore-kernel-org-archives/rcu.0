Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23818C93F;
	Fri,  9 Aug 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210667; cv=fail; b=fmYgwJsbl6p8GN7hjhZusxAeODrzNLd2tNgmtXM1EpHUGcWrniRG8U2BNRjUgeevjLbjIBfWZyPHzEv9GLF5ah+KgDmpJhS9kom2Yg8FUR/i+aF8BWuO5OUbf5cPEZwQRKKmvF34dt2KU65+Cb8ewq+NHUegBEiIaD1uJUdC4pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210667; c=relaxed/simple;
	bh=lrJkLioVm5UeNdvRLjO/0X2kSIc1G2YxvXueyma2eeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oi9mK+kYqk8x9J0KlyHCiIDW1m66d5Ah9Pdwtuu3rJlT5fNkJjsnMw4v1tCqWPGbdmQ/QdxQQiQ6k1rE6r/amxpNM8f3d9WhS3oj4JA5vB7Zt04cEpBjIIOz+fFNvLgNOx1GF6qbpEdva0TCWXqzzXnOxjttqvOK6VUEoXhUVYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=fh0U9Zgz; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="fh0U9Zgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXWXGS3LMqtdoAVPDWtouQtm5P0OXUbaHSpu/g7pKlWm5bgEn4WjpvPlYaf2A8KbwP4rnWB9uQDXBmLXeIL0no+MDAap5jfIjvAva2Hf9bI9oGiC7OeD01Thtl85+7lg4ywQG10xIYTjt5Ykga0JhtbJq+nFh1Yb7LnbTvBJ2f/71QKtnqAksQ3tSrISB485R8yKaDkehZcIY4fNL+KKblA4LrBPUooPq5tRS5sAuwY3gSaTibAZ3djxiockx65ERhA0zp+BKwHj3U4RfzfSrZNmC3S9gXlPzg4C6+vMr8nF2Iwfz5Oac4+uqtL8nYwZmWDBjdUVn1QK78UvjkSmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FR/iafYYJSJxzmG419L7tSuoxqSd7x6bzr9CFpcvK4=;
 b=kRAYH4S1wFxQc0VmJN+mjjUGKwQDWaT8d/TLxMBqI1IAYEvPIU47fXZqsxycYs6+rztjGto9LBcCRXGxM955j3KFVR1kOcr7tm8L26knk/qcoflNNc8j9UvGGyT+A/ChTEoKUhgM05boAVCWTsYt6PTP/OWhrOKBZfubHFnf0jlmLcOXtLyPBmpiTQM4G9ER70mzTuyS1NqpSIu/ZYhY/6HfRGPDvvBdB3xoIKmWMlqqcvD7gV9fowwXcaPFFALCDUUILfiNOVhEMPk96Pl+NFQzJEoS39F8yrID3wK292toaijEOTnr4Il3QZRnukScWobkQfji3eXAMRzV0s/E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FR/iafYYJSJxzmG419L7tSuoxqSd7x6bzr9CFpcvK4=;
 b=fh0U9ZgzoocuFfjCxaz21WBJl4IfTG5xnYdump4kOpw9HQ9v/HE2zU0FUv5A/8wsB93FUzfsYYKcltyr+ng0itWWjJC2u7r5WnyA1RjfnmL8ucgRd2V98qEABsY4uxNRIgnT/fjrwC5eRCxpEfdfZJlte1z4hnBQ6DdwfsEON2aev6XfdsS1U0E10EHvsQux+emaEkH/Wz8KBYXNdg1/hnbKHMNdYvsm8UF7MRwJ8P26wqXXw05jY3MmvlP130XNn44GR9JF921P2h3nPwkSMKEYci7VfX5ueGTpf5eRfiL/XjagXHf6PyIadZnXnfrQ6O8xQl8o8AuCRA/AhCAWnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DBAPR07MB6757.eurprd07.prod.outlook.com (2603:10a6:10:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 13:37:39 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 13:37:39 +0000
Message-ID: <f15aea08-8daa-4994-a8f6-be0461b06539@nokia.com>
Date: Fri, 9 Aug 2024 15:37:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
 <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
 <20240313003244.GA29568@willie-the-truck>
 <ZfF4t74OD4CgVaGV@shell.armlinux.org.uk>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <ZfF4t74OD4CgVaGV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DBAPR07MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fdf15f-36ea-42e1-74af-08dcb8787009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjRDcXRZNlZBdnk2SGhNbnpYbHFvc01JVmJqdFprQkozQWNVVDlWckc4SGM5?=
 =?utf-8?B?TFhKWUJ0N05odVJKT0ZpdWpCYklrZGZmd2gwbjU1b0JOb1RrZS8wOEJjNTZP?=
 =?utf-8?B?R2h0TmlUc3lsU1dtV2VxMWVkSDdlT0xhWDFWNnFUZlRuamZjdzhTMjVyTkZI?=
 =?utf-8?B?UmxmOEp0WGdvb3FLWFJ6cHl2eU5oY01oaWQrZFhuNnVoNEs2VWZ0YjdoVUgz?=
 =?utf-8?B?bTd0UEptdDhwQnhFSlU2d1hmZVRKNlJUUU52M2ZEQmR6T1dKNHcrVk1OdW1X?=
 =?utf-8?B?RFBZM0UxNTZaU09DdjdmaGc5cy82M3RHOVV2cURiSmI4alZxaWZMTkI1WmVM?=
 =?utf-8?B?RVJSV1ZRdEJSempqdGcrbmlOK0w4QUgxVWtQZDUzL29MTUlOZTJjQUlQZVNT?=
 =?utf-8?B?Mm05dE1jb2JjQllBVUpJZkdqSFlPOXA4QXM0MVBpVHh5SEJGT2w2b0hJenFS?=
 =?utf-8?B?bVlWM1lYMXQyVkt3WERTMFFlSjJ3TzhmVVY1bmdNM1hibmRpaUpDUGs0SmIw?=
 =?utf-8?B?K0IxdzJZV1AyM1J3UW9IQ29vcSsrUEQ1ZnZlNklVUjdTVmNMcnFhNThzaHJS?=
 =?utf-8?B?K2hEdG1wbTE3QlQ3V0FZZ0RoR0VxTlJaOHp1c1R2MGV1a1RIS045UEd5ZmI2?=
 =?utf-8?B?YmpKNEFCRE5XNXhXTlppWHQxMjRmZ1ozWWwvenIyVEZkcjhJL0cxa0JkQmRH?=
 =?utf-8?B?M3ZzazdOVC9Hb2kyQmFVSy82MDRqMld1V1ZmQjF1WW5RUFJQKzQvRUdwTmFV?=
 =?utf-8?B?VWpSdm5GK21IZmdvK2pCOStzWDRNKzdoL3dha2I2UlRndkFTY3kybEZScGZ4?=
 =?utf-8?B?eUxUVmtXejhuT05FUDUyejRQelpRdW1PRlpHOWVvYjZ6N1lLeFd1QkE1aVJu?=
 =?utf-8?B?OWZ4T1JNQ1pENlJ6VTVNRTgvWlZJbkhwUVlrTmo4VlNSUmhXcFNBdXUxZkU2?=
 =?utf-8?B?ZmJ6REUrSWZuMUhnMXBWbnJaR25xS2xDdUF4NFMyREYxU3RoRlUweXVLVUly?=
 =?utf-8?B?OTkyU3lUNWJCbWl0K3B1dzFEOXZWWWlXSVJmODBsTkJYeGFJZGxsYWFHNVJL?=
 =?utf-8?B?Wk4zT0taUXpHNVgyK2cydlQ5S2JJS2tBQkc1bTdLcWp2ZldsQnVUVHVvRmJD?=
 =?utf-8?B?YWRvbTJIaUpFY0d5YmlWczZCUzN3dTRzOGYrSWdudWZxZk9EVmt1ZzQvWk0x?=
 =?utf-8?B?ZDk2T05DZUQzekF5a05JZDlJZjVRTURBRjN0M0hQeUtjbmdkd3FFM2FMdmxB?=
 =?utf-8?B?by9WODcxeDRKN3pkRHIvZFFnRUpZUmRqQUlhbkxEV3NhUksvbGRMSERTb0hw?=
 =?utf-8?B?eldvY0pMTmk0TVB3NktUaGZVR3V1UGxWc1AzMThwWjJYOU1FUksrMVNpSkp3?=
 =?utf-8?B?MEVnV2xZSkVSL3VidTd5Q0xHMUwzdmQxYjNYVmdla2h2LzBmdGFMeXJyZkF6?=
 =?utf-8?B?Q0tqVWlQRUhqY04xdzAxQ2NtclJhelg5NDlTQ1JKRjJ6Q3JIdXlRT25PT3hq?=
 =?utf-8?B?dVZBL0NCMzBONmdUdjJVZ2VBbExvMk9ERlpYNkdPLzlWS0tMZmZQN1c1aUc5?=
 =?utf-8?B?OVJkM0l4Y25EZzYyaWN6aDRsTUV2R2NuRXFackhqekUxQXU0UllLM2pjRXlj?=
 =?utf-8?B?b2xTNUNMR1BLMU9IWEhJaGVOdDRCSFo2VDRibXlobFlEMjdXRG5WdDZHN1NM?=
 =?utf-8?B?TnZSQlBEVmpvbU9jZ0dFM3hlM0NGRmQxWENtM2kzNkFLbCtrOXIwNUFpd2Nh?=
 =?utf-8?Q?V6LzyFmnzt84dETvnNatsdn3ZHM+/r2AaWyJvNj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhCSzFOeHkwY0hhaS82NnVtYnJBUVI0dEIvYzVRMWRtN3RnYkNPaUZVeUFJ?=
 =?utf-8?B?a2NidG9WQ1JnajdVdGUwdk9DNUlsUlpKMkd0U2prYU9ZeVlNV3lvcGhWUTg2?=
 =?utf-8?B?K3BYUU56MEN4L2RlRVkxSG5WVTV3QUovbFpyb1JKcjI4OEhHVEhFYVNMUHMx?=
 =?utf-8?B?Y2hoSndyWXpaRG03UzhHNk1aTi9NMGFaWURkRjFNUXJkdnFDQ293bldBcnp6?=
 =?utf-8?B?TFRxK1VYemw0ZFBHbDVFOVErSzJXRGUvelB5L1pHZjhZRXJ2OFMxbGZpMU10?=
 =?utf-8?B?alZxMUh1eEJ0Y1dENW9OcmR5M29jRStJSE5iMjFvajVFSHhCSU9mT1hESG14?=
 =?utf-8?B?TDhud2QvQjlOOHpxaVBkLy9tQTJpaGNTRUkxbWFlSnZzdHpWMHREbWRXOHA1?=
 =?utf-8?B?ZTI3OGVia21PcDM1WTBVaHU0SzkxNGZaeFVOVE1SUDhQZlo3eVZ1VjJ1cVpJ?=
 =?utf-8?B?Q3RxVWx0emlrT0w5aGNGRUgxdnhndkNxeU54WXJEdE9YZW1pSzVkRG5ncTJw?=
 =?utf-8?B?Nlo3UmtNd0dYWHV3RUpNRUxmZitQSXJOY1RaOUFkUmJQOGtwZnI5ZDZ5U1Ur?=
 =?utf-8?B?aUlWaHFoNmNtZFBLaFFQWjc2OUdoT1J3b0o5cXRWSmdrc2VQTC9nMDV3ald1?=
 =?utf-8?B?Znd0UHJsdER4VWJqREtvbUFVY0k2UkhjMEtLR1dydEtDSmI0QlZRdG4rZEdM?=
 =?utf-8?B?NkZjQUVyZC9yZE5URGFqaDV3UUpCNkcrUU0wcGpJNUtVNGU5bFNRZGRBUzR5?=
 =?utf-8?B?TlcxYkQ3VVhRM3EwU1NsZmI4TlNvdzBPVDVYeGtZdjhFWDlCNE9rMGJuY1dy?=
 =?utf-8?B?VW9uK1VtT0FEQytqVU9ha21iSVdvV1BUcFdZYmZUWlNGYVBSSUU2c1dzd3ZG?=
 =?utf-8?B?RGlKSzdMbkVhcnVHdkJRSDJPWVJXT2h3QlVra3FRckJwOG9BYm5hZ3JNbVVl?=
 =?utf-8?B?dGdsMEZmRGFPdk5QTlRLSWRoNzFMMkRIYWVkMWpER1ErM1FKb0lPV2ZaWE5N?=
 =?utf-8?B?WUZPZUtMUENiYWVkSHFuSURGbjdyVWlJMnBpM254OUlSckZIcUdtYVRQWUor?=
 =?utf-8?B?dXpUY2pTSDRBVllQWXMzVkV1aVFqN2hmMk44ZlhUaDFsWGRsWUNUQ3ZNLzdj?=
 =?utf-8?B?SE0xY2FnV29wVWVRMGs2eG1QcW05T3VSdWhyQjI4Ykp5Um5hNkxiR2tmRDJD?=
 =?utf-8?B?S0hhN3V1K2hKenVXa0NFS0R0RjVnVmViZitZT3JBbDVsM0NOeEsyVUhrZ3NZ?=
 =?utf-8?B?V3poVWx2SkM2YjhPc2h5SkVjaXRIRjhaa1RoMzJLaGZZY2twbnEzQ3diWkZ4?=
 =?utf-8?B?NzBHS3p1N3pmL3diNmk4SThsNTc4TWZvNkN4TVdvbWpxbndiZm0zMEtoOERZ?=
 =?utf-8?B?Ty8xa3ZKSDRFUElCUy9IeUIzNUpxeG5XazVIb1gyZE8wRTJFc3RZVUc3OGRk?=
 =?utf-8?B?VVpNTlkzMkJyTWhqUlVoU2tLeUhlcTNab2lLNmlsczBvREVieHRySUYzK1FV?=
 =?utf-8?B?bzhCVmk3NWpkTzU1UCtPbCtEQXlDdkFwSXFGb09HZGZrVU05cXN2bDhrK0lS?=
 =?utf-8?B?VWJvSHpjd0Q5NktFUFc2dVZtMGNMSXh6NzdzWWZLK291Y3JjN3NqcmI0V1Qz?=
 =?utf-8?B?czlqNGwyaGhYRm5tR3hQbEI0L2I0ZWtTUGxNdGMxTUZaNWdqelMyOUkzYTNv?=
 =?utf-8?B?M3ZDTVZWYXVoeElRejc3d1BTMUJib3F4QUp1Z3V0RXJRTS9lMmkvUUp1Vmpr?=
 =?utf-8?B?eURQeGt3N0xpUzdNVzhUOWt2TjdlcW43eFIxTkRFWXdFaHkyWUg0ODR0NEt4?=
 =?utf-8?B?VFpNN0RtTEhmVjlCaVlDVFhpSlZkOXpXaXVZckRnSmVPZFk4eHFTRGY4dGhj?=
 =?utf-8?B?Mkx6OUpscGo4a1BLTVZrYUNpdTVkbEkwczNKekFtaTFnbGt5T3dlZ0JnS3M0?=
 =?utf-8?B?ZDZyM1BWWEtjVzBMN0xNR0RWdXE5Y0dZMUEzUWZJTG91TnlXV0tISG4xOXFZ?=
 =?utf-8?B?ak9JU05xNE9XbWl0aVZGdnJPdURLWHdFcGo5QTdNTHZiQm8yTm1zS2k3OFBB?=
 =?utf-8?B?WGc2MVpKTGRNc056QXR1WmUxR3BrMW5DYWFwUzJjWnk4cEt4eUZsU0MvSkd1?=
 =?utf-8?B?Vm1YU0k1RENUOG84N0lTUldiR0RZUWdSbTZDNjB3WEs0MWkzLyt0c0NQdzVN?=
 =?utf-8?B?cVFOUkNTMzZsVVhCYTZLZ3lrMnNZdit1T3RrV3BVVUpLZk9vdU42dVBIOHNq?=
 =?utf-8?B?Y05HUkl6aUg2YnlEVVJETnJBYXBBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fdf15f-36ea-42e1-74af-08dcb8787009
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 13:37:39.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDJaNDuBDhEbcMNe/dgUkPUNYxbHriBEjklbdNq+zpeFZcNb6ExcIfGiuRj9lAfWIIWuiL46lhgGI++LAWHl/HAjWlflKL7qW8R8tbHygpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6757

I'd like to revive the discussion and quickly summarize our options to
avoid a false-positive Lockdep-RCU splat when check_and_switch_context()
acquires the ASID spinlock:

1. Briefly report CPU as online again via
   rcutree_report_cpu_{starting|dead}()
2. Replace raw_spin_lock*() by arch_spin_lock()
3. Remove ASID spinlock

Both 1. and 2. are workarounds with different pros and cons/proponents.
Regarding 3., the last comment form Russell is:

> For 32-bit non-LPAE, I can't recall any issues, nor can I think of any
> because module space is just another few entries in the L1 page tables
> below the direct mapping (which isn't a problem because we don't use
> anything in hardware to separate the kernel space from user space in
> the page tables.) TTBCR is set to 0.
> 
> For LPAE, there may be issues there because TTBR0 and TTBR1 are both
> used, and TTBCR.T1SZ is set non-zero to:
> 
> arch/arm/include/asm/pgtable-3level-hwdef.h:#define TTBR1_SIZE (((PAGE_OFFSET >> 30) - 1) << 16)
> 
> so I suspect that's where the problems may lie - but then module
> mappings should also exist in init_mm (swapper_pg_dir) and should
> be global.

Unfortunately I'm don't feel qualified to contribute to the discussion
on option 3. Russell and Will, would you be able to spare some time to
drive this further? Otherwise I would propose to make a decision on
going for option 1 or 2.

Kind regards,

Stefan

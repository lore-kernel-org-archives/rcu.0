Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EB128816;
	Thu, 26 Feb 2026 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064848; cv=fail; b=RObKJlVpiShvepgJSxcR/xbjQwJdlsCAYopxVyw7RqVcLOXVxas8RSIafTZ/Q+VaO5LtiYifBgxdHS7U0nSOKGRs39psKkP5tQJhg6jhIRQuBHaTY+l800E7f/etsjmIDpwho5+fr43Z8lO0wQluMX/f9RAae/CcYOlGd263w8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064848; c=relaxed/simple;
	bh=nItpFWwOouF3dwhlB/H3mixGVEWGahQjbnScO0hCCPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZV+w1NLKa4plcpIzS0W6hgleFkTNSqMbuPPsv7WBnTJZBYLV229SyDJmFudor4/HmPCON61Wh0Ga7ewASVSc3Ndiky2tVW94TMLsZ16FXlgBXgdsBURJZDbMm5WBi7p/rDY7OlAWHXX2x+/+n6dCLsNHpE6SFgReWtVnsC4A9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TT2TGwEA; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TT2TGwEA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTyHbZBoag6DOPh58d6vW3rWWtgHpBIk/xhbJxuWMvixVtOAL6A1yglhnffNsFAiveZJjt1PZ/SkpYF7BLmNd2oYF4dq2t133kkzJ5gMZtb4Y5hJwbEf5cCe/Tz6UxrCx8vV61qS31QdSBfOVYff+XZz/ht7Scg5k51Su8NkuiXOeV+1BfFFVJLPBQGfBt/nRpZ7+F2e+hqrfcpRhg7ADlinHs+O+qUP56P/+XpwaFnRqYcNdeT0ssT78mu+l7zzILkr18ZUj2YaTp8wQspV+x7NGa1Tz3BZQxy+3oHSXthu8DRyvOpgJ434d9JJ6lYcMC65QOR76+KCSBFg7ema3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nItpFWwOouF3dwhlB/H3mixGVEWGahQjbnScO0hCCPU=;
 b=P66OYrCPI5/kQzEAE7LI9cd+D1LFGFVB/6MZj78QXwkM2ABiQ4nc01CYqEic1ew0n+eEilXsVHoTCuOe0IexNr78Umccik0zrYTIqyN1dwS3Gwrj6pPF9jms/KJRbA3Wht+ZJrMAOTRIQ0/VDRl1mfK4abciSgJpQYLLJDOIxBfMobaF0e6/epDYCA1fXXnMwaKfiQVCXgQweE1cGB13UWrWlC9+x7QaWQoAqM7EaGrd0/pyzA2ZWWsCrchKlE5LLmIpsxTb//3Ny+ECBk4GbfdYLp8bPF6/yuLIjsYpebxR7588VAGN2CyooIdPyfO+MTRvelHIY8umN0QNlPMYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nItpFWwOouF3dwhlB/H3mixGVEWGahQjbnScO0hCCPU=;
 b=TT2TGwEA4UXn9zf2wCEcl6DVys6fVc/FIhP14F7ZwXA4Kx3PXCPHM+Rp0My2B+qMsXzzG6Qn9UBrXjAJnJR5e46DbO8Ee9miIM/8kfINSY9XOrYQGW2908ex5cFbYmBW4IcZOYo12SmWcPd6g9qWJv5649UIYFuxgSUcA2CzHsjI9L5Q+ODYS6MHWkxJE+Bvk/tkI4/LnSSqNApezxecSvPzjiZyiuMtXFtYs9S9N55g+s08YccbdjhuluhV4lF4QtPpUqhKSKU8CoFNfUF4M8sSdggwwdeiFRKmiO4wW7UmZ06JFViKItNCA48B40DalvHUn77yIWeWEatOCUvj9A==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 00:14:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 00:14:02 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 4/4] rcutorture: Add NOCB02 config for nocb poll
 mode testing
Thread-Topic: [PATCH RFC v1 4/4] rcutorture: Add NOCB02 config for nocb poll
 mode testing
Thread-Index: AQHcpeH7OMLUtsXwEEaM2ScuGSWRKLWT9OMAgAAo+F8=
Date: Thu, 26 Feb 2026 00:14:02 +0000
Message-ID: <6D0EDF53-CCB5-4FC4-AFF5-A22C0FF8C065@nvidia.com>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-5-joelagnelf@nvidia.com>
 <89367e04-7647-4165-be41-385b61aa131b@paulmck-laptop>
In-Reply-To: <89367e04-7647-4165-be41-385b61aa131b@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8955:EE_
x-ms-office365-filtering-correlation-id: a8a6156c-9a33-4b1c-9fa5-08de74cbf247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 RYc/9MyDB4PyLk+FAm0tkH0twCEdjMnbGvjpzr4ktpXbmuWy/S3odB0norunTXeHKWbI4Ir0hbRXQ4xovG15iG38ATDOtk9RIx5pnA2GAN1otjyo3wpfF6l0i0f6dzcw4O0RQuIMO4SRT9Fv2sBetLa9kU+mXsGuq1KyGguxMHXZoGIIHplZpLEgKBdzDQ4TUVEruJIAEzC+UfKq2p8jTiwxG58f4vg+T8B0eRepzdZRTL6eTZfbTim84qk54krBvZhu4aOo2gcNXAu0f/Ijap0p9VN8asEB87X8UfshDINVtzQjZeY3lTjYe0i938rCBXVAss/TtbEcmpFHiLcTEhawSTxg2kJJqiIIcH/s/QS5bHEd8eMBBu+Es1ih0IJX+dnHIgCjq/hasvQjuy48ZCc+qK4kUzqgxPf2B9/+hmZMD6JVZ6kUFZ69Y7QVz3OAPsikAMpX5pG3uyh+rZp421kbY/WeVQ4NO4ba4Zg7mJarM9oUT+AeExWlOEm+y68XIKBoQCQ/nNgH1rmQbOubAd3/7jOEqF8vvkOELs5M/POXItrc11vtJPN1KIPWN+U0Vs3+WrxWdGo2YOnfrjhXRkJPYIxEbVCiof6qAm2DK+RkuNw2yOhGnc0kJURLRp9v56fUL1kVCsMWlg0LeF90w+sXgUaY63aDLqfxgZe63zKU50EKCGDHV25YkNRNhv9vVstWEn5ncz/a1zqtKLyfAnTAVbxFUeqj4duyX8zofrNiPCOJzgV9we0wvyXI5WSwZUiXvCXQ3OT7ItckpIHrKoY7NYJYxh22seUIOg4HAMI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFJLa2JMUFY3Qzk1QXJpYlNSN1lyTWhPakxObXJoR3QreXJuUXR5enBQSTZG?=
 =?utf-8?B?d3hrWExNT3dDZFZ5YmpEdFp3bER1a3NHblZUZk5Hb0VrRWpMT1FlTFNOb3kx?=
 =?utf-8?B?aDhGYmNqM0dEdnpwd0Jldm1tVzNvang5dzY0UVRwejF4bmlsNW1vdFUrd2Zn?=
 =?utf-8?B?SFBqN2l5cUlMdlR6RngyNko1RC9GUDM5SDNUa1VFU1hLUFNldEFHbkV3UVBq?=
 =?utf-8?B?cHlxM3drcmtSYkRESVUvM0EvN0lvaWhzeGJLdHdvM3ZrZ1h3NVlLMmZtYjZh?=
 =?utf-8?B?emo4eW00TG1SeHpZd1IrOUdlTU1LRWRmOEpHampndFBuYkkwaDN1bGJkTmty?=
 =?utf-8?B?bnZrTGVkclp1QytUUVViY1haWTBTK3R5NWs2c1AvOEx4UEp1QnZnalhoeWtV?=
 =?utf-8?B?RkZKRzBzTXYxeHRpQzJDOTFkT3FNdFB4Rko2QS9oRkZQUE5MMWNsOW1hci90?=
 =?utf-8?B?QWhBaC8yUEVDZ3JCT2szcVNXaHd1dk9tdnRlTjZVYVM2V2Izd0F0OWVndnhp?=
 =?utf-8?B?NzRKWWFocVpWdk5tc20zeEUwb3VVK3d2WGMzNVhWbk5JM3IzUWVLMExjYlhH?=
 =?utf-8?B?b3F2SU5FM1d5NlhLWWx4a2N1NG4xVmZkUW05bWpTMEFmSFl4NEFMcXQ1b3dE?=
 =?utf-8?B?cmJBOGZHeEN3ekJPQ3kvRVZJQmorUCtuZU9qbkJ1NUsyV1lHT2RwVEROYVZT?=
 =?utf-8?B?R1F4Nkc5VWI3OXZ0cUJHZ2NtUmJ6SEEvRlpPb3RRVWhrZ3NnVFBkODNFZTRh?=
 =?utf-8?B?NHBCbnhndGZIeUJjQ3ZuLzFoNThNNnFvK1Fwa2ZxRFNEbkg1b09HSElYQUEx?=
 =?utf-8?B?TGk4STQ0ZnJOaEtlc0wzWm5JTDdLN29BcURCMGRBUXFlYk5ldTNGVzZOcVhR?=
 =?utf-8?B?R1h5elBadU1JUDc5QnRZWm5IWmovb1dmbFVlNXJnVHhueUJXbmtIbVFQVlNX?=
 =?utf-8?B?a2VackNVTWh2cVRhRjVlRWNKUzBTVjY1c0lLR2UzeTYrSTI4L1BObWZYblNw?=
 =?utf-8?B?QWNJZDZWY1dQUlYzaGNCQjNUNlc5UEhVaWxLeGlZaU96eXh0Z0ZhK0h3ajQx?=
 =?utf-8?B?b1pnNnhaUjhMYUdHNmpXZlZUUWxDLzBJekJwdmF0VEFZNXQ1cGlWV3FvS0cw?=
 =?utf-8?B?NmFpN0czQ0hmazJaQzJrTmpDNHhPVDNKL3BML0dnL2FtWXFCTmlYczROK1dG?=
 =?utf-8?B?Y0xnM2IvTkovbTE0TGdHVk1ZaDM2Uzh2VG1TcFA0bnV4ZzVGcjdNelhqNGZk?=
 =?utf-8?B?SVYwMXk3UWNJTnNJcUdXaXptcVBHMGE3OEZxRzRQZC9zZkdidEg3dkZ1NzBi?=
 =?utf-8?B?aFdwMERKQkxwWTNOVVoyc1poZXpSMnJZeVh1Z2s3VzRERHNmQXdEckQ3VW85?=
 =?utf-8?B?bmpwK3J0L3JGeDVuaXRwenFsUkdMRzVEcytiaUJvUEVZSWpoVE1hb3FRcmxO?=
 =?utf-8?B?SUtrWHVXcmFRUEdhTzUzNDVCME5ST1VQMDB3eGVPYjUzYkVPR0QzSHhsY2xp?=
 =?utf-8?B?cEdSU092MUxHTE14YThiT1FTMnNQd3J4SnZ4QlRaU05QNjhNUmZKazV0WXVz?=
 =?utf-8?B?OG8yVWM4aVhVVjN4RE9sbWY2V0l5OG45Z0RQN2dYcU16blAvY2VNUXp1N3Mv?=
 =?utf-8?B?NTJOelpjY3lTVlJzaGpvWEJIQzl6aFdIalU3WFo1VVo2Z3ljZDkvRXdnak1C?=
 =?utf-8?B?SEpMUlljWGFZZ3Y2SWRHRndnNThSWlVZdnJiQnZ2TkhrYTRHeEFtV21md01j?=
 =?utf-8?B?N1ZSZkNETWVEY1pOSG80akFtK203eXR5K2hmcmFWRmtMUzRudVNDK085cUpo?=
 =?utf-8?B?Q1JITnc0M0dXMkRyZk5Pa1R6TzA1eTA0Z0xuUDBZMVdaYU52QklIc1NJd1V3?=
 =?utf-8?B?bklicnVMYWdDS0c2WWpzUTM3WmtQcHhlaHZrSXU3bnNPM1dxWVFBNE9kbXYv?=
 =?utf-8?B?a3pmL0xpenlocDZld3AzSHhXV0xyNGNPcCt3TWRCUjRCZjJEMTJEaDA3VDZ0?=
 =?utf-8?B?UUs2Rkd2YmIycEhydEd1bkhYb2NLRWxxMHZLam1tS3JGSjZWWmtIcUFmQjgz?=
 =?utf-8?B?OWMvZ3pQbk5NdHZ1NGxEeFhWWDYwU3EvMWtGZTBhTFYvaWZ2N3F5SUVUUzZW?=
 =?utf-8?B?QUNmblZmYXdlTU5FeHB0WXlScENNdTkzM3VFYURka0RNTndWR3J1M09Sbi9I?=
 =?utf-8?B?MjRHYTRIZTFPcURHWmFhb2ErQk5HWVpscUxmWG4xMzNlQXdRYVM1SHlScm5z?=
 =?utf-8?B?ZHl1K3FOaHRDemhucW1ZUWppclY4YktxT09Ed3I2WUFPRkxxeHpDYjY4Ungr?=
 =?utf-8?B?Y0szZ0tyQ29tR1UvWFJRMjNxbWJZRUg4UUxkQVhrYSs3UTZ2QW52UT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a6156c-9a33-4b1c-9fa5-08de74cbf247
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 00:14:02.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grKP/cvcD5d1xOr85gfUB/3cmGosVK4eYa0vr6nV8weYonAfFB430kR5rR90OTuxdKPqwnclD9piBFZg29Xezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

DQoNCj4gT24gRmViIDI1LCAyMDI2LCBhdCA0OjQ34oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBUdWUsIEZlYiAyNCwgMjAyNiBh
dCAwNjowNDozNVBNIC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IEFkZCBuZXcgcmN1
dG9ydHVyZSBjb25maWcgTk9DQjAyIHRoYXQgZW5hYmxlcyByY3Vfbm9jYl9wb2xsIGJvb3QNCj4+
IHBhcmFtZXRlciBjb21iaW5lZCB3aXRoIENPTkZJR19SQ1VfTk9DQl9DUFUgdG8gZXhlcmNpc2Ug
dGhlIHBvbGxpbmcNCj4+IG1vZGUgY29kZSBwYXRocyBpbiB0aGUgTk9DQiBpbXBsZW1lbnRhdGlv
bi4NCj4+IA0KPj4gVGhpcyBjb25maWcgZXhlcmNpc2VzIHBvbGwtbW9kZSBwYXRocyBub3QgY292
ZXJlZCBieSBvdGhlciBjb25maWdzLA0KPj4gd2hlcmUgY2FsbGJhY2sgaW52b2NhdGlvbiB1c2Vz
IGFjdGl2ZSBwb2xsaW5nIGluc3RlYWQgb2Yga3RocmVhZA0KPj4gd2FrZXVwcy4NCj4+IA0KPj4g
VGhpcyBjb25maWcgaXMgbm90IGFkZGVkIHRvIENGTElTVCB0byBhdm9pZCBpbmNyZWFzaW5nIHRo
ZSBkZWZhdWx0DQo+PiB0ZXN0IGR1cmF0aW9uOyBpdCBjYW4gYmUgcnVuIGV4cGxpY2l0bHkgd2hl
biBwb2xsLW1vZGUgdGVzdGluZw0KPj4gaXMgbmVlZGVkLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEuY29tPg0KPiANCj4gRm9yIDMvNCBh
bmQgNC80Og0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2Vy
bmVsLm9yZz4NCj4gVGVzdGVkLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5v
cmc+DQoNClRoYW5rcywgd2lsbCBhcHBseSB0aGVzZSAyIHRvIDcuMSB3aXRoIHRoZSB0YWcuDQoN
CkpvZWwNCg0KDQoNCg0KPiANCj4+IC0tLQ0KPj4gLi4uL3NlbGZ0ZXN0cy9yY3V0b3J0dXJlL2Nv
bmZpZ3MvcmN1L05PQ0IwMiAgIHwgMjAgKysrKysrKysrKysrKysrKysrKw0KPj4gLi4uL3JjdXRv
cnR1cmUvY29uZmlncy9yY3UvTk9DQjAyLmJvb3QgICAgICAgIHwgIDMgKysrDQo+PiAyIGZpbGVz
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yY3V0b3J0dXJlL2NvbmZpZ3MvcmN1L05PQ0IwMg0KPj4gY3JlYXRl
IG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3JjdXRvcnR1cmUvY29uZmlncy9y
Y3UvTk9DQjAyLmJvb3QNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3JjdXRvcnR1cmUvY29uZmlncy9yY3UvTk9DQjAyIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmN1dG9ydHVyZS9jb25maWdzL3JjdS9OT0NCMDINCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjRjMmI4Y2Q2ZDhmZA0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmN1dG9ydHVyZS9jb25maWdzL3JjdS9O
T0NCMDINCj4+IEBAIC0wLDAgKzEsMjAgQEANCj4+ICtDT05GSUdfU01QPXkNCj4+ICtDT05GSUdf
TlJfQ1BVUz04DQo+PiArQ09ORklHX1BSRUVNUFRfTk9ORT1uDQo+PiArQ09ORklHX1BSRUVNUFRf
Vk9MVU5UQVJZPW4NCj4+ICtDT05GSUdfUFJFRU1QVD15DQo+PiArI0NIRUNLI0NPTkZJR19QUkVF
TVBUX1JDVT15DQo+PiArQ09ORklHX0haX1BFUklPRElDPW4NCj4+ICtDT05GSUdfTk9fSFpfSURM
RT15DQo+PiArQ09ORklHX05PX0haX0ZVTEw9bg0KPj4gK0NPTkZJR19SQ1VfVFJBQ0U9eQ0KPj4g
K0NPTkZJR19IT1RQTFVHX0NQVT15DQo+PiArQ09ORklHX1JDVV9GQU5PVVQ9Mw0KPj4gK0NPTkZJ
R19SQ1VfRkFOT1VUX0xFQUY9Mg0KPj4gK0NPTkZJR19SQ1VfTk9DQl9DUFU9eQ0KPj4gK0NPTkZJ
R19ERUJVR19MT0NLX0FMTE9DPW4NCj4+ICtDT05GSUdfUFJPVkVfTE9DS0lORz1uDQo+PiArQ09O
RklHX1JDVV9CT09TVD1uDQo+PiArQ09ORklHX0RFQlVHX09CSkVDVFNfUkNVX0hFQUQ9bg0KPj4g
K0NPTkZJR19SQ1VfRVhQRVJUPXkNCj4+ICtDT05GSUdfUkNVX0VRU19ERUJVRz15DQo+PiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmN1dG9ydHVyZS9jb25maWdzL3JjdS9O
T0NCMDIuYm9vdCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3JjdXRvcnR1cmUvY29uZmlncy9y
Y3UvTk9DQjAyLmJvb3QNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLmMyMTJhZTI5OWIwYg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmN1dG9ydHVyZS9jb25maWdzL3JjdS9OT0NCMDIuYm9vdA0KPj4gQEAg
LTAsMCArMSwzIEBADQo+PiArcmN1cGRhdGUucmN1X3NlbGZfdGVzdD0xDQo+PiArcmN1X25vY2Jz
PWFsbA0KPj4gK3JjdV9ub2NiX3BvbGwNCj4+IC0tDQo+PiAyLjM0LjENCj4+IA0K

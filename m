Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988738757C
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888473; cv=fail; b=gO9mpTt9NfXyubaNRc7Qw3jLXCPm29UnPGtzZaESJ8XothRQRbytdgXHx+MCYI2rBwjCsbCmcwLshnT0E+pcqG0CxXFsuDli29e20+SqQ2554zMqiibpS+h+VmdUGRTb5lggz62jZBEhCGbPlUGYmjffgqomoP0QRzrv4YM2tIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888473; c=relaxed/simple;
	bh=M4/1JYv5yQH5rTN4GKpSAAPt2lAFuxeR3P388ty2Y7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTP6kmn7nr6PrU/YQS7d/MBFBTI0o9Wxdg8BNin50G4wZc8ZCex1LiuQ1TsHeD24m67UYWqEdcOnFqn6iC2FX7Vm4M2Gmmcjt7GuCQIHkOMCDsDXjh7lhXitwiwUoBibkITPsZv20lAi7TAx0HPZJM+ctOZn7xycOx2zG2i64e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aL6NA2w/; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aL6NA2w/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO0uTzIpr/SI3TwxkJPev1JclCbwJUugRTmTSp6dLGuXb3GgbVZFPfvVH8CUdQ4dKuboYWdoecrxuZfxVqxrc/oETEYymFP0hANIZfBbUtgnmV/nBeTOeydQ3RvsWV5qAEwmEyFzrmTklTZT9l0Y7a8DpvbC10CvnByAv9QfRmRouEBGeiOj8HkgQmZJhEeP+qR2F1dPrre3X/Pgi1HftMtoIjLX85uRQWpbjDVC76YBkz4HqBTVtiug58oDFBb0NZzH00S4NPTm+UrfTRtcMvZcZClhXvOtjrbC8nf5kpGhSBbhLet3XCktsnL+4l7eYFdqeZVuN/rjU+gFTdC0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4/1JYv5yQH5rTN4GKpSAAPt2lAFuxeR3P388ty2Y7Y=;
 b=uOKC9gTv+U0cU0IDLeePAVwgcTU4M7jzu+cCxJpcrLGHTC9++sMRUqnRKFeJsoq3/ANzSFKP8bypuH0osxMfQfIhtzrBVCcp0uMIzau89ryxbycxtqd77vVogSYtUq+3FGiOn/jokPTd7+3A9p8NU+wORPy8mDplTDr2v5/PF4X5nG4YinOfdSluMh0xZGy0VpRZOzVUr7phS9HtgW38M4jJnZaslcnZBeSdY43dvgOLUZRsAtjia5Xi0DfrtNkJPRARU6455DExkYoKgOhBezNo6OxFjCEQ9DxoReOMLftjexGlhmaa+iLOYUNtYSwwfDiAxjdh86elZxJoOy9KDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4/1JYv5yQH5rTN4GKpSAAPt2lAFuxeR3P388ty2Y7Y=;
 b=aL6NA2w/OA9qCfuqfD2C64iFTf8BlKt4Eh7ywRKRpcqqJT+E8xKlGJzikNG6VpOzeMd1pg0Bg/QeWfqj+f7xHem5uyIEogwkHdHChCR+aUh+BMwlsmkbgacsKGYOCmsfvfmqwdFLwR+gTrU9kn/LNVM86PefDfQi0vPsiAIWqJRiEerZWfBaIm45RYzW5zeHh17ISYYrdDvNqNxcR6A+949U461Syx8OrbZi2UPOMIlW9Q0VKmh/vZx9dK58/VVQJMcB7vm/g2QmFWg2ajgZzLCyJNqJEuGRp1Xl7BAQ0+D2K8995vdxQCgGLhZ11Q6DtWEImQNhgs4jvkRJM7w1+g==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:47:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:47:46 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun@kernel.org>
CC: Zqiang <qiang.zhang@linux.dev>, Kartikeya Dwivedi Kumar
	<memxor@gmail.com>, "paulmck@kernel.org" <paulmck@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.iitr10@gmail.com" <neeraj.iitr10@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Thread-Topic: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Thread-Index:
 AQHcthLL304H6q2WAk+gUq4Bl4J1mLW0Hg4AgAAQdQCAADBmgIAAEw0AgAAv94CAABargIAAHmAAgAAA1wCAAAVlAIAAHHKAgAAITgCAAA0BgIAAGm0O
Date: Thu, 19 Mar 2026 02:47:46 +0000
Message-ID: <951324F5-A72F-4767-A0DC-7814650BDDD2@nvidia.com>
References: <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <CAP01T76Ud2yBWwXFyzNaLLOq6yjKbHRAXFsg=TMc7LYkZH_Opg@mail.gmail.com>
 <f41b71aa2a39a7841e8913ae291cde5edc5e33c8@linux.dev>
 <abtNpyDsRdkzVA0G@tardis.local>
In-Reply-To: <abtNpyDsRdkzVA0G@tardis.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|PH7PR12MB7114:EE_
x-ms-office365-filtering-correlation-id: d039a315-da4a-43a2-d6f3-08de8561e713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 gLSE5c+MBVixfqfqz+ovNyQlFM1RZg/5UK7pZewvr4gX5uy/mBKnsLnDZEG5rRrk0tASGcEd5D8rp2NFGdHJ+K11V/eUFhDMWiJmRK+DkPcqXnKFGmRlq7EydKsZvHH1J+dZpYFmBZZdsCf92980YCCCmL8XNy0CfCMzCu2BqjGBsj2BMBORWpBS+bJagDu9NgpxCoWDXQ+KLNYUfrVXkOwDQMJcCJ7qorsMBC4AK3wYDKjKVVtj8J1jr946yhwLbsk+gaC7Ns4rhgodD6Ho7yv51jFDFzQd6l+lYhmYDy0KIZw6axEc4sFJO46j5NVXIhlac6RGjxTZN3XN3zYm4uuPyY0CuEB+IeNUIkpNbc1R8631+hnHPiIbnTlsI9pqqQ+dGvB9or4NgKGztpd3bITtGQup6pi/tHLNERnDtoDvXmKMbn+UvphLDUds/3zUPvxr0A3grTKMqf2qUYfGWicfYg4q/NeaArnFuQSmhJU7+JJg0mFxV/MI8P8yoFpdGxYehvd4+p7owwyvBp3TVXStqOH+cETQZ1Qufjn7ri8RzO++b4n677nIxQAYcW6lY1f7aRepaTKMYx1S//NXu9HIjHNbaliLrDXpaaqMEs49bhD/3S7WtGVIJcGINV8ZgyUEboEuh+2xiqfrXJDHERrCUsJ9Liz0PEJ1+6kvHYplbM8GxOGIN2F966xVZmmYfZ3QXVrUE/4rpMU01TR9JwmTJwsP4MRt7pu19bMdTjTEpqPOuPt9vX6dbqT/9NmD1HP468d9nM+jCpWUOk7h4ASrMCrmkzw/qtoOmaNvnA8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkN2MWw1UlFXWE9KWVZPZ2djc2FhNFZjV3dFcG5BRnhYOWJiZEhKT01PcEp6?=
 =?utf-8?B?dnQyeUFaZlBzMkw5YnBnV2lRNWtLam1lWFk1VXo4V1pGdFFUdGVJUFdLeEJp?=
 =?utf-8?B?NUZzL1lmbXIrSmtEakhKUGFkQWtPRzNXSmZra0lMckF0S0tONmEvNzJ6ZHZD?=
 =?utf-8?B?cmQ4SitVRTZGNFVqY2pNUXE4OER0K2Fnak1RWlRkNEQvNzNBdC9jQkJ0Z3Rz?=
 =?utf-8?B?eTQ5a3RLUVZ3a3ZrN29EUmkreWFCTGlMeUJFbUQwbmdvOHliamRBcXJIQmV6?=
 =?utf-8?B?TEZVRmJNRi80MHN6YjlwMG40am5Cd0lhU3lFbXJmUjRyYzIwbGlZQ3d0UjZ0?=
 =?utf-8?B?SWRndERWRG15SW42dHhzUmdYUjJycDNoMEdybm84dGljcWtVMHYxK092NVlU?=
 =?utf-8?B?K2c0SE5ycnFHMW13dGJqNFV6SXZMYWpSeXJiWlkvcy8yVFZBS2RaTTVkQitJ?=
 =?utf-8?B?VlNNQWhVL1hIRnBoWVRIdnhJSHRFR3BoTVJ2a0ZPVjJObEhURWpyMUNOdWVp?=
 =?utf-8?B?aUpqUGZOUjlYOWVPZEpYd21YM1BxV2NEdXBWbVI0RGJhVGE5TkdqczJVRjAr?=
 =?utf-8?B?L1NqRkwrYVEvam04K0IwVWVHVlNEOWNzM1ZKTlowQ2MwOW83NzR3RHhPejZE?=
 =?utf-8?B?Y01oa3NWK0F2bnpqQjAwK2dRekRWQnFVdDBsQ1FOd1NrNmErOTFiWU51UWR1?=
 =?utf-8?B?M08wamRtZEJERWl4VXVvUU9aZ2EyODlRQjRaalpaN3h1OWZOWVRLYW45a29B?=
 =?utf-8?B?NitKbWluZFQzSmJxcGs0cXdXR2EwZE0vTStqZW03ZmZCS291Ry9wVFNpRlpn?=
 =?utf-8?B?NkJRcHVjRVY5bTJYNnVyYVhWQWxnb00zdUxaV3c4SzRjVndLVHhqOWExZXdq?=
 =?utf-8?B?c2hxZWVQOEthZW16WE9lR2JucDhzd3BReWtlUDlFOG1XZDRsaU1FYjlFMjdh?=
 =?utf-8?B?ZFVQL3cyVFB0K21lWkVGeWFieEhndC8wdG5zcXIrRTdqRmRPczFvWTdaUlll?=
 =?utf-8?B?eUJibEowUld5ajNUMjJERUkwNVZpb3V4RFNneGYydDVxNUxFUGxnbndDM1F5?=
 =?utf-8?B?TE9QYlpGR1ZvSDBleC9hMUVFei9WMjhWelptc1dTeWoreHNvS3hva3dqeFBM?=
 =?utf-8?B?WFUxTXd4dUd5b1J6OU5WZVRjUkQ4L0JZTHJ0azAzOXFjQk8yZVUvZTYwZGRO?=
 =?utf-8?B?QU1KenJYZExVYldNUlVCRWJYTXRFUkZ2VEttRnZYbnBFRXNGSW0vREo2cVNN?=
 =?utf-8?B?a2V4WHQxQk4xT3ZBTVUzc3pJaXBxTmc0a2NWMHFBcUtRTDB6YklWL0JZSDVM?=
 =?utf-8?B?WmZkQ2wxckkrOFhMZkZOQ2s3dUtid0RRMGFmVlJsaURGeWwwOXBkcEptTk1z?=
 =?utf-8?B?WW1rMmptUmc5d0hZb25Fc0N5ajJZQXQrYUVXTXFINHRhdlZHUjdHazVHOXF2?=
 =?utf-8?B?Y0FlWS8xaWYrMVJld2tTQkdGYTlML3o1NlRZUVJNY0QwbEpYSnJHeDE4cEtM?=
 =?utf-8?B?NDBwUGYyczJzQ3hVVHI5WForNWNvR1VuM3ZBVEpLSXlVWUMxOUxxNk9yQ1Jo?=
 =?utf-8?B?VmZyQ1Y1TDR5cHhZWXg5b0pxQmFQSnpsb291dkYzMGZlVjl2UnV6RFpjNEJw?=
 =?utf-8?B?TGFKN2c2aFNOSTQ0LzRUSDBJYVpoZ2I5Zk12bDRTYXF0b2JlOWU3Sm4reks3?=
 =?utf-8?B?T3dHb09KQ3lwK1NnWXMyMVVkQjQramJTN2c3M1JqQVFnN05JZStGVmJvTjRF?=
 =?utf-8?B?VGIwS2FTNy9HMnhsNDhHTWYrNEE3WUF1ZklVSFRHV0toRDJtUVJMMDlhQWxF?=
 =?utf-8?B?SkVQclZNcjFGZzYvR0lhL3JlK2dvZTNOUVd1QllEZWZyNW9NaitMNWQ0dExU?=
 =?utf-8?B?MGhHTkJ1K2NRWGt0THdiOUhIdC9Jb2JRUW1CdTIzempsazA4WWs5VHB0aE9M?=
 =?utf-8?B?VUZQWDI1c2ZhQVZBcXhyVlRESEUveVVwTmtaRHhIbHRpdlFuNy9nWVI4bm9J?=
 =?utf-8?B?VjhLbG9Fd3BZTkFzYnNIclE3eWcxL2Z2ekYxVUpCNGhweVQ4RVVsVzBTeUxN?=
 =?utf-8?B?SmQrL2JOSmpXQVJLQ0FPZUh0Q0ZhcjFad2RyZzJSZktaenZZUTdXMXRxYTBv?=
 =?utf-8?B?OXFxRUQ1QWd2ZHUzVzNlN3pvUzIvdmhmMDU5Sit0bXdwUnVNK0VaRmR6dlZp?=
 =?utf-8?B?Q0VKTlc0TGlzUnREeW9VME5DWkJuUkYyb3BrY1VOOG1LQTJVS3g5bEJRYkp4?=
 =?utf-8?B?a3VYYzBFVFpHUlBjWS9tVnlLVUt3Zk5XeEE4VkFCdUI2TGhpZDFjWXg5U2M5?=
 =?utf-8?B?ZklneDBIWGhxcEJnNmdYZGtITHd1YWdUTUpoWDRQYUV6SVJnd0srQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d039a315-da4a-43a2-d6f3-08de8561e713
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:47:46.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIvvcveGsmZz9exvAIbefqclRr+8NLEb6kQ+qRNxRrzFVDr55kYGKIOjBdv1DnaVFbFg1qMyk3nG54TYs2rM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

DQoNCj4gT24gTWFyIDE4LCAyMDI2LCBhdCA5OjEz4oCvUE0sIEJvcXVuIEZlbmcgPGJvcXVuQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBNYXIgMTksIDIwMjYgYXQgMTI6MjY6
MzhBTSArMDAwMCwgWnFpYW5nIHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBXZWQsIDE4IE1hciAyMDI2
IGF0IDIzOjE1LCBCb3F1biBGZW5nIDxib3F1bkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+
Pj4gDQo+Pj4+IE9uIFdlZCwgTWFyIDE4LCAyMDI2IGF0IDAyOjU1OjQ4UE0gLTA3MDAsIEJvcXVu
IEZlbmcgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgTWFyIDE4LCAyMDI2IGF0IDAyOjUyOjQ4UE0gLTA3
MDAsIEJvcXVuIEZlbmcgd3JvdGU6DQo+Pj4+IFsuLi5dDQo+Pj4+Pj4gQWggc28gaXQgaXMgYW4g
QUJCQSBkZWFkbG9jaywgbm90IGEgQUJBIHNlbGYtZGVhZGxvY2suIEkgZ3Vlc3MgdGhpcyBpcyBh
DQo+Pj4+Pj4gZGlmZmVyZW50IGlzc3VlLCBmcm9tIHRoZSBOTUkgaXNzdWU/IEl0IGlzIG1vcmUg
b2YgYW4gaXNzdWUgb2YgY2FsbGluZw0KPj4+Pj4+IGNhbGxfc3JjdSBBUEkgd2l0aCBzY2hlZHVs
ZXIgbG9ja3MgaGVsZC4NCj4+Pj4+PiANCj4+Pj4+PiBTb21ldGhpbmcgbGlrZSBiZWxvdyBJIHRo
aW5rOg0KPj4+Pj4+IA0KPj4+Pj4+IENQVSBBIChCUEYgdHJhY2Vwb2ludCkgQ1BVIEIgKGNvbmN1
cnJlbnQgY2FsbF9zcmN1KQ0KPj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+Pj4gWzFdIGhvbGRzICZycS0+
X19sb2NrDQo+Pj4+Pj4gWzJdDQo+Pj4+Pj4gLT4gY2FsbF9zcmN1DQo+Pj4+Pj4gLT4gc3JjdV9n
cF9zdGFydF9pZl9uZWVkZWQNCj4+Pj4+PiAtPiBzcmN1X2Z1bm5lbF9ncF9zdGFydA0KPj4+Pj4+
IC0+IHNwaW5fbG9ja19pcnFzYXZlX3NzcF9jb250ZW50Li4uDQo+Pj4+Pj4gLT4gaG9sZHMgc3Jj
dSBsb2Nrcw0KPj4+Pj4+IA0KPj4+Pj4+IFs0XSBjYWxscyBjYWxsX3JjdV90YXNrc190cmFjZSgp
IFs1XSBzcmN1X2Z1bm5lbF9ncF9zdGFydCAoY29udC4uKQ0KPj4+Pj4+IC0+IHF1ZXVlX2RlbGF5
ZWRfd29yaw0KPj4+Pj4+IC0+IGNhbGxfc3JjdSgpIC0+IF9fcXVldWVfd29yaygpDQo+Pj4+Pj4g
LT4gc3JjdV9ncF9zdGFydF9pZl9uZWVkZWQoKSAtPiB3YWtlX3VwX3dvcmtlcigpDQo+Pj4+Pj4g
LT4gc3JjdV9mdW5uZWxfZ3Bfc3RhcnQoKSAtPiB0cnlfdG9fd2FrZV91cCgpDQo+Pj4+Pj4gLT4g
c3Bpbl9sb2NrX2lycXNhdmVfc3NwX2NvbnRlbnRpb24oKSBbNl0gV0FOVFMgcnEtPl9fbG9jaw0K
Pj4+Pj4+IC0+IFdBTlRTIHNyY3UgbG9ja3MNCj4+Pj4+IA0KPj4+Pj4gSSBzZWUsIHdlIGNhbiBh
bHNvIGhhdmUgYSBzZWxmIGRlYWRsb2NrIGV2ZW4gd2l0aG91dCBDUFUgQiwgd2hlbiBDUFUgQQ0K
Pj4+Pj4gaXMgZ29pbmcgdG8gdHJ5X3RvX3dha2VfdXAoKSB0aGUgYSB3b3JrZXIgb24gdGhlIHNh
bWUgQ1BVLg0KPj4+Pj4gDQo+Pj4+PiBBbiBpbnRlcmVzdGluZyBvYnNlcnZhdGlvbiBpcyB0aGF0
IHRoZSBkZWFkbG9jayBjYW4gYmUgYXZvaWRlZCBpbg0KPj4+Pj4gcXVldWVfZGVsYXllZF93b3Jr
KCkgdXNlcyBhIG5vbi16ZXJvIGRlbGF5LCB0aGF0IG1lYW5zIGEgdGltZXIgd2lsbCBiZQ0KPj4+
Pj4gYXJtZWQgaW5zdGVhZCBvZiBhY3F1aXJpbmcgdGhlIHJxIGxvY2suDQo+Pj4+PiANCj4+Pj4g
DQo+Pj4+IElmIG15IG9ic2VydmF0aW9uIGlzIGNvcnJlY3QsIHRoZW4gdGhpcyBjYW4gcHJvYmFi
bHkgZml4IHRoZSBkZWFkbG9jaw0KPj4+PiBpc3N1ZSB3aXRoIHJ1bnF1ZXVlIGxvY2sgKHVudGVz
dGVkIHRob3VnaCksIGJ1dCBpdCB3b24ndCB3b3JrIGlmIEJQRg0KPj4+PiB0cmFjZXBvaW50IGNh
biBoYXBwZW4gd2l0aCB0aW1lciBiYXNlIGxvY2sgaGVsZC4NCj4+Pj4gDQo+Pj4gVW5mb3J0dW5h
dGVseSBpdCBjYW4gYmUsIHRoZXJlIGlzIGF0IGxlYXN0IG9uZSB0cmFjZXBvaW50IHRoYXQgaXMN
Cj4+PiBpbnZva2VkIHdpdGggaHJ0aW1lciBiYXNlIGxvY2sgaGVsZC4NCj4+PiBBbGV4ZWkgZW5k
ZWQgdXAgZml4aW5nIHRoaXMgaW4gdGhlIHJlY2VudCBwYXN0IFswXS4gU28gSSB0aGluayB0aGlz
DQo+Pj4gd291bGQgY2F1c2UgdHJvdWJsZSB0b28uDQo+Pj4gDQo+Pj4gaHJ0aW1lcl9zdGFydF9y
YW5nZV9ucygpIC0+IF9faHJ0aW1lcl9zdGFydF9yYW5nZV9ucygpIC0+DQo+Pj4gcmVtb3ZlX3Rp
bWVyKCkgLT4gX19yZW1vdmVfaHJ0aW1lcigpIC0+IGRlYnVnX2RlYWN0aXZhdGUoKSAtPg0KPj4+
IHRyYWNlX2hydGltZXJfY2FuY2VsKCkuDQo+Pj4gQlBGIGNhbiBhdHRhY2ggdG8gc3VjaCBhIHRy
YWNlcG9pbnQuDQo+PiANCj4+IElzIGl0IHBvc3NpYmxlIHRvIHVzZSBpcnFfd29ya19xdWV1ZSgp
IHRvIHRyaWdnZXIgcXVldWVfZGVsYXlfd29yaygpDQo+PiBieSBjaGVja2luZyBpZiBzc3AgPT0g
JnJjdV90YXNrc190cmFjZV9zcmN1X3N0cnVjdCA/DQo+PiANCj4gDQo+IEdvb2QgY2FsbCEgSSBk
aWRuJ3QgZG8gdGhlIGV4YWN0ID09IGNoZWNrLCBidXQgY2xvc2U6DQo+IA0KPiAgICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yY3UvYWJ0TWhkX0xWcDN1TF9wQUB0YXJkaXMubG9jYWwvDQo+IA0K
PiA7LSkNCg0KSU1PIEkgYW0gb2sgd2l0aCBCb3F1biBwYXRjaCBidXQgSSBkbyBub3QgdGhpbmsg
dGhlID09IGNoZWNrIHNob3VsZCBiZSB1c2VkLiBTUkNVIGludGVybmFscyBzaG91bGQgbm90IHNw
ZWNpYWwgY2FzZSBzcGVjaWZpYyBTUkNVIHVzZXJzLCB0aGF0IGlzIGEgaGFjayA6KQ0KDQpUaGFu
a3MhDQoNCg0KDQoNCg0KPiANCj4gUmVnYXJkcywNCj4gQm9xdW4NCj4gDQo+PiBUaGFua3MNCj4+
IFpxaWFuZw0KPj4gDQo+PiANCj4+PiANCj4+PiBbMF06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2JwZi8yMDI2MDIwNDA0MDgzNC4yMjI2My0yLWFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20N
Cj4+PiANCj4+Pj4gDQo+Pj4+IFJlZ2FyZHMsDQo+Pj4+IEJvcXVuDQo+Pj4+IA0KPj4+PiAtLS0t
LS0+DQo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3NyY3V0cmVlLmMgYi9rZXJuZWwvcmN1
L3NyY3V0cmVlLmMNCj4+Pj4gaW5kZXggMjMyODgyN2Y4Nzc1Li5hNWQ2NzI2NGFjYjUgMTAwNjQ0
DQo+Pj4+IC0tLSBhL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYw0KPj4+PiArKysgYi9rZXJuZWwvcmN1
L3NyY3V0cmVlLmMNCj4+Pj4gQEAgLTEwNjEsNiArMTA2MSw3IEBAIHN0YXRpYyB2b2lkIHNyY3Vf
ZnVubmVsX2dwX3N0YXJ0KHN0cnVjdCBzcmN1X3N0cnVjdCAqc3NwLCBzdHJ1Y3Qgc3JjdV9kYXRh
ICpzZHAsDQo+Pj4+IHN0cnVjdCBzcmN1X25vZGUgKnNucF9sZWFmOw0KPj4+PiB1bnNpZ25lZCBs
b25nIHNucF9zZXE7DQo+Pj4+IHN0cnVjdCBzcmN1X3VzYWdlICpzdXAgPSBzc3AtPnNyY3Vfc3Vw
Ow0KPj4+PiArIGJvb2wgaXJxc193ZXJlX2Rpc2FibGVkOw0KPj4+PiANCj4+Pj4gLyogRW5zdXJl
IHRoYXQgc25wIG5vZGUgdHJlZSBpcyBmdWxseSBpbml0aWFsaXplZCBiZWZvcmUgdHJhdmVyc2lu
ZyBpdCAqLw0KPj4+PiBpZiAoc21wX2xvYWRfYWNxdWlyZSgmc3VwLT5zcmN1X3NpemVfc3RhdGUp
IDwgU1JDVV9TSVpFX1dBSVRfQkFSUklFUikNCj4+Pj4gQEAgLTEwOTgsNiArMTA5OSw3IEBAIHN0
YXRpYyB2b2lkIHNyY3VfZnVubmVsX2dwX3N0YXJ0KHN0cnVjdCBzcmN1X3N0cnVjdCAqc3NwLCBz
dHJ1Y3Qgc3JjdV9kYXRhICpzZHAsDQo+Pj4+IA0KPj4+PiAvKiBUb3Agb2YgdHJlZSwgbXVzdCBl
bnN1cmUgdGhlIGdyYWNlIHBlcmlvZCB3aWxsIGJlIHN0YXJ0ZWQuICovDQo+Pj4+IHJhd19zcGlu
X2xvY2tfaXJxc2F2ZV9zc3BfY29udGVudGlvbihzc3AsICZmbGFncyk7DQo+Pj4+ICsgaXJxc193
ZXJlX2Rpc2FibGVkID0gaXJxc19kaXNhYmxlZF9mbGFncyhmbGFncyk7DQo+Pj4+IGlmIChVTE9O
R19DTVBfTFQoc3VwLT5zcmN1X2dwX3NlcV9uZWVkZWQsIHMpKSB7DQo+Pj4+IC8qDQo+Pj4+ICog
UmVjb3JkIG5lZWQgZm9yIGdyYWNlIHBlcmlvZCBzLiBQYWlyIHdpdGggbG9hZA0KPj4+PiBAQCAt
MTExOCw5ICsxMTIwLDE2IEBAIHN0YXRpYyB2b2lkIHNyY3VfZnVubmVsX2dwX3N0YXJ0KHN0cnVj
dCBzcmN1X3N0cnVjdCAqc3NwLCBzdHJ1Y3Qgc3JjdV9kYXRhICpzZHAsDQo+Pj4+IC8vIGl0IGlz
bid0LiBBbmQgaXQgZG9lcyBub3QgaGF2ZSB0byBiZS4gQWZ0ZXIgYWxsLCBpdA0KPj4+PiAvLyBj
YW4gb25seSBiZSBleGVjdXRlZCBkdXJpbmcgZWFybHkgYm9vdCB3aGVuIHRoZXJlIGlzIG9ubHkN
Cj4+Pj4gLy8gdGhlIG9uZSBib290IENQVSBydW5uaW5nIHdpdGggaW50ZXJydXB0cyBzdGlsbCBk
aXNhYmxlZC4NCj4+Pj4gKyAvLw0KPj4+PiArIC8vIElmIGlycSB3YXMgZGlzYWJsZWQgd2hlbiBj
YWxsX3NyY3UoKSBpcyBjYWxsZWQsIHRoZW4gd2UNCj4+Pj4gKyAvLyBjb3VsZCBiZSBpbiB0aGUg
c2NoZWR1bGVyIHBhdGggd2l0aCBhIHJ1bnF1ZXVlIGxvY2sgaGVsZCwNCj4+Pj4gKyAvLyBkZWxh
eSB0aGUgcHJvY2Vzc19zcmN1KCkgd29yayAxIG1vcmUgamlmZmllcyBzbyB3ZSBkb24ndCBnbw0K
Pj4+PiArIC8vIHRocm91Z2ggdGhlIGtpY2tfcG9vbCgpIC0+IHdha2VfdXBfcHJvY2VzcygpIHBh
dGggYmVsb3csIGFuZA0KPj4+PiArIC8vIHdlIGNvdWxkIGF2b2lkIGRlYWRsb2NrIHdpdGggcnVu
cXVldWUgbG9jay4NCj4+Pj4gaWYgKGxpa2VseShzcmN1X2luaXRfZG9uZSkpDQo+Pj4+IHF1ZXVl
X2RlbGF5ZWRfd29yayhyY3VfZ3Bfd3EsICZzdXAtPndvcmssDQo+Pj4+IC0gISFzcmN1X2dldF9k
ZWxheShzc3ApKTsNCj4+Pj4gKyAhIXNyY3VfZ2V0X2RlbGF5KHNzcCkgKw0KPj4+PiArICEhaXJx
c193ZXJlX2Rpc2FibGVkKTsNCj4+Pj4gZWxzZSBpZiAobGlzdF9lbXB0eSgmc3VwLT53b3JrLndv
cmsuZW50cnkpKQ0KPj4+PiBsaXN0X2FkZCgmc3VwLT53b3JrLndvcmsuZW50cnksICZzcmN1X2Jv
b3RfbGlzdCk7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4gDQo=

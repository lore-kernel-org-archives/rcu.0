Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364423;
	b=Mrwytll1mgIcId15Jds3isT3QHhB7DuwW+egrG58zCj7cIUrV69/iyZgvoydtQnRsDpR
	 K0kOqxiS9fIGxiTVvEH9T0kf/FgFmSgqMptTxhgUTc5fpJ19wiErG+UCXKr0XKHft//z0
	 PJpBtcRmm97n9lkdvMXpwlNEh2yiLydMNGvrhq99xlFpJTPDYlqObA9fB09zUyeTe8r4d
	 lhH/0wlSKVOBlhnZeOGPpOHCb5DnXPnpccUHIKJtu7q5oHhHII2mFpFRLfYlvW9XWgNZx
	 5e8/hc7cmE03I0rx4O7x80e//Ld0p1GWK7YU5KRsjYhpEjBrmePOFIp7lSXT3imCDTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364423;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rSdN+Zn4FmAMhuK9cRBrsGEOCkzNEReT5tXSberfDww=;
	b=MzZ7fenBxvuWRof5OsdDoZxMS/kDiAQVBEmnazBZJbd3C+agZX6sIL36WyQ+5wnNVuQJ
	 r1fuuu4Gz2qeA02KHgtm/q8CzRPTZHJIZPtCkO1nQwkJqtT0L7r/H02ZpCV7AE9lECnfZ
	 wUAQrIkWRGDIB/XRdRGfwVljg25KYK5Ni9Dl8zjUreU5g3qCyOCi1eSQrDSks7cBczu9D
	 LgBxsG+tAwPAW4kjby8ypQIq+NQw9czwINfLBYid/gYKSZqQehRgaGkHRqssD37T8iyBG
	 G7H8wazQElp7I/7LQHZ3GTnCQlCILbB5N9433J6TTsO/YGnblQLc8ve+UObuf7Dd1MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XYN3CIQy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.41
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDB606A31A;
	Fri, 30 Oct 2026 12:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EBDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XYN3CIQy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4dqUwjhl8zvATRvMUhM+iLblht8IYOHDaM/NAkQmTyHXmzh/adfEEGIBZCVjtAvecRvNaE7eaaU+/ulpVi6o8EqmGBNEt3OichOpD+wNHBCp3VLF//ULkW+JGSWsITwYTupwxGcnrqazi7Nt1tgXVH3ilV48/l3h+vSohwDi1xCBe2URXndYn6e9vFDBKi1oe5c1EPEex1/pJmwFkHjhYyGyjBEBRiLYzMkWjlHaO81PkaOhldPNSzBRpkcoAqycSwGHDtZE8xoUhJ6/T9iStG6AkhZTR4dIclP9MTgWwaWAkceNeD6UP5gr6L9mur2lqIzZmlb5Hp7+uSB1qc7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSdN+Zn4FmAMhuK9cRBrsGEOCkzNEReT5tXSberfDww=;
 b=JKUfhvOSoFpdZ8snMjlMN8NdgfYTo8IUmhtoktJ32Zb5cfVeOG6V/QJsMgFjf5EDDzPD66FEIpmG8v5pneF5zkVcAXASA8qWue2yFxnmzPE81IsVozcy+CF1Pj3hfRqRG+dED36rhvR7zqjumPWlm49Ju6Ay6fGkGRCdJF6OVD+6NH7q5Akvu7MeKkPKqB7yUv2Y1aFf/ryMaFWFali/7UF+B1NhTnsr1QrKJ9K17/+V3Dd4tbAM9skPKrGzphliKr/RO7GMN9xTdAL9MPhp7ED1edce6zqmqPR0xcSWNEAwGA6sqPX20O3nVs0W5uGRgbG8UgxXkAQncoq3WRyjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSdN+Zn4FmAMhuK9cRBrsGEOCkzNEReT5tXSberfDww=;
 b=XYN3CIQyeOFYpiwj+FdL5M4T2fs3YsOtdHavZtFWXe3rih13tHQmN5wKJBETIed30NbQFI63L5UOg3Q/BUidTJHUYAEJ0DEmLx7ji85EoCHwYVM5fp66gdZ0mw7dz+qXekOo85uj5bv1XzBFumyknpGuqFudaqGIKKQfL6mA6hk5jEfsS2K+RkptfeKLpxi3hbPdjteG+QYuq+dy4xiGhLhy6tuouK2ttLvbfoIP1QDQuD+3i09ym1Le3oSbU5epNOB8O2xg/8CgfB25TpSbFZ0e0k/DtyvxJ8GZsW9LwlZUfx4R/H5VcuRv0fi05uzdgfb1LW7Xg0EXuQdvjhFtlw==
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:46:55 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:46:55 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"boqun@kernel.org" <boqun@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for tasks-rude
 and srcu-atomic
Thread-Topic: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for
 tasks-rude and srcu-atomic
Thread-Index: AQHdaGy+ox+SsOmCBUyv56KrLcGFUQ==
Date: Fri, 30 Oct 2026 12:46:55 +0000
Message-ID: <ACA82057-9E74-41CD-8EEE-1D59E98D2D41@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7742:EE_|DS0PR12MB7582:EE_
x-ms-office365-filtering-correlation-id: c9b76e9d-4fa0-4ef4-ab92-08df3683e133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|3023799007|38070700021|56012099006|11063799006|5023799004|261026121527099003|261026130827099003|261026140227099003|261028144727099003|10067099003|261021135927099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261009223027099003;
x-microsoft-antispam-message-info:
 EWm1VBk0RzRHfTdPZOlYO6dR4kgrpjqD2Pw7bLbKvRI0mI4RU6nvjGw0xblrHxadcNursM5fdKT20GK42W/C2u7Vewqbb77yyoW/PagJnZUrh700b0Wy+B8MNoN2EOr1JoAb8vFYB1FVzkS3skGta8tAPzDTMZ1vergO5VSQzHuSp17l+Am3aDHoQZ72yTmYPRX5DElaZs62SgGOnMTx7mNSbZHtDmIXpd0HDnTGo5HR+TPb3Jw8GFAK/X1GCAmn4brXoNs/m+xzStHcXO3wxpdcvWqumuG9kVRn2dvXMjQ1jbpRae8ejzKpAkOqKwd2EkRNdQML2uk9Hwk19EDYWIA0Nq+tRiZv9Gy4agvcmxlFJMXeqF3Gi8iAqjcfphlFq8PDzJz5jOYYIJQkZyMxhkNOWFKAYc4KR01eLMGjaVzPCqopULLd0E2kvTJu0ZJpsJc6nyptjuO2Cnj92NX5rO7HO3HjJE2m/fF3LiInDD4JSJMtgO00Rpjsc73bt1LE3Z0cvNKLMXG9WMNvv2OXc7X9FBLo8G3ks3HBXVqV2kOGuOAqjPGoZyr2TOSpxUQc+FkxyA/mrEZ+nzc03mCs/jsqUFlOIBgcJ+DFPUeklNNEULR9Q+AEvkfaUvsdG4+2ZP44p/eHHJQYi0+38ivOGqfhHdn/P7LnLpt2xWcVir21K7nrLWQmZFWBllej042a94g4jLvoPya4Yd8zF224FGQNc17Tl51ZOaTBvS/OnbA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(3023799007)(38070700021)(56012099006)(11063799006)(5023799004)(261026121527099003)(261026130827099003)(261026140227099003)(261028144727099003)(10067099003)(261021135927099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEIxYVZGNERpWDlXeGpvb1JFdXFpMnIyMERVcWNGWXRyaEExaFJzeUJ2alYw?=
 =?utf-8?B?bW1GZXRaaXRYQ1Z5OHNZK3ZBSFg3UmpmUk41WTIrS1pxQXJzUWI1ZTFnejBa?=
 =?utf-8?B?VTdaZGRjT2dPTWtobkc5KzJ0aEV2SlNMK2pLc3ZIUmZvd08xcjVPd3ZZUnFs?=
 =?utf-8?B?VkhIZmJyMDJKZ2NoZGJOZ2QrWUxJS2YzeTljZ1V1dytldWlabGxDOHFmWnY5?=
 =?utf-8?B?aHBESDd5UkxwV3RaWi9uSkpjb0pHOEVPZ1NVcWd3K0t0UVZndGVreFJqOWdj?=
 =?utf-8?B?dlBzTC81RzNjQUpKN0hyMlkzMzI3bU9VSnEycGZTczViekdReU5TOWtEMi9v?=
 =?utf-8?B?L0MzNE9ZOEw3UzhKcDByWWk4T0ViRVlmSUV0MDg5Z29WM3hJS3FhamprRWc3?=
 =?utf-8?B?VWhFV2UrbTBBcUg1emFXSGpDZ3pzdE5QOGhtLytqUlN5eEtCeVkxNStvQzB2?=
 =?utf-8?B?ZVFUSUt2Y1BrVEhXNE1NVnlaMGxCUkJUTFZkbytGUEs5aGgyRHRSS21kbkdV?=
 =?utf-8?B?aFZDdTdIN1FZdXFCbE9USnNqeG5wUGVhS2Q2bmx0M2hkdU80d28rNXl3Y2dM?=
 =?utf-8?B?dHFyOGcwNnRtYzk3UmdJUmZ2d1BjQjJheG9Hb3orOC90ZFh5bHk5RFhvaCtX?=
 =?utf-8?B?bG4wcFh4UkloTTI5ZUhnNmZnbmtuSDduenhubUNoVzA0MW9GV1lqaTdJaVdy?=
 =?utf-8?B?TGZzT1FydkNhQS9KazMzdmxQQW1wUVNMbERtUWZjT1JiSllUVkhhZnRUN2RN?=
 =?utf-8?B?dmhubFltTHcwSW81eUNCK0VlNDJtcjFtWFM0N3o5VTdpUXF1UEtSWFRNSjc4?=
 =?utf-8?B?VkJHWGs1eGtmYVM3eU5QVk5HeDUxYmVqaXp4em1SWElndFp2SFoyaWphWS9t?=
 =?utf-8?B?S3ZBQ1UrVEdjK0c4c0dMdG1kYTdPNDcwV1kzMkltNDlZdFBtb1RNa0JQb1B6?=
 =?utf-8?B?OHlxM09tV0QyVUVKV0J3ZDN0bUx6Q09RWlNRN3dtL0tYcmh3Mk9pb3ljeFlS?=
 =?utf-8?B?ekhxWHc3enR5TVlON2FWSWx6dlJKd0I5dEJPT0l0VG5naUQwbVdTUEF3eFNO?=
 =?utf-8?B?d3lNL2Fzd1d0SnpEUG9nWlh6dm1nL1JjRE5JZmlXck5pU3pKV0pQOS85RElO?=
 =?utf-8?B?aGJSYm5IV21sRTcyeHJ0TVZyY0FNcEtqU2o0K0Z6Smxtb3ZqeVFTUlh4MkRz?=
 =?utf-8?B?cE9HNGFVMmxla3hWZTFDeTFZSExLYUpJcHY2ZXk1Ynp1OHhmYlI5R2t6TUxm?=
 =?utf-8?B?QkRJd1Q1VzhjT0dQczlYM2ZhWlZuTldrVG1Eb2MzRzl3VDAxQ3BpMSs0QkNj?=
 =?utf-8?B?NkFMMlJQQjF1K0NHVVdER3FTSzZRWStOR2xZc3RXazdMVitncTdiNnpDWCtm?=
 =?utf-8?B?UjlqR1J5L3VNK1dxZzVXSTgzUVpLeXJrc0FpOXlVV3hjRnFSYXZ3QmFRY2JM?=
 =?utf-8?B?b001bHg2dnBKbUxMSmdGbG0vUEFaYnNzWUlDa2ZQUkFtQ1R5VjJJanVIeTlx?=
 =?utf-8?B?L2RPU3gzd0kzSFlzcnFaa1YwTXBlZVhMb0U3cGVJb1dDZ2s1NzZuK2ZkMWxs?=
 =?utf-8?B?T1VicXZhdTRaR2UzUzMxeFF0Y095V0FSTWYvRW0zSmVHZ3NzdmpnSFMxQWVU?=
 =?utf-8?B?dzlvcDJqU2RNcWN1MEcrY3dYSXVabXNJazFvcGVWcHZrV25JUm1SUHJON0pI?=
 =?utf-8?B?b3FmR2ZWVndjQitsZkZpTjI1ODJtMWhtd2xDZnZpSHhlcWVSa1J4TXc2bmNE?=
 =?utf-8?B?djUycU9WOC9VVDBWMlBUYmE5bXAxMWJUREs0MVVIMS9xNCtVeXFPVURRWlpJ?=
 =?utf-8?B?WElORkFBeGtTNFYwM25xanVXR1FzVWxNV2dxeWp0UjZRektNM1A2U1RuSW5w?=
 =?utf-8?B?aTVLQ1NKT2M1Y1ZtVVJ0dDJWOTVFRVIvYm9rYWprRTNWSFE0S0YyQzJWRVFo?=
 =?utf-8?B?SmlYM0ZjZDJJM2FCRUMzNGZKVkdaNk5pTS9VR3A3emJoOEpLRGV4a2ZpZlpv?=
 =?utf-8?B?V2FQTkkycG5oL3NDOTkrTVpRMGh4bnhrbGZGYUFqOW44eDJQYWJ1YlVBTEhW?=
 =?utf-8?B?VjUxSjFNUDRYcWJIV3p5L2Z1WVFybStDZUxyTEZUY0ZtMlhBS3NSK1FBR0FS?=
 =?utf-8?B?R2xkR1ovWFdOYWxFM2F3UGlpNnB4SXJ0Ykcxcm1WdzEzOGZnc1NFMFhIeDZH?=
 =?utf-8?B?Q2pIN1ByWVd5N2pBc1JKcC9Wd1QwVUJ5bnJVQmI3ZndPUldqZ0ZMOGpwanhq?=
 =?utf-8?B?c0JFQjFTV3pvVTkyY1ZKSWN6Q0FRblhUVFd1bXF5cmJzSmMyd3Nib0IwczdB?=
 =?utf-8?B?UVRVaEJScUN6dERtOWFsVDRTN2pVbzdmdUNuMDZJWlJjZmhJOVpCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC21C94335ADA34AB921D3969ECD348E@NVIDIA.onmicrosoft.com>
Content-Transfer-Encoding: base64
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b76e9d-4fa0-4ef4-ab92-08df3683e133
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 12:46:55.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLarV8gjJhYzEsYNi2WRnK3ZzVs8Pq4+LOsrgN6DupwWeF4LygzbD41Tym+7ZvaH1gu4IKueHvIMGtSxO04Syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582

DQoNCj4gT24gT2N0IDMwLCAyMDI2LCBhdCA4OjE04oCvQU0sIFpxaWFuZyA8cWlhbmcuemhhbmdA
bGludXguZGV2PiB3cm90ZToNCj4gDQo+IO+7vw0KPj4gDQo+PiANCj4+PiBPbiBGcmksIE9jdCAy
MywgMjAyNiBhdCAwNTozNzoxNlBNICswODAwLCBacWlhbmcgd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+
Pj4gV2hlbiBydW5uaW5nIHRoZSB0YXNrcy1ydWRlIGFuZCBzcmN1LWF0b21pYyB0ZXN0cywgdGhl
IGZ3ZF9wcm9nX3Rhc2tzDQo+Pj4ga3RocmVhZCBpcyBjcmVhdGVkIGJlY2F1c2UgdGhlIGRlZmF1
bHQgdmFsdWUgb2YgZndkX3Byb2dyZXNzIGlzIDEuDQo+Pj4gaG93ZXZlciwgdGhlIHR3byBSQ1Ug
Zmxhdm9ycyBub3Qgc3VwcG9ydCAtPmNhbGwoKToNCj4+PiANCj4+PiAxLiB0YXNrcy1ydWRlOiBj
b21taXQgYjQyOGE5ZGU5YmJhICgicmN1dG9ydHVyZTogU3RvcCB0ZXN0aW5nIFJDVSBUYXNrcw0K
Pj4+IFJ1ZGUgYXN5bmNocm9ub3VzIEFQSXMiKSByZW1vdmVkIC5jYWxsIGFuZCAuY2JfYmFycmll
ciBmcm9tIHRhc2tzLXJ1ZGUsDQo+Pj4gYnV0IGxlZnQgdGhlIC5jYmZsb29kX21heCA9IDUwMDAw
Lg0KPj4+IA0KPj4+IDIuIHNyY3UtYXRvbWljOiBzcmN1X3RvcnR1cmVfaW5pdF9mb3JiaWRkZW5f
YXBpcygpIHNldHMgLT5jYWxsIHRvIE5VTEwNCj4+PiBmb3IgU1JDVV9SRUFEX0ZMQVZPUl9BVE9N
SUMgcnVucywgYnV0IGxlYXZlcyAtPmNiZmxvb2RfbWF4IHVudG91Y2hlZC4NCj4+PiANCj4+PiBJ
biBib3RoIGNhc2VzLCB0aGUgbm9uLXplcm8gLT5jYmZsb29kX21heCBmb29scyB0aGUgY2hlY2sg
YWJvdmUgaW50bw0KPj4+IGNyZWF0aW5nIHRoZSBmd2RfcHJvZ190YXNrcyBrdGhyZWFkcywgZXZl
biB0aG91Z2ggdGhvc2Uga3RocmVhZHMgY2Fubm90DQo+Pj4gcG9zc2libHkgY2Fycnkgb3V0IGFu
eSBmb3J3YXJkLXByb2dyZXNzIHRlc3Q6DQo+Pj4gDQo+Pj4gMS4gVGhlIHJjdV90b3J0dXJlX2Z3
ZF9wcm9nX2NyKCkgcmV0dXJucyBpbW1lZGlhdGVseSBkdWUgdG8gY3VyX29wcy0+Y2FsbA0KPj4+
IGlzIE5VTEw6DQo+Pj4gDQo+Pj4gWyA2OC4wMjI2NzRdIHJjdV90b3J0dXJlX2Z3ZF9wcm9nX2Ny
OiBObyAtPmNhbGwoKSwgc28gbm8gZm9yd2FyZC1wcm9ncmVzcyB0ZXN0IDANCj4+PiBbIDEyOS40
NjIwNDZdIHJjdV90b3J0dXJlX2Z3ZF9wcm9nX2NyOiBObyAtPmNhbGwoKSwgc28gbm8gZm9yd2Fy
ZC1wcm9ncmVzcyB0ZXN0IDANCj4+PiBbIDE5MC45MDIxMjNdIHJjdV90b3J0dXJlX2Z3ZF9wcm9n
X2NyOiBObyAtPmNhbGwoKSwgc28gbm8gZm9yd2FyZC1wcm9ncmVzcyB0ZXN0IDANCj4+PiBbIDI1
Mi4zNDM4MDldIHJjdV90b3J0dXJlX2Z3ZF9wcm9nX2NyOiBObyAtPmNhbGwoKSwgc28gbm8gZm9y
d2FyZC1wcm9ncmVzcyB0ZXN0IDANCj4+PiANCj4+PiAyLiBUaGUgcmN1X3RvcnR1cmVfZndkX3By
b2dfbnIoKSBpcyBuZXZlciBldmVuIGludm9rZWQsIGJlY2F1c2UgaXRzIGNhbGxlcg0KPj4+IHJl
cXVpcmVzIGN1cl9vcHMtPnN0YWxsX2R1ciwgYW5kIG5laXRoZXIgdGFza3MtcnVkZSBub3Igc3Jj
dS1hdG9taWMNCj4+PiBwcm92aWRlIC0+c3RhbGxfZHVyIChvbmx5IHJjdV9vcHMgZG9lcykuDQo+
Pj4gDQo+Pj4gVGhlcmVmb3JlLCBjcmVhdGluZyBmd2RfcHJvZ190YXNrcyBrdGhyZWFkcyBpcyBw
b2ludGxlc3MsIHRoaXMgY29tbWl0IGFkZHMNCj4+PiAtPmNhbGwgYW5kIC0+Y2JfYmFycmllciB0
byB0aGUgZm9yd2FyZC1wcm9ncmVzcyBjaGVjaywgcmVqZWN0aW5nIGZsYXZvcnMNCj4+PiB0aGF0
IGxhY2sgdGhlIGNiZmxvb2RfbWF4IHNldCBhbmQgYSBwb3NpdGl2ZSAtPnN0YWxsX2R1ci4NCj4+
PiANCj4+PiBzaW1wbGUgdmVyaWZpY2F0aW9uIG91dHB1dDoNCj4+PiANCj4+PiBbIDMuMDYyOTU5
XVsgVDFdIHNyY3UtdG9ydHVyZTogcmN1X3RvcnR1cmVfZndkX3Byb2dfaW5pdDogRGlzYWJsZWQs
IHVuc3VwcG9ydGVkIGJ5IFJDVSBmbGF2b3IgdW5kZXIgdGVzdA0KPj4+IFsgMi45MjIzMjNdWyBU
MV0gdGFza3MtcnVkZS10b3J0dXJlOiByY3VfdG9ydHVyZV9md2RfcHJvZ19pbml0OiBEaXNhYmxl
ZCwgdW5zdXBwb3J0ZWQgYnkgUkNVIGZsYXZvciB1bmRlciB0ZXN0DQo+Pj4gDQo+Pj4gU3VnZ2Vz
dGVkLWJ5OiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEuY29tPg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAbGludXguZGV2Pg0KPj4+IA0KPj4gUmV2aWV3
ZWQtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4+IA0KPj4gSXQg
d291bGQgbmV2ZXJ0aGVsZXNzIGJlIGdvb2QgdG8gcnVuIHRlc3RzIGRlbW9uc3RyYXRpbmcgdGhh
dA0KPj4gZm9yd2FyZC1wcm9ncmVzcyB0ZXN0aW5nIGhhcHBlbnMgYW5kIGRvZXMgbm90IGhhcHBl
biBvbiB0aGUgc2FtZQ0KPj4gcmN1X3RvcnR1cmVfb3BzIHN0cnVjdHVyZXMgYXMgYmVmb3JlLiBK
dXN0IGluIGNhc2UgSSBsb3N0IG15DQo+PiB3YXkgdGhyb3VnaCB0aGF0IGJvb2xlYW4gZXhwcmVz
c2lvbi4gOy0pDQo+IA0KPiBPaywgSSBzZWUuIHRoYW5rcyBQYXVsIDstKSAuDQoNClNvIGxldCBt
ZSBrbm93IFpxaWFuZyBvbmNlIHlvdSBhcmUgY29uZmlkZW50IG9uIHRoZSB0ZXN0aW5nIGZyb20g
YW5kIEkgd2lsbCBhcHBseSBpdCBmb3IgNy41Lg0KDQp0aGFua3MsDQoNCkpvZWwgRmVybmFuZGVz
DQoNCg0KPiANCj4+IA0KPj4+IA0KPj4+IC0tLQ0KPj4+IGtlcm5lbC9yY3UvcmN1dG9ydHVyZS5j
IHwgNSArKy0tLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIGIv
a2VybmVsL3JjdS9yY3V0b3J0dXJlLmMNCj4+PiBpbmRleCA5NjgzNDNiZTRlMGQuLjkyZmYxOTdm
NDc4OSAxMDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYw0KPj4+ICsrKyBi
L2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+Pj4gQEAgLTQwMDcsOSArNDAwNyw4IEBAIHN0YXRp
YyBpbnQgX19pbml0IHJjdV90b3J0dXJlX2Z3ZF9wcm9nX2luaXQodm9pZCkNCj4+PiB9IGVsc2Ug
aWYgKGZ3ZF9wcm9ncmVzcyA8IDApIHsNCj4+PiBmd2RfcHJvZ3Jlc3MgPSBucl9jcHVfaWRzOw0K
Pj4+IH0NCj4+PiAtIGlmICgoIWN1cl9vcHMtPnN5bmMgJiYgIWN1cl9vcHMtPmNhbGwpIHx8DQo+
Pj4gLSAoIWN1cl9vcHMtPmNiZmxvb2RfbWF4ICYmICghY3VyX29wcy0+c3RhbGxfZHVyIHx8IGN1
cl9vcHMtPnN0YWxsX2R1cigpIDw9IDApKSB8fA0KPj4+IC0gY3VyX29wcyA9PSAmcmN1X2J1c3Rl
ZF9vcHMpIHsNCj4+PiArIGlmICghY3VyX29wcy0+c3luYyB8fCAoKCFjdXJfb3BzLT5jYWxsIHx8
ICFjdXJfb3BzLT5jYl9iYXJyaWVyIHx8ICFjdXJfb3BzLT5jYmZsb29kX21heCkgJiYNCj4+PiAr
ICghY3VyX29wcy0+c3RhbGxfZHVyIHx8IGN1cl9vcHMtPnN0YWxsX2R1cigpIDw9IDApKSkgew0K
Pj4+IFZFUkJPU0VfVE9ST1VUX1NUUklORygicmN1X3RvcnR1cmVfZndkX3Byb2dfaW5pdDogRGlz
YWJsZWQsIHVuc3VwcG9ydGVkIGJ5IFJDVSBmbGF2b3IgdW5kZXIgdGVzdCIpOw0KPj4+IGZ3ZF9w
cm9ncmVzcyA9IDA7DQo+Pj4gcmV0dXJuIDA7DQo+Pj4gLS0NCj4+PiAyLjE3LjENCj4+PiANCj4+
IA0K

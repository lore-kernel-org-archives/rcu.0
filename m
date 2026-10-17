Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22248E0E7;
	Sat, 17 Oct 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249363; cv=fail; b=uKVeAPdff8QFIv/1hWVFMdU/BApSVyMu3EpnnZm1c5L5a0b8ZCf8R//16X0fO1rquP5qMtP7FIwGGd1xVrL88nX8xlbrAu/75DBxay16RalQLIjiC564nA8MXJUNQ7ut6T53fB1G8u9Xyf79WM3XICSgju51z4Wh7NIfGqASI2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249363; c=relaxed/simple;
	bh=3fjbTfDEKc2X3flF3hquABb+OfIN4lR1DpTMLJUZghk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEDa1B4sS37LE819JhmkaR2ygWZw7HiiOdf2ZfzDAaKLYjM7VmgBXqmVMljCYwWhSnA454RDfwqNAi+O6kt+xacVWU2xpJ5VE7Cr2Ea8/GpUsnfDGtQ3a7e0LteAdSxNcrWpdhEHbkOntVmZ/AqLdjKRz6lkLurSu7ambZGZgQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIc6cgH+; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIc6cgH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpkjEI3rz4q0l6hLIQCLC6kzGr+W+ZivO8zVkoh/HjwSJ53WYp4mylS3kCmhQniiQr7AK1Ck1yC4cLFv47+yNxWRQIZEFGkdD569+ZtWPYHMzpMxvhqP0LZP5vy0wM9V8BYylYKMQoWz6K4VFjhhB/+GLIzhILaGDh6ze6nOe+z0osZz0wRc88jKdy4NhrGTyhBliUrgbprN36Tf3Eo6JfLw8+9pMmCNLDVxipb9NoPkvbklzF30+MHDC96blwFWrJ2ts1wjzJynmmG2lN3XMcq/DQP56iStCAs7RH59lpqu9Cdr2jedcKfZF+YIqZ0hQoTQ9OmmRF7zDZzZ4O2CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fjbTfDEKc2X3flF3hquABb+OfIN4lR1DpTMLJUZghk=;
 b=ITkRfpAqGxZ33Ct6HRw45akuMUxFBmThicSOzsYgzwaeAv68aXqTSqg9AFb4SHnTDRVnIBCLTfT2IOEtMkd/+0uM84svdUfvbH/y8IOSKz358/bQAIMISy1aZn/hlavWOyIVwV5kb6nkHCY7U8H1lAyX7ae1JjJeyyKwLulOqtnmdKRpyVYaU7HYSGqAe/LseEq1kdGzjU4hD5NQrnYaUgFzW6+5bMj+6iJFFJrDstU7siDqYef4lI+CBXJz2O6bWqDQU2J4HtBd0ssyfrP2lzbihwS81KX1b5RI+98FeekGA41kdt5uuEb5txgbZ0jPmNW2WR/gJ7GFVNJbKqTm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fjbTfDEKc2X3flF3hquABb+OfIN4lR1DpTMLJUZghk=;
 b=tIc6cgH+XzltES3TOmcBUCDK3J/tDKvYRwSkCjfFuisLbIPK6xtGH2VvLALYMR1scSzBGLiOkHp9TsyxZrULMNBRlPRVR1X+QtS+m2TQ+47c3RPEt0i2XSqigmdwYBUPWc4s2RsJzpuEE0F9YQLw7Me40ZTmK8NC4BW7I3Zbea61LWvF9cgGc7RHjtKLYfZpcYNQ4Jf3wkREtrDNOS73MJ64zku5CbW6tKBjKO88Rs0bW+u1djrbIb0o2ESfUn3AJNbwKIxqAXpbVl3B4PMji8ReGOn0dblg/1cCtQLKwRkcDJt2LwB5cUknISTk2Enhl5jDP0F5ixjDwHCzErBuRQ==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.12; Sat, 17 Oct 2026 15:02:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.021; Sat, 17 Oct 2026
 15:02:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"boqun@kernel.org" <boqun@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "qiang.zhang@linux.dev"
	<qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
Thread-Topic: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
Thread-Index: AQHdXIoOw8oKAMF5GkqWWPIoLDAGl7cB2AQs
Date: Sat, 17 Oct 2026 15:02:37 +0000
Message-ID: <970F52C9-3198-4BD1-B1A9-6A4B24F550AA@nvidia.com>
References: <20261015094619.8773-1-qiang.zhang@linux.dev>
In-Reply-To: <20261015094619.8773-1-qiang.zhang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: 0fe5dad0-6233-4c67-5eee-08df2c5faeca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|56012099006|38070700021|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 6i+qUGKaxDZhDoaVsV6zwoDRdWCgR+Z+qgBKca6b2h70JLgsbJ35+c0qELjFC+WTRfiCEE1X0NqJtpqNAzRV1S6gpqU11dYqXTlGzgea3A+WvXeE9aCUYmeWecQM4jpI0nryuRq29B01+MaoZRrBDZcVBVTWwPaXU1eyRiGmwZiRP22rJNDzCje+0Tlcfidd05Eg+dTEpFhTcGL0t4FO/SSfoGf1Fg/MxsHPOOHNYxuGotmdMBMwys3w0CpVukT0j/gnfzQ7KAEwrsF5PVxBEXLG2UNMIh9JQkS/05kESmV3QYRQJgPbCp4xi0+usIOJMwHXKU82+bgxTjIPQdfh1TQKqh02JD6KxYJx3YaJvebO250+BITFoOYNeI/6oYUagug6T5EfSPDyAjO5HCdi5gSv0Jc26w1PHQgkgTC2eQ2g3Jg3U6sxAdunUrnk9W2YUdDzCda6kiQqzUeN9CHc8JYNuBMKw9eyXogIEQN8D4WQbx8NMmMAikKhyOW0El+gHUoUPq8W4VguXF39qMYBij5CXd4oOgi+BLA0K67GPps94lYNGIF1uBYOBAIiHS2FfwojBnVYHlx+Exg42lGMpf4AxC+JJvmHfmLhqjM9+O8xr1iwq0UOmfA4CIYTuT99KNvNbp5NWqyxW0veV+8OFw63QYaK1ogjXx4iH/Zucm9ZzyehfqoNPbH1pZ9yZ4KAs7SSljflEyy33KDyTs9IGTxNN6XuqnKN9T72SVqYAfU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(56012099006)(38070700021)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWgyUGp3QnBKQ0ZKelJTZ1FkOGYwRThpR1EzUmVRZm8zUHJRL1ZJaHpjNVZj?=
 =?utf-8?B?Z0gzVERLMStORDU2MzIyT25zQ1lZLzRENUp2VnVRaUhrOTdGWVNtWE9lZjdY?=
 =?utf-8?B?NkZseU1SdCs0NTB2VTRlOHlzTDNvU2V6T1lmWnJ0R1IzcE1XbktsVTB5ZFcy?=
 =?utf-8?B?dGNNeWVUYmxrNmVmRjVzTzhWSHovOStobG1NdXpaaStzTEJzM0xaS2pRRUI4?=
 =?utf-8?B?SE1WYjNQTDBuOHlPZHNsWnNnZ3pwV2lNN3M3RCtvbENMU2FpSGRaRWpMYkdq?=
 =?utf-8?B?bElNbDdQcXlaVjRGZTlQN2pQK2JWYmVieFdaM0hjT0ZFWUNlTVlIeHV1dTl3?=
 =?utf-8?B?bEcwS2hOaUxSTTJpVElpVk56b3NaZ3V5aGFSWjNRa2VTOFE3VTQyVUtIT1Aw?=
 =?utf-8?B?VGo4czFFODlGZy9NMjkwY0ZhNTJzRFVMbEI3TG5hK3pZTTJjaHhBczE1TUps?=
 =?utf-8?B?dWUvR3RwTEVVTk1ZQ043TDEwdFhtQ2wxekNQdFJFQldZVmtyQ2NZdDJvQk9v?=
 =?utf-8?B?SVd3ZU1GYytsVTlHSUFWNU4vTlJCTHJlZFpaZnhrMDREZXBZWFZxVlkrcERP?=
 =?utf-8?B?UHpNcEkydncrMEZEUVF5M3luWHJ6ZUZSZFZTc2k1Tk84RlVsVE5RRTBtMXNQ?=
 =?utf-8?B?WFpuNmh4Ulc4ekFWL1MvenhmWkVuOVJzL2R4Q3FZWUdVcldFUGdhOEhqSkNv?=
 =?utf-8?B?OUtoU0dXUTdzTmpDZGF3OE1jVm9UYTdQa0ZsS1dIUXVTZGkrRHZpb0dzMzUy?=
 =?utf-8?B?L0VwTXF6N3kyMERFVDBLeTRKNGduMHBrNkJiZ0lyV295OFlDQWtwM1cvNi9v?=
 =?utf-8?B?TkVsU3lsYXNwMVh3d1M0UGhUVkZtRzRVOW9qVW1KMGlmMG1nQTFYd0ZOZ0NS?=
 =?utf-8?B?ZFlKOGhScFFva0JCbW90UlB3Rzg5Y1BEb2lCbnllbmdROW9EZ2NndU1OK1Ji?=
 =?utf-8?B?bUpRdTZCbXZVOHRTdXY5b0dxbmY3N0w2L0UvR2VGSlRGS1ZsdE40WDNXVERm?=
 =?utf-8?B?ZS9zK3Y1Z0V4emo5ajR6dEYrY1RRME1Xa1pabWl0d1h2RDdWZ1NOUjdsWTVv?=
 =?utf-8?B?b0VEYTJMMlRoMFZpZS9CUlNyVXN3c09Wb083MkQ4QTBBUGlBM2Z5UHAwblpn?=
 =?utf-8?B?K3RJQjJOY2ZiamN1ZjNBSzUvMVliNWN2N015Y3ZuUnQrU25sNmJKSXFYVEFE?=
 =?utf-8?B?bWl1WEJHY1dYY2QwN3NxaFQwaGgvemJvNWdEMXk3a2VFZHlqNTZaclN6Ujcz?=
 =?utf-8?B?ZWpkNjNacHl0Q2JabVl5Rk5NeS9ZZ1k5ZlZEbDVLL1FXd3daK3dobGM1QXZM?=
 =?utf-8?B?Q0RWcnJ3dTBHTEtQZndGcU56bXpYWWF4dXUyL3M0VjVxUThyMi9VWXZuWFg0?=
 =?utf-8?B?VDlYZklidnhXQnFreWRpbFBGR2ZMc0llUHJPbnViVGVabFJqME01bUt1Q1N5?=
 =?utf-8?B?dURvV3FUTkVkREVhK1EwWFZrNUJkbmFzNlZYUHRiczlkSFM5V2xEMnNaeUlO?=
 =?utf-8?B?M2VKWldpVUJ2RFBlSGdnTEc1RzB6TnBiVTJoLzA3cWNucDY3ZHhTM2tCTmFC?=
 =?utf-8?B?WGc0M1ZQTGYyWFNiZ0NxSnhrc3NnVDJFbDdVZ3Z4MFhLYU01Vmd0RVlXeEhl?=
 =?utf-8?B?REh4Y0ZDYjU5dUlxZXhaQjFSOEhJV2xoeHB3dnVLUDlla0kxZnBRSDEzMWUz?=
 =?utf-8?B?SGpZRW1XUWR0bzFHbHE4TEpqVGQrbXhzaVRDSy8wMnk3Q08xZHBhUWxhVjRz?=
 =?utf-8?B?bEZtV2ZHdlpWdEs5NzVXSGRXZThuYTRYOHZCVnZiM1hpRHZlenJuUWJHdnoy?=
 =?utf-8?B?OS9mTDliMk8wOEVUeDFsUDRENzloZEZlSUJRVlVJcWtkRGVwOEorUS9Qbjlm?=
 =?utf-8?B?eFZrN29OZjF3ZEVLdzJrZTN6Ri9vYldZMXhIVU1QKy82TU5GcnUrclRZRVN6?=
 =?utf-8?B?UGU4V3ZkK1Jmekl5L09QbzhVY0ZhWnk4VGxNUDNIK213aC90MklhUTNIL0J2?=
 =?utf-8?B?MGtEN3pEdUMrRFQvcUZSdVVwYkVITUJtL3k0RnBaak5iR3RVSkNpNUR0ME02?=
 =?utf-8?B?VTZ5aUdubUhXS2RCS2RnREtqWDJjZVFhSTJxaVNQaFFyajJKZGNrL21JWFZT?=
 =?utf-8?B?am5zY0x5REZ3Q0NQOFJJVmlhaHVJVThaYnV5WXBpa1pkQ3c2aDlXeE1WYTNE?=
 =?utf-8?B?Sm5qL2RvQUcxN0NIczFWQkFtbldGUlpFdzloQ05xLzBOa1B3WVhUSkxMTEdJ?=
 =?utf-8?B?blBPK2FsK0RPMDZscFBURkthcmZ3azg4TEd3Skw2Q2ExK014blVyS2RxOTFP?=
 =?utf-8?B?K3FJM2NHeFdXR2NXYnp4bnpscEtKM2hiVHptUG1semlYdDRXQ1dWb2VPMG9H?=
 =?utf-8?Q?hKQWJeYahdKQFTTi4gpfxNfpl1RGJKQN77yF6R7jAooXT?=
x-ms-exchange-antispam-messagedata-1: lDzRD7BOAf60Zw==
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5dad0-6233-4c67-5eee-08df2c5faeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 15:02:37.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHbgBwRTb6OCHIrEItv1S2Nk97BgvhJD2GgaBPFzO4ScV7q9JHzGWyWOH2noIcwOSWMV7uBQPzXOYV7jvPWyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

DQoNCj4gT24gT2N0IDE1LCAyMDI2LCBhdCA1OjQ24oCvQU0sIFpxaWFuZyA8cWlhbmcuemhhbmdA
bGludXguZGV2PiB3cm90ZToNCj4gDQo+IO+7v1RoZSBSQ1UgVGFza3MgUnVkZSBncmFjZSBwZXJp
b2QgaXMgaW1wbGVtZW50ZWQgYnkgaW52b2tpbmcgdGhlDQo+IHNjaGVkdWxlX29uX2VhY2hfY3B1
KCkgd2l0aCBhbiBlbXB0eSB3b3JrIGZ1bmN0aW9uLCB3aGljaCBmb3JjZXMNCj4gYSBjb250ZXh0
IHN3aXRjaCBvbiBldmVyeSBvbmxpbmUgQ1BVIGFuZCBndWFyYW50ZWVzIHRoYXQgYWxsDQo+IHJ1
ZGUtdGFza3MgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zIGhhdmUgY29tcGxldGVkLiBIb3dl
dmVyLA0KPiBzY2hlZHVsZV9vbl9lYWNoX2NwdSgpIGNhbiBmYWlsICh2aWEgYWxsb2NfcGVyY3B1
KCkgcmV0dXJuaW5nDQo+IC1FTk9NRU0pIGFuZCByZXR1cm5zIGltbWVkaWF0ZWx5LCBpbiB3aGlj
aCBjYXNlIHRob3NlIGNvbnRleHQNCj4gc3dpdGNoZXMgbmV2ZXIgaGFwcGVuLCB0b28tc2hvcnQg
Z3JhY2UgcGVyaW9kIGhhcHBlbi4NCj4gDQo+IFRoaXMgY29tbWl0IHRoZXJlZm9yZSB3cmFwcyB0
aGUgc2NoZWR1bGVfb25fZWFjaF9jcHUoKSBjYWxsIGluDQo+IFdBUk5fT05DRSgpIHNvIHRoYXQg
dGhpcyBmYWlsdXJlIGlzIHJlcG9ydGVkIGFzIGEgIlRvby1zaG9ydA0KPiBncmFjZSBwZXJpb2Qi
IHdhcm5pbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQGxpbnV4
LmRldj4NCj4gLS0tDQo+IGtlcm5lbC9yY3UvdGFza3MuaCB8IDMgKystDQo+IDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvcmN1L3Rhc2tzLmggYi9rZXJuZWwvcmN1L3Rhc2tzLmgNCj4gaW5kZXggZmNhYzczNjFl
YzUxLi45MWMyNTcxNzQwMmUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdGFza3MuaA0KPiAr
KysgYi9rZXJuZWwvcmN1L3Rhc2tzLmgNCj4gQEAgLTEzNjEsNyArMTM2MSw4IEBAIHN0YXRpYyB2
b2lkIHJjdV90YXNrc19iZV9ydWRlKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gc3RhdGlj
IHZvaWQgcmN1X3Rhc2tzX3J1ZGVfd2FpdF9ncChzdHJ1Y3QgcmN1X3Rhc2tzICpydHApDQo+IHsN
Cj4gICAgcnRwLT5uX2lwaXMgKz0gY3B1bWFza193ZWlnaHQoY3B1X29ubGluZV9tYXNrKTsNCj4g
LSAgICBzY2hlZHVsZV9vbl9lYWNoX2NwdShyY3VfdGFza3NfYmVfcnVkZSk7DQo+ICsgICAgV0FS
Tl9PTkNFKHNjaGVkdWxlX29uX2VhY2hfY3B1KHJjdV90YXNrc19iZV9ydWRlKSwNCj4gKyAgICAg
ICAgICAiJXM6IFRvby1zaG9ydCBncmFjZSBwZXJpb2QsIE9PTSBpcyBub3cgZXhwZWN0ZWQgYmVo
YXZpb3IhISFcbiIsIHJ0cC0+bmFtZSk7DQoNCklzIHRoYXQgdGhlIGJlc3QgZXJyb3IgbWVzc2Fn
ZT8gT09NIGlzIGV4cGVjdGVkIHdoZW4gZ3JhY2UgcGVyaW9kcyBkbyBub3QgY29uY2x1ZGUuDQoN
ClRoYW5rcy4NCg0KPiB9DQo+IA0KPiBzdGF0aWMgdm9pZCBjYWxsX3JjdV90YXNrc19ydWRlKHN0
cnVjdCByY3VfaGVhZCAqcmhwLCByY3VfY2FsbGJhY2tfdCBmdW5jKTsNCj4gLS0NCj4gMi4xNy4x
DQo+IA0K

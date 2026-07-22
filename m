Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1574457AA;
	Wed, 22 Jul 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745494; cv=fail; b=Q7/AnXqdq7QgtR63EUL/dIXeBOQCgHcrTdpkeXLswenShXUTj17QGnrwCVDSkKRfDqIlFDOb8c2GeORQ9AiggzYiCX8XcCqknH4A6sIvMOx4lbMbvzia0ASRATBIsIDsvMcxhOyIuiWr19QEm3f4IcNDgRM9Drh2X457TvyTNCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745494; c=relaxed/simple;
	bh=HJOOrW7ekbMnnArtVLs7wyDnqLUMStIdXGMljZ5XUM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rk08mMy6AlBZttlLty/tW3ol3nHwtj+cOdGZiES6+YVgbPHuCA3E3KCf6uoKuPH0JYof4rsLC2u89zE9Mu5Ipfb8PHw6CZjKGcMAKGhn0BoSaPG39TJKQTh9U42d9nhQVVRfeIK/pZSaSwEqSFn/f/LsgomcxZwgG6qAZOk6AOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HpQTMpkw; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HpQTMpkw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZvQpW2lQwaQIJydQ/yx1i9C0i+u7N0usCNnnPmV4E4toDxAc5iVF340Ghq0sJHPYrzoF2nfkQxnxYOWNPzwLKr5GE7tPhPqCVW9jI8zaIwjn2Ga6J6iG+B9gT7g7YALxxHeMqXvkkROnnzqrHQbjDWq/kEmanXc6ituAUTsB77KmFXovH626OVxK3GvQz/h7Ol34dFYrUykQjnho7OUYDxT5Ftwc6KeS7DR+b/Krj7fXPtq+jj9UQjZ0qwcZKya5KJYmVqDV6znU3+vIouELKqI/1pYE9waOF1ycmBucFC512myJjGEZrrJPNDB6bGOast7FmbV3NsjEj7qYPi3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJOOrW7ekbMnnArtVLs7wyDnqLUMStIdXGMljZ5XUM0=;
 b=dTAHaSqvH5IdQ3PcYU0ER4v4ueg9b9nv1S/MHXhDmu1UnA7Y6LtLCGoVanLw6I7JdHBB+aR3UfEQ+GVdoxlx8qfU5OM+YFERaQiy+q4gjuzJDdZDbA4dTr2ccALJQKGjbjmRAMzHbsX0kNQa0zk/RLo8yhHTDU8gDrA0StAweP5fW5MJm86Fez6K4Bjm5U1uCfntZcVX3p0Tvtsts5ZFFRCPEjQx+FoFz4KPuPyTBa5HatWwvUXH029OPF2au6KsdYucZ+KQTstCrvzogrwSnOHDJ4DeZSh7lGXGcdlq4fHufJOMGXp3B+OxA5VylhuGAc/DuDM4mOXAyitdgwVXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJOOrW7ekbMnnArtVLs7wyDnqLUMStIdXGMljZ5XUM0=;
 b=HpQTMpkwHh36L/orRc2zdNYxCxJiZZqxXosfJjuNatDN1HOip+sUXOjGvYSXBwhTZC5IJsRyZkjMak9aAT5mTcBq14aUwAKySUQjhfgx6gqol+hn1pKLPXPkm5vmixRIWZPNkMUYnWK+p6e1QfopXdqYb9FfZImEgTTicm5Hv7Gak/ou3/QkN1VOEv5FLwu8fQ/cm8nC7LnsrdINQZWdT/JM7ktrZOWWcyeB2Du9TIVyGgNHxzRj3U36a8JJyUYRacmZ8v0YBPIQ22iXk0YeMQcCNY+ZYr6V0fP5lHtTnWQgWiFVbtJflwcmFV9eTLlYLojsm6kpYby6T6L2HjrKuA==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 18:38:05 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 18:38:04 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	"delcastillodelarosadaniel@gmail.com" <delcastillodelarosadaniel@gmail.com>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, Alexandre Courbot
	<acourbot@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
	"adzicmirko97@gmail.com" <adzicmirko97@gmail.com>, "alistair.francis@wdc.com"
	<alistair.francis@wdc.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"frederic@kernel.org" <frederic@kernel.org>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "daniel.almeida@collabora.com"
	<daniel.almeida@collabora.com>, "boqun@kernel.org" <boqun@kernel.org>,
	"lossin@kernel.org" <lossin@kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"phasta@kernel.org" <phasta@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"tamird@kernel.org" <tamird@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lyude@redhat.com" <lyude@redhat.com>,
	"lina+kernel@asahilina.net" <lina+kernel@asahilina.net>, "ljs@kernel.org"
	<ljs@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "work@onurozkan.dev" <work@onurozkan.dev>,
	"urezki@gmail.com" <urezki@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"fujita.tomonori@gmail.com" <fujita.tomonori@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
Thread-Topic: [PATCH v6 2/6] rust: error: Add ECANCELED error code
Thread-Index: AQHdGesESzt36KBa/EixWW27QHW3A7Z53p+A
Date: Wed, 22 Jul 2026 18:38:04 +0000
Message-ID: <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
References: <20260722144931.1070312-2-phasta@kernel.org>
	 <20260722144931.1070312-4-phasta@kernel.org>
In-Reply-To: <20260722144931.1070312-4-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|DS5PPF5C5D42165:EE_
x-ms-office365-filtering-correlation-id: 6b0f82e3-082e-4af8-b7a3-08dee8205e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|921020|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6pFAfNPXDExAv5OUJnsAclJTMtVhHH8hFTmjfQB+Ky7Tn5rdpYwugAbyzNq/U2QGoaqNpUZd9vP+yMbFLGQcNQciZhFHIdBlSIEnMB1OmeaY5KAT3yO6RWDGxbuIlOwMZ2dsGITQNsp/uhjab8iz8Ipbca6n6Offnm2OXkTovxYzgQ+dTqj5tKRR72suvL1OejWhAcf6oV4fiaDl/99WWk4KwA1ekJvSEHIrfFhdJMWo4hMzJ9kl3J8Hrd1o/UYi3Z+REOfdEmzbEdCWj7jys0GekP8Q+mcUAZ0DQO5Qp4HoFFFuOXx1expMDtOIxssD+VZ9/OttqRw1wAuvDxOFsnSgHsipUf0DRBPSFMLcTP32wdDyzp/AFjRhc2teG92fcrldBrL5KhW+PC4ZyBLBvOBoajTnoUMQRhuRoI6zcIsON8ysWNo9ZN4yKg4yKycLFUuq6wAXr9hxu/yFijbu7j3AlHUWRlef2v0/vH9iYXj4bDICIvILECvsim4ZAZVLKP0Fy89tRGTgIb3KUypo8lzzdAMYaBWQUN7vB7MoIw9B42RTt9NNFFRz7GufAZIZsb9aanH1FBztD2kUrwfmF/TB4oS4kAbOUQ06uifDxDiuyJLJM/j8YTKSE56znCN53ZftEjZY5VeX28Ok0molBEuwhyYbX9wGoHnN+U4wY9FAhl1E9QIua5mEw6VJul/KQru6/fKHyRPDN1BaiHM+kXxVznXbxlgPh+HYECXC/KAJFH06Bk5OK/AEnUqeMLQQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clhRc21ZcFEwRGh6M2ZlWWxzNzUzN2NoQ3Q1MElHU0JsZTNvcHlYemFuUUda?=
 =?utf-8?B?YnJJbHBCZUEyTXhHbmpyNFNzL2w0WmxOL0F1cDdCanB2aWkyTXJlUnliVkZU?=
 =?utf-8?B?eFFTc2lRNHREWjk0c1lqbEZUbnlvQ0tBQld2bk14NGVUSlhNclhpV0RuaXA5?=
 =?utf-8?B?d0hZUUJIUWhCMi9RZFk3d0ZhWTJNUEJPcHlYMVF2ME1uc2tBaWExYlNnODNX?=
 =?utf-8?B?clBzQUhPbmFRVWZnQklzRDIxTUduZCtPNEZZMzJSTWJlUUE2RlpTSjJEb3dm?=
 =?utf-8?B?QnZSMFBoRFhCRGJPZXQxL1dJM1Y2djdUNHNsUnpNWVlxbG5xUVJYWTEya2h2?=
 =?utf-8?B?OVYwdSsvSzloUjRjM2tKQlZUNk9CYWU2K3B4Qk9taDUvYUhwVFR6SlkySGF3?=
 =?utf-8?B?bUpFUUxqM3dIcWIxYXNlR0lNZXE5SHZxanpiRnZWV3FLYStXUnZGQ1gvTitT?=
 =?utf-8?B?V09FNkhiNEM4RnJnK0hRazFXWGYzTEE3Y2tJNTdlZjlKYWhyZUVwL0NyWENm?=
 =?utf-8?B?aGpubXU3Wk01ZDlmVnROSFRTcm40WG4wVXV4cE1TaEM5bENTSlF5dCt3dTQy?=
 =?utf-8?B?SWtUeXliTk9XQWhwLytnclBuZllnT3RFKzZQYW9SUk9XNzlscHQ1bjJFR2d6?=
 =?utf-8?B?VjI4cjJWeTRZR1IrYldCcXpaMEJ1cW5KRUg4eUt0OHdyZGoxbWVnTExnbHdK?=
 =?utf-8?B?SlVmUHIxeEhTdTdXQVhSdDhGb1lHWEl1ZW5vYTlFL2M0RTIwQ3BSTDlEZHpY?=
 =?utf-8?B?dHUxNHRicm1YbkVBWHRXcTQxc2F2OEljOEtoOStNcWFqcGg4Y3p6SHU2OE55?=
 =?utf-8?B?VkV1bGxUanN4cGdkMlJpM2Z4TVhoK2pVMXZPVGhXWndTaklkRWthTmdmRzVF?=
 =?utf-8?B?b2hUbUVCY1B5SE83QVVsUzh5TnNJQU45SkExbGFSZkhGc094SDc2OXNad2NT?=
 =?utf-8?B?VDY5WjgzM1Z6VXNOcGdHZlVhS1UvaFJPNnBveUNmaHFjalFSeTcwcjdGMkMw?=
 =?utf-8?B?QU91NFJaSEVJd3NwejBqT0d5Y2Jod0RLalR6RWhlVlJxOWZ5eGNER0F3dmU4?=
 =?utf-8?B?eFo5R0k5LzFRSEF5LzlmTnJsNE9kMlRQVng0K2xaVi9idEo0MWVrbzdTQ1Jo?=
 =?utf-8?B?YlFia21VS3ErclltQ2kyUkg3WURRNENMM0oxYjhKMENYeFNjUjhEUnQralpO?=
 =?utf-8?B?cjdJTkliZmZrQWl5OTB4OGlHMTJJMitFSFIwSktpeE02TUNzUHRrT043VDJF?=
 =?utf-8?B?TExXMVhNSkVaVlBGcm5sbXBzZmtBSnVhYVdJVzh5UmFsZkNEcXZVRmZneHUy?=
 =?utf-8?B?dVJZMjM1TG1iSFYzU09GRk1qWkovNmRBZDNuK3BEaHliMTNIeVRESmk1bFdC?=
 =?utf-8?B?UWxSRmVYOG15T0hVVXhML1NxKzB5a0tLbkxEWUVIb2hLNnFtQTNSdVNldVVG?=
 =?utf-8?B?clpjL3VYRlNkemp1a0l0MXpzYWNqMXV2S3NrZDdFdzUyb2MzRmRLRjJjeEs4?=
 =?utf-8?B?ajY0d2dUNEJyUzhZWWVUL2o0MS9VM1h0OFIzcDgyOXM0eVVybjJyNlJHMHd4?=
 =?utf-8?B?OE1sd1o5ZTRJN2FWZnRpcFhiL3R5bjY5VjNua0VzWGt0bWd5STdnS2RYcXJT?=
 =?utf-8?B?MGQvem9kd1N1RWlWZ3pXZUdyRCtFQlhHRkMrMjh1ZkRPUU42ZGdlbXFzRnQ4?=
 =?utf-8?B?emsrZUFKb2tpMCs4Z2UzUWRBOHpuYStmL1lyYzQ1a3VLQU80dE96QzRENStR?=
 =?utf-8?B?ek5vVUNvcWVXTDMyNVNuOVd0UzhQc1N4SC9LMzZaYjRoZnE4YWtrWThZMGpI?=
 =?utf-8?B?QzhpVDgzaVg3U0FlMnhNVjZKSDJ3QzhMOGV3c3g0WFg4U0J0bW9QTDd3b3dX?=
 =?utf-8?B?cy9TZjMxNVQwckYwSmkreXhrUmhvbjgyMW9jRFdoODJCbk1tV1ZZRkFCYTVE?=
 =?utf-8?B?eUlGdVFtUjZySUNvUHdqUm5RVXEwcjc0OWhUWFlaUWM0N1gwVHZDRzNMODdH?=
 =?utf-8?B?aGRwYy81ajROYStMZ1RZejBJejJCRVdJVU9uRkpFRHVvWTkvTmkvRFV1Z09U?=
 =?utf-8?B?OUNmemdiWGNuRGF0bWVWKzRKa3ZuM05RcFgzd0ROT3hjcUpiaTFNdVFQY1F2?=
 =?utf-8?B?NCtMZGxuZHZ2dFZ6NmhBRDZtc2dSbWlIT3NDS3UwOVA2YTRLZy9EOVBxai9u?=
 =?utf-8?B?a0xtMDZPY1RpRmVGR296ZnI2SGQ1cDdQUVFhbVBKaEhjL1ZLODRTam8vejcz?=
 =?utf-8?B?WFBRSGI2NUlrWi9uMCtJNEZWaTZmVC9ZOUc3T2prR3Q3QzZHU2t3UzBkejRR?=
 =?utf-8?B?bXMzTCtwUVFoN0tBczViZytxbWE3ZTdQLzFxdm5URHZsSHIyeStWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E72ADE0257D07E438C1BFB4ACF576C6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0f82e3-082e-4af8-b7a3-08dee8205e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 18:38:04.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt78FC67L8IDh/L3n6Jm3yswjNjw/iaxBqUF2LH4WZkN3cN5kKzjdJtTt+M0XvEUl+svwaqrOJ3qvVvWwMcZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDE2OjQ5ICswMjAwLCBQaGlsaXBwIFN0YW5uZXIgd3JvdGU6
DQo+IFRoZSBSdXN0IGRtYV9mZW5jZSBhYnN0cmFjdGlvbnMgbmVlZCB0aGUgRUNBTkNFTEVEIGVy
cm9yIGNvZGUuDQo+IA0KPiBBZGQgRUNBTkNFTEVEIGVycm9yIGNvZGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwIFN0YW5uZXIgPHBoYXN0YUBrZXJuZWwub3JnPg0KPiBUZXN0ZWQtYnk6
IERhbmllbCBBbG1laWRhIDxkYW5pZWwuYWxtZWlkYUBjb2xsYWJvcmEuY29tPg0KDQpObyBuZWVk
IGZvciB0aGlzLCBhbGwgcmVtYWluaW5nIGNvZGVzIGFyZSBiZWluZyBhZGRlZCB2aWENCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvMjAyNjA2MjkxODMwMjIuMjcwOTUy
NC0xLXR0YWJpQG52aWRpYS5jb20vDQoNClBsZWFzZSBwaWNrIHVwIHRoYXQgcGF0Y2ggaW5zdGVh
ZC4NCg==

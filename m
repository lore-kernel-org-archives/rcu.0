Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44793E9F9D;
	Wed,  7 Oct 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370057; cv=fail; b=cF12YhX02/S8mACyFjsNdKW3Xgpbi7aCGk8+4Ajrot91VWt+9z9oqF2MtGbjQnYnHjRVxiiNllVgTxFYk2X0NvPhl5WeaQzehUvw/BEERlBl1ixGBCyOoZXXemvCbvvyVn4fYc6cdQnBcoowFmky1zS8mlPyRzyX3nVmPMZeQxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370057; c=relaxed/simple;
	bh=bmjqir9y6SSCLbAPjr8C2DTH6mbQDQuN4ryA8zNaMLk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CaqTT51IRzdHljylyxvUj+x6+0At+0TxbOEq8tlHcwLIUamDeTY+67LxjV2QV3h6/OWPc01zhYbCY7OrWNGXzGVXYtCNGKJr5ljoX2X8eVjoDwr8sQ+rBITME+T24GHd7/jD1QsAQLRs+I7mlXcPFUUdcHtszLk7GoZOi22++mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9w+rDHe; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9w+rDHe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO32GCbOztFKqtWcC50ppuc65aFpROOALmNQUfw6FSN71v8Lz9PlvLyOyRv1Bw2zhWKhbkWnK8GjwWZjJ6P6brbrMVfuR9ArFQUknWn0jbGi7+P232afioiTPXymtx83tmhXP1SPCMpDsDaimR+3fW3Ue3gK09BQ9lU4hVSOixURyjYClznAV+8zwl4AUO4KH7AaGOWUHJ5xHr0VQ/IjrNGaFckILf7SjUg2m3mkqo6/EbJD2MMKqVd/bks0RMbiWZ2cj6mcCSpApQdpr6fNHz73sk5I4CmHIfGxnlYoC1l1334R+Z+4z3FduYE+H2p3tMnZIDeD+riFmFPNM6/tkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmjqir9y6SSCLbAPjr8C2DTH6mbQDQuN4ryA8zNaMLk=;
 b=K+VNjnFWWQBJ0LwXgzCnfCpe0BwBRWUjtCCneXZevAEzt4JDYgBcNmdHwlY2Iruvnxbd7doSE4uMQg9Jp57SoU7W5xbU3OWezxZaUU0/rRZb7u2wuVM8nIBBxJDEa6gSV9Jdp5gAPgzg5pPHKDX/tC6IvpRiYesN7d62ZZHEuHkbl7seJBR1Jq+Y4VD2PKwKOc1/LV1icEsSEB/ikXlgZvffzIgxiuuk8l4j39cu0xyDaqjE2qWXHmxsPmbcBdBna3mp7o0k7YzcE7BGM5GJFyqUKRrs7t3cTNTZD2dzFCi5ViL3GjAltwcFY7VcZK8CIE5CB7ZjX+ul6r9N2Ytprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmjqir9y6SSCLbAPjr8C2DTH6mbQDQuN4ryA8zNaMLk=;
 b=Y9w+rDHeihQmIrUlUXgeTQBBNnYNovzm/aUlx12aUkIICjXvkFQRG/QtLaKZwmenh/k+k/g8FzVPn9fjJnKtErXvtYsqArVH/AR7zEjFmDZsaGFA8IbTuOfMmMdwyxMKoUaMD/h2pLPpjUlWPrzdDszjpXnHhDQrYtyGzPf3J96rN0b+1Sp4lC4HrJlDvyrZsepiwMptLaqV+nv+nm5LXlaorufKVOw7Iv4gjkv43XF7sOXDGGl9EirmyeDkwiKAyL1iNs8FTSK2kGZu9RxTAfhU9rUdm5RXM+gCBcuoyq6IQdS53Ss4Ej4mXS5Oco68AYdlRc3+/ypN4azwHJBVbg==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 10:46:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 10:46:26 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Cunlong Li <shenxiaogll@gmail.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
Thread-Topic: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
Thread-Index: AQHdVkkZNkYxZoh7Zkyyv/cweWtQYw==
Date: Wed, 7 Oct 2026 10:46:25 +0000
Message-ID: <D61AEE6A-A21F-4D7D-8A7F-0672B8BB75BD@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|BY5PR12MB4146:EE_
x-ms-office365-filtering-correlation-id: 2d7f508d-4b73-43aa-57f7-08df24603c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|56012099006|11063799006|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 1vS+bBgT+eca26ERJb7e76DAWJXHcuEpAWNGdJjigNuaIiHRbXLKSpthCe+Xt/28aHHMD6od/TmJYsbULCLnASvU5GzppWt1DVNPM80EZo6f7V7dReKzDleacHjaJXODwWLQcNiJ229gTK4fUXi78CEGavLUHLVfn162nT4vdTqy7B7WgJruuWIcHfC7sPra/Oifj3Sp+r1Tera6pBxS0mDMI+7DKO6ZMsVd+hePYeUfABojt5uYntDOHjYpAcxN3Ue52mWa19qZSTvL/vDLNc3RHB00YnY4hRj7u5UkReAELCtP04STfcdPmEgOks0MmRSThAadfHhLFe1qIiz9h3MbNDr0znj3X4ARKqZmKIifplMPdVG9MjTiJ4PsEY/gqCSktsB7S9WUlItONefNR8f9C7Bt2PfQMHzaxP1kJnrllNRmt9MwLmIRRT3ypz5d8hoCuwz1faA+eW/EVASKMcAeD04VJrbb/cVK+obxLatP5c+W82rh/UYbk+8M4jswPqR3BGM4cP9YKQ/QOb5dxM7pMKcbe9ScpnH++2PCTwwUY4Rl61D0k4JA8WPdJNuf6mo5a4f5WsDJAqwDw5akAVpkM3HY85qAIeUQ0tVT4bK2wfpuIVskvdn1pEivRwqHpew0xdDzG2A0ssHHjEmxdUO51cvMyZGuHpKwtK6XwSeVj4r43qfPw2jAil3r+C+K7bXX4mXOt0GbcRIlojTGyw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzJMWGdSbWpQV1oyVjZ3dHMyZDU1T1ZFekNNUGM2eC9TU2I0S005eStqVHFZ?=
 =?utf-8?B?cmY5N2c5RFVLV3VUWHFOdnJrK3k3TXhUbW1ldVAyZEUwdHB4TGQrYkVQS0s5?=
 =?utf-8?B?MFNqVkJGVWtIS2ZaSWdtNjIyV3R1ZnFPUkdhc0xVaE1GYWFIZTFlbUNRTjl4?=
 =?utf-8?B?NDl4OG42aEZVeDZIZ3hqWVRsTmpoQVRyL3dBUDVKVXNuSDJzZS9DWHg5bVVL?=
 =?utf-8?B?aDNibzNNcElRdEowc1NDQ3B4SmhjSmorNFJ4aCs1K0lyUENVRkRiOUNUeGFC?=
 =?utf-8?B?dWd0Wi9DNWE4OWNnSUNvWnhSOEFhMmxZQ0lCKzM2RUgxZFAvS0hrUDRMS2tU?=
 =?utf-8?B?OVlrYmNkK3d2OFBOOW52MmZpZlhodWppYVJKdktVVWlyN0JpTzBMOTVmZGda?=
 =?utf-8?B?VDNOaW5Oenl4cWxvT2N6RUdEdjdudE5pQStWbmhneGt2TEtzUlR3QU1CN2dj?=
 =?utf-8?B?T2Z5MmV1ejdlMDZMeGxkN1Y0Um1JQUtvQzIxL1pHR0I5c0toSVdZclBxOURC?=
 =?utf-8?B?N1NDQ2xLaVRjZE1YN0tHNXRqV1pEWlV1ZGxQR2hPamJYWmVqd3FKZmxrNURj?=
 =?utf-8?B?Y3FRUEQ4R21mMGFJWGc1U3dMdVRtc0NNS1ErRnVHdStNYlBmWVJDSXdtdGZ6?=
 =?utf-8?B?L05kTzRtL2cvQkV0ZnZTTTFnN3N4dUhFMUV0K2NZejE2TDQ1NDFwbHp5bWZW?=
 =?utf-8?B?MUo2b0loUWJmZDdoTnZpMElSMjNrQ3E4NnFBU1NDWDZyZTZKVUhuUk9QRURP?=
 =?utf-8?B?NnRpNlU3NXZIVG9WVXlyanpmWEhsdGd0Zm1KeENnU2h2RmpqV3Fvc2FPa0ZR?=
 =?utf-8?B?cXhRejlEOUpSeUNtUkdTTG4vdkFiUnpyR09FeldsZHVKWGw0NXBCZmVtSThv?=
 =?utf-8?B?REd4S1JleDFOS2JzZTQydi9RbHc4Mkx3UU1ZUnpGWnZpNWtvRm1qb2Z6a3ps?=
 =?utf-8?B?VUlKM21Xbm5HNjg3M2JJUDR2M09Kd1pPWUxGNGdxd3pha05ndFpmZ1hFNDk1?=
 =?utf-8?B?UWJ3TERXQmZYY09PNnFjZGR1bGpTRFRubWZERDZnVXNkbEQvT2tLZXRuYnAr?=
 =?utf-8?B?ekpWYlhMQXFVd2tiWGoyQ205b3Erbk1lWkc5aE5FT09yOHVxb2xHUXd4Znl0?=
 =?utf-8?B?WHQyalQzSTJwbExwZnJTK1pDYWU1SDdsSDB6ZDVRdXB3elV0TFRkZ204ZFFx?=
 =?utf-8?B?WE9Ka0VJRi9HNG9KMDlId3R1UGVJVi9mQVdDMHBNSzVxVmxJNEt1ZHBXTjlW?=
 =?utf-8?B?ampSc3pHaG1zMEp2Z1N3Rnc0RUZiYlJqRDQwTGpLbFFvandKU0Zac1V3RW1S?=
 =?utf-8?B?VzM3Zld1M3VzQUVhbjdQY3k0eHBGU2x3S2FBT1d6TW5sSFN4dFl1R1JPeTRM?=
 =?utf-8?B?ZVdiUU5wV0I0d2VoUlpRYjFEam4wamxWcWMxdXJrRXF5UDdEaUVjZW1uNVJO?=
 =?utf-8?B?MUdNOUx1SXljRW5xbkgxMENrb0xqa1F6SXNyRGFMMTdVQitOTXRHRWF2MFhq?=
 =?utf-8?B?YXowYTRpQzBoWGthTTFieXFRQzhCcjdHQkEvNHk0REJHbC9GcjlkTEI4OUdI?=
 =?utf-8?B?MW5QRHBoam8vQ1RYVmN6elROM1FxMnI0ZTF3Z3pYeVU4OFU0eWxReW9MWU5X?=
 =?utf-8?B?UFZ5akh0MFNvaS84WFFuMHZyYVJMQ2RqMmtwMVljU0lyVWk1T2hxYTA1L2Zr?=
 =?utf-8?B?WVNGRms2R1FSYWQ2bEZlcWw0WW1UcnZwUWhrTm1lcDQxRDJNUU9JZGowcTBR?=
 =?utf-8?B?VnFyaEFrSWkyZzBFdFFjdFo4UHlDSmJpU1JJK2F1OXBYbENYdkdDL2QzOC9W?=
 =?utf-8?B?WHJTZHI5ZnFVQUVCV250aGIydndWVkJPbi94SUp0eHZFcGhEb0h3RmhURVE0?=
 =?utf-8?B?QkpKblZFeGtpS2FYTGZGWThPbWVaaVhOYmJwZWZDUWpQNjRabHovd25zVUUv?=
 =?utf-8?B?OWthYjFTRTkwVW9VQzd0YXYySjBjNzdTaDdPTE9xRFljeEtKWE5Qa3NmSm9F?=
 =?utf-8?B?WThJVUVONWpGK0hyRTJ5WDFaRkM3SGJXY0Q1alRYOGZvZlBSOTIxWktoSVVG?=
 =?utf-8?B?blZXaTFyeENORDN0MjdtaWtuMTlLK25vMnZQOFh3TnFTdmJ2RjlSN1RLaHRx?=
 =?utf-8?B?TnkrMkpBSjI1bW1WV0poalJXRVRFOElOUU80ZFdNWXdxVnJJQ2NLdXBYTG9v?=
 =?utf-8?B?cFVZQlh6eTNtakp0UTd1OTg1Q2tQRDRqelBQUnZRdjV2UWJwUmVoMWRZWU1p?=
 =?utf-8?B?eFB5cnBoY3dIanpFbjN1NGRVUE1zWFA1TXlERnF1eGcrQmFtU2h0MjYvRVBk?=
 =?utf-8?B?dFZ2RGRZdTlPckxFaHZTVmZ5N2Z2MlhtMTRtZjFqSk9Ca2lZTSs1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F43808D767DFC54888F4B6B799B40DFA@NVIDIA.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f508d-4b73-43aa-57f7-08df24603c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 10:46:25.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2UPJWea3hkg0M2wL4a6U3QVsJnymKLhwvWZL8zGIebEw6iCjzZhV8HE5zCtVcWob96hAIYIW7dBUlEFzLyCtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

DQoNCj4gT24gT2N0IDYsIDIwMjYsIGF0IDEwOjU24oCvUE0sIEN1bmxvbmcgTGkgPHNoZW54aWFv
Z2xsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUdWUsIE9jdCAwNiwgMjAyNiBhdCAw
NToyNzo1MVBNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+PiBPbiAx
MC82LzIwMjYgOToxNyBBTSwgQ3VubG9uZyBMaSB3cm90ZToNCj4+Pj4gSXQgc291bmRzIGxpa2Ug
eW91IGRvIGtub3cgdGhhdCBpdCBpcyBsaWtlbHkgdHJhbnNpZW50IC0gYnV0IGJhc2VkIG9uIHRo
aXMgZGVzY3JpcHRpb24gYW5kIHRoZSBiZWxvdywgaXQgc291bmRzIGxpa2UgeW91IGhhdmUgbm90
IHlldCBmb3VuZCBhIHVzZSBvZiB0aGlzIHBhdGNoLg0KPj4+PiANCj4+Pj4gDQo+Pj4gVG8gYmUg
cHJlY2lzZSwgd2Ugd29ycnkgdGhhdCBzb21lIG9mIHRoZSBzdGFsbHMgd2VyZSB0cmFuc2llbnQs
IHNvIGENCj4+PiBwYW5pYyByZWJvb3Qgd291bGQgYWZmZWN0IHRoZSB1c2Vycy4gIEJ1dCB3ZSBo
YXZlIG5vIGhhcmQgZXZpZGVuY2UNCj4+PiBlaXRoZXIgd2F5OiBldmVyeSBpbmNpZGVudCBlbmRl
ZCBpbiBhIGZvcmNlZCByZXNldCwgYW5kIHRoZSBkbWVzZyB3YXMNCj4+PiBsb3N0LiAgR29pbmcg
Zm9yd2FyZCwgd2UgcGxhbiB0byBlbmFibGUgdGhlIE5NSSBhbmQga2R1bXAgdG8ga2VlcA0KPj4+
IGludmVzdGlnYXRpbmcgdGhlIGNhdXNlIG9mIHRoZSBSQ1Ugc3RhbGxzLiBXZSB3aWxsIGFsc28g
bW9uaXRvciBkbWVzZw0KPj4+IHRvIGNvbmZpcm0gd2hldGhlciB0cmFuc2llbnQgUkNVIHN0YWxs
cyBhY3R1YWxseSBvY2N1ci4NCj4+IA0KPj4gDQo+PiBSaWdodCwgSSBqdXN0IHdvcnJ5IHRoYXQg
aWYgeW91J3JlIG5vdCBzZWVpbmcgcmVjb3ZlcmFibGUvdHJhbnNpZW50IHN0YWxscyBhbmQNCj4+
IHlvdSBzdGFydCB1c2luZyB0aGlzIHBhdGNoLCB0aGVuIHlvdSBtaWdodCBiZSBjYXVzaW5nIHNp
ZGUtZWZmZWN0cyB0aGF0IGRvbid0DQo+PiByZWFsbHkgaGVscCB5b3VyIHByb2JsZW0gYW5kIG1p
Z2h0IGJlIG1hc2tpbmcgdGhlIHJlYWwgaXNzdWUuIEl0IHdvdWxkIGJlIGdvb2QNCj4+IHRvIGRl
YnVnIHRoaXMgZnVydGhlciwgYW5kIGZpeCB0aGUgcmlnaHQgd2F5IElNTy4NCj4+IA0KPj4gSWYg
eW91IHNob3cgdGhhdCB0aGlzIHBhdGNoIGluZGVlZCBoZWxwcyB5b3VyIHByb2JsZW0sIHdlIGNh
biBjb25zaWRlciBpdCBmb3INCj4+IDcuNSwgYnV0IHRoZXJlJ3MgbGl0dGxlIGJpdCBvZiB0aW1l
LiA6LSkNCj4gDQo+IEhpIEpvZWwsDQo+IA0KPiBVbmRlcnN0b29kLCB0aGFua3MuICBXZSB3aWxs
IGtlZXAgbW9uaXRvcmluZyBkbWVzZyBmb3IgdGhlIHJvb3QgY2F1c2UuDQo+IE9uY2Ugd2Ugb2Jz
ZXJ2ZSBzZWxmLXJlY292ZXJpbmcgUkNVIHN0YWxscywgd2Ugd2lsbCByZXN1Ym1pdCB0aGUgcGF0
Y2gNCj4gd2l0aCB0aGUgZXZpZGVuY2UuDQoNClRoYW5rIHlvdSEhIQ0KDQpKb2VsDQoNCj4gDQo+
IFRoYW5rcywNCj4gQ3VubG9uZw0KPiANCj4+IA0KPj4gVGhhbmtzLA0KPj4gDQo+PiBKb2VsIEZl
cm5hbmRlcw0KPj4gDQo+PiANCg==

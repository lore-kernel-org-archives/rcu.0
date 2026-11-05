Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793904772;
	b=OeITB8Az7WPWeB/d2UmvzH1iRNGrkOjajVE2PLmRnbC7Xyawf6k8/FmGhsxMFg2/bWW8
	 lcECj6eHBvRz7Mce2XnxV47iPC4pQ34/EfOMgwR31e10cw4756Pyg+JIcj83QZUE9Rh1D
	 6tpStdSea9M0p3P7yL+ya9djnKldDWvvajdamsW5FCnBpYt/3e64NNYVi+S+0L+Qk/JsV
	 Mk5CExnXT6pIKdzh+KNQa3XnuWQg2gitwDrAU0BB+XLQleex7E89ME1z65+iOdWysn+vG
	 vOz3WG4cuYR5tE76+wYs5y15aATvhnLGqPzL4m5CouiyxsljlDlZnRtYXvKVWGGkPoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904772;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CF0aJjfy/SZBrHQvcz9S3og6DxDNPigE/t6UajttKao=;
	b=MZ9+6f6hHoTX5/6HdWE6Seyx8HYmRbTaUKo6fmfCzvyl7+s7o9Ka/NP4il4a/usrChX+
	 Z21Qucp/JqQf5O/MrIrSS0O6OrmX53xxsNaMOUczQdVDn1GpQrqReVb0xZMn+ENp18DQU
	 E1qdu23ReW51YI7a/3LbohjoiTWEqsm3r/WvdIHXTY70v+GIBRB9B1R27PEkGDwmzvMpv
	 IW8nhDHJXfWZR1iqRb/olMU3y8VMRwhXguFmauZumkZ1IRjrKRhHWxkqtfvGv5hgH7JRm
	 v+ndif0P2fRTHDIRocJPOzt86hrIX5CcCRSmswLEW9OZBcgxvbE17LyrKzxbq3wY89w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HsAseuN2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.60
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC606A328
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 18:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DCC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HsAseuN2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTumVnfklzTI3Y4O5H7VcQfgiaudyjIErHNO1Qdtp82a034XLkDzzbNN3zkr8008hEAfqdFZe9ScEVrXVvugPkvJDHUXe1PCthfkafbDQv5tg0tYEJvz/kaXJ+vXoAu2M11Ylss5kpZLU2k5gjwv7fWUV97aG5qj2tUZFQY7b0EI/gi8tzOTDJjBcFaeFQMSja0w5agg6uE5KjZVNI3KLLfvf5M9J1fKLMlRiRJnwnb5ABzq+3AfB4hXXDtd+Nu0JPDmTn3Q6yGBNjpEQ73jQp/1VVCmYoqhSCwdcaeUYObEfysYa3k+39n1rGV6uv1JVCJ9rqxiPawzEQSwjQmhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF0aJjfy/SZBrHQvcz9S3og6DxDNPigE/t6UajttKao=;
 b=N0khFqvy6Ly0wlRb21tKPnJYEXSHqvKRHXn4H7BDsghQ0Ysig8G+1wegIRfJsBNPhsVptzePeWecT8NyI38NoCaiXS8Kxll7p73GOZlJjnvBEt9LHwQv7ly27Uixafdm7eVt5Dnqny/lemRFghecLaAfw+HzREBIvpBPxyrhGAaJJehbf1gvZZIP69rfwvn9ste2gQChwSfNHz4la4Sd7PaB2kJ8t0eZcR806ShRFGSYICSb4jzhHDz00u0yk1O8Z4EQc1BXMMFNOSpNR0+M+TlpoA7t6w1Ht7aBCzpxIgrklFxzlfr8p5IrzDM6r1qp98BQzcbnzOuHgbG4Yu9DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF0aJjfy/SZBrHQvcz9S3og6DxDNPigE/t6UajttKao=;
 b=HsAseuN2JATTjzQ6SyuijNW3OOs65wr0wC0IciDWZKXJMi9KjfpQSdzf2bJnKMH7bKwINSxlpxZpRmFP9bZL9GT5R1h3+iaxu5fK3ZT4kUgztr4b4mb9/ZoxuHs8E5wctwvJvecSrp3i4Pyr0zhJgLETw7swan9qCa0wl983pf77J23ODjp7E04/18ZCfQJM6lSF4htosxJz2M8FJkIlvlIH00pS1d6ejQUPPO/cAYJDpvxpQLcJX0Ezo3DIGNm7cGQTA3chJoujh0UKO0pXFThf8lA/bFjGs+wwRQGXl8Zx4OBt9SzsvH0so3zi+n8ZExj+6YuU28nC9t0PlMdKqg==
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV1PR12MB663552.namprd12.prod.outlook.com (2603:10b6:408:514::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 18:52:48 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:52:47 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Uladzislau Rezki
	<urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Thread-Topic: [PATCH] rcutorture: Don't try to disable to RT throttling.
Thread-Index: AQHdbUXj+z82MKm/Fkm8XMOYmrp+lrcfzqMAgAAEg4M=
Date: Thu, 5 Nov 2026 18:52:47 +0000
Message-ID: <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
In-Reply-To: <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7742:EE_|LV1PR12MB663552:EE_
x-ms-office365-filtering-correlation-id: 29e51bc4-469d-4f33-3855-08df3b6dfbf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|38070700021|4143699003|56012099006|11063799006|261009221227099003|261021123027099003|261009223027099003|261026121527099003|261028144727099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 /gndm+3+tF8cwjf0z2jNJc/M5iLAXibfwUPVxovtKOUFVlLxliNurI+3ZT73ooqfXGRJrKmaHhVpPi3cW62YpW44UlQ0R1QQQT2vh3eKFcja5NghsbMyFKeOMDmXRxGCteXSXd42KmqQzrjvxxgRDwMXiZzhoGvJ/rheQiIouG5Qoy+ZBZS1uNLlqPa/VgvybvXxmzWGwP8weGLejijPNGYvRduIeATRIR8xG+Xa54OVvwLj83WNJRhTKLNt37FyKJdAKkntC630XCuy/lI32I75otAjayAj2n8FYGZtFfcXYKyKU3iTPW4IjEIUgsUSVc/zQ3WVCgxFBjddwvwQFbgQ/+Su7u7c9+ZkS+ZXM/aVwXGOlltxVRbYfxHWpp4I0JHA3nP1cctF1fbUbCgK8iGoQQ5lNrWf3C6h9Yo60xAFz26y/guAsWpWkg3RY/tk9zIrDIKrPGKKbjGxJ1lAcptS6eD4hPRwxexImkTO32CD/2Uefb/kHYfUjTbkweImttQWCqWt3oQP10D9g8McoJIaRC9u4yO3SS2nmHoKZ/sr5l5h17V6vOG03UbvycPUHPWzvTfid4rRfJ2Pbtr08wzBbHyIakVzBpDQiHkntCAw6t0L+CpGH8TFjXCdES0tzek1FnqEVi6vQe4g6I/SU5YX0tfA6dcEAXBHC8ghCGUKSd45yqYo5MMlu53fn7lHt9s9sm/wpaBNzNn+1PFbzOt7F+VHQCYNkc2x1o+mC2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(261009221227099003)(261021123027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnVVcDlRdDFDVDU5SElIemt2VmEwaU5md0JmVnJhSkdFaFdib0ZlVTVCaUsy?=
 =?utf-8?B?bGJCTTd6UjlWelN2YmkrMGE3RGQwY3pqLzdHaUJ3cHlVZHRVWk9MNnBlWXJE?=
 =?utf-8?B?TjAwSTBobSs5ZnlUZFNmMk5HeElWU1EwTU1zRGVaelRYd2tsM3U5R3RTOEs3?=
 =?utf-8?B?Zm1IdzRPdUtveFV6T3FZdU5JRUlaRTFTVXU4MFhNOVZRYTV3cWNieUlRQkpn?=
 =?utf-8?B?WHBKb09YVEFSUlRacWpDcmpRd2FtZTdxSjJrcnltRUxYdlVXOUNydWI0MjhQ?=
 =?utf-8?B?SzQzZWl5NU9Wc1VuQU42cU1jK2t4M1JCdDhQVnNON0ZmMUxmVDZKbFNhVURU?=
 =?utf-8?B?cUZOTXFJbkVBTFMrQkVTb2hEc3RKMDBoWHkxaXZsV054TVk5OTFUTFVxcFlR?=
 =?utf-8?B?V0cwM1lGNUNuamM5YU81VGN3ZytOc3lNT01wTzhkdGprWU1wMXJZUGhIRHZr?=
 =?utf-8?B?ZHBYTVo3SjRNbENIVHFRWmJEZU1NMTdKdk12a1B2dTkwVHF3SXBOWDRYOU90?=
 =?utf-8?B?bDFqTFRxTDBUN1NQeDVoMForWWFzR3BXVlhjQVJmT0ZWWlNKQkEzUDdvWW4z?=
 =?utf-8?B?Z09uZzFSS2M3b3Rpc21hWDJKWGc4eDhSVEwzcFU4TktXTGI1OXA3NVBUbEcw?=
 =?utf-8?B?YXZSSllPRGFuRXRXYy9iVVA3OW5ZeW1iWkRjUGdUdUFSLzlFS3dYMThycGJh?=
 =?utf-8?B?NzgrYndYMk5aUVBsMk5ZQkJtMHNIWU9ZaGw4Y0svQWo1dm5CdUpRditoZW9E?=
 =?utf-8?B?VEUzTFlBYy9QV3JNY3B3ZmdsUTdWSFpPelBGYlNmQ2U4WHlYYWhGeUxsWHNy?=
 =?utf-8?B?c3JaZFhJRmpFNEFPYmtXMFdNdWhVcHVSSHNJUFdxOVdPZjFHVVptZ3dOSUh4?=
 =?utf-8?B?TEU0YVhBUktCUENlQW5aclVoVmJMMHloOUVEdUZPS0tFNE5waEtXZlpMdzVF?=
 =?utf-8?B?ZDlwVjZ4Q2dmNUpRN2VPbUpZS2dEQnVDZEQxem9TSURSSTJ1U1Ywc3dCOGtu?=
 =?utf-8?B?TGptWXJoQmFhZWtzQnBZWkZIVzkyYXF1Q1pSZEVNYlMyM0dQSjM2NHc0MWU0?=
 =?utf-8?B?UzdBSnNOeTFqL2tKeFllbVhDU2hNUHk2ZUUrT0pnMjRuUFFNd3hHT0lKeFNv?=
 =?utf-8?B?L1JnMlJQenpDdFRvY0RQVk5oUEJ1VHdrUkF2YzRycDhQaVVPWmVBUVFpMlF0?=
 =?utf-8?B?azZvWXpkeTk1c0VVQ2trNTBOaWI1eVZ3K1ZEQlRzR201eGtqTnBINXlaYi9s?=
 =?utf-8?B?bDhNaXR3ZUpOWk1YMmVXTEY1RVlYa1ZaQ3Fnc0JUVnpHYVdNQXlLVXBob2Z3?=
 =?utf-8?B?QzRqNTVuN0ZpZXhCKzFiTmh5cThZZVFzMlRLVEF2YXZZbjdCMyt2bE5ONnVW?=
 =?utf-8?B?VGxpaW03QStuUWQ4Q3VPMUdIZ2t3YzAzUDU4dm5DZ2VwZlpqMWJ4c1lEaHNz?=
 =?utf-8?B?RWY4VUNTV3AyOXp6UmJPSDlnb1UwY0VGTnlZNkk2UGFNS3czaThMTUNNWWRC?=
 =?utf-8?B?ZmVrS3VpczB5YXU4dmlHR0RTOHZBZVVrcUQxbE9QSVhjZEJlVndBL29rWkIv?=
 =?utf-8?B?NmVHVHFjdWZQSmIxSnJhYW81OXRwK3h2Z3lyQWF4ek8xQUxIb1ZBM3ZVemhW?=
 =?utf-8?B?eTl0cTVMRTRFVW1YcHNTcGthVE5DYnVRdXdIYWxrbWpzZUphZUNqUys5SlJ1?=
 =?utf-8?B?NG01V3VBR3cydnVCWDl2eG04Zm5ZWUN0UDRpUmZRYm1adnRpWHpOQjhjcVN2?=
 =?utf-8?B?ZXJwMVBhTjVVRnZmWVpGZnAxU00xMG9LRkFPaS9kNUZGcDBYelhQd2NrQVBV?=
 =?utf-8?B?aGgwamlSdWEzQWYzb2JnZFp6cHYxNkJXQklJcGZBRDIrUHdQNTkwY3BrcEo3?=
 =?utf-8?B?OVoxOGJxUysySTdiczZOLy9HZW9QQ0RVQThKcGNqcW9HWUdnQWlrMU1YZ2t5?=
 =?utf-8?B?VjN4Q1k4R3B5UWg0K3Z5S1VhQVhtWkZLK3JZT3J2dlFFYkVVTHdmUnlxU1lO?=
 =?utf-8?B?L0g0dS9ZV1AvTDh2SjhJNXo2WHZFQUhGNjdRV2pnZXVUSEFpN1VPZGw3bG5s?=
 =?utf-8?B?OG4vKzFqN1BXWHN0TmdDZkRIQzdxYlpDeVBVQlVBQXlHdVY2azhEaEw3WVdW?=
 =?utf-8?B?TzhYMmNHMWdvSnU5NTcwOHo3VExJSGNaRUpzdUJJMER0ZlpiQ0dWRHZQOTAy?=
 =?utf-8?B?R1NoSGYzb0MyVlVrb3E5Y01HS3J1QlYxVXJMZ0EzZllxM0krWnl5dkNFdUlH?=
 =?utf-8?B?RnhGbXpPU2pUbExuNEY2bjZGSXNaYnIwMTcvZDhyOVBOR21NU09FNEZlcDBn?=
 =?utf-8?B?bnpsZFdTcS9pVXhSckFHUmxpa1EwVWpNblRSNHM3cHFISFZrZzFzdz09?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e51bc4-469d-4f33-3855-08df3b6dfbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 18:52:47.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48R/UgM/krMNgtYTjlHjZw9fNFX8C9ohla8A86++FmVQW8HXg/VgFZ56Nrw8ia+til02zdqAqTECZRPXzf5c7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB663552

DQoNCj4gT24gTm92IDUsIDIwMjYsIGF0IDE6MzbigK9QTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1
bG1ja0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgTm92IDA1LCAyMDI2IGF0
IDA1OjUxOjEzUE0gKzAxMDAsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+PiBD
b21taXQgNDUwZWZjYTcxODJhNSAoInJjdXRvcnR1cmU6IERpc2FibGUgUlQgdGhyb3R0bGluZyBm
b3IgYm9vc3QNCj4+IHRlc3RzIikgYWRkZWQgdGhlIGFiaWxpdHkgdG8gZGlzYWJsZSBSVCB0aHJv
dHRsaW5nIHdoaWxlIHJjdXRvcnR1cmUgd2FzDQo+PiBydW4uDQo+PiANCj4+IFNpbmNlIHY2LjEy
IHRoZSBETCBmYWlyX3NlcnZlciB0YWtlcyBjb250cm9sIG9mIHRocm90dGxpbmcgYW5kIHRoaXMN
Cj4+IGludGVyZmFjZSBubyBsb25nZXIgc2VydmVzIHRoaXMgcHVycG9zZS4gVGhhdCBzeXNjdGwg
Y29udHJvbCBzdGlsbA0KPj4gZXhpc3RzIGJ1dCBzZXJ2ZXMgYSBkaWZmZXJlbnQgY2F1c2UuDQo+
PiANCj4+IFRoZXJlIGlzIG5vIGluLWtlcm5lbCBpbnRlcmZhY2UgdG8gcHJvdmlkZSB0aGlzIGZl
YXR1cmUsIG9uZSBuZWVkcyB0bw0KPj4gZWNobyAtMSB0byBlYWNoIC9zeXMva2VybmVsL2RlYnVn
L3NjaGVkL2ZhaXJfc2VydmVyL2NwdSovcnVudGltZSBmaWxlLg0KPj4gDQo+PiBTaW5jZSBzeXNj
dGxfc2NoZWRfcnRfcnVudGltZSBkb2VzIG5vdCBkbyB3aGF0IGl0IG9uY2UgZGlkLCByZW1vdmUg
aXQNCj4+IGZyb20gcmN1dG9ydHVyZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFu
IEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiANCj4gVGhhbmsgeW91
LCBidXQgb3VjaC4uLiAgRG9lcyB0aGlzIG1lYW4gdGhhdCB0aGVyZSBpcyBubyBsb25nZXIgYW55
IHVzZWZ1bA0KPiBpbi1rZXJuZWwgd2F5IHRvIHRlc3QgUkNVIHByaW9yaXR5IGJvb3N0aW5nPw0K
DQpUaGVyZSBzaG91bGQgYmUgYSB3YXkgdG8gZGlzYWJsZSBETCBzZXJ2ZXIuIEFkZGluZyBBbmRy
ZWFzIHRvIGNoZWNrIGlmIHRoZXJlIGlzIGEgd2F5LiBCdXQgSSBhbSB3b25kZXJpbmcgaWYgdGhl
IHByaW8gYm9vc3QgdGVzdHMgYXJlIHdvcmtpbmcsIHRoZW4gaXMgdGhlIERMIHNlcnZlciB0aHJv
dHRsaW5nIGJyb2tlbj8gOy0pDQoNClRoYW5rcw0KDQo+IA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBUaGFueCwgUGF1bA0KPiANCj4+IC0tLQ0KPj4ga2VybmVsL3JjdS9yY3UuaCAgICAg
ICAgfCAgMiAtLQ0KPj4ga2VybmVsL3JjdS9yY3V0b3J0dXJlLmMgfCAzNSAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAzNyBkZWxldGlvbnMo
LSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmN1LmggYi9rZXJuZWwvcmN1L3Jj
dS5oDQo+PiBpbmRleCBkNjA0NDRiZjNhMDJkLi42ZDEwMzRlNDlkNDExIDEwMDY0NA0KPj4gLS0t
IGEva2VybmVsL3JjdS9yY3UuaA0KPj4gKysrIGIva2VybmVsL3JjdS9yY3UuaA0KPj4gQEAgLTY5
LDggKzY5LDYgQEANCj4+IC8qIEEgY29tcGxldGUgZ3JhY2UgcGVyaW9kIGNvdW50ICovDQo+PiAj
ZGVmaW5lIFJDVV9TRVFfR1AgKFJDVV9TRVFfU1RBVEVfTUFTSyArIDEpDQo+PiANCj4+IC1leHRl
cm4gaW50IHN5c2N0bF9zY2hlZF9ydF9ydW50aW1lOw0KPj4gLQ0KPj4gLyoNCj4+ICAqIFJldHVy
biB0aGUgY291bnRlciBwb3J0aW9uIG9mIGEgc2VxdWVuY2UgbnVtYmVyIHByZXZpb3VzbHkgcmV0
dXJuZWQNCj4+ICAqIGJ5IHJjdV9zZXFfc25hcCgpIG9yIHJjdV9zZXFfY3VycmVudCgpLg0KPj4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIGIva2VybmVsL3JjdS9yY3V0b3J0
dXJlLmMNCj4+IGluZGV4IDk2ODM0M2JlNGUwZDEuLmFjYWI0MjVlNzJhZDUgMTAwNjQ0DQo+PiAt
LS0gYS9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYw0KPj4gKysrIGIva2VybmVsL3JjdS9yY3V0b3J0
dXJlLmMNCj4+IEBAIC0xMzMzLDM5ICsxMzMzLDYgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmN1
dG9ydHVyZV9zZXFfZGlmZih1bnNpZ25lZCBsb25nIG5ldywgdW5zaWduZWQgbG9uZyBvbGQpDQo+
PiAgICByZXR1cm4gY3VyX29wcy0+Z3BfZGlmZihuZXcsIG9sZCk7DQo+PiB9DQo+PiANCj4+IC0v
Kg0KPj4gLSAqIFJDVSB0b3J0dXJlIHByaW9yaXR5LWJvb3N0IHRlc3RpbmcuICBSdW5zIG9uZSBy
ZWFsLXRpbWUgdGhyZWFkIHBlcg0KPj4gLSAqIENQVSBmb3IgbW9kZXJhdGUgYnVyc3RzLCByZXBl
YXRlZGx5IHN0YXJ0aW5nIGdyYWNlIHBlcmlvZHMgYW5kIHdhaXRpbmcNCj4+IC0gKiBmb3IgdGhl
bSB0byBjb21wbGV0ZS4gIElmIGEgZ2l2ZW4gZ3JhY2UgcGVyaW9kIHRha2VzIHRvbyBsb25nLCB3
ZSBhc3N1bWUNCj4+IC0gKiB0aGF0IHByaW9yaXR5IGludmVyc2lvbiBoYXMgb2NjdXJyZWQuDQo+
PiAtICovDQo+PiAtDQo+PiAtc3RhdGljIGludCBvbGRfcnRfcnVudGltZSA9IC0xOw0KPj4gLQ0K
Pj4gLXN0YXRpYyB2b2lkIHJjdV90b3J0dXJlX2Rpc2FibGVfcnRfdGhyb3R0bGUodm9pZCkNCj4+
IC17DQo+PiAtICAgIC8qDQo+PiAtICAgICAqIERpc2FibGUgUlQgdGhyb3R0bGluZyBzbyB0aGF0
IHJjdXRvcnR1cmUncyBib29zdCB0aHJlYWRzIGRvbid0IGdldA0KPj4gLSAgICAgKiB0aHJvdHRs
ZWQuIE9ubHkgcG9zc2libGUgaWYgcmN1dG9ydHVyZSBpcyBidWlsdC1pbiBvdGhlcndpc2UgdGhl
DQo+PiAtICAgICAqIHVzZXIgc2hvdWxkIG1hbnVhbGx5IGRvIHRoaXMgYnkgc2V0dGluZyB0aGUg
c2NoZWRfcnRfcGVyaW9kX3VzIGFuZA0KPj4gLSAgICAgKiBzY2hlZF9ydF9ydW50aW1lIHN5c2N0
bHMuDQo+PiAtICAgICAqLw0KPj4gLSAgICBpZiAoIUlTX0JVSUxUSU4oQ09ORklHX1JDVV9UT1JU
VVJFX1RFU1QpIHx8IG9sZF9ydF9ydW50aW1lICE9IC0xKQ0KPj4gLSAgICAgICAgcmV0dXJuOw0K
Pj4gLQ0KPj4gLSAgICBvbGRfcnRfcnVudGltZSA9IHN5c2N0bF9zY2hlZF9ydF9ydW50aW1lOw0K
Pj4gLSAgICBzeXNjdGxfc2NoZWRfcnRfcnVudGltZSA9IC0xOw0KPj4gLX0NCj4+IC0NCj4+IC1z
dGF0aWMgdm9pZCByY3VfdG9ydHVyZV9lbmFibGVfcnRfdGhyb3R0bGUodm9pZCkNCj4+IC17DQo+
PiAtICAgIGlmICghSVNfQlVJTFRJTihDT05GSUdfUkNVX1RPUlRVUkVfVEVTVCkgfHwgb2xkX3J0
X3J1bnRpbWUgPT0gLTEpDQo+PiAtICAgICAgICByZXR1cm47DQo+PiAtDQo+PiAtICAgIHN5c2N0
bF9zY2hlZF9ydF9ydW50aW1lID0gb2xkX3J0X3J1bnRpbWU7DQo+PiAtICAgIG9sZF9ydF9ydW50
aW1lID0gLTE7DQo+PiAtfQ0KPj4gLQ0KPj4gc3RhdGljIGJvb2wgcmN1X3RvcnR1cmVfYm9vc3Rf
ZmFpbGVkKHVuc2lnbmVkIGxvbmcgZ3Bfc3RhdGUsIHVuc2lnbmVkIGxvbmcgKnN0YXJ0KQ0KPj4g
ew0KPj4gICAgaW50IGNwdTsNCj4+IEBAIC0zMzkwLDcgKzMzNTcsNiBAQCBzdGF0aWMgaW50IHJj
dXRvcnR1cmVfYm9vc3Rlcl9jbGVhbnVwKHVuc2lnbmVkIGludCBjcHUpDQo+PiAgICBtdXRleF9s
b2NrKCZib29zdF9tdXRleCk7DQo+PiAgICB0ID0gYm9vc3RfdGFza3NbY3B1XTsNCj4+ICAgIGJv
b3N0X3Rhc2tzW2NwdV0gPSBOVUxMOw0KPj4gLSAgICByY3VfdG9ydHVyZV9lbmFibGVfcnRfdGhy
b3R0bGUoKTsNCj4+ICAgIG11dGV4X3VubG9jaygmYm9vc3RfbXV0ZXgpOw0KPj4gDQo+PiAgICAv
KiBUaGlzIG11c3QgYmUgb3V0c2lkZSBvZiB0aGUgbXV0ZXgsIG90aGVyd2lzZSBkZWFkbG9jayEg
Ki8NCj4+IEBAIC0zNDI4LDcgKzMzOTQsNiBAQCBzdGF0aWMgaW50IHJjdXRvcnR1cmVfYm9vc3Rl
cl9pbml0KHVuc2lnbmVkIGludCBjcHUpDQo+PiANCj4+ICAgIC8qIERvbid0IGFsbG93IHRpbWUg
cmVjYWxjdWxhdGlvbiB3aGlsZSBjcmVhdGluZyBhIG5ldyB0YXNrLiAqLw0KPj4gICAgbXV0ZXhf
bG9jaygmYm9vc3RfbXV0ZXgpOw0KPj4gLSAgICByY3VfdG9ydHVyZV9kaXNhYmxlX3J0X3Rocm90
dGxlKCk7DQo+PiAgICBWRVJCT1NFX1RPUk9VVF9TVFJJTkcoIkNyZWF0aW5nIHJjdV90b3J0dXJl
X2Jvb3N0IHRhc2siKTsNCj4+ICAgIGJvb3N0X3Rhc2tzW2NwdV0gPSBrdGhyZWFkX3J1bl9vbl9j
cHUocmN1X3RvcnR1cmVfYm9vc3QsIE5VTEwsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3B1LCAicmN1X3RvcnR1cmVfYm9vc3RfJXUiKTsNCj4+IC0tDQo+PiAyLjU1LjANCj4+IA0K

Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C681EFFB8;
	Wed,  2 Apr 2025 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576827; cv=fail; b=kOcUxI2Cp90ygi11h4CuHiQ7rswMBD6xmM8XCMuPVG9DDacsInHHuaeI6K9wNCHbhWymxupc6sv8FmflvQHZKDVB9obTZtHm267wbypv5gT8yDpg4bT09X1UFwmVLoXqeKrsLPPVjNsFbfC8wSpKLJm1qlnk0qQVM/0w3QZc68U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576827; c=relaxed/simple;
	bh=0c4VjEQP+6uCzOkg0jWsGxwLOOLXXaEZNA8Sa+hgZJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJPqoalWYUWuRbiToHcWpPJgPvh9VfvFNnhyuPr5YT5GI33w9EqvVUycacSZx2IPF4nN9YGY4gPwrFJUNtD9EbSjqjqVnU7rmS7YlODreYfmlElNoEqVtAsVXCMBFt0/qVrsoIhEcHTFFbJjFU7+BeyHtpo8NqIqw6MOC9XNkw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=htdDI75+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HXaYR9ta; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="htdDI75+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HXaYR9ta"
X-UUID: 2ea3963e0f8f11f0aae1fd9735fae912-20250402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0c4VjEQP+6uCzOkg0jWsGxwLOOLXXaEZNA8Sa+hgZJo=;
	b=htdDI75+phD9DMskcOtHkCFh9EYJyzpPgLH0Iaoj+j4vmSyrnpMdmjBQBkWgXFItG5Zob9Da59KyQGTPPr+HobSTw19n5a41Y+ugG9bKTKftU86mhE90gEjZoe0Jc2ik6IP073Dv6RHwO18e6EFguUmAa+VdFiqEmXu+LD9TcWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:22f97bdc-a36d-43a3-8eed-a319bbeb9bb9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:428819c7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ea3963e0f8f11f0aae1fd9735fae912-20250402
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <kuyo.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1191037768; Wed, 02 Apr 2025 14:53:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 2 Apr 2025 14:53:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 2 Apr 2025 14:53:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb7PtL2kBAtXJcvQiZSiitA6rPzo7PvbqyBGp/uNdRvVgaIFcSN2I9M8Wye94XuzX8SKKOp7Kr07bdL6fb/7ddNHVxszw9SWF6prOnJPoBah8hrB6Dlz88jSqTLoj9sIeSHA4tDDi1vfRvW15kEcC6DN5FEkyf0gf3/vDEgHRUvSUHRlSOupsefjGsSCJ7jsgnqnSAdUfuMFeIB1P7NCqpWFWUVBitGmtt9vnMPCfJ/jFvVO+hjMdgtgvJc2SAQxmiiI13cpzcQI560o9EqZS/vHMyh1hqkHjETFDI14hKMTejINli0HN3nsaDxsCdteV6kbozPG1/nVmt3mhY7PoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c4VjEQP+6uCzOkg0jWsGxwLOOLXXaEZNA8Sa+hgZJo=;
 b=HYeYAq0tsPmsMmMcYdCfDZy20w/KModkSlKxbHLU3U9xhuXTkSvI/MF+LQATfZjbmBlLNdNdtf8iN5mipMIqI1E9EPa/9zK+Oe7Q6vyqnM8K2V8ec+l19JX29dndiwqLk7auDZ8NBWTAtKoulxbh2fE8bxIqKSeWKPKL8JNsqXyaxxJJKe7yqInIWHxyCDk4eX7NfbBH0709zahh/onZQVz/eNgF232mkJI4jliNQc2/3wL4wxn1dS3eN+kPAxfUMYsbzlIlvMUmd8Eys8u8JRSRjtNW0g9qTXkWkWcXG04zPAMYdk7ndMAU/DJ31bm8FwxbyDHD6zmZcnXii+d/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c4VjEQP+6uCzOkg0jWsGxwLOOLXXaEZNA8Sa+hgZJo=;
 b=HXaYR9taOla0YSWr7yZGH2n00AMtF+AXC0J93IKInlQDDHlXVu62d6a9VgqkKPzJgOCdXyHFuFL925KUMw0wkFQKrKgwhWC7m7z1hSEUttHnHOp0bcfW4PKgp1AElFx8D9uk9bjEURlDN2smxb7ycUdACiixDXquJxURj7Ct42Y=
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com (2603:1096:4:12e::5) by
 SEZPR03MB6620.apcprd03.prod.outlook.com (2603:1096:101:7b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.33; Wed, 2 Apr 2025 06:53:24 +0000
Received: from SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::e57f:afc5:49cd:45bc]) by SI2PR03MB5580.apcprd03.prod.outlook.com
 ([fe80::e57f:afc5:49cd:45bc%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 06:53:24 +0000
From: =?utf-8?B?S3V5byBDaGFuZyAo5by15bu65paHKQ==?= <Kuyo.Chang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>,
	=?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= <Walter.Chang@mediatek.com>
CC: wsd_upstream <wsd_upstream@mediatek.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "vlad.wing@gmail.com" <vlad.wing@gmail.com>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "kernel-team@meta.com" <kernel-team@meta.com>,
	=?utf-8?B?QWxleCBIb2ggKOizgOaMr+WdpCk=?= <Alex.Hoh@mediatek.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "neeraj.upadhyay@amd.com"
	<neeraj.upadhyay@amd.com>, "leitao@debian.org" <leitao@debian.org>,
	=?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "qiang.zhang1211@gmail.com"
	<qiang.zhang1211@gmail.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	=?utf-8?B?WGluZ2h1YSBZYW5nICjmnajlhbTljY4p?= <Xinghua.Yang@mediatek.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Topic: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Index: AQHbn7ek2AdWKEF+okqg29msJ8sB+7OP+GqA
Date: Wed, 2 Apr 2025 06:53:24 +0000
Message-ID: <ce8ec4491cfd17a374177918537a6b3be34dbb43.camel@mediatek.com>
References: <20250117232433.24027-1-frederic@kernel.org>
	 <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
	 <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>
	 <Z-Qu0stgvwHF9n3q@localhost.localdomain>
In-Reply-To: <Z-Qu0stgvwHF9n3q@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5580:EE_|SEZPR03MB6620:EE_
x-ms-office365-filtering-correlation-id: 77b50ed3-c895-4f43-5c3b-08dd71b31072
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3ZSNU9KV3RQc3RZSjR5WGw5d25hYTdIMWdQV0V2cUZ5M1pBT2JlR2EvS3VX?=
 =?utf-8?B?Nis4ZTZLTEs4SVlScWozeVZtQ2ltU1JvZVl2a2xvUXBnT3VCNzhVUzlrc0Zy?=
 =?utf-8?B?SzhOR2x0aFY1V2gySGUrUHcwNjd5d2VReEZSd2VKWGFFTjIzbisrOXN2UE93?=
 =?utf-8?B?S1c5d05mTjN4aUNXc1BkUmlCOGE1aUVlRC9yVmRleUJtRUNIWjZuejV4T2ZG?=
 =?utf-8?B?eHVFTGlPWXljSkF2V1J3R1NNY2d6TVBvR050NEkwOXA2NXlXdS9vTUhpZVMy?=
 =?utf-8?B?eWNwRU56Q1NxWHFaN3V1TnoxWnFNZWQxTUhlU1k2VjczdWlmL0hrT1VyKzBl?=
 =?utf-8?B?U2NrVVNpVmZiT1pqMHFEWGcxazRhVG1leHJ1TWgzUG40VUpxZVZRWjJ3OWRx?=
 =?utf-8?B?SExnRDNXRURKYnNvdkoyNDg0Qzh4d002OC9SZk4va0dqRS82bjdIQndMSDlR?=
 =?utf-8?B?Q1JmaUhvWWp4UW9hNHFPSGsrcmtmeVFKQ1p4NC96c3hZRU14WXFKKzJpWXIz?=
 =?utf-8?B?bzlXc09rSmNuTXI0Z0hYQndJcTZDSnAyRU1pQUZIWTJ4dWxOT1JiVThOelE3?=
 =?utf-8?B?MUE3dHFKK040Yml6Q0FncXZXZGdvWU1aMW9xaGZpb1ZQWDdjY2dMWmxuTVhQ?=
 =?utf-8?B?RDBZT3QybGNTSUI2UVd6cEZraWpJZmJSbnd1ZXQ5cWdONnZqYUpsblBWUDVx?=
 =?utf-8?B?TVFoeVFseWNMUG5CRTlxb2x1ak1NV09ESkZDczIrUzl5NzBmcy81SmVrMSth?=
 =?utf-8?B?RUdJY3ZZbGtEV3dkbGdqbnQ2RXlFN3lOeW54NlZMOHBzVndzcGE4dlhWTGcr?=
 =?utf-8?B?YlpJeW42VG1jUTc2OU03bWxCcHI4bkd1bEdLa081WllyV2I5RjlxUTJLMGlz?=
 =?utf-8?B?bGphaVlGc3o5ZWJJSk1SbmV2MlNqNEUrR2MrV3I4N2xwSi9IQlVNbW0ybVFV?=
 =?utf-8?B?Y2x4b0hYWTYwYStIR3dPaFZqN1VEUHFLZkxNS0ZZd29MdXpKbVdDMSs2YkRF?=
 =?utf-8?B?T292WU03TFFzSFJNTExqTEV6dDRuYkpTWU1TcVpvbzBKMnkzZ05RR3dody9K?=
 =?utf-8?B?VVZya2E1T012MmdFSUx6U3pRNkIxNWpqVDdmU1BJcnhrTG9wbXQrUkloVzZF?=
 =?utf-8?B?S1p0ZDFQSlBCam15eVFMdERDUVQvdHdqQ2o0K04xWVJUeXJNbThXeU4xKzZK?=
 =?utf-8?B?VTZZaURSNHBoSi8zTCtJNE16ZUNyYWdySjlTZDFuZmMvSFlySDJZQnFNYmFZ?=
 =?utf-8?B?OG83RG5RWFFCVXNQek5TTGRGR1VCYTZic2hLcTBKeXhKTGpQZ0ZHT0QvNXB2?=
 =?utf-8?B?ZHJyWmR4T0hwWDRtUURjcW4yVkJ0dHdKRmF1Sm1DLzEvSmFoWmQ4OUhncHUz?=
 =?utf-8?B?ZzJPS0RTRElubzBNaytQMzRqS2pqbUxkNzNhdHZVQ1lrOHZQVFh4bS90VlFh?=
 =?utf-8?B?ckhHcTJoQzZ6VmpYMkZnMndQK2NJV2ltTXdBUDVMVjdYVi9GbXZteWJ1RW5Y?=
 =?utf-8?B?UFpoM3FmUVU4MDA5ajdSQ1FVM2tMZEY0a3BsNXhZWWl6RktzWjQwOVdPUFVV?=
 =?utf-8?B?UXRtZzF6bTk2YUFWRnB1T1dINDNDdWhNcW5seFBIUW8xOEtUbVBsaVBNSStx?=
 =?utf-8?B?eUdqNkhlSXQ4SjcyMS96aFRjdHBsVFk4Z0g5NEljaUNJZXBsQnorQXE3K2ZJ?=
 =?utf-8?B?U0YrejF3YVZqUk51ZUJsY0VVNVQrVkdBSExCSkZJUk9xWVRFWVpRRHVGenAz?=
 =?utf-8?B?Tk1WWnZ3b3huY0t2RFViUzdFY3M0TUZGdmJSTmFnckcxbmtVbTZ4alJ1QlhF?=
 =?utf-8?B?akxkVmJ5Q28rRGlJSUpNREFtUDhFZnNhY202TlJlc0N4SUxuMHpmNlk1dXhW?=
 =?utf-8?B?a2QwQ0VEZGF1NEYxMGJVcmI0UEhrc0c5Rm1rZDJZaENaY1ZmMHRvUlE4T3F6?=
 =?utf-8?B?YmR5Mlk0TlBlYzdPalUwSURvWjFpUU9UMm1walAyamlFaVh0NlNmelRnU2JI?=
 =?utf-8?B?dXZJKzhXcnN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5580.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3FEYTNMNTBJMjFhSkNyaC9jY3VocTBheGZtY2tnOURFSC95alJBMkNGT3JL?=
 =?utf-8?B?UW84TFd1T0srMEMvVUNjREl1STF0Q3B4T3Q4UUQyTEMrbmNPaXp1MWdyM1lC?=
 =?utf-8?B?N3BBNkxBRGhyM1BEYVpoMWVaOFdZRlRXOUsvOTJuMjZRSDV2SUhCcXNxNmRQ?=
 =?utf-8?B?dE9HemhyRHpheWVhdE9qcEV1SjFGMCtNK2lNZ0pvOTRnOVVxako0YkpQejZJ?=
 =?utf-8?B?d24zVm14bVIzdEhidEN5RUZWZzI1S2tDRVZPeVlaQmhSNVNzRFJ6QjZTUlJ6?=
 =?utf-8?B?OFZ6dy81Z0crQ3MrNTlpSWxMMGhOVFZ1citkeGVuR1VtRG13SzlTNTFESWVK?=
 =?utf-8?B?OVJBM2kremU3S1c1NzFtZXpFS0I4cmk2OFg3NlJyS2lwTkcvS1JXSGRRcURo?=
 =?utf-8?B?Q1V3bzdIQ01LZU0yd3dHTWdpYS9GUnNjYkU5MFgvN0plMjJKNkNhMWJ5MDdY?=
 =?utf-8?B?aHg2VU9aZnZhWlJTSVdSZU54RGoyYjBERlBlMW1NNmdOM29GYVFmZ3NBV0R1?=
 =?utf-8?B?NFoxOTlaTzI5VThnUEZJcy91SjdEeUNyMEdqaExQV0pQSWNJTU1xZUg4RlRs?=
 =?utf-8?B?Vmc1aUtDWXdpbitkRnJvZ1dlSzNIQmZ2S2VVakVsWnBtM29makJUNkZkWTF6?=
 =?utf-8?B?amRtd2o3QTQ3aWJwZms1NGVwOXlkUkY2bnErVndQdzg4ZkhHUWwxN2lxTVNr?=
 =?utf-8?B?eE1uL2MwVElXN0dTUlY4Y2ptRU1PYUxuWFNoQTFGbEgwVkIzdW93OU5KYmhP?=
 =?utf-8?B?cXFEa21lai9FL21IQ2JsNzNDOERqNEJqZHZ4MXpoNEttUWlVVTZScGhMQTJP?=
 =?utf-8?B?Y2Z6M1hjak5OTVhrcEJFRCt3WnlZcTBaUUlYMEFtQ0hLREZKMXVQb2ZtOWs4?=
 =?utf-8?B?ZlRYT2NtdHN2WTRUbnhFQ29xb0dsWFMwaUhOdGUvWDJmenpYbDkzUEF2aHlu?=
 =?utf-8?B?Y3llRDE1UXNXUmQ5akw5T05QRnpubEtWc3F5OUNWeHlEdmlVYUFPTGx6Mjhi?=
 =?utf-8?B?dGNEdE8wOGZzVTF5c2hVclVuakhTblBDMHNuNHZicnhGb3dYemdCYklrOWhk?=
 =?utf-8?B?bXJKU3dmMytFTmhzWnI3Wk9XS0t3c0J4QVFybi84MDRsOW92NHJWWkxqbXZu?=
 =?utf-8?B?YzFKdTFSRHpmdmRYRnI1cXdudVVlWm1Db0dHUTdydWF6OXFNMzVmNVhvUmpN?=
 =?utf-8?B?OFpiT3Y2a3RjMjQvbTVONUk0U1UrcnprdTVVNFUrWDVPLzNaVVdocmR3ejRo?=
 =?utf-8?B?MnZPcjJMODIwNThWN2NGZHJkQ1FiMWFoS3AwZk95TTVJWWw4NkZjbng4bWZ2?=
 =?utf-8?B?YWNwZUJQeDFoMkk2UFdlR3F3R1Y2YkRLM25Xc1V0dG9PbmNlWVp0d0FqWG5x?=
 =?utf-8?B?WnVBK0ZNYjlPUG53UTVVa1Uvd1BSY2dHbXVyWUhvaUUxdkgxVVNlbzBMZ01p?=
 =?utf-8?B?dFRNVzNpaFJZR0lDTUorVU16Y0RhTkh4bkt2NmtuT1kyYW1YUTl0ank5M2hq?=
 =?utf-8?B?M2ZxSVR1ME40UjBxVk9CaUNJRWpLWlRIWlVXVS92R3NxT1djOCtiblYwbTZZ?=
 =?utf-8?B?N2YyZVJtWTZBTVNqUlppUzE0VDdSRnQvTCtLa0pvc3RtSXpaWGpSRTI0WjJz?=
 =?utf-8?B?cGpQZlV5d21TWTVpL3pVT0FsQzZBWXFkUjc1S2NySDZGSFNSN1VqSVNTd1NX?=
 =?utf-8?B?NCtYdlVHa2lvMkUwNE03VG5POXFBYlYwRGY4aWMrenFYWnFIQkhHMUZZVGZY?=
 =?utf-8?B?Vml4YmZZQ0tVMVJUMzlCaC9uSVFMbkhUUU1CU2RCVlRpUnBxTDR6MXJhdWIw?=
 =?utf-8?B?NWxlUFU1dys1RFBnYlFqcnVRUlVXZVlyUjJIbk5sdG11MmRnSCtoZFBHUWhr?=
 =?utf-8?B?YVBLVUxNSlVtQ3VHL3dTZ0xqc29QM1Q0bWhlTDlmWUVYZkxTZGcwWFZyeTR0?=
 =?utf-8?B?YndrZ1U3RjdqTGFocEE3TWZ4L0V0QlBlMXpMRG5lV3paa2ZUYUhzdm5CaXJ2?=
 =?utf-8?B?Z0lUREEzeGMwYVE2bFE3bnVWbkxic2QvMWt3Mm1mK3M2a2IvZG4zNXZlK1da?=
 =?utf-8?B?VWV4YmV3eG9TZ3hBTnphaXQ3c2UzMTBWeFFNbmVLVmdUNUp4em5uWUJQT1hC?=
 =?utf-8?B?M3Y3NnV3djl1Qi9QKzhyQUFGS3lzQVRidDVweitUSzVJUkNvZEo4ZEZYd1E5?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB7D115E9F72FA4DA6FD799C0B0BEAB5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5580.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b50ed3-c895-4f43-5c3b-08dd71b31072
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 06:53:24.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Otna1/S/6q37gI+5EDd59paIJXblRE0G9C9vDnaifFlFwu/IbuvaAsOhbyBiHoymGLDy0tWEY1+z8eGg3u3sjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6620

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE3OjQ0ICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBIaSBXYWx0ZXIgQ2hhbmcsDQo+IA0KPiBMZSBXZWQsIE1hciAyNiwgMjAyNSBhdCAw
NTo0NjozOEFNICswMDAwLCBXYWx0ZXIgQ2hhbmcgKOW8tee2reWTsikgYSDDqWNyaXQNCj4gOg0K
PiA+IE9uIFR1ZSwgMjAyNS0wMS0yMSBhdCAwOTowOCAtMDgwMCwgUGF1bCBFLiBNY0tlbm5leSB3
cm90ZToNCj4gPiA+IE9uIFNhdCwgSmFuIDE4LCAyMDI1IGF0IDEyOjI0OjMzQU0gKzAxMDAsIEZy
ZWRlcmljIFdlaXNiZWNrZXINCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBocnRpbWVycyBhcmUgbWln
cmF0ZWQgYXdheSBmcm9tIHRoZSBkeWluZyBDUFUgdG8gYW55IG9ubGluZQ0KPiA+ID4gPiB0YXJn
ZXQNCj4gPiA+ID4gYXQNCj4gPiA+ID4gdGhlIENQVUhQX0FQX0hSVElNRVJTX0RZSU5HIHN0YWdl
IGluIG9yZGVyIG5vdCB0byBkZWxheQ0KPiA+ID4gPiBiYW5kd2lkdGgNCj4gPiA+ID4gdGltZXJz
DQo+ID4gPiA+IGhhbmRsaW5nIHRhc2tzIGludm9sdmVkIGluIHRoZSBDUFUgaG90cGx1ZyBmb3J3
YXJkIHByb2dyZXNzLg0KPiA+ID4gPiANCj4gPiA+ID4gSG93ZXZlciB3YWtlIHVwcyBjYW4gc3Rp
bGwgYmUgcGVyZm9ybWVkIGJ5IHRoZSBvdXRnb2luZyBDUFUNCj4gPiA+ID4gYWZ0ZXINCj4gPiA+
ID4gQ1BVSFBfQVBfSFJUSU1FUlNfRFlJTkcuIFRob3NlIGNhbiByZXN1bHQgYWdhaW4gaW4gYmFu
ZHdpZHRoDQo+ID4gPiA+IHRpbWVycw0KPiA+ID4gPiBiZWluZyBhcm1lZC4gRGVwZW5kaW5nIG9u
IHNldmVyYWwgY29uc2lkZXJhdGlvbnMgKGNyeXN0YWwgYmFsbA0KPiA+ID4gPiBwb3dlciBtYW5h
Z2VtZW50IGJhc2VkIGVsZWN0aW9uLCBlYXJsaWVzdCB0aW1lciBhbHJlYWR5DQo+ID4gPiA+IGVu
cXVldWVkLA0KPiA+ID4gPiB0aW1lcg0KPiA+ID4gPiBtaWdyYXRpb24gZW5hYmxlZCBvciBub3Qp
LCB0aGUgdGFyZ2V0IG1heSBldmVudHVhbGx5IGJlIHRoZQ0KPiA+ID4gPiBjdXJyZW50DQo+ID4g
PiA+IENQVSBldmVuIGlmIG9mZmxpbmUuIElmIHRoYXQgaGFwcGVucywgdGhlIHRpbWVyIGlzIGV2
ZW50dWFsbHkNCj4gPiA+ID4gaWdub3JlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBtb3N0IG5v
dGFibGUgZXhhbXBsZSBpcyBSQ1Ugd2hpY2ggaGFkIHRvIGRlYWwgd2l0aCBlYWNoIGFuZA0KPiA+
ID4gPiBldmVyeSBvZg0KPiA+ID4gPiB0aG9zZSB3YWtlLXVwcyBieSBkZWZlcnJpbmcgdGhlbSB0
byBhbiBvbmxpbmUgQ1BVLCBhbG9uZyB3aXRoDQo+ID4gPiA+IHJlbGF0ZWQNCj4gPiA+ID4gd29y
a2Fyb3VuZHM6DQo+ID4gPiA+IA0KPiA+ID4gPiBfIGU3ODc2NDRjYWY3NiAocmN1OiBEZWZlciBS
Q1Uga3RocmVhZHMgd2FrZXVwIHdoZW4gQ1BVIGlzDQo+ID4gPiA+IGR5aW5nKQ0KPiA+ID4gPiBf
IDkxMzlmOTMyMDlkMSAocmN1L25vY2I6IEZpeCBSVCB0aHJvdHRsaW5nIGhydGltZXIgYXJtZWQg
ZnJvbQ0KPiA+ID4gPiBvZmZsaW5lIENQVSkNCj4gPiA+ID4gXyBmNzM0NWNjYzYyYTQgKHJjdS9u
b2NiOiBGaXggcmN1b2cgd2FrZS11cCBmcm9tIG9mZmxpbmUNCj4gPiA+ID4gc29mdGlycSkNCj4g
PiA+ID4gDQo+ID4gPiA+IFRoZSBwcm9ibGVtIGlzbid0IGNvbmZpbmVkIHRvIFJDVSB0aG91Z2gg
YXMgdGhlIHN0b3AgbWFjaGluZQ0KPiA+ID4gPiBrdGhyZWFkDQo+ID4gPiA+ICh3aGljaCBydW5z
IENQVUhQX0FQX0hSVElNRVJTX0RZSU5HKSByZXBvcnRzIGl0cyBjb21wbGV0aW9uIGF0DQo+ID4g
PiA+IHRoZQ0KPiA+ID4gPiBlbmQNCj4gPiA+ID4gb2YgaXRzIHdvcmsgdGhyb3VnaCBjcHVfc3Rv
cF9zaWduYWxfZG9uZSgpIGFuZCBwZXJmb3JtcyBhIHdha2UNCj4gPiA+ID4gdXANCj4gPiA+ID4g
dGhhdA0KPiA+ID4gPiBldmVudHVhbGx5IGFybXMgdGhlIGRlYWRsaW5lIHNlcnZlciB0aW1lcjoN
Cj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdBUk5JTkc6IENQVTogOTQg
UElEOiA1ODggYXQNCj4gPiA+ID4ga2VybmVsL3RpbWUvaHJ0aW1lci5jOjEwODYNCj4gPiA+ID4g
aHJ0aW1lcl9zdGFydF9yYW5nZV9ucysweDI4OS8weDJkMA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBDUFU6IDk0IFVJRDogMCBQSUQ6IDU4OCBDb21tOiBtaWdyYXRpb24vOTQgTm90DQo+
ID4gPiA+IHRhaW50ZWQNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgU3RvcHBlcjogbXVs
dGlfY3B1X3N0b3ArMHgwLzB4MTIwIDwtDQo+ID4gPiA+IHN0b3BfbWFjaGluZV9jcHVzbG9ja2Vk
KzB4NjYvMHhjMA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSSVA6IDAwMTA6aHJ0aW1l
cl9zdGFydF9yYW5nZV9ucysweDI4OS8weDJkMA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBDYWxsIFRyYWNlOg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxUQVNLPg0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID8gaHJ0aW1lcl9zdGFydF9yYW5nZV9ucw0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0X2RsX3RpbWVyDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW5xdWV1ZV9kbF9lbnRpdHkNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkbF9zZXJ2ZXJfc3RhcnQNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbnF1ZXVlX3Rhc2tfZmFpcg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVucXVl
dWVfdGFzaw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR0d3VfZG9fYWN0aXZhdGUN
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnlfdG9fd2FrZV91cA0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBsZXRlDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY3B1X3N0b3BwZXJfdGhyZWFkDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c21wYm9vdF90aHJlYWRfZm4NCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdGhyZWFk
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0X2Zyb21fZm9yaw0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldF9mcm9tX2ZvcmtfYXNtDQo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgPC9UQVNLPg0KPiA+ID4gPiANCj4gPiA+ID4gSW5zdGVhZCBvZiBwcm92
aWRpbmcgeWV0IGFub3RoZXIgYmFuZGFpZCB0byB3b3JrIGFyb3VuZCB0aGUNCj4gPiA+ID4gc2l0
dWF0aW9uLA0KPiA+ID4gPiBmaXggaXQgZnJvbSBocnRpbWVycyBpbmZyYXN0cnVjdHVyZSBpbnN0
ZWFkOiBhbHdheXMgbWlncmF0ZQ0KPiA+ID4gPiBhd2F5IGENCj4gPiA+ID4gdGltZXIgdG8gYW4g
b25saW5lIHRhcmdldCB3aGVuZXZlciBpdCBpcyBlbnF1ZXVlZCBmcm9tIGFuDQo+ID4gPiA+IG9m
ZmxpbmUNCj4gPiA+ID4gQ1BVLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyB3aWxsIGFsc28gYWxs
b3cgdG8gcmV2ZXJ0IGFsbCB0aGUgYWJvdmUgUkNVIGRpc2dyYWNlZnVsDQo+ID4gPiA+IGhhY2tz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gUmVwb3J0ZWQtYnk6IFZsYWQgUG9lbmFydSA8dmxhZC53aW5n
QGdtYWlsLmNvbT4NCj4gPiA+ID4gUmVwb3J0ZWQtYnk6IFVzYW1hIEFyaWYgPHVzYW1hYXJpZjY0
MkBnbWFpbC5jb20+DQo+ID4gPiA+IEZpeGVzOiA1YzA5MzBjY2FhZDUgKCJocnRpbWVyczogUHVz
aCBwZW5kaW5nIGhydGltZXJzIGF3YXkgZnJvbQ0KPiA+ID4gPiBvdXRnb2luZyBDUFUgZWFybGll
ciIpDQo+ID4gPiA+IENsb3NlczogMjAyNDEyMTMyMDM3MzkuMTUxOTgwMS0xLXVzYW1hYXJpZjY0
MkBnbWFpbC5jb20NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8
ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGF1bCBFLiBNY0tl
bm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBhc3NlcyBvdmVy
LWhvbGlkYXkgdGVzdGluZyByY3V0b3J0dXJlLCBzbywgcGVyaGFwcw0KPiA+ID4gcmVkdW5kYW50
bHk6DQo+ID4gPiANCj4gPiA+IFRlc3RlZC1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0Br
ZXJuZWwub3JnPg0KPiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IEkgZW5jb3VudGVyZWQgdGhlIHNh
bWUgaXNzdWUgZXZlbiBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLg0KPiA+IEJlbG93IGFyZSB0
aGUgZGV0YWlscyBvZiB0aGUgd2FybmluZyBhbmQgY2FsbCB0cmFjZS4NCj4gPiANCj4gPiANCj4g
PiBtaWdyYXRpb24vMzogLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4g
bWlncmF0aW9uLzM6IFdBUk5JTkc6IENQVTogMyBQSUQ6IDQyIGF0IGtlcm5lbC90aW1lL2hydGlt
ZXIuYzoxMTI1DQo+ID4gZW5xdWV1ZV9ocnRpbWVyKzB4N2MvMHhlYw0KPiA+IG1pZ3JhdGlvbi8z
OiBDUFU6IDMgVUlEOiAwIFBJRDogNDIgQ29tbTogbWlncmF0aW9uLzMgVGFpbnRlZDoNCj4gPiBH
wqDCoMKgwqDCoMKgIA0KPiA+IE9FwqDCoMKgwqDCoCA2LjEyLjE4LWFuZHJvaWQxNi0wLWc1OWNi
NWE4NDliZWItNGsgIzENCj4gPiAwYjQ0MGU0M2ZhN2IyNGFhYTNiN2U2ZTVkMmI5Mzg5NDhlMGNh
Y2RiDQo+ID4gbWlncmF0aW9uLzM6IFN0b3BwZXI6IG11bHRpX2NwdV9zdG9wKzB4MC8weDE4NCA8
LQ0KPiA+IHN0b3BfbWFjaGluZV9jcHVzbG9ja2VkKzB4YzAvMHgxNWMNCj4gDQo+IEl0J3Mgbm90
IHRoZSBmaXJzdCB0aW1lIEkgZ2V0IHN1Y2ggYSByZXBvcnQgb24gYW4gb3V0IG9mIHRyZWUNCj4g
a2VybmVsLiBUaGUgcHJvYmxlbSBpcyBJIGRvbid0IGtub3cgaWYgdGhlIHRhaW50ZWQgbW9kdWxl
cyBhcmUNCj4gaW52b2x2ZWQuIEJ1dCBzb21ldGhpbmcgaXMgcHJvYmFibHkgbWFraW5nIGFuIG9m
ZmxpbmUgQ1BVIHZpc2libGUNCj4gd2l0aGluDQo+IHRoZSBoaWVyYXJjaHkgb24gZ2V0X25vaHpf
dGltZXJfdGFyZ2V0KCkuIEFuZCB0aGF0IG5ldyB3YXJuaW5nIG1hZGUNCj4gdGhhdCB2aXNpYmxl
Lg0KPiANCkhpLA0KDQpCeSByZXZpZXcgdGhlIGdldF9ub2h6X3RpbWVyX3RhcmdldCgpLCBpdCdz
IHByb2JhYmx5IG1ha2luZyBhbiBvZmZsaW5lDQpDUFUgdmlzaWJsZSBhdCB0aW1lciBjYW5kaWRh
dGVzLCBtYXliZSB0aGlzIHBhdGNoIGNvdWxkIGZpeCBpdD8NCg0KDQpbUEFUQ0hdIHNjaGVkL2Nv
cmU6IEV4Y2x1ZGUgb2ZmbGluZSBDUFVzIGZyb20gdGhlIHRpbWVyIGNhbmRpZGF0ZXMNCg0KVGhl
IHRpbWVyIHRhcmdldCBpcyBjaG9zZW4gZnJvbSB0aGUgSEtfVFlQRV9LRVJORUxfTk9JU0UuDQpI
b3dldmVyLHRoZSBjYW5kaWRhdGUgbWF5IGJlIGFuIG9mZmxpbmUgQ1BVLA0Kc28gZXhjbHVkZSBv
ZmZsaW5lIENQVXMgYW5kIGNob29zZSBvbmx5IGZyb20gb25saW5lIENQVXMuDQoNClNpZ25lZC1v
ZmYtYnk6IGt1eW8gY2hhbmcgPGt1eW8uY2hhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQoga2VybmVs
L3NjaGVkL2NvcmUuYyB8IDkgKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMg
Yi9rZXJuZWwvc2NoZWQvY29yZS5jDQppbmRleCBjZmFjYTMwNDBiMmYuLmVmY2MyNTc2ZTYyMiAx
MDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCisrKyBiL2tlcm5lbC9zY2hlZC9jb3Jl
LmMNCkBAIC0xMTgyLDcgKzExODIsNyBAQCBpbnQgZ2V0X25vaHpfdGltZXJfdGFyZ2V0KHZvaWQp
DQogICAgICAgIHN0cnVjdCBzY2hlZF9kb21haW4gKnNkOw0KICAgICAgICBjb25zdCBzdHJ1Y3Qg
Y3B1bWFzayAqaGtfbWFzazsNCg0KLSAgICAgICBpZiAoaG91c2VrZWVwaW5nX2NwdShjcHUsIEhL
X1RZUEVfS0VSTkVMX05PSVNFKSkgew0KKyAgICAgICBpZiAoaG91c2VrZWVwaW5nX2NwdShjcHUs
IEhLX1RZUEVfS0VSTkVMX05PSVNFKSAmJg0KY3B1X29ubGluZShjcHUpKSB7DQogICAgICAgICAg
ICAgICAgaWYgKCFpZGxlX2NwdShjcHUpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IGNwdTsNCiAgICAgICAgICAgICAgICBkZWZhdWx0X2NwdSA9IGNwdTsNCkBAIC0xMTk3LDEzICsx
MTk3LDE2IEBAIGludCBnZXRfbm9oel90aW1lcl90YXJnZXQodm9pZCkNCiAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChjcHUgPT0gaSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQoNCi0gICAgICAgICAgICAgICAgICAgICAgIGlmICghaWRsZV9jcHUoaSkpDQor
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWlkbGVfY3B1KGkpICYmIGNwdV9vbmxpbmUoaSkp
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBpOw0KICAgICAgICAgICAg
ICAgIH0NCiAgICAgICAgfQ0KDQotICAgICAgIGlmIChkZWZhdWx0X2NwdSA9PSAtMSkNCisgICAg
ICAgaWYgKGRlZmF1bHRfY3B1ID09IC0xKSB7DQogICAgICAgICAgICAgICAgZGVmYXVsdF9jcHUg
PQ0KaG91c2VrZWVwaW5nX2FueV9jcHUoSEtfVFlQRV9LRVJORUxfTk9JU0UpOw0KKyAgICAgICAg
ICAgICAgIGlmICghY3B1X29ubGluZShkZWZhdWx0X2NwdSkpDQorICAgICAgICAgICAgICAgICAg
ICAgICBkZWZhdWx0X2NwdSA9IGNwdW1hc2tfYW55KGNwdV9vbmxpbmVfbWFzayk7DQorICAgICAg
IH0NCg0KICAgICAgICByZXR1cm4gZGVmYXVsdF9jcHU7DQogfQ0KPiBDYW4geW91IHRyeSB0aGlz
IGFuZCB0ZWxsIHVzIGlmIHRoZSB3YXJuaW5nIGZpcmVzPw0KPiANCj4gVGhhbmtzLg0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQvbm9oei5oIGIvaW5jbHVkZS9saW51eC9z
Y2hlZC9ub2h6LmgNCj4gaW5kZXggNmQ2N2U5YTVhZjZiLi5mNDk1MTI2MjgyNjkgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQvbm9oei5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgv
c2NoZWQvbm9oei5oDQo+IEBAIC05LDYgKzksNyBAQA0KPiDCoCNpZiBkZWZpbmVkKENPTkZJR19T
TVApICYmIGRlZmluZWQoQ09ORklHX05PX0haX0NPTU1PTikNCj4gwqBleHRlcm4gdm9pZCBub2h6
X2JhbGFuY2VfZW50ZXJfaWRsZShpbnQgY3B1KTsNCj4gwqBleHRlcm4gaW50IGdldF9ub2h6X3Rp
bWVyX3RhcmdldCh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIGFzc2VydF9kb21haW5fb25saW5lKHZv
aWQpOw0KPiDCoCNlbHNlDQo+IMKgc3RhdGljIGlubGluZSB2b2lkIG5vaHpfYmFsYW5jZV9lbnRl
cl9pZGxlKGludCBjcHUpIHsgfQ0KPiDCoCNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2Nw
dS5jIGIva2VybmVsL2NwdS5jDQo+IGluZGV4IDA3NDU1ZDI1MzI5Yy4uOThjOGY4NDA4NDAzIDEw
MDY0NA0KPiAtLS0gYS9rZXJuZWwvY3B1LmMNCj4gKysrIGIva2VybmVsL2NwdS5jDQo+IEBAIC0x
Myw2ICsxMyw3IEBADQo+IMKgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlvbi5oPg0KPiDC
oCNpbmNsdWRlIDxsaW51eC9zY2hlZC90YXNrLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3NjaGVk
L3NtdC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL25vaHouaD4NCj4gwqAjaW5jbHVkZSA8
bGludXgvdW5pc3RkLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiDCoCNpbmNsdWRl
IDxsaW51eC9vb20uaD4NCj4gQEAgLTEyNzcsNiArMTI3OCw3IEBAIHN0YXRpYyBpbnQgdGFrZV9j
cHVfZG93bih2b2lkICpfcGFyYW0pDQo+IMKgCWlmIChlcnIgPCAwKQ0KPiDCoAkJcmV0dXJuIGVy
cjsNCj4gwqANCj4gKwlhc3NlcnRfZG9tYWluX29ubGluZSgpOw0KPiDCoAkvKg0KPiDCoAkgKiBN
dXN0IGJlIGNhbGxlZCBmcm9tIENQVUhQX1RFQVJET1dOX0NQVSwgd2hpY2ggbWVhbnMsIGFzDQo+
IHdlIGFyZSBnb2luZw0KPiDCoAkgKiBkb3duLCB0aGF0IHRoZSBjdXJyZW50IHN0YXRlIGlzIENQ
VUhQX1RFQVJET1dOX0NQVSAtIDEuDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY29yZS5j
IGIva2VybmVsL3NjaGVkL2NvcmUuYw0KPiBpbmRleCAxNzVhNWE3YWMxMDcuLjg4MTU3YjE2NDVj
YyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL2NvcmUuYw0KPiArKysgYi9rZXJuZWwvc2No
ZWQvY29yZS5jDQo+IEBAIC0xMTYzLDYgKzExNjMsMjAgQEAgdm9pZCByZXNjaGVkX2NwdShpbnQg
Y3B1KQ0KPiDCoA0KPiDCoCNpZmRlZiBDT05GSUdfU01QDQo+IMKgI2lmZGVmIENPTkZJR19OT19I
Wl9DT01NT04NCj4gK3ZvaWQgYXNzZXJ0X2RvbWFpbl9vbmxpbmUodm9pZCkNCj4gK3sNCj4gKwlp
bnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiArCWludCBpOw0KPiArCXN0cnVjdCBzY2hl
ZF9kb21haW4gKnNkOw0KPiArDQo+ICsJZ3VhcmQocmN1KSgpOw0KPiArDQo+ICsJZm9yX2VhY2hf
ZG9tYWluKGNwdSwgc2QpIHsNCj4gKwkJZm9yX2VhY2hfY3B1KGksIHNjaGVkX2RvbWFpbl9zcGFu
KHNkKSkgew0KPiArCQkJV0FSTl9PTl9PTkNFKGNwdV9pc19vZmZsaW5lKGkpKTsNCj4gKwkJfQ0K
PiArCX0NCj4gK30NCj4gwqAvKg0KPiDCoCAqIEluIHRoZSBzZW1pIGlkbGUgY2FzZSwgdXNlIHRo
ZSBuZWFyZXN0IGJ1c3kgQ1BVIGZvciBtaWdyYXRpbmcNCj4gdGltZXJzDQo+IMKgICogZnJvbSBh
biBpZGxlIENQVS7CoCBUaGlzIGlzIGdvb2QgZm9yIHBvd2VyLXNhdmluZ3MuDQoNCg==

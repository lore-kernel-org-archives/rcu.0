Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C2221F04;
	Fri, 18 Jul 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829849; cv=fail; b=m/TxJT9ZsxmfEbVQCkEnO4gC/WvpUCqo6r9uqyrZ5OjxEBYxWWew3JRYLJcL+XijvrjhHN/ViK7aSj0yYuQGR3DDyxRDO2S9dyvo4ncbMo9B9FlFu5Jq+fFlXszyR2Bf6h2/4oh0GdsBkwbRm8poTxCWYsFngqRBzUb97r99qCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829849; c=relaxed/simple;
	bh=jj/0BA3dRLxjyiPxAKSJHOM1HSWg3ixWbBLRrq5WHvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEn9D14dbzRMYSq0ZayZD0suLKGvmHaSySVmiKlQyUsdZ4u94cy4J4K5TnU98lFkUjAfVMZC1PF6DpI3S2CZky3cH+BjK8NujMVR/BAVbFyzk3Kw0pnBZO/NkaAGHyVUwZ0x3k4M1Gt569Mkm4vk22BsUM/cb0gnIZYEas+D4nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SU2/ZSVK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=U7m1lUAO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SU2/ZSVK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="U7m1lUAO"
X-UUID: 142ef0c463b711f0b33aeb1e7f16c2b6-20250718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jj/0BA3dRLxjyiPxAKSJHOM1HSWg3ixWbBLRrq5WHvU=;
	b=SU2/ZSVKyRhNuz/nSN7hf/OEAoWBTc0+wb+setOHEViN24qJGNh2YFafKgL3y4NrgQ7Jm30GAXrF2Ee9bN9I3AbXZOgtDQ610jkZJn1vUPoUvLhztFfQNbpWNI77C2JDrxPgoZdBoVxqboDaYGVv25r+3DSubVPmKwd57rHFv1A=;
X-CID-CACHE: Type:Local,Time:202507181710+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:821d9d37-d519-4e40-8c35-b170dab764c1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:76fa2673-f565-4a89-86be-304708e7ad47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 142ef0c463b711f0b33aeb1e7f16c2b6-20250718
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 854747901; Fri, 18 Jul 2025 17:10:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 18 Jul 2025 17:10:35 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 18 Jul 2025 17:10:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivyA8FcNzfUSsX84Vc/pGQWhCzwyQRAWdA//xKviCq50ioiuyyU1boUSRm0Q0kvlr7euRjsokdrlhZ0QOn2BOdXJ+P6oN6llX77msnQtrmI+zrHYfGNEfKn4R8aMIJZMkZf1alGnecvQ5aifmdj8WwobHWoXvGmzI3j4yFOkSAoZpPJ44hkwCAuchbpCwSljZf7hG97O912ncYjQ8IekbCevN1KyyFOKXBeGTunjyRchc8b6Fimgog2LqjuGauXSoNet3CL4s+6XJmcxKNNxsGVqllrjk5Md1/vfq97KM+QlKeCh3SAhgTKIh1UotWcPNJPKjIugfYvaAIiknDhpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj/0BA3dRLxjyiPxAKSJHOM1HSWg3ixWbBLRrq5WHvU=;
 b=mQAlXi2ypM2LiyTPxIwDr6f7KKqnzEY3NaHO7Gxz7GZVloCIkr6TyOfkZwQG1HAWRQx3ONjsFUqnTUoNVHqHuintCNMnXI6+36ktOWGsRbX66wBEj4vzRv85I3oTU9BdueH7Fbt6DTgdIYJ4y8miNPKr0qQWDe5K7dQRMatLB/qbSElcYrkMv7HE1lJLzYa31tLsuonfD7xq/0IklGwJ3whC8dV9CKtzONXfitb7dk3ZrOnikYNhfioXqoNKKlMJDc9+3vYXpCgU19kTyYBJA/58U3hFD2kl1ec0yufugECrZH/6TwSYiOJ6nHhwfh0oDHBe7BpJNxh5Kf5KIPk0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj/0BA3dRLxjyiPxAKSJHOM1HSWg3ixWbBLRrq5WHvU=;
 b=U7m1lUAOkn0EKXAfz8qbKianOWl1StHctqngglCV0snv70TU4TXKOlG9LwUgbSuOR/zhX6V9WX1jcn2vimQErUlnbnzzEI2behLsaEI96XI2EF6zfDC/O1P+q8IhrzcMbO698il1PYFbv5+lbos9I7mAD85u1OJ2LOsxmvL2+BY=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by SEZPR03MB7589.apcprd03.prod.outlook.com (2603:1096:101:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 09:10:33 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%3]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 09:10:32 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>
CC: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"weiyangyang@vivo.com" <weiyangyang@vivo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, =?utf-8?B?TG9ycnkgTHVvICjnvZfno4op?=
	<Lorry.Luo@mediatek.com>, =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?=
	<bobule.chang@mediatek.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "joelagnelf@nvidia.com"
	<joelagnelf@nvidia.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] rcu: Fix delayed execution of hurry callbacks
Thread-Topic: [PATCH] rcu: Fix delayed execution of hurry callbacks
Thread-Index: AQHb9t9raNmcFZGwikqNUlcFsD7Q4rQ2UWAAgAFIgIA=
Date: Fri, 18 Jul 2025 09:10:32 +0000
Message-ID: <2c69ead1047ff7b7671b8b577fe69884870f66fd.camel@mediatek.com>
References: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
	 <aHj79rtgLm-7tT9E@localhost.localdomain>
In-Reply-To: <aHj79rtgLm-7tT9E@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|SEZPR03MB7589:EE_
x-ms-office365-filtering-correlation-id: db16ea25-8531-4053-6548-08ddc5daf2e3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXdoS3VTRUFPdmljV2sya2xyNUxPZ2pGaE9Da1ZQQ3FMaXBVV3BVUzFLRW11?=
 =?utf-8?B?eS8rb29DMW9ZY1JuWTBxbmM5aGNhdkVjNi9nc2lKQ0g3M3BkTWYxN01KSXpk?=
 =?utf-8?B?a09VWS9QNFowbi9ET09aMHdjSlB6NUlOZ0tGVkFpNGpoRFcrdTFXYXh2ZlYv?=
 =?utf-8?B?UjBkbTVpMWJpMXJ2ZTA5V3RXbGxGeDFNKzdHdXZGU2pSUmdvcUNwTDhiNzRH?=
 =?utf-8?B?ci92QkIrayt2M0IxRStrUTZBcWdOTkRXa2ZrWXBraFNRQ0h4UVdCZllyNzRq?=
 =?utf-8?B?MTY3Y2JzeHFoK1J6VVFlbWxSTE9EaUY3dkVEWEhxL2FOeXdWZjZPaG01bDho?=
 =?utf-8?B?bENabWNrOXlXbnFpK1kzVzBteDJMWWNJeEpJMk1vTjZmdkRVclhqRHdUWC9k?=
 =?utf-8?B?ZkxIcGhBVC9xa0F4L00xSWJIMTJSeTBUU05EYW1LbVVMVnl0VkIzUTVLelFG?=
 =?utf-8?B?T2k4RFdsVDU1R200TVBUTk04aXl2SXVRTnBoL1FrS1JLZThVVzAwMkNLSEhy?=
 =?utf-8?B?UzdUQUtVWHdiejBydEZtUGhrZ2MrU1U3VmkwT2pnakdyOHdPR25DeTBUdlBu?=
 =?utf-8?B?aG5Fa0g0ekhqRlJJUUxJTFZVNnFBRVFQcDI5cU96aTZEdGk2S081WlllUldu?=
 =?utf-8?B?UllaTURoY1RQdjM1VXBHVFlSMWZzSVBlQXhtU0hudy9FK1BLMGFPSWJLOEtR?=
 =?utf-8?B?aFhGZk1wak5UVmNqWFQ1a2ZXcVJWb0pReTJtbHlQcSsrYzBRNVRSMy8rWnN0?=
 =?utf-8?B?bXBBS3AycjVVVjhGc3FoZlNMcUhEMnM4VkI0Y3RueUd6VDhJOUhUUkFaRkdJ?=
 =?utf-8?B?QnJMeG03ZktOQ1NpMGkreEI0U1ZJM0p0Zi9LMk1ldmdVMkFQc2hodlFNQU1E?=
 =?utf-8?B?WE0zN0MyY2F6a05KUUtXRVhHMmJNbXNtdEtZUzU2U3MzTXZGZTVTZkFoaWgw?=
 =?utf-8?B?dW1GbnorTVpBMWVEQms5UWhQbjJFQTI5UHI1SHI4aEFjeC9HekgzV1NqSEVC?=
 =?utf-8?B?bXJhNWxJY1RpN2hzYUgxSk9DdGJZN1QwRkRiUi9jaGNDM2RjQUgwRWFlcCts?=
 =?utf-8?B?TzdlcDN2MlcxTFpJRU1ZMU52UTdSYzlJYlN5d3hIRGVsRi9QUkdlVVp4aFJY?=
 =?utf-8?B?RFYyQjZkd2R5cjBZcitFUFp1N2Z0UHdHekpoZWFlSnhUNGtnNXo4SDZSTUNW?=
 =?utf-8?B?Y2xrZ2dqUXpPTkszR0szRlZGcWRWbWlMd3NEMHlWdkdBaXNTZTZtRDRWWUM5?=
 =?utf-8?B?SmNEeld4RHZrSTNYTUM1NDNPL1lOL3dyUGI2YmxNTnBOSGhscTZDQ1RRNWFt?=
 =?utf-8?B?cW5MT2tVTlBKR2NmUzUzQjZneGFHaFZiRmUvVHRiMVVIYmtKUDJUK1d1VThD?=
 =?utf-8?B?b29CRzcwVUxUazZ1djhHbDJkRlZWcVRGUnhaanFNNVMrSUtwRklGSGF2UW93?=
 =?utf-8?B?aEdoQzNKcmFaQ0MwS083UFhFcVN1NHZaOU9IdGtBRFgvekZjd2ptRkFpTzlz?=
 =?utf-8?B?SlhoK2N2TjZ2Ny92S1h2NURXU1ErNmxLZjhDNkVwWlZSM0djWXB6V3lmN2xw?=
 =?utf-8?B?VHluNkxYdWNKWXk2QVEvbmxDNW5IUFRZMndZd2V2cHNoZHlOaG9aTllwa0Z3?=
 =?utf-8?B?Mm56QkgwWmszR0U2bTdmZzltV0tBMXo4YVNEOUNvZ1FWWVZNS3l5aDhlWnQv?=
 =?utf-8?B?OVFQblp2ZEdXVUYrTVJRWGxPMVNPTnRtb2pSYlNhbHh2U3VCOUZRTnF1Y1BE?=
 =?utf-8?B?MHg4bjc2NVk1YndGa2I0RjV6L2UxcnRqT2tieEdZM3d4bkJLZDBhTFFaWXpF?=
 =?utf-8?B?N2xiSGNVUS94bm5LSEV0TURDcFJDRjRSYjNQWEZVNDdMZGg4T2pGbEo2SWVv?=
 =?utf-8?B?QVV2Q2dQMm1KZENmZkRxS3Z2V0gvOFB6UEE3U1ZnN2VkcnY4MFREZHpiYjYx?=
 =?utf-8?B?OTRUbS9pVjdLaEFHeXVZTW1lMTl0aS9GQ0c2MmFwdHBqMFNHLzEraGZEMGNr?=
 =?utf-8?B?U2FJbzJXMG53PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG13eDVpaUYxUTdTdXNqRFlMY1dyVUVROGZaQ1phRXNGcVJmNHU0UVFjWjc3?=
 =?utf-8?B?aXVMb1Fiamd4YjlNdGdaMEErRzc0UFlkN0VLVVVkcjRlbzVVcDA5RnJmSGtF?=
 =?utf-8?B?bUJWang2QVRIYVBJMUJSNVJ1REg1R3NtZjhrNUgxYnlIUWQ0dVN4MTRvZnF1?=
 =?utf-8?B?c3JUVVNzVUYzTFBDcFpFK1JrK2U5aGl1eEpZOGhGTFM4ejhsaGNDVkQvMS9L?=
 =?utf-8?B?azZjNUd2UlBKbHRrY3RmSGFpY1hNOTljdnBVWFpQYy9NVEtIYmdZNk16T2RC?=
 =?utf-8?B?QTA4RG9zOXZXWkp2SE11cU9MVnE3OEh6c0YzbEVOdk5oYnROVDlETE9yUE1G?=
 =?utf-8?B?M1Z5a1YrSWMwdnhSbmtqWWJHVGYyYlN5dVk0citEb3ZCV0xhcC96L2pQbkNG?=
 =?utf-8?B?YytMZEYwc2lRTUxFSG1BR1N1Y0VGSGxkRUJSWmJLaVRDdWhuRVBqY0s5ejNQ?=
 =?utf-8?B?OWp0NFNIS3dQYlQvckE0MEZVYTdQYWQyWDRHTWw5MnUxQW9yU25kMVk3MG82?=
 =?utf-8?B?SG96bWJyREZOUGdzMnh4ZTJiVTY3dnEvalpPUDVGUDNqWnJ5aGVUL2c4amQ5?=
 =?utf-8?B?MGdXUmR0bW5XZURJWW9MZGNPNFNsMEVxY3FtcCtTd0dRUkZBKzVDRnkvd0J3?=
 =?utf-8?B?TGk4dUlxdXNLQlc0bUhSWmtzM2VZNjBBV21ma1hGRmhHdk9UL2w5NmtjcFdi?=
 =?utf-8?B?V3JZSWdONjBvU2kvdFJqOHl2WjVjRVF4b0NsYWlOVHVucUp6cDA4OXN6Mzcx?=
 =?utf-8?B?RU5keXRkVm5pSW1FSENIWEY2eGZPblF4UFgyeVRIY1dHWnpCTHArRnFyN2ZO?=
 =?utf-8?B?NDBaVm9FWE1YcGk5eW90OTk0eXZWc2lONUxTL2hBdTRpNk1hS1QxRVdzZUgy?=
 =?utf-8?B?TTFHVXgyODUrbDd0bDh6cE8rdGVFQy9Eck5ITlVFK3hTb1hIcXFZRzQ4N3pC?=
 =?utf-8?B?M2VFMzc5dFFnTlZ6T3lLbXpJMHdEOXJtT3NEREJCYVI5L1RRdmlvR3hpbXJr?=
 =?utf-8?B?TklxcGJGeTZueUFnYmZncEI3NkU4N2haN1RFQVNtSGNRSEozY1JRb3FVWEVo?=
 =?utf-8?B?V0tOL2NLaGdhYVZLeVoxTmFlbDd2d2hkZWZnY3ZXeVAwVERDTytyQ0tmem5C?=
 =?utf-8?B?dU9WS0gvWUpmcHpxdlZVdU9YTVFqcER5VXNNMTZHMktkQ0RkamFiTzl3SFJi?=
 =?utf-8?B?Nmw3MzZrTVlLbTBnNEVQdW5mTlJCZlZlV0JXZWJxNnVHZTdUdkJVV1RKRUdB?=
 =?utf-8?B?Z05vaWE5UVdJRERZVTFmVlZabW5ETllOZEVwN3BURkVHcURoajRhbHE3N0Jl?=
 =?utf-8?B?VTZBZ1dDY0tWVXVPN0E1b1Y0S0dJS2E1UWFCOEVjZDZNOU15dXRlKzRrY1lY?=
 =?utf-8?B?R2dJdDFNWnNXeEdTZXN5cmVSb0FqWVRlSkd0RUFQeGdpL2FYOG90SVNZbjkw?=
 =?utf-8?B?Ylh6dFpQMk5xNGVjMzdnY0N4ZFVCdklZSzduRklhdjlCRW0wWityVTF5a2Ix?=
 =?utf-8?B?bmdEdGYyWGZUSVVKd1JZYlorUUtRbk5VYWwyd0d5ajhFSGZsL1FJY2J6d1Ji?=
 =?utf-8?B?YXlGdDVBNWpKZkd3T2pzSWFzenpFb21udDY0bmthMEtOM3FVVVFrbldjQ0Mr?=
 =?utf-8?B?SksrVjNrQkhmOFkreDVNMFpCZkRyWWhIS2VKNUNlZHIvK2llTHU2UFJHU3Zn?=
 =?utf-8?B?enBhYnRtU1JLaFJrZWsvTzBvUk4xaUpUaEVLVW4zQnF4N0ZQZVEycTFkMHU1?=
 =?utf-8?B?aVFaVUkyYzBKL0dkNERNMmJsenNZQnFTc3BweURwMWlWU2dXa1h4UG1QTGE2?=
 =?utf-8?B?NkZRdmRXV1VaMndGclh3aHd2NGlGSlB6bDZIZllKTVpGZSsyOFFwQUM0QXc2?=
 =?utf-8?B?dzM3SW4zZEYyMVFSeldvQmVXTnlVV0JpK0x4eGU0QzFLVmQwa3VjSDJQSXBK?=
 =?utf-8?B?ZGtmTWhOYkdWRUpROGxEVTVaK0hQQ2hvS0dxM3ZiUExHNzBJY0pvbkk2VitE?=
 =?utf-8?B?emhDV1V3azdSZWFGMDVFQVVGTkVXeUZFcFBoTjI4MXFVbHlrcjVFa0VxWllh?=
 =?utf-8?B?RmFvZ09mcHExNlJnVXVzcysxYTRtWmZVRHRkeExTZWNPR250ZlhCU1dXNzEr?=
 =?utf-8?B?WUNTSUVuV2FaWk5SVTJNSlJIamk2Q2RKZk91M2ZNWG4yTzlJa1lwUjM1eE94?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <188600157B4E6F4480C37EE74C0A7F4B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db16ea25-8531-4053-6548-08ddc5daf2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 09:10:32.4705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sabjORMbWlrZl21iReLIKUEPKaDLCpDTMUUpv86lb9TCAMvmcFjfRS0Kb1b6gccwQq0BPwop/kSmS/hJeS44Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7589

T24gVGh1LCAyMDI1LTA3LTE3IGF0IDE1OjM0ICswMjAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBMZSBUaHUsIEp1bCAxNywgMjAyNSBhdCAwMTo1Mzoz
OFBNICswODAwLCBUemUtbmFuIFd1IGEgw6ljcml0IDoNCj4gPiBXZSBvYnNlcnZlZCBhIHJlZ3Jl
c3Npb24gaW4gb3VyIGN1c3RvbWVy4oCZcyBlbnZpcm9ubWVudCBhZnRlcg0KPiA+IGVuYWJsaW5n
DQo+ID4gQ09ORklHX0xBWllfUkNVLiBJbiB0aGUgQW5kcm9pZCBVcGRhdGUgRW5naW5lIHNjZW5h
cmlvLCB3aGVyZQ0KPiA+IGlvY3RsKCkgaXMNCj4gPiB1c2VkIGhlYXZpbHksIHdlIGZvdW5kIHRo
YXQgY2FsbGJhY2tzIHF1ZXVlZCB2aWEgY2FsbF9yY3VfaHVycnkNCj4gPiAoc3VjaCBhcw0KPiA+
IHBlcmNwdV9yZWZfc3dpdGNoX3RvX2F0b21pY19yY3UpIGNhbiBzb21ldGltZXMgYmUgZGVsYXll
ZCBieSB1cCB0bw0KPiA+IDUNCj4gPiBzZWNvbmRzIGJlZm9yZSBleGVjdXRpb24uIFRoaXMgb2Nj
dXJzIGJlY2F1c2UgdGhlIG5ldyBncmFjZSBwZXJpb2QNCj4gPiBkb2VzDQo+ID4gbm90IHN0YXJ0
IGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBwcmV2aW91cyBvbmUgY29tcGxldGVzLg0KPiA+IA0KPiA+
IFRoZSByb290IGNhdXNlIGlzIHRoYXQgdGhlIHdha2Vfbm9jYl9ncF9kZWZlcigpIGZ1bmN0aW9u
IG5vdyBjaGVja3MNCj4gPiAicmRwLT5ub2NiX2RlZmVyX3dha2V1cCIgaW5zdGVhZCBvZiAicmRw
X2dwLT5ub2NiX2RlZmVyX3dha2V1cCIuIE9uDQo+ID4gQ1BVcw0KPiA+IHRoYXQgYXJlIG5vdCBy
Y3VvZywgInJkcC0+bm9jYl9kZWZlcl93YWtldXAiIG1heSBhbHdheXMgYmUNCj4gPiBSQ1VfTk9D
Ql9XQUtFX05PVC4gVGhpcyBjYW4gY2F1c2UgInJkcF9ncC0+bm9jYl9kZWZlcl93YWtldXAiIHRv
IGJlDQo+ID4gZG93bmdyYWRlZCBhbmQgdGhlICJyZHBfZ3AtPm5vY2JfdGltZXIiIHRvIGJlIHBv
c3Rwb25lZCBieSB1cCB0byAxMA0KPiA+IHNlY29uZHMsIGRlbGF5aW5nIHRoZSBleGVjdXRpb24g
b2YgaHVycnkgUkNVIGNhbGxiYWNrcy4NCj4gPiANCj4gPiBUaGUgdHJhY2UgbG9nIG9mIG9uZSBz
Y2VuYXJpbyB3ZSBlbmNvdW50ZXJlZCBpcyBhcyBmb2xsb3c6DQo+ID4gwqAgLy8gcHJldmlvdXMg
R1AgZW5kcyBhdCB0aGlzIHBvaW50DQo+ID4gwqAgcmN1X3ByZWVtcHTCoMKgIFswMDBdIGQuLjEu
wqDCoCAxMzcuMjQwMjEwOiByY3VfZ3JhY2VfcGVyaW9kOg0KPiA+IHJjdV9wcmVlbXB0IDgzNjkg
ZW5kDQo+ID4gwqAgcmN1X3ByZWVtcHTCoMKgIFswMDBdIC4uLi4uwqDCoCAxMzcuMjQwMjEyOiBy
Y3VfZ3JhY2VfcGVyaW9kOg0KPiA+IHJjdV9wcmVlbXB0IDgzNzIgcmVxd2FpdA0KPiA+IMKgIC8v
IGNhbGxfcmN1X2h1cnJ5IGVucXVldWVzICJwZXJjcHVfcmVmX3N3aXRjaF90b19hdG9taWNfcmN1
IiwgdGhlDQo+ID4gY2FsbGJhY2sgd2FpdGVkIG9uIGJ5IFVwZGF0ZUVuZ2luZQ0KPiA+IMKgIHVw
ZGF0ZV9lbmdpbmUgWzAwMl0gZC4uMS7CoMKgIDEzNy4zMDE1OTM6IF9fY2FsbF9yY3VfY29tbW9u
OiB3eXk6DQo+ID4gdW5saWtlbHkgcF9yZWYgPSAwMDAwMDAwMCoqKioqKioqLiBsYXp5ID0gMA0K
PiA+IMKgIC8vIEZpcnN0USBvbiBjcHUgMiByZHBfZ3AtPm5vY2JfdGltZXIgaXMgc2V0IHRvIGZp
cmUgYWZ0ZXIgMQ0KPiA+IGppZmZ5ICg0bXMpDQo+ID4gwqAgLy8gYW5kIHRoZSByZHBfZ3AtPm5v
Y2JfZGVmZXJfd2FrZXVwIGlzIHNldCB0byBSQ1VfTk9DQl9XQUtFDQo+ID4gwqAgdXBkYXRlX2Vu
Z2luZSBbMDAyXSBkLi4yLsKgwqAgMTM3LjMwMTU5NTogcmN1X25vY2Jfd2FrZToNCj4gPiByY3Vf
cHJlZW1wdCAyIEZpcnN0USBvbiBjcHUyIHdpdGggcmRwX2dwIChjcHUwKS4NCj4gPiDCoCAvLyBG
aXJzdEJRIGV2ZW50IG9uIGNwdTIgZHVyaW5nIHRoZSAxIGppZmZ5LCBtYWtlIHRoZSB0aW1lcg0K
PiA+IHBvc3Rwb25kIDEwIHNlY29uZHMgbGF0ZXIuDQo+ID4gwqAgLy8gYWxzbywgdGhlIHJkcF9n
cC0+bm9jYl9kZWZlcl93YWtldXAgaXMgb3ZlcndyaXRlIHRvDQo+ID4gUkNVX05PQ0JfV0FLRV9M
QVpZDQo+ID4gwqAgdXBkYXRlX2VuZ2luZSBbMDAyXSBkLi4xLsKgwqAgMTM3LjMwMTYwMTogcmN1
X25vY2Jfd2FrZToNCj4gPiByY3VfcHJlZW1wdCAyIFdha2VFbXB0eUlzRGVmZXJyZWQNCj4gPiDC
oCAuLi4NCj4gPiDCoCAuLi4NCj4gPiDCoCAuLi4NCj4gPiDCoCAvLyBiZWZvcmUgdGhlIDEwIHNl
Y29uZHMgdGltZW91dCwgY3B1MCByZWNlaXZlZCBhbm90aGVyDQo+ID4gY2FsbF9yY3VfaHVycnkN
Cj4gPiDCoCAvLyByZXNldCB0aGUgdGltZXIgdG8gamlmZmllcysxIGFuZCBzZXQgdGhlIHdha2V0
eXBlID0NCj4gPiBSQ1VfTk9DQl9XQUtFLg0KPiA+IMKgIGt3b3JrZXIvdTMyOjAgWzAwMF0gZC4u
Mi7CoMKgIDE0Mi41NTc1NjQ6IHJjdV9ub2NiX3dha2U6DQo+ID4gcmN1X3ByZWVtcHQgMCBGaXJz
dFENCj4gPiDCoCBrd29ya2VyL3UzMjowIFswMDBdIGQuLjEuwqDCoCAxNDIuNTU3NTc2OiByY3Vf
bm9jYl93YWtlOg0KPiA+IHJjdV9wcmVlbXB0IDAgV2FrZUVtcHR5SXNEZWZlcnJlZA0KPiA+IMKg
IGt3b3JrZXIvdTMyOjAgWzAwMF0gZC4uMS7CoMKgIDE0Mi41NTgyOTY6IHJjdV9ub2NiX3dha2U6
DQo+ID4gcmN1X3ByZWVtcHQgMCBXYWtlTm90DQo+ID4gwqAga3dvcmtlci91MzI6MCBbMDAwXSBk
Li4xLsKgwqAgMTQyLjU1ODU2MjogcmN1X25vY2Jfd2FrZToNCj4gPiByY3VfcHJlZW1wdCAwIFdh
a2VOb3QNCj4gPiDCoCAvLyBpZGxlKGRvX25vY2JfZGVmZXJyZWRfd2FrZXVwKSB3YWtlIHJjdW9n
IGR1ZSB0byB3YWtldHlwZSA9PQ0KPiA+IFJDVV9OT0NCX1dBS0UNCj4gPiDCoCA8aWRsZT7CoMKg
wqDCoMKgwqDCoCBbMDAwXSBkLi4xLsKgwqAgMTQyLjU1ODc4NjogcmN1X25vY2Jfd2FrZToNCj4g
PiByY3VfcHJlZW1wdCAwIERvV2FrZQ0KPiA+IMKgIDxpZGxlPsKgwqDCoMKgwqDCoMKgIFswMDBd
IGROLjEuwqDCoCAxNDIuNTU4ODM5OiByY3Vfbm9jYl93YWtlOg0KPiA+IHJjdV9wcmVlbXB0IDAg
RGVmZXJyZWRXYWtlDQo+ID4gwqAgcmN1b2cvMMKgwqDCoMKgwqDCoCBbMDAwXSAuLi4uLsKgwqAg
MTQyLjU1ODg3MTogcmN1X25vY2Jfd2FrZToNCj4gPiByY3VfcHJlZW1wdCAwIEVuZFNsZWVwDQo+
ID4gwqAgcmN1b2cvMMKgwqDCoMKgwqDCoCBbMDAwXSAuLi4uLsKgwqAgMTQyLjU1ODg3NzogcmN1
X25vY2Jfd2FrZToNCj4gPiByY3VfcHJlZW1wdCAwIENoZWNrDQo+ID4gwqAgLy8gZmluYWxseSBy
Y3VvZyByZXF1ZXN0IGEgbmV3IEdQIGF0IHRoaXMgcG9pbnQgKDUgc2Vjb25kcyBhZnRlcg0KPiA+
IHRoZSBGaXJzdFEgZXZlbnQpDQo+ID4gwqAgcmN1b2cvMMKgwqDCoMKgwqDCoCBbMDAwXSBkLi4y
LsKgwqAgMTQyLjU1ODg4NjogcmN1X2dyYWNlX3BlcmlvZDoNCj4gPiByY3VfcHJlZW1wdCA4Mzcy
IG5ld3JlcQ0KPiA+IMKgIHJjdV9wcmVlbXB0wqDCoCBbMDAxXSBkLi4xLsKgwqAgMTQyLjU1OTQ1
ODogcmN1X2dyYWNlX3BlcmlvZDoNCj4gPiByY3VfcHJlZW1wdCA4MzczIHN0YXJ0DQo+ID4gwqAg
Li4uDQo+ID4gwqAgcmN1X3ByZWVtcHTCoMKgIFswMDBdIGQuLjEuwqDCoCAxNDIuNTY0MjU4OiBy
Y3VfZ3JhY2VfcGVyaW9kOg0KPiA+IHJjdV9wcmVlbXB0IDgzNzMgZW5kDQo+ID4gwqAgcmN1b3Av
MsKgwqDCoMKgwqDCoCBbMDAwXSBELi4xLsKgwqAgMTQyLjU2NjMzNzogcmN1X2JhdGNoX3N0YXJ0
Og0KPiA+IHJjdV9wcmVlbXB0IENCcz0yMTkgYmw9MTANCj4gPiDCoCAvLyB0aGUgaHVycnkgQ0Ig
aXMgaW52b2tlZCBhdCB0aGlzIHBvaW50DQo+ID4gwqAgcmN1b3AvMsKgwqDCoMKgwqDCoCBbMDAw
XSBiLi4uLsKgwqAgMTQyLjU2NjM1MjoNCj4gPiBibGtfcXVldWVfdXNhZ2VfY291bnRlcl9yZWxl
YXNlOiB3eXk6IHdha2V1cC4gcF9yZWYgPQ0KPiA+IDAwMDAwMDAwKioqKioqKiouDQo+ID4gDQo+
ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBjb25kaXRpb24gdG8gY2hlY2sgInJkcF9ncC0NCj4g
PiA+bm9jYl9kZWZlcl93YWtldXAiIGluDQo+ID4gdGhlIGxhenkgcGF0aC4gVGhpcyBwcmV2ZW50
cyBhbiBhbHJlYWR5IHNjaGVkdWxlZCAicmRwX2dwLQ0KPiA+ID5ub2NiX3RpbWVyIg0KPiA+IGZy
b20gYmVpbmcgcG9zdHBvbmVkIGFuZCBhdm9pZHMgb3ZlcndyaXRpbmcgInJkcF9ncC0NCj4gPiA+
bm9jYl9kZWZlcl93YWtldXAiDQo+ID4gd2hlbiBpdCBpcyBub3QgUkNVX05PQ0JfV0FLRV9OT1Qu
DQo+ID4gDQo+ID4gRml4ZXM6IDNjYjI3OGU3M2JlNSAoInJjdTogTWFrZSBjYWxsX3JjdSgpIGxh
enkgdG8gc2F2ZSBwb3dlciIpDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBDaGVuZy1qdWkgV2FuZyA8
Y2hlbmctanVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nLWp1
aSBXYW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5
OiBMb3JyeS5MdW9AbWVkaWF0ZWsuY29tDQo+ID4gU2lnbmVkLW9mZi1ieTogTG9ycnkuTHVvQG1l
ZGlhdGVrLmNvbQ0KPiA+IFRlc3RlZC1ieTogd2VpeWFuZ3lhbmdAdml2by5jb20NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiB3ZWl5YW5neWFuZ0B2aXZvLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFR6ZS1u
YW4gV3UgPFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IFRoZSByZWdyZXNz
aW9uIGlzIGZpcnN0IG9ic2VydmVkIGJ5IHd5eSBpbiB0aGUgVXBkYXRlIEVuZ2luZQ0KPiA+IHNj
ZW5hcmlvDQo+ID4gd2l0aMKgIENPTkZJR19MQVpZX1JDVSBlbmFibGVkLiB0aGVyZSBpcyBhbiBh
ZGRpdGlvbmFsIGRlbGF5IG9mIDTigJM1DQo+ID4gc2Vjb25kcyBkdXJpbmcgdGhlIGhlYXZ5IGlv
Y3RsIEFQSSBjYWxsLCB3YWl0aW5nIGZvcg0KPiA+IHBlcmNwdV9yZWZfc3dpdGNoX3RvX2F0b21p
Y19yY3UgKFJDVSBodXJyeSBDQikgdG8gY29tcGxldGUuDQo+ID4gDQo+ID4gSW5pdGlhbGx5LCB3
ZSBzdXNwZWN0ZWQgdGhhdCB0aGUgcGVyY3B1X3JlZl9zd2l0Y2hfdG9fYXRvbWljX3JjdQ0KPiA+
IGZ1bmN0aW9uIGl0c2VsZiB3YXMgdGFraW5nIHRvbyBsb25nLiBIb3dldmVyLCBhZnRlciBlbmFi
bGluZyBzb21lDQo+ID4gY3VzdG9tZSBhbmQgdGhlIGZvbGxvd2luZyB0cmFjZSBldmVudHM6IHJj
dV9kb19iYXRjaCwNCj4gPiByY3Vfbm9jYl93YWtlLCBhbmQNCj4gPiByY3VfZ3JhY2VfcGVyaW9k
LiB3ZSBmb3VuZCB0aGF0IHRoZSByb290IGNhdXNlIHdhcyB0aGF0IHJjdW9nIHdhcw0KPiA+IG5v
dA0KPiA+IGJlaW5nIHdva2VuIHVwIGluIHRpbWUgdG8gcmVxdWVzdCBhIG5ldyBHUC4gVGhpcyBs
ZWQgdG8gdGhlIGRlbGF5DQo+ID4gaW4NCj4gPiBpbnZva2luZyB0aGUgaHVycnkgUkNVIGNhbGxi
YWNrIChwZXJjcHVfcmVmX3N3aXRjaF90b19hdG9taWNfcmN1KS4NCj4gPiANCj4gPiBFbnZpcm9u
bWVudDoNCj4gPiDCoCBBbmRyb2lkLTE2LCBLZXJuZWw6IDYuMTIsIDggQ1BVcyAoQVJNKQ0KPiA+
IA0KPiA+IENvbmZpZ3VyYXRpb246DQo+ID4gwqAgQ09ORklHX1RSRUVfUkNVPXkNCj4gPiDCoCBD
T05GSUdfUFJFRU1QVF9SQ1U9eQ0KPiA+IMKgIENPTkZJR19MQVpZX1JDVT15DQo+ID4gwqAgQ09O
RklHX1JDVV9OT0NCX0NQVT15DQo+ID4gwqAgQ09ORklHX1JDVV9OT0NCX0NQVV9ERUZBVUxUX0FM
TD15DQo+ID4gwqAgcmN1X25vY2JfZ3Bfc3RyaWRlID0gLTEgKGRlZmF1bHQgaXMgNCBmb3IgOCBj
b3JlcykNCj4gPiDCoCBqaWZmaWVzX2xhenlfZmx1c2ggPSAxMCAqIEhaDQo+ID4gDQo+ID4gQ29u
dHJpYnV0aW9uczoNCj4gPiBUemUtTmFuIFd1Og0KPiA+IENvbGxhYm9yYXRlZCB3aXRoIENoZW5n
LUp1aSB0byBkaXNjdXNzIHdoaWNoIHRyYWNlcG9pbnRzIG5lZWRlZCB0bw0KPiA+IGJlDQo+ID4g
YWRkZWQsIGpvaW50bHkgYW5hbHl6ZWQgdGhlIHRyYWNlIGxvZ3MsIGlkZW50aWZpZWQgdGhlIHJv
b3QgY2F1c2UsDQo+ID4gYW5kDQo+ID4gcHJvcG9zZWQgdGhpcyB1cHN0cmVhbSBjaGFuZ2UuDQo+
ID4gDQo+ID4gQ2hlbmctSnVpIFdhbmc6DQo+ID4gUHJvdmlkZWQgbWFueSB2YWx1YWJsZSBzdWdn
ZXN0aW9ucyBkdXJpbmcgdGhlIGRlYnVnZ2luZyBwcm9jZXNzLA0KPiA+IHJlcGVhdGVkbHkgZm91
bmQgYnJlYWt0aHJvdWdocyB3aGVuIHdlIHdlcmUgc3R1Y2ssIGFuZCBoZWxwZWQNCj4gPiBpZGVu
dGlmeQ0KPiA+IHRoZSByb290IGNhdXNlLg0KPiA+IA0KPiA+IExvcnJ5IEx1bzoNCj4gPiBBc3Np
c3RlZCBpbiB2ZXJpZnlpbmcgd2hldGhlciByY3UtaHVycnktY2FsbGJhY2sgd2FzIGV4ZWN1dGVk
IHRvbw0KPiA+IGxvbmcNCj4gPiBvciBkZWZlcnJlZCwgc3VwcG9ydGVkIHdpdGggdGVzdGluZywg
YW5kIGhlbHBlZCB3aXRoIGNvbW11bmljYXRpb24uDQo+ID4gDQo+ID4gV2VpeWFuZ3lhbmc6DQo+
ID4gTWFpbiB0ZXN0ZXIgd2hvIGRpc2NvdmVyZWQgdGhlIHJlZ3Jlc3Npb24gc2NlbmFyaW8sIGNv
bmZpcm1lZCB0aGF0DQo+ID4gZW5hYmxpbmcgQ09ORklHX0xBWllfUkNVIGNhdXNlZCB0aGUgcmVn
cmVzc2lvbiwgYW5kIHZlcmlmaWVkIHRoYXQNCj4gPiB0aGlzDQo+ID4gcGF0Y2ggcmVzb2x2ZXMg
dGhlIGlzc3VlDQo+IA0KPiBOaWNlIHRlYW0gd29yayA6LSkNCj4gDQpUaGFua3MgOikNCj4gPiAN
Cj4gPiBOb3RlOg0KPiA+IFdpdGggbXkgbGltaXRlZCB1bmRlcnN0YW5kaW5nIG9mIGxhenkgUkNV
LCBJIGFtIG5vdCBmdWxseSBjb25maWRlbnQNCj4gPiB0aGF0DQo+ID4gdGhpcyBpcyBhIHJlYWwg
aXNzdWUuIEluIG15IG9waW5pb24sIGh1cnJ5IGNhbGxiYWNrcyBzaG91bGQgbm90IGJlDQo+ID4g
ZGVsYXllZCBieSBvdGhlciBldmVudHMgc3VjaCBhcyBmaXJzdEJRIHRyYWNlIGV2ZW50Lg0KPiA+
IElmIG15IHVuZGVyc3RhbmRpbmcgaXMgaW5jb3JyZWN0LCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVj
aWF0ZSBhbnkNCj4gPiBndWlkYW5jZSBvciBjbGFyaWZpY2F0aW9uIGZyb20gdGhlIG1haW50YWlu
ZXJzLg0KPiANCj4gWW91ciB1bmRlcnN0YW5kaW5nIGxvb2tzIHF1aXRlIHJpZ2h0IQ0KPiANCkds
YWQgdG8ga25vdyBJIHdhcyBvbiB0aGUgcmlnaHQgdHJhY2suDQoNCj4gUmV2aWV3ZWQtYnk6IEZy
ZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+IA0KPiBTaW5jZSB0aGUg
aXNzdWUgaXMgdGhlcmUgZm9yIDMgeWVhcnMgbm93IGFuZCB3YXMgaW50cm9kdWNlZCB3aXRoDQo+
IHRoZSBDT05GSUdfTEFaWV9SQ1UgbmV3IGZlYXR1cmUsIGl0IGNhbiBwcm9iYWJseSB3YWl0IGEg
ZmV3IHdlZWtzDQo+IGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuDQo+IA0KPiAtLQ0KPiBGcmVk
ZXJpYyBXZWlzYmVja2VyDQo+IFNVU0UgTGFicw0KDQpUb3RhbGx5IHVuZGVyc3RhbmQsIHdlJ2xs
IGZvbGxvdyB0aGUga2VybmVsJ3MgZGV2ZWxvcG1lbnQgc2NoZWR1bGUuDQotLQ0KVHplLU5hbiBX
dQ0KDQoNCg==

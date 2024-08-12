Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8D16C854;
	Mon, 12 Aug 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453877; cv=fail; b=EzwHCEyV+zELgSgy6SR7pY6Vx+R1ttJWlaMShqyeqPy7GjLj5ks/DgDDYcWICxMB1F6ooEUvzQEdYZ1R556U2WpY6kYnHW6w7jt3Y9ehckMX5xlFWvFBdnpxVjoVO/cD+25VLFbwk7QAb3Uv3xzkKx2QbJbbloZiDGn6ZjAyZQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453877; c=relaxed/simple;
	bh=4RHWLtJm0hW0/wmmra4ViKTn1vbZ8TtbgyzLDWDmo4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgRxu7oHJuMdEzMMCrPuUOBdYqV+RyJlCsnV7bdLP0oIhBwImPNuZ/TenJFzLU2bDRgXw2gt5LElzc4GnjbEARCMtTdCmGOePtCik05XIBYm7OHprAhBy8bwJA8BpbYuQZSgi6+sWPJo6mgxTf9UrrxnpNMw2hsJwycVgfv5WCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kJgenRux; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qsgfHamB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kJgenRux";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qsgfHamB"
X-UUID: ceeeb5ea588a11ef87684b57767b52b1-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4RHWLtJm0hW0/wmmra4ViKTn1vbZ8TtbgyzLDWDmo4A=;
	b=kJgenRuxXlfbhGM/dJxtm8LXamzbKpR2b1nTTCFmIAJLGriCc4s8TtOMquapRK9iA70H/MlujVwpJ0Z5VkummvjH7kmCoVAW7JtGh4uf2yILIK6564AJ2NSn2OEQ/rdm9Lk09ypMdvoqOSUS4zTFrYowhZeQBUDD4eMiv3GKJjg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:75641fa2-793d-455f-aa47-39f66037aef7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a69876fe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ceeeb5ea588a11ef87684b57767b52b1-20240812
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 725256737; Mon, 12 Aug 2024 17:11:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Aug 2024 17:11:03 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 17:11:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrEw1J1yFQFsEd8M7J90RnA2FC8NPS7wQNmcEyxbcSTwVnxs6tvXwrtIyk5E3kIAO0z8d98IxwCB60KcfzFe78CZ0myJhoNnsLz2O1jgojKnrybjzzlpCzQfKxPTYEkt2LQ10p2dc3XnmRz+3OKpkYcC6/bsPf2BDfZMIGjKBr7WHNRTy9lYdX0r/w7/rIz3iEXHu+u6BKT8kq/baHS030NChl/M25245KdO/FXdDRtXX5JZs+6h0TC8q5ZXcVyP81WUOrkmMov3RkIPx8cQTaU+3s9kxm3PVSTdOTOqTxYdr5f+Cey4yWUjvOA1PyuxpxxrNTe+JUnt2p1rSfMJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RHWLtJm0hW0/wmmra4ViKTn1vbZ8TtbgyzLDWDmo4A=;
 b=tPSEyZTLKQFRLdVFEsEenMprm1b5pxtrR0lbgR6r3jXmWKLF4cTx+bZDCI6jveRYxwAyClaI8j47FVFS+YztvoqJjxvNIv01gKY+rp25pcFsk6RgkHzSEJVxTDB0OjBe7MFO2/JgnO85TpTNOtLyne/eJjJKTQAijzGrttdfWIxCWqMwaN3/goYC0w5daGYvGgrdmxViDVgD0gTjyP/npAhcxHaPnb6F3i9TVMrgr6jMFvvLqX/ZXLrgkODo8iN/SGrYTEGRmuZ30LIDI15VaQByoAhGs79arK9uW9KWRSQ6EqkYSMLRJqip1n2Oq+6UwBjI7nmo0+Jqy+Glhluwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RHWLtJm0hW0/wmmra4ViKTn1vbZ8TtbgyzLDWDmo4A=;
 b=qsgfHamBEok25GmslxVCuMpOqdd/0iu/Ab7EUytBo2xVZJz18zgdO/qr8wcGRwsowzZstuNduZvsDuyZ5fAbNSP2tD0ClYwoeLPn5sIdGXtAZFtsCjdRDVW+gaURR30HUjCiIMoxkTfyzH4hnWOK7u3rwaBEWvhF5xz7U6am7nY=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 OSQPR03MB8504.apcprd03.prod.outlook.com (2603:1096:604:27a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 09:10:56 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40%5]) with mapi id 15.20.7849.015; Mon, 12 Aug 2024
 09:10:56 +0000
From: =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>, "qiang.zhang1211@gmail.com"
	<qiang.zhang1211@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "neeraj.upadhyay@amd.com" <neeraj.upadhyay@amd.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Thread-Topic: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Thread-Index: AQHa7JL00MQfh1YQgkWM2h9PLcX0vrIjVeyA
Date: Mon, 12 Aug 2024 09:10:56 +0000
Message-ID: <65b6b97a6f61f80c5f1ea1f245eea392a0de5523.camel@mediatek.com>
References: <20231218231916.11719-1-frederic@kernel.org>
	 <20231218231916.11719-3-frederic@kernel.org>
	 <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>
	 <ZYMElDsPLTJDdco3@localhost.localdomain>
In-Reply-To: <ZYMElDsPLTJDdco3@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|OSQPR03MB8504:EE_
x-ms-office365-filtering-correlation-id: 8448324a-3324-4dfb-dfa5-08dcbaaeace6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUFZVWJrV0ZZaDU5dmlRK2E3blhYWEd4UlhxTlQ4YlZFMFhxSHhyYWFjUFJM?=
 =?utf-8?B?ZUZwWFFOM2RhejVUVEVVTkQ1Um4zYTBMMHB5WmwxTUdsaG8wWkR4ZUJOWGps?=
 =?utf-8?B?ejBZT0U3VGduSVhQQ1F5TzlIUHd6MzJUekxrOWNIU1k1RWVUMGNDbjJqWjlh?=
 =?utf-8?B?MWhZb3dKcVcyenh6NGdYZTl1Q1pVVUFEVDF5TEhlL1cyMTBpcHVrSXdRUVV3?=
 =?utf-8?B?MEozUEFKWGlTVUN0VVlIdTYrMklsVlJBYlllVUlpendFMVlMQjNRQjJmdW9q?=
 =?utf-8?B?VG9oMmNlUTk5Q0dwWjAvVE1qR05CeWRick15dklBRFVsVUhyWmk4SGMvWHV0?=
 =?utf-8?B?Y0hlWnV0MFpDYllFdXd5UE44Umt5bzRnSEZnaDdTMkdWV2hnWWNSTG1OYUJV?=
 =?utf-8?B?Y3Z1MzV6T3pMYkRZQ0hyaWZldkdTa1hyUzZodTlhcUFROUx0Y0ZORE1sQWV6?=
 =?utf-8?B?QmY2ZXZEblJSaWpsSmZ3cGpqMlc2NXphRHQ0YUl5Q3F6ZHBOL0JsMmdwZXVn?=
 =?utf-8?B?NmozRjF6LzZaTXdCRUdObmhVZ0pzcnNnSXFMdjZGd1k4ZDJCTE5WYnl0czJs?=
 =?utf-8?B?Y21YYTFUQTV5dUtpbS9pZ3MybHZWR2YrL1JBREZwTk56Tk9UQVZzUG9CM3dG?=
 =?utf-8?B?VTEvWmhZQ2tjS1daK1E1Qis4amF0ZklwOHhWTjNGUlpoQXNmQmFPZXVjbUJH?=
 =?utf-8?B?d1JjZW05Smc4NlVHbzR3dStkRHp5NDEvanlsQlFra3dlellZZlNOMVdzdEFT?=
 =?utf-8?B?MXFoVkRXMXFxaTJFNzBQeUJRakthZzU5bXIzV1VhdXkwYVdlaVJIM0djeFhZ?=
 =?utf-8?B?bHIzVC9aZFZDendMUnRuNHFhbTVDSExnenlqY1FXZ1ZQSEVrQjZjeURueGF6?=
 =?utf-8?B?emlsanN3YlAvdWRGbGI5cW8rd1R3cFcrV2huakl3RFVkUm85UDFqSGtwMG9m?=
 =?utf-8?B?MGwxQkhHMFJJcE9PeUlxeHNFam5CcDRkdWk1UnVrSzA4V1FjYVNiYW5XSTc1?=
 =?utf-8?B?L21UTi93M1c2S0c3OVZRWE5CTFZwOWVTQmFPV1ZIZTNwZklVbjM3N2Nad1BM?=
 =?utf-8?B?RmFJYTEzSHBMVjJmUHd3RWY1dTJCKy9rYjhOdUE2WDl3d0p5ZUpJeVNEanJn?=
 =?utf-8?B?dHVmTXY4SUxjRWFCcHlxSVpWRThrLzNtaTAwU1crMWYwSTV3MGJudmdjdjIw?=
 =?utf-8?B?Q1pRelQvK1dXOVpaQ3lYLzgzQ3Y4cGk1TjR6Y1ZOa3EyRXVHb0pSYzkveWdK?=
 =?utf-8?B?Um92MDJqQXRZaFhUTmYzYmlRekUzSVk5Nm1sS0dFOE12NjRtWHpsSE5BUXFB?=
 =?utf-8?B?UU9YZEhNSk5mcTBCOUxkY2VhSjEyYnBpRjFPVHl3Si81QnZXM2VuSU82SERq?=
 =?utf-8?B?aU1MbGcwWm82cG5ma25qYi91ZFVmaUpxOHhaTUhKeWhWejJPTWIyd2laYWdY?=
 =?utf-8?B?c3Z5OVRCMC8wc2crSEJBaDNVdkt0TFR6bFFiWE9jdFdnOGVBTitNdnkvNDRm?=
 =?utf-8?B?Q2pMMVJXYThiRWtQdUFtMVJ2SkpRcEtObmZYTzJPZ1QrNXVRM09CUVdLWmkx?=
 =?utf-8?B?VGk3Y2kwRExGYW5udUZ3Uk4yM3hmKzM2YXVSWE1kTXV3dzlua0R3ODl4T0NR?=
 =?utf-8?B?WU5EaHJMZEFYVXlobFZybGVEYWh0SEUybFhiYW1oVFp6K21RTC82Q1djNi9J?=
 =?utf-8?B?bGc1YXRIT2h6WGFuUUQ0VzhDQlBUeWI1eTI5cVVEVVpnb282YytpU0FXY0J2?=
 =?utf-8?B?MlhVcW1XLzdlYm1nMGU1UEJwdG94M1V0TXZVWDNFZS9CRWs2QWliMlgxNHJh?=
 =?utf-8?Q?s/gDY/MXeDFok967oa+wY67jYPIU/l/aQpURA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJrdVVOS2NzMVNuV092NDZSaTlIbmNBRS8waG5VVTlwK25OK1l1WjlWekZW?=
 =?utf-8?B?YjczRmo2LzFNTDdXSHhKTEMxWTNxWUkySDRNVHQzc3dhcEQ2SEJwckRwWEYy?=
 =?utf-8?B?SzhDdHZaa2V6Yk1SbENrdU4zVG1WZmVRVzVMSzMzU3pvWjE1T0ZqTm85T0la?=
 =?utf-8?B?a1hlTzI5QkpCbjBHZjl3QkVsaytOaGFMUmU5WVRkOGtHS200RWVuaTNLOFl2?=
 =?utf-8?B?MXpYOC9PYzBxTE9oaWNrdmRMYTFBSkh1c3ZRZHlOdlhtdVNqeW5sempXQy9j?=
 =?utf-8?B?RzNLZ0cvL3dRVmQwejJEV0NibkpwWXJDRTlaWlMrK01XeDVRR05QRG5lejdN?=
 =?utf-8?B?b3JFRUdOVFN6Qk1mNXB6NjA3M3ViaDZ4Wmx3TW00TWFnZFdKbHJOMkFlVzNC?=
 =?utf-8?B?NUNHV3V0Yml5TExpbWtjTlNFSE9LdmxseDBRbzNOdU9wQ0lIR1dIS0NHUzNR?=
 =?utf-8?B?aDNLVm0yMWRySGVUSmJPM3hSL1BrUHhFaE11d2NBWjZlMlZOZVRRUmNodVJH?=
 =?utf-8?B?Nitoa1lKTHBLVnVubVNENzFDNnNhUnEwUTYxankrWkFGM0hoaXIyeDdMZzFj?=
 =?utf-8?B?TFBuQktyaEc1eWczV2V1SzVseXMyb3hkQ2ZuQUFYNzUxbFFzZ2YvSGYwQnpH?=
 =?utf-8?B?Wi9OY1RpWDlZaVJGNW5idkhRZExKREdIQUVrWHBuK3I2TmlUZTNtQk5uTDFP?=
 =?utf-8?B?WkhLZ29lenFScU1ObStwVmZNbHJ4bmVRNFNna2twNmU1M1lzWUVtYnRmSTVu?=
 =?utf-8?B?d3pBS2h1Q01ubDNEK3Z2Vkx5RVZrTE1ndHNGU1o3OU5xRFl4NFlYbGp6VkJN?=
 =?utf-8?B?dnMxVUlzeEdtazNaMUVJT1Nad0dzelZqdW1LSktOWHlXNHoxejV6ZjZRb1py?=
 =?utf-8?B?MVB4VFp3elRIQ3k3WEVWUWpENCtUUFBoczJ1Z1o1SFkyMTI3cGUwMHFmVnNk?=
 =?utf-8?B?MjBscTFMNndmbVl2bmdwQTJ3WW9OeXJRVW1TQlV4WG4zWUw0aENxb0dENWFw?=
 =?utf-8?B?VEZqSm9VT1AvZGM4UWhoSkNBRWFFcU1SM3hldTREUmp4MjljTkRXUFhXTXRF?=
 =?utf-8?B?MTlOQk50RDBsNnI1bkpPYzZNV3c3bllWQjAvQXhtOXFuWkIybjBhMnM0KzA2?=
 =?utf-8?B?cERFdXE5eE8vbGptMlNzL2YzaU85cmVYTjhmZ3BQY0tudkVzOXM0eXp3UU9E?=
 =?utf-8?B?S2tycUZHTlN6NlRIM25JRmdJd2J5aDRlbFN3OUV0RGg2OHYrc1hIMmRjUUcr?=
 =?utf-8?B?SXFtd2cvRmczT0ZQVXd1bDlyVUtJL0wzdlNQTXBJRUxqWVQwSU1wcjNJVjJY?=
 =?utf-8?B?dVpmbVY0eFNyYkpWWDRRYmRiZCtqLzlqalVKWlVuVHc2cEYvMWJrYWs3R2Mr?=
 =?utf-8?B?OWJpcW9DRjJkQ1Y3VElkTXUwcldpekVIQURSQ2JwdE9GcjBraEJEbE9PL1dv?=
 =?utf-8?B?STJzdit0WDVZTGU3VTRKVGt1Z3JmVm1mUW90U0x3ekVHYlQxVjNMWHBDQ1R3?=
 =?utf-8?B?SEpra3EzSUxaeWN6N3NEd2tyNnFWRGVoNzdVK2I5OTlMOEFTN1JRZEU4Y3lo?=
 =?utf-8?B?RG5yem5xUmk4S2lmZjF2cDVEem9VRU1ERDhWaU5wRW5Nck5GUHRWOXhzeUU1?=
 =?utf-8?B?bzN6aWNjaThNKzM3SVlPV3Bvdm0zbzVQNXd1RnNXK20vMENYc2Z6TmJpeTV0?=
 =?utf-8?B?MzRGNysveCtuZEI5WXpUbjZrUyttaG5DTzRzTnV1ZlF1Y0Y2eWZad0liaUtN?=
 =?utf-8?B?SzdaY1lWYTV1RlJ4TEE5Nk85OS9PcFVCOEpYSzl3TGFtS2hsWHRWVFFtcUY1?=
 =?utf-8?B?Z21ET29YejVXVmE0Rmd3eHovZHR1bFY1SE9ibWZTL09lclkxTEhSUmc1eEto?=
 =?utf-8?B?RmdEdUh6RHF1SXlhRjBrd1FCS1hXVHFKMkFGblNhNndENTlDY0Exb1RBVHZI?=
 =?utf-8?B?L202SEdnYVA3UFJtbXZSUTdzMEVORHNCa2lPakFvelRIS3lXWW9tQkZlcm03?=
 =?utf-8?B?b2VySkQ0ZUNqZ0RKREcwdGF3RHlHRnlZRHk5cnB4YlNFZHBxUTFXL1ZEYlkz?=
 =?utf-8?B?bERCYUxjTFdkYVN2UE54MS85ZnBVMkNSR0ttYWVwbFk4MEJQdWJYS2cwbW5o?=
 =?utf-8?B?TWNKQlBuVU9YMUtLT3NtQzBmdE1DWXhhY2haQ0V0ZS96bE85VFgyMlVaTGln?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <374195955792664A812D40248C3A0A34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8448324a-3324-4dfb-dfa5-08dcbaaeace6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 09:10:56.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+PCcbfUyZbmOqyqE19AUtQD6XMKSpFY+cMT5+MJoOYuSKo3OXYKyQbZgzgaUFHaZ2y8ZEaJSUurdTIR8QaRyDrZt9pyAU1NF1cWSNxEivo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8504
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.980900-8.000000
X-TMASE-MatchedRID: O/y65JfDwwsOwH4pD14DsPHkpkyUphL9fjJOgArMOCaUvX/ci5TjsnxZ
	di31cOFSGRpEFyLmo64mkmvtQHMtCO2niodCoJB/jNvYZHpO13coUVkB7ifJntSp2QQ0eQgQ3Vh
	CXjP25gQOeEivp/zOUixemB9zi6rcr78SC5iivxzSBVVc2BozSlkMvWAuahr8SnQ4MjwaO9cqtq
	5d3cxkNT3zSp73HMHc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.980900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0CB4D4B3607D30F3C2379E28533B44BC08F9F58FA2BD37F7919E09DDD25706BF2000:8

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE2OjEzICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBMZSBXZWQsIERlYyAyMCwgMjAyMyBhdCAwNDoyNDozNVBNICswODAwLCBaIHFpYW5n
IGEgw6ljcml0IDoNCj4gPiA+IA0KPiA+IA0KPiA+IEluIHRoZSByY3V0cmVlX3JlcG9ydF9jcHVf
ZGVhZCgpLCB0aGUgcmN1b2cga3RocmVhZHMgbWF5IGFsc28gYmUNCj4gPiB3YWtldXAgaW4NCj4g
PiBkb19ub2NiX2RlZmVycmVkX3dha2V1cCgpLCBpZiB0aGUgcmN1b2cga3RocmVhZHMgaXMgcnQt
ZmlmbyBhbmQNCj4gPiB3YWtldXAgaGFwcGVuLA0KPiA+IHRoZSBydF9wZXJpb2RfYWN0aXZlIGlz
IHNldCAxIGFuZCBlbnF1ZXVlIGhydGltZXIgdG8gb2ZmbGluZSBDUFUgaW4NCj4gPiBkb19zdGFy
dF9ydF9iYW5kd2lkdGgoKSwNCj4gPiBhZnRlciB0aGF0LCB3ZSBpbnZva2Ugc3dha2VfdXBfb25l
X29ubGluZSgpIHNlbmQgaXBpIHRvIG9ubGluZSBDUFUsDQo+ID4gZHVlIHRvIHRoZQ0KPiA+IHJ0
X3BlcmlvZF9hY3RpdmUgaXMgMSwgdGhlIHJ0LWJhbmR3aXRoIGhydGltZXIgd2lsbCBub3QgZW5x
dWV1ZSB0bw0KPiA+IG9ubGluZSBDUFUuDQo+ID4gYW55IHRob3VnaHRzPw0KPiANCj4gRHVoLCB5
b3UncmUgcmlnaHQsIHRoYXQgb25lIHRvby4gSG93IG1hbnkgbW9yZT8gVGhpcyBocnRpbWVyDQo+
IHNpdHVhdGlvbiBpcyBzY2FyeS4uLg0KPiANCj4gVGhhbmtzLg0KDQpJIGVuY291bnRlcmVkIHRo
ZSBpc3N1ZSBwb2ludGVkIG91dCBieSBaIFFpYW5nIG9uIGtlcm5lbC02LjYsIHdoaWNoDQpjYXVz
ZSBSVCB0YXNrcyBvbiB0aGUgQ1BVIHRvIG5ldmVyIGJlIHNjaGVkdWxlZCwgbGVhZGluZyB0byBh
IHN5c3RlbQ0KcmVib290LiBJdCB0cmlnZ2VyZWQgdGhlIFdBUk5fT05fT05DRSghYmFzZS0+Y3B1
X2Jhc2UtPm9ubGluZSkNCmludHJvZHVjZWQgaW4gW1BBVENIIDEvM10uIEJlbG93IGlzIHRoZSBj
YWxsIHRyYWNlOg0KDQogQ2FsbCB0cmFjZToNCiAgZW5xdWV1ZV9ocnRpbWVyKzB4N2MvMHhmOA0K
ICBocnRpbWVyX3N0YXJ0X3JhbmdlX25zKzB4MmI4LzB4MzAwDQogIGVucXVldWVfdGFza19ydCsw
eDI5OC8weDNmMA0KICBlbnF1ZXVlX3Rhc2srMHg5NC8weDE4OA0KICB0dHd1X2RvX2FjdGl2YXRl
KzB4YjQvMHgyN2MNCiAgdHJ5X3RvX3dha2VfdXArMHgyZDgvMHg3OWMNCiAgd2FrZV91cF9wcm9j
ZXNzKzB4MTgvMHgyOA0KICBfX3dha2Vfbm9jYl9ncCsweDgwLzB4MWEwDQogIGRvX25vY2JfZGVm
ZXJyZWRfd2FrZXVwX2NvbW1vbisweDNjLzB4Y2MNCiAgcmN1X3JlcG9ydF9kZWFkKzB4NjgvMHgx
YWMNCiAgY3B1aHBfcmVwb3J0X2lkbGVfZGVhZCsweDQ4LzB4OWMNCiAgZG9faWRsZSsweDI4OC8w
eDI5NA0KICBjcHVfc3RhcnR1cF9lbnRyeSsweDM0LzB4M2MNCiAgc2Vjb25kYXJ5X3N0YXJ0X2tl
cm5lbCsweDEzOC8weDE1OA0KDQoNCg==

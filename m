Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682412629C;
	Tue, 29 Oct 2024 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168472; cv=fail; b=jMEg83YbMx//+VzgLbP4MemsG1t4Bbj1bx98ncrCRedf6YnLQkOxyo6FSwT09gXvb7z4Hkq0Zgm2EXsndNmma2g6ij4DJgloIGNNHwqMSWzmCoGbcrCC+wrYvZygypw9j70F3r3zccVdm08yXQkBT3ytJeSD/Mr+yLQSxCwW3jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168472; c=relaxed/simple;
	bh=qDSRQX2Rx3sXZNN33Sx7XsbaRRd+ty2LSfKjrO+8TGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZOTGvdZMOo/6+eMgTtGkZpoUZpfFjpMjpjGtO7QXVzik8v2yWIB2vWJlLIJM3FkoYpnmne3YVmRPQLXHWDycQGU2j94tMBI0rXP5kvH1/vdG4Fua8IrGw+6K81Z6u165tmJNvuTFBmVJd9HsCMFYCjGqHZpCz8v35vybDSv2w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YF0JoCYn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LYhR3EBJ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YF0JoCYn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LYhR3EBJ"
X-UUID: 6de90832959c11efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qDSRQX2Rx3sXZNN33Sx7XsbaRRd+ty2LSfKjrO+8TGg=;
	b=YF0JoCYnh6gxPuiz+ItKYJ4vHoAWNEcfPJIdphV0hoLDSfl+WQU9/ep7+dppXFjiGlAqHlSqdUNvzjr9vgyV78StKgPUnzaREguw/7B5PCs+208cQ/4ZSQDf5aMVDm1UUz6DFXziM/mnNHtKG7gu6hfgOc5IfvGZ8DLzNu5ZY+M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:fbc7ab96-2732-43d3-b433-5b1a3df5401b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:c6aa33e7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6de90832959c11efb88477ffae1fc7a5-20241029
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 544408911; Tue, 29 Oct 2024 10:20:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 10:20:55 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 10:20:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okQ/IPzf9T8CBptRtezuQf3Kw+MDoKdd3vJg1r1fgf9M/lWOaL2xjwx/pbyT0h82kg9ECk9NAshsWt8tEvmR9PRs+o7m1kI+CO/kbCVWXOLOAHiJ7pLWSf2UCbrvIxggzpO8L/G66hubTlu+G0UMODCidbfwRluDhYA0TuA0jpXElgwwAb0NxXvzQO4KYEeLDewmM9PPhrefGtyShJmpWZ08dGYu0GyHbLWYZcDDySsAhPmSVUZKGZq4jK7WlJbFEnNpdmspPOqlRwQ3LtrAbJBI3sL07vDFomHd02Wt0ZB9p8WTClnvCrBX4tew3YHfFlfXwgwihR1OTh2XEedFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDSRQX2Rx3sXZNN33Sx7XsbaRRd+ty2LSfKjrO+8TGg=;
 b=ygKYILbBI4Oz72iMgwtw4qpinNjcK7AaLsjGdz8WODQJTIgQlcPhQ7HWmuUwopd/JjMznMxymm+T0OdW00q1nNvQRxE2Wnwe5T7u5jZ0e5Ie3aUITa+Ejisj/utWjkys5E4OF5pEkC8yLNq0Kq8pf8FVvkxMi/4xqcAClx+LrMYz/mGj0y16KfmL193/onxFyWwCoL/ZHXZvMJK3QpZ1O5c69C4gIT8rNwMBc2arig1xFiQp8RFK9PCltQjuc/DUtTScfKxitgERTEXKn0h7GOR6ure2/h2I3WIFTj1JmjhpU/q/ecBYzgf/5blnBTdsyhUTpcxevB464MsjVF9kpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDSRQX2Rx3sXZNN33Sx7XsbaRRd+ty2LSfKjrO+8TGg=;
 b=LYhR3EBJjsZOyhe6bDFtvaSY7o1gTkhXLAadL14Qn8pvGQx5cxbLaywtD2qGCYtzMo8K5wImFteohB3gMerHzcQ3/VyzS5ZuFsovHOgEKI81zWL8kUpP4W0kPPgYF/hKT0iRf8QhZTFpM5UNrQUIMUjhqp7AnzHOOP94zK34jOA=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 SEYPR03MB8065.apcprd03.prod.outlook.com (2603:1096:101:16e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 02:20:52 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40%5]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 02:20:52 +0000
From: =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC: wsd_upstream <wsd_upstream@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?=
	<bobule.chang@mediatek.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "joel@joelfernandes.org"
	<joel@joelfernandes.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Topic: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Index: AQHbKZuQD0a1bmt83kGqJ5+0CTWhuLKc/yAA
Date: Tue, 29 Oct 2024 02:20:51 +0000
Message-ID: <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
	 <20241016161931.478592-3-paulmck@kernel.org>
	 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
In-Reply-To: <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|SEYPR03MB8065:EE_
x-ms-office365-filtering-correlation-id: 63fe9093-f33a-4859-8c7b-08dcf7c04f7e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTVGa2VJT3RqOXNQeTBrU1RQRjBIYzhSOHNDMU9mdWprTzFYTVFkekJLa2Q4?=
 =?utf-8?B?ZkwyR09kek1rRnlnUXdVTG5lVnV3SDRtS09iVDBWV3pNeE9NNS9pdTd1YkFB?=
 =?utf-8?B?V0xuOXZvbkR6NDRxeDNBdHY3dmVHY1JqSDhUaXdDbWFLMGIvRkFLUEgzaTFs?=
 =?utf-8?B?UnpnQVNUWVBkZzRmaUxYdTh4R3pEdkZFNGFjQjlEVHVkUjlrNVBkVWpPUHRP?=
 =?utf-8?B?c3BXNU5KWlBFbUZlQTVINXBvb0NSRmV0Sk9aWjhwZUtjZ1QycGxsOUpDWnor?=
 =?utf-8?B?b1NCbEpKK25hckpJeis0VURIMVNBblFNc2ZXbS9sOHpMSXEwenZwUW8wYTZO?=
 =?utf-8?B?aDgzQXZ0ZzNKb01tQXQ2Y0w2ME42OWZkdTRaa3BuWlZHalQwRXJQNy9pRlVx?=
 =?utf-8?B?QkRPeTZVSHBDM2lhRDVTQ0JoOG5ZblhYUEdKc0hZQTdKN3JYODNDdWozc09X?=
 =?utf-8?B?Q3RPeXJKYXVHVmNRUUtnZGhmalJkTjJjbjZ1Q1dXcFUreDRIaXlNRERSTDRz?=
 =?utf-8?B?R1RSRm1SbjZmeFlieEZkdFdSU2FNT1VtZlB4cTE4Tm5Jd3RFK1ZpbUZsa25n?=
 =?utf-8?B?U2V0dk9nYWhrQkJqSDAvRHBKc3pzODFqNk1BVjNKTjNvdTByOSsva1VxcjFv?=
 =?utf-8?B?LzJSR25XSE1mOVdCd3o4SEhzTS9NRnVGdnlqcUhCMmY5Lzd6Mnc0SFVaUnZ0?=
 =?utf-8?B?eGV2QTNJR0FCaktoSG9XcFdKUzZQMkNodU9DcnFGdjgxdjFQTkxEUFJQMEoy?=
 =?utf-8?B?bHo3VnozdDJidHpSU2ZRTlM5ei8zTmpnRnNoREEvQXlScExQVHJvcnlJNnB6?=
 =?utf-8?B?OU9raG85SGdVMUUrWlN4cnhib0R5ZHY3Y3RxamNEalpBY3g2VlZveXlEQW56?=
 =?utf-8?B?MmJpcHEwU3NkaER5eW94NHlLR3pTaFJqK0gyVnY2L2tCRm5ZOTJkcHhUU2Jq?=
 =?utf-8?B?ZmhKQnpFRWQzMTZiWkFQcnFkRkNnK2JlYnV4dkhZcDFZNDNvODVjb2JhcW90?=
 =?utf-8?B?ZkpQYWRCeHV0NEFTTm1JZ1k1NDIxZHcvWWRaSHl1cEVqM3FqK3ZnV05XWFpT?=
 =?utf-8?B?cU5mUDNzdk14N0srSlpIRHZxSVhZNjFRUmJVbzF2eW9VUEZwZG9hajF5RTR1?=
 =?utf-8?B?LzlKUUNtSmJidUdOSGtMQWFvNEtxcGZBYm9ibVhrbDBIVzhKT2R5SVhUWHVQ?=
 =?utf-8?B?cXg1VmMxVE9WMUVuT1BNbFJyYnJQUnRzdEhuMlZVc0pZRE9Qei9yd1lrMGcx?=
 =?utf-8?B?STNjS0tPMC9NQkZjZ0JzZFlyc0Q5ZTRDVUlyK0Zia3k3RERSemgzalJBaHZC?=
 =?utf-8?B?NVR6OW5JUGtyZm5jeTY3eG1RSVFkK0h3Qy8wTXp5Y1o1aWNBVW05OTdIV21O?=
 =?utf-8?B?RHFZd21OK0RFZGFIU0UyWnR2WHNoSGlWcFI4OWZlWFU2Wmlpc3QwNWNEM25h?=
 =?utf-8?B?Q2VGbWxrak5VaW1UdjZxWldKb2h3ZjNraXBXNWVSZ3EzYTZ5cTN4b1J1b2pJ?=
 =?utf-8?B?Qk1VeVF1L2VoekdnSlNYSkppUld0bkNkZXNCWnV4Mzd2Smd6SFBLNUhsVXlP?=
 =?utf-8?B?cnNNNlpacm1XbW45aW1EOXB3ZkQvMTB2RThuNlRITjVEa3NicmVsYXk2dmVh?=
 =?utf-8?B?MDRHK045bkQybGl1ZzJnL3BHVW9hazVKQzB5RWhoanV6QXQ3dURmYnZrZXZp?=
 =?utf-8?B?MWMyNWFOWDFSZzVsVVh3RG1xSXY0WGYrOTN1VlYzWk9taDlieS9reHFRT2FS?=
 =?utf-8?B?NUhDdnpyMUJTMzRyUHUwUGt6ald0MnJYRWF0M0N0YmRxMmJJVjJ0dHVFaUEv?=
 =?utf-8?Q?Ppp2Fw3Zv4oh0sXQo4R2UEeRkRkwHADxw+Dvc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkYxL3pCNzJFU1JCQ2UxZVZPTEpWdXRmR0NGc2QxT3J0UGlTVTY4R1FhZGxx?=
 =?utf-8?B?eW4rdld2OFRzZjNISFQxdUFabVlkNWNma2UrQzNNdDQvUHcyZk81bzNLQlRD?=
 =?utf-8?B?ZUFhOUY3dnllcm9acXBDSWxEREcrVjBXYTg2WFNTTzZjKytNZkQxcXkrUi9H?=
 =?utf-8?B?WWhONEdjWUhCUVl5QnRrNjdYVW9BVzNOTmEyS2QzWDlrQlgvZUFHTDBWVTVp?=
 =?utf-8?B?dG43U2I4R1NVb1RteHpFNmtSOEpjeTExNkt3Rk1vQzQwU1B5YzJrUUJHSUNX?=
 =?utf-8?B?dzB0a0dTb2NGY2ZLL0o1MkxHdWpmc0tjTmlIanR3NVFXQWpOU2k5Z2M3ZXN0?=
 =?utf-8?B?N1NxNnNoTnhvUHZvUVRRc3JYb0gvU2kzM3RXYjY2R092N3pCZkxuUXdGWjdF?=
 =?utf-8?B?Yk9GZCtIWEtDNUdJWFhIWnI1YU9jMG9mcnNlSkxURDVSdFlmdmdxc3k0cWRw?=
 =?utf-8?B?TmI2QTBqa3BZcG9DU0xPVlExY1h6R3pXenVuTnMxTHkzSFhKUHMyUmlkL3Vq?=
 =?utf-8?B?V1FDQU1TVDIyVkczOEhpb0k0c3UxcTNLcUMva3cyL3VobUw5SUppa3Q2Tkw4?=
 =?utf-8?B?Y0VpTGhGSUwreUo5NE1VRStaR2x1dmVjZ09GQ3pBZlhsNDFpNTNUS0xnTU5z?=
 =?utf-8?B?VHFtY01QOWMxdW5xUGc0T2xjT0dGS204c2JOQlhpS25WU1h5Q2V5ekd0Rmlu?=
 =?utf-8?B?NkIySkhEakxpRGd5c3NDT2wzbUFKdEY2eGNHajV5Y3RkZENqalhPSGszYU9S?=
 =?utf-8?B?SHZyNnJQVzR6Z25WbTVDRmJneE5TZWhiV0pYTGFmZHA4ejVNemJiU25XbWly?=
 =?utf-8?B?TWpTZUNLUWRGV0pPZ3g4eUxQdDVTSzl0THJwMzRPejlQWm1TWlc1SVRWQ3F0?=
 =?utf-8?B?MEZXeVJncmI0K0YvZ0ZubGJkK3IySjlLRFVYK2d3SnlFUW1XVzQrVG53MUJq?=
 =?utf-8?B?S1UrUWRESzZEZG1NMk9LWlV4KzVSdGM1ak14KzdDU2pkdDlBUVhTdlhpN1lj?=
 =?utf-8?B?Mnh0cGM4dG9CMmhEb1czNDlucWJQeERzeGVZZVJwTWwvKzVCT2ZVTjQ1d1pp?=
 =?utf-8?B?QjBid28vS3VQV0tMMTdsVmJQQU8zQXNKc3VNN2JZMU9HZ0VtazJjZFZhSmVu?=
 =?utf-8?B?bHNtR1R4QVhuclE4MXUvUkhPa1pYeU5oNHdmWllJcFREUDhZaUx1NjMrbk5H?=
 =?utf-8?B?Q3FpVlR4WnpIQ2UwYnpod2p2cHNDRThxTDdVTElEcTZZL2t0MUx0QXNGUXk2?=
 =?utf-8?B?Wi94WkV4bk5tSU5PTGNJQlVKTS9GelZtbGZEMDZ0YkpWNFl3UVBIcktTdkhz?=
 =?utf-8?B?Q3hxR2g0TEIwYTJhOFpvUkIxMTgvOW5MNmtSbDhTdStWUlNDK2V2OUxwTGlK?=
 =?utf-8?B?Y0Y5dUdTcW1ZZUpWUE1yQTdsd29NSjBBMFpvZkxSY0FjZXhDck4zb2swbG51?=
 =?utf-8?B?cXBycWtMTVBlMitIVjdFV3Fjb0d6WjRWQm1KRE10L29vcytBWmxLT0x3RExa?=
 =?utf-8?B?bWxDY1N1WEhidVBjSlZGTjI4djRDQVFhTDNTd1Q5VmpNS0lGeDN1TFdhYU05?=
 =?utf-8?B?ZWxQYzdKcE81NFdreUhSb2R2YnZFV1l2b0tjZkN6ZzJzTGtHSjRKcTYxSmds?=
 =?utf-8?B?L0tiTzM5RC9iS0drL1M5ZTdzdDk5SUU4WHljSmlsTHlLNjdaZ24xTmFmUDhp?=
 =?utf-8?B?dGNYVXVNQkplc0tHL0NrczZ2RWRxeWxDWVpuQWEyOWE1cFFHeDlHR2dTSE9U?=
 =?utf-8?B?d0h6SVZlQU91ZzU4NlQ4S2VYb2xTWGZwQVo2bjZ0Lzg4Zzd3WnIyZmQ3Smlk?=
 =?utf-8?B?d2VRQjJGWUlpdmxpSXBNVVpydTFPOUprTlVFY0VNaG55d2cvcVVqYWdFSkE1?=
 =?utf-8?B?Rm9pSmVjbDkvRDFkYm52UWlaZ04rakJOTDBoQ3U1Z09BRCtzOXY4UUl5ZjFN?=
 =?utf-8?B?NEpNdXNYenArSTZhektPaXJoaC92d3RIejY2TDhrWkpKSndtWG9yR0NMdDVM?=
 =?utf-8?B?SndHZm5UY3NMM2ZEcmdiYTNRb3RGc2VFWlBxTDd1VkFvRUhOd2E4NlozejRT?=
 =?utf-8?B?T0Qzc0xDR09XN3FTeGxMNDdCUVBSUmF3bmtQOUIxYUg3VStzT3RFUnkrbTlw?=
 =?utf-8?B?YkxEcXFMN21lMHZwQjh3SDk2SjR3T1JDcElmQjFoKy95M21vNGM4aVJvNFR6?=
 =?utf-8?Q?Qifh6lJ7nExrwlrdvUMGVYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCE8782178F5764DAEE7501384CB8CF0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe9093-f33a-4859-8c7b-08dcf7c04f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 02:20:51.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4evpU09guZ1HiorIknvT3u2WQJdSZGsxVdzrEgPuxLbCYxd6WY4UpnvziGsn93BgXB1FZd8jtiCVhweLwEx/OcOD+U6YKnuUvkwFcaV4kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8065

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDE3OjIyIC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBUaGUgcmVzdWx0IGlzIHRoYXQgdGhlIGN1cnJlbnQgbGVhZiByY3Vfbm9kZSBzdHJ1Y3R1
cmUncyAtPmxvY2sgaXMNCj4gYWNxdWlyZWQgb25seSBpZiBhIHN0YWNrIGJhY2t0cmFjZSBtaWdo
dCBiZSBuZWVkZWQgZnJvbSB0aGUgY3VycmVudCBDUFUsDQo+IGFuZCBpcyBoZWxkIGFjcm9zcyBv
bmx5IHRoYXQgQ1BVJ3MgYmFja3RyYWNlLiBBcyBhIHJlc3VsdCwgaWYgdGhlcmUgYXJlDQoNCkFm
dGVyIHVwZ3JhZGluZyBvdXIgZGV2aWNlIHRvIGtlcm5lbC02LjExLCB3ZSBlbmNvdW50ZXJlZCBh
IGxvY2t1cA0Kc2NlbmFyaW8gdW5kZXIgc3RhbGwgd2FybmluZy4gDQpJIGhhZCBwcmVwYXJlZCBh
IHBhdGNoIHRvIHN1Ym1pdCwgYnV0IEkgbm90aWNlZCB0aGF0IHRoaXMgc2VyaWVzIGhhcw0KYWxy
ZWFkeSBhZGRyZXNzZWQgc29tZSBpc3N1ZXMsIHRob3VnaCBpdCBoYXNuJ3QgYmVlbiBtZXJnZWQg
aW50byB0aGUNCm1haW5saW5lIHlldC4gU28sIEkgZGVjaWRlZCB0byByZXBseSB0byB0aGlzIHNl
cmllcyBmb3IgZGlzY3Vzc2lvbiBvbg0KaG93IHRvIGZpeCBpdCBiZWZvcmUgcHVzaGluZy4gSGVy
ZSBpcyB0aGUgbG9ja3VwIHNjZW5hcmlvIFdlDQplbmNvdW50ZXJlZDoNCg0KRGV2aWNlczogYXJt
NjQgd2l0aCBvbmx5IDggY29yZXMNCk9uZSBDUFUgaG9sZHMgcm5wLT5sb2NrIGluIHJjdV9kdW1w
X2NwdV9zdGFjaygpIHdoaWxlIHRyeWluZyB0byBkdW1wDQpvdGhlciBDUFVzLCBidXQgaXQgd2Fp
dHMgZm9yIHRoZSBjb3JyZXNwb25kaW5nIENQVSB0byBkdW1wIGJhY2t0cmFjZSwNCndpdGggYSAx
MC1zZWNvbmQgdGltZW91dC4NCg0KICAgX19kZWxheSgpDQogICBfX2NvbnN0X3VkZWxheSgpDQog
ICBubWlfdHJpZ2dlcl9jcHVtYXNrX2JhY2t0cmFjZSgpDQogICBhcmNoX3RyaWdnZXJfY3B1bWFz
a19iYWNrdHJhY2UoKQ0KICAgdHJpZ2dlcl9zaW5nbGVfY3B1X2JhY2t0cmFjZSgpDQogICBkdW1w
X2NwdV90YXNrKCkNCiAgIHJjdV9kdW1wX2NwdV9zdGFja3MoKSAgPC0gaG9sZGluZyBybnAtPmxv
Y2sNCiAgIHByaW50X290aGVyX2NwdV9zdGFsbCgpDQogICBjaGVja19jcHVfc3RhbGwoKQ0KICAg
cmN1X3BlbmRpbmcoKQ0KICAgcmN1X3NjaGVkX2Nsb2NrX2lycSgpDQogICB1cGRhdGVfcHJvY2Vz
c190aW1lcygpDQoNCkhvd2V2ZXIsIHRoZSBvdGhlciA3IENQVXMgYXJlIHdhaXRpbmcgZm9yIHJu
cC0+bG9jayBvbiB0aGUgcGF0aCB0bw0KcmVwb3J0IHFzLg0KDQogICBxdWV1ZWRfc3Bpbl9sb2Nr
X3Nsb3dwYXRoKCkNCiAgIHF1ZXVlZF9zcGluX2xvY2soKQ0KICAgZG9fcmF3X3NwaW5fbG9jaygp
DQogICBfX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSgpDQogICBfcmF3X3NwaW5fbG9ja19pcnFzYXZl
KCkNCiAgIHJjdV9yZXBvcnRfcXNfcmRwKCkNCiAgIHJjdV9jaGVja19xdWllc2NlbnRfc3RhdGUo
KQ0KICAgcmN1X2NvcmUoKQ0KICAgcmN1X2NvcmVfc2koKQ0KICAgaGFuZGxlX3NvZnRpcnFzKCkN
CiAgIF9fZG9fc29mdGlycSgpDQogICBfX19fZG9fc29mdGlycSgpDQogICBjYWxsX29uX2lycV9z
dGFjaygpDQoNClNpbmNlIHRoZSBhcm02NCBhcmNoaXRlY3R1cmUgdXNlcyBJUEkgaW5zdGVhZCBv
ZiB0cnVlIE5NSSB0byBpbXBsZW1lbnQNCmFyY2hfdHJpZ2dlcl9jcHVtYXNrX2JhY2t0cmFjZSgp
LCBzcGluX2xvY2tfaXJxc2F2ZSBkaXNhYmxlcw0KaW50ZXJydXB0cywgd2hpY2ggaXMgZW5vdWdo
IHRvIGJsb2NrIHRoaXMgSVBJIHJlcXVlc3QuDQpUaGVyZWZvcmUsIGlmIG90aGVyIENQVXMgc3Rh
cnQgd2FpdGluZyBmb3IgdGhlIGxvY2sgYmVmb3JlIHJlY2VpdmluZw0KdGhlIElQSSwgYSBzZW1p
LWRlYWRsb2NrIHNjZW5hcmlvIGxpa2UgdGhlIGZvbGxvd2luZyBvY2N1cnM6DQoNCkNQVTAgICAg
ICAgICAgICAgICAgICAgIENQVTEgICAgICAgICAgICAgICAgICAgIENQVTINCi0tLS0tICAgICAg
ICAgICAgICAgICAgIC0tLS0tICAgICAgICAgICAgICAgICAgIC0tLS0tDQpsb2NrX2lycXNhdmUo
cm5wLT5sb2NrKQ0KICAgICAgICAgICAgICAgICAgICAgICAgbG9ja19pcnFzYXZlKHJucC0+bG9j
aykNCiAgICAgICAgICAgICAgICAgICAgICAgIDxjYW4ndCByZWNlaXZlIElQST4NCjxzZW5kIGlw
aSB0byBDUFUgMT4NCjx3YWl0IENQVSAxIGZvciAxMHM+DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsb2NrX2lycXNhdmUocm5wLT5sb2NrKQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhbid0IHJlY2VpdmUg
SVBJPg0KPHNlbmQgaXBpIHRvIENQVSAyPg0KPHdhaXQgQ1BVIDIgZm9yIDEwcz4NCi4uLg0KDQoN
CkluIG91ciBzY2VuYXJpbywgd2l0aCA3IENQVXMgdG8gZHVtcCwgdGhlIGxvY2t1cCB0YWtlcyBu
ZWFybHkgNzANCnNlY29uZHMsIGNhdXNpbmcgc3Vic2VxdWVudCB1c2VmdWwgbG9ncyB0byBiZSB1
bmFibGUgdG8gcHJpbnQsIGxlYWRpbmcNCnRvIGEgd2F0Y2hkb2cgdGltZW91dCBhbmQgc3lzdGVt
IHJlYm9vdC4NCg0KVGhpcyBzZXJpZXMgb2YgY2hhbmdlcyByZS1hY3F1aXJlcyB0aGUgbG9jayBh
ZnRlciBlYWNoIGR1bXAsDQpzaWduaWZpY2FudGx5IHJlZHVjaW5nIGxvY2staG9sZGluZyB0aW1l
LiBIb3dldmVyLCBzaW5jZSBpdCBzdGlsbCBob2xkcw0KdGhlIGxvY2sgd2hpbGUgZHVtcGluZyBD
UFUgYmFja3RyYWNlLCB0aGVyZSdzIHN0aWxsIGEgY2hhbmNlIGZvciB0d28NCkNQVXMgdG8gd2Fp
dCBmb3IgZWFjaCBvdGhlciBmb3IgMTAgc2Vjb25kcywgd2hpY2ggaXMgc3RpbGwgdG9vIGxvbmcu
DQpTbywgSSB3b3VsZCBsaWtlIHRvIGFzayBpZiBpdCdzIG5lY2Vzc2FyeSB0byBkdW1wIGJhY2t0
cmFjZSB3aXRoaW4gdGhlDQpzcGlubG9jayBzZWN0aW9uPw0KSWYgbm90LCBlc3BlY2lhbGx5IG5v
dyB0aGF0IGxvY2tsZXNzIGNoZWNrcyBhcmUgcG9zc2libGUsIG1heWJlIGl0IGNhbg0KYmUgY2hh
bmdlZCBhcyBmb2xsb3dzPw0KDQotCQkJaWYgKCEoZGF0YV9yYWNlKHJucC0+cXNtYXNrKSAmIGxl
YWZfbm9kZV9jcHVfYml0KHJucCwgY3B1KSkpDQotCQkJCWNvbnRpbnVlOw0KLQkJCXJhd19zcGlu
X2xvY2tfaXJxc2F2ZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCi0JCQlpZiAocm5wLT5xc21hc2sg
JiBsZWFmX25vZGVfY3B1X2JpdChybnAsIGNwdSkpIHsNCisJCQlpZiAoZGF0YV9yYWNlKHJucC0+
cXNtYXNrKSAmIGxlYWZfbm9kZV9jcHVfYml0KHJucCwgY3B1KSkgew0KCQkJCWlmIChjcHVfaXNf
b2ZmbGluZShjcHUpKQ0KCQkJCQlwcl9lcnIoIk9mZmxpbmUgQ1BVICVkIGJsb2NraW5nIGN1cnJl
bnQgR1AuXG4iLCBjcHUpOw0KCQkJCWVsc2UNCgkJCQkJZHVtcF9jcHVfdGFzayhjcHUpOw0KCQkJ
CX0NCgkJCX0NCi0JCQlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZV9yY3Vfbm9kZShybnAsDQpm
bGFncyk7DQoNCk9yIHNob3VsZCB0aGlzIGJlIGNvbnNpZGVyZWQgYW4gYXJtNjQgaXNzdWUsIGFu
ZCB0aGV5IHNob3VsZCBzd2l0Y2ggdG8NCnRydWUgTk1JLCBvdGhlcndpc2UsIHRoZXkgc2hvdWxk
bid0IHVzZQ0Kbm1pX3RyaWdnZXJfY3B1bWFza19iYWNrdHJhY2UoKT8NCg0KDQo=

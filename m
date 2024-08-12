Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DA14EC53;
	Mon, 12 Aug 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463609; cv=fail; b=dnHLp4VwB9z/wa+zr3E4+P2U6fw9gQseZyKJHZkw91FT022Sf7wZf12PwA7iSNAfPIRGKpb2RvQWfmwoNrvabBW296B5aUc8YGESRLR+ujVD33abGjMoDC9XzXm9TntFDruRzWiFfTSJw9YHCB1haChxThlXuxfcL238zwGXK4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463609; c=relaxed/simple;
	bh=gARtcISs7XWpw+X5JUbXPT+hFJ9R2SXhQu1eMAJabbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxNeTU8mhaLWpg5fxypLGGrCU3B6DHSG5cdsjIuJutj6B4klQn9tAC6EJvhwpqDPkzia9NG75kcBHQlrvQt9Nt2LEkzpnvj4DQGxb2+69wjTNrAQEWEHWb5WGsqjp0neN+rh8VXstTQceft8USP1soxJZtPFQEXZ/+9gGtECN04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CYvw7E3/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WF1uo1pC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CYvw7E3/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WF1uo1pC"
X-UUID: 78ef0e6c58a111ef87684b57767b52b1-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gARtcISs7XWpw+X5JUbXPT+hFJ9R2SXhQu1eMAJabbo=;
	b=CYvw7E3/+AhvA57iv6vOMRl0ol3t3/m+3EiOHK18hb+JGXmes9vBF3HXV3u4rQ6jUQBnEaCUm34P/sMXbfLykWq+JLOk1+lkd29XLLNaXwquJQRSD207mbIkOPBUlvxA0oLvVPRRvO3vipRvGafaPB4Y8RGGO3vS4K3EI/K8VQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a6d91e38-ac73-4a65-9893-23be43938758,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:cd767dc1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78ef0e6c58a111ef87684b57767b52b1-20240812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 331453674; Mon, 12 Aug 2024 19:53:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Aug 2024 19:53:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 19:53:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBc4Ar6m1knnypdkfiE5oh/cAxJ5DlNq2/QXJpkNSw9+9twUG5JDj9kdwVg8evhiydZK8ZQKYv2JwrbacRsNedMZ5Cf0nxomOX1kAwvksJQoFa5+hC1h/+tf1unuYWO5sJ76lyzX/3ZAV+qQu1LkladSIa2E2AR2d5/uETbx/xXfuAfVYrp+0g8RmVExgBAqpgoDHsnK8S8viQKUIEeGqExd7/HqQKiT/OMJjyWihcNrxULYj8QJD4tBg1FkLYDk5s8VU+JJoT3gY9sY/rzS+/hrKAd8oUhiOWQuESetCRs44NOH41ZlNIDqy3TbnKSMfNYK5ezmkAtB8pGCt7iUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gARtcISs7XWpw+X5JUbXPT+hFJ9R2SXhQu1eMAJabbo=;
 b=szqgdzX27I+aHkk9R4qDmVlJASL38YfJMU/YpgJIaYu8Ao3hMP1a2AI8ZgMcLn3bTmL4ZT59qP8gd9zcfP17/DHgkHAjdn3PoycFgbIRfEsZ8Zoe9szp2PngpTgMgQ+go2bJctIgbH9/5rxBIXcpLWyiw4MmyKruF0Fsd77Sc1wzQvuIRhDNaIOyXQTvj0FuJIc6hp8LeIFMFLxG+KND5kEaJuL7yqkRZYjEsjj4pJvaZCTG+awmPkJm5GGaxC+/ytvt5/vpPdV/8BQ3uTliltd206ZcAoG8XFXS1w86OGE0xYw4gOS1ZcFi0Y/Oho9zB3GFiH9q4HEBKrg4fqQdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gARtcISs7XWpw+X5JUbXPT+hFJ9R2SXhQu1eMAJabbo=;
 b=WF1uo1pCFIxtvJnCR7afkigKvtKfSV8IbXNk68UskZZLG9K7pBHcjtA5BAEP65FF3o6w2Xc4q7yP2C73G0n1eJ6Iw7rlBCJKpn8E4Bs/SDP7H4v8OFF+BKOMM6fydQuW0hkULMauSUUqITNCzb0yqh6TJYHw4pzt6gVVYX6AVFM=
Received: from PSAPR03MB6411.apcprd03.prod.outlook.com (2603:1096:301:af::12)
 by SEYPR03MB7144.apcprd03.prod.outlook.com (2603:1096:101:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 11:53:17 +0000
Received: from PSAPR03MB6411.apcprd03.prod.outlook.com
 ([fe80::f463:8ae8:6d27:a1ab]) by PSAPR03MB6411.apcprd03.prod.outlook.com
 ([fe80::f463:8ae8:6d27:a1ab%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:53:15 +0000
From: =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "qiang.zhang1211@gmail.com"
	<qiang.zhang1211@gmail.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"neeraj.upadhyay@amd.com" <neeraj.upadhyay@amd.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Thread-Topic: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Thread-Index: AQHa7JL00MQfh1YQgkWM2h9PLcX0vrIjeJdSgAAKrwA=
Date: Mon, 12 Aug 2024 11:53:15 +0000
Message-ID: <29781c9b46641e3cbcd9d3874cb18f90ea916193.camel@mediatek.com>
References: <20231218231916.11719-1-frederic@kernel.org>
	 <20231218231916.11719-3-frederic@kernel.org>
	 <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>
	 <ZYMElDsPLTJDdco3@localhost.localdomain>
	 <65b6b97a6f61f80c5f1ea1f245eea392a0de5523.camel@mediatek.com>
	 <ZrnuctZQS4DTSb0q@localhost.localdomain>
In-Reply-To: <ZrnuctZQS4DTSb0q@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6411:EE_|SEYPR03MB7144:EE_
x-ms-office365-filtering-correlation-id: a76e6a10-9aa3-46ea-c189-08dcbac559ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ODh5dzFFU2Z6NXVITkFZMkFpdTRtMFZGdHVRR1JzakJHUkhOa25ITlV5TUlY?=
 =?utf-8?B?U1BsWGdXQTRpRTR1V3dqd1hOQmVlM0w4dDlQVkQyMGpGRUtDc0syWGN6b3Jk?=
 =?utf-8?B?dkkwdy90c0EwVnRwNzFnekROUmhRekF0U0FSR1NGVEtMVGpHOWpYeFRabWN1?=
 =?utf-8?B?cFNsYWUxQVhJNlBFclJHUU1QSTdBb1hVWXpLdVluNDVxVFlKc09VeEU3aENH?=
 =?utf-8?B?YnVQbXpWUW5RTHpiSVVXMnBPSzVwQnBJNjBhbkZkdGYyRGlEWWMzTGV3MUVJ?=
 =?utf-8?B?ZytMMzEwcFZ6cnNiRWwyRzlPNlpMcS9BRkFKd3VRbHErUU0xQjFYZGpvMkJZ?=
 =?utf-8?B?SUcrVUtQTkZmRzFFR1ZaYWFwVU13ZnhlVzlOVytkNlQzYlg3QjNqUm1TejFT?=
 =?utf-8?B?YUd1OWY1djFjUUpmcGUydmNCS1dHYnAwREVqS0dGRk9NdVZRWEF5M0lnYUtO?=
 =?utf-8?B?RGhnU29OamdyczFnTlhMOStsKytUY2pTeWJ0MXVwQkZpNyszZVhmQVVTN2Rr?=
 =?utf-8?B?RFlNc09aSFVocER0ZGF6czAxdm1ZVWZoeHRseXhKbDVQMjhMVE5raWNJbk9a?=
 =?utf-8?B?by84Z2FRZEhoZlpzMU9GVHBVOWJiZ1NzampZUU4wZmxkVVNoK092djl3Nmsy?=
 =?utf-8?B?YWFSQnQrdDFoN3ZHcXB6b3ptUTE4UkpPTkFuWnJNOWVIVUZrcFpxMHk5bnNh?=
 =?utf-8?B?MHBRRHBSS2kxSVZ0QUtFNEpsZ0pkaFNBTWN0K2ltM0t4d0dZTEptMnJtMGt2?=
 =?utf-8?B?WmRJTWpvd1NUOUtBc0Vkek9EWE9LSmI0cCszZExUOS90eURqZjdYeVNDT3NP?=
 =?utf-8?B?TUxmRmoyMmxZamU0K2lNTmFyckNYeUhoSW0ycVJxcS9zVzFIRndIM0MycThQ?=
 =?utf-8?B?ckdSMXBXaTdyNE5VUUhKU3Zsb0ZWRkdUb2ZTbjlJSWJSdXdLdXNDOE9BbCtN?=
 =?utf-8?B?SHc5cWpvOU9nWjRNS1hlRjhjZTJVQU1zcyt3U3NIOG41M2tEeFF0SzF1bDBp?=
 =?utf-8?B?VGh6M01NQ3hkcGJkeGxVbnZyK0FKNlB5MThRNUxPbVpDOGNnUGs1UFp4c2ta?=
 =?utf-8?B?N29iOHQyamdpcXh5NlNHd0t4THBrZ0w2YktPMjBZSWpjbVhYVDluTlludkhL?=
 =?utf-8?B?OWYzcU9PSHQ4a0svckZyUmo4cDZ5YlNmUkpBb2tCTVFMWUFudENmclF2UHBx?=
 =?utf-8?B?R3RlNFB1cVpWYkxTMFNJMkJBWVE5UjlSaG9xalgvTUY2SnZ5bFBFclYzR091?=
 =?utf-8?B?OHhLUXFadHpiNTdlTEs1bUlYMGFLYjBvNG0wNDlIb0NhSU03Y1l4QWpuYlJr?=
 =?utf-8?B?b2xlTWdibks3ZGMvVmxvYzQ2aW5CdEl6aGdpYWNSK0dhMmJmUDJCaWF1YXRC?=
 =?utf-8?B?QTZXRWZNUUMxY0l1ckRpL1BpUFpwbHhuU0dySzhnSkt4S0w3eXp0Mk5PK20r?=
 =?utf-8?B?cXgxc3pJenFLYjdwMnN4djB2R2hzaktaT28zdTJuTytXRHpqcTJwTDF1OTh4?=
 =?utf-8?B?WjN4MHZ4eHBSMWd1UVZtaUxzTkNYanUxcWdCSUpUQmVpVG5IRlY3L2x4MDV4?=
 =?utf-8?B?TFlWQm10REs1dnBxeEgyUGZSRXJKUitvdGlSQlF4WDVhMGU0eVJpdThDZ09U?=
 =?utf-8?B?dDRRbHBWWjFiRElPeEhlS3k5U29tODQ2eDErMmVoYm9ISUdsNkNvcHNyc25T?=
 =?utf-8?B?TGl5VW9qdjdMTStkd08wbVBtSU1ZeXF6aXZFUy90NUtpb0pmZHdGNUphSXB4?=
 =?utf-8?B?U3B6bFkrK1F5cm0wVnBJeVFyQWpyeDlRcDFtblloWjNQeU5aQkVVK2ZLSnlj?=
 =?utf-8?Q?pz91ypp4Y7QjO7ObUudJWDtdKxg5dJndKegtc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6411.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3R6NExiT0FBdEJudk5DanhUR08xY2hDTGVCNjJsdVNPcTc1MGVJTllGbElH?=
 =?utf-8?B?dFBDNDdVMmN3UXJNMG1sN3ArbkpyMnBKaEh3czNTdUdSL2lnbEgvTS9KNThy?=
 =?utf-8?B?L0UycHV3QjN1cFU4Q1Aram80TXZ6cTRkcXZ6Mk5TT2tibG5HY0c3NUIwb0pj?=
 =?utf-8?B?S1Nsb1Q4Y3IxSkFTZHAzMDhidit6RVlZTm9xcHhGTUVKQmJNejlRakdGT0NJ?=
 =?utf-8?B?NHZDdWxRaDg3OXd6ZWxtUi9KM3V4bUg1anBhZ1JqeVVwOUdhTW5KSEdNdTFE?=
 =?utf-8?B?cXZFR3BrNGNXREtYV1N0OFVFeEZxRWVuK1hKanYrazlJK1BGWTJaTW9wQlo3?=
 =?utf-8?B?NERjS0JST20xR1FEQ2pMK1FDTnRvdnRHT0VoUnhuU0RPRDdDcGJ6NXE2Y1Na?=
 =?utf-8?B?YkxFNWpTSjRCUkJDdGgxNk5zYmNJQXRBR3RnWkhMR281eXRmV3B4dDVZM2pT?=
 =?utf-8?B?eU1EL2QrMjF5ZndoVmdkeWxRK2hINEgvSVdDWCtsWGdHVnZYM3hrYUdXaExQ?=
 =?utf-8?B?d1BEYzFtQWxLT3lER3V1cUhsVi80ZVAyM0FrTGhwSXhXanFCZlpIOVpjV1hU?=
 =?utf-8?B?Qk50elFBK1BTYTcvOVpLYXlTcFdXK0NhWmRKc24yRGwvK0owciswRzBmek5Z?=
 =?utf-8?B?b0JVaVdkVWJPWE0vZU4xNXErZExCR0ZFc1FwV0wyRHo5OTlybVlGMjBpWVg2?=
 =?utf-8?B?YzNYeUdraHhsQTFEOVZ4VVJ6TVRiR3p1dUpjOCtockFjSG1TLzMwY3ZQTUk5?=
 =?utf-8?B?UEFBQzNGNUtiWXdvbnhZcUhoY1F5cUk1QUhZZDVkeW9yKytNK1RNV005b0Fl?=
 =?utf-8?B?SVVyMEg5Sm1jcnVNditGTHdvZmMwL3FXVDNIMTZaN0NzVFY0ejNXT2JyUDVS?=
 =?utf-8?B?Z2hnbkxYVER0eHBtb0w3SGhOVlJJUHNoUHlIc0tzdmFtdGc1NHBhdk1JRW11?=
 =?utf-8?B?NnUrbXRpT0V0dUZOcTh2VVFiYWtTT1pVSVdxS2Q5RklieVFkeWsxcGVWV0Vo?=
 =?utf-8?B?d0RvNWVXYWVBaW9sTkVuUm9sVkc4bE5VbHViNnFZQVhkdzVrUThuMDJ5RFQw?=
 =?utf-8?B?WGxEY003S29EZmRJRnhVSFhYYlJOT1YxMFBrKzllYndnZlpsTTlDOVJjTHdJ?=
 =?utf-8?B?NHpmcFgwZFVpd1F2R3JVZjNCZGh0QjU1NGhlK2lySEEyKzd3R2xyVG9PZUFF?=
 =?utf-8?B?WFRHOHpJUEQvRFhNQVBJVzljb3JPbnp3S3JvejNjOWhoL1pHdXQ3ZS8yOG1v?=
 =?utf-8?B?U3d3RnY1RFNPNElzVC9abGZSMzRWOUhpc0NSRE5Xa0JlOFBhb3VFUHhCWTU5?=
 =?utf-8?B?Mmx3czZqUGhSY1M5N0JmSXU4WGM5SDJPdWZwOG9aZVEydVRmT1JWWUdDbVBO?=
 =?utf-8?B?QTl4SWJ6SUQrelVSd2NvamZOVWMyV3VwMUVtT1lodmdmeEdUWFZFSHZhTm5z?=
 =?utf-8?B?U2ZpbzNKeE53WmVzOFFTRmxqczcyVkNDOTd1Tm9zdVhPS0tBenZnUnRKeTBo?=
 =?utf-8?B?N3lTaFR4MTJBUEFTMzRKNDhBdGwydjU3NE92SDNhc1RmRzF3TDhFWW9ueEV3?=
 =?utf-8?B?enlWOTFqR2RHUTVxV1c2ODQvUlk2dWdKVDY5TmwyL1J5SDhpSmVtSk5kRlZN?=
 =?utf-8?B?ZCtScHJ1cDRZYUpZTW9KQ1ZOeVBDTXdpaU5nVkVER3d5SWEwTWhlOEt5NmdY?=
 =?utf-8?B?RTRvK1NwY1dtVDlMNmdHR0VOMld6a2VhU3c2bDJyd1lhUlhsZi9HdUZ1eEdu?=
 =?utf-8?B?V2dqazc2Sm43akR0MGlTNkw2emo4Y1hKSTRJZVBrQ3h2b1pSanVCeGswc3pp?=
 =?utf-8?B?bWpxZkxiSUpYZGJXc2FZcGhtc1FyT1FNa0RrRFpZd0JlK0NES0J2eDU1VXY3?=
 =?utf-8?B?a3Y3N3hjeVk1TDZ1YTR1RjBvV1VOVGJoMWlFVjRoWXhGRXRxOFBoZ2o3OUt0?=
 =?utf-8?B?cUQ2OEE1SW4veVU1Q1dSR1p4ODFXZ0VZQTFjNmg4RWVBQStCTkZib0NYUVo5?=
 =?utf-8?B?SG1PZ3plQTgrR3MyMVArdVZ2MHEyRzdaRlFHN2xWNXM3T2dpMEU1c3VEU01t?=
 =?utf-8?B?bHVhWFBZYkFPeHliVFF6blpMMUhjOW5yTWtpWTkwcVFlRlN3Yy9FbzlHZXJW?=
 =?utf-8?B?YVNqR25qMUZsWHdmSnVkZHJiQmtnTUlxZFlhUFdoRDNHUFBMRisxQVlCTUd1?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9DEB40F09668E4DA7F84BCBEE98DE09@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6411.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76e6a10-9aa3-46ea-c189-08dcbac559ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 11:53:15.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXkBkZZb8f5L10mgqUMzYuZmv68zcwtJVOed7qLA7nFPkKHOzVJcwl19LWR/pW8V5IGuwZPzzdGDA+VyDFNVVK3lNlHC9pJmaV3XYnWGaz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7144
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.934500-8.000000
X-TMASE-MatchedRID: pBwXUM+nCwv4OiVTWoD8RCa1MaKuob8PC/ExpXrHizyqJWkhwhbq6y1X
	YnltZaZnEc8OveTE8ieRzsbMusikMzT7rmcnNv1sA9lly13c/gGeimGtNywjtpsoi2XrUn/J+ZL
	5o+vRV7wDpAZ2/B/BlgJTU9F/2jaz3QfwsVk0UbvdirxFVpmK9X/9YGKPF2d6S3gzjU+Nt/WNvm
	KoTbXWXRIk2wMXK+DhKic56Zsagdo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.934500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	689744E5E6DDD99F52EE1D3B2F10C4D8C7138C5708A2CEA633CEC5574F5187A72000:8

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDEzOjEzICswMjAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiANCj4gVGhpcyBtZWFucyB5b3UgYXJlIHNldHRpbmcgcmN1byBrdGhyZWFkcyBhcyBy
ZWFsIHRpbWUNCj4gdGFza3MuIEkgd291bGQgYmUgY3VyaW91cyBhYm91dCB5b3VyIHVzZWNhc2Uu
DQoNCkkgdGhpbmsgaXQgbWlnaHQgc2ltcGx5IGJlIHRoYXQgQ09ORklHX1JDVV9CT09TVD15IHdh
cyBlbmFibGVkLiBUaGlzDQpjYXVzZXMga3RocmVhZF9wcmlvIHRvIGJlIHNldCB0byAxLg0KDQoJ
c3RhdGljIGludCBrdGhyZWFkX3ByaW8gPSBJU19FTkFCTEVEKENPTkZJR19SQ1VfQk9PU1QpID8g
MSA6IDA7DQoNClRoZW4sIHdoZW4gY3JlYXRpbmcgcmN1b2cga3RocmVhZCwgc2luY2Uga3RocmVh
ZF9wcmlvIGlzIDEsIGl0IHdpbGwNCmF1dG9tYXRpY2FsbHkgc2V0IGl0IHRvIFNDSEVEX0ZJRk8u
DQoNCgl0ID0ga3RocmVhZF9ydW4oLi4uLCAicmN1b2cvJWQiLCAuLi4pOw0KCS4uLg0KCWlmIChr
dGhyZWFkX3ByaW8pDQoJCXNjaGVkX3NldHNjaGVkdWxlcl9ub2NoZWNrKHQsIFNDSEVEX0ZJRk8s
ICZzcCk7DQoNClRoYW5rcy4NCg==

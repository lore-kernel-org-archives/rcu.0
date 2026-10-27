Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793131049;
	b=sgTEu60pdx+LT4nQLEB48Y3cjnPNzJHf+iqp3RFrcryM+Uj+oJsICaicsw6LMWQLbKsW
	 VbXSkA44j//rrkxgTRrlwigCKY7Mw8Yezr/PpsW7FM+8qVgJ1vpY5Ytam1I9uJ37ga07O
	 tZMfhEU8K7IwqFtXBlyf6Sl99LGV8NLHR1Wx0BdGnymjo3flRGeVBQVlq7RiQNdHaTKi6
	 RcU/SQW8KrDa4Zul5Nu7t7DB0+gRfbGv5CB72447UjdgRa0cfvxqp3Nbyv7WPFvm+gflU
	 RTbaW+DhVgIIWXLYtl9OprV4jBpdtJPXfW1OUEdIsT82yK0Y2vWKPGOjuyIYBTETYGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131049;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mERFZWsD2BMA9arLnFadwgooZe/M60aDhGPXvH21M/c=;
	b=FkxFrCnfZIIsfYDaBLFy1Tj713Pd33jk8LHXZHz47+HDpTjMCdS77ETbAO3kziIOsHwx
	 vFFMXAAw5IuNjWwuhYNaqK9X0rYeTDUM6MVcCtkadQT4eXVweqiXqmnRXBV7dLdR3P2qk
	 Lmz+qTe5AL5XNuDxm4xnbdJNj3DrDN+ovtL+k2R6rU4cfb6R+argCAAWtqLtisWjAivFI
	 qX4CYsfqoEhR68BsWrJDSYJy7PlPGBYO83h50eYj9MI3ToUMyKgtSZLUK1K72YnT0KRcZ
	 WMRHMgIOoL7b0ySL3ArlyuG8nNLIc9cdtOhYgL+BSrep4TuZMAkaOBgfUXLaHmd4xVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GFKJXkr1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.136
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021136.outbound.protection.outlook.com [40.107.192.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BE606A32C;
	Tue, 27 Oct 2026 19:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143BE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GFKJXkr1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMV5n9qvgPD2rgl30+hUR57kM0RMq6kkGaDkiYB/0F5N3sTzE4XN7NZRuNuwzMtS1l7bG71EOF9WlZEbimMX4c94NeJJITmW8UR62pVs+3xcP2Ztgbl+abDox4vgjaLA3JKB35vx6H43eaU5oneBmpJDygwNmXFsfYrWLkYKsd35BOmpggKbDSzD1lDjqPdSMe1rMmmD2NMZYru4vrEStjjZCkRpcLx35Hxgc9h8JxdETq71AZPn2cm3xQjll0/+zWAFyLTbvEMvIFqDNbMWtK4KJW7gan4wSdmMjrqqIHIGgQhCQfcybM41D19l8+LdTuJEj7AnnUiFIQFbfOOykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mERFZWsD2BMA9arLnFadwgooZe/M60aDhGPXvH21M/c=;
 b=i9GL702r2HSL37NsI5OPFPOC7yEw7APXy1yQMY+7NVID51bWNgUdpZxdO8rjpKCYwtn54i0LrGR+ZC+QfzzxEDruC6HRAmuTlx6LNp4A6cMVVK90R2hirjxVOjOC6lEE4V3eVFM/vjwUbbtd2CIaKXORcY1V8CeXAcyWQ8u2MC9lXz8K7mAUbL/kBA2/51AxqdKudYD1GQFKEy+zblu9NEne14PHULLIzPzJ0Oi2uKofnu2jC4Lhq0TUC9furZsW2hN0H/Ot06Pz+ldvvSfkxoAD7FNddqqVOmT08R117PlDCyq3bh09GBArKYegfD85zv+kQHzFqT9vc+CBR1nmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mERFZWsD2BMA9arLnFadwgooZe/M60aDhGPXvH21M/c=;
 b=GFKJXkr1jhoA0pZt9G+nZNPGPfhOuIDoMR707eAOOgm+Aueh8VuMIgl43w5NGDPCpZL9+1z+J1YPT25weuJb+kAqwHf/UgLJ5JsHdmiOoTgRBRO3DAJdQdrX1ubVPlC76DNkSfYeDA/41L38Uj6bwN9B16C1dwGYBdWJByw3/Sr8Lgyk/umb/h9H3PPMV7HV+1F0EIoVhplus/hVzgm4x5zXw8yLnGoe22VfCsgc/dTMPswJae33nM4LlxVa+mZnm0/H8+fc6mfS0vq5yQj62ZfKaF4fILvcCGnG/MPpa42RWtn7bVbrwUFrTkXEkaOdUiO+h9NnRPdcMs1ubv2xNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB092508.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:57:21 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:57:20 +0000
Message-ID: <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
Date: Tue, 27 Oct 2026 15:57:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
To: Puranjay Mohan <puranjay@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023181940.457424-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0077.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB092508:EE_
X-MS-Office365-Filtering-Correlation-Id: e7154b83-664d-4cf0-dda2-08df346482d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|18002099003|6133799003|22082099003|261026121527099003|10067099003|261021123027099003|56012099006|4143699003|5023799004|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	+4ndcnVTxDvCNwlAR7ieTiEb1dJ1SlGjpp6qMPzwcpw87bt6ZXEBIPfjJSQYv1qq6RjceEqoQ+6aVnMVm3lnBbwM4QfPgkmx7pBj2t4hvm9hbvvvCK2eayQ2CxgHPtDYyS/fwWlztI2WLq4rIEEac/TnXg7GxU3DX0bzhWNtWuq2Nk7BQqO31qGbXUtJFGl/S/2n+pxX85cOtw8Q93Ctba43GSoxEwODkJsagLxPTQoSJ8Be/KZ74hJNZBZHlfCrmpocEPkYVTeEnwRgqyf1oc2JDpuRfAi729YJUoMLbLfq0TjF/gcyfddsI/2h4QzWhn0iynlyABDGaKbHMnZ/37BZ8KPMAKsVds1b9VrEtPaIAF4T/Rlbf1OD2hfTt2Hm4VEVQwBDtFWbj/iyOhguqJyZxepmbKS2Yna9I43N6m82Bp5+4lndjXAUz8nSgO2g115mTJZgWuRyHu0DZXZGagQRuuMW69wypqsQyWrQUVBiwkCbR1ZBdzGHdc4aogKPfOcpg3eDAD+KfTc24i28m3+8RliH9dhldlzr1GfJGf3Ipl8OzQZRgvlsw4GY+6BoCOJo4igfcJa0IQKOPkDikL0tFTNmzd/7Iw5hvo/5RGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(18002099003)(6133799003)(22082099003)(261026121527099003)(10067099003)(261021123027099003)(56012099006)(4143699003)(5023799004)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE5FWXVJNlZkOVpqSUJRWDhrTDVNOUh2dXltUGN1TWZDaG9HcTZaeEFZbDNV?=
 =?utf-8?B?TnZsdkxBbDh4WGtLTFFMYzB0UmhqbXB5LzlJTzhlS3ZxU2EzOFpGYy9ITS9F?=
 =?utf-8?B?bzdwcUNuNGhtRzg5WlR6SGhOTjh6VUwreE5UeDJhb2c1Z0I0YTIva0FVM2ZF?=
 =?utf-8?B?dHJPMUp5S1VUVkxKVjdMZVJmbzhTc2h6eTdvOHdSN0FTbTlaQU1iVllHTlpz?=
 =?utf-8?B?Mk9JQjVRK21lcDRWT0NJK1dha3JVS05WdDVSb0R2NmxVWW9zNnNmYlF3M012?=
 =?utf-8?B?V0VuRGVQZ3FQaTVPWW8xSC91ZndhcWwxNmVhbjV3cmYvR0ZLRUtQK2pJSSs0?=
 =?utf-8?B?Z0FMdGRUYnU4d3Q4aTNHZVJWVE85SGNoZGZVbW1VdTNlZDh3Z1BFSUlYK1BL?=
 =?utf-8?B?QlFuYm5RQk5oWlZCbU9EbWtweXllY3N4UC9rcWxWUGNicmVzMFZyMXZncWN4?=
 =?utf-8?B?N1N4bE5DcWNzT2NnU1N6TXpUVzFpV3FtZ1NMa3RWSWR4cC8zajJSM01ydGMx?=
 =?utf-8?B?MWJSL3BxOHNpVStTdkRYSnBkWkp0a2tVdjBBNHQ5WFoyTVBYUllQMm55bzFm?=
 =?utf-8?B?ZVVuUEt2VzJsQWNnaXQyL2NNanFJSGJOT2RmU3lGaXVTVzFQQ0wvY2Q1QjJL?=
 =?utf-8?B?R0N6ZWhUb0h3NkVaTHFCVkZTalo2WXRiVDJFeEVDYkQ3ZU85N0tRRDJSZ3ho?=
 =?utf-8?B?V2l6cmtsWmpvT0ltS0RSN3FSNlptSHBTM0dNWmNYTzdXaGkwS09SQlhPQ21U?=
 =?utf-8?B?SDBLOWtEVEpqZ1ZkWEV1OFR3QXRqU3BoV1hWSEl6ejllWjc2azZGcndJM05E?=
 =?utf-8?B?MmdrN1F5R2x0WjRZbXVZYTJqa2E2TnJkb3VJZmw5NHp2KzdnYXQrc2tWNmtK?=
 =?utf-8?B?MEJobk14ZEoyWnB3cXY1Vm4wcVFCS3NOUkRrTlFPb3kySzU4bHM2K2RHNmZa?=
 =?utf-8?B?bUhRTFpCdG1wQ2ZxYm1xTEIwL3BYaUZ3Ujhwb29PbmloT1RTR0tzTlk2MTN4?=
 =?utf-8?B?eUZPbHVxTUM3WkRpa0lndDY0b1hNcFM4TmZXamszSFUzSXhNaWNpZ0UyRHNF?=
 =?utf-8?B?dWVIbEFVTXYzdmdZdmJtdEJKaFl2M1FhVGNQdkJEVXFWTFA1cXVwN3BzcTNm?=
 =?utf-8?B?bnhacG9vN09xNXcxUWlEQ05Xd1ZBZUVPVDJCZnZwb1gycEQ3UWM2T0VJQlFu?=
 =?utf-8?B?blVIZkpqa3l2a3NLdG94VHQrSjVVWGsvQk9HMGV2OWptaUpESXpSV2tGb29C?=
 =?utf-8?B?QlFWRVhpVTNwREp1b2F5OFlUMHpOaTlGZXl6UzdtSjVWYjN4WE8yYTZzV0Nx?=
 =?utf-8?B?bW00SXJJeGwrL1p3MEJibThVZCtaYjJ2MUNwT1hhZzRjUDV3Z3pjcjh4Zkdp?=
 =?utf-8?B?bVNvd3g1VTdiclI4WWZQVDVvempWenFVbnNjUEpOZ3RtNy9mQUt6K0NJV0JX?=
 =?utf-8?B?bUVlWjZIR1EvaUdBTFpaVEhtdHhiekxta2NXRUYvM05xc3VVdjYwcTE4MU1n?=
 =?utf-8?B?QXYxK24yeVVKM1VhQ3BSWGZDT004VTJhYjh0dUE1VkRaNUNuaytVNzlicWh0?=
 =?utf-8?B?VHFzZGFoL3MrT3g4TWtMa2E1N1ZRclF3bm1NMEprMVR6RXJiRmJwcVdFdVBK?=
 =?utf-8?B?RGRZc09IZG8vdW5PMit6cFdKMDMwdnpOckExUE43QUxSV3NIbzRINDM0MFhW?=
 =?utf-8?B?OTExQzA0TEdEQkVnQVJBZ0lHTUttU1JDekZhNGp1NDRwRVptRFl1MTI3ckdS?=
 =?utf-8?B?M0xtRUpPSm0rTjA2dmFheHp6OVlCOE1zUlBzMW5jaWdIbWIyNzdqQ0NsTHNn?=
 =?utf-8?B?WE5BdDhxR0xLRTJkNmpxekNKbSt4QWpkdVNiRlZvTlFrVGZPSnFSOHBPeDUr?=
 =?utf-8?B?OXBEalhYSnpHaXVtYnlHOU1RcVlNZm5RVU83djBodjdQK04wOVBaVVpScm5H?=
 =?utf-8?B?Q282WkRCNmFPNGs2ck5QMFl2ZGtVNzZON3QxaURLbStOYWVnNFVoamROb3FN?=
 =?utf-8?B?WjRYRTlTUUNnVTdhTUxvcFVxbmVCWEczRjF0SkZxSkk4Z29pTGpNd0JMazBG?=
 =?utf-8?B?Mkk4S1h5Yno4dVVwTjBGQ1cwTU5PR2hKWVdpY28rMGx6WjNTdFZHY3hTcTFp?=
 =?utf-8?B?Zys5a0JaY3QzS0Y5cTBZSXNta3FvaVVLMVllWkovdmRyU295MkV3T29FR2NZ?=
 =?utf-8?B?Z2pqY2FVOXdYSVVBWktWNzBsa1AwU09nSHNidE5SNU42cHZiMkg0ZFRoZ0Jo?=
 =?utf-8?B?eGJTYUNiS2VQUXZYeGRjSjRyanRCVzM2MmRsYzBvYS9DbXV6T3JFbVJNZXZW?=
 =?utf-8?B?YThYa053VFZQOUN5M1ZsNGJKLzdXRkoxcGtPYWNiUVBNdVowZndsR1BkWStS?=
 =?utf-8?Q?2TP/ro/QqKIGSbPw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7154b83-664d-4cf0-dda2-08df346482d2
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:57:20.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41PVuKOdvy9GB7eeTKHQQ2v1A1gvnUODgLzGup7eR0KrKshNQRKbr8VsmcIrB18TnR+iY0qVvNR1hEE7+AWjlWC+UK9YW5nDaywPH0+4EUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB092508

On 2026-10-23 14:19, Puranjay Mohan wrote:
> Hi Mathieu,
> 
> On Fri, Oct 16, 2026 at 09:33:07AM -0400, Mathieu Desnoyers wrote:
>> I'd specifically like feedback on:
>>
>> - Where this should live (kernel/rcu/, lib/?),
>>
>> - Naming and API shape (descriptor + records),
>>
>> - Whether the Bloom filter threshold should be a config knob,
>>
>> - Subsystems where this could apply.
> 
> I went through the series and ran the KUnit suite on arm64 (QEMU/KVM)
> with PROVE_LOCKING, PROVE_RAW_LOCK_NESTING and DEBUG_RCU_TXN.  All 59
> cases pass, and herd7 agrees with all 21 litmus tests.  The
> install/flip/settle ordering and the descriptor lifetime look right to
> me.


Thank you for the review and testing!

[...]

> API shape: every rcu_txn_list add, delete and replace allocates a
> descriptor and frees it with kfree_rcu(), so all of them can fail with
> -ENOMEM, delete included.  That is hard to use on teardown paths, and
> reserving first only moves the failure.  Since a descriptor can be
> reused a grace period after its commit, have you considered a small
> cache of them, tagged with start_poll_synchronize_rcu() and checked with
> poll_state_synchronize_rcu()?

This question is really the crux of your feedback. There are many options
to explore here, and it all depends on the user expectations. Let's focus
on this one and keep your other questions for separate replies.

First, I suspect that the "add" and "replace" cases could fail with -ENOMEM
without too much problem, which really leaves "remove" as problematic.

The problem with the cache of descriptors (which I've done in my userspace
implementation already, a per-cpu "txn slab cache") is that it does not
fully address your concern: a thread doing a batch list removal in a huge
linked list can run out of pre-allocated descriptors before the grace period
ends and the descriptors are freed. How should we handle that ?

We should consider the way struct rcu_head is designed for call_rcu as a
precedent here. The tradeoff is to accept a waste of 16 bytes within
objects to make sure there is no memory allocation needed when call_rcu
is invoked. This ensures there is no situation where the caller may need
to block and wait for memory to be freed when invoking call_rcu, e.g. in
teardown scenarios.

The basic question is whether there is a _hard_ requirement on making sure
a list removal operation *never* sleeps due to memory allocation.

Another open question is whether what we want to prevent here is only memory
allocation, or do we also want to prevent blocking that waits for a RCU
grace period to complete ? Or RCU deferral the culprit of the issue here ?

Here are a few takes on what the user requirement could look like:


A) Allocate on object creation, no allocation on removal (hard requirement)

If there is a hard requirement on never allocating memory on list removal
(not even GFP_ATOMIC), here is one possible option:

We could embed 2x struct rcu_txn_record into each list node, so it's already
available for the eventual removal. We could then change the txn descriptor
from a flat array into a piecewise scattered set of 2 entries records
(one pair of records per pre-planned removal operation).

This wastes memory during the entire object lifetime. This could sit on
cache lines separate from the hot object cache lines. These objects would
need to plan space for the rcu_txn_group (the selector) so there is really
no rcu-reclaimed memory allocated for the transaction descriptor on removal.

The space overhead would be 4x larger than for rcu_head though, we're talking
about roughly one cache line (64 bytes)­ per object for list removal (2 records).


B) Use a preallocated per-cpu rcu-txn slab, allocate GFP_ATOMIC when slab is empty

Another option is to consider using a per-cpu slab of preallocated txn
descriptors. This suffers from the basic problem that if a user pushes
hard and depletes the reserve, we end up in a scenario where we still
need to allocate from that context.

Relying on GFP_ATOMIC allocation could help, up to a point, but this is not
bulletproof, as a user could also theoretically empty the atomic emergency
reserve as well.


C) Require user to pre-reserve txn descriptors in contexts able to handle allocation error

I've actually used that approach in my userspace fractal trie implementation to facilitate
error handling: each mutation operation first reserves all the memory it needs for
the rcu txns it will need to perform throughout the entire operation (e.g.
insertion, removal, rekey, graft...) so ENOMEM can be handled early before any
externally observable side-effect is done. This requires to carefully design the
data structure mutations so they are split into a planning, allocation and commit
stages.

I find that this approach was a good fit for userspace, but it does require to
allow "removal" operations to fail with ENOMEM if there is no memory available,
so I'm not sure how applicable it is for the kernel.


D) Use a preallocated per-cpu rcu-txn slab, synchronize_rcu when slab is empty
    (sleepable caller)

I would expect users to remove list items from within RCU read-side critical sections,
so calling synchronize_rcu() on the same RCU grace period "domain" would break this.

One alternative there is to consider having a different RCU grace period "domain" for
RCU txn, and wrap all accesses to the txn descriptors within that RCU domain read-side.
This way we could handle OOM by enqueuing the thread hitting OOM on a waitqueue associated
with the rcu-txn slab, which would necessarily be woken up when RCU readers of that
rcu-txn domain complete (typically in a short time frame), and the call-rcu worker moves
the memory back to the rcu-txn slab, and issues the wakeup.


E) Use a preallocated per-cpu rcu-txn slab, synchronize txn descriptor reclaim with
    RCU (steady state) and hazard pointers (OOM)

This is basically just pushing idea (D) further to remove the need for sleepable callers.
We surround the rcu txn proxy pointer resolve with both a RCU read-side critical section
and a hazard pointer slab address guard, thus protecting the use of the txn descriptor
with two types of critical sections. The resolve would run with interrupts disabled.
The "resolve" path of txn proxy is not a fast path, so we don't mind the extra overhead
too much.

On the "remove" side, we typically have plenty of preallocated rcu-txn from the slab.
In the common case, we keep using RCU deferral to free the rcu-txn in batches. This
would implement a custom per-cpu pending list to enable the following "stealing"
scheme.

In the rare cases where a user empties the slab, we move to a more aggressive
mechanism based on synchronize_hazptr: we "steal" the batched in-flight RCU txn
reclaims so we can fast-track their reclaim after a hazptr synchronize. This would
all be using busy-wait and the only contexts we'd wait against have irqs disabled.

The motivation for handling the steady-state with RCU is throughput (no synchronize_hazptr
on the typical "remove" case). Hazard pointers then handle the OOM corner case without
requiring sleepable callers.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

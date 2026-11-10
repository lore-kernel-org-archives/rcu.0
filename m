Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324391;
	b=1mfPqlmj+OmRdbghOkEfL5LTnhhEkxk6ttgV6GDoh25A+GfjNpNGRLDG51TdmOUKsViI
	 zYn1fD9IiJTPbvvi0xE5mwLUa7S222lcKAv3Qywx9xd56tI7hFVjFCD2KBtF+hs5FOjVF
	 nmCqNVxAai33UAwu21+1msV5r3aGsNztzEBwUWh+pttzHUkgXoQGi4VkWT70w47E6M0/n
	 w/3k1ElIpxQabE6nTR4K5JH4jUvEq2GoZB10SKmoGKVk2+PZND9LscJgzbzwtKG6Oy9PG
	 zzvy+2oJKgPYD3P0KW6WIf1GWCHGq0wQ4IgXwax/JTGTHHt2d7yWu6M6HaThEM6M1OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324391;
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
	bh=jYNqoXBMQ6OiPrgVInMShk+pMSZi9oJHw7xFBYWKFTw=;
	b=zAeYYhQ+7w3I10jBPNpvH+Fr7rUOdj0l9BRF+4Dr6z1ERjY6Smo0mj/UMC9p7otHlcwO
	 Txc1t3sTEdMFrGikY36tXvetsA5BPHXGwJVTuf/BmY1uQeaQ4Z66tlbZ2N/rXJyAxgEJT
	 RGzT8f07OWihyGiaYaMYUjauhP7BQWo+1U7/R7BxeNibISRiVYns49varzduged7FyvqL
	 eHp+ooufapcLQRsP3zwaE7LwYf82q7qFUksosT49HfL9z+cwGFvTV2WVivRMBjnF88Vb/
	 97ZS6hK00+bhxEOHrKETlB9c5ZSvxFfTR68V3QaQbpwMuSfptCbuU54iAUyTx73++qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KRqJ7vG+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.88
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021088.outbound.protection.outlook.com [40.107.192.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41E606A323;
	Tue, 10 Nov 2026 15:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC41E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KRqJ7vG+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUBo9b63QV/Dd2MJSfp6MGIYgHu0s7510/dQnKBidWiM/mkO5riDHiKL5IeOlZtAodx9MZl4GkbK2N43ndUC4WFCUbMT5+W6DpbSvD2NojorZ0X5XHfI4uitPwNCCbeTx3UmaulGoMiUJgur/4db4nZQRkOPni6t5gqr7mb3oXFeSZOOiV8XRgGscEMzWfuERJ3v332mwxnxjYrMFAfN0sVm2MW1YeH4Mp8LxvUyyxRhRkhJ0DdZEQ+DsLfldKe4wpGdGIuxoyBdU6vDMlr7wwVrBxlLoP18ye/7m9uuHH+TPQV1yPnUMmlcEe9EF3IiD1b2NeUb7izmUdxhgpAILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYNqoXBMQ6OiPrgVInMShk+pMSZi9oJHw7xFBYWKFTw=;
 b=PvotXIqnGh1f5hwUWYnvEb+RMaVw0rmXyoZgo1UZZUUrsCdZJMjHplvIsX8WPTIQOqs4MAyPmPxZ1xqIPzldI+6kz8bl0qSdN8gU2BK1EvdALe+HNQQw6pyf76TIR7Qps3BCiPofg3Y7Igig5s8r6Xnjd23uKJ4jzeRq5CdC92wGOHkAmxJvKfDFhmHrtFKxEziRKRRH/j0VgE96DUOU3cpzJvHRawvUmfc4B1IvmHi2UdPmsR651ZKspGQUcLvoJuAD11k6Njrs0mVI45UTSU/unwh2s6IwRtM/uclMHbv8s7sJmmR6+4ks8GVGi6zYQmKP1Gys2xTYglBDgHJ3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYNqoXBMQ6OiPrgVInMShk+pMSZi9oJHw7xFBYWKFTw=;
 b=KRqJ7vG+tQ/8tJrOooXaaqb4WtYrEHFwFz/nt+VQVNfkXK2FzSVchvpPaie1qiwn8XHyOjH6GRabR9PSdQV1wrfxL9KZ6QHG3kkQXd2KeLTCSG+1/3EHRsh0ycoZ93FdBbcDVKwkJfA3v0ywa9EOXFgBi+OrmanNkwFUa5VicbYvzbXktEbmJTiJnT7bAFYNaFGU/8zYD6NHd+PQO/sGM+RH3U9diwhpcrxsjyvsSiYH8qliFDdDD1AierrgqFBi1qD9tLObxX9FV5P7V1kZt5nzD0R0GlArJTIqkmRTPcVEPePicPlJVyF0+UNkwYV2kF/Ps7K+r+gA2et3S/E1kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB11574.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:156::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:26:27 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:26:26 +0000
Message-ID: <cf8bf913-1bf9-49d6-9749-8631cee1604f@efficios.com>
Date: Tue, 10 Nov 2026 10:26:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
To: paulmck@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
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
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
 <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
 <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>
 <3cb75140-1d10-4de3-86e6-c9d70edd2da5@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <3cb75140-1d10-4de3-86e6-c9d70edd2da5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e2debd-d1f1-485a-d1cd-08df3f3efc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|56012099006|5023799004|22082099003|18002099003|6133799003|10067099003|261009223027099003|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	FZOhIy0aQMJCsKrqUAg62UUxzAZmNf6ukwbXcAM5rx2O6xDaMhOI20Q9N43Pjt+4pgjhADkr9JrEpHFTpp4JllbuHFfX0DNmGCr2k4kFO4GgKmOn7ecWFqEkvygbEUJv5GSJuk//NV3ymgPUBjM+MSpLk/tQk59djgkLuWpMSKFEfyeTrXSIO8I/1V34zBE45s7065KP7PwoUd1dMHN5veds4nTe8i7pUxRZSBHi1ZvBKeatqo87HNZLtdprtmWgehXBqM3989K4thQUKJ7RBnrJLYlx1/uRJQdh7A4i7o3mH3ypF+sExTU5ZnLn3EUdiO58vRBsySEos87bGdNVb+8eojg2Lf+BaerCXHURJvkSG/L6sWZ+ro9XjHypb1c2G0nigSPnba11gmq07PCcrd0uQICjsIex9FVYi1sIcMTXnf9Yjk+/EKtDqYonoYfYZsnOw+fWxX2GadROzWjuiudqJkeG97VTH0H/dRJlQgr7oLkw2SSAfZu64G/QNLUra2RL+MuSiROg4o5aTW8mKADmNcluyLVlWA2DMXMwcPJRj3N6fq9vgmtRBRfg8HhZyR7n4kNtUQMELNeijiQP53hYK2XQ7mTgXcyRO65cL4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGcxKzJYV2RRbzhNeXY2ckloQzVmUTczNEFibzBhSkZTbENnMEVEWWRnNi9B?=
 =?utf-8?B?djhYV2xtT3FQWGZRcVZEUFFkY0d5NnJSUkdiand1aCtzUm1GTGlaVE9zN0dS?=
 =?utf-8?B?N3JSK3hoWS82SVlSMTlJc3g0bGdhT3hleGtGM3Y5QUhlMmFPTm5NSHZMeWl0?=
 =?utf-8?B?Ky85ZkJJYUowQ2JMVlBicDdEY28yeTFDWTVsS2U3S0IrbDh3Q0tRQmdrekFa?=
 =?utf-8?B?U0paWUkxMC9qd2cyVUlHU3krNUYrQ0I4L3VJeWpKbUJIdVNaYnZYY1d3M3Bi?=
 =?utf-8?B?dDVxQk1tV092UkFsNi8rZStweUk2dE5sV1YyelZ3bDNGSTNuYkdFTDdsMEZX?=
 =?utf-8?B?VkVrc1VuaWJSenNzZmtWRVdXZUwyUExWSURtQ3QzdkFSUUM2SkswSVA5SUlq?=
 =?utf-8?B?NmY4bzJoYmRJZzY5VE9HazdWTmkzTE5YRGNMMTBncVVJMVJveVZ5K2djOE1i?=
 =?utf-8?B?M2ZlbjlDREh5NDVqcS9KdGxVTGc0RHYzV25pODk1NUN1V2dqT3UxUDdOcW5l?=
 =?utf-8?B?RDVpU3VrNUxuS3BoS3BHRlpsNldoRXJ2MGIvZHRMWkNCWk41WG11aHV2WXhC?=
 =?utf-8?B?VU4rR1dGdG9BSTlHNGNxUzFGSnUrVlJHVUIrTFIrc014V0hpcldTcHNmbDhG?=
 =?utf-8?B?UTlnOVhoYTY2VWtXSkkrUENFQVZZZzRZSEdGUUhTVnJieTZJVlpxTHRpM2pw?=
 =?utf-8?B?dUZEd3dxT2gxRGNFclJrWmE5REYrazlDZGEwZFVCNktwc01IMG5aZmkrODB0?=
 =?utf-8?B?SW9lRUtiSTFyQWpubGVHcm43cm45VW05cG83UkhudDkxK25QbHFwalgwVUNN?=
 =?utf-8?B?NFora294dFl0UTFwNHBwQXZidjNjeUVPUDJpT1NJL25hU3NNTE80VEgzVHBP?=
 =?utf-8?B?Y1NDK2VCMHlnekpjenQ1OXdINVpQanU4MDdBSTVIV1ptZTNQUEJLVW5Gd2FT?=
 =?utf-8?B?RytQaHpXTVZhYjN5UVZ5ZVpQN2R1bm0rVzBYdXltMEVKOFAyRGVvS2ROalNq?=
 =?utf-8?B?L3ZQWlRLc1lFTjhVbURyaktwWDZ2RGpEN1NBQkI2UHI3S3pRbHhMdHlzWkJH?=
 =?utf-8?B?eXR1eFhkNUljTW5GRlN3dUtkZVBzLy9lY090THMyaWRQZVppYXdyUTJnbURX?=
 =?utf-8?B?bjMzV3lST2ZDb0JNYm9iTTVJKzhsN0sxdlhXVXg5R0liU3Y3MkVTbmFyQWY5?=
 =?utf-8?B?ME9EMGZFZHlNSkkveERlUi95b0ZHNXdBVjlmdEYrUUFMc3FOSEhTckd5U1gw?=
 =?utf-8?B?ZUdIdGZaT1JEY2wzVkREN056Ym5KdFdZV0tEaG1oVjVMZlBIME0rRFdnbTNX?=
 =?utf-8?B?SVNBRUV0bWhSdmdLRHFWcVRubzNTWVVQY2IvSi9xZVNzZ29ya3B2cVVaeVdZ?=
 =?utf-8?B?VENVdVFsd21nSllmcWF0c3FMbEt6ZnNEUzVDL0s3N2tnT05CUW0wd0dpUXlm?=
 =?utf-8?B?UkV1SGpLSkRQOGlwNkhVbi9xRTJWQWttaTE5TGxOelNIRU9TRmJkNkZ5RWFI?=
 =?utf-8?B?cmtqcnFvZXJHcmQ2N3JaNjZiZStiTEVOcVdCQkt6RzVtS0laeFdiRFVMdUJJ?=
 =?utf-8?B?azc1c0VNcXJKWm1sYTlmMDZDYUUxLzh2aE9qZWJodENoZVIybURmNU5UL3BV?=
 =?utf-8?B?UGthM01WTUVaNHBGWnVVaXdOMml2MHNZVm9ldVNyTmI2UCsrTEpmS0xJbUZ4?=
 =?utf-8?B?b0xEdzNpT2pZQUNra3NBVHAvbGdJU2tGd1U0RllkTTliWXRkU0VVbDJQYXpU?=
 =?utf-8?B?RmpmZzFOU1EvOEpBMnUyNVdYVW51OVdTTFdiQVdMd1I3d2xDYU9BVVFOOCtU?=
 =?utf-8?B?enpOVldPRVNmbUVKNk1mZ05yT2ZrZnZIYXFqWUdqNW8vL2ovRXN0ZkdhVXF5?=
 =?utf-8?B?L0srSVRpL1hUdXpTMUtJK0FvM1VUWnVOUjhwRDhaNlM5bjNIYjRXcXVMNWtS?=
 =?utf-8?B?S3dWU1RsNXdqanFxNXprTkZVVHJ3c0JiYzlDU1Roc3ZLTVRZazQ4SXJTUjBL?=
 =?utf-8?B?RHR2aXZWVkJjT2ZaQlRlWktpUDdpdndFZDVjUHR5ZEdkMk5QWlRrRXVGcG93?=
 =?utf-8?B?dzdqdjhVc3RISjY2T3c2V1E1Q3J0d3p2TldteFBCNnQ3VXBweGt2QXFkZUM4?=
 =?utf-8?B?VGpvSXNNeXpwZmtPMVNQdWdUbVpEeHoybnlPWTllU2ZXcWV3MFZCWFJidkZr?=
 =?utf-8?B?eW9STUlTYUtBVm1YYU1WUVIwaUg0aHJpVVo0K2FWU1I2UVU2QVU5QXRoVmdI?=
 =?utf-8?B?cjdzeTNzUXZxU3BHa0xTRzQreUlLUFhRbFA2VXJuK0xRajdrd2F5MkZXRi9a?=
 =?utf-8?B?S2xjOTRVZ3hNMHdVRmt4d21JOFpkdDhXTkZaM3dKdUoxVVJjVnV4eEdRZyt5?=
 =?utf-8?Q?XIeaUodLCDI/LdgY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e2debd-d1f1-485a-d1cd-08df3f3efc2e
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:26:26.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IduORo87WwAI6Xt/BUvwxJoVIdaWyP7BK/uNB4WXJslp0FyDyatjuwN7nXhhg/6R9mtCyOkZb4AuARkSfmLmC9NFyUWBB/3QhydMqWP1Rko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11574

On 2026-11-09 20:34, Paul E. McKenney wrote:
[...]
>> Would you prefer to add these two variants on the SRCU side, or should
>> I prototype them with the next version of this series?
>
> Your choice!

I'll do it. Adapting atomic SRCU to these needs is much more
maintainable than keeping my own copy of nearly the same mechanism.

> If you would like to do it, the trick is to make srcu_read_lock_atomic()
> and srcu_read_unlock_atomic() invoke __srcu_read_lock_fast() and
> __srcu_read_unlock_fast(), respectively, instead of __srcu_read_lock()
> and __srcu_read_unlock(), again respectively.

I'll start by making every atomic reader NMI-safe this way, as you
suggest. If David objects, we can still change it based on his
feedback.

> Then there would need to be an srcu_read_lock_atomic_irqsafe() and
> srcu_read_unlock_irqrestore(), which would (as you say), replace
> preempt_disable() with local_irq_save() and preempt_enable()
> with local_irq_restore().  There would be a flags argument that
> as far as I know requires srcu_read_lock_atomic_irqsafe() and
> srcu_read_unlock_irqrestore() be macros.  It would be good to share code
> with srcu_read_lock_atomic() and srcu_read_unlock_atomic().

Agreed. I plan to name them srcu_read_lock_atomic_irqsave() and
srcu_read_unlock_atomic_irqrestore(), as macros sharing code with the
current pair.

> And kernel/rcu/rcutorture.c would need a bit of tweaking to test
> this new interface, which should be discoverable by looking for
> the code that tests srcu_read_{,un}lock_atomic().  Maybe just make
> srcu_torture_read_lock() randomly decide between srcu_read_lock_atomic()
> and srcu_read_lock_atomic_irqsave(), and have srcu_torture_read_unlock()
> follow that decision.
>
> One potentially tricky part here is that rcutorture is not set up to
> pass a flags variable from a read-lock to the corresponding read-unlock.

I'll look at the rcutorture side as part of it.

A later version of rcu_txn will then use these readers, instead of its
own per-CPU counters.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

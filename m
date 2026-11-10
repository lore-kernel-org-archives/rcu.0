Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323563;
	b=f+xiRIM0n1Je/wKvht+IMoBdZAPX8i6+xUuLaLN44k5fhs3Y+ICv41eyZF+UsBegY1XP
	 ftMSr4P4j3QxcnnTewCUyBWNo+JcUNeXAP9apjVYy8mzoKDbCcS8id9IHlTkThU9BE9Xp
	 fuyp63/MzcxMMZpMjTSywqHe+inpGPNS+BusqaB+6kIdbKOPakb3vIf4Uzj4Ny5nQVZeH
	 3621MqF5DXrITC4lUP7MNWFRj5LzAPQt1vyAX3P7LHNii5uDz55qPhTqPc1ldWmkbHnTM
	 S8aV/qlylspeIaut7TxO7oOKo4vAVLZWyTugfchjdqWV1xYsf5EGL6vE3bh3kUFautA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323563;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=THz7fVG9KiQc0opTn4tN1Tm9uQzXM2jeXNNZcGEfq9g=;
	b=xVBJjX7P/WXOIDRi+WePWk2NGr1/qpJjiuG65koORQpRR+ByltRnWhcv7ny3UKrGQea9
	 h3YloDPJmaDasnZwp5ZveDYcxtSrYlDs7+fl3lPpTYiScIcxMeuWXjPd4hWYEAp8hJXzf
	 aoXDOnLxSB6yunWJOnX9Z0gbLJuSlbZjnv7Xeb6kYyv7F0jtlwxQ2VMspL9nzDS5yL463
	 wMYZu7NsReZozJwhmxQ8aiGmjOWoeGWAw8oxIBh9uWDE/MFmhsjJqj0oSNAN9szLQOwx0
	 8OFl3WLWL/fzXSqERYPoMcE1MSgHmjasBvSl2WqbP2aYA0xc1uNoBSLR4Q84dLUucjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dWgDmtUZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.92
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020092.outbound.protection.outlook.com [52.101.191.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D5606A335;
	Tue, 10 Nov 2026 15:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450D5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dWgDmtUZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBuv0Qv7POXV3XnWrLEn2mwLzXW0bfJxZYMhBBJqP3mX7dlZG7KKDkuQQzsQxAN/roTGpvszJ1fN8UqCNUmnF3W2QDdBQIESBdmWRfejfTt82jP7U3BBByASP+4olLzlZiDrgR7cP21YovzoY+XtdCZu80lDF/myDIueleYcAHIqCrImUnydxH0RSy0K678S5D4pddBxg0SsRF1CruwGmvsErjDu17Z84WtBm+vQB21Ag++yn8xybS1QFZ/Bc4RovVg6OaTCKY6f/aIVkuN2oRfWkKnqCrTnBcJJOYfSxVZMbfAZfGCFabXhb1vMCeG+P8pFMIsx3uLrdVGn0+pwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THz7fVG9KiQc0opTn4tN1Tm9uQzXM2jeXNNZcGEfq9g=;
 b=h0kXnRikWhuGaX2WEt6QIpBJy3ACeQxgxli95Nmq+Ss/e3A07nHv2VPfEvfBjFZL38cs0jFnxTqepo7CRVEBCx2n21+1hreGXyg6N7bSPK4WVBGmiJ9CiZ647eJHek0UCZrUfaiqH9QmWKJP6puEfJakbOXmkBD55IS3t2+SgohSv81pNWRS5e7ptZgNfFV8Q243nkcjzWJ85HfRLuxBxVhtLYjE3v1RosByMOZktAwQYTxrKqb6fxw3wZwaGYWUpWwaQQL9SYUpTerwwjdRi/e5YEXNjfbEnide4yM6bDypIPb4yZwTCP9D3NiCcm+9RFqd3msqhy94O48FzqA6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THz7fVG9KiQc0opTn4tN1Tm9uQzXM2jeXNNZcGEfq9g=;
 b=dWgDmtUZLDVQGGgG+K4DdvNI+rJABOb7RfYng1wp/+1JgcycOwQuVytKkmvT8Gb9X/ZCbuEv6ULV9qeIaONDxZABGRSuAO+YgP62m6vGen4UaOdszvWxQt+K6kpw99uw8ONHoSDXzLi7OGn7sDuAAOHDTHDoJ9bngNlFpXx2cWLqxc4VRwoACybBVZWnsRpHwJf4v7BwwKwk+OYS9P+1gLAerfMWWGKPWNUYs7+cYQP1TIV/k5Mv5MD8O8dor02S8IIJj7YZg5tOBpGcvSeOkSCnAbhUReLTfNNXrP+HYD2wKALwMk2EctZJN1n5xruzHIJVyo3CA5Wz/fN/DwjsAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5460.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:12:38 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:12:38 +0000
Message-ID: <2b632221-6a69-4d80-b546-3b7387be1fd0@efficios.com>
Date: Tue, 10 Nov 2026 10:12:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/12] rcu_txn: Add CONFIG_DEBUG_RCU_TXN
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
 <20261016133319.433617-5-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-3-puranjay@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261023182218.479327-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f335b34-65db-4914-8345-08df3f3d0ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|261028144727099003|261026140227099003|56012099006|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Lge8aGJOyynjFGWuuZjXaI+CzkfbGusu4r1HFdltpHF67RKtrvQEAyuWkWuLJKWgBUjDDO4ddfE4ZEzlPcdoZj16DL7qZXF/74/Sqqlk6a/+AVuk8G7yYBGGX5PXJbs7XqSA+P3pmsvr8NEpn+VcFwwMLi/CrkXfshaAezNZvC63FHNYciW9URC8i/2+TW2/LYpIgJRMsOc3GZ5nsjT3CW2Bm0Q4JFPraCE/ol2cdD0pms6CwUD5DBs8TJ3AIEdpYD6hBVYq0JizaC59+4mff6OW+ImWzlxC0U4LKOqVLuFnvgqvPKJHUZzcDK5FX5YE06cudch1lDmp4ifuOo7YOInoA53nVToCWUR3Vkvass1gFwAN7MA2YKpbgsfwBYlT4myYc08qzHkIoHnE8fRkJz+VCQAZtmNfJTOOOr1EiJfsE1bKhceBQdJ1XAKgmHKXcKE1KLOLZWmpidJxHbGzJVEuWTQrRFz/giHpnlugNaYAeB5UH2jXACKgw8186Ve/4F1hMcJOnkwdXYWs+8oIHx9Eg+l3ZIvHXGKskdDku5l6g8yJdazGMNnlhKmyA7jBAOel7fi9zzU0BciuCDys6rDB81JEbmtye/w2znTllbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261028144727099003)(261026140227099003)(56012099006)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1doTk81Q096L1gxUGlIeDlQZktoMy9QYjdrd3RhVzUzbW1xVVhSVzdML3JK?=
 =?utf-8?B?eGdTM0ZnVC9jUyt6QXR5cDhlL1Q4WTV5aTBhaUh4cExBemtsdzViaXVMM3JZ?=
 =?utf-8?B?aWIvSXdmV09kckxmeWJvRG5JUnlQcVdMQkFGZ1hnM1pJQzdPMlpqQWpoaXR1?=
 =?utf-8?B?bEpCVFBkVW9IdWlZbktXRllEWTYweG53SklENDdicnZ4ZGFJY0JLamJBdnYy?=
 =?utf-8?B?R0lHeTJiOEVQRDE4VWVwWVFNSkl2bnFKSjdxT1pORHJBdGhxZjQ5TjhNQUt5?=
 =?utf-8?B?OWorZ09rSytpSWFtRlJ4ZlJyNGc3VzJzRDQzWXU3NFFJRm9tVVorTTRYSDJq?=
 =?utf-8?B?Zm9PcEJacXRHQ05KdmNjU3VBaGdnbCtIUWd2YnZ3S0RYTnZQU2JSZyt3Q3Jk?=
 =?utf-8?B?Z3JXU24vMjF5TEtxWVdGZERrZDUxVmwzK05EeEsvUUNMUms3TTlLODVQQ21F?=
 =?utf-8?B?anpGL2wraWtzaDYzV3BvMTNXaXdhQitZOUdLWTJMTkZXM2p3b3ZscmtoK210?=
 =?utf-8?B?cG1idkxnb0V0all6Q3dUQTVQekFpNllKQ21xejR2WkIyYXBaa1dGU3RjenVV?=
 =?utf-8?B?QTAvM0k4bFJuYVdLZCtmUTZuVGVvR0JKOFIxWDBWb0ZNeVNZeklLRGkzaUtQ?=
 =?utf-8?B?cm5sVWVqdU9Sa2huZ2NJaVZIQ3ZPYURhKzBHSEZPLzZJYU9RQm9ZL2VjRXQ4?=
 =?utf-8?B?TmgvVytwL1pvWC9keVpKVkF5UVh4M1N3M2lzdmNGT2Y4NFRQYktndTNnUlRz?=
 =?utf-8?B?SElSQXdHT0ZqZWJFVVQ0M2Z6bzgydVVPQTRGZ1NvTUpWeDNHK3lUSzltTmhV?=
 =?utf-8?B?ekNQMVcvcyt5RWZLdW9nS1F5TDFSRDZyR3d4MmFleFJqRGNad3VycTJJSjBX?=
 =?utf-8?B?THF0dFhqRWVoWU4yQTFPMzBINS9VS3F2WDl5WG50YmhuWFhjQlZMQjRvUUxH?=
 =?utf-8?B?bitiYWV5b1Q3K3dWK01HQ1JhdkhOK055Q3pqdmhGRHpDT2VicnVPTG9QZVF3?=
 =?utf-8?B?UENSeEFBdk9DelVjeEJKV1psdkwrQ2xGbHcxRVNSZ2tzMUEzWEVSaTdFWFJO?=
 =?utf-8?B?WGN6ZEF6THNlaG9qTnVub1liR1ZDMWFSTHVLZ3E5ekNQVXBwNWw2UC9SdFV1?=
 =?utf-8?B?dkFIMVI4ZGh3d1l6SFFIRTNVMVdwTlJsbVF6bGkrRkE1S3ExejFRemdzQ2NK?=
 =?utf-8?B?ZURCdFVQU1c0OXd6Qm02bkt1dEorMlpxNGZQYy9OZnkvWnZwRXNBVDFGSXY3?=
 =?utf-8?B?dlFnT0lBQlFXaDZIUDFDRmgyeFgwM0w1TjcrWEFlN05FUTZEbjEvc29jT1Vr?=
 =?utf-8?B?Y0lTaEpIdHB1QVZTVzZudTJlS0VyTkhSUzV3RlVJUStRM29SQnYra2YwRVhr?=
 =?utf-8?B?Z0dHclVvT2twL3hTNFZLczQzQXZWaVRCWmJGR0REQ1dnQUxMQzBkeHBrbFRJ?=
 =?utf-8?B?ZFVScDNEYjdkZXRqZXdvSjNLV3BoZ0d6KzlBR2JtWGxDUjdjMWFTeExwQ3Zj?=
 =?utf-8?B?d28wenlCQU1STTQ4bDhzaWprN1BNUjZyZlZRMlVnZ0xueWlhRWhIVGJDZ2tX?=
 =?utf-8?B?SWNyZkFHQTdVZDUvWU5mSHl3MjcxTEhsTnRpMzU1clVVa3B1TjlFTXhiaDhP?=
 =?utf-8?B?TjFBTzl4bUYyMURzRnQ3QUZNakJyUTlnZjkva29Vcithb2NQdnNJM3NQb1RI?=
 =?utf-8?B?cW1kWjFoa2ZGWHY1MGU3QWg1U0R2TVMyZzBicXZndHd2dDJjSUd5R3ExeDR5?=
 =?utf-8?B?bHZSeUFSVXAwYVZwZHZqaXMzRFgwRGpCR25UMzM0WmZaSm1PTEhsaml1d21p?=
 =?utf-8?B?aGdtR2Y0cW5PR1ZTait5Zkp5b3Q1Q0FDUXpVQUlsVHNjQURFTWNBaFlGNmtM?=
 =?utf-8?B?VUQyL082YzM2WWowREYrRzNzc2xKUWVEWlhTc0FWVVpHZGhXNk9NY09zNUdN?=
 =?utf-8?B?RWtscm1rWHRzS2dZTC85cnNQc2VXck5JWThsSElUSUI2eUY5RGovVzBVNS9Y?=
 =?utf-8?B?OVVHRDNYYjZ4K0liNFJ4Z1IvcGI5bXY5UHZlMDBoWEs3Vys4dlhSVU1Fa3hu?=
 =?utf-8?B?VWsrMFVlYVhucHg4UGhYLzk5RFg5dEdaRVE2WmduUm5zN3AzUUNVY2RKd1d0?=
 =?utf-8?B?R2hDSFhiWWowajdPV0wxd2lmcTZ1NUFSaWtOLy9DZDMweENCL0sxZ29GT0pB?=
 =?utf-8?B?R3V3Q3VJVnZYaThPVXpJZWhPNnNkdHJoUmRvUWZRdnVFQ2N1eUNDdTZmbk9P?=
 =?utf-8?B?WUxSQkcxazNtQTEvVUFBa1ZsVENpMjhxT2cxNHBWaXdsUCtmczg3eHV6V0px?=
 =?utf-8?B?NzdaV0pkY056MHdSMzJCTDhqaHRCZUE1dHRpQ3dFd0hlWS9EMFYvSHcwdUkv?=
 =?utf-8?Q?2FmI+11tBprD9XNVUu28XcDdz7xVExiy7MPhN?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f335b34-65db-4914-8345-08df3f3d0ef9
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:12:38.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enJ/l0xAe+X7OJO46qwyifA4z/KSgfVfWLK9JY5Az4nAmFFXkWjM0ShGQYLrF7J6DneYWD43HS83archZJ0i2lCqFzLnrY8f+y/lZRj/VHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5460

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> This can never fire: the only caller, rcu_txn_resolve(), has just
> checked rcu_txn_is_proxy(v, tag).  I'd drop it.

Dropping it is planned for the next version.

[...]
> The append path checks new_ptr for the tag, but the chain path doesn't.

Good catch. Adding your check to the chain path is planned for the
next version.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

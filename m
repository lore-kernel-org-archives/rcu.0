Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792762666;
	b=tzklCPL3fd6ISU6tSO9SLvK3NfpQXGqSyuqIgM3zWUrtiM5fm586HBxRhIqDYXLtXB+U
	 EnL44sZg4tRbEJ7LhwKOxmJPlloQLhByI+4PtUKGMVd+EvxxwG4os/6qOFmSAy125nhBd
	 Drkxb9ia8DUuyZykrg4H4tkk7Gv7SXd9mWetU6MqFKlGRKGSHxGKeQgMsOa3GtvWsshUz
	 LrcxyEY8OhGtuzlynupxiuDkRRvhvURzxeMSLP3au4EfyraESDqS/31xlFyeNSOOsW2tM
	 xtSocQ+9e+TBij84vGhsulIjhtr3h8HgNaTS7AT47RyMj6QD0dpXVw25L1ZHwlZlZsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762666;
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
	bh=tDJ/zmmRXHGLQOX2KvQGJix94Dc/PEn17H4RzkJ5OxQ=;
	b=vzSWspf3TbrXQYdji43Gi4aG/WyTMP851RHvmRn92ODuU84AslvUth81Snp9UY00o2xh
	 l9VMKufizWl6EIRox3i3xCUHGuV4KP1td4IJCpS11bEB2EQFyfIanX6aAd53vQ1fLT18/
	 qwRywzx7FjSmQxW8QQceAhK2gQnS5wte9vMV8oSgmcnWicBEB9HGS0kNnQp1fX+PB5zpu
	 zy2nUclaZFFUgBuZn13L8wR19vc6UkDceHjKyqr48wyy/xk9cJyIN8o7/JBR/D9A8wArJ
	 IHqCD5vlCs7LVk8kIQjvYdX/c3OFbfbLuU7cPFBQbg5/6uOWLJZqe8nqY6g7uLNBa2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jPUy3gUz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.78
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022078.outbound.protection.outlook.com [40.107.193.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE5606A31E;
	Fri, 23 Oct 2026 13:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67CE5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jPUy3gUz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdCgQ/SNBQ8A+dZOWoi2I6KOkyM/N9JVAKk6TGu6r5oSrQ2AP4r5sDTAlIRZBrnq3irf6s60GYyzWOSS2T+mxse6w9HINXVFt9PARK/c1ocYkTkPa1bXfxWV7m0w9ScV6bc5g6783PtuOJt+U7NHij9TdLEM7EKFUqI1iIHIzVEYs/QvGO60ulQ3VZZBJFEpfHYwyOoT0UMp46KiIWFrOMDRG+m5vTIQ58t4TEdC5H4aHsRtr9uR0uzAsFQ393itODDjxdIy5k+FUZSXYpJhoUDSHwqyx65GqLCb7FwumMp2vWFuJyAX/pwOttvRLLtNLqEGkHLniQhFINAFdIbJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDJ/zmmRXHGLQOX2KvQGJix94Dc/PEn17H4RzkJ5OxQ=;
 b=J0a49WzgB1SDp+nLPR183W/rOuhumhVDQ6TQdg6taglNh69iYUn1zWlR9B+83R2tZjuvQNxv8UyK02gjqRDZPz7fMbtNx7OogapoqaI23N/5/lUQXfZ2DYaNhFmB81P75o5dui562gI5Nbp1g5o9ZI4rgYR5EIuiZ1a7xH5WweDkXvYPeMVE/WbCFyOAQgdaXaAfbkHkharU8i3obvdxPJSUPdkVbdVnv2C2nQtQKd9Rwricvln2ZeGil+BqHDyTUa3E5y/NUssUmFKPP65fwDHoX3cjtXtToZeBhlX3vue6FHRkAVchYRrPktC4LG2qR6uSZplLIWFpTxGLT0PhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDJ/zmmRXHGLQOX2KvQGJix94Dc/PEn17H4RzkJ5OxQ=;
 b=jPUy3gUzOpyjmmbc5Dv7gfbXz9rUgE5exlKeNfCHjGM9oIu+vjYP6pR/rZQL6BgCd+39TZ7/bF+0Qj14eIPAXOR60aNR6AjyQ+VbN42VnSUeDsjz1AjG604v2FrRr8fVvH2fi8pW20+HxFa0/bnhZ/tYo8yR5N6TdfkBnqRGFXFSd8yL3VywUfZWg5q6BQLR8CUC+P9IBu1cSngV0DPS7Mj45PfM0ehT3ix1rFKr49vqpZUK30AtSFPns9pDBrqLg0N1BoZanHRF4smArDr9Fng3alW9VnQ1PS4gpMlOE5vQ1z98MxNvJMMa6o0YZ65gemYqyy2jX16J75nv3hT3MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB215607.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:37:42 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 13:37:42 +0000
Message-ID: <7f1e23a9-7d42-4a50-98d0-c932a2db4b8e@efficios.com>
Date: Fri, 23 Oct 2026 09:37:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
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
 <20261019005556.GA997610@joelbox>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261019005556.GA997610@joelbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB215607:EE_
X-MS-Office365-Filtering-Correlation-Id: f917cda0-5acf-4428-5397-08df310ad00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|4143699003|18002099003|22082099003|6133799003|10067099003|261022115727099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	4eHogdP91wkaXj8xHFeiwLY/kX5s3lx8EZj5a5MGI6Ks88I2FYCJMTGvnxNAYoxkKLokDo364WLgw9xary9HeHT4tLj7VLWbERdnEuAoGPdzN0EEg26KtkrLAyNlfztP7pIQ6bxNOsWWjk8GPezpkR2bVWYUU7sdKHSLw/sKa5sgECwMn15K8tj+bfetZdU0BZUurBrgSAvIPW0PIl+l8wmb0fM5LSYlvW2Iafx+eHsn4QpxFHYmjV5CBARvZTK8jrqEVipOm/jqm/l662e4fZIPLdBtJ35lsnGARF6D+PQKw22DWY5D9RqbXmsjJXpGs2rH1Pd2He5y5W0eCO7KL9sBhr7apNON2ecfkOPOw9Jv6sfUOi0o6shi53qa6Ju1fgo1T+9grsmfGbQFqjV3ORIbZCBYnDHsTjq4op9UbKLVW0FOCBc6Tr/aXtoK6qsH6niPYCLnkWSCsT0zS1ksCKtqBcPTrc1nK0hu7cvWq7vOGoRh7NfJClnJw1a+p2IxKFOJnlkW+ZyH1ZSUBjEa0I1ijscq/q4U+o8L4WLmgCeUjKWN+/LVdB/kfV+/tGNwSPmAGmF6GfcXUZS8JwNYQ8n+KPz8JB9A26YwKfxY3iU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bll3MVhmYkUwRkhkYmJiVnN2emZSVDNGaldEenhtUWtXdFJYRFpnc1V5RWZi?=
 =?utf-8?B?ZW9YVXVWTElkZitGZkpaLzVvaUhLNDdKMW5NcFlZOVMrM2ZOalI1cExxTVdB?=
 =?utf-8?B?MGhDSlJ5b1IzRnkvamdXVVI3Z1NsWTUzOVJOT0hBYXFUa2Q0SGhEd0U3Q0lL?=
 =?utf-8?B?MVd5cGxLWi9KMkxVRXBkWUw2RHhlaEUvNk8vdlp0RE1LNGt5N2tjVVEraWJt?=
 =?utf-8?B?RSs3S1VWRWZ6K2h2SkVVZkxybEl5YXc5WG5kSjBmNStxRVprZ0J0SFdtZFkx?=
 =?utf-8?B?VlZZYlBHZGVnRFhHNXBOYWt0L0thb2wrRkRvcVRidkFUTHBZRWZmN3l1YlZR?=
 =?utf-8?B?UWV1bDIyNE02cDg3MkloWjdYcCtSd3dwd3F2T2RkSkxaUHZaOHNOS3JING9V?=
 =?utf-8?B?TXNWN1VBeVhOMUdxUkZHVHhHZHFhYkNPYW9Uak1xeWxQTDZubW9XS1ZkRUJv?=
 =?utf-8?B?N2dFUmE3WnZHVXRyVWxzSkJoOXFiQzZyQmVTN3o4WkFxaGlFSDlxQVAvVEcv?=
 =?utf-8?B?K3BSeHB3N1JFWVJQZWs4TGM0QzAyZUorVU42cHJseU5Xd01QNkcrRWx3a3g4?=
 =?utf-8?B?RW5VeWsxaU5KeWdsTDBrWXB0RUlDRHFaek5nNU5YUUdZWVN0bGNqYXJLVnIz?=
 =?utf-8?B?R0t1QzhyQUxQaTJDaXFEbXJlT050MG8zUGx0aGJKcXBGSFJNN2N6aDF1b3Bo?=
 =?utf-8?B?dTN3TThRTjltOS9abjFSejd0WXptdDd6bXlmdXV6VWN4VE80YStJWUkvem9L?=
 =?utf-8?B?Vm9xUmNnUzRoNWhvbDlTUzJVSnRSWGRza1E2RFdGcDk5bVZuNVRDaFZJK1pK?=
 =?utf-8?B?dHNiZ2FVQVFCSmVUUjlQVjdDbFdjL1JtbEdrYmNaaU53bmZxTHN3V2pZcVRH?=
 =?utf-8?B?eE1laVlVc1BaQ1lPa0Z3M3ZkZHI3Y2dUbFBHNzhsdFJsYWdaREc1ajRMV0pl?=
 =?utf-8?B?T1VMWmJiQS8vWFEwdWJHeG1meDg3WGQvWEhmN3RKUU1rSVZrTmtiZllPbG9h?=
 =?utf-8?B?T0xzbDVkMVZTbWZqcnp0NGlUVnRQZnJqVzIyOVBoREQ4bWdFR2ZzWEJiMDZ1?=
 =?utf-8?B?Mm1wZmZqNEptY0kxQm9hb2s5Y3VpejBwVzYrcTVDRkNGYW1IZ0tRYkMzcTQ4?=
 =?utf-8?B?M1BBeGVXTlM2R3Jpb0EwZWlVY0dwWCs1eU5mMlBoQXZTYmpqWVh1M2d3VXZM?=
 =?utf-8?B?b00rMDdHTVJnVWdpbFlWb2lPUlRIMWh6YkFGTDgzK1pHTVBicVZUb2ZPNnRI?=
 =?utf-8?B?VG80VkRYYytiK0FjblRZRzR4bEF1MlEreCtKY2ZZWTNxc1B3akZTTUZISmZ1?=
 =?utf-8?B?NWMzTnBlUFJWeWVsdmRVajFCRmU1d2tlZDZQNDFtczhDL0JmV1Z2RHRTQ0NK?=
 =?utf-8?B?REJWdDNCUWJlT2dpNzFWRDl0c25wMndlNHV6NDByR0oyS3BlZjd1K3Z3RGVq?=
 =?utf-8?B?Tlo3OUxCamk5YjhJbDhZdUJpS0l2NlJvUG1UT3RYY0VHZnA5ZmhTODhlcndx?=
 =?utf-8?B?Ym5lWm5STitqZEc5MnFXZHlPTmJFNVdoWmFtTFI0UUNUeTJNeEU1U0t0L0do?=
 =?utf-8?B?d3ZhTk1TTWFJeE56WmNUMmdPdnhTMWhhNTVHM1Zxc0NrWmY0Y1Q4TDNUMmN4?=
 =?utf-8?B?OHBuZkJFb1R3Z0kvWG9xaDM1SUdKbDN3TUhINUJDQWJUNCtWdFhhdm1aUkV5?=
 =?utf-8?B?TGpxR21RVHF5eXBhbmJsdFoxSFphMTBpUkFFeUtLc3dWQzFXRGgvcVozZkJj?=
 =?utf-8?B?eldkbElybXV2aEx2bU9RcHNLU21TQWNDWStFZGgwUldQN1QxSnhEUzRuZ0Rh?=
 =?utf-8?B?cFhPbUJPSkdaM0l2eHJ2ejR0ZE9nUzllS012TkVnR0tqdkM1eWlOQmVicjJ3?=
 =?utf-8?B?NFVKdysrdWRUVENYN3RrQTBYUXFIT1pYeXMyU1hVb0wrL2czOE1uTFRJeVJ3?=
 =?utf-8?B?bUVGNjNDbTJwems2T0RnbmtkZnF1aE5pOUFnNVBVMVFjWWFDYVhJR3JjV3pj?=
 =?utf-8?B?VXd4ZGtwQnIyVDBmaTROMktVdUF5bWYrWHpZanRmQk9LS3lsbWEvYmc2eXdY?=
 =?utf-8?B?SXdjUzgzelBLMno0N05mOVNoZjJVRXJ5ckNhMENTUDY4OE5tMUZiQVJuZk9i?=
 =?utf-8?B?ZE1GbHRMcHNMOWE1TGtzbTcvZUZNNC9odWlIM29lSWpWZ0VkaHZxOXYrcE9U?=
 =?utf-8?B?ekRYQnQ5UGNER2cvejBsRTQ0TmkweWRYZEFFWnJ4N1U5dTVDOWhNZ3VIbWlY?=
 =?utf-8?B?V3hjTjV5ZEt1cm9DUm1NeWI3RUV5dDlROWd5MUFJc2xFY1c3SXhsa3NYQ0VF?=
 =?utf-8?B?K25UZ1ZpNHhDRFptdXd6c2I2K0J2YnV2VkZoTkZxeUw0aXRCZ09PWE45cXg5?=
 =?utf-8?Q?0zYivG6hFfeXaQ3M=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f917cda0-5acf-4428-5397-08df310ad00b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:37:42.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzwuKQ+Rho4OS9DxJG+LXaMTMfW7UOby4joYAdQzzy3O3igk4gaiP/yZzEAAm65cZKU3Zqr04sHa37T+27sKEPxWkP2DLJ4Q9qdCjrqpbeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB215607

On 2026-10-18 20:55, Joel Fernandes wrote:
> On Fri, Oct 16, 2026 at 09:33:07AM -0400, Mathieu Desnoyers wrote:
>> Hi,
>>
>> Earlier this year, I came up with a neat trick which reduces the mental
>> challenge of adapting data structures to RCU.  It turns out that it also
>> widens the applicability of RCU to additional classes of data
>> structures.
>>
>> This is done by a low-overhead abstraction which I'm naming
>> "RCU Pseudo-Transactions" [1, 2]. I name this "pseudo" because unlike
>> classic transactions, the writers exclude each other, readers get no
>> snapshot, and there is no abort.
> 
> Cool idea! Instead of tagging the pointer, perhaps alternatively the proxy
> object can be allocated in specific dedicated parts of kernel address space?
> Might be slower to test against though. But perhaps will make it usable by any
> users who use lower bits for other purposes.

A range check is possible, but it costs more on the read-side fast
path than a single-bit test, and with variable bounds it adds memory
loads. On x86-64, roughly:

1) Low-bit tag:              ptr & 0x1

      test  $0x1, %al
      jnz   slow

2) Range, constant bounds:   ptr >= BEGIN && ptr < END

      sub   $BEGIN, %rax
      cmp   $(END - BEGIN), %rax
      jb    slow

3) Range, variable bounds:   ptr >= begin && ptr < end

      cmp   begin(%rip), %rax
      jb    fast
      cmp   end(%rip), %rax
      jb    slow

Users that already need a low bit for other purposes can align their
objects on 16 bytes and use any of the other low bits as the tag,
still with a single test. A multi-bit pattern within the low 4 bits
can also be used as the tag, at the cost of and + cmp + jne on the
fast path, if more flexibility is needed.

One alternative I've considered (suggested by Paul McKenney) was to
use a trap (page fault) to handle the proxy case. The idea would be to
make sure the proxy address range triggers a read fault, and handle
the proxy resolution within a page fault handler.

This is a tradeoff: we'd skip the test-and-branch on the fast path,
but we would then have to make readers take page faults (orders of
magnitude slower) whenever they run concurrently with an ongoing
transaction. This would favor a workload with very infrequent updates
at a large cost for workloads where updates are not *so* infrequent.

Therefore I went for an approach which would keep read-side overhead in
the same order of magnitude whether or not a transaction is in progress,
hence the low-bit tag check.

> Btw, Pseudo-Transactions sounds long and weird, maybe "RCU proxy"? :-)

I initially called it "RCU flip-latch proxy", but ended up going for
a name that better describes what this really is: a transaction
in the filesystem (journaling) sense.

Note that I use "proxy" in my definitions and code to describe pointers
that are re-routed to the transaction descriptor records.

Thank you for the feedback!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

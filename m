Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2132.outbound.protection.outlook.com [40.107.115.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E831F1921;
	Fri, 13 Jun 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829095; cv=fail; b=uDAO8iwaIXut3F8N1VwtAYkWqvLv7Th+zs3LgnHaqLbvIkaOz+kYCeSh9HL88JyVh0g1aQX4Sene3eepavAChnESD8ZmsMZsyhPcIXbQLshMGoKCG7Bh0GPYPryuJa/AxjcW9In3Z+emJx9z43F/brMHEJIV1JyxTRJwn9D3q4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829095; c=relaxed/simple;
	bh=0hkqZZfhjOYOYo+UECmIYNm1Qs4v5qc+owcZpxmBYm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOTZCx0FK1TfIyi7h7fRDRsdtkKMAqdnsyYiD3MC4/h94YBOcG5ASlVbmhfaG+8wR67CHfxUwz3sbZtvTlWGw1a16IbYryr8dBtqYZzF4vJ5htATFxybDa1TejGC3igkxbHJScGSJYdmLvicdXzk+qbq82M5swHyi2wpeaX6+ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UGmyJq8k; arc=fail smtp.client-ip=40.107.115.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UGmyJq8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB53VUL4fmh1M0czT586SvrO4a7hgbXOHRZaXxkkhpUT9+M4f7ESK8l55DrdhphAfGr8FAFKKm9EumziZ672RsJCz+0ddU92FukcOHfOyR6Q5ppee5dbmmfPhuY/eBe1WZDIVo1wW8DzuIeyZrFSFZjpS2ofuda8vYiUTv/aGX0wt6hXtsuId0kKl/SPLL0P6DREuvXgon6iPtjUypK88cgFAIkXyyDKwB2kLVfrIAvG22vqjBH2bB54ojWoEjfRm6LPXiW6suU5Ouf2SdF/0DaqfRL6Ab5ljsBeBsViwrgESfBd85mw3dNPWQj9djGPEK0pUMx2F9Ob6shauI3uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8rkmA0xWv5fx7gXhxYvcWwDCcJpARRVW+Ybzke2bWw=;
 b=YFnp9U/hfs6hZ62s3i3H+fGTiQbDz57Ml1sr2q8zsuJQsZsb+07cUOoN/Mad3Anjmw64YlIuXO3Hm7nfeyuSwSFXxVAS0Og6cpwtfqWSFZ75tcb/zp8x4t5E1i8U+x26qzMUYSdy0NcYGw4wdmJHK3kMRk5qTiPxXsXAOW3IO9m/TgQiWfEIlPOPLzcobBj77GklgvPpvdeYv588cIojvpPvkNRyjKZvwut21Magl/n9OEKtNUTqadlp4jZI5y9AInw9XvS8eZ6uG7m7PMLgHpAxNKz0LQuNqNPJFErV3eWmk7/ktse42VGCcuw3bOouXnAw8jyefnsDHqCCe5D3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8rkmA0xWv5fx7gXhxYvcWwDCcJpARRVW+Ybzke2bWw=;
 b=UGmyJq8k2yDEahGLCoSAXJZqvqxMTCGLW30pihpDoO1RICk5Ex7aDuyHpv0Qw0J2fbf8YsMe8pZLNHZVwXk+FaQj1ZxWDX/f/7/knuHIDJLg8+b8P5Jco91UO9zidVGVTG25Qwl3+qGvaOsC2BCQ25UBetxDKE4BJpCF4wPIjMaLUluV/xwT4brFxhPWKUQJzhLngFw52qPCnxiokwMYD0d9ueli2ioScpAkxuo9WF5gei7MBiPIsXWyRph6duQnXpo1I7n33oGM6D2cSqcZ4gJuib/E9XrMS+ajOFFbXg6YTlUN09ura3aBrf5fKW3JN+DfebDPl4ugYkKsAMtn5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT4PR01MB9751.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 15:38:07 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 15:38:07 +0000
Message-ID: <e45869f6-8cc4-4cef-bc11-baa23db47d3c@efficios.com>
Date: Fri, 13 Jun 2025 11:38:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Switch tracing from sched-RCU to preempt-RCU
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250613152218.1924093-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::19) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT4PR01MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 29986c1e-276c-4931-f0ac-08ddaa904b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG5xTncxK2pLTUZ5Sld6MWQvaWNKNkQwb0o5NUZhNmpYVzhhMXgrVVlzd3Jr?=
 =?utf-8?B?RTJlWXQ5ekowR1J4Q2ZqenlvYkdjZnpiTzY4UEg0L3NhUzdtQmEvYjZDMDJL?=
 =?utf-8?B?RUdGNlVhUUlEK3BXSitIWWlkMTZXMVJqVHZ0TldwcFQ4bnBLbSttakM1NHhR?=
 =?utf-8?B?MVozSU9Wa1NOWU15TkRkemwrSGNnQnhFeFRlU2lKck5OcVVON2Jhc2NpZXZn?=
 =?utf-8?B?bVhCNGdmM0owTTBPTTQyTWNXMGhvbVAzL2ZWc1k3a2FVaklrTCt4SytQMEN4?=
 =?utf-8?B?TUIvRlBjRENEeDhReGNsdXJYbWoyUTJVQThFV0RkdFhUNXk2R0lMVXBSRUta?=
 =?utf-8?B?eWQrMWxtbkpsZGI0eVJYM3p3NFJUOG9RWndVZU14aitOcmdMV1I1eHp2b3l5?=
 =?utf-8?B?elFRUmxhd0h1NHpOT0E5RVEzKzZneG5YVU9PRlBCUVIvNzQ2VmZMSEFmR01Y?=
 =?utf-8?B?aklTTE9kdzNZNzZTUElnUUJ4cWJud1EvUDM4aVNJZUZuYjRmS3NSbHlrcUtR?=
 =?utf-8?B?TEcvM2k1d29VcFRGajR3cERkeTJzQTY0emhrUFE5MFlEdjFBRnpCeUh0bEhv?=
 =?utf-8?B?Y3Q3NXhodC8vU09uNFR2WDc3V1dIaFZFU3Ezb2pua29SMXJjWVhmcXpGR0FN?=
 =?utf-8?B?UVphR091MUVNb2ZoR0Y4Qk9hTDNxTjNJYlBXMnBVSnQxOXNYdnEycE9mM3ZP?=
 =?utf-8?B?RzNLM3QzQXFPVmxDZ2ZaQU8xVGYzMHVSSjlDQ0JHRzdZbFVZUnhFTkFLSlBv?=
 =?utf-8?B?SE1xelppVEZsUTkzSGZFVFM1N0pQNnJGVHNlZkpHR0RUblM1b3RJSFUzeWV4?=
 =?utf-8?B?WVVrY0sreW5iMkVHRFNVeWdyZWJPeG1oU3RxTDIxWVU4TDMvSTAzVFFHWk5S?=
 =?utf-8?B?aVBxc2FGK1NJM3NrM0RSc1NxSm1VZENSUDhjSUtVa1lldllFZGNvckFFbTJj?=
 =?utf-8?B?UFlhR3Mza1Bkc0RhTnlDZ0RqNDFGakZTWXNFamh4Z2xhaCtQZDB2RWhSQnBn?=
 =?utf-8?B?bFFPNlRaM3NVSlVUdGNyb0NxUXVWMlhBdzhFZGRHQmtIcFV5ZlM1Y01pU2lR?=
 =?utf-8?B?cGdPQ3ZoazI0U0J0NmQzWVYxN3MxaDZmcEFJTjJvdUV6OXZwNU5xdWZab1dD?=
 =?utf-8?B?MWRPRDhkOUUrTTQxSlM0anBKTVVkcTIwalF2anlhMXloZHYrNk5Id2d1d2pB?=
 =?utf-8?B?YWxxTXIvMEkrOU1HamdPNmxneG0yTXVFUEF0ZW1nWnNpbkJ2RnB3bDV2MDRx?=
 =?utf-8?B?RzZWdVNuRU1SRG5HS2FwcU1YQ0o5RUFkSHc5ZHAxL2xwYnloSS9oemZWT2NP?=
 =?utf-8?B?MmlrUmhObnBlRU9pNWRXVzVPRUwyR1VCRkxZa0NnYXdGc3dDeElMUklCQ2gv?=
 =?utf-8?B?UnNkaTZ1SkJDNHVDb3NsMWtiVXZ0MmdSUlBrZkF1M0lWbGl6ci9PVC96enlF?=
 =?utf-8?B?em4ranUrMDAybHpwVWJnbWE4djFGZlV3eTFpcndYeUNZWkVmeDJqbUc0K3d5?=
 =?utf-8?B?RnVwT3FNVUVIbmdSZW5PUUNzVDMxaElSWkQ1OTRsLzZveERaUUtIQTgzODh3?=
 =?utf-8?B?Wmg2QWNKWTYxdGVQWWgwUi9rQTR2bGlrOHRnT1Y4QTJNVURTd2NrcDBPZm41?=
 =?utf-8?B?Wi8yMjdaSnNiVWcrS0ZGSkR0WTZ2a1BMelBybWlUdGVXQ3VHSllFYjRQTHFr?=
 =?utf-8?B?ZDkxMytqWWs4N0ZnSUZ5bkc3NXNORVdLZ2FvRjI2bmRxNXlVQTlwQ05sR1pj?=
 =?utf-8?B?VmpoNm1VN29TK1cvbUhCQzVQbDMxUGNrV2t1MWRlRCt2NEkzWnNvWTVUYlRX?=
 =?utf-8?Q?HGvS7kN0a6dtfpXBYVuavboitJ+HpqTK7vogY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFlDUGtzWmVhdnI3QkhUL0xsNHhxa1d5WXhWcHFhMmtJVmtUOVFCUHhXM2Ns?=
 =?utf-8?B?YVpqVy9vWFdJazgvQ1o3TnJGMytnbjFTR3JEendxdGVFYUgrWERLeEhaK2lD?=
 =?utf-8?B?d0R2bk9kMFFZYlZhaDVPbGFXczR1S2N0eFZKS3l2cmhiS0tGYXZuL0t0Sm9B?=
 =?utf-8?B?VU10T0kzaHJ1TnBKSU5CTUR1dTRxNEFVWlFPcGs0N29ZbGFwd2VqYVBBcHB0?=
 =?utf-8?B?TE96dHUzK1djWVFwRlVSakxnUnA4Nmc3S2w2ZE8rRm0ydDVLZGRPTXdlVS9F?=
 =?utf-8?B?NGNVci9zTUJIbWFQQ0R3bWtVZHBHSk9TSHBsRENmTm1YQmRFYmVWVHdkZ0xz?=
 =?utf-8?B?WmpSbXJxUmJMa285UVZkWDJCa3pvdW1MbjRXelNXaG5sTHNjNE9BMk1MS3lt?=
 =?utf-8?B?cmExZUUwZXBjNUg4L2Z1eVZpQTBzc2grREsyQ2VaUHVRZ0VsMzNEaE0zWFZp?=
 =?utf-8?B?SUdSQWhVSlFxQngvcGp1U3A2VGo2OXhoMjJqZEVrRUZkSTY4bHg4NDkyekRC?=
 =?utf-8?B?RDNrbGo5Vy9MMnlTOGRLK2pLaW82Q1BiczRiRndVUnBXRHphMjJuUHNtc25W?=
 =?utf-8?B?SW9OTmxlNkI5eHhaTGlRQ1dFTTcvc0ZjSnBoTXpISUxHUVRPUE5aMms3ejF6?=
 =?utf-8?B?a0lQQUZwa01DYzJ2MzYxTW5LNzljSlBVVTJmeEtxZlpmV3ZVOW5kMU1wZ1Zx?=
 =?utf-8?B?WC9OZzNOTCtHVzB6K0ZYbUkrVGxOa2c4cUF2Njk2TmF5aW4xVzJLUUJnblNw?=
 =?utf-8?B?MDR5Z2k5MVkreXpQMUxPamNOU0hrUG9IY1ZFMGpESis3d2VPQnFjWFZGMWQz?=
 =?utf-8?B?S243QnE2Qi9CSVZPZkprY3oxRGpRa1BFTGtQcUpCby9CcXlXc21sZlNFL21h?=
 =?utf-8?B?TUtjZ3M0ejZEeGRYUkorNDJJMk1OeXlDUGZBMlZuclFySzFGMXk4SnVlbDJq?=
 =?utf-8?B?NDkzdlBoOStnclVzT2p5dmkrT28xOHlSTTRzTmYyU0VhNkVJZW1UOVo5OVA2?=
 =?utf-8?B?K0RzWEVPUk9tV3NGWThQaWIveUFxSHppTXhJT2xVcmx1M2V6bmJla2xwNnZo?=
 =?utf-8?B?cG8rbE9tQTZTSDRTSkNmemUxeFpqWFcxdXp3R1JudWRHMkt2cHBnVFo2Zldt?=
 =?utf-8?B?dVNBSzhkK2ViSE91S0cwVGVXb25NQTJPRUNoUHU0ajk5dmN0MlRqTk8vMVRF?=
 =?utf-8?B?YmgyOG9rckRzY0hzNFJuWFlCaTJ1ZlN4NlRFQ1dDYVNUUWptTCtFZ0o2NFBR?=
 =?utf-8?B?ZkNRcm0vQWhCNXg1eTBqR0c4VjZpRjd2K0xIUWJZeWt1dWNsYmMyYXpZMHJa?=
 =?utf-8?B?WmczZnRYZ21temVPUlhZenFFR2g4Q1ZZeGdlcVd3SVY4NUlCRTNGMkQ4Slh1?=
 =?utf-8?B?LzZ0REJkUngrOXg0WUxoMHBaKzJ2RHozWmkwSmdocW5aVldNRjJENERGZCsx?=
 =?utf-8?B?WnRUeDFlblJvRXBCTFB2Um5ERHJHcGlVK2crSnlibzgraEw2OVNPL0t5bVRY?=
 =?utf-8?B?M0c5cW1SbE1rbVV0SHBLS1RSbThSTDB3YXltT0hnazV6U2x4bW96Wk5lTlp3?=
 =?utf-8?B?b05ub0RuNVRZWGFlVFloN2NIbWlVL2RBSVN6eFdkb2xubWE1M2srL3pKbmhz?=
 =?utf-8?B?YVFZdktrcUNJTFhjSmtEZVdhNWtSV2QzNjJtRmVrOU1qYlV4UXBoUmI2NUFQ?=
 =?utf-8?B?eUR1eWRMbzBqZlJmK3BJQ2ppRWZSMFVWSWxxbXFSVi8rcnhHMEN0WmhtSElw?=
 =?utf-8?B?dzc3T0dNSVJCNVE2Z3Y1VExQZlZaUjRpRVkwODJhOXVZU0pRUUxZWU5sd3A2?=
 =?utf-8?B?aE5IaE9Hd29URGtueE1TUEFuWUZ2UGtpWVdjVUlWdHpBYklJQWR1U1lpZTlR?=
 =?utf-8?B?YVllZlhJTC9qaWxlR2xRdS9NKzFxY1BOWlV1aGxuL2g0VkFYc3dtV3lweHAv?=
 =?utf-8?B?QVFCV1JzdHh2cWVHeGZ2YjJoVGs5YmYvbklQb3hjcnpTMU5ZWkpiRWNmMERr?=
 =?utf-8?B?QVFjV240cmVKZG9WVmJ5Q0JDeDd2Tno2TGlRQjBlYUNDZy9WZGMxYlRiRnM2?=
 =?utf-8?B?Y1BveXpTTTBTbW9UTUFXMURrOUM0bW1XQ3AweUJvcDNSV3pWcnR4ekVwd1du?=
 =?utf-8?B?dlpTa0gwTXdqTWUyaGo0TE1JZlJZaHRPSitwTXZIeFN6ZkFMUUNEcHFXem0r?=
 =?utf-8?B?dzlSZHdUZWxlcHhBbEVjQ1JuekJEL1cwVzZLUEpuSFAzcGdTTW9mRDhKMmo3?=
 =?utf-8?Q?lVZ1ohaWhJOJVh87rlXbC1nngbhTMt+69JJScuBxII=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29986c1e-276c-4931-f0ac-08ddaa904b23
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:38:07.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O0zluTMH1HyodPwneMEKPyYnzMHLlx94Etd30ONKVaJbsfSfIo6AN1neywtdBDJw3dQUgSAhryi8Zs2FdMYRvG+PeUD6wkg3MpjSbYlCeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9751

On 2025-06-13 11:22, Sebastian Andrzej Siewior wrote:
> This is a follow-up on
> 	https://lore.kernel.org/all/20241206120709.736f943e@gandalf.local.home/T/#u
> 
> The problem is that trace points disable preemption due to sched-RCU.
> The arguments passed to tracepoints may used locks (yes, they should
> not) and eBPF programs can be attached to tracepoints which may use
> locks which become sleeping locks on PREEMPT_RT.
> 
> Mathieu said regarding the need for preempt_notrace:
> | There are a few things to consider here about the constraints of the
> | callsites where the tracepoints are inserted. In general, those need to
> | be:
> |
> | - NMI-safe
> | - notrace
> | - usable from the scheduler (with rq lock held)
> | - usable to trace the RCU implementation
> 
> This is covered by the here suggested rcu_read_lock_notrace().
> 
> Mathieu's suggested steps were:
> 
> | Well the first step would be to introduce a rcu_read_lock/unlock_notrace.
> 
> Patch #1
> 
> | This solves the problem at the tracepoint level, but requires that we
> | initially move the preempt disable to the tracer callbacks. Then we
> | can figure out within each tracer what needs to be done to further
> | reduce the preempt off critical section.
> 
> Here I am stuck. Patch #2 is probably not correct due to "move the
> preempt disable to the tracer callbacks". I didn't figure out where they
> are…

As part of the faultable syscall tracepoint series, I've identified 
those sites for perf and ftrace. See those relevant commits:

commit 65e7462a16cea593025ca3b34c5d74e69b027ee0
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 8 21:07:13 2024 -0400

     tracing/perf: disable preemption in syscall probe

commit 13d750c2c03e9861e15268574ed2c239cca9c9d5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 8 21:07:12 2024 -0400

     tracing/ftrace: disable preemption in syscall probe

You'll want to make sure the DECLARE_EVENT_CLASS also
does the preempt_{disable,enable}_notrace similarly
to the DECLARE_EVENT_SYSCALL_CLASS.

AFAIR something also had to be done to make sure migration
was disabled for ebpf syscall probes. There too you will want
to disable migration for normal tracepoints as well.

Hoping this helps,

Mathieu


> 
> Sebastian Andrzej Siewior (2):
>    rcu: Add rcu_read_lock_notrace()
>    trace: Use rcu_read_lock() instead preempt_disable()
> 
>   include/linux/rcupdate.h    | 41 +++++++++++++++++++++++++++++++++++++
>   include/linux/tracepoint.h  |  2 +-
>   kernel/rcu/tree_plugin.h    | 14 +++++++++++++
>   kernel/trace/trace_events.c |  8 +-------
>   4 files changed, 57 insertions(+), 8 deletions(-)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

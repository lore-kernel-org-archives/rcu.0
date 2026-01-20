Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24735349B06;
	Tue, 20 Jan 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928097; cv=fail; b=ZruyAedmiVvsN6k61GOrCe5XOMPi8M307fAJTBdf8JJ7QPR+WJk0COf1WnL0Dpv7MyfvoH+JYVym3tbCK8H4XncuPlg+ljjRZePUGcvS0VzeWaYmy9JgGBUgJD+qlk1BtBuS2L8gD+J+v3J5vtMCinVlga5fGTD+PBj/0V0ng+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928097; c=relaxed/simple;
	bh=1sJ20CDD4s9pknXihOiyUvXi3/k1O7Q1kkq1ycAxgi4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IAsZS3YVId6dMvNIpbs19CAzkHzIHqlsjv8DXYCOViqm6kdsVBsLs0gObR2IpUS4cgkMELtSn6Xxsx+kYIM8FzSIaN4wfzQfItMlzg9UgBWPp8S5Z8idwQ5BDYcKbaA4cdbEixN3bQzdlMNzK7yrj3Pnf/Go1dhhUfha0yekd4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XzzsetFn; arc=fail smtp.client-ip=52.101.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XzzsetFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwfWWwKYKY93XMuK0qWLbWYQUfqNM/97Qg4sB4U6jEMLjzBsWtyhdlcvt+m8QC2OpgzMggOetyn7HE7c4bte1alIu2arl35F15PmdXd+/T9hB61qyy9Omx5CKULNayYlbsJviXegJb2fUTcBHzhnHFKZ4+dY0Cd0obDMBa5jHsA0+ayv2R1ZRh/hnzKAZNHnkTptKn7krETdml1+4pQewXUTP/kfv2KYFpSkKBQw8EDwhtrPQgKoNSHSKQBLsnwHXyqVg1NFAGvTuQOKJvuczr84UoOPuwo792vLB1AC6QQJNMFYboBlBMZ639Hp9l7ZQzVNG0bgqTo/mee3QEM2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URY/n5c3tD9BAdM3UL9xSkwFMqf1AQuPwYqvRnf0QPE=;
 b=lApDipsdBwkWYUkt/ciq9FqFc70XFJxvpydzHXGdJQFbpWR87TrXeG/lWe5i9AWZW9gZo7kQH/+LhRyyDY0Stn7dr1moXfMzQBi+i9BG6mGjyAEoY+qKbi0ZYnkOnKLwijVhcFNDvPO6e8GF/LhjJ2sS7qpBPjU5SaD9ZpE5suRHnYCSlCalm3xz414AWKAnenjtf1pPwi3GdA2uu8l9RvgFdTiMv3B1L58jsGjAoYNYcP4ClFpYMKw2KfcgEp5Yv0c8BCfpmFy2lO9FLnHiwlm/D004fGd5McgvYZIEXhAHY+OrjSeykjROhP+0WDq8wmeBPJglI3N27Adw5KbxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URY/n5c3tD9BAdM3UL9xSkwFMqf1AQuPwYqvRnf0QPE=;
 b=XzzsetFnFbiQWnbfZd+q0qLv0TpWb1RDQs5d3Lhu5kXquW79rpLW4vFEf2hS4PrSJW03hMzPe7znPNo1yUUvAy7WszvEaHVNqYVpHJmbFJlwGNVkiJOkFYNTWxsm0ZaX8IKT49qbWaHM6LA3FA47f1/h4Fn1GpNj6BrQhKs0gxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6952.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:54:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 16:54:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 16:54:51 +0000
Message-Id: <DFTKOAJE7DSB.1QJWJVC4FJY0O@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Dirk Behme" <dirk.behme@de.bosch.com>, "Dirk
 Behme" <dirk.behme@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: sync: atomic: Clarify the need of
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260120140503.62804-1-boqun.feng@gmail.com>
 <20260120140503.62804-2-boqun.feng@gmail.com>
In-Reply-To: <20260120140503.62804-2-boqun.feng@gmail.com>
X-ClientProxiedBy: LO4P123CA0062.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8e2edf-d830-46d4-af4c-08de5844a134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnA3cDdlSE95VXlRV2lEZk1WZldkbzA2U3RBcFRxMUdiVGpEUHVkUURxR015?=
 =?utf-8?B?UmxZWjdRaHQ2aUhWZHJMR2NBbVFmNjk5Q2V0TFNidTBnT256Y3d1a09KbEZV?=
 =?utf-8?B?MmppeUdnenQ2bEJXcXQ1Z1MzTE9HaTkzREdPM3B2RFJKM2hwTmFRSjh3bHBj?=
 =?utf-8?B?ZC9FMm40UjM5VGZkdDdseWlwcE9HUGgvT2dKOFMwemR0TUFXTUhSR0FmTUtH?=
 =?utf-8?B?ZEhIVHdNQnVyekltS252WTlxY21LZFZqMm52SHF1cm5Yd1J2VjZNREhUTVND?=
 =?utf-8?B?aHlSR0ZlQU9FVkZXRjE5Z3Q4VE1SSHJ3cWFJQVppcmZjbDBwMk9yeFV0ZHlH?=
 =?utf-8?B?VGZaeExESThxL1FXZktybTU3TTliUlh5Tk52S0czMFE2Rml3NWxKVFFpRy90?=
 =?utf-8?B?OEhjZlp0ekR4Z2M5Qk5kTEc5UGtQTm5yREVyRDdtOWdDemp0RlJidnZGczRj?=
 =?utf-8?B?MWxBQzVqM3Q1dlVqVmpaNlpEZnhSNlFwVnlVcTU3YXpMQlM5NEt3VGZIeERS?=
 =?utf-8?B?bWwwb0Nld1BGTFRPRWJydjllTXp4SjJpV3kwZlJNUlRSV04vdHJKY0RLZE03?=
 =?utf-8?B?c1NHbG5LM3pxbDcwWVAyOHA1aXBLZUluOUFLT2VLSDdVTDR1NjdaSUdKckxV?=
 =?utf-8?B?ZDFNZStmRGlnZG5JNjJWby9ZSUphVnMyN3Q2ZzQwVE1CcVpJelp0Vkp0d1pH?=
 =?utf-8?B?a1l2NDVjTkRsMHlHOWZReEhWZVIzS1NEVGtSL2RCUUxuNDF6VlpKNDFCTmpq?=
 =?utf-8?B?WCtJN0phMTdFNmhvQm9pRDN5dkhIN2EzdGVtNitna2g0VDFMYm94c0hIUVM2?=
 =?utf-8?B?WUl3MWF4ODIzSG5GczExc2FrcFNTNGNuejlvZGtrc05SQ2NYa0ZaUGgvNUJN?=
 =?utf-8?B?SEw1djRlam40MFVYQk9CSkV1QitTZ3JOaHpGUUlWRGVRMTVZL1IxMDE0WCt4?=
 =?utf-8?B?VS8vQ29NQjNZODE3SnRoYUsyd0dCQWd1NWtrRzU1TUNFdDFPb3c1TWM3aG9J?=
 =?utf-8?B?aWkrYzljTkRXSFVaSk11RTluSENEWW5UWFpTbzB5SDZMS2tWVHpPVWZEbWIz?=
 =?utf-8?B?a3kwT1B1UWVnWXEyZ3JoTU1JaWI0MU9lL2Fwc0UrUVRvOC9mUkJYOHRvQ1Bt?=
 =?utf-8?B?YjBTdWJwZDcwRVJrWVF5MG5iR3JmaHgrVk9EYkszeFdJUktGV3JueHg5cFAz?=
 =?utf-8?B?UVNjeVNaekRTRE5NUWlUNDlTYjZBUUFoeFY4aVJSbTAreTJGSmRoR1FvNlhL?=
 =?utf-8?B?cXR4UlBjT2dYaTY2ajRLTXB1NzNzazFCYTQ1WWd2Wk1YYWhvZTJORXhYbWpP?=
 =?utf-8?B?U2tFdlp3RVBmbmF6dUplaWVhWTlvTFVyVHc0ZXEvQnB6dytaWFJpa2htQTND?=
 =?utf-8?B?ODdrbFplT2pWUDcwOVVMTzlTemdtTWNqOHlWZGpaQlFjU1JZby93akJpQnJk?=
 =?utf-8?B?b0hWT0h1dlRGdFpCUXhtdjZoL3ZON1NlUmxMdnlPd1Q5MStLeTB1bEI1amln?=
 =?utf-8?B?MnNld3p3RGg5SWFaNTQ1Q2RreWtEUm14N0Z2Z2dVaXZXcmNNV3pucVd3b2Rk?=
 =?utf-8?B?elRiTkplRVF0S0FjUXVPQldjWm5wWTFKWEZhclRuZVUvc3lOYW5vcW5xWnhz?=
 =?utf-8?B?aXJZdmg1ZFM5THpzRE5vb0dEek1yYVlNRTBIUVpPUGdodnNxNGw5L2trdWxz?=
 =?utf-8?B?clJUZ3lNN0o5aHJsWG1RRkdTRXVCRlhpWFlYWklDdXpIYUlHbHhMOTVOL1Y1?=
 =?utf-8?B?NEFPWEpGbTRQWE4zZEZVSEZ5SEQxMnVQaVoyNTlxQnlDK2ZPOFpkYVUzeWIv?=
 =?utf-8?B?Tk1WVEJFa2JVTGRUYmFLeG55cUxjWXFQWm85RnRhZTJmc2tJb1dDRVhhS0Mw?=
 =?utf-8?B?RUU2SURibGptZHhZbWkwSElGbzNvRTdBcm5maEErenRQQmxHNnhiaWQ5VGtj?=
 =?utf-8?B?Q2R0MTRJRnRjaGtIMkl2T1d4OGF6emliSWtXTU5scm9LNGIxaUZQOFo0NDVG?=
 =?utf-8?B?RlRjSloxR1Z4dTRvL3F4NzFMaTdLZUZvTzgyY2FvOXVHMkdzRi9qdVNBVmxm?=
 =?utf-8?B?Y2t2TTFQMXhjZVVqRXBBbzhoeDFVL2VnOFpKMEp3VE02MkFvZndLekdQM253?=
 =?utf-8?Q?YERc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFPZzNuaXYwYjVkWk9aVE5IUmlyTWY5S0dSWEdxaVpaZm50TVFoaUlVYklM?=
 =?utf-8?B?aHA4dTNqdHJWRnExR0ZVVmFidVZYK3J2QjNQeXFjUWFScjV3aGhZTG1LazlM?=
 =?utf-8?B?K2hMTkdBREZOOUlaaHhuTlZXWXpCL0p2N0pWYkZqTWk4bnpLN3NQWmRiQ1Fx?=
 =?utf-8?B?UzlhWXp6NkEyMkRmT1J6aUIxRyt4ZFhyY0FnMTZZa0g4S2NjUHNicWxxSVVD?=
 =?utf-8?B?YWZ4aDdxNHRUNFFUTjBxaVllNkQ1RHVncHdmRWxIaXBORFduWlI3V1pJdTVG?=
 =?utf-8?B?VTRTVXU0L2hxdmE3NSsxcmhOUHBLVitqaUVZbjM4QXgrWDBYKzBhYldCKzlL?=
 =?utf-8?B?d1M1RFRMN1pOZkhkamQzcE92TUlpd1F3UERtdDdsS004Nm1VRzkxRlpMMGRG?=
 =?utf-8?B?U08wVGxPWW4yZGZhek02aE82eTZIOTBSZlVZRndpZ3B1Q3JscXplS3RsRmt6?=
 =?utf-8?B?ODhRQXdHNWowdHN0Q2dqcjRNa0JCb0dWdkswSlJIbGMway9HMjFTQkpDRlZm?=
 =?utf-8?B?ZURoQWZnd1dQOEtVMGZnb0VOS3JYTjNwdlJEYmV1YWIzUmQzOXVGZncxL0lS?=
 =?utf-8?B?VVR5RFB4MGwrTTlma2diMmQzOTBreXh6MHV5MW94Rjl1Y1loRHBxTlQ5NDNq?=
 =?utf-8?B?SjUwaGNjNWxQNUpSNDl2dS9wOElnMStFNmFFNFVOaHZZL1BDVzdCbDZNYTlT?=
 =?utf-8?B?bFpCVHVlTU5HTnRUMU13dStvVS9RQmRKM2RrdW9LYWVzVmEvUCsyREovS3p4?=
 =?utf-8?B?NWN2V2tMbG9uVHI1eFRoL0FwdWsvTWo0L0c1eE1nNU1sRjRpOTdSclJSSkN1?=
 =?utf-8?B?Rlp6WjVKVktDcFk5WkRDOWJKcnNXL2Rxc2RTbFk5RVJZcWtxbUVjcE9XV0RP?=
 =?utf-8?B?VnEwL3p3T05EQ0hFMTVUNElxVzVHOUZ5RmZScU1CZTl1WVpKdXZBRTBaQ2Y5?=
 =?utf-8?B?a2dobHJIbmFZVmJ2NXRNTlNhM0s2QW1MRGFYVDNyamtRZXU3amE3ejhVeHdv?=
 =?utf-8?B?Z1FDQWc0UjIvc3hFVEJ3U3VrOFdVM0pHNi9EWXhqc1pRdVk3QkNZdVlRQ1Rj?=
 =?utf-8?B?UURnYmlNUE5jbVJESXFFbWdQNWQ0K1IyWGtPVTFzSG82TzdHRVA1SDhGUFFl?=
 =?utf-8?B?Mm9lR0RVY2Mzb0FhN3QvQ0tzWHNHNDBVNEpaUG5PZGVxUmR4SXo4S1pmZUxG?=
 =?utf-8?B?UUJjZXQxOGlpNm13Yis5ZS95T01jYlg3Rml6RGdrNWVidFhJRjBpZmV2bzlH?=
 =?utf-8?B?V05iMExXcVlXejZzQndSbDhORDl0NmNwY3Z4SXpvTmhPRWNTNFdOYStvejlR?=
 =?utf-8?B?V3gzaVJ5bE9La0N3MjlxeHJWdWVVRExwbk1WdVVJdW5MR1hLd2NzNTMvTXlN?=
 =?utf-8?B?cTBjRFgyS0Q5TzRLOVQxREFCUlljNTl2TlAzU0VtVUdRTHEvYVQxZlExR25i?=
 =?utf-8?B?a1VzbFB3bGN2aFVSdnZCRWhyTTh2UmNBdlp2SWtwWnZxL1NlUlh3OTFsOVJv?=
 =?utf-8?B?NmhvSVlpRVAvVmYwZVdTOGpwWThBc01nN0U5a3JoTEV5eWVHYk1yMGE4Z1JG?=
 =?utf-8?B?cFBlVnZnTk1rTWJBZ1lOSXBwbHh0MjV0elRQcXN6cmNBWVNnUExZZUs4OERK?=
 =?utf-8?B?Qld3dzJqK042MjdaZDBBUzlRU1ZrNzd2Yk0rYnZ2MlBBUkxBa05GcWdpN0w5?=
 =?utf-8?B?dUN4cWI3K1ZnbmZQSmNidkRUMVBrSTZpR095VG40anZwQXJEQmJvckV5RzJy?=
 =?utf-8?B?YmdPMnp5SXJpQVk5Tk9GV1BUd3ZuZ2F3YU1TR0tGSjhTSlltVFYzcWNwcmRX?=
 =?utf-8?B?OUduSmwwMm1LeE5DdFhVS1NydkwrQVc0a0o3K3AwMzR1TzBHWEtmS2JrZ3B3?=
 =?utf-8?B?U3pYQjF1NXVtVWlSWE9tcGVmKzNsRTV1bFUrZGlIVDI3WkJKa1lOSlVnaXNE?=
 =?utf-8?B?QkYrci9RNFRuY3ovcFZNQ05xYm5NN1pVSkF5Vm1HU1dYUFBPVTVGb1NRYzFn?=
 =?utf-8?B?YktvRVpVS3AvZWZvSDlqWmlubHh4cTJ0UmdwWEdFbTRPTStVTG0xZHc2ZFRD?=
 =?utf-8?B?aDB0Y0VMZ3p0NFhtcUhwLzREdjI2bnpTQWJ3MHFZa2R5UUdEK3NGUUJDQ1lo?=
 =?utf-8?B?aVB5SStLWHB1RkgyUW9FeU5OejJBaHR6akkveUVwSnVwTElTMG5xNTZGczFX?=
 =?utf-8?B?SFVXL01UMzlrMlYrT1p6OVJDbklhL2NxZThCM1JveG9ORlNGMGFjbGtCcEli?=
 =?utf-8?B?RTBKZkV5enpTSDZYdjZIdXpjSlNXMFRIUjhmYnJCQ1M3UzJYQm05WkVvQnVn?=
 =?utf-8?B?K3Q4ckZHdzdIQWdMdmlmcGFvd21ZM2QwaVFPbXJONVN6c211Skh3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8e2edf-d830-46d4-af4c-08de5844a134
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:54:51.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+EN4THWYCxwOlUKE7kHO5QoUpguVQPSf9Z3IO//+5HTfv5CDiJ0l3UGxdcMDq2T4Az7FqauOWRMoESGUEPsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6952

On Tue Jan 20, 2026 at 2:05 PM GMT, Boqun Feng wrote:
> Currently, since all the architectures that support Rust all have
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW selected, the helpers of atomic
> load/store on i8 and i16 relies on CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy.
> It's generally fine since most of architectures support that.
>
> The plan for CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architectures is adding
> their (probably lock-based) atomic load/store for i8 and i16 as their
> atomic_{read,set}() and atomic64_{read,set}() counterpart when they
> plans to support Rust.
>
> Hence use a statis_assert!() to check this and remind the future us the
> need of the helpers. This is more clear than the #[cfg] on impl blocks
> of i8 and i16.
>
> Suggested-by: Dirk Behme <dirk.behme@gmail.com>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/atomic/internal.rs | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomi=
c/internal.rs
> index 0dac58bca2b3..ef516bcb02ee 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -37,16 +37,23 @@ pub trait AtomicImpl: Sized + Send + Copy + private::=
Sealed {
>      type Delta;
>  }
> =20
> -// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence th=
e atomicity is only
> -// guaranteed against read-modify-write operations if the architecture s=
upports native atomic RmW.
> -#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> +// The current helpers of load/store of atomic `i8` and `i16` use `{WRIT=
E,READ}_ONCE()` hence the
> +// atomicity is only guaranteed against read-modify-write operations if =
the architecture supports
> +// native atomic RmW.
> +//
> +// In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architecture=
 plans to support Rust, the
> +// load/store helpers that guarantee atomicity against RmW operations (u=
sually via a lock) need to
> +// be added.
> +crate::static_assert!(
> +    cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
> +    "The current implementation of atomic i8/i16/ptr relies on the archi=
tecure being \
> +    ARCH_SUPPORTS_ATOMIC_RMW"

The printed string when assertion fails will have 5 spaces between "being" =
and
"ARCH", although it probably doesn't matter..

Best,
Gary

> +);
> +
>  impl AtomicImpl for i8 {
>      type Delta =3D Self;
>  }
> =20
> -// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence th=
e atomicity is only
> -// guaranteed against read-modify-write operations if the architecture s=
upports native atomic RmW.
> -#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>  impl AtomicImpl for i16 {
>      type Delta =3D Self;
>  }


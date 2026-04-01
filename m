Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020072.outbound.protection.outlook.com [52.101.189.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A0314D1A;
	Wed,  1 Apr 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064918; cv=fail; b=Tkc6PB13skwFCJgXWnJeOiipzq6B03js8qVZLO/t0GoNSFdPAa7DCLdIlcyP/LHpWUWn635xftQx2pBe5Uuwd5CmCu532IV2DoAOTC70CPuauH4CxK1fLKBzqzukIv2kNLcNDNHuUWx2wUqzEZRdm8VWdctiaZCWuXubGPE5Vr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064918; c=relaxed/simple;
	bh=xNXiyEN5xkWRXJLF3hOKdG5/oJR0MumygTlvgaj378Q=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=FVOiqU8K3WpPS3YWHlyuluaE0dsjyAeYXAouF+ngX440wFOTGE+FLJhuD1hWhwx7iT0sWSVlYhvxTwtlg7f4yN9E+e38Mehu0YXgK2fisLLfKjxropeDc1QR5McSKnhhhvgQBrQFKWPo0csK1G3l3knxSU4FdQYnD0iH1VQgvak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ErR5DuSY; arc=fail smtp.client-ip=52.101.189.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ErR5DuSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1++k+PcHfYijZxMjquwxXggfIeBRTJANw6JZTCZ16gLLkJeHqqa9n/OgJ/Qu+Cgzpmr1jwoZHj702paWboW3Sn1Bmc/7abhViJ5hJXud2WcxwjWKtJ9/cYwoB69nf7roXRnIae0xKKLZAd0pTEjZTrrN3gU/3TxR5wVFR0txqROLox+8loYbcjo8M4LNVJl0ym6tK+kKXMRYVH8gsXnRGSsFesueVtIaIe9cFYEh87BV/uBCbS1Gqxls2aos97asAXUEc54+QSKoIzWMBvtGIcZkjBKf0WKMgOh9oh/yYv4dy0XyaZ7aVEwvtbHZCtTWUd4VgJnC3CMLV2bLB8OgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCJXXGTCcIFysreHQbBDO+ivtDMfsRWJ1T+hQemNJaA=;
 b=W/GANZLPL8BUS5TUT21VbKBgV+Noi5rU/lJ6eIZI9M1b1DF6/uWGiZVCZJ9oEYuwOYAmeyLQElzs20Bq2SVd76aytLlNfvEWiKldebPRztl8cnhVZz2YkL3etcV+f4pgP+mYSQ3Oh5sX+kyqcu1BThFyglUtwIChNYuFznEBNMJ1x61MZL+wfOtdj9r0k0eG7QTmKloi43Hb2f0JTMkuoZeB1MU+SsusocHMiWmsQQpbckFjYev0xyCxTNu1hnk29JEOlj3iY3zYRB99/h8JCsJix5oJlB9PGFrbjVHXlztWk5wmGcyM7iU9Cd5SFVwfqtsFxru19yk9cNSmmKzdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCJXXGTCcIFysreHQbBDO+ivtDMfsRWJ1T+hQemNJaA=;
 b=ErR5DuSYxLdLRINpDLvFGILrN153AbdQCWeLH7+wu3zByaW6bYLytk0CA2iGtnHyWWCx9f1FTXI6h8nT+lY7VxRnalT77JJW9k8BKHQxuKXKDdMSNQp2nTufKEeS6wDb7JEYnSTz0xjtpqms9/c/tUOmFyiJyKmJcI7Wj9T5aoVOkqU+6eueQ/kkZbUIRTUSS8ZhqdEhW6AwYkAqMk+bKjRBORkBdkZwBED0n0e94INnEVTbjnx8M4vEBehKUP8wpPvZsS6aOHDIiLBiJvXqwQj6X0AfTVIf2P5TI5TgEMzPVYo6sNFr4tBW1A/TybIDWQyMvym9rQ/1gw5dvEfzTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10600.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:106::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:35:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9769.017; Wed, 1 Apr 2026
 17:35:12 +0000
Message-ID: <b7b20a93-0310-48c1-90b7-6c12fafc784e@efficios.com>
Date: Wed, 1 Apr 2026 13:35:09 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: paulmck <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>
Cc: rp@svcs.cs.pdx.edu, lttng-dev <lttng-dev@lists.lttng.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?T25kxZllaiBTdXLDvQ==?=
 <ondrej@sury.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Subject: [Userspace RCU] Introducing a new data structure: Fractal Trie
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a593ade-c326-4e61-17c6-08de901506f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yuwCVJ9+RNDqZqSOwdefm9aYz5XwuCAGG0sVQcqjT95ORPOt39qdLzxA9yxgHnjFIWOltwpeDejiciyZjgCexDYjS/4i0oHF9gxNzMOZBoqfbuoEmaB9IQgVbPyTlUDqo8U5JoXsP6G8sirChV/VBv9O3EySDqudf0OF6+I8PqzSl8Aj2J+vTKgwaFQIBwu61KqlAmuJpPTPOwZ6seyfOSA++Qwbp2fAHWiXNVsIvDKI8o0+CTI7rOfb8ETeuOdPFvzuFSLia6l8Fzvez3HE7jl6TIsav4xxvHq9tNwGmnZChGszSQFZJ/hCCVsV8LdxRS/vu+rjYa81K+RXqSrRvKx4nloVr/DZZIedbMfgczEWVh4H13lYVCOETNN9d2ICFNdaH3/f0XbiYIowF51byh/DgjILW6vxcPHisvfPvdyuyK7ZmQ/nRNfMQrFOkzOPS3Oh/6zGL6ifT+h1f9pgkwmwDnL/Rgrp09D/sWozGUm7UmUEX4grvdsiAPoBAme5XSIH4IMorq2Ufem35y4JOTZYl7Du26HX72/1AXx5Wwagjcj/WJWjSFi4p3ZFhk4F+8avF1MQqXdTJefVXQKCWRE4LUpb9t5I3bA8+SsvtEpJWfigiVk/QFm8/VZygrUeZjuj1TPB7MblX7AXSNR/mTk0JGb2A7W7ZArpMxLY50SXD6ib8iQXjYlN/8yHQoM+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VBRzJTVS9qcUphSnplUU1CdHY1S3MzS1NZd2V2MnQ2NDA0c2U2K3BuSlYv?=
 =?utf-8?B?SldHSnVMZkdHeXF6dUVTMGZMRElNeURnZmVTK2xQQWNaalQ3MWh4blptTzJD?=
 =?utf-8?B?SmI4T0ZNeUVDUzNIMGVkQ0VhazhSVktpQjlrMDdaL2pLUWJiN1E3K1dtV2pQ?=
 =?utf-8?B?eVBnMmhkSkpLaFVpTWdRVzlqSnR4WFlyN0M1Y1lOUUNwdVlqT0RlUTZGdzlr?=
 =?utf-8?B?Y2pvWjRIQ1RkVDRveXBOcVlXeGcwY3Y3Uzlyd0hnUVF5MzNrNTFoWjRWcVFu?=
 =?utf-8?B?SzFxdGVKdGNwd1doUmdGWU1EdmNaVTVmOUlFeXBYSjQ1RHdSOGlxNmlqU1p5?=
 =?utf-8?B?S20vcUxpcFIyZ0VjLzJjbFBtOHIxWGI1ZVZkOG9KU0RSd1pVeG1SSjRJdlNt?=
 =?utf-8?B?ZWNlWE4yTzJscTRITlp5UU9TTmVQcDZxWEZpVzRoQWxvUVNjcWZiUGpEL2NG?=
 =?utf-8?B?Znk1UE56YWJxQlZEZzhadE5WY1F5RG1jeCtYTDhuTDVwOTk3VUFZOFlCUllv?=
 =?utf-8?B?NzJjUEJOMENpQVkrSEp5azA2aVNLZGdPSU55THU0U0dwU1BYampOVHJwWjZF?=
 =?utf-8?B?dDRLL1l6cm9zditVdzFlU2dYVWVLcFNSUytDOGxUeHpIclpzd0Q1VnFJRkJt?=
 =?utf-8?B?cSt4cCs2QWtYSUFMZ21mMFpRTXJzTFdjRUhJSE9KMkpQeVJyME9HQ1hhdFJu?=
 =?utf-8?B?eXBPWEhDTVZVNmZpS0lyOTFnbG1yUzgxdW5rNFhNNDZVSGp2TDR0ZHlTZ0c5?=
 =?utf-8?B?bnhpMGpnOUwyY0kvWmJNSURwNld1bVBCSjd4VzB5aDlXSXJsMWpEemozK2hY?=
 =?utf-8?B?Q0thZHkrckhPaE81dHp0MzNFTVEwQ3UvVE9TK09ZMi9RZjRjUjJNMjRKWStl?=
 =?utf-8?B?dTNnKzdKM2ZkQ1lXUm5GNmlLT2RYQWRMTVhlVmJiYS93SUZITnJLbUU3eFVR?=
 =?utf-8?B?bUc4Ym1lMmp0UVRlRVNkaWk2RmpwTmFvZnp0eG1zNTdMMVVqemp2MkYwdDZa?=
 =?utf-8?B?VnpwcGxlKzVjaEpTZm5GR09od1RjcUpIVFRwK1lRWmF0eUxKak4vVXRlcnFa?=
 =?utf-8?B?RUxBOEVMU0dnekhKMFZsTS9INVFTOW5XZHhWVzkvN3BEODVHQytJaHNla2lq?=
 =?utf-8?B?eitELy9ST3ZnZHRJdUNBMWhudGpxdGhKUnpUMkxwZmlGczBubU9EaFFlOFdF?=
 =?utf-8?B?Yi84blhmdGZBazAxeEVpRnlIcnZYSHRKUWM2WWlId3FOaldqbnVQYVYxdjBE?=
 =?utf-8?B?SzgzWEx4UUJXNElaZnJKcGJzVnUxMEZHa3FMWWpFdzBGOG05eDV4cGQ2QzV2?=
 =?utf-8?B?S24yenlQY3c5aHZHWFl0dmJqeVRrZWg0WnpWNjJWT3lNKzd4SGs3aS9YWFdt?=
 =?utf-8?B?ZlM3dWM2QnhxQkFTdm9idWx1ZUswQVY0ZWpWcy9kbVRaSzZrdG9hclNjdWFK?=
 =?utf-8?B?R0drbDR3Ukc5K04zTGpKVVhHWEozOGJ4c0xwajV1QTU0N2JDSUZoT2NYbHBv?=
 =?utf-8?B?TThVdDNwUmhhRkhTTk1kZFUxdEszV0Z5SCtLM3VBZkVyL2JKTDB5dG1BSXBx?=
 =?utf-8?B?YlV3eHpPTVpKOXk1WUNHMW5WMEhhVmlyeU9naGhFRXU4RE4rYXdNR2crL0hC?=
 =?utf-8?B?S3RvWnl6OHFEdGtVZkdHNTdLcHJkb3RnWEhidzZqMjREVzRta2Ezd2ZuNDNM?=
 =?utf-8?B?ejNHYjVUUll6bzVRTFBTdEtWZlJrdFFzdWhmSW52cnljTUpuVXBieWlWd0ZL?=
 =?utf-8?B?amtubFZiL0JJWVJ0M2FGSUhTR0JPbXJaU3BzS3FSeG5mUjdyUXMwdHlFU1ND?=
 =?utf-8?B?UVR4eDRWcldPVmM1M1Y5ZCtIZU9EU2ozNFhZWlN2MTQ1bDZoaDJyU0k0Yjk0?=
 =?utf-8?B?UTlWRzNRVVJuRkNoSEMrcHlMTVZBTnI2ZkJYMjJPWnpISGQ0RXJ6N0tWNnRJ?=
 =?utf-8?B?dVRrWE1pTUxHcTcxT2RPVXpZbk1kVGNTV1RyRnlnRVlYZ1Z0bHNpeWxMQTNj?=
 =?utf-8?B?MTVUVEZ2VnIzOTlDQ3hIV1FUK1cvaUNuRjlOelVYR0RzS3QxZXlSNEROWWRI?=
 =?utf-8?B?UmJqZU4zek9UV0hGd05uUkRmQWFMSU1aWVEwcnZlbGxqLzJZc1g2THdZRXYr?=
 =?utf-8?B?MSsreCtyNzZQdW02K21yM0tMcUt1NTYxRDlvMEl3dUd4dDFjUjhQUHpQWVZu?=
 =?utf-8?B?aFlhOWlnZ0tlcnI5QTFlQmxTSnVxaUNYZXliei9GblYvK3lFRFcvQUJ5ZGw2?=
 =?utf-8?B?cTd0NjNGMzloOWkzZWFWNmcyZ0lDbWVEV29ZcXlzYXhlWU5Za2RaaUtPYWZE?=
 =?utf-8?B?Wm5kek9abjZZZEg2WERRankzSTZxRFRtdTZ2QTU1Wmlpa1JHZGdnMDdtV1Bk?=
 =?utf-8?Q?0nsfJjeDRrxxohacEtNpuIq3Syo/q54F0NdEU?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a593ade-c326-4e61-17c6-08de901506f3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:35:12.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGZ6NGHUBVvfBhdl3JECrL/HHm/M0Bw4OU7b+E7lC7J3hMU0FVl0hLQ8AsBsJD1+6GTsFlzRp+XIoqquhQdPs5Z/Fyat8yl45BGbEtQKStc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10600

Hi!

I've implemented a new RCU Trie data structure, and would welcome
your feedback while it's in development stage.

It's currently sitting in a development branch of my private
userspace-rcu repository. It's currently targeting userspace
applications, but could be ported to the Linux kernel if there is a
use-case for it.

https://github.com/compudj/userspace-rcu-dev/tree/fractal-trie-dev

I've started working on this project around 2012, and I've recently
been able to find time to pursue this work. (Many thanks to ISC.org
for funding this!).

Here are a few major use-cases I see are a good fit:

- DNS resolver,
- IP routing tables.
- Real-time application data structure lookups with strict real-time
   bound limits (wait-free, guaranteed bounded number of cache line
   loads per key byte).

I'm pasting the API header top comment as summary of the feature set
here:

/*
  * urcu/fractal-trie.h
  *
  * Userspace RCU library - Fractal Trie
  *
  * A concurrent, RCU-protected ordered trie mapping variable or
  * fixed-length byte keys to user-defined nodes. Keys are opaque
  * byte sequences with no reserved or sentinel values; unlike
  * tries that rely on NUL or other terminal characters, any byte
  * value may appear at any position in a key. Lookups and
  * traversals are wait-free under the RCU read-side lock and can
  * proceed concurrently with mutations. The internal structure is
  * acyclic by construction: no sequence of concurrent updates can
  * introduce a cycle, ensuring that all lookups and traversals
  * complete in bounded time. Supports exact lookup, partial
  * (prefix) match, ordered iteration, duplicate key chains, and
  * range queries (<=, >=, <, >). A longest-match lookup reports
  * the deepest trie position matching a prefix of the input key,
  * even if that position has no external node.
  *
  * Performance characteristics:
  *
  * - Lookup: At most 2 cache-line accesses per key byte.
  * - Ordered traversal: At most 3 cache-line accesses per node.
  *
  * Internal node configurations:
  *
  * Internal nodes self-adapt to the key population using several
  * configurations (linear, 1D pool, 2D pool, pigeon), each with
  * a different indexing strategy suited to its child density.
  * The appropriate configuration is chosen automatically based
  * on the number of children. Node sizes are powers of 2 between
  * 16 bytes and 2048 bytes on 64-bit architectures (1024 bytes
  * on 32-bit). Mutations use in-place updates when possible to
  * minimize node recompaction, and hysteresis at size thresholds
  * prevents repeated recompaction when the child count oscillates
  * near a boundary.
  *
  * The 1D and 2D pool configurations partition the 8-bit key
  * byte space using one or two bit positions respectively,
  * distributing children across sub-nodes. This provides a
  * range of intermediate node sizes between the compact linear
  * configuration and the full 256-entry pigeon configuration,
  * allowing memory-efficient representation of medium-density
  * populations without requiring the full pigeon footprint.
  * The bit positions are selected to minimize the maximum
  * sub-node population, using a minimax criterion. The
  * transition thresholds and worst-case sub-node sizes were
  * empirically validated by brute-force enumeration of optimal
  * bit selections across millions of random populations.
  * Alternative approaches such as Judy use a population bitmap
  * with a dense child array, which requires recompacting the
  * array on every insertion or removal. This is incompatible
  * with wait-free RCU lookups, since a reader could observe a
  * partially recompacted array. The pool approach avoids this
  * by using fixed index positions derived from key bits,
  * allowing children to be added or removed with single-pointer
  * updates visible atomically to concurrent readers.
  *
  * Node type and configuration are encoded in the low bits of
  * child pointers (tagged pointers), so determining a node's
  * layout during lookup requires no extra memory access.
  *
  * The 2D pool and pigeon configurations use a 32-byte bitmap
  * to locate populated children via bit scanning, reducing the
  * number of cache-line accesses needed for ordered traversal.
  *
  * Memory layout:
  *
  * Per-node metadata is stored in a separate page via a strided
  * allocator and reached by pointer offset from the node address,
  * keeping metadata out of the node's cache lines. This avoids
  * padding overhead within nodes and ensures that lookups and
  * traversals only touch the data they need. Internal nodes are
  * reclaimed via RCU (call_rcu), so readers never access freed
  * memory even for the trie's own internal structure.
  *
  * This provides memory efficiency comparable to adaptive radix
  * tree schemes without requiring user tuning or configuration.
  *
  * Graft, graft-swap, and detach:
  *
  * The graft, graft-swap, and detach operations move entire
  * sub-tries between trie instances within the same group. Each
  * operation is a single pointer store visible atomically to
  * concurrent RCU readers: a reader sees either the complete
  * sub-trie or nothing, never a partial state.
  *
  * - Graft (cds_ft_graft) attaches the content of a source trie
  *   at a key position in a destination trie. The destination
  *   must have no content at or below the graft point. On
  *   success the source trie becomes empty and can be reused or
  *   destroyed.
  *
  * - Graft-swap (cds_ft_graft_swap) exchanges the content at a
  *   key position in a destination trie with the content of
  *   another trie. Unlike plain graft, the destination does not
  *   need to be empty at the graft point: any pre-existing
  *   content is moved into the swap trie. Concurrent readers
  *   see either the old content or the new content, never an
  *   empty intermediate state.
  *
  * - Detach (cds_ft_detach) removes the sub-structure rooted at
  *   a key position and returns it as a new, independent trie
  *   instance whose key lengths are relative to the detach
  *   point.
  *
  * Root-level operations (key_len 0) work with both fixed-length
  * and variable-length key groups. Non-root operations (key_len
  * > 0) require a variable-length key group
  * (CDS_FT_LEN_VARIABLE): in a fixed-length group every key
  * must equal the group's fixed length, so a shorter prefix
  * needed to address an interior graft or detach point cannot be
  * expressed, and the call returns
  * CDS_FT_STATUS_INVALID_ARGUMENT_ERROR.
  *
  * Together, these operations serve as the transplant, exchange,
  * and split primitives for bulk operations. A typical bulk-load
  * pattern populates a staging trie offline — with no RCU or
  * locking overhead — and then grafts it into the live trie in
  * a single O(1) step, keeping the writer critical section
  * minimal regardless of the number of nodes being moved. A
  * complementary bulk-removal pattern detaches (or graft-swaps)
  * a sub-trie in O(1), waits for a single grace period, and
  * then drains the detached trie locally, reducing the cost
  * from one grace period per node to one grace period total.
  *
  * Iterator Lifecycle and RCU Locking:
  *
  * The `cds_ft_iter` object can operate in two path modes, selected via
  * cds_ft_iter_set_path_mode():
  *
  * CDS_FT_ITER_PATH_CACHED (default):
  *
  * The iterator caches the traversal path (RCU protected pointers) to
  * accelerate subsequent sequential operations like cds_ft_next(),
  * cds_ft_prev(), or cds_ft_remove().
  *
  * Because of this caching, the RCU read-side lock must be held
  * CONTINUOUSLY between the operation that populates the iterator
  * (e.g., cds_ft_lookup) and the operation that consumes it. If the
  * RCU read-side lock is dropped, the cached path may point to freed
  * memory.
  *
  * If you need to drop the RCU read-side lock between operations, you
  * MUST invalidate the iterator's cached path before reusing it. This
  * is done by calling:
  * - cds_ft_iter_invalidate_path()
  *
  * Calling this function clears the internal path state while keeping
  * your key intact. The next operation (e.g., cds_ft_remove) will
  * automatically fall back to a safe, fresh top-down traversal.
  *
  * Example A (Continuous Lock - Fast):
  * rcu_read_lock();
  * cds_ft_lookup(ft, iter);
  * cds_ft_remove(ft, iter, node); // Uses cached path O(1)
  * rcu_read_unlock();
  *
  * Example B (Dropped Lock - CDS_FT_ITER_PATH_CACHED only):
  * rcu_read_lock();
  * cds_ft_lookup(ft, iter);
  * rcu_read_unlock();
  * // ... time passes, lock is dropped ...
  *
  * lock(&writer_mutex);
  * cds_ft_iter_invalidate_path(iter); // Flush the stale RCU cache
  * cds_ft_remove(ft, iter, node);     // Safe: Fresh traversal protected by writer lock
  * unlock(&writer_mutex);
  *
  * Note: CDS_FT_ITER_PATH_UNCACHED iterators do not require
  * cds_ft_iter_invalidate_path() — the path is discarded
  * automatically after each operation.
  *
  * Debug validation (URCU_FRACTAL_TRIE_DEBUG_PATH):
  *
  * Building with URCU_FRACTAL_TRIE_DEBUG_PATH defined enables run-time
  * detection of stale cached paths.  Each path population records an RCU
  * grace-period snapshot (via the flavor's
  * update_start_poll_synchronize_rcu); each path consumption polls it
  * (via update_poll_state_synchronize_rcu).  If a full grace period has
  * elapsed since the path was populated, the cached pointers may
  * reference freed memory — the program aborts with a diagnostic.
  * Since struct cds_ft_iter is opaque, this option does not affect the
  * application ABI — only the library needs to be rebuilt.
  *
  * CDS_FT_ITER_PATH_UNCACHED:
  *
  * The iterator automatically discards the traversal path after each
  * operation returns. Every subsequent operation performs a fresh
  * top-down traversal from the current key. The RCU read-side lock
  * only needs to be held during each individual operation and while
  * accessing the returned node — it may be dropped between operations.
  *
  * This mode is suited for iteration patterns where the caller needs
  * to drop the RCU read-side lock between steps (e.g. to perform
  * blocking work or acquire other locks).
  *
  * Example C (Uncached mode, per-step locking with refcount):
  * cds_ft_iter_set_path_mode(iter, CDS_FT_ITER_PATH_UNCACHED);
  * rcu_read_lock();
  * cds_ft_for_each_rcu(ft, iter) {
  *         struct my_entry *e = cds_ft_entry(
  *                 cds_ft_iter_node(iter),
  *                 struct my_entry, ft_node);
  *         refcount_inc(&e->refcount);
  *         rcu_read_unlock();
  *
  *         do_blocking_work(e);
  *         refcount_dec(&e->refcount);
  *
  *         rcu_read_lock();
  * }
  * rcu_read_unlock();
  */

Your feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


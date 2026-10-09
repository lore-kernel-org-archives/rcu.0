Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191C3D5C32;
	Fri,  9 Oct 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582968; cv=fail; b=eitlwzCBWPhTDApfKzcKYprwkRoWkTs51NOqif8ydb3TJDLEhdjQM5cnLNKlBnfaymDCduTYbC+5a4DAd60+Q3t1xGZnIMk7daAY8ubYktsnQv7we3xpo+JxkKK3EsKSQhBN/cSn2k5yrdgTK01uBFWWyk136rjPkHworTEL+zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582968; c=relaxed/simple;
	bh=46eeMNJOr9Oa6r0zsdcjF0nx+83fZvXyugEHOQKZ5gA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=djboJUoUGV6JnxKAjkYXPVyyrsjD+a+R7T5dg8lRLJJUgveEsN/2I3xfhYX+PyDr7mNEVpcUdnhYPx71kFr94PIPVLicv2ZrRvSEbHcYLw1uIlUchSTzt4rx6Tjplgf2hcCHQCRl+FAzwqZZpj6mo/MqzIQ9ZuWM+gceWddmTms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=l3QQTq4n; arc=fail smtp.client-ip=52.101.96.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="l3QQTq4n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8r67xD0daZ8TM+DWhGJeiL33ih0z+9yYaMDB0o1WI6tal9xOZ1PuffYoh1VSO4nrYI+9bhlWlpxdbNKSgCt3jmLjHa87o2oQPiTcOy6UE8xR2L5gT5tJt+B448lm308yR8OtoW3zpAV9RrPNd5nRQlHdiMJTfxHhJM4bHoceo2t65dfLadEVG7+s0zrfOaAesW5j+m9VmGaPB0mEOMn9KqZOLiOesyCupASgcETJ0oJwNgSk5r2Ajr9WaGmDRxFj+L6BEmUV1kfO/7BXb9lG2oB99p05LKsGsNs1ne1wn4cTe8K0yarTMUOXNbDhCZIkA/zxOdAmnEcw8UqytKgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh4YcTw8JbaNUhW/j/fMV1f/mSLIk4EOiM7Jyoi4eX4=;
 b=sjcFxc6oDathWllHCk3/f+KnNCV63KmB0s8a/HsvLuTVSbE5vpUC93sCLLoQeAfvesqa7i2GchN9CvU7IMSJ77e9qiYvzt6TsgyQC7zkOMMcWyUkJxezgw8lWRqBUi+F4sqNUfe68PpQ1VhDrhY+RMK4OJHwhv43Z3gPuRCCUanH0csFqJa2MbrpY6tskvNlW1k0QHZnWSZ0rBkAOWie65DIS/azhCb1vaRL/+Br8IHvlVzatQpB+djq9WkMRF+k4Kh2FoZl7eAGIgHp1ZXVaaA7jb8UYI84rOqm4GMknk3Yjdln2jNCwGGv3CEWj/7ueRLur2OqkIxAtcCs3tCWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh4YcTw8JbaNUhW/j/fMV1f/mSLIk4EOiM7Jyoi4eX4=;
 b=l3QQTq4nvoEmPKX0BYeFNJWQ2l5DkKIm9v1hFZDTm2aFphuhOt8aI/kv7LY96f74P5K5tG9aAdSRZG/CoQblPOP0n/YsFi4XyfErEHouXllj82hzlatDShy3YCvPNelmoSqAsmAIZ7RmzS8qGp2ydV8oXjOrakjN3ZnnMTc8iyA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6184.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Fri, 9 Oct
 2026 21:56:02 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:56:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 22:55:58 +0100
Message-Id: <DM0N5L0LG9P0.6IFXMJX60P92@garyguo.net>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Paul E .
 McKenney" <paulmck@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Alan Stern" <stern@rowland.harvard.edu>, "John
 Stultz" <jstultz@google.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Joel Fernandes" <joel@joelfernandes.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang1211@gmail.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Waiman Long" <longman@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Vlastimil Babka" <vbabka@suse.cz>,
 <maged.michael@gmail.com>, "Mateusz Guzik" <mjguzik@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <rcu@vger.kernel.org>, <linux-mm@kvack.org>,
 <lkmm@lists.linux.dev>, "Nikita Popov" <github@npopov.com>,
 <llvm@lists.linux.dev>, "Lian Wang" <lianux.mm@gmail.com>, "Kunwu Chan"
 <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v2 2/4] ptreq.h: Introduce ptr_eq() to preserve
 address dependency
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
 <20261009182142.6311-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261009182142.6311-3-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: LO4P123CA0537.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e20ae1-a5e7-4a6a-233b-08df26501c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xwRm4U2dhMOkdXaI1PH9ZFAjLsSJ3Y/kmQk49jKfxIZHut9asaA+uBsDwEoEHZz5uQSXQSkNLKW/JWbBONVxzRvOXP93wNcTeXojRO8h8h1vwn3qGf09Emsqo2vbxFHwgQMhJImNHQ6SE+HCQRNHkyx8IUSq19LmOjmYfVih8YbCzA7W1JAq4xfu+c+SWPYId/wvmUsDlZgGhPhHBNll+R4lwJpDkp/bFK7Cp6A8aMBmDVstnZVjz1h4PWz5KeHem4pE2igNHqHuTf0q8elKI/w+XyFVEN//QiU+eF48ftywP8SSW4bd3dFqzUyrTnI6ijclQ7shwOUQD+3BiPGKQnnmuwO2rhsXPagJFwoptea5kl0RhT5fmaSdsX4QSspqmI/iLKynzA8iBfbCOJ8cm/G0rByZ0g2PIrGvin/KAJmUqJQ//ZP0bjhWFnk7FlGw4Mi6lXWyK+XMzLv88UGxaTDE5p7dYoF68e4UfWqfVncAdDE+MOD56EpDHfgQf9w0p1EFFbAH4vdg7/xezveHUe/G5gZGtI3FEYHnCuG9Z+A9LlsbRAC33SdjVz/FC7aP0ZLyf/0OD5PHR+avCkoQzajCQ7+XTz6TcdMnKGmwpV3HszXop/VJ2s5biGKyCfdF092L2ZL0bR0qtfopECchMqbutBxX0FkP9mTZyVmS8Yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGE2V0toT05mL1FRWnY3TlFYTE1UcCswdGV3blhlSE5KSWFELzRmUE8vOGlZ?=
 =?utf-8?B?L0tBR3p4cWI5ZXd2bnhQV0c4VFlNamRXb0FMWFJVWDFJYUMyWE9rM3BrRjd6?=
 =?utf-8?B?QW9aclMzUXliaTM3NSt6TEZJazJZSXd4ZjNBcGcydXdKa1hVUnYzKzZBZlJU?=
 =?utf-8?B?YnVZbDFMVVk3QVlmbzNqT2E3THJNb3FVMTlNUkJoUW1NYkV5R1Z1WXdsNFV2?=
 =?utf-8?B?OEZDQit0OEhlRGRxRDlVekYvQ1c0bGFwRzFYUEVZK0pnQm5SQnMrVDhYZ2Nq?=
 =?utf-8?B?ZDJSNUg2MXB6cUxBZytPWVByclpXSVN6WTBHSjM1ZTlEaCs0WUFYVzZ3OVkx?=
 =?utf-8?B?ck1hVGRtNWxqNVVmZHJiSk16RTY5SERmNGxRMnJ5WGxPSDhCcmZQWDFpTWZt?=
 =?utf-8?B?Y0lubXMyYWMvSi9BSzdkUCtEL2NqMVpVdzg1YytFemdvdWJFZGJYbVZWN3pD?=
 =?utf-8?B?NXFDVzg1aXBiTUwwaS9sNUFJa21WSW1TSVVReldrZEhwYzl0R0lFb3JoaExv?=
 =?utf-8?B?VVVsM3NQYmo5NFo0Tjgwa0daRkc4NEdReFNFcUtFSDVJK253bEk1VkNIZ2lV?=
 =?utf-8?B?SmgzNFJJTG5ReGdjZithdEQvNnU0blF5cUxibllvS0ZPKzhpazVXeU4rK0xN?=
 =?utf-8?B?NHdMcS9COTJWcGc0djQrOVBuTWZiOHY5emNDWTc1ei83OU1PbXg5a1UyV1Zo?=
 =?utf-8?B?cTNjTzVpZTE0Q05UMVIraFFMYXZZNU9tcCs5ZVh5SityL3JJM3R1bFE2dXpY?=
 =?utf-8?B?VjM1a2g4bzV2NWQwYzdQN0kyVldTVVY5aC9LZ2Y0ZXRNdVF3QUNwVWFCc3Fu?=
 =?utf-8?B?T1JhOUI5TmdLclR1Yk5LQWdrWG1tTkRYT05QWExVLzAwYTdGTzVEelVjajVF?=
 =?utf-8?B?alJQMU9XMFhCMmJQOW5ITGdtR1I1dDd0ODVjS3VaZDVjdWdSWUJXdkdvQmJw?=
 =?utf-8?B?bVZnZjFQTjBZcmdpTnNIYzc4MUJTZmgxYVBURmNrckk1MU0yQmE3TFFOSGJG?=
 =?utf-8?B?cDdwSU1sUldVK3ZDZFArSW1MOFVXMXVqMFVmaFA0UVJiYzVmcElOSDhFaG52?=
 =?utf-8?B?clFENFRMYW55NlhRYmNLZWlzQ1NUZStlakg4dEhBYW5ZNFllbWprYkZEaUM4?=
 =?utf-8?B?NzBKK1J3Vk9kVEhETmxObFRtUHY1TXFuVy9oV1RYUExIVVVpUEdnNDRLKzE4?=
 =?utf-8?B?NTBybzdyZlNZaFg2bUE3dityVENLNTc1b2xqQUpwSStnSUZCdVpGRHZaZy9C?=
 =?utf-8?B?emluell4Z2RHSWJzMHA1LzZOclNvZkQ2blBscHl3WHlNVkcyU1RYbHI4KzFU?=
 =?utf-8?B?cUJDNnJMUnlYQ29ES0x1SGo5cGFRRk1nOGRkOHJYZCtNNXRQZXVvQ2g0R3RI?=
 =?utf-8?B?WkJOWG9BcjJuUkV4VEVrZVE3QUJybEkrVGQydXhoZnM5SE9KT2xDS3VCMHp0?=
 =?utf-8?B?Q2FZK1VLdldPQlVJYXBpSGovb1JaOXB4VTNuTjBDSkNUcENQN0hSd05zUkNS?=
 =?utf-8?B?d2YveEE5QW42Si96Yy9GRTZLQTAzV0hOWlhlNk5GbDRVRFY2aEtCc2huWE9j?=
 =?utf-8?B?U045aVJWU3Z0dlRNaGowSTFXNjJoVUN5SGJqWXVnejBOZU9QMENzQS96YUVx?=
 =?utf-8?B?ZXFXMzM4UGdsc3p2cWEzcU1acldhZlRIRmx1b2NseTd2TlMremxvcGxhOE9P?=
 =?utf-8?B?ZWlzSlBTbFhWVzdCenpnRkM2b25razdEcDRQV05SSnVRd3d6YzNhUStMMllq?=
 =?utf-8?B?ZWZlZFcwVDNpTDdGU2xaWmNzNFk0THZNUXFYOWF6a3VhTURlazRkUnhtekhh?=
 =?utf-8?B?aHJlUjk1Q3pURXlKbDJnamFCZEEwNkhZenU5bXAxTTFhUFRydVVHV2NTTC93?=
 =?utf-8?B?MVRwOXJZMS9McUZUS3o4ZEhRSUJScnphZ09TRkprNWVud0o4T2tUUlUzcGZy?=
 =?utf-8?B?RXdtdmRtUVBVTzV5dWZoMU43eG9mZlJiaXFyMjR6ZE12ZFhmZnV4N1E5Mmhr?=
 =?utf-8?B?NUh5RUNxOGt4L1M2V04wNTNDbDNaeGhUWmRLbG1jdkh1aVk1OGRkWmtiWTc0?=
 =?utf-8?B?S01OakE1Q0ZQMW5ZQ1RzYlowZkloT3BDeG1lS1c5OWRhZTd0SmFXbTZXVFhq?=
 =?utf-8?B?Lzd3UGRvbWkyZHBwd0J0TENHOGpOaHh6SVV4WGZFS0U4NlNoK01KVkM2K0xn?=
 =?utf-8?B?VjRLRlF0Tm9GZWVMYkZGZEN4S3J5WThMbVVFWHBtUnlwVkpkb21lM1NzRWtK?=
 =?utf-8?B?MWtOb0s0Ny96MnQ5S05WL0FYb29ZRVY0MTRlTU5nc1E1UWpTSGovdlZrYVQ2?=
 =?utf-8?Q?yFXglUqAtC/Fw4k48N?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e20ae1-a5e7-4a6a-233b-08df26501c54
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:56:02.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFPUYYWwsv3nCiaJRAowTMwdXGNnG/Z3HxTRRavqlevQcYKyZKE8lzO/CVtPc7vo+FvNXvC9cqo788ERUJHiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6184

On Fri Oct 9, 2026 at 7:21 PM BST, Mathieu Desnoyers wrote:
> Compiler CSE and SSA GVN optimizations can cause the address dependency
> of addresses returned by rcu_dereference to be lost when comparing those
> pointers with either constants or previously loaded pointers.
>
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().
>
> This is needed to prevent the compiler CSE and SSA GVN optimizations
> from using @a (or @b) in places where the source refers to @b (or @a)
> based on the fact that after the comparison, the two are known to be
> equal, which does not preserve address dependencies and allows the
> following misordering speculations:
>
> - If @b is a constant, the compiler can issue the loads which depend
>   on @a before loading @a.
> - If @b is a register populated by a prior load, weakly-ordered
>   CPUs can speculate loads which depend on @a before loading @a.
>
> The same logic applies with @a and @b swapped.
>
> The header "linux/ptreq.h" is the expected include target. It
> contains the documentation of the ptr_eq() API.
>
> An architecture specific implementation of the pointer comparison
> can be implemented by each architecture as asm/ptreq.h. The x86
> implementation is provided initially. If no implementation header is
> present for the architecture, an arch-agnostic fallback based on
> OPTIMIZER_HIDE_VAR is included from asm-generic.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> Cc: Nikita Popov <github@npopov.com>
> Cc: llvm@lists.linux.dev
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v1:
> - Move to linux/ptreq.h, implement x86-specific comparison
>   and asm-generic header (fallback).
>
> Changes since v0:
> - Include feedback from Alan Stern.
> ---
>  arch/x86/include/asm/ptreq.h | 16 +++++++++
>  include/asm-generic/Kbuild   |  1 +
>  include/asm-generic/ptreq.h  | 16 +++++++++

I agree with Boqun that this should be ptr_eq. There is no need to save tha=
t
character :)

>  include/linux/ptreq.h        | 63 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 arch/x86/include/asm/ptreq.h
>  create mode 100644 include/asm-generic/ptreq.h
>  create mode 100644 include/linux/ptreq.h
>
> diff --git a/arch/x86/include/asm/ptreq.h b/arch/x86/include/asm/ptreq.h
> new file mode 100644
> index 000000000000..593b45f80451
> --- /dev/null
> +++ b/arch/x86/include/asm/ptreq.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_PTREQ_H
> +#define _ASM_X86_PTREQ_H
> +
> +#include <linux/types.h>
> +#include <asm/asm.h>
> +
> +static __always_inline
> +bool ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +	bool ret;
> +	asm(__ASM_SIZE(cmp) " %1,%2" : "=3D@ccz" (ret) : "r" (a), "r" (b));
> +	return ret;
> +}
> +
> +#endif	/* _ASM_X86_PTREQ_H */
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 2bc00c67dc54..e1d95dea09d5 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -47,6 +47,7 @@ mandatory-y +=3D percpu.h
>  mandatory-y +=3D percpu_types.h
>  mandatory-y +=3D pgalloc.h
>  mandatory-y +=3D preempt.h
> +mandatory-y +=3D ptreq.h
>  mandatory-y +=3D rqspinlock.h
>  mandatory-y +=3D runtime-const.h
>  mandatory-y +=3D rwonce.h
> diff --git a/include/asm-generic/ptreq.h b/include/asm-generic/ptreq.h
> new file mode 100644
> index 000000000000..db5a88628b1e
> --- /dev/null
> +++ b/include/asm-generic/ptreq.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_PTREQ_H
> +#define __ASM_GENERIC_PTREQ_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +
> +static __always_inline
> +bool ptr_eq(const volatile void *a, const volatile void *b)

I suppose this is `const volatile` to take advantage of implicit conversion=
 that
adds cv-qualifiers to be added implicitly. Might worth a mention in somewhe=
re
(commit message maybe) because I was confused for a second on why this need=
s
to be volatile.

> +{
> +	OPTIMIZER_HIDE_VAR(a);
> +	OPTIMIZER_HIDE_VAR(b);
> +	return a =3D=3D b;
> +}

One thought on inline assembly. For RISC-V, branching with comparison is a
single instruction, but there's no instruction for obtaining the boolean fo=
r
a =3D=3D b.

One option is to do

    static __always_inline
    bool ptr_eq_likely(const volatile void *a, const volatile void *b) {
        asm goto ("bne %0, %1, %l2" : : "r" (a), "r" (b) :: not_eq);
        return true;
    not_eq:
        return likely(false);
    }

and then the optimizer can turn a ptr_eq call + a branch to a single
instruction. This, however, would require likely + unlikely variants.

Alternatively, we can just not have all the complexity, and just emit one e=
xtra
instruction:

    static __always_inline
    bool ptr_eq(const volatile void *a, const volatile void *b) {
        unsigned long diff;
        asm("xor %0, %1, %2" : "=3Dr" (diff) : "r" (a), "r" (b));
        return diff =3D=3D 0;
    }

Thoughts?

Best,
Gary


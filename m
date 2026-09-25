Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020120.outbound.protection.outlook.com [52.101.191.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC1442370;
	Fri, 25 Sep 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363349; cv=fail; b=HEpBLVEtjGE3fddlKwfWmZj73Y4KSMEXZWEZPrBiYcBExDzjOla+f0pjOpmeA1Xe7O3g+JNYX91+QIIIVGSMVXGlT4PnPTAAz61QPXmT7PB185FkvIiD1fnyqHcXYWqdJp8XrCeI6EAvMlOhq+KrG2SdCHKhJpAYayR8C6czt7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363349; c=relaxed/simple;
	bh=YypHUnjDIQ548IwWG+SholPYac3wImjWaMsxvaCyh+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QIV6f++9iRAcpIk3asNr6eEdZXxSArCrrqmz5kS4kUGkxFw8rC54x6wEIBWaf9QjFIFUTSpjrrHjSLhjDlp4MIhERFyB/ioSPyhmQ8vT1wfQcizVnxJho4PIi6CWEEWNs9wT8/6wfkKWZTzBxc7G41w5fPDESlsURXNI8kQhADQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P+32TQYd; arc=fail smtp.client-ip=52.101.191.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P+32TQYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmQF4MJxs+2mm3hccHM2vnSeZNXUFzNn5JvytU5w4onufkpjpe3SurIU0sw46WCM8kmeyjZExKBknleIcwmi7Hg67RrI128MSRyp9gUgRRj2IOjFGQMPFwFLXDdfqFdoomumZQHd5yK8ftwAj9jvLoDExQor1CJIls8vXT1h7grYzk3Jn2L5+OIdD+pSZ/xsEWp4dnI2CHoQamAprVMz7S8byMFaRbKgEjszuOeGPcihPsPMdgx8+ilJ6s4Ogp4ml+mYZt2VokRJvpleDJNCPWn1iAdFUh0nW4zj+CmPTXq/zIJQA0FcHJXJdIWIuiT6p3p2m27b1hTgv/+/CUkMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYyX9q2aPAXZ1F1/WBj9pKHgr8AyTqaFk+SLtIKD0DE=;
 b=fgD1/gBlYtwAkpQvkE7UlyPdFcBVHUjjh7BRSXnY4KBn+mc1so6IU88/jvVpQFclDKsvFoYxdpea3H27DF/nAgad4YelbNQHGIxSVhsgoM24AA7EOjgOJC799DAN6GvV6xrKEZs7Jx76TwhVwrjjttU5Lg0qSDti7VuKtCfKMLwpLS2e6OSJ7uT43clEJt/tDzH85GR3Gy02eWwKlNIj5n9BhUuBWZ0vng6+seotDNdKdOSP9fiZTaZawVP5IobjAr+bIxfUoDSipF/TUkSNqwc7tU6RYe3Z0DstF1VtRIOdIUBwJS7GjVJoVgBZ7uf2JtOzQmXRNiQaDExRqc/7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYyX9q2aPAXZ1F1/WBj9pKHgr8AyTqaFk+SLtIKD0DE=;
 b=P+32TQYdkQr01SMR9gGfp4MJhZYxKH+Ee8H1i6AvjjFsuQX24zdZugIumd3FWFBNvZ2nqs2NoyFI5db9kbC+AxbWE75I/HfDbFxdqjOl66GefxBrV3vcCuwKDzJ/UA1tNUBEMTppkcDw1AOUVlaQ+kDhOqchV+dwjIPDLy9XdZnqLouUGkYHnoRAAvsxPeqABywpI0lCxFR1bHXuu4Fn/nnXHZrea5ZH29ojXPqLMZSc+2GN6T04rqdT7fLadugS3n32ApPBqnwdxxxr+KnqkooR51B6TBTGXRasjqXG/QLcRYJ3GlgqwiJsKq/5LnPmRrhg7+VbZjOWCqPvOW3SFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB004688.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 19:08:53 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 19:08:53 +0000
Message-ID: <61c5fbbe-be15-4eda-9286-b8daf718b25c@efficios.com>
Date: Fri, 25 Sep 2026 15:08:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
 Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Bradley Morgan <brads@mainlining.org>,
 Bradley Morgan <include@grrlz.net>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <aq6N7BPWJ2jl8y-1@MacBook-0RXW5>
 <b6887389-6683-4cef-b612-5bee7faad1f3@efficios.com>
 <arAB94gx8kFpU4rx@MacBook-0RXW5>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <arAB94gx8kFpU4rx@MacBook-0RXW5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB004688:EE_
X-MS-Office365-Filtering-Correlation-Id: 20692a08-da44-4c5f-4ad1-08df1b3870aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|5023799004|56012099006|4143699003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	3QPY0FYNRRceGdKrhEcX1iD70wLkNJkqfNDOvARAf5V+/PyxvruylMfOTbpACcR1Pzm0GOFXkoTIZ1Bqx72mWctF3EoOz/nHxLqy+M3/uPSt9xS6xSfo+drUGuOjQgMabythYeXrg63yb1aGbDUG1AP1YhszrGVkVhNuxBessCR0f6jKMSRl0GpGByomE8n0ymYqeTBZgtm/Yz/SPYnAMQGpaDQuKP5lBbiaoVL2z04Yr0VSbaLcTMWX56b/WFhlqKDjE+OrZGDfNU+pkUTO/tEYO8YmCVCbpJ3ZolE/hbCFEFt0BhJ0n+bdKqyZdXdzpRdaWCI4D8WFyLBuGI4MKTIAp0TOg8mLINndTPqfseosY67uGPcDewkNTTz0yEllmOvnNFWqngdOyzk7u+finQPzJYSGkW4oG3LJPdPXvfJAjp/Cq0Kl0Hd5/ymajdNqjfHGSe0AjQRn2Lj8hErx1mFnK+hU9thkdglJ5PwQGLak5YPlDYKvsFl8+zFCSQY5IZBs9ZqkC4DMox+fMaeKA0Ihrt7hsHKtwfLt5tPPbaxp6wzPzIgxIiU0oMYl938iRUyR6yubflfuIcBas5ohYlnCqMRIc0Jo0TZExjQTl1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(5023799004)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlsa0JqWVlRbkVNN1ZCMWdnN1NBNzFxUU1RSHl2V1NhK3ZBR1I4VU1vVWhY?=
 =?utf-8?B?TUgzSGQwakRhWjIwVEo2NGkwT29RQWU0WFU3alJTZkFYMGpMcGVaeWlDRHI3?=
 =?utf-8?B?TlFvWjQxUVZHNWxTbU1BYmI0cUJSNkJEUzdEUCtlcHZBYmRQR0hnTXE3ZVVs?=
 =?utf-8?B?WnZ4ZmtZN0N6RmFPTHBXcWFacjcrd1BFeC9xZ1RRblZiUzl6QjFKV0ZLczFB?=
 =?utf-8?B?dTlhanBORytMcFZ4eFBaUERnMVRBR1lXOWEvUWIvYzZXRDZzL1k4RmRZNDF2?=
 =?utf-8?B?MzBlY3NDV0YxRzNBSThjVjZNOWVCc0hJN3lFZGIvdk14VThHMjNwWjcvRGxy?=
 =?utf-8?B?UGs2eDUzdGFKL0poeXVtTlpMM2tYeWJYQW9GQ2JiNjFWL0lGTUVHaUZ0L2Iw?=
 =?utf-8?B?bThSd2RiZGdpN0E2VENGVmxwZGlPTFY2clZyVVFFQXNucmUyaEdQeVBvWUxh?=
 =?utf-8?B?ZE5DQlNOWVg0cHBvV0M2cGdkdzJRWExpV09QQ1kzNmppbTRpZE4zdTNVQko0?=
 =?utf-8?B?cXovL3lrWkRHT0JHbE5Gajl6TldYWVk4dzIrb2pJdWRJTEpRNkxtVmlXYUUy?=
 =?utf-8?B?SjBrWDBtZEVsckFFQk5vMEpiK1RlQzRnby83V1dneFZjYXkwTHFScXU2Uy9R?=
 =?utf-8?B?eDN5OEJRdUtxeXdjU1RlVHgwNy81N3ZhQWQrWlpIRWdQTkR4akJVMFJGSU5a?=
 =?utf-8?B?VHZHcmE1enZSWFY1K3JiMElKQjljZkZmNStPMk01MUxlTHNDQ2c3bEJOSEM3?=
 =?utf-8?B?K0JSWlRpWmc0ckZVMUtlamVEVytYcWZNaUlDendUWkVRNy9tRUpTV1B0Zmdy?=
 =?utf-8?B?ZmI4QzRqUHF5Z1NITEUyZDB6NDB6TWQxbkFaelBUenFHdlJxZDZOendidCts?=
 =?utf-8?B?SVFaZlU0ZzNXaUFBZ1Azc3RxT3NYODdxZ1U3L1JydzJ4MG1TQjdPTDhGT3lq?=
 =?utf-8?B?VVQyYWhpR1RURXRXK3RKZ1ZqbDF4ZFNWaTNuTUtWUnBYVXhHeW5KWGRQVnRQ?=
 =?utf-8?B?T3VUcmVsV0RHdDluSnZWc0Zna285Rmt0bmNhNFo5QmZFN0k3clJZMzhiUGdj?=
 =?utf-8?B?QndDYXJkOXRqdE4vV0x3OWg3ZFkrZDJRN05NYWljb1J6dGczVTJ2eG1FcVpU?=
 =?utf-8?B?blFWZVlnT09FN1JJajlzVHRudXhEbWIwaWZwenc1RWlhTlVFNmw5TklWM08w?=
 =?utf-8?B?VzlWaEwyL1NXaU9PdVhRK3RwQmltR2tkREhOd2VpTnpTYlhnMnl2NmQxV2g1?=
 =?utf-8?B?ZUpCTVI3YVM4eCtaYXRBR2IvSWpvaVp6WlkvVHRENC9GTHNVYzdVcDF1cng4?=
 =?utf-8?B?ayt1cThXVnJwOXZmTzFZdDNub0N1YzNuOVJYSllHeWVGdXZabTd6Wmc1YWh1?=
 =?utf-8?B?bzZyLzhXd0ppN0xnc0l2ckJrMG5PMEtGbXNCbytOMTFBdU5oNjVWUUFjbVZm?=
 =?utf-8?B?V1JUZXFMZWc1SHhMVUR2REpVYzNNWjV6N2JockpJYzZjU3FwWXE2NFBud0ho?=
 =?utf-8?B?WGp2WWZpWUR3elZmL21wb055MnNIWnNRUC90T25tSFZxaENpNG9xLzdMUmJk?=
 =?utf-8?B?dkxjdFQzdUg5VS9wdWVjV2NyOEt1STAxcjB1bjFqM2FFNlBkTEZ1SzRnbG1V?=
 =?utf-8?B?Qjk0Wjh2WXVpMENyOVlLNERnYXhnc3ZHa3FNWUpucmZGYjdZZFFZbHE0NHM3?=
 =?utf-8?B?emlnZms5Zlc1cWVWTVIrcEFYWVVZQ0dCUXdTYTQ5Z2VOUW02bXErcWR1VEFu?=
 =?utf-8?B?UGNZdWhhUkwwTnZlajVYVkhuejhkM2phVkdiYjFnSlVnWE9pemt0WGdLY3ho?=
 =?utf-8?B?aDEvYmhWSjh2OWx1U0dTbkpCZGNwN09SMExaYnl4STlhcDJWNmd1VGVRdnpU?=
 =?utf-8?B?cFA3dmY2UGRLNEx6MzlMWTlFTFF5Vks4VHpQSWxOUGYrejBGVXA5dWRWNXZJ?=
 =?utf-8?B?YXdCV01aR1YwVXIwVmlLRm1vNUFhSGJqN2ZDRGNMMVIyeEFvazdha0I1MmZw?=
 =?utf-8?B?blVtSkRzQ3Zrb3VmWVZMcUFLemwvVkc2UGNDZ1Q2am14V1dEM2pnWTVDK2tv?=
 =?utf-8?B?M2dOYlNzQ2Zxbk9MZGtRYmVrY3VDeHBndUJNR3hZSHdjTzI5bkZtL0ZCK0dR?=
 =?utf-8?B?cjlqQU82WXpYQWhJNjJ3Q2I2UDhmR3dMc1lZNnV4L0QvbDgxaHVDaUp6SWRR?=
 =?utf-8?B?NlNEb3dUQlpCQXpRZzdCVFUyODFoZ2xWdGhYaTJYN28xenhRNEI3RG5PTFBZ?=
 =?utf-8?B?YlRCSkdxMHVZcWlIYk4xVFNTWGl5bTFHOU5aOHY1K0lScm92Qzh1dVlOTWhY?=
 =?utf-8?B?blp5NUtrbzVKUTdSR2k5emVUMFk5OVJuM0p5QzIzMjFhcVZ5L2VEK0tpSkM2?=
 =?utf-8?Q?79INGH5Bq1BaIqa4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20692a08-da44-4c5f-4ad1-08df1b3870aa
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 19:08:53.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLGtSqiTmY4jp6xna8S29X5zd/84T15/mCTm/dQp8O8Kvvo5cOiRJQOAsVeHQGkpWLVaUUIAjIC9OtbyEWTHze5ijFmK4Em7kdJ9lhSOQEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB004688

On 2026-09-20 11:55, Boqun Feng wrote:
> On Sun, Sep 20, 2026 at 08:46:55AM -0400, Mathieu Desnoyers wrote:
>> On 2026-09-19 09:28, Boqun Feng wrote:
>>> On Fri, Sep 18, 2026 at 05:00:54PM -0700, Paul E. McKenney wrote:
>>>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>
>>>> Implement a two-phase wildcard scan to guarantee forward progress of
>>>> synchronize_hazptr() even if there is a steady stream of ill-timed
>>>> readers which populate wildcards into per-CPU slots.
>>>>
>>>> This is performed by flipping between two wildcard values (1UL and 2UL),
>>>> and alternatively scanning for the opposite wildcard while newcoming
>>>> readers use the other one.
>>>>
>>>> There is no possibility to miss a reader because all slots for all
>>>> wildcards are accounted for during a synchronize.
>>>>
>>>> As a simplification, use this period flip to drive the hazptr overflow
>>>> list selection as well, since there is really no point is making the
>>>> overflow list flip use a different state.
>>>>
>>>> Protect the wildcard flip with a mutex.
>>>>
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>> Cc: Boqun Feng <boqun@kernel.org>
>>>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>>>> ---
>>>>    include/linux/hazptr.h |  6 ++-
>>>>    kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
>>>>    2 files changed, 74 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>>>> index 43998bf43de4..43122c5673bd 100644
>>>> --- a/include/linux/hazptr.h
>>>> +++ b/include/linux/hazptr.h
>>>> @@ -28,7 +28,9 @@
>>>>    /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
>>>>    #define NR_HAZPTR_PERCPU_SLOTS	4
>>>> -#define HAZPTR_WILDCARD		((void *) 0x1UL)
>>>> +
>>>> +/* The current hazard pointer wildcard. */
>>>> +extern void *hazptr_wildcard;
>>>>    /*
>>>>     * Hazard pointer slot.
>>>> @@ -243,7 +245,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>>>>    #endif
>>>>    	if (unlikely(slot->addr))
>>>>    		return __hazptr_acquire(ctx, addr_p);
>>>> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
>>>> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>>>>    	/* Memory ordering: Store B before Load A. */
>>>>    	smp_mb();
>>>> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>>>> index a9d3d68a1525..d3d1050d92cf 100644
>>>> --- a/kernel/hazptr.c
>>>> +++ b/kernel/hazptr.c
>>>> @@ -13,6 +13,17 @@
>>>>    #include <linux/list.h>
>>>>    #include <linux/export.h>
>>>> +/*
>>>> + * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
>>>> + * hazptr_synchronize forward progress even with a steady stream of readers.
>>>> + * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
>>>> + * This also affects the overflow list selection: the current list used by
>>>> + * readers is array[(unsigned long) hazptr_wildcard - 1].
>>>> + */
>>>> +static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
>>>> +void *hazptr_wildcard = (void *) 1UL;
>>>> +EXPORT_SYMBOL_GPL(hazptr_wildcard);
>>>> +
>>>>    struct hazptr_overflow_list {
>>>>    	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>>>>    	struct hlist_head head;		/* Overflow list head. */
>>>> @@ -28,8 +39,6 @@ struct hazptr_overflow_list {
>>>>     * limited to the number of list elements.
>>>>     */
>>>>    struct hazptr_overflow_list_flip {
>>>> -	struct mutex lock;		/* Mutex protecting add_idx from concurrent updates. */
>>>> -	unsigned int add_idx;		/* Index of current flip-list to add to. */
>>>>    	struct hazptr_overflow_list array[2];
>>>>    };
>>>> @@ -38,6 +47,20 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
>>>>    DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
>>>>    EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
>>>> +static
>>>> +void *flip_wildcard(void *wildcard)
>>>> +{
>>>> +	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>>>> +}
>>>> +
>>>> +static
>>>> +bool is_wildcard(void *addr)
>>>> +{
>>>> +	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static
>>>>    struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>>>>    {
>>>> @@ -72,7 +95,7 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>>>>    	 */
>>>>    	if (unlikely(!slot))
>>>>    		slot = hazptr_chain_backup_slot(ctx);
>>>> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
>>>> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>>>>    	/* Memory ordering: Store B before Load A. */
>>>>    	smp_mb();
>>>> @@ -118,7 +141,9 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>>>>    		for (;;) {
>>>>    			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
>>>> -			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
>>>> +			/* We don't expect wildcards in overflow list. */
>>>> +			WARN_ON_ONCE(is_wildcard(load_addr));
>>>> +			if (load_addr != addr)
>>>>    				break;
>>>>    			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
>>>>    			cpu_relax();
>>>> @@ -139,7 +164,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>>>>    }
>>>>    static
>>>> -void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>>>> +void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>>>>    {
>>>>    	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
>>>>    	unsigned int idx;
>>>> @@ -148,7 +173,39 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>>>>    		struct hazptr_slot_item *item = &percpu_slots->items[idx];
>>>>    		/* Busy-wait if node is found. */
>>>> -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != HAZPTR_WILDCARD); /* Load B */
>>>> +		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
>>>> +	}
>>>> +}
>>>> +
>>>> +static
>>>> +void hazptr_scan_period(void *addr, void *scan_wildcard)
>>>> +{
>>>> +	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
>>>> +	int cpu;
>>>> +
>>>> +	/* Scan all CPUs slots. */
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>>>> +
>>>> +		/*
>>>> +		 * Scan CPU slots.
>>>> +		 * Forward progress against recurring wildcards is guaranteed
>>>> +		 * by scanning for one wildcard while new elements use the
>>>> +		 * other wildcard value (1UL vs 2UL).
>>>> +		 * Forward progress against recurring single hazard pointer
>>>> +		 * values is guaranteed by the fact that a hazard pointer
>>>> +		 * is not reclaimed nor reused until the scan for that hazard
>>>> +		 * pointer completes, which prevents a steady flow of readers
>>>> +		 * to acquire that same hazard pointer value.
>>>> +		 */
>>>> +		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
>>>> +
>>>> +		/*
>>>> +		 * Scan backup slots in percpu overflow lists.
>>>> +		 * Forward progress is guaranteed by scanning one list
>>>> +		 * while new elements are added into the other list.
>>>> +		 */
>>>> +		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>>>>    	}
>>>>    }
>>>> @@ -161,7 +218,7 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>>>>     */
>>>>    void hazptr_synchronize(void *addr)
>>>>    {
>>>> -	int cpu;
>>>> +	void *scan_wildcard;
>>>>    	/*
>>>>    	 * Busy-wait should only be done from preemptible context.
>>>> @@ -177,33 +234,19 @@ void hazptr_synchronize(void *addr)
>>>>    		return;
>>>>    	/* Memory ordering: Store A before Load B. */
>>>>    	smp_mb();
>>>> -	/* Scan all CPUs slots. */
>>>> -	for_each_possible_cpu(cpu) {
>>>> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>>>> -		unsigned int scan_idx;
>>>> -
>>>> -		/* Scan CPU slots. */
>>>> -		hazptr_synchronize_cpu_slots(cpu, addr);
>>>> -		/*
>>>> -		 * Scan backup slots in percpu overflow lists.
>>>> -		 * Forward progress is guaranteed by scanning one list
>>>> -		 * while new elements are added into the other list.
>>>> -		 */
>>>> -		guard(mutex)(&overflow_list_flip->lock);
>>>> -		scan_idx = overflow_list_flip->add_idx ^ 1;
>>>> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>>>> -		/* Flip current list. */
>>>> -		WRITE_ONCE(overflow_list_flip->add_idx, scan_idx);
>>>> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx ^ 1], addr);
>>>> -	}
>>>> +	guard(mutex)(&hazptr_wildcard_lock);
>>>> +	scan_wildcard = flip_wildcard(hazptr_wildcard);
>>>> +	hazptr_scan_period(addr, scan_wildcard);
>>>> +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
>>>> +	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(hazptr_synchronize);
>>>>    struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
>>>>    {
>>>>    	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
>>>> -	unsigned int list_idx = READ_ONCE(overflow_list_flip->add_idx);
>>>> +	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
>>>
>>>
>>> What if this happens?
>>>
>>> 	{ <hazptr_wildcard == 2UL> }
>>>
>>> 	CPU 0				CPU 1
>>> 	=====				=====
>>> 	hazptr_acquire(ctx, &gp):
>>> 	  WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>>> 	  // slot->addr == 2
>>> 	  smp_mb();
>>>
>>> 	  addr = READ_ONCE(*addr_p);      /* Load A */
>>> 	  // ^ addr == gp == old, i.e not NULL
>>>
>>> 	  				/* unpublish and wait for reader */
>>> 	  				old = gp;
>>> 	  				WRITE_ONCE(gp, NULL);
>>> 					hazptr_synchronize(old):
>>> 					  smp_mb();
>>> 					  guard(mutex)(&hazptr_wildcard_lock);
>>> 					  scan_wildcard = flip_wildcard(hazptr_wildcard);
>>> 					  // ^ scan_wildcard == 1;
>>>
>>> 					  hazptr_scan_period(addr, scan_wildcard);
>>> 					  // ^ will miss reader on CPU 0
>>> 					  // because its slot->addr == 2
>>>                                             WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
>>>
>>> 	{ <hazptr_wildcard == 1UL> }
>>>
>>> 	  WRITE_ONCE(slot->addr, addr);
>>>
>>> 	hazptr_detach():
>>> 	  hazptr_chain_backup_slot():
>>> 	    list_idx = READ_ONCE(hazptr_wildcard) - 1;
>>> 	    // ^ list_idx == 0
>>>
>>> 	  smp_store_release(&slot->addr, NULL);
>>>             // ^ clear the per-CPU slot
>>> 	    				  // flip_wildcard(scan_wildcard) == 2
>>>                                             hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
>>> 					  // ^ will miss reader on CPU 0
>>> 					  // because it only scans list
>>> 					  // 1.
>>>
>>> If I'm not missing anything, then it means a reader can dodge the
>>> hazptr_synchronize() scan, because its per-CPU slot can appear on
>>> wildchard=1 but its backup slot can be on wildcard=2.
>>
>> The scenario presented here includes a call to hazptr_detach,
>> which moves the slot to the backup list, which is handled by
> 
> But the slot move happens between the two scans in one
> hazptr_synchronize(), so it's moved to the scan list 0 instead of 1,
> after we already finished the the scan of list 0, no? That's why the
> scan can miss it.

Just to be clear, there are really two mechanisms combined here:

1) The per-cpu slots scan (fast path), now made two-phases.

2) A two-phases overflow list scan, for "detached" slots.

If we look at hazptr_promote_to_backup_slot():

          * Move hazard pointer from the per-CPU slot to the
          * backup slot. This requires hazard pointer
          * synchronize to iterate on per-CPU slots with
          * load-acquire before iterating on the overflow list.

This means synchronize needs to observe the per-cpu slots
*before* it observes the overflow list.

Now your point: because my current implementation observes
each phase separately, for each cpu, your concern is that
a detached per-cpu slot being moved to an overflow list of
a different phase could be missed.

Indeed, when hazptr_chain_backup_slot is invoked, it re-loads
hazptr_wildcard, and therefore its phase is completely
independent of the phase used for the per-cpu counter.

I think you're onto something. The safe approach out of this
would be to restructure hazptr_synchronize() to scan for
both per-cpu slots phases _first_ and then scan for the
overflow lists. This could be done by separating the
scan_wildcard into separate words: one driving the fast-path
"wildcard", the other for the overflow list phase selection.

> 
>> hazptr_synchronize() _after_ scanning the per-cpu slots
>> for address and both wildcard values. So the synchronize
>> algorithm on the right column should be completed to show the
>> role of the backup slot handling as well.
>>
> 
> I don't think I see the enough explanantion here, maybe you can
> elaborate more? Especially when the hazptr_detach() happens in-between
> these two hazptr_scan_period()?

As I explained above, I think you've found a hole. Does my
analysis and proposed solution make sense ?

Thanks,

Mathieu

> 
> Regards,
> BOqun
> 
>> Thanks,
>>
>> Mathieu
>>
>>
>>>
>>> Thoughts?
>>>
>>> Regards,
>>> Boqun
>>>
>>>>    	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
>>>>    	struct hazptr_slot *slot = &ctx->backup_slot.slot;
>>>> @@ -233,7 +276,6 @@ void __init hazptr_init(void)
>>>>    	for_each_possible_cpu(cpu) {
>>>>    		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>>>> -		mutex_init(&overflow_list_flip->lock);
>>>>    		for (int i = 0; i < 2; i++) {
>>>>    			raw_spin_lock_init(&overflow_list_flip->array[i].lock);
>>>>    			INIT_HLIST_HEAD(&overflow_list_flip->array[i].head);
>>>> -- 
>>>> 2.40.1
>>>>
>>
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

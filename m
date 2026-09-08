Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021082.outbound.protection.outlook.com [40.107.192.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F152BE28;
	Tue,  8 Sep 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881396; cv=fail; b=kGOyLOAarDDYx0hO53NcroPgU/sDhbKZOrVGAHVwTxSJaOoW0PsiVTbbQjs85zXvMQvfaK77szEWWEV8dio3VFc2bFJXPiTfxTiQsgF12hMSD3oCoO6glDpmf7gFP++Xg16iT8anTCJMhtsoFb7iYh0oj4AXGfbCttko3dbKKpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881396; c=relaxed/simple;
	bh=9w3E51lcVl17aK7v3eIN5rguWKlAEWzzxedEC5CvmCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dt7iHovMnEFZABSKlELh/k/kZlqshwQ1g71h+K8ErBbtd0GuelZ++R1vLd8xyjTswXSJsMOhx9KhxE8CqH62fB0Ps6M9h207lM4F+HmC7GjKOPb60TlejCKyQvIn1vepeC0ZQmB5Q4zTwbnxsdkHicl312nLFDNd2q+KYe4szvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lrHnMb6m; arc=fail smtp.client-ip=40.107.192.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lrHnMb6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQvNJl4aWT5s/+zDPGjMApJS9B7wCiP/piMvOqq8mntIvg8Uu34uYEduI+xCSxnWmEUT43SUOsudrMvfXv5+IAVKBU9eabVUa2qePz33G26UI5dcChZTa1dhzc+Yot98u5vhsgYxaDTJwKWs3/Mu5H7t1761LsR28/18nyDFs1yW3R9NueTc6YdCJ/SXbvt9FN0DrtWktzV1s12Afq2v5UVUmtlrNOOC4KAQYEi2bzqzKmg2TeUoYllGkIfU+Mp9Xdwz45dB5h4F0Sfzq2+lJw6n0LWxC0Eg416j7NX54d67h5oU66xCXswUvJry1PDHBlEzna4XONtDMOkjZViSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2ts0lNfIBygyC9dyYCDrMOiw0nLtwgR78sNyenuXbo=;
 b=UBXJFCEoG33kkKuXCjzzGXP0vYNI3HB8iqcRrhQRLSw177uwSlTXmAaLR0OHQ/Ln2SDQjmj/NYP/5H+M/aL88ymYXf9ygULn4GTu3Br+UE1Do9/XhE1uG0mFRjSg1GqbPDMO1mwXj+exAMBA5uOKPGEYCGxV4EYl5Up5ZKqrSMPDp1ehnfTDP8krEUKl5w/38LbDkW3n+Aqttky1xZuShRhvErF2rg0laHLeQQbP0e3v4Z6S61G3xGLlOoT+qIl6knEs5sY1xUtnqyMrBiAbx2OXq92TmvyofU5/WvSyNgW/q5/yrb3uTiYU0PhvxLYvqvxc7U0x7Iwetd70sAiPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ts0lNfIBygyC9dyYCDrMOiw0nLtwgR78sNyenuXbo=;
 b=lrHnMb6m01feqvpX88GkglEKgvwH7PxRKwMWo5qdW0JcYVlHs4+kMGL0IF+xWfp2MnUHKb6BkAHPQagXdIb3xgdkigi9s2TBPSTHgal2hMiOtx5hSGwiUN7cbJH3bxwfc4/nNwNn5xJ75LiYmaQPmNj8o6NQTEIsTyfN+zUD42fM97D2K5adtthUoFl/Djnfh3jOuZQNDhFkTARbsZ0366o/+IcE5Kb3sqiRRAlnLVDXLp0ue/PmaNgcXGNhGNKGOeRN5aW8/UlaBalwsvZsQ0NB7UhuitmSjhu7tX9xCBUMvoykwfzJSgaXg2rZ5yPKBh+tk+4MN1DvE2K5Kl3SQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB10292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 15:29:32 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:29:32 +0000
Message-ID: <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
Date: Tue, 8 Sep 2026 11:29:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
To: Bradley Morgan <brads@mainlining.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <yi1.lai@intel.com>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
 <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB10292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7705cc63-2eea-4fc1-459b-08df0dbdfb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WrIgKwZpRV97dad7flGoF/+ZhvejLiF8Mox8SzeP9cubqoqlcAfxvrDNfQhGryevik2SVq3a1tgVOnkKUe77Kp6jdeJEgKJ4MN8iFVKA5sn5FfIwqZbcFt++GF+c4M9ZYvaCL1PJlHj7WioZre96nCHMlq8u5Qn/aHxkQBm9ExHjyV/6qT6/6LFEWocHluGiYkZcV+reL8ETZ/IIdYfe6lT2iUd8qORc6QMMmt8vQcaenLSVpFPU/hZ0eWMVGAjLA/jlHoeK3o3OGzEtqEVNPb79QdYUXZZhhkcGIkd3k/bE8GB7vK/qygdBwS1qa4ANoFm4sn7k/LbBYQd9IG0ubVPZhiMQJligpW+jVaaZa9DvNtQvBTwNgUg4YyTP4RScJUAwI0CW54FGHxHsHzpwhJ866eXDYNO/0B+Ev+OxjtmLWyFrhdEFZ3gYdQ1lK/FE1JnMo/Uckp2FEhlCyW+Be0nAG43Xd2BiOoDcF+bFE+f7uRwJkWHcGZh78p0iJ6JUnmqXp4h/vb1suEDyyiiDAbXFmd0qbF8eeF3jx1Y4aianGMVgs1WJSwroxH2cmQrzJMZMRfjbEZdSVS9dp2X3SUlAQpBqQ6DKdaAbfQAw2PA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2hzMm0vV2VFL3pCYmlqbExnMkloT2lnWnN6TnJXa1dYOXp3VW1zRys2MUl5?=
 =?utf-8?B?YkdBdUZScVk2N3BMUlM5bjRPTSs3dldLdFJDekI0Yzc3NkU3cDhRcUFTUE9x?=
 =?utf-8?B?c3ZOREl2UDY1S3lhS0Ztd3RFeTlzTkF5aFBZUG1tbUVYcEtiVU05WmZhSmZT?=
 =?utf-8?B?clR2ZUprWXVqVXJ0YTUzRkUxSUdkOUJvczluUzdoUnlrejMyNUJEVXFoOGVK?=
 =?utf-8?B?c0ZheVhKcFljQmQzaHhPV2xINmVQM1hkcDJIZDE0SkY5V28xaFMyRE9Ob3Fo?=
 =?utf-8?B?LytMNjBVNFVxU3I3dFJsYWxyeW1xRjgzaS8raFlHUmdBWWx6b09uN1BvNk1W?=
 =?utf-8?B?aENjWU9SYzg3TUFmMU4wVGYrOVpNVkJBZHZOak1SYjl5NUYwNlFnRnNTck1D?=
 =?utf-8?B?NmZGcDBnMHVBcVNnTVZpSkYwU255MmpWWGNaUGE4L3J3eWt2VS9qd1JxbHF2?=
 =?utf-8?B?TXg0MkdpMGZvbFNoNjRkQUZkdFQxSGdIdjR1VlpLc3NhajB5SklCZHFDdWRl?=
 =?utf-8?B?ZFdUVHFFU1lPYWdEV1BFR1c3bUgyQVJlREJEVGJIOVFhbFNJaC91MUlUUStt?=
 =?utf-8?B?MDhhRnJ0bXNKLzhzbWtpeThuRUlZUUlhakR6bGdCdjdRNVN0TlM5UitiY3p2?=
 =?utf-8?B?UXl3czBpRWl3T2VUbm9tUTJRVGJvUnkvdmhxUHRxOTA1MHFNbGhmQ2xBMjFK?=
 =?utf-8?B?L3dGYis3VlNrR2k1TGxRTHNFYUgxQ2k2WmtFWkhwYklldFp3MHRqNnVZdm0y?=
 =?utf-8?B?MjFKeDIySzJPbnhqcWdLc0NJK1BRajBYYWpKUzNCRnlDVWoxczBlejVpVDhs?=
 =?utf-8?B?czZFVy9NVktvdkt1Y3pKWkt0MmpxZzkzYUc2ZmR2WndCUlF5SVBRTDBqaWc2?=
 =?utf-8?B?aUxpa0xNUWdDR1B3NVFGaEg5Y1E4K295RVQzV0xMNVdnR1BDWjNsUDRoa2RH?=
 =?utf-8?B?MzZ4Z2hyNkJod0RFamNIUmJKWEZEdnFaMGp5RWI4NnNkTk5EYXRrSDdPYmxh?=
 =?utf-8?B?MllVL1NWK0tFU2o3cjJzZnVLSG4rZ0xrbFBkcGtqZnBuOTNreEoyZURMaXgz?=
 =?utf-8?B?NytOTWRpT3NZd0V1QkRDTHpLK2cza1picE51QytLem5LUUJVeHY0YzE4b2pv?=
 =?utf-8?B?R3BqNU5Od0cxT3hGeENiREo2U1daL1VCNS9GT0hqUG1JakJnMGx3OG4vWUg2?=
 =?utf-8?B?bzBZT3ZRODZpSmtyWlBlY1pvQ3RTN1FrUjd3MmNrZDdlbjQ5Wk52eEIyZWhD?=
 =?utf-8?B?UGxRemFFRWM4NFp1Wk1hTjNzbng0WG5lQSt5bU9Ed0xiZERCQUNiL1VnR2RV?=
 =?utf-8?B?TmM0YXVTb0FoaXJqV2hkQldNREdrOEVzYkp5NFA2M291UFNmd0ZCTTJ5YzdN?=
 =?utf-8?B?TmVnYWxjeTk3VEVGWDRrV3E2ZDVlV3hJZVI0K2h1em42Z21YbmRQSnllOXEr?=
 =?utf-8?B?OUNlMks5Q3FjZllYTjJzWkZWUFFkOEEvcTVzekVpZ2VReHk4dkg3YXF3ZGxR?=
 =?utf-8?B?ZC9NSUJFcklaS09HK0c4VlJQZjVNMktEY1YwVUhhSm9hbmNNRHlKVWFkRWww?=
 =?utf-8?B?NFFRTFNwTUZvRGFnK2RTaTY1NlplWW9lMFZYZGg4TTE3SExTb2s1TmwydFFQ?=
 =?utf-8?B?R0ZHdmhrWXNnWTg4cUdYakxwOURmYThLeFc3cm8zNXBYbGtUQW1lWEhoY0Fy?=
 =?utf-8?B?a09BTThLdTdJZ2MzK3A3K25lVlorM0F2Mm8ySHJ2aHVDWlloTWFtZUtLOWpI?=
 =?utf-8?B?YlJ3WjNSU2Y1TUludktPdW1rdXVUc0xLV0JtQ0pzNThDUWd5NUtkQ2txb2FH?=
 =?utf-8?B?S0lodDcxcG5hVlR5OWVmNW95RVFBd2krbWxVYkl1OVJuaVBScTlOTVdzaHNn?=
 =?utf-8?B?ejRHZU5CMGUzRjZtMmMrSWhUWW5TQXVQRVRZVkhwTElFRnJsZlFtZ1ByMUlI?=
 =?utf-8?B?NkNRZGxVQW1iR3hvaWJ0MGx4bUNHc1NuekJjZllnaHhiQ3hiVElDMlh5NDlZ?=
 =?utf-8?B?dmpFa2piRm5USXErYjZtWncvMEw4V3dETmhyZmNxNmJMK1FiSStibWkxSXVN?=
 =?utf-8?B?NHI0OGdMRjBkMWF5RVJ4ejVjUG1IK2M1MWFKUFRDM2ptQmF4eXlTeDZaSmxP?=
 =?utf-8?B?Z3l2OTZGSHhkN08rcnM2M3pEeWJSVjV5dGVVTFNwdmRGYmdYLyt2TWduSk9s?=
 =?utf-8?B?cjFQMHgwOXlEbVNSOVlqakIwNWgrS1ZqWHpiR3EwNGdNVzZkVmpQOTBUK21N?=
 =?utf-8?B?T3RyUW9CTFljSkk1LzhvSElkcGNLTTZKSytXTjk0R1QrQ05zY2VYK2c4U2x4?=
 =?utf-8?B?N3ZHUVJVcmsvQW9ZMzRaSk9zdkFIMHJsUEhpc1pJOUd4eUswWHNLZjF0QXA3?=
 =?utf-8?Q?ddco7ZDwd1ngCiLmv7ewgvIn1PxVVdbBi0nY9?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7705cc63-2eea-4fc1-459b-08df0dbdfb45
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:29:32.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR9w8693SLnQZVIdvW3WXKz8WrLfzskz/yHxmlZR5/6RQWvNVyw9+gSGhfE541K9R3Z5VdDqq08iqM88csiCHk4EOzdo4zBSG5L6uGPoFAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10292

On 2026-09-08 11:24, Bradley Morgan wrote:
> On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> When hazptr_acquire loads a NULL pointer, it sets:
>>
>> - slot_item->slot.addr = NULL,
>> - slot_item->ctx.ctx = ctx
>> - ctx->slot = slot
>>
>> And it returns NULL.
>>
>> Then hazptr_detach is called on this ctx, it will act on the ctx as if
>> needed to be promoted to backup slot, even though it has a NULL addr.
>>
>> Looking at what hazptr_note_context_switch() does before promoting
>> to backup slot, it checks for a NULL slot->addr, which is exactly
>> what is missing from hazptr_detach.
>>
>> With this in place there would be no need to explicitly check the
>> hazptr_acquire() return value before calling hazptr_detach().
>>
>> hazptr_release() has a early return check for NULL addr as well, so it
>> makes sense that detach does an early return (no-op) similarly.
>>
> 
> You shall kill me for this!!
> 
> Could you perhaps do a splat in ze commit description pls?

The splat is available at the "Closes" URL below. I'm not sure whether
we should duplicate this verbose information ?

Paul ?

Thanks,

Mathieu

> 
> 
>> Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
>> Reported-by: kernel test robot <yi1.lai@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Cc: Bradley Morgan <brads@mainlining.org>
>> Cc: <rcu@vger.kernel.org>
>> Cc: <lkmm@lists.linux.dev>
>> ---
>> include/linux/hazptr.h | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>> index 43122c5673bd..d1670121947a 100644
>> --- a/include/linux/hazptr.h
>> +++ b/include/linux/hazptr.h
>> @@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
>> 	struct hazptr_slot *slot;
>>
>> 	guard(preempt)();
>> +	slot = ctx->slot;
>> +	if (!slot->addr)
>> +		return;
>> #ifdef CONFIG_HAZPTR_DEBUG
>> 	ctx->detach_task = ctx->detach_cpu = true;
>> #endif
>> -	slot = ctx->slot;
>> 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
>> 		return;
>> 	hazptr_promote_to_backup_slot(ctx, slot);
>>
> 
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

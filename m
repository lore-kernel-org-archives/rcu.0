Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020097.outbound.protection.outlook.com [52.101.191.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBA52FE47
	for <rcu@vger.kernel.org>; Tue,  8 Sep 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875478; cv=fail; b=X1fsoGONLQkcUaIfjuE63VgQH62lxWTcxTRiQ/8B3J3dqt5XOLhPkGasPRRkzmZjTF4gcPMwn9e/jiy3PQiE8OYBYumX2dwwCLnXsmZieS9cyRAvT16Pe6MtDGP9oL3/R8UMpa3L5SHWqzta5GkxzSvKoHc3HOJKWZc77LN4Wjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875478; c=relaxed/simple;
	bh=QuQ75SbUp5TBhV5Y26NhoXoIniisJ/eoykEdwj5/DMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQ+oci6J6poqnT40tcFB8DZLGwS3fqHIDNDyrcIzmr922T3RT/ogloIyDIp6cKo2Axd5eLAMWMWmADXz7inF/CummRSEAtSgHjqg3sTSJ9U72ZceM44Nst0TJsAckSbggHiWP1mhnRBaIAGOB1b2deczHWeKo69OF1QEarN6Yjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RmD2qsPE; arc=fail smtp.client-ip=52.101.191.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RmD2qsPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN+EWlC10ED3qa8i4rGecgPWOZZvJ63m96D4/C9Eq4OdSR/DnR3FeFX89Iv0FFnqDy6fmPRKcPUHMBTVOMpxLFzKziccuLm5CBa0sOlzVpKxldeAAIzndgFn60agnsiYKjGqatrsXxvumR6tgQUPLl1ScfBWslga6mFCgtbiDFM8Em07g4Iz/o1jBdb2GBA9KHQMH3ETXEAgBp4oSC4tuQsKeqNgNjAylokIWA3eZDOy2ZFzO72QJm+HLh4+mt5ARwFKjnmucfVvx5RoD7AkrT7kFkIAH89BHMrBB8wvIh9l3AR23Rz71U5G8Uhx/ncwEvu1AulLjHGDly+GP8D4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfHGu4mNr5tsCLFYDCGM5XKIbQRLkEg7mve8bXDSksI=;
 b=WleoYvCOBN6IKDpmR6eHzvCwiHnKUS9S/5FXVP1qVLf6nglXUVgLg5q3oNroaZslOLnw7nJ5W2r20omMLtKngxVeduFtnPYvRO2F8HLc7ZHI55k4jmphjygv9BNdCuhf4ajLr6xR02xk84Og0nwVPnmvjC4BCm3QpmvZTO5qW/0n7JWLIXNGF5Uko0zsbObV3m9Op9HLsFWJTXwB5IPn0VfSxbxLgu6LjOzXn0ldNUuZccnPj6JAEjN5Di1XKCidLZMlptx+neWqB7DCsuGWPeQ+f2fHq7vvW4OXbI6PFGu9VdF13A3aBm2gHMZxB+GQnNwC3O4X8DLwkGdMJeDl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfHGu4mNr5tsCLFYDCGM5XKIbQRLkEg7mve8bXDSksI=;
 b=RmD2qsPEJqyKmMJ5mLerguOBn2BE8G/yaXlRS/Dc7w2vrn5RJ4cY+tz7wj6XY/SEKIfJ4NCdDxAIMGa9AWd7Bl0uLXaooyY5ELt5b7yYGnSbIJAFe0/AW5zWhA8MyfU59TLGwi2rvELh78MGM8jXVlQRfTfnXeJC5VMjPdyD+z21gXdBzRXZBaR+7+BnZ/sEny2KCXi/ECZUZerMxY2MasXm0rjEIEKZSFStkjQlc1t/C2vb4TOm4L3j7g2Xl0y+OD0w9nJ0ehLiRqURWyUB71HG5Us2d4vyE8lDScZE+K2AFYx8f3cXsT64Ri13sFakSUU5nmVm9XY9WvvzO/05Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB954171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:50:39 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:50:39 +0000
Message-ID: <5cde694f-afc7-4c96-b67d-bafdb7e88746@efficios.com>
Date: Tue, 8 Sep 2026 09:50:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [paulmckrcu:non-rcu/next] [hazptrtorture] 9b08a09f6d:
 BUG:kernel_NULL_pointer_dereference,address
To: Bradley Morgan <brads@mainlining.org>, yi1.lai@intel.com
Cc: boqun@kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 paulmck@kernel.org, rcu@vger.kernel.org
References: <9D3C10DF-2BA2-4F97-AAB1-C36AF227F6B3@mainlining.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <9D3C10DF-2BA2-4F97-AAB1-C36AF227F6B3@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB954171:EE_
X-MS-Office365-Filtering-Correlation-Id: 12886442-f95b-4a34-1be5-08df0db02af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r0oBTnjsX0Mrg2NNF+nZnBld9LdyXAVrvPDPBzz4rGGkCPG1igLUDRiwA2Mi1TNzO6uRoTjGVLSZN5fg+Cw+zQlGXVIVMLCPAj9sRv2+wTekosk/26AVJmO8B2TjB9kwxDcZdwC1dSplVHN5vKr6q10uvYeP7Jva7Rlp8iXXp1nbdyKA66L9NgLCfqOdHcsmEiA8qyPaG0CPhLobWxYGSygu+KiZRFd9sQ9LmNYN2bpaekXizEBhIpWt6Q8uAXQWgv1NghnrTisVxvEgKt6cVwZe8Eo/jOACsJmyUXpFsCVw+dfl3NBgWoQ8+nQvpj+bSaH9IC+XcoYZUFGoR6h6VUxHQUrOQcFmIUiADrz/lT6UqOlN0BCSDakxJ4IC8MxqW5hILcx/p53jpbyXxbPC53am+WFj0C+EdMQI1Zk/f8qvCd/BMatXILr7mnmCnXGdpUHedHH+ezVOXbwJibsQ1AiPTwQaZLGou3ZMNUufclqw/Ex/wYzetrCU4TjLthpTtWNpZHMSd19fN9eEjiYFxXhC/VQevvNrPliyWIOAauIizvGX5kAfNfqVRU2U1y6FyBFxxiuKSeMce4eqmlVjbpFBInQQz0Uq0UmdFNsCfZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkdyVVpGaTNiZUQ4VEJjU3hFWld0T0lSQVZJb2lLaStGQkM5dDhYNGdMMnd2?=
 =?utf-8?B?clBaTUFaNTJIakVLY3Qxb1dCQWZRcDRIazFuOVpnaGRoWGxuZUpoL0lLYVhr?=
 =?utf-8?B?TDc3Z1JhVTlrUlJjZFhCVzM0RVBxMkc5anErV1dJZ2xiclQ3eFQ0UmJFRU5M?=
 =?utf-8?B?YUI2MS9rWFJGMW1yZUEzSUlZN3FrZ3o4Tk5JZ2l6UEd0aFZOZTYyOS8yOFZN?=
 =?utf-8?B?cEFIQ3B3aEI4OW05ejRsSGJma2dMSVdzNS9mdWs4R0haeUpkRS82WG1qUEZK?=
 =?utf-8?B?TjgzQ1R2c0l3VTVWYzk1OWJCeW9SRlVEQkpHWDR1bnVkbktNVUVlL2NSbmg3?=
 =?utf-8?B?SjZVMGhpSzNBanRib1lScmNnQUdtd2szMW1IOEJqSVQ4eFZNLzMzU3R4RXRE?=
 =?utf-8?B?dzV1N0lESXNpODk1OGljSHNFbGtJUFU2QmxWUGo5UTlNUDNiZ21VNnUvbnNv?=
 =?utf-8?B?QUM1K3lCeElnVlVpQWFZb0Q3MGdOdEJySjJkaHFnU2pTVml2V0xubWJZNW5t?=
 =?utf-8?B?TjFyRThjTTR3dlpqZTQwZ0NkZU1HQUVmWWFydVdNVUNjQklYMGxZREsrNnFM?=
 =?utf-8?B?V2xtWHFBYWtJV1g3WVB1RUdRbGM2eGluU3ZPVVFVcHFGUFFCVnhCY1FsVkIy?=
 =?utf-8?B?N21HYWNIRW4wUDJ5N0ZGenVXK2p1TFAwOG5sTUV0ZVhKbHEzWDYrUHhxT0R6?=
 =?utf-8?B?SHVMQzdPYTF4UFFVclZxc3c2WWdockd0Q0dENUVYcUQ5MWZ1ZmhyMjVtRnVV?=
 =?utf-8?B?Ny9PLy93THlvVU1odkpXRFI3ZGpYa3lKc2dmTnZySmtRWlJ6cytzM2dEdXRY?=
 =?utf-8?B?d3NkZmptQm1Ja3gyS3J1QlMrOTRCWkg3dXhIOTN6bFRWQjZnZWdodkRPZjNZ?=
 =?utf-8?B?d1ZIcWhNUTRCM1gxT09rNk9ndUpvTkovNXJiUTJkZGwxdWtHR2JKaStCTmRY?=
 =?utf-8?B?OFhReUtLZ21Da1psYzJYdFBDMkVjNGFDYTdLdERBWEhIMTJERU1mZlBIUmxi?=
 =?utf-8?B?OVNVM1ZGTGNIQzVhNnpnUGg4UFRYVEQwR1c0U1ZtOFFVeWxWNlRDU3dRNWhW?=
 =?utf-8?B?OGphUUtSbEQyYUFxOGVzMmtaZHd4V2RCY1NMVW1DNkk0OGhJVXFyaG4rcmJ0?=
 =?utf-8?B?NXd2ZTVEYmJEeGhwN0dUZGxPaHozL1IvaTZPL2Q1RG05Q25zTzhzMmtDS042?=
 =?utf-8?B?Y0VMbFhnby9YUmRlRll2c3hJWE53V0h4eVJRempDd1JKRjVNNjc4NnBDRkI3?=
 =?utf-8?B?RHl6c1M1dmwxeldvQjBjL3dabGtydGFkVURxMi9kbVV4ZDU5ejVZWVFGZVJo?=
 =?utf-8?B?eWk2SWd3NkxlL0dqWVpvT3hxcktpT1N5MVNMeDU3NkpmRW4yTi9xVXNuNU9k?=
 =?utf-8?B?ODN1YThRaXFRRk5lTXVlNEhoQmhXL04xS3BSWmtwcE0vQjhEMythZGZXYXBa?=
 =?utf-8?B?UzFnRHZ6SjR6K3Z5KzFQcHVVb3N1bTdhT1dtdExZeDgzYXhSYkk5UUxrMlli?=
 =?utf-8?B?Z1VxakRkMnZGNWU0T001N2puaHcweFVXUDNGb0hlMGVZR3lPVDU4YVpWcUhu?=
 =?utf-8?B?RzNwZEF2WGRrRkdjODl1eGRsQUxSd205S0N6dXhoQ21ZZFRDUmRaMUVVMmd6?=
 =?utf-8?B?U3lRS1R6QlFXa0FGS1NxV1c3N0FFZkJhUnAxR2xKWGtZWWRobWRyc3R5NEFL?=
 =?utf-8?B?N2ljUmMwSDBtOS82amw1aUpCZFhEd1dqeWRZbFh3bjViT3N2U0l5aWhSaW9m?=
 =?utf-8?B?eXhtOEVKSTQrVHhmV3pzU3MxVG80Mk1FSmUyNzRhSjB6ZjNwNTZVVlRERmRa?=
 =?utf-8?B?aEtxNWxYWDJKbTBGc0tBbXRwdkVwb0ppeG5jTEJSREJONUZ5VlErQW1zQTMy?=
 =?utf-8?B?QjlyL1hzK0pKQ0RPN20wWWN0czhYWTJxWkZIWkdmMG4xZU0zcElCVWJ0WUZx?=
 =?utf-8?B?c3c2U1N5R2dkS3ZmVWxQOVNKcXAwRndaTWIwK1RWcm0yejA3RjNJMHBZT3Ur?=
 =?utf-8?B?LzlGMVFVMVdFcnZpL0VzVU1uK2djNSsxOE9XMnZVQlJNbU5FUEVRRmFFbnhV?=
 =?utf-8?B?K3F1dmx1blVBRmJZU2gxaVBWM0dLVXRoSnNNSHg5aTNQbTJDQ1cxOGkwQ3R1?=
 =?utf-8?B?TFFxYmt3NGNHREprdjlFMW1kZ1BlcWRyeURKcGwxdVlZbHlMbStJMkJOUE5w?=
 =?utf-8?B?MFgwQVJCelhjZ1R4Q3RraGM3VXRiSk5BclZWTnJaeStDSENvTVYxcGl1V0JQ?=
 =?utf-8?B?NFBEMWhNM0xCMndmeEJobk9WYnFBUHVkM2VPb2pBSU95MURaR2RMYTZaNEtG?=
 =?utf-8?B?VkgrQnVTQ1k2Uzh6bklWcUVVR0piV0hhU1FzWXRBZi9GdFA3YkdWWnI2Y2g2?=
 =?utf-8?Q?flugq9FuxYw/gys4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12886442-f95b-4a34-1be5-08df0db02af3
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:50:39.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZDrXGWCzt26mm0mEv6sLhkYDe3tMa5Odz0JCo0ggmwpxgvFLNvfOUIbL9AcYTfr/ZkSIHPVWhCDQwAEtHukKRh8yTl4fUbHPx1ZoFF4OdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB954171

On 2026-09-07 16:42, Bradley Morgan wrote:
[...]
>>
> Hi, could anybody test if this fixes it?

Although this fix to the hazptr torture test addresses the issue at the
call site, I think we should make hazptr_detach more robust instead.

How about the following:

When hazptr_acquire loads a NULL pointer, it sets:

- slot_item->slot.addr = NULL,
- slot_item->ctx.ctx = ctx
- ctx->slot = slot

And it returns NULL.

Then if we mistakenly call hazptr_detach on this ctx, it will act on
the ctx as if needed to be promoted to backup slot, even though it
has a NULL addr.

If we look at what hazptr_note_context_switch() does before promoting
to backup slot, it checks for a NULL slot->addr, which is exactly
what is missing from hazptr_detach.

Something like this patch (compile-tested only) ?

--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
         struct hazptr_slot *slot;

         guard(preempt)();
+       slot = ctx->slot;
+       if (!slot->addr)
+               return;
  #ifdef CONFIG_HAZPTR_DEBUG
         ctx->detach_task = ctx->detach_cpu = true;
  #endif
-       slot = ctx->slot;
         if (unlikely(hazptr_slot_is_backup(ctx, slot)))
                 return;
         hazptr_promote_to_backup_slot(ctx, slot);

With this in place we would not need to explicitly check the
hazptr_acquire return value before calling "detach". You will
note that "hazptr_release" has a early return check for NULL
addr as well, so it makes sense that detach does an early
return (no-op) similarly.

Thanks,

Mathieu

> 
> 
>  From 3e92b8153c31106d6a080e1c9bbe9bf1e86e1f63 Mon Sep 17 00:00:00 2001
> From: Bradley Morgan <brads@mainlining.org>
> Date: Mon, 7 Sep 2026 18:00:08 +0000
> Subject: [PATCH] hazptrtorture: Only detach acquired hazard pointers
> 
> hazptr_torture_acquire() detaches unconditionally, even when the
> readlock fails. A failed acquire leaves nothing to detach, but the
> detach still promotes the context to its backup slot and chains that
> slot into the running CPU's overflow list. The reader then retries on
> its own CPU, the fast path hands out a per-CPU slot and overwrites
> ctx->slot, and the chained backup node is orphaned, still linked,
> with nobody left to unchain it.
> 
> The next detach of the same context chains the same node a second
> time, into another CPU's list, and the node ends up reachable from
> both. The eventual release unchains it once, hlist_del() poisons
> node->next, and the first list is left pointing at the poisoned node.
> The writer's next hazptr_synchronize() walks that list, steps onto
> LIST_POISON1 (0x100 on i386, where POISON_POINTER_DELTA is 0), and
> reads slot.addr at offset 8 of the backup slot, address 0x108, which
> is the crash the robot hit.
> 
>    cpuA (IPI acquire)     cpuR (reader)          cpuD (do_pending)
>    ---------------------  ---------------------  -------------------
>    readlock() returns
>      NULL
>    detach chains the
>      backup node into
>      cpuA list
>                           hpp_htp is NULL,
>                             continue
>                           reacquire, ctx->slot
>                             is now a cpuR
>                             per-CPU slot
>                           acquire succeeds,
>                             defer, detach chains
>                             the SAME node into
>                             cpuR list
>                                                  release, unchain
>                                                    once, node->next
>                                                    is POISON1
>                                                  kfree(hppp)
>    synchronize walks cpuA
>      list, node->next is
>      0x100, reads 0x108,
>      Oops
> 
> Skip the detach when the acquire failed. The slot holds NULL in that
> case, note_context_switch() and the synchronize scanners skip NULL
> slots, and the next acquire overwrites ctx->slot, so leaving the
> context attached is safe.
> 
> The robot's original report was against the defer path before detach
> existed, which 4bd7f458229a fixed. This is the same crash surviving
> through the IPI acquire path that 6357ec235c59 added.
> 
> Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>   kernel/rcu/hazptrtorture.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 7c8b589..267f262 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -373,8 +373,11 @@ static void hazptr_torture_acquire(void *hppp_in)
>   	/*
>   	 * Acquiring a hazard pointer from a remote CPU.
>   	 * Detach hazptr from its task so it can be released by another task.
> +	 * A failed acquire has nothing to detach, and detaching one anyway
> +	 * orphans the chained backup slot on this CPU's overflow list.
>   	 */
> -	hazptr_detach(&hppp->hpp_hc);
> +	if (hppp->hpp_htp)
> +		hazptr_detach(&hppp->hpp_hc);
>   	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
>   }
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

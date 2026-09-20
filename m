Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020089.outbound.protection.outlook.com [52.101.191.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC83164B7;
	Sun, 20 Sep 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908431; cv=fail; b=BdFPylNaa5zqSR1khB4lDRKdL7g2Mr+azr4jvXqUlHqRIw+pS6lHsoiSPPRGHl9PmDhZ+rxOtGuPZKnOzUJYnicpFgdudkN8oQuQ/eTzaOl+2UEEv7LKsl87SwsNQQE9sGGtLf2MxHILc9I7/E7vXFV475cS6+3XRz2XaW462tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908431; c=relaxed/simple;
	bh=RXOHAv2M3eHkm9/sag1hhV4Bhh0KGmFtmIPNGlosr6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eoT4qqrCG7yNsetxsyOx2p3h5aXdmQXP73latilrWyObSa0ZD/Vu2iwNLVmDX5dFgPjCBiuNV7U78QOIitK8NwYfe8k43uq7B5kMOZ95Jx3VD7NkxfIS0eK7CjnKiqvous7mVm+mcbbU2gdbHIXgG4aPRlI/etaakQgEh69oTXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S88Io4cR; arc=fail smtp.client-ip=52.101.191.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S88Io4cR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueynkmJsPdlNQVYmCwUMoizp2rqALuMIDMnT5ED21VaR4YDNl7BV3BtFN0/YgwwcF4OK1eXBp1XqdNFAsVdb7S5EfJAoWiiMcXasSil9WflzOT3CIHSwpGt1O5S7NI1bUESFqnYRwYjHHb0359YVkmDwx9SYI/g+c7GX0L+gvB57kV/WVqw+hsInOpT6CuHLoKRUNTzCN7oxYTgSZPsNZbH1OqNH1tRpVKGW4KKnWzH6mws06sB+XsUIXAcUBzZpKxnR7MmXB4fiTDszb9l+6fH7WM9m4p7wRWUV1iuMJ2MsVKoB967TFqFlmzkrvsbsMPD0PC8cJxjC35SaqjXFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErIyhvs5rlM6Vosu1CHz0BRh+pibiOLw1LVabx8fjLM=;
 b=w0Bp4uB5bzf/KoD8H1XzS2PZculgJo/L/Q9Ouuy6UHQVvEPT7+H1MwVMgD6c9sxXTHGTgchck0T3Z/3IOuJ1+WrwzDaxLr11RocBahAxiefedRcq+ZEzo9/WLsHjr54C5bCfpKVEb6atysQuHDNuj7KCdcuwHfE5QE8ja3kEkSbIfNbQfZvVUb6CwmyAyoMz73pY5d3yX7rVxEnk1gjJU6+qr7w3ZyQlnabqZ7b794rKNIFBXg6vz52WxbODUpLbwKoBDHWcKZHlO9CGSpd8JdvXy41Cbv3nyOiIN3QzVEY+AaGvA/Wi3cpgNXZPCOmUHSfU5jhsMkCMd+XcoyTnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErIyhvs5rlM6Vosu1CHz0BRh+pibiOLw1LVabx8fjLM=;
 b=S88Io4cR38EyvHbL+mTtxPMwlLfd1vABBgmn9jdTtZHERvG5QqJpPRJuuUPMNRXsrr685aDCbW73EFlxRIOwAWf7udTH1e7n+3FhfzWhWLdbEktbP3Pps0nVjwRPNBj7WA9lzGWyI69/Os1t4jwomrx1n2s8eb12k7v2CXMvi6E0o92innNm8bCx0CvbxfAsbao3QXzPJxjvw3IxFOxmZQRClyYcsqGLZTFOL1+GSDQL57CJ9dnVnfQW2bxK1NmwTN0c+mtAedJsxfxE72kI8iwLMq8uGhfjLGc5CkeTeTzvrv1Nhv7z8S6nOsqIERZ3NJ5ODlduktE2fpByhTSytA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB492506.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1c3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:46:57 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 12:46:57 +0000
Message-ID: <b6887389-6683-4cef-b612-5bee7faad1f3@efficios.com>
Date: Sun, 20 Sep 2026 08:46:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
To: Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
 Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Bradley Morgan <brads@mainlining.org>,
 Bradley Morgan <include@grrlz.net>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <aq6N7BPWJ2jl8y-1@MacBook-0RXW5>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aq6N7BPWJ2jl8y-1@MacBook-0RXW5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB492506:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d3ae9f-143c-4af2-3f1b-08df1715415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	SQgZPrl0jTgC+N9x6YGuDvq/x0uxb5OSO2F+c+ib9gxlz4+VeWtLCrlFtDTYiZCFJ03WCSoFcbjxGj5ZViGebgL68k/ZVn+wyNy8IOlzz677UPllD5/fwsGyh+k9XT+LecDuotTdLNxxANaMNaOIWGqMjTPN0zMIoi6h6BDTM9VUg/DLrgXjWICFMoOcaomO03mrIav8is9fXVqRKFN7mWUwY7NLcfwyEylULqYUz0/tLHscGVf/+PVIHNvpf3NP0r5NBh+BegRDsOOA7VOndBxYiRyqwpAMxEJS80BVWcC58lb3+ZkUE1uHRQVgMQIMwTnOPSIYrcvA+iX4T228A6AQLQExWGo1QlxZ7n9KSW/1HQ4EkqBoW6Ixz19Tg7qa/U3bHTj9jDuoIf+e21xruA5ot9CTcZBj8D8dryfjrBDQ+Bec7nXxp9g0ceqSpPfxn66oXA4YUMjSdSgrKQTr/ZQUOF8W4+1jQUdVnsXKdvN0DV4zLGTlIRGpERrKGe2/h6UnQevYG87ZyyE69YMYOfm1E+lthYPOLY7Tzu22Hor/N1OpzTiWNBgYewX6WocF9cWT80K9jMBVidD/7d1nk692JQf6L8PkivbPns3r+Rs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRLdjB1TWloZGx4ODhXZ1ZDNG16LzFicjVwcDc5cnhVeUpXdmVtL3lLeUdV?=
 =?utf-8?B?WjV6dFZEYldXN1JUMzY4ZVE4YzR3K3ByazZaYWE5RTI2TWJYWFFtemhNU2Y3?=
 =?utf-8?B?d2pZRjRNSUthdXVmWWRJcURjWldQMVdtVG1EMThEc3M3WmlJWlJhd3YzaHJW?=
 =?utf-8?B?Zy9ZTEg0WXhQbjJ1L3liOC9jYWZVbnVqNlJxUFBmMUIvRUJwWXkxZ0F2eXlt?=
 =?utf-8?B?alI1S2t5TkFtOGpsK0VYb3Nkam1RYmpxUDRmUytGbVloZjkwbC9KRjdQMGNx?=
 =?utf-8?B?WnJmMWY5Y2pjOEZ0OGhzaUdiT3hyVVNteUdKMk9ObFVsbStqd0hZRjJNNmo1?=
 =?utf-8?B?c0xGMERMZU5ZOCsxMjhYd04wdGNqN0ZJUTJzODRXamx6blhrRFpCUmJIQXpq?=
 =?utf-8?B?U2lXczBWRmtTeGFQKzQxNFBkeHVDZ0M3NVVQTXZPSitzVlU3UlF2VlRRTWJh?=
 =?utf-8?B?VzN5eHoxSEtCbzZDZEptZTRYNGZrMUpLekliZnN6S1ZyUG5rNUpCZnJuY2Nl?=
 =?utf-8?B?NzdZeXNBUXVjUGZIdjVMVEVocmFCV2tzYVZ0Y1NGMldzNHpPaWlGQTVOcTRp?=
 =?utf-8?B?VFFpbVdwNng1Q3ZJRWRFSlZPYmpiZk1aL3RINXdqVHJ2dGR0elVxZmZER3Vi?=
 =?utf-8?B?eUxlVzRoK3ZEVWNaNE14dWppaWgvcW5SbE9ZWlU5azFMaENLSEdVVjdJOE9o?=
 =?utf-8?B?L0lRdDdvRlpYdUYxTnpHbDQ2M3VtNDZHSXFQRS9Yb1R3U2pTQmJGMDlkNlFF?=
 =?utf-8?B?Z3VsdzZXZEpHQjAzdHcyRGkvKzhiTnExTnF4Y1RXbXFLVW1VNnVNVHZvNVJB?=
 =?utf-8?B?N21KUTdXSjdyamg4a1dXenBXZzIzbitkaGlqVzVXYktyNDRDelZqTGxoNXVC?=
 =?utf-8?B?akJRQXdha3MrdVE5UEpkdkl3eS9ZRDgzQk1lYjliNFg4NFI1TEJseFlMK0tF?=
 =?utf-8?B?SW5rb092eFRtQ3IxRGh0U3g2REJRT1V1ZUMzTGhpektEQWpqWWpDWFlDQmJH?=
 =?utf-8?B?N1I0d0g2UmlIYzA2THduMzJQMzZvbmRXTThaTGE0VTRsUE5welVBR0VWc0Rk?=
 =?utf-8?B?QTFVc3RVWDFJSG1SN25sbnljSVIxNEppeUFUV0tPV0ZVanNnTEczRk9KZFlI?=
 =?utf-8?B?b29UcnkyRVRBTEpEbGl2SDMxbHpaa0pZQVFuaU1MVnMzRGVFSGNyZWJxOHhW?=
 =?utf-8?B?QVFOeEF4dXJyLytXcURmRXFSOFdoQm1zMzlxN1o5YlJoc3hFWVhrZ1JLMmVy?=
 =?utf-8?B?WEorb3UzUTFWdGN2QXVYcEFrZUZMcUtwQjI2bXIxQTJ5aGdWMERjR1J6L2Qw?=
 =?utf-8?B?UExYT2hYdDlyVnZvelYwa0s0eHRPRTdtSlFkUGZXcXc3M3ozRktlOWlMOFBo?=
 =?utf-8?B?TFNmNW9zK0kwVWdZeEx1ZXpKQ1hsRndnQk5xSThWWFZIcXM0SnlUbmhZVzcz?=
 =?utf-8?B?OVJQTlovWmhtd1dJRXpHT09CWU8zb0dnQ0hPUEdtZzhkR082eTB3aDRVazd6?=
 =?utf-8?B?aWw2OWVhTGxqbm9FNWxySU1ZeXNUWUt4QS9TZzF3Q2NSMndFZDdGMmJQYWpa?=
 =?utf-8?B?enBMUEdiUFVDNDQrNml6NWlzS0RwcmNsYWljZWxndEN6a2tBRkdrVVY2MXRr?=
 =?utf-8?B?T0dHL0lUcFdLNmZBVFZDaUhvVUxyUmZxNXRUVVpuWHl6WlFuajF3Q2Qvd2V4?=
 =?utf-8?B?R0V1aURzaUZqOGlqTE1ORzVjc0FBbmcrUG1VNERJejVkbi94ZmMzbWE1TGdr?=
 =?utf-8?B?VkZlMUlIaTR5OHRkNU1mbVNsUWtOTmVZVnJpbUJGblQvK0dwQ3pUS2hFSWt4?=
 =?utf-8?B?ZlNiZWpiRThrWnpoMkdBaXM3QUg5TTI5d0pjM3plampqTXJsbG1QVEVIQTRR?=
 =?utf-8?B?UVhrbHpRTEViTEtTcm1Vd3lTWTNMZXBmbUkxaWpBU2NkVUxyTUs3Ujhod2pR?=
 =?utf-8?B?OU5SMHpjUzdEdWNGR2s4KzBCdlJXZ0NLU1g1VTB5SmZ2TFFSZHowV1hobFhJ?=
 =?utf-8?B?VmpFbkQ0Qks5Qlh6cHlVY0RIbVBJU2pUU1BnS0hrMzkxa3pialM1ekFPSi8z?=
 =?utf-8?B?bnRhUTZFV2s1ajl1bHc1MU1ESm5UOGJYM243ODY0RWIreVFzbjArV3lvNjl0?=
 =?utf-8?B?RVQrckhncUxpd2R6eFF3c2p6dlg0UWFDejVtQlpSQ0tzYk9oWkNQZTdFTFVx?=
 =?utf-8?B?QjFLTVNpWkJVOGlBOEVCVkdDbXNiZEFnZmdMOVBZcmtUUk9qdnRjazZUeW42?=
 =?utf-8?B?OGVIN2RuK3FsbkpSTjg2Zkd1LzFnUnZMQ1NJTWRWNVFoakppQjJpRy9HZmhN?=
 =?utf-8?B?ZEs2VGF4eHN2OW5PMGRYWEhuWlhKWTdQM2ZGekx6dHF0YWtDZ3NzbmZDNGhs?=
 =?utf-8?Q?ZAK0+8ATOrZQFe8A=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d3ae9f-143c-4af2-3f1b-08df1715415f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:46:56.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndYbJ8+jKJ/1nXEOsazCRKfhQt7RsG6BzXI6qlMq1YvJVb6eQ7VPQU4XnEqPlvBYLbLgjT68bhQfnHOG+wKFbYBUKmXHFvmyWKhdJqIdTi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB492506

On 2026-09-19 09:28, Boqun Feng wrote:
> On Fri, Sep 18, 2026 at 05:00:54PM -0700, Paul E. McKenney wrote:
>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> Implement a two-phase wildcard scan to guarantee forward progress of
>> synchronize_hazptr() even if there is a steady stream of ill-timed
>> readers which populate wildcards into per-CPU slots.
>>
>> This is performed by flipping between two wildcard values (1UL and 2UL),
>> and alternatively scanning for the opposite wildcard while newcoming
>> readers use the other one.
>>
>> There is no possibility to miss a reader because all slots for all
>> wildcards are accounted for during a synchronize.
>>
>> As a simplification, use this period flip to drive the hazptr overflow
>> list selection as well, since there is really no point is making the
>> overflow list flip use a different state.
>>
>> Protect the wildcard flip with a mutex.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> ---
>>   include/linux/hazptr.h |  6 ++-
>>   kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
>>   2 files changed, 74 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>> index 43998bf43de4..43122c5673bd 100644
>> --- a/include/linux/hazptr.h
>> +++ b/include/linux/hazptr.h
>> @@ -28,7 +28,9 @@
>>   
>>   /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
>>   #define NR_HAZPTR_PERCPU_SLOTS	4
>> -#define HAZPTR_WILDCARD		((void *) 0x1UL)
>> +
>> +/* The current hazard pointer wildcard. */
>> +extern void *hazptr_wildcard;
>>   
>>   /*
>>    * Hazard pointer slot.
>> @@ -243,7 +245,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>>   #endif
>>   	if (unlikely(slot->addr))
>>   		return __hazptr_acquire(ctx, addr_p);
>> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
>> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>>   
>>   	/* Memory ordering: Store B before Load A. */
>>   	smp_mb();
>> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>> index a9d3d68a1525..d3d1050d92cf 100644
>> --- a/kernel/hazptr.c
>> +++ b/kernel/hazptr.c
>> @@ -13,6 +13,17 @@
>>   #include <linux/list.h>
>>   #include <linux/export.h>
>>   
>> +/*
>> + * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
>> + * hazptr_synchronize forward progress even with a steady stream of readers.
>> + * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
>> + * This also affects the overflow list selection: the current list used by
>> + * readers is array[(unsigned long) hazptr_wildcard - 1].
>> + */
>> +static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
>> +void *hazptr_wildcard = (void *) 1UL;
>> +EXPORT_SYMBOL_GPL(hazptr_wildcard);
>> +
>>   struct hazptr_overflow_list {
>>   	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>>   	struct hlist_head head;		/* Overflow list head. */
>> @@ -28,8 +39,6 @@ struct hazptr_overflow_list {
>>    * limited to the number of list elements.
>>    */
>>   struct hazptr_overflow_list_flip {
>> -	struct mutex lock;		/* Mutex protecting add_idx from concurrent updates. */
>> -	unsigned int add_idx;		/* Index of current flip-list to add to. */
>>   	struct hazptr_overflow_list array[2];
>>   };
>>   
>> @@ -38,6 +47,20 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
>>   DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
>>   EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
>>   
>> +static
>> +void *flip_wildcard(void *wildcard)
>> +{
>> +	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>> +}
>> +
>> +static
>> +bool is_wildcard(void *addr)
>> +{
>> +	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
>> +		return true;
>> +	return false;
>> +}
>> +
>>   static
>>   struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>>   {
>> @@ -72,7 +95,7 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>>   	 */
>>   	if (unlikely(!slot))
>>   		slot = hazptr_chain_backup_slot(ctx);
>> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
>> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>>   
>>   	/* Memory ordering: Store B before Load A. */
>>   	smp_mb();
>> @@ -118,7 +141,9 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>>   		for (;;) {
>>   			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
>>   
>> -			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
>> +			/* We don't expect wildcards in overflow list. */
>> +			WARN_ON_ONCE(is_wildcard(load_addr));
>> +			if (load_addr != addr)
>>   				break;
>>   			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
>>   			cpu_relax();
>> @@ -139,7 +164,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>>   }
>>   
>>   static
>> -void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>> +void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>>   {
>>   	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
>>   	unsigned int idx;
>> @@ -148,7 +173,39 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>>   		struct hazptr_slot_item *item = &percpu_slots->items[idx];
>>   
>>   		/* Busy-wait if node is found. */
>> -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != HAZPTR_WILDCARD); /* Load B */
>> +		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
>> +	}
>> +}
>> +
>> +static
>> +void hazptr_scan_period(void *addr, void *scan_wildcard)
>> +{
>> +	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
>> +	int cpu;
>> +
>> +	/* Scan all CPUs slots. */
>> +	for_each_possible_cpu(cpu) {
>> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>> +
>> +		/*
>> +		 * Scan CPU slots.
>> +		 * Forward progress against recurring wildcards is guaranteed
>> +		 * by scanning for one wildcard while new elements use the
>> +		 * other wildcard value (1UL vs 2UL).
>> +		 * Forward progress against recurring single hazard pointer
>> +		 * values is guaranteed by the fact that a hazard pointer
>> +		 * is not reclaimed nor reused until the scan for that hazard
>> +		 * pointer completes, which prevents a steady flow of readers
>> +		 * to acquire that same hazard pointer value.
>> +		 */
>> +		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
>> +
>> +		/*
>> +		 * Scan backup slots in percpu overflow lists.
>> +		 * Forward progress is guaranteed by scanning one list
>> +		 * while new elements are added into the other list.
>> +		 */
>> +		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>>   	}
>>   }
>>   
>> @@ -161,7 +218,7 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>>    */
>>   void hazptr_synchronize(void *addr)
>>   {
>> -	int cpu;
>> +	void *scan_wildcard;
>>   
>>   	/*
>>   	 * Busy-wait should only be done from preemptible context.
>> @@ -177,33 +234,19 @@ void hazptr_synchronize(void *addr)
>>   		return;
>>   	/* Memory ordering: Store A before Load B. */
>>   	smp_mb();
>> -	/* Scan all CPUs slots. */
>> -	for_each_possible_cpu(cpu) {
>> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>> -		unsigned int scan_idx;
>> -
>> -		/* Scan CPU slots. */
>> -		hazptr_synchronize_cpu_slots(cpu, addr);
>>   
>> -		/*
>> -		 * Scan backup slots in percpu overflow lists.
>> -		 * Forward progress is guaranteed by scanning one list
>> -		 * while new elements are added into the other list.
>> -		 */
>> -		guard(mutex)(&overflow_list_flip->lock);
>> -		scan_idx = overflow_list_flip->add_idx ^ 1;
>> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>> -		/* Flip current list. */
>> -		WRITE_ONCE(overflow_list_flip->add_idx, scan_idx);
>> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx ^ 1], addr);
>> -	}
>> +	guard(mutex)(&hazptr_wildcard_lock);
>> +	scan_wildcard = flip_wildcard(hazptr_wildcard);
>> +	hazptr_scan_period(addr, scan_wildcard);
>> +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
>> +	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
>>   }
>>   EXPORT_SYMBOL_GPL(hazptr_synchronize);
>>   
>>   struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
>>   {
>>   	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
>> -	unsigned int list_idx = READ_ONCE(overflow_list_flip->add_idx);
>> +	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
> 
> 
> What if this happens?
> 
> 	{ <hazptr_wildcard == 2UL> }
> 
> 	CPU 0				CPU 1
> 	=====				=====
> 	hazptr_acquire(ctx, &gp):
> 	  WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> 	  // slot->addr == 2
> 	  smp_mb();
> 
> 	  addr = READ_ONCE(*addr_p);      /* Load A */
> 	  // ^ addr == gp == old, i.e not NULL
> 
> 	  				/* unpublish and wait for reader */
> 	  				old = gp;
> 	  				WRITE_ONCE(gp, NULL);
> 					hazptr_synchronize(old):
> 					  smp_mb();
> 					  guard(mutex)(&hazptr_wildcard_lock);
> 					  scan_wildcard = flip_wildcard(hazptr_wildcard);
> 					  // ^ scan_wildcard == 1;
> 
> 					  hazptr_scan_period(addr, scan_wildcard);
> 					  // ^ will miss reader on CPU 0
> 					  // because its slot->addr == 2
>                                            WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> 
> 	{ <hazptr_wildcard == 1UL> }
> 
> 	  WRITE_ONCE(slot->addr, addr);
> 
> 	hazptr_detach():
> 	  hazptr_chain_backup_slot():
> 	    list_idx = READ_ONCE(hazptr_wildcard) - 1;
> 	    // ^ list_idx == 0
> 
> 	  smp_store_release(&slot->addr, NULL);
>            // ^ clear the per-CPU slot
> 	    				  // flip_wildcard(scan_wildcard) == 2
>                                            hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> 					  // ^ will miss reader on CPU 0
> 					  // because it only scans list
> 					  // 1.
> 
> If I'm not missing anything, then it means a reader can dodge the
> hazptr_synchronize() scan, because its per-CPU slot can appear on
> wildchard=1 but its backup slot can be on wildcard=2.

The scenario presented here includes a call to hazptr_detach,
which moves the slot to the backup list, which is handled by
hazptr_synchronize() _after_ scanning the per-cpu slots
for address and both wildcard values. So the synchronize
algorithm on the right column should be completed to show the
role of the backup slot handling as well.

Thanks,

Mathieu


> 
> Thoughts?
> 
> Regards,
> Boqun
> 
>>   	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
>>   	struct hazptr_slot *slot = &ctx->backup_slot.slot;
>>   
>> @@ -233,7 +276,6 @@ void __init hazptr_init(void)
>>   	for_each_possible_cpu(cpu) {
>>   		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>>   
>> -		mutex_init(&overflow_list_flip->lock);
>>   		for (int i = 0; i < 2; i++) {
>>   			raw_spin_lock_init(&overflow_list_flip->array[i].lock);
>>   			INIT_HLIST_HEAD(&overflow_list_flip->array[i].head);
>> -- 
>> 2.40.1
>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

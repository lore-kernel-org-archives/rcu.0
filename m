Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020102.outbound.protection.outlook.com [52.101.189.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4D3EAC8D;
	Sun, 11 Oct 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749191; cv=fail; b=C6CBB4AKZ2b6hlaEpavLnV9/BspzJfh85Oex78vIiWeakVDiGZjp04kzCViGCAAmbnVQ+HOY+31v/I/l5PJ3tq/SwV5M5sT1VBW14VAna2eYUc4yvM2vds7BzVT9iC6MaQPYayfxKJZt7i3dvG0xGOwo8z2RH/QTP9KAbqqjnpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749191; c=relaxed/simple;
	bh=Hjl24krGP2wGz45ILh+cXt0f/W2QrIoZnUXV/Fm3biU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BkUB4ATX2ab9fL2fpnmLnrGfVnVCsHcCgVj70wKYv0oUAYWLI8IA5D77f36g2x43J6SrGAy7pv3+5wzNSF2qwLUIXc0mL/7KWxIhveY/NEMVAhp20eiGeks+2/hfMNBM9WxOOijoqnq46Hd9L9kAPaUfKwulQRsxhUwY4B41KKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WcJl456c; arc=fail smtp.client-ip=52.101.189.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WcJl456c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq3J/W+HBW5bupkL+dnE9fZyL9OUpe0FQWyvHSuFSkKSLj0bvSlPiMUWv+MSWk9MV3VbLmnlY8BzuB5y73Zq5nDpL+Us3dBfnUTd36ct0Z8TPkDhkV03Sh+HuTRdogS7IXsT725Xk04ZPN1uO3qdgx7HGxD4xunTrOa+rVE9yfT6kEnGtRMr/3LtLeRGl7ov8b5UVB3kH50H8yGWYGGL96APQx3a7F3BmBrQ1TP+u63/ZEnWrg6pniAOXOj4gcIBncXh9Qz1sWxbbWds6vyy7t/Exd9nPp1jG5yUmY2o+7yXeCmBta1kxGAgQ6jMIwvk1ZfG92jKAhjNzkUMfAV3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OL20Pza5HyE3tD7cs8q77aH3xITZJhqKeOWl1bB8kE=;
 b=xYoVTn7SEI2FPGBhvYYoqIQUNtpE3PSC+Oc/uNjzKDRoRC6vJisCWQRwkF52ysHqWLhoLj3Jwij90scTN832u3FRvaBePvoMHlOfwHDROEW7v5t99ESE49NBBq4nNV/667h5s5le80ltOoQXMVWG4hjfLnpRK0cKGm5BNApLNTe7OHd12hwKl+M6+/50CO9+eayC387DIPnO2uAcO+VnDoAfcY/SE91W3u2DBztvkDH7UYswat8rYtayZXzd/pv4pRGYu8hi2vFydiJu3pV3nEC46/P9S63tNwiKfMIuRNCWD7kaFtiY0uu8nBjyiKf72vfeHj7zSCwvO22QLL0YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OL20Pza5HyE3tD7cs8q77aH3xITZJhqKeOWl1bB8kE=;
 b=WcJl456cuiRZnabANx1n6ACKThSB/vIMlVoD4fwKcQDpgn9hoJWo1vD9Roz8P2A6LxXRH5bPOTYuEqPp3219Esew6T9LvIDA5VFP2dr/uxB7eQRiX2XB4THF34F8pzVx9zt2rnsy5KZSs5YFP25gFwVL6Q/I0Aj609Ql4fSywQBgOJMJiHbuFAOX6vIn31JnXqAMC3YegnsWFkKbtTJtt3AHNlA2+ww5sUpbk7TpqU5erjUkSLtza6aP72uDq8UiN6J7CTrZazquue1bZmczO8b7pU6FWsN20Vvb8pa//qFbaN4EwOFpj8w8Rg6SW26xYd7tpUSQ/mVkZCMofQSWhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT8PR01MB612386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:12::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Sun, 11 Oct
 2026 20:06:25 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 20:06:25 +0000
Message-ID: <97f91313-e629-40c0-b3ff-f23c235a8ad8@efficios.com>
Date: Sun, 11 Oct 2026 16:06:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr v3 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
To: Bradley Morgan <brads@mainlining.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
 <20261011194902.97364-5-mathieu.desnoyers@efficios.com>
 <E99B2D1B-6D27-4ED7-A7A4-083DB5427925@mainlining.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <E99B2D1B-6D27-4ED7-A7A4-083DB5427925@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT8PR01MB612386:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b66b566-ba05-452a-ce3d-08df27d32108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1+y9V4pfD1jkRmnbPALuzCuWalkd3VzCyGaFnUsFv5iImJSZpxlIYy9xWDE3rJxucBQzBHiBw4Q2qzIqp+bhVC5dAWR1Bh6z3N7l6rlJOuWdbKeaUYpV36HWeYCEdrDaV7k3op0lfVqLhQmje+/7KdvAXmm8I+p7iJLakgR47RllU0n1WOCvPBn8g7boBPfC0K1/aLWx6TGAYQm6egkZXtgeMqBqMJx0vlH3T2watKA0yNFMkTibPpbPiqlV77WZ8vGGlBKZNOOThgESq0d5/cw1sirQ2Veg0/vLsJIljZ2dxm31kdGvkaUZZHsyVOn8keYK+vMakIxbqzIWd9zgFUEZoxd7JadeAA2+5HuJg8XbUvt4Un0gkgWp1RMHEeVZp4rNRCp/zsgO8b9Hdf2U31DLGTuAobwo7yGmy3x4mBPODCTHXl4swbUBWS5Csi2mtSF2vCeEFiuIFj6TDxy/ekFsZxpznzqTdfXXnmHWexaYQ+KexPr7fSvMtAEiPLAYaof2e0wZTjFE6Y1ccGTBOEcjEb4Og89KnyzDZXOItwoJwJaksLRlWmRFdHjtt+ZvArxrxQtSJ1PrbNTamO2Zo1aP8LMFlW30BGeCDy733Zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkpoTFFvRUQxc0ZQUFZvamlsVmxDL3BZUFJScjdqeWk5d2xKaHN3QmlITVBZ?=
 =?utf-8?B?SXVTdEoweTdVRWg4ZjBoNDR0dDN3THJyeHNlcXFyY0paeGZFWnNoK1JOMEdu?=
 =?utf-8?B?QUJTbm1uaXhMeXNtRElSMUtlbGd0MG5wMVVTbThHRlFqd0w0Z2dsS1FlSGVi?=
 =?utf-8?B?Vzhob3Y0U1U4KzBwZzRmZ3NDS0V0cWtTYzdOakpad3ZwdTAzWjRLbkJsK1dW?=
 =?utf-8?B?bXI4RW52SjhxUXdINmxCdmlZWVZQSVFEeE1vSE93R2I2dWQ3QnNMV0NtUmFG?=
 =?utf-8?B?TjFxT0pYaE04UkdaWlhZNEtKY1ArYzVrWDNrN2lMRkIxdVh3QkFjQWxvVVd1?=
 =?utf-8?B?aTFPeUdaL3NzUWcrcHpWa1JwZDJsQ3kzL1hLUlJlZlFscnYxeDNPTEtwUldP?=
 =?utf-8?B?dDhEc0ZKVXpGYVZ3OURvQlhIWnlmT1AxUlpmZGl2dU43elNNTWlXdUJnaFlm?=
 =?utf-8?B?c2dxbHlYc0Fsd3RGZDc4dlRvcHNIMExwM2hCeElQenlkVm5Ld3NmV1U4S1BB?=
 =?utf-8?B?T1U0bUQxa3NNVHV1Q29hSXYxall5TGlYTGszamJWQWJINGlyZmpwMTZRTCs1?=
 =?utf-8?B?UlZkbVF6eGw4bHBFN1NaZitDYWk1VWtGcjNReUZ2NkJrQ3N6N0JVc3JBY3dP?=
 =?utf-8?B?RVlVb1hrT1E5Zlkya0gxeWFmeTIxblAvWldFS0laWnBEbUJHTVZXL0lhamNp?=
 =?utf-8?B?WGVaMk1jTG9YNDZXUDM0Y3NMZTc4OGhCYi9tMk1UcUs3UUYwNHNZSTlIejVR?=
 =?utf-8?B?Mno5cFRjSDNNbkh6b2E2RjNmREdPZHdXT1R3bHJEZ2ttOUpHSmZXdG4vclJw?=
 =?utf-8?B?REFXeStSYk1FTEJQM2FvaWc2a3AzUUlLN2ZSVmNqdkZ3M2t0YzNjL0l0N0Jx?=
 =?utf-8?B?cFJzK3NEaTlYSkdVS21kMFA0ZnZnQzA0eTE4VlgzTXBUUGw1cTZEcUxSMUhl?=
 =?utf-8?B?ZU4vUXhUaE9ZN3hrVElsem5tZDF2TWpXMHRjblZrR1V5TUZ1VER3STd5ZGJN?=
 =?utf-8?B?anZFd1lrQ25oVmhSeThxNE9Ja1MzUXNlMkJNekRCaURNdnJXbDFKdkdjYnpo?=
 =?utf-8?B?UFllak1YaUpidzgwNUJBT0FHWTZZVnZpeTJpdEhoYk5xalFZLzZ6alQrdVBE?=
 =?utf-8?B?NHArRGduRW1uck10S3ZlSFRXamlObG5EYWxZTjRtK2ViV09XU21KSUVzdUlz?=
 =?utf-8?B?R0Q4ZERsL1RDOTVIZFBkRXhDWlhBUmdXcFduMXlhdUI3cVlFOWh4VGJDREtm?=
 =?utf-8?B?OFRVNE8rTnVUMkRJdkNpb3ozeXJrb2RnUndrdk9yY2hFT3cwVkxhLzdEU1VH?=
 =?utf-8?B?OXp0OGFVckRkUWN5WVVYcHRucW5PWW1iaE9FTjJaMi9FRXZTL09uZDRlbjBa?=
 =?utf-8?B?bXVKMmt6RU1XK3VUL2duWDRnTEh6KzFBVm91MzdTUFN5SnRLNjcyR1VlQkVr?=
 =?utf-8?B?SmdMOGV0bGowMU5mV0kvK1RROHgwd2VXQ093QjVCS0RzR1hTeXFtYzNUcXM1?=
 =?utf-8?B?UXFhZ1NkeXFhQ3BDYzA1bnYwb2VOaW9kTTllYlVOVExvSW5QS2dmS2FPNnkr?=
 =?utf-8?B?emMvTkpMV3k5YXlHYi9zWHFxckxoV2R1UXBaSEtKQ0tXL3dMNEUra3B6bUcy?=
 =?utf-8?B?dW94eklQVjBPRk9qMitYM1NDeHZjdDE5Q3RrcFRKU1JNTXZhZzFaQnRJRkZi?=
 =?utf-8?B?MDJLYU1zd3lvUDJpMENZZWc1VjdmN0JTOUxIQk1zY29UZmRWSlJlNnB2SS9R?=
 =?utf-8?B?cGRwMzBoSjlLL0VjcVAvUkc1YW5PV3BhaGs3ZjF0dTlGaWZVdFF2TVcyN25O?=
 =?utf-8?B?MW5CbklZR2plYzN5Y1kvaDdBbkhwbWQ4V2JXaDRnRFpyQUxwa1FVUWFtcjZp?=
 =?utf-8?B?UC9yT2w4OWJWbGQ3VjBwVW9UNldPbGdPU3JieUY1bTV1ZnJ6Vi8wd01nZlBJ?=
 =?utf-8?B?djJ2NXNoVnJldm0zOGdxS05KQjA5dVk2cjZFN0U0Ymt4Ym90a2ZWV3liVTZO?=
 =?utf-8?B?OUdyQTFTRTZtck9XdXh5WmFQZ09PYUhWL2g4QURINzMraE9FRko0MmZ3NTRq?=
 =?utf-8?B?YzE2ajZHYk8zQTE5VllLcGIzcHZqcDAwTjVsNUZFUU9yZ25TVE5sOEFlNUUv?=
 =?utf-8?B?QWo4Y0xLdy9WVTdkNkJIM1dkRVlxNGo2Sm9ZK0hrUWVONEcza1I0Z2xnRmVU?=
 =?utf-8?B?ZWNBV2syNHpKQll3OHVXSEZqKzJCZUdSQ1lWeUVKcEVXYjllelRZWUZQZHA1?=
 =?utf-8?B?QlZpZ0dNMHdLUFZuUnlxWUQ0NkRLSjNZaUswZHpTaFplQmRnWVMxakplbWhL?=
 =?utf-8?B?SGNNWEM4SmpXUkVxY1BUZDBpak5JZkxRdDgzTHRXWU9pQy9BUy9yTGZhWk5v?=
 =?utf-8?Q?gBl3eoDMpXrZtniQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b66b566-ba05-452a-ce3d-08df27d32108
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 20:06:25.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w1UvAKyuuTKvJarG/0Ehq9pJEyPPGt94e5C11zH+8O/ZpDRrmG8c1FsFTKsh8sVBjp5inZghQC3Xj71/qg+mcEexwuptmzMAGglnYNujwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT8PR01MB612386

On 2026-10-11 15:59, Bradley Morgan wrote:
> On 11 October 2026 20:48:50 BST, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Introduce a "try acquire" hazard pointer fast path, which performs an
>> early load of the address to store it into the hazard pointer slot, and
>> then re-loads that address after a barrier to check whether it has
>> changed meanwhile.
>>
>> On comparison failure, rather than re-try, guarantee forward progress by
>> falling back to the __hazptr_acquire slow path on failure.
>>
>> The acquire slow path attempts a try-acquire for any available per-CPU
>> slot. If that fails, it chains the backup slot into the overflow list,
>> therefore guaranteeing forward progress for both hazard pointer
>> read-side and synchronize:
>>
>> - Readers set the wildcard, and then proceed to set the more
>>   specific address to replace the wildcard.
>>
>> - One synchronize alternates between two overflow list periods,
>>   scanning each one while readers are added to the other period,
>>   thus preventing a steady flow of readers from preventing
>>   synchronize forward progress.
>>
>> With this change, the scan on per-CPU slots don't need to expect a
>> wildcard anymore, because none can be produced by readers. Wildcards are
>> only expected within overflow lists.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Suggested-by: Gary Guo <gary@garyguo.net>
>> Link: https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net/
>> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Hi, my R-B still stands from
> 
> https://lore.kernel.org/all/C53DEBF5-555F-44A8-A11C-A15C83AAD341@mainlining.org/
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

Sorry, I forgot to add it to my commit message. I'll add it to the next
round (if there is one), else hopefully Paul can add the R-B tag if he
picks up this series.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

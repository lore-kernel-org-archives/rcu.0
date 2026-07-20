Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D238B7B4;
	Mon, 20 Jul 2026 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579583; cv=fail; b=mh28l7UdI+M2u2CYjXvmS4RUrQ/U2bjrgjgPu3S4KIOl3w6CV31kEPzCUyLGk/28Tvh/8odyXonOekzi172G0xKcILw1kln1P2lGeL1AXp/6IG0X7KD0o6fp3ryQ4SkoCorEJZctgeIOtRgLalb+znGM8mWrimiCZReB+TYG1jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579583; c=relaxed/simple;
	bh=2b4Ap68m0GghQVpqcDQZ0r3JLKL17NmR/E9B0SKSVrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUU5OSvAShiVkuYvzrMp0rAlJKgD1jw1B2DVvNTGyG8xVUzQJJX2y0CHWXiz3Q4PWyURgJWJr0LtlDsuOtqdYcBqNkgjCmRU6lnRcWWIGF/9MBEtVYvOKMfEaPm1SG6hBrI/9+Adf2Frg63HE1ztRexLfZY59FwTyijEnKEDKF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EFb4fOXU; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFb4fOXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9RfQ243Fn9vkui29GpOWG+yTzsz0VG7WH/p8tNcQf4Vuf+9ruzKU6MzOQNb/GZCu/IPWUZCJW15pnZyDtI+y79WmaKZBPwyoDW1h4hINsrw2/EnSAbM70wTC2CwMVfOCxLOzLVUEa/xFXmRidFvCzu2w6qzHQRVQSfzwb1L+MTw1Xn7EKHMWAcaH66Z0HCa/JrZpVYA5WbBRF1h/5FyLDsq0PZBwK8Kg6eNKCvC9SttRi2PPGy/lWnXdmhyXyUVuO1GlUDTtTKVqbYejfCs5UURpXkUxUk5i1WbqLQie09w2BFGi+qLJ9mG7acaFBsgu6abXWtFaDbCovRYePPA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D47UigBy+3QSOWm7AFl2qWidbMPmxFgkSk5KO3mg35I=;
 b=now/JCo55rs62sLTziD3M5xeA+23juIwd95Y6OQgERBpSxUQRF9n8CkPDZEcolUa0A+VTGzy+Gd1gi+LfonCiexMxbUGpqSoL+Ik+70hUJU8oAcTlVmSGFTTNEot2KTfzfig4ZtLTMSpOE8u0a7DZdColMaA5uwza+y0x9DVCxr2n/col77iYQ7B4xaGqooVOvoVevoAaKtYT+lBU13WbRJshpJCdBa5Pvqf90+FUqYDG1RiZzRtc9bKrpe0rCaueG6H6mE3b06er+39RsOlJELBfgmSo2/O3IDJAFmXIMrXmczTi2PennKYmOVsukIcBn+IxwbTZgpXlH8tflBpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47UigBy+3QSOWm7AFl2qWidbMPmxFgkSk5KO3mg35I=;
 b=EFb4fOXU21Vg9NgNGe1TVp7VhppmNogIj4HzDCZGq1AU471PbjGfvOvQYhRZw2qqkI46B2CtGtotRuxzGcc5VHnQyWyK6vQ20wbeDXIC9hfrNOKC5BlLBZ1dI2nYtIkOG7uv4uKh537f+AxEtV9nhC7rONeC85UjDiRmnGL0/2uk97eEqA9AeaaZPDdZJ931Z+QvhkAuSv5ubTFWmZashtTqmDPZOhTgRJObLeXn3ambfwFubS5IQLLq3Ane2tD5d8LoAERIPizD0hKv/iOSO9cjRJy+VA5ea4cJNC4/QTk4f3DCYwe3qz8wYAV9ZXtx1+RDvn0UAc4ELbt6BQ7xdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Mon, 20 Jul 2026 20:32:57 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:32:57 +0000
Message-ID: <1894b814-7a1e-46be-9c2a-581a617c4add@nvidia.com>
Date: Mon, 20 Jul 2026 16:32:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] rcu: clear defer_qs_pending in handler for
 compounded sections
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-4-joelagnelf@nvidia.com>
 <e6aa799f-2a1d-4343-8159-715827fea64e@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <e6aa799f-2a1d-4343-8159-715827fea64e@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e42be21-903d-4e0c-9ddf-08dee69e1554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1UEc6oFkMd8eaP+wqXBpvyKZYHnKsYXcFfKBNeqfUYFXk0IMS0yUKh+3JhXauwnZ1q8A9Y7kOtVwMqxUIbcOGt/h5gql4KyiTXSFHHWfwQidLSENCGHHda1IUKFSC/SZ1f14JyWKKVa+XsTaPuWTdxAJKFs7TFLAqaS6d8vw5CiabjqX8FzH6BZNOo+YtKchBBI9AN8HdoJ2TbNpKDnsEn6AHjjshBWYrJbcD9jOBtEJobuK8O7dMh4KrZS0wCYpixHvJHeECeIWPggPceb5AdJ4+BK0NR42YCNsnD6evhMXlkV5hDnqoIBDWiAjKGqxSrVAKY3a3GHmZhYmrlbbKLpybqFvenJgG+fhTdQWNVzvOlAzafgLjkKLtot4caQRHOuBeL76CrnnEN5EaY3MwdVsoAo1muWFX8oiPTkK421fbUOshd6xVm1cn211gnaoQTticKYQRxZ2PAkwEaOxh6aUEzB3JEl1HTQi4sC5+jcBJwBa/+UoBvUwBVC0IuW4SXOYFGoqwGOxolnr8INEgLAgXQb8PsTp+QVK0GqxQu+G3Pno62MT0WCa1VBcNYleKsWJsK8U8qd/dFNzwFIRgyTr7ujENZ/72JfUIb0DAebZKPpKXPHKKXU/pV8kKssrth2i1mrqY4a4KVD09isbydxZkI6DO6bReyMIhLuAE8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eldKWkY4dlB5WHdxN092TnYrc01NaXBrcGJlNERwYUVwNXoyelNpNXFrTlFC?=
 =?utf-8?B?RVhuU2xacnVVeTNucnUrQTdnOTZkVldPV3pIUXROTU1PWC8xN0hDU2JxNzhs?=
 =?utf-8?B?aHc2Q0FoTWF2Q1NnNlJhNGJPdmVWbU1nemVlYjc1U09ZK2gwKzRLY1J0eUI4?=
 =?utf-8?B?SUx1czJiOHFFU3dvWUZuNHYvenlLeUc3WXl4RlBhL0pQemlxZzlsZW5HTWZ5?=
 =?utf-8?B?ZmZlQlRYVStIVlZWbUFsM0prdjZUOW5yc3o5V2U5Zlk4V0w1bDk4V05ORS9R?=
 =?utf-8?B?d1h2Qk0zRVhGWE9wWDRIbFVWak5WNzBTMWFobFlNeFYxQnlNVTRYWDVTTTRk?=
 =?utf-8?B?alltZDV3a3Z6UEk5N3JpdGlQTDR1ekRHY3lTUkxGa2ttSEhhNm1pbzRuZ2F1?=
 =?utf-8?B?YmlLNDJWZ2VRTmV1bkVxbEd2djgzWHUxTDFneWp4MTJHVVdvaHdlYktuVmdS?=
 =?utf-8?B?Y2gvYzRFUjFDbGhHaDVLcmVDY2JNUVlCc1VRWGZGRFFlRXdqMFgwOGVQbDUw?=
 =?utf-8?B?R0d4Z205ajV1WXJxODRyOFFYZUx5SGpkZGR6a2d0U05IdVU5Y0dzMVFidDNl?=
 =?utf-8?B?M1VRazBLSTllWEozZVZtQW4ybVJTWmNQSVRXVk1LZFU5K0tvL0pFaGVVOGht?=
 =?utf-8?B?dGh3UU9EZFhVU00xejZMK0tybStkZVFERkM2aHlKS1FxQlJqekswRTdwRUFy?=
 =?utf-8?B?S0JyZGhad2o2b3Qwek96SUJia25aNGttS1AxVFZwaFZWL3Q0ODkwU2lkRlhW?=
 =?utf-8?B?UWN6ZE5xb0JkZW4vTXkvR0F4b1BzbDFhSVdteHRxNDZPYlpPNjNhMW9qU3ZD?=
 =?utf-8?B?ODVDa2J1c2RncUVrbnZ4Sy9wc21hYkV5dGpJc0lpWEhNSG95ZDg3ZllUL205?=
 =?utf-8?B?Vm10SFo4elhrVEZIaytpMUFyU3FyZnpCZUVSdXlRd21UbEJuN0tUMVk5N05u?=
 =?utf-8?B?aUR1R0h2NWQxUTU0TU9xYXR4cXpQZUtxc0x1MzBmdDhhQ0R1WVoxUHJ4Q3hw?=
 =?utf-8?B?ZU91dXNUdEIxaUZDdzZVbUZMYUJtSTJSVXhYQUgwUlFrMDJZdktxQ2UyMUxE?=
 =?utf-8?B?NGNTS0p3OGFVcHRIdGVMbWFRaE05N1VFcFZmWGJkYUdTWW5TdWVKVEtwR1NJ?=
 =?utf-8?B?MFZzZ1VVTnNvbHRuV25mUE1LUGNkb21udjJzTklWQ3YzNmJWZWNxZklzaVE2?=
 =?utf-8?B?U1NlWkFVVlk4MHNROEdMQ3gxT0c1SldkaEVFaGkwM1VMdlI2djgxdkJHZ1ZW?=
 =?utf-8?B?UlF1VWk2akxxdGZVWFpPUTVxcVJjZlFuVTBFSmk2OU0yM2RNRUF5eHl4M2tZ?=
 =?utf-8?B?SGF0a3dHTjVqdU1oOVRWRmtkL24zYWFaZlpvOGYyc2NyeVJiaWhlZlJ0WTd1?=
 =?utf-8?B?aExhb1RUY2VUY0g3U3JjTktCaTdvYlUyWDFDVnIwS3BqbWQzT1BFbmRNQ1RY?=
 =?utf-8?B?T3llWFlKZm9tZTRpQUtrT1Q1S0FuQ1RnYjUvYWlsL2lxRFhWdmxKRUtFckFt?=
 =?utf-8?B?NUtoSStTT3ZsdUpQTVE5ajI3cDFOS2JCdUVNMk9MV2Q5ZTFObHhQYXFaT1Rh?=
 =?utf-8?B?MFFkeTNzaFllSFJjdVdFS2pRcm91U1BFWE93MSs2aDJNaWxpQWU0Qk9xUnlK?=
 =?utf-8?B?ZG5tYW9pR1RUVjVZV2JuVG9Hckg3eEs2czN6dGdjeVNoNkpSSnBhcGNsN09v?=
 =?utf-8?B?TEd0L2xoVXl2dGZlM2hHQmZJL05JajRaY21PdS9ITHFGZFB3bXN3WGlyS1dx?=
 =?utf-8?B?WXZPalFpclNYaDJQNXRuV21PWWNhZjhtbjBleHdoUzZuanY3Vi8xcjFoNExG?=
 =?utf-8?B?WklqSzFmSTRBS2p2OU1SRmdRaHRuZ0Y1ZW1OaW9PYlJIMVordW1XVFBRWjEy?=
 =?utf-8?B?cHAza3VDUWhVT2JEY3p5WnN6b05LdExydGdPUkp4Z0E0WkNmZHRyUnBibng2?=
 =?utf-8?B?VE9lOXUrMUd2SVNPREk3RllPK1J6Vmp6UXZnK3lPZkVrSnF0L2hLeVZrTjA4?=
 =?utf-8?B?LzVBdDA3VGhXa1pTelZNQTNxeDgyYTNzQi9tZ2RmRTN1aElTQko0bEd2d2Fm?=
 =?utf-8?B?dEQxZitlR2twbXU5ZjQ4ZnE1K2tjSVRZNC9RWllFSUFBdHVHY01Kc05aUlhp?=
 =?utf-8?B?MjA0cW1RWmZEMWxoeHBnR1lldVZFaTYzUytodDZWb3ZINVJUUU5qUU5yU2NF?=
 =?utf-8?B?a3hodnRWZk8rTnFmNUN4dkxOemR2WDlJUzY1ZkJnRW85ZXNXV1VsTFFHeTZB?=
 =?utf-8?B?RThaUHZrWkFQdU9RT00rWFZlVmpHa0pIYVBRemtZSEswZUdxTk9KM2hkcDVR?=
 =?utf-8?B?cXJ5aEdZZldCZ20xcnBVUFA3M2M1aDQxdXVFVFlvSzdKejRPMGxUUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e42be21-903d-4e0c-9ddf-08dee69e1554
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:32:57.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la6PZc9mZqjq+/Z/l311MUu6maDY65ny5d11q5jshGFkhZkh15VJS/m4YA9oEge35N9Qnxl+hKlDdh2dD7j4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314



On 7/15/2026 4:50 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:42:56PM -0400, Joel Fernandes wrote:
>> The deferred-QS irq-work handler previously cleared defer_qs_pending
>> only when the handler ran inside an active rcu_read_lock() critical
>> section (rcu_preempt_depth() > 0).  Paul McKenney pointed out a common
>> multi-segment compound pattern where the handler fires between
>> segments and segment N+1's arming attempt is silently suppressed by
>> the rcu_read_unlock_special() pending-gate:
>>
>>     rcu_read_lock();           // segment 1 starts
>>     // may be preempted/boosted here
>>     local_irq_disable();
>>     rcu_read_unlock();          // segment 1 ends; arms defer_qs_pending
>>     preempt_disable();
>>     local_irq_enable();         // handler MAY fire here: depth==0, but
>>                                 // but preempt is disabled, so it cant
>>                                 // nudge.
>>
>>     rcu_read_lock();            // segment 2 starts
>>     preempt_enable();
>>     local_irq_disable();
>>     rcu_read_unlock();     // arming attempt suppressed incorrectly -- (1)
>>     local_irq_enable();
>>
>> Waiting for the next __note_gp_changes() clear is too slow for the
>> compound case, we need the deferred QS report sooner.
>>
>> Therefore, make the irq_work handler clear defer_qs_pending whenever
>> rcu_in_compounded_section() is true so that (1) can do the arming.
>>
>> In addition, introduce rcu_preempt_deferred_qs_try_report(), a small
>> helper that reports the deferred QS (and releases any RCU priority
>> boost) directly, but only from a clean, non-reader/compound context.
>> When the handler lands in such a clean context it now reports the QS
>> directly instead of merely nudging the scheduler: this makes the
>> irq_work robust under preempt=none / voluntary, where a
>> set_need_resched() nudge would not enter __schedule() at IRQ exit and
>> the QS would otherwise wait for the next tick.  When still compounded,
>> the handler falls back to clearing defer_qs_pending as before.  The
>> bounded-delay rescue hrtimer added in a later patch reuses this same
>> helper.
> 
> The patch generally looks like an unambiguous improvement, but just to
> make sure that I understand...
> 
> None of the code below is even built if CONFIG_PREEMPT_NONE=y.  So is
> the text above referring to kernels built with CONFIG_PREEMPT_DYNAMIC=y
> and booted with either preempt=none or preempt=voluntary?  If so, we
> need to explicitly state that.

I mentioned "preempt=none/voluntary" above, but you want me to also mention
CONFIG_PREEMPT_DYNAMIC=y in the commit message? If yes, I can add that.
However, just to note, this patch is relevant also for fully-preemptible
modes. The preempt=none side-effect of this patch is just a bonus (since we
can't get the aid of the scheduler in those modes).

Let me know if that makes sense, alternatively I can also just remove the
paragraph in the commit messages starting with "In addition,..".

Thanks.


> 
> 							Thanx, Paul
> 
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 46 ++++++++++++++++++++++++++++------------
>>  1 file changed, 33 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 7555022bf38a..7768a40677a4 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -702,7 +702,32 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>>  }
>>  
>>  /*
>> - * Minimal handler to give the scheduler a chance to re-evaluate.
>> + * Report a deferred quiescent state but only from a safe context.
>> + *
>> + * Both callers (the irq_work handler and the bounded-delay rescue hrtimer)
>> + * run in hardirq context, so preempt_count() always has the HARDIRQ bit set;
>> + * the compound-section check below deliberately inspects only the
>> + * PREEMPT_MASK | SOFTIRQ_MASK bits, which reflect the INTERRUPTED caller's
>> + * state, not ours.
>> + */
>> +static bool rcu_preempt_deferred_qs_try_report(struct task_struct *t)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (rcu_preempt_depth() > 0 ||
>> +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))
>> +		return false;
>> +
>> +	if (rcu_preempt_need_deferred_qs(t)) {
>> +		local_irq_save(flags);
>> +		rcu_preempt_deferred_qs_irqrestore(t, flags);
>> +	}
>> +	return true;
>> +}
>> +
>> +/*
>> + * Minimal handler to give the scheduler a chance to re-evaluate, and to
>> + * report the deferred QS directly when the handler lands in a clean context.
>>   */
>>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  {
>> @@ -712,19 +737,14 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>>  
>>  	/*
>> -	 * If the IRQ work handler happens to run in the middle of RCU read-side
>> -	 * critical section, it could be ineffective in getting the scheduler's
>> -	 * attention to report a deferred quiescent state (the whole point of the
>> -	 * IRQ work). For this reason, requeue the IRQ work.
>> -	 *
>> -	 * Basically, we want to avoid following situation:
>> -	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>> -	 * 2. CPU enters new rcu_read_lock()
>> -	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
>> -	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>> -	 * 5. Deferred QS reporting does not happen.
>> +	 * If the handler fired in a clean context, report the deferred QS
>> +	 * directly.  This makes the irq_work robust under preempt=none /
>> +	 * voluntary, where the set_need_resched() nudge would not enter
>> +	 * __schedule() at IRQ exit.  Otherwise we are still inside a reader /
>> +	 * compound section: just clear defer_qs_pending so the next
>> +	 * rcu_read_unlock() can rearm.
>>  	 */
>> -	if (rcu_preempt_depth() > 0)
>> +	if (!rcu_preempt_deferred_qs_try_report(current))
>>  		rcu_defer_qs_clear(rdp);
>>  }
>>  
>> -- 
>> 2.34.1
>>


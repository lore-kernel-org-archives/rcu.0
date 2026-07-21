Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FC3955F4;
	Tue, 21 Jul 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649351; cv=fail; b=W7jo0GME3JhEfoGGRpi9ZYcG+D7tX6OYih7QIn4p92ivE6uct9dGuNqW4rBAMUYRY8FOfxSBvus823NlEiD232JhT712xzrD4WLTqHZj9Nb8pILjdmCR805uJ9nKcof38eYqWtn9MfYYppm17VGfAPbRRfbQ94BNc3VF6DcDbx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649351; c=relaxed/simple;
	bh=O82Fvj9OImpERqAC70iGLrnBp5Jv5NCzOUCd3/ffONI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=en07CLbmyt1n9cjoilYYUvFSzJDxR0zi53nM3xzgjOKK5zEWuPRMJPabfTPZPo+qN6dNtRQTWYm++7V3kQo4PblhPcf+t+jl8nzQavUweuK2JBNpBmTN1vh5eNUnUqg4xffjYDk14pG84MLciLIWrTaShn7XzYeELjtEplymzBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VgzOjpUm; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VgzOjpUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzxoZ7N3zm2+CDDR0u43SeStpXuRoe+Ij+Y7IMKOJRWFafhmAQG6ihTgqClJIM9VgTdaY+q35smNeCrvEkI3rPBm4HEI8fKxSGiUy21P2x25vr5mbKh5I4EtWYmo1ZrIcG5kdENiiZ5taVYK1C70+hIa9nla9DWFh0YNK3UIElKg4d8kWEyoKA55UJ8hl8rOHy1rygpqH3zvdbmqusu0y1kD0W0pw6SwspSgBVzgJ9BHg2dm1KRde0K0WAetrDlvPinc2Jp0KslCWqdjf/3WNMrOGv9NnPC1qjNc4c91t/YrjDQ3p/zVeL7S2cCMeAYDGOz1sTEtRKuOcg4fIsDSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQy8lgvOg/8knXBL23LmiA0adYQEKeO/mzW4hJkW7DE=;
 b=gDRa+WpUuolhdke2UyQyuzGfLFq4KTPVvZOl9+sHdceCwioOx/PW0+bWReTPkwBj33lQwRegzFch3Zo8iva1VK6m+OehiIMA8HKU+Agl1YScGGEmQJ0Xrl9uI69Y/qWUYH6xVPSqb4QRNQ1e+qT6M/1i1MLBxytHhwDRzVILBJsfg6adP0un0HWKTugDgSoTEFftAUKaOO1Kinp3xy1L4JPSXFW9wXto4zMMhqQyej7sPlyOtqufxABIvWf+hnmseB0gVfg7B/CKjv0K/DveN2wEKJuM/+txSC19sNhIvDsSiuvHojJPXvd/PVUzVbl761BaQ4cMdLOuysNQklQF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQy8lgvOg/8knXBL23LmiA0adYQEKeO/mzW4hJkW7DE=;
 b=VgzOjpUmRoL1WeHuhv7iEa1cY6K9K+woTSg6gwKUKP36Fn6Ls43frwlfF2T6thRB6MLiHsChoiPwkJvW9J2gQpsp3RlRdIWMQUf7SrsnrR/Daj+9a/CTcbbs63pYUQSB120drDfPE3tvx95xm7CucwACSBYa3M8sm5qI7f6G9jE1La3VggIrUbgWdfjCHMEmirrO+Qu6Qp+e3mDK5obDykKXOkwKEUJ4bevKJpqvAthYOpuEQJxi7llzgnZoMiof/zraowb8oo+V5emwIEKHWO8jxPszcD+HAIPv2o+6rxj3HyBJg90kbubceuCotbNQ1wLIvC8lox+I1vYhmcshUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DSVPR12MB999149.namprd12.prod.outlook.com (2603:10b6:8:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:55:44 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 15:55:44 +0000
Message-ID: <3dc26b07-ac80-467a-856b-0fe2c2000df6@nvidia.com>
Date: Tue, 21 Jul 2026 11:55:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] rcu: clear defer_qs_pending at expedited IPI entry
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-6-joelagnelf@nvidia.com>
 <fc902af8-4e2f-4e23-834e-6d00fa85c06c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <fc902af8-4e2f-4e23-834e-6d00fa85c06c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DSVPR12MB999149:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f29e8d-ae45-4423-4f48-08dee74085d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tDRTzmIpXkuR8MZnxfNYcr0cMRkLpP1s1bokk9gOqdDm3cZv92uWun43JbfoQWukRpEil1sGpt3AY1jZMUZuLCU0uWxGanTInhIV1txjqRyDT7GhqIq8BipB5nzHnIlc1YHTve0/nes3Uv7UfXoUI4dAI+b1p19WKro/XBSn+9KHH1Gd2v7MqyzIy5152Dys2QpWJT4v1STB64h5EBv/IS0H//T8gfr0jV98KobDgje64Qcq4gGVIo5/ED1kt4QjBeJTJRoVI1KuzuII7q1DBFHU1DCDqXqgRpuRl17/PVvNUINGs4B9hu9zPpMHXln8LPaHq59Bli6QxMuUZyoN6L5OMGCnFk+vKOVWpu7pqC64zoyQafMj769wcj+S2LE8EqxMwaq0+HRlsmkEmuBtyBv7UpOeV3QMLJp1rJ1u3/0TzrOrJjSdyAa7/IRTXkHA7OG9mmy5KAJ0UOgtmtkRchcuaRF+/splg3MCTMm6+r5lGEqK7DT3c6rD2UV2xw50hnfFWnttTsC9zxTvKeSzPkLAdfKIvPgWyW40OF+ihxFMbfiFdUU/IZmG0Dm6NzB3432s2EkRbEm43qv7myOuz4jkbGrCLd220X94UefOOWNl+nNvIeuqBKDFjtChZiJ6/Y1xw3SCuHM8QGTN3tMz4yLyo/F4QZ5ojkmHI4Up/z0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzhoMkp5Y0xCRThmc3lQRFZSRUlURmpGS1BROGkzcGg4QkZTY296NjBmR2Yy?=
 =?utf-8?B?djM5Rk9aNDYxUHd6ZTFyYVJNTHJLRVBWSDV5b2VuVWFaeUpNN05hZmM3ZDJX?=
 =?utf-8?B?SHZWSi80Zlluc0l2L0RDb1l4OEpLSlpQb1BEWUFQaVc3UVpFU1RYYnpTcmla?=
 =?utf-8?B?UEJ3aGFVU2lXVmU3dE1LUmNRTDhQYjNhNXpTZm4yVjI5cW5SSkNqMjhaL1Vi?=
 =?utf-8?B?Skg5S01ITlpVZG1Qa2U1eGxzdCtqbHoyMjVrK3hWTTlhRzRJaWRrZWE2OTcw?=
 =?utf-8?B?MzFaa3NBS1h5YW1SUEEzTGxQZjFYV3Bpa3lNeW1nZW1iVnRmdGc4b25ZSzYz?=
 =?utf-8?B?cUZqcHNpRyt5QjVENHBiTVNDSXV3d1VMT3o1ZXdwNE52dUsxdW9BMDNHT3Jx?=
 =?utf-8?B?b0doRUZsdy9RQlAwckhCNk9KaUQ1eElyaW1SakgwWUkvZDF6MSsrbnhiZHIz?=
 =?utf-8?B?QmYwOEhnVUhlQ0dQRlFRVndqTEVYd1hyQWJwakYzbUU0bWVDbWVpb2JqMDBt?=
 =?utf-8?B?ZFBlalBmS0lhRTNYTDNQN24xR1AzSVlVUUtadHVDMTdZTXk1Zm9BMGdVOXE2?=
 =?utf-8?B?ZmlhTjByVm0xWlJKZU42Ukd0K1h2ci9ocWkyT3FNc244MFNpbFZUR2Q1OHgz?=
 =?utf-8?B?MDl5bFRobVJEeSsyQzF5bE4vQk9wMmVENjMvTUNTSlNsQmZEUlREcm5xcTMy?=
 =?utf-8?B?V0dmSFlvUGFsYWF2ZkdvdTdkY0NsUkRYTUJLZWtOVm1lSy9TMjFWVmVqU3ZT?=
 =?utf-8?B?TWN1WWQrME4wZkN5d21WVHhRbnNDOTBBdWpHOE0zNS94TEFoYm1FZUorOFJ3?=
 =?utf-8?B?VjVyNkxqMVJlQ09pSDRTM0FZalJvMW82b1ErZVl0QXQ5aUgrRG5leEE5WEUr?=
 =?utf-8?B?SS9yL1F6RisrNlBja3JCVVlTQXVOTVQvUmZ1UG9GSG8xZStUek5yTXczN05M?=
 =?utf-8?B?d3N1RnU2ODZ3dFF5bENRSzRUV21rQUthZG1sN0pnTk5lTWwyMkJic285bHVV?=
 =?utf-8?B?aWVOVXNIWXhmN0J1dWlxZlNqUTQ3SytJa0RRaGI1TWdUenlrRXZ1REtSckdN?=
 =?utf-8?B?bnoyZlhLRkZjVDlhT2RYUHJHYldwUCtXRGNBUkxwbDNWRUJHaUE2Z244cFRm?=
 =?utf-8?B?VlpDZHdaR2JNRW9oTXZ1MjJzWE5mcVdLQjBMeUNDdXRCa3E3MjRKR09WQVpD?=
 =?utf-8?B?NVVMK216aFRybHhJamxNU1lkZEc1QWdoSmVEMlQ4TGszNmJRaUZ4VVR2Rmtj?=
 =?utf-8?B?cFFEeWNLR3VPdjhnUzBSSldmeFpFUDhNRDNzenowcjd4ZjI0REZBTExBNUUv?=
 =?utf-8?B?clhpR1VJREtCSjlkd0YzdWVEQ05aTloxVUlQM2trZFpIUytVaGhESlRiY1Za?=
 =?utf-8?B?Y2VQNEN5YVNiQ0NiT0tDSHRmWGR6b0poMXlxME5KMW5RTGhpcEFaZGJrYS9l?=
 =?utf-8?B?dHV4VU1qSzZlMEpOdzg2aVE0T2pIdENNL3N2a05GT3NFajRtSGVNZEdmWG1Y?=
 =?utf-8?B?TEc0RzhZd1FRTDBuamQ1bFg2dk56NHB4L0ZTaHVMbW9acDd1blE1R0lsZzd1?=
 =?utf-8?B?OWRYdll2VGdBWFNkRlZyeWFha0VQbXZLMUFoUTAvbkQzUWE3Qys1L0xsV0tP?=
 =?utf-8?B?UWYyQlFYRGFBbzBIenBpOE12WVJsdG02Wk9xVTVqUG5HbERlcTByTjZGaTln?=
 =?utf-8?B?b1grMGtmV3cwVzk2aWM0bUZFQjBKa0hod0lHUFJlMlZHa3czNlJCcExsa2VO?=
 =?utf-8?B?ME1tTzBPR2p6NDhpWlVHQ3VaUnVEMFhyRzVoK2tVMlNpTHZIdzBEVytBUGJm?=
 =?utf-8?B?a2IvN09TOE0yNEpDb1krWU4wZlZHdk1yTVlCSlRRNUoxajRRZ0lyR2owK1BG?=
 =?utf-8?B?aVZSRWtLd3k3ZGlNcVBQb0VDZWtmQ1UycmhJWDlUMDJsK3hwaTdTY2hEWFk2?=
 =?utf-8?B?aTg3SnJORmd1SzhPNDF4ZWUrMU83ejZnOFpUNzVXdGxFdVRURzUrVjFaUmpL?=
 =?utf-8?B?dlF6ZUIyc0xWRmRobUswNmU5K3RQOTZhM0cwSVFyNW1GcTB0SnhpZmdhSG9D?=
 =?utf-8?B?R0U4T2prd0NsVGcvdnBIVTZldHRiSVBydVFPZnIwaXloZ3FEZ3hSRmI5NlVl?=
 =?utf-8?B?ZnBmckx1SzNFVGZDMEkvK3A5VmJka0F3TWs4eUsrU3V1NXJDaDdEbmNKak1N?=
 =?utf-8?B?eUNOTWpnS3FzdVhtZDB4ZjQ4YmxRWlZIYlpSWlh5bGx2ZTlNVGRGN1gwL0d4?=
 =?utf-8?B?RlhMVDdVQ1dSU2ZVd1lYdlRFRmNKaUdvaDQxaXNnRjR3bnhXS0xIT0toeUdj?=
 =?utf-8?B?ZEt6S2tkeU1yMFBiVkVKRDVMb0lhRUNmdkN1bTdJT3FsNzlEWUdLUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f29e8d-ae45-4423-4f48-08dee74085d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:55:44.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FsRFFnlZFOZdUPJ0k3xRdvZMvYWzJR2n4NmJQJ62fhLaaZx3OzvvpBLEeZI5yErccmz9EjGkTI4y1B/q3HuFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999149

Hi Paul,

On 7/15/2026 5:01 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:42:58PM -0400, Joel Fernandes wrote:
>> The per-CPU clear in __note_gp_changes() (from an earlier commit)
>> runs only when the local CPU notices a normal-GP advance.  When an
>> expedited GP arrives at a CPU whose defer_qs_pending is already
>> PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
>> pending gate.
>>
>> Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
>> This makes it possible for any arming attempt that follows
>> the IPI within the current GP to be able to queue irq_work again,
>> allowing completion expedited GPs quickly than waiting for one scheduler
>> tick.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_exp.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>> index a43469da3926..5be80d255d6a 100644
>> --- a/kernel/rcu/tree_exp.h
>> +++ b/kernel/rcu/tree_exp.h
>> @@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
>>  			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
>>  		return;
>>  
>> +	/*
>> +	 * Clear defer_qs_pending so arming attempts following this IPI
>> +	 * within the current GP can queue irq_work again.
>> +	 */
>> +	rcu_defer_qs_clear(rdp);
> 
> Suppose that there is also a normal grace period pending.  Will clearing
> this cause extra unnecessary activity with respect to that normal
> grace period?  If so, why is that OK?  If not, what prevents it?

There is no unnecessary activity with respect to the normal GP: whatever
this clear allows to be re-armed funnels into
rcu_preempt_deferred_qs_irqrestore(), which reports the normal QS, the
expedited QS and any deboost together. So the enabled activity is shared
work that lets the normal GP end sooner, not work done at its expense.

But also the exp GP IPI could have arrived during an RCU reader and
subsequently needs to do the deferred work. The flag clearing becomes
important then (even if the normal GP previously resulted in the flag
getting set). Patch 4/8 ("rcu: drop redundant defer_qs_pending clear in
irqrestore handler") makes this clear necessary by design: PENDING now
intentionally persists until the next GP-boundary notice, so without
this patch an exp GP arriving mid-window could be reduced to tick
latency.

There is also prevention of pointless clearing from rcu_exp_handler():
we do this only after the "WARN_ON_ONCE(!(expmask & grpmask) ||
cpu_no_qs.b.exp)" early return, so the clear executes only when this CPU
still owes the expedited GP a quiescent state.

Does that answer your question?

thanks,
--
Joel Fernandes




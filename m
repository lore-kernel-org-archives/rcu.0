Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D736215D;
	Wed, 22 Jul 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732398; cv=fail; b=EwfhVoixPBSNc56p8X5KSvrc3PLdHgdqtLlkg60/9tSA5i8F5/bDaSvgwHV7J5VDQYw+bxTyHFhXCWdEZfanP7WB2XOy41gQ/QOPpzudeJItpyO/j79o0obMpOngHplwTC2nin3YUuNbWpVfmmESewFIxBJsgqcUx7oj5RBVLLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732398; c=relaxed/simple;
	bh=pYrrlrLupy1USk0uEDsEvyuNf9UKUpBArbz8WmFThXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mfvd1iI7QuKUkHIjIplmD6BE+mdQ8GWftMdRjWE1+TWcQARIDEbq6lHWxm/dumahVKDUoUtdraIbVggzZDp1Ctga18z5IKmXyv67grOFhw202I4Lyau9Q23L0kZQtbVYbYaRKrcgGVa8T6aFik9QP1NcyDYaDdQUD/u9vqm/UD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KruMIhal; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KruMIhal"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYZbZ6azvAGGafK+40txzUTIgqiQHwlEp0A9xriD/ebbGKXIdHRhxn2i2bHxYJb9gAk/d8WTtZV9WvtiDBfDFSbRMv7z2yIHlF9BaDuiz3Kx0tKDT37F2eSsNgKMBhlrJUDErJbtOBalRVexI+Mfi/hH/etPM4n4lF+31sakbrDIh7N3xoMOl/GVw5jDFRsqxsG0WwCRM6oIWwSER0uilTBFYzLYa8+Puot91bQourziAf+9b17Lv3p8FaMwcGqV8aao1ulq+Kngq5zdw0VqINPk/y378cJcop6oLkY+AIHtR9AlljAQazoFevHJw8rwPWkwq/60tN/LRfqVIVOSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrRv9RYzFW16+oa6ET61jneX18XevQRfsLkOV/e9dUo=;
 b=RL4eZi6yauw75VCq7gMRy6jhrW6zKjV4cxGP6PwwvKASE7w0eCyhbDHQ4YpHkk08+Io3L6wkUqCLg+X4mcnMLJzfgUKAVMzcUZiPaOl6MYZ2B35sRuFasIiwC/nWpW2miZxCicHBFTJytFm+MKT6qApQ+Gwb8fENhL1kJUbxbfh586cLhrr7j4GZe5raF6sE1eBmApCdESkzHBiJPaOJGgCvhsBxH1hbM4QXwyqJI8ZvhZsWiHUyBtsaqrOshh9JRBorlP7C8WavYTW4UJYUd9y4wr86j0zreoR0chsQBk0/85dpiy8Dm1IU8otPLx6hVhyJWK2q/KAiZ+mCDyvd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrRv9RYzFW16+oa6ET61jneX18XevQRfsLkOV/e9dUo=;
 b=KruMIhalupoHigX+yPDtnOAFp8mNaME97R2QWq3baORZErow4I6Td+/Hf4nFmJwRQFhXXUBs2ZnY9frgiJppKFLZ78z1NAwTz2nv0G4u6CywTd4VCAbd8IkeUgkVDTL6Q/w7fQQaq66n0aEetLEjv5VBrjX2JiALEJGKQU4bwOj6NZLoyZHextDgPnePTF6iJFr3yWpsQ0upxY6ly0jKD94GxrZTzGamiuJ7KhOFJzFPYH8guIHSZyf9WD+VsW4gzTfTKJj+Q7d2fj8H3BIytcSmzeTrfAtaUoLEfHXpANFuY1zKp9W/ds/EW+30BQoJT3fMXHC5rC65FAkc1Hz9CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 EAYPR12MB999134.namprd12.prod.outlook.com (2603:10b6:303:2c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:59:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:59:49 +0000
Message-ID: <e44aa40a-5938-46ed-a79c-23ae4fe6ca10@nvidia.com>
Date: Wed, 22 Jul 2026 10:59:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] rcu: add per-CPU rescue hrtimer for deferred-QS
 reporting
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-9-joelagnelf@nvidia.com>
 <57ec870f-e08d-415b-824f-ddefef94417c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <57ec870f-e08d-415b-824f-ddefef94417c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:d4::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|EAYPR12MB999134:EE_
X-MS-Office365-Filtering-Correlation-Id: 197b7878-f1f7-4805-b022-08dee801e02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/8nB1IZasFJ6Y064sHKI84efKL08uabi1zQRkwqWlT11FqVIknYlNDwk4e1nOfdT4WhOYRDmV8bjpiIlSF3bkTUBaiHRnWvYJG7oX7baSXZWjXBBXbHbRHwT+sa3mF6tifBb9DjuhmK26fzQuCgPSzielUG62f+7l56d2YNg5YiozhdGUxxnhb0bORuPlnGK9Pxt7S6VridceFJyNsEx0yD4LP6MPzV76uCoI0xVCcM0jjQmreWVDAo+5YuabXhS1KYmtUw3LnApeQTvezqzRMSesqpJls8+uXPStYEeZ9RfaZBJCueBsl+ipu1q3C+sY1KVeREv/t8IpfdKJVyz5Dk7ibhJos6Un+e9KXZ11xnzDT3jsfqnzdqfZZ15fvh8HJwtkp5FPo+iycZK/vpgKvSXgQY01zHakN/U/zGBvgCch/Jr8qII4p7NhovSlk3XhFBth7r//erV0A6edwRqEg0Q56vTrM0BaVHAJG2ZtjauCzGkpabZqJKM+ZrGIVIvjNO0zb9VrPBfthVZ16ZMxnyxh7VyAUq3YJ97UwFz81jD5HcwoAwH3MV+YB2IY9E6e6y9rayvnP5UlNn/L9kx5/LsyZApyPaNaSMAw1yPuatCyOeGvNtj2087pXguFCJPhQRap/GRmLlMB1peyEdaomPZmqDhUOoHaSjUEcA/Y9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtKTER0NHBWT3puaDFGQ0VwemZOSlV0bVNpaE81Nm5rT2RVbk5Wai9neUI2?=
 =?utf-8?B?QTBCNC94QWphd1pXTGs3OS93S1ZIZ0ZFWUJ5ak84QWxDMy9DRk1XNW4rOWtL?=
 =?utf-8?B?K0xDb3VzUVFpTjltWkFSZXlESWxMbWJPQmludVFpdG01S0hkUmdNWVVxV0p0?=
 =?utf-8?B?WStwUUt5SWdVQzBXSlgyeWhTamZ6MXJqVEhvOVBWNUgwRkZyRnhtMExlbG9j?=
 =?utf-8?B?UW5jWkJPUHdiMHJGYjRjbVR4NGM4a05OTU5xOTdqMXJESlkwb3BnR2l5a1Bs?=
 =?utf-8?B?eStueFFSQkVkNlh2QURTTVR0T1hGaWNWR21ic1JqR01yRnc0YzVKZlM0ZEVJ?=
 =?utf-8?B?N1F3ZlhaZlJldU1BMm5vRXRsNXlQS0hvUTZLVVIrRHladHpTdGRqNFFvajQ4?=
 =?utf-8?B?cVNWb1VJanVGbEFYWlRrY2NTMXd6c1EwY2piMk1LQU5FZE5qWEE0SjdYTG5m?=
 =?utf-8?B?UlllS2YzSkd2QVkzak56MVl4akN3bjM1QWg0Qmh5N0ZKNUZKMmk2aGxWVGto?=
 =?utf-8?B?eVB2bjJIdUhPeFpid2U4MEoyMjZ0b0pNSjk2ZHJrSUZMQVRuK2J3d1ZYMEJz?=
 =?utf-8?B?VTM1MWcxb1VHQ1c5VlVQZlIvVGpMclBLemdCZjdzakd5Q09BQnlraHB0cHhD?=
 =?utf-8?B?QzBFd2g2U05rQk5VemNTby9SRmdBTzFXZzBZY0FRWGwvYndzQzQvWGYyY1ZJ?=
 =?utf-8?B?YWsxWlNYdHlpZXR2UXhXZVdrdmlPSjdYTFF2dlc4SkZHTCtWbDJSTHFNdHRv?=
 =?utf-8?B?SE1KZFl4d01VMWZXRUFlVUEyQzYvRUtFL2dGc1FPYjBSemZsVitkajRrYzdC?=
 =?utf-8?B?Uno4ZW5SckRSWnJKaTFPNHZmck5UckQ0dUhyL0ZycGRoSkUycmhSd0owTjhj?=
 =?utf-8?B?TzNXZk04YkJ6SFJ1YTZoVFkyUm1TeDlRMkVmOFlQdEpuTCtiVzFPNGtrdUZQ?=
 =?utf-8?B?b1p1UGZSV1NXZHJhKzkyOWE2YXlpb3lKSnBiNzd3R0JiY1VBdEhncFVrNjAv?=
 =?utf-8?B?QzlTSjUxSHFHNXI4czNSZXZOVjdvRjd3OWh3YXphek9la2RMd1VKc2x1SXFL?=
 =?utf-8?B?ekhTMXJjTFMwYVh3QUlESVE0TThMOFRXenJLWkYyRW40QS85QVRoTElKL0E4?=
 =?utf-8?B?TG5ndDJUUU4zZ3hUTWE3NVdBZnNaekRRZDFDdnlwVklJMjhYb1VZSzhQY3VV?=
 =?utf-8?B?aXlHUEJLejJlcXhDNUgrdXVFNk92MmZRbHZ3aUt3aXhlU09UTGd4d3d5SHVC?=
 =?utf-8?B?K3NBWnh5SnBUOFc2SFJsK0drNmtSalVGeTlzQ2FDVmdhNUd3OFhEb1lrSDIv?=
 =?utf-8?B?V2F1RlZNb1JzVDhVRDA4ZXVDeUd5b2l6T1R3aGM4bDNKK1g4cXNWbG9ZRzQz?=
 =?utf-8?B?Y0xLMXNXL09UN2NwdkJ6eWpCTEovUVJBaDhlMU1wZDM2SWJBUXJ2OVpRK1hj?=
 =?utf-8?B?RVJDZ2JQbEpINWpGWVVpQ2pvc1U4dnJOUEZUZFJyOWR5VG9BbkRhQSsrU1pt?=
 =?utf-8?B?VTcwV2dEY29GTHV1bUFOU3ptd21Xc25HblFyN0h3b0ovUkdvMSs2SkZBd1Ra?=
 =?utf-8?B?eU9pUXhBalVFN2xlMC93dnlkVkR5Q3lUdWJsWHVpQVZXcU0ydW5xcnIweWdj?=
 =?utf-8?B?ZHZ0NDk3c1NsdFp2YU9RMnF0ajRzeFhJMWVWTWpZYmQ3SVNmVkxjTkkxRVJ6?=
 =?utf-8?B?dU5XSFljT1BxR20yUGFJWlY0RnhZbjF1SkpWN3NKeHdRdnpuNkF6eHhjNWw2?=
 =?utf-8?B?TEdKVldXdXdoTkluaUZoaUYwaUhyRERCZmY5L3M1bURYL2lSeGhhUkRsdWd4?=
 =?utf-8?B?c2pxTmlXaEROOU1iWE01LzRPbE9LREdCSXZzUXN3NFNHenVFK0JSVWV5dnlW?=
 =?utf-8?B?clZpcTJFSUliMEFhZmFPS1pQUjR5dncrYkl2UkV4cFgwTEFNQjBQTnVTSzZl?=
 =?utf-8?B?dmlDclBPd0M2MmFMNUE3OVhKU1V3cjlCTmNyQ0VwcHpjZUgzcXovY043amhN?=
 =?utf-8?B?eTJ5aGY5RGlMd1dNVXpRdkoyYzhBbkVWbWo0dUY3SGdTRmo2OU1sT2Vuak9C?=
 =?utf-8?B?cEsvQU1WZ1U4RkVhZDh5YVUydjZoamNUSVM2ZnlNaGlYRm5TbThrNTlPZGk4?=
 =?utf-8?B?TGdxcXdJNm16T0d6Z2YvWFFJeE5JT0xHakUxVFUvekdoMnRmUkk1YXdnWjgv?=
 =?utf-8?B?aXpybTNmZFN0TVdlSHJjWVRiT2N0RGVuZ04vSk5wU1hJV3ZLSFdtMGtCU1Fp?=
 =?utf-8?B?SnB5dkEzQVJwUzg2VXBWeU9pSitYeUJONXR1R3pFS1dDY1p4S1dlZ0twQVpM?=
 =?utf-8?B?aWtMRXZUS1IxbUh4U1BFbXhmWnV4bnJwbitZNEZ0RFRuQ3dmV3dTUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197b7878-f1f7-4805-b022-08dee801e02f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:59:48.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sefle3zZHPGUjQq3IWpOrC1fycyOgf53Vkb23m7HvqHl5RPQ3YwU07C6xwRSIy6zhJIftaHDkEO7uriDxqCaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999134

Hi Paul,

On 7/15/2026 5:35 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:43:01PM -0400, Joel Fernandes wrote:
>> The compound branch of rcu_read_unlock_special() arms one of the
>> scheduler, RCU_SOFTIRQ (raise_softirq_irqoff()) or irq_work_queue_on()
>> in order to report a deferred quiescent state at a later time.
>>
>> However, that is not enough in scenarios where an interrupts-disabled
>> section spans the preempt_enable() of a preempt-disabled section:
>>
>>  rcu_read_lock();
>>  // receive IPI for expedited GP
>>  preempt_disable();
>>  rcu_read_unlock();    // sets the need-resched flag
>>  local_irq_disable();
>>  preempt_enable();     // cannot reschedule: IRQs are off
>>  local_irq_enable();
>>  // now outside the compound RCU read-side critical section, but the
>>  // expedited GP is still held up
>>
>> Introduce a per-CPU bounded-delay rescue hrtimer, armed from the compound
>> branch when an expedited GP needs this CPU's quiescent state, that reports
>> the deferred QS via rcu_preempt_deferred_qs_try_report() once a clean
>> (non-reader, non-compound) context is reached.
>>
>> To keep the rescue from firing once one of the normal mechanisms has
>> already reported the quiescent state, cancel it from
>> rcu_preempt_deferred_qs_irqrestore() -- the common path through which the
>> deferred QS is reported.  Without this the timer keeps firing (and
>> re-arming) only to find the work already done; cancelling on the natural
>> report path avoids the great majority of those fires (observed as a ~90%
>> reduction in rescue-timer fires under rcutorture TREE03 with
>> rcutorture.gp_exp=1).
> 
> Can this replace some of the complexity in the deferred-quiescent-state
> code paths, for example, the irq-work handler?  (Yes, we will need an
> irq-work handler for immediate deboosting, but that is a separate issue.)

I landed on the same conclusion you mentioned in brackets (immediacy), if
the irq_work gets there first, then we'd want to let it do its job, with
the timer as an escape-hatch for weird compounded cases (irq disabling
wrapping around outer most preempt enabling, etc.).

Also, after this series, the irqwork handler is simple IMO code complexity
wise. Let me know which part felt complex if any.

> Please see below for another question.
> 
[..] (replied below)>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 6f5d31e3f1a3..324d08c7a91a 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -592,6 +592,18 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>  		local_irq_restore(flags);
>>  		return;
>>  	}
>> +
>> +	/*
>> +	 * A natural report path reached the deferred quiescent state before
>> +	 * the bounded-delay rescue hrtimer fired.  Cancel any pending rescue
>> +	 * on this CPU so it does not fire only to find the quiescent state
>> +	 * already reported.  Use hrtimer_try_to_cancel() rather than
>> +	 * hrtimer_cancel(): interrupts are disabled here and the timer is
>> +	 * HARD/PINNED, so a callback that is already running must not be
>> +	 * waited on (in that case this is a harmless no-op).
>> +	 */
>> +	hrtimer_try_to_cancel(&rdp->defer_qs_iw_rescue);
>> +
>>  	t->rcu_read_unlock_special.s = 0;
>>  	if (special.b.need_qs) {
>>  		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
>> @@ -772,6 +784,54 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  		rcu_defer_qs_clear(rdp);
>>  }
>>  
>> +/*
>> + * Bounded-delay rescue timeout for the deferred-QS reporting.
>> + *
>> + * The compound branch of rcu_read_unlock_special() arms either the
>> + * scheduler, RCU_SOFTIRQ (raise_softirq_irqoff) or irq_work_queue_on() in order
>> + * to report a deferred QS at a later time.
>> + *
>> + * However, that is not enough as in scenarios where local_irq_disable()d
>> + * sections span the preempt_enable() call of a preempt-disabled section:
>> + *
>> + *  rcu_read_lock();
>> + *  // receive IPI for exp GP
>> + *  preempt_disable();
>> + *  rcu_read_unlock();    // Set the "need reschedule" flag.
>> + *  local_irq_disable();
>> + *  preempt_enable();     // Cannot reschedule as IRQs are off.
>> + *  local_irq_enable();
>> + *  // Now outside the compound RCU read-side critical section
>> + *  // however, the expedited GP is still held up.
>> + *
>> + * Introduce a rescue timer, firing every 50 micro seconds after the last
>> + * rcu_read_unlock() call, to fix this.
>> + */
>> +static int defer_qs_rescue_delay_us = 50;
>> +module_param(defer_qs_rescue_delay_us, int, 0644);
>> +MODULE_PARM_DESC(defer_qs_rescue_delay_us,
>> +		 "Microseconds before the rescue timer fires a deferred-QS report.");
>> +
>> +static enum hrtimer_restart
>> +rcu_preempt_deferred_qs_rescue(struct hrtimer *hrtp)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	/*
>> +	 * Still inside a reader / compound section: deboosting is unsafe, so
>> +	 * rearm and retry after a bounded delay.  Once clean,
>> +	 * rcu_preempt_deferred_qs_try_report() reports the deferred QS and
>> +	 * releases any boost in the current task's context (or is a no-op if
>> +	 * natural recovery already landed).
>> +	 */
>> +	if (!rcu_preempt_deferred_qs_try_report(current)) {
>> +		hrtimer_forward_now(hrtp,
>> +				    us_to_ktime(defer_qs_rescue_delay_us));
> 
> One way we get here is if we are in an rcu_read_lock()-style RCU read-side
> critical section.  But in that case, we have an rcu_read_unlock() in
> our future, so do we really need to arm the timer now?

If we do that, we run into the issue where outer most rcu_read_unlock() ran
with interrupts enabled, but outermost preempt_enable ran with interrupts
disabled? Like so:

     CPU 0 (task T)                             CPU 1
     --------------                             -----
 1   rcu_read_lock()
 2   preempted in reader
 3                                              rcub boosts
 4   T resumes in reader
     (a rescue armed earlier fires here:
      depth > 0 -> don't restart as you suggest)

 5   preempt_disable();
 6   rcu_read_unlock();
       needs_exp == false: // because outer, IRQs ON
 7   local_irq_disable();
 8   preempt_enable();       // NO schedule
 9   local_irq_enable();

     (T out of reader, still boosted)

We can do your suggestion but changing the condition for hrtimer_start in
rcu_read_unlock_special() to the following, but that could be worse because
now the timer starts more unconditionally.

    if ((needs_exp || t->rcu_blocked_node) && cpu_online(rdp->cpu))
      hrtimer_start(...);

> And before I forget again, thank you very much for digging into this!!!
> 
> This is not a simple situation.  ;-)
> 

It is my pleasure, thanks! ;-)

-Joel


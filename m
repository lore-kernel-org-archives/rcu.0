Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909D46DFF5;
	Tue, 21 Jul 2026 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650706; cv=fail; b=Dvk6hHctuKGS0J7wKbqH/gB8lkYcDwGHtZhyOrrn998lRSpJ/0DaeDY2Bnxi4dxDPejLBiWOzh4N5NccGIGyxZHruxsspA3Ghk8/FkkumfqzRoNJqITrUMcS/+bBGW4kMG0lSomRQUUYpcQgXpeBJaFxMPqI587PnAQqLPd8AfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650706; c=relaxed/simple;
	bh=skXnqfmUxu++uyfplr3eQ8kz6CHzpa/H1n2bNs18y8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K4U7PcoVjYvGLZDGMBbUY2JjYJa4D53ZdnHsslUwFvvJcBozNur+1I/tImsjcbIkIuDFfKg25+CJUkTGulxpiWBMbFS+zCo+SfS2Wqmw/erhxBfqYck6EKonzGAYt4JRjV5jI4ioKKdmQbhtT7nVRkq2WrMPcXUuEBJNZ2cGppI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YaYy+B8X; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YaYy+B8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoVZbSRFpxsBmJqiI9X15kFbhA08g2DXkoqKFkYYVm7o46E3YbjugBdSdQTDaBIFW14h4QcrG0n76qHVYQCPkvG/mAchbcR+IWGA9o/nsZ8fNyfNo/qAk9zweb8fsijMl5x6UOeQ8hFuLiZQEVTEXNN08K89zj8LBI60C2NHYrws+0jv2wDnUtGptgeSGBC4TUpC080sDUIjOznk2cix/drmxaW3wW6JITfo/GrWOdJQeVRcgcaPQokhziC8HVkHEbjKaqAhKxwoFdW+NLPULhzNfQ4i8el9/qFT2+hwyayc2EV0gKh4TpS2RfFT+exd4ymlEthVcPPB7vyHl80HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhVgTUjp7dxXe+A/0dzMdfmqFxM7jhkijiXIhUEEW98=;
 b=hX9RDbjki8iMaQ0mXtZdHI5yTnzTfkWk+SySJGsA+f0NGTvlw5vDxukrniBtCJVzw1jwK8SfEU9CwimuJOx6jKX8VL13pkj1ch96eYijNekmOyMoe/TFNwu8RoYWQnkCchJ/0YF1Clq7pA7AoplC0dFq5vYwyXm6CNZqCbY1hK0XcmeS/Iv+0CWckmNMJzD7F06XJxeOJMsId8B7qvv7yFpSakhNJXv1H/F1MeLC3D+DrLCrtg9TJMUqgIgmu2aCq3NSAONPiYUPdbIkPZ5rJWkQyrQdi35Eh12E8Bmqs6+ASUOgontemyiHLyS6nk8hNq2lim9PLoFuZeNmF6bNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhVgTUjp7dxXe+A/0dzMdfmqFxM7jhkijiXIhUEEW98=;
 b=YaYy+B8XqLUw7fj50YqDA6y6E30EMzx8mg339zPrZ885N+TwcIkU1oxwfMqNS5PbvSd4AMgwZBZCwjPURKEZm3KHNThS27ihgRlBKv4dXHTho1TKTBEG6ImyTYOVlMXUb213jutZVo2zfuQIydbiv0Udu769W2dF3Ion6dSszOg0FXJPlycfhpFF0LZTXUAeNhA+gCyfNMPhzYprCFs3gUjO4Lu9JeiGBHgYUR1eqQ2lwkP/22SVialcgg7eN/N0t1/edlBA7Tdsa5kXpteLIIZJQpv5AHuPRQqjD8xBLq+pvcB1SzXbpp+VI5JNeBZNCHiIRCuQ7I3yK/Dyza5a3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Tue, 21 Jul 2026 16:18:19 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:18:17 +0000
Message-ID: <57d70fe2-5a91-4bc1-81e3-0c44d231e126@nvidia.com>
Date: Tue, 21 Jul 2026 12:18:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] rcu: set need_resched on softirq deferred-QS
 arming path
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-7-joelagnelf@nvidia.com>
 <9c3fa7ae-df21-42ca-84b3-8eaea8684ceb@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <9c3fa7ae-df21-42ca-84b3-8eaea8684ceb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS2PR12MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d844327-dda8-4f8a-d729-08dee743abf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|56012099006|10067099003|18002099003|11063799006|22082099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0RTG4E7hlGXxmGso7zvAaKQokBcWLN1MflBkotgWdV7QA6H/LlGDLdTr4z/k6ztA6dK6JzJSYBbPmdsOU2H8HClkDwqVRg6zxoUR1IgxfxVzr5Kd93d7NUytV9eZA9U5MSsXxDI7BHGEVEe6v3prC4GbLeScDPz5TVmsAg2zIVoUjTCRwD1xSkt7ZRBC3kaxUc13Bf5RfTqvVNNOgPQGjjZVzcsBoGH4LRIRS3rKYEpI0n99XSTrlbk44ckHmogLBEskNc1zAd1qiZW435ELLOqxcDvVeb2shyKSW14fpPG991oYp4zcUjZvrj5GuM2ZMKpqjc+sLn5ioh+er/TIlT8hNdn8NdqfmQlyXNPbcXqbGLGAm9ASLNK+Vct9RgjJJt4OV62Jv/QIYZxH1ejwxW/pQvcGwIVgMSUq7/C9lMnpeysaBSKDyZgzs081fNFITdu66CsdTINs4qYAVVWP/O8WeAMuNb+3J9/7ja/DSHL+1K3Z22Bx1nkItOC2keF57VAF7isg/s3UBT9dkHohUhbIXrjA0TprwR3/eRv0AM/Q6RxiV+OWlZ6h9VjuN2cmHEll576D224ST22fIEl6W/1k8ISruUWlRTxz49RhXkMqbz6c66IU7SbjW9ycfPB7xsQ5+V13wVSKa5wJw6kx38TaeynslPvBc2nA2TM9dis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(10067099003)(18002099003)(11063799006)(22082099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZlSEorN0VVWkdTYTFkY2xzUDRGQWczeGVsdjRFVk03eVhnUlRJem40RWpE?=
 =?utf-8?B?Y2pKK1poNGo4WkJEYXdpbGtIOE92TUlsWGl5MzZiNWZQRWw1WnAxR2JxYno2?=
 =?utf-8?B?cmEyQ3JveW42c1dXU2ZxbkhBb0ZWNVdTMTlFVFl4MDBwYUwwbmhIN2dxK1dR?=
 =?utf-8?B?eGpGTmg0b0VIMjFpSjVMelArQ2gxaFpqUkgraVhjMUxHQVBkZENBbU13enZ5?=
 =?utf-8?B?Nzd2NkF3Q1AxajdGNFhXVlN3K0xtbWVNb1gwcjlmTzQvNTZBQWw1NDZIL2Z1?=
 =?utf-8?B?cHhvMERzeHdqN1l1d3ZNaFNjTjBQUFc1RzlBdkNuZEcwQjZQSjN1Z29rTmtD?=
 =?utf-8?B?QTNUaENFL0JaOG45WTU0Ryt2bVN3SDFJZldPdlBwZWk3SUlPMFBnckRjMTcr?=
 =?utf-8?B?azhqei9FT1J3cjBuNk1xdlhzUDlPb200VERyMWVWOXR3QXpQWkFHNU5ydjFY?=
 =?utf-8?B?MmF1bVl6VlJxWGhncVZ3US9yTGE0MTlmS3pBSXJtWUUyQ0xEMHNWTnpybHUv?=
 =?utf-8?B?SU1EK29GbDlqcW9zQ0Z4VDdqdkpNc3BidE9GRDF1QlE4UHhUdnlWQzFFc2Jy?=
 =?utf-8?B?T3NoMHQ4Umt3Z3hYcmVucnJTRGJnOG1rdXduTlZualJlN041K21LYnRjNEVk?=
 =?utf-8?B?RnRPNU5yd2tTbkF2cS9kR0JvOTBEcWw1L2sxcW4wV051WTQrL3RsMHJMSlVI?=
 =?utf-8?B?TFFoM29taWdCMitla2IwZTB2OEp5Y1Uzem5oM1puWVBBZWx1ZFMwWXB3V2xL?=
 =?utf-8?B?clZNVFl4dmZDSDRmcjFTNVdJbUhZUUtJUDFRQitTYkV3di8zSit3bXlGU2tC?=
 =?utf-8?B?SUs3NzZNbjRMcFpva2tvV0xudExsa3pTeWJqNFgwQ3A0emZQVnV4ZEVNUTlS?=
 =?utf-8?B?dGt3NzIwUnBEQlFZZm5vWkd1THpMdjJ1aG92ajluN1IxRjBhc2k2anNGUXc1?=
 =?utf-8?B?SWNnTTQwVWJxcEJNcjN1bjVLNzlzT1ZoUGFLeDM4YU1nRVdPbUg2OTNNZmlV?=
 =?utf-8?B?aUVLUWdqaTJCd2IrN2p4SUQ4M0NyQWhnS3ZqMU13VVBUODZjMEcvRThySEdK?=
 =?utf-8?B?TzdCcGd2T0I0akJqUWNjdExRWjZodXp3YUJPS0RkVHB2djJNWDhCeUx4ZEZ6?=
 =?utf-8?B?ZkpUYWdkcFN6Y1JXWkk0bjJ3Z0t4TFY1Vnd0TmRQcVZBdlpKZDlmWmFTeEZk?=
 =?utf-8?B?WXV0MUhobkJvOGN2cmN3NjV4emlCeEQ2a0FEUjlhUE8wM1dvYkl5THFheWY3?=
 =?utf-8?B?S3JkdVZpYTNtcHdaY0xhWUl2MWttOXExM09MbUMwT0hiK0pOSkJIN1ZhMk9n?=
 =?utf-8?B?UHB6Ky95NGRkRzZYUGYzMHZGZWZWZGxZUG5lUktNR3c2U1JmQ3ZVU0xibjBt?=
 =?utf-8?B?VC9hYlIxTG9zV1ROY2pvNVMyYkMrbDNzaXlVZWNsYnFyNFZCdWlPZ2NwT1NH?=
 =?utf-8?B?NTFJQW5uSGtVazk3bjkrTklmSjMwYUxlYVNTaGFWVnQwcXJGNVNWNGd1cXFI?=
 =?utf-8?B?Uk82cm15alZHcHRWMTNNRzd6Q0R1ajlxYzljY0pjaHlidWE0L0wwTmRDVXhY?=
 =?utf-8?B?WHpvUFQweVJRaG9BR3dtWjUwWEpoWTZLbTVCMitITG5ub3pTakN4VEdpaE9j?=
 =?utf-8?B?RXppa0ZGWEZxWFVjUlg2amJGZEd1ZjgzK0xmZUtvZWQyOFNSYnlDa3lyTUxa?=
 =?utf-8?B?OS9iUXUxSjNIdG5qbDVIZVk1WWNuamVuMTQzM0hjZFBtNU1qa2dmYlF0RHNv?=
 =?utf-8?B?MkFqMVJKN08yazUrajB6OUZMblE0WGNhZmlNR28rbVNNYWNuMUFDWDdUamVZ?=
 =?utf-8?B?U0ZrRFU1cmd3NFlHUHBmOHZRV2l0QWZ4bVVBSTRTT2padm1rcDN6emdrK0Z0?=
 =?utf-8?B?Ujg0aUNwQ2tpdG9tNDVtYThIUDhpNG9pOE1zOHY5eVg3aGsrWjNleVlYcy93?=
 =?utf-8?B?ck9VaEF1b1RmQVRnVGlWc0RaWWIwYXFLK3FzeHBYNlltc2ZaZ1N2Q2JzSnRX?=
 =?utf-8?B?QmQyQXZ5VFVRSWlqdGJmU3F5b01rWFlrUnpOcDVhYVhmbVNwRHF2eWFhSEln?=
 =?utf-8?B?ZmdqbjEza0pFdzVEcXpjUFNVcGtWaFdsc0p4OVh2TXBqUjlBS2hoZkE2UzRB?=
 =?utf-8?B?ZmM3ZFhpODdQcXR6aWoraTc1bWxQNjZUZitFZ3RlU0xYOFV6S3h2WkVWR3pD?=
 =?utf-8?B?cGNOaGNvd29NWmVITXYwYURJU09GMGFFckQ2QzhtM0thL0hzeU9EdXVTellz?=
 =?utf-8?B?MFhncDRHTWRCYmM1aHM1eTRaRkRVMmRVNDdhdFkrYVkvWWY5YlpLeEtsSW1J?=
 =?utf-8?B?eHM4VzZQU0NIMFlTdnVjeWJ2MVhvNWtYckZOY1ZMblNRRGJESG54QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d844327-dda8-4f8a-d729-08dee743abf3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:18:16.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV6O0kp8sNeNXe8hsBzp2uwRu9GdupkOgqeevPnMsy54Rj5d6CGIs31zNPgAY67OioliQsXFEkb+VOM9BWzc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637



On 7/15/2026 5:12 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:42:59PM -0400, Joel Fernandes wrote:
>> The arming code in rcu_read_unlock_special() has two paths for
>> deferring QS reporting: a softirq raise and an irq_work/set_need_resched
>> combination.
>>
>> The irq_work path always calls set_need_resched_current() before
>> queuing irq_work. The softirq path does not, relying solely on the
>> softirq firing to do the rightthing.
>>
>> This results in a problem as follows:
>>
>> Consider 2 rcu_read_lock/unlock segments:
>>
>>         rcu_read_lock();            // segment 1 starts
>>         // needs_exp becomes true
>>         preempt_disable();
>>         rcu_read_unlock();          // segment 1 ends; IRQs on, preempt
>>                                     // off, needs_exp=true =>
>>                                     //   raise_softirq(RCU_SOFTIRQ);
>>                                     //   arms defer_qs_pending.
>>                                     // Before this fix: no
>>                                     // set_need_resched_current().
>>         local_irq_disable();
>>         preempt_enable();           // softirq pending but IRQs disabled
>>                                     // hold it off.
>>         rcu_read_lock();            // segment 2 starts
>>         local_irq_enable();         // softirq fires: rcu_core runs, but
>>                                     // we are inside a reader (depth>0)
>>                                     // so no QS report; on softirq-exit
>>                                     // preempt-check finds no
>>                                     // need_resched -- still no nudge.
>>         preempt_disable();
>>         rcu_read_unlock();          // arming attempt suppressed
>>                                     // incorrectly: defer_qs_pending
>>                                     // already PENDING.  Without this
>>                                     // fix, no fresh
>>                                     // set_need_resched_current() on
>>                                     // this path either.
>>         preempt_enable();
>>
>> Therefore, add set_need_resched_current() to the softirq deferral path to
>> avoid long latencies in situations where GP needs to end sooner.
> 
> Hmmm...  Doesn't this make some of the prior changes unnecessary?

No, the above nudge and the earlier mechanisms cover different gaps. The nudge
only helps where something promptly acts on need_resched. It is not effective
until the tick under CONFIG_PREEMPT_DYNAMIC=y with preempt=none/voluntary
boot; it is also not effective across the local_irq_disable(); preempt_enable();
local_irq_enable(); Those are the cases the irq_work direct
report (patch 3), the exp-IPI clear (patch 5) and the rescue timer
(patch 8) are there for.  Is there a specific patch you feel this makes
redundant? Any case, it'd be good to have extra guard rails here.

> Also, how often is this giving us unecessary context switches?

AFAICS, only one extra when an expedited GP is waiting on this
CPU, a task needs deboosting, or a special-state unlock happens in
hardirq. In other words, only when RCU is already requiring work from this CPU.

For example, it is wasted only when the softirq managed to report first. I can
add a counter under rcutorture to quantify that fraction if you would like? But
I am doubtful it will show any difference.

> Finally, what exactly does (->defer_qs_pending == DEFER_QS_PENDING)
> mean at this point?

After this series: "this CPU has already spent one softirq/irq_work
queueing since the last clear event; do not queue another." It is
purely a throttle on mechanism queueing, for the recursion safety from
b41642c87716 -- decoupled from whether the QS has been reported, and
decoupled from the need_resched nudge.

You are right that this has drifted from what the comment in tree.h
still says ("An IRQ work was scheduled but not yet run") -- I will
update that comment block in v5 to document the new meaning. Does that work for
you? Also lets rename defer_qs_pending to defer_qs_throttled. That's what it
really is, that was why it was introduced. i.e. to not have to do extra
unnecessary work (for recursion protection).

Thanks.

> 
> 							Thanx, Paul
> 
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index c37d8cfeb714..f58ae29acdef 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -846,6 +846,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>  			// Using softirq, safe to awaken, and either the
>>  			// wakeup is free or there is either an expedited
>>  			// GP in flight or a potential need to deboost.
>> +			set_need_resched_current();
>>  			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
>>  				rdp->defer_qs_pending = DEFER_QS_PENDING;
>>  				raise_softirq_irqoff(RCU_SOFTIRQ);
>> -- 
>> 2.34.1
>>

-- 
Joel Fernandes


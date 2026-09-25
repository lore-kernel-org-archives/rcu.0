Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022090.outbound.protection.outlook.com [40.107.193.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CA3B05B1;
	Fri, 25 Sep 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367497; cv=fail; b=MyGyqhqBOpvLykeCIhPpcAK8KmLqPR0/2HfJkAnFFKRgY76L0kKRj2RnFC8I04AXUc3L+hAuHZ0ABtpDQdw+HBZOLWrY+gjrZfCqHzEPQmC8de7q4EINwnY6AVM7ApRew3zyW8vzlSDvwioZqjfJj0WZh962Tev9OTV0Xk8e8FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367497; c=relaxed/simple;
	bh=yD7cYYz+x27xw7rilUghbTjwp/N2svQASvY26kVM4mQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=leUJnskR5QfucmUGpZhBuIiCzFFNpfiyEuvkhIa0Tj+S17nZLRPIB1maIvKBXo7pie451U7VZPstAq6E/x8sMpboInUTSvFRocYoRDeRzCyCmSvxXulCijWQsybE5tnuldTZbxK8BtBTJKNKJ9FfNSXIppWtU4UYhcuZ3WY7fYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QsyzmHWJ; arc=fail smtp.client-ip=40.107.193.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QsyzmHWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBUIk+ldnMGqYESOr4pYyohqCZhWeTCOY6s5tbWUE3tyoibA0TQ47pf+L1PywoLzC7e6P0KeM/x+ygI4agRYk655zMRmrqh/XIGObR3w3XMATYglYS5kYCWhi04wKubZUWxmgJC9iTO72alQ8CYbDR+OWcPQ0dfHZGaZE0MrU49nEBZreB6MwJoEWF6/0/0QG7LlDEXORCCX3yppWPH+UQTVYSskc+oZdqYCElofgO8D7Tsyc5eBkIRRRtStjD1vf0Apw7YhZruHW5i6pTrjHfFcQNUDPR0Fn15iNOMru7yk1DGogQK12Nd1zvxvDXJIhsDP0hyQGObc9oFfELJDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7SkYhYcWlmgV9QWQV8yp1TR6/8bytzyPC9ysmNa6Ys=;
 b=TqOTbJbs4l2KcZfu24nbSY8/1p/HBY1XhmCjI9VvG/SlICYBhghMUYfCgoN3FssFhjXOl5VY7IRyaJLnsMrCGKapAoVRuZwo/eztJX8q0MsyS0CA2zJQ6vL2BQnx33aYaAu/1jcyvpgrvQxQNJyAFS+s9Lns+S5vLIfrcJqCx7Anu/cghpkBkHIMn+tMuvaESbMh21pr5DfA6GK6NtaqIU6CqndVqk9K3y4US1O1bnFXrrVWC6aH5L7hs/K0b6+pM4B1vQ7Im85T5Z5NXIH/DUl0x2/bLy9JpgIrnzmKx2P6GBmecUYHrLsMEYbAXmOrvtoBeI6BPoQbGpjUAaM5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7SkYhYcWlmgV9QWQV8yp1TR6/8bytzyPC9ysmNa6Ys=;
 b=QsyzmHWJMDx3cTdfJd0mQGFdMvsaXDWnp1YzJXziqnlzz4ZLRTE10fg+XCa7RxBGJQckVPKuTTdpSUkSpj6G+ruNITKBvlMVaudCJW5mNuEnBKc6BJIpv3WmBN4QUAWadzODGGyi0oeYa1Uwrfxfp8KDsUPyfl0hWd5Ie/e0CjYR7Uct1b5X33RzoLcKT8AuA1Sag8coHk+7r4xtws2kYos+obzjrXQeXvrvF01PYyNr5OoOpyWrrh9oLwz/t1s8IYdJk3IXrCop0rAhfexAXLLqqxoT0p8o1ttp+3QsYfseHgvrG58ED/FNId+g9UoXgw9PzfbxE17b7bFkW3X10A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9626.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 20:18:10 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:18:10 +0000
Message-ID: <9bbdc65f-7dda-43d5-98d6-957ba9cd73cc@efficios.com>
Date: Fri, 25 Sep 2026 16:18:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Gary Guo <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, Boqun Feng <boqun@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
 Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Bradley Morgan <brads@mainlining.org>,
 Bradley Morgan <include@grrlz.net>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
 <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
 <DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net>
 <4da27ea8-6f1a-40a6-9be1-8bbd474d8367@efficios.com>
Content-Language: en-US
In-Reply-To: <4da27ea8-6f1a-40a6-9be1-8bbd474d8367@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::18) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b5c3b7-1f98-48f3-840d-08df1b421e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|4143699003|260925021311599003|260925021911599003|260925022911599003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TeGj+rRD+3F71aYS15Capha0+K16+R5dwrdos18JkqENYI6RNim7qS1RyHn6t4CdhSLfeT2DiL74QKfsmHr9MZyfEBnj5IB0MtFFiNsWemhNr5k64FTeh6Ree0gYv3jC9YFmgz+lnCe1dJmXXgOxVfe8GM8sZ5DLhcj39NZqk5JtNu+a8nQ+HvASzLcnApYbwq3Oq/V/sc2VKAl6O9L8RfJnNT+UvHA0T8Y/xsu3/uFyjvldvuzpmpWdwsSt0RKKa35E6VAXHwWfjqwqFqj6ak9zrIoAQzvbh9cC4a41PxyIzk/Eqzv+t5GyI2zpJHJg9FvFGYYrJyA1mMZe2hwLJgpqr2NWoiFrRCZqeZHAIkhu/+zk2DpCIQI/36inIcCBsVX6CYiUtAGuIai72ZjkxisJDNX1UB5FG+sNyr3/4ArCVWv4Ens3m7ujW2lsDjOwWJl72oDQ4eYnnsCwYfEW9QS+kdCFHbEKwVv/aU/oNypipi7yj0dgp1U1Iut53fZCEd2+4plJ8UgFtDfUONDuDcQlSm+I//U2FtaOWZVm2iIvM5jdjrwwCjN3hACFSJuLZ4Y0e+pZMZrb348DNlkwgiVcuAx3oxZ7pZKXqVLkoq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(4143699003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzV6Y09peEtDbnFWOXBxelp3UWJ4K3owUlBQbHVTYSs5d1VQckQ1M1dOak1G?=
 =?utf-8?B?cGdyalVTaU8vM2IzdC85cHhrUzBVOHNsc2VyVXhJaEoxSlhnZFNiOUZjUHQz?=
 =?utf-8?B?NDBsOW1LWDlTOUxRL2dZOGdNbmJSdmVWWHVPM1NhQU9qUGFPVTdUMXBBK1RH?=
 =?utf-8?B?a012N1pLMVNWbGkraGs3NDlQS2N5Slpmd0dkNmswSjllaWZSYk9ia1VINWZo?=
 =?utf-8?B?b1JsL3ErdmtFeVpjejlEQTBFTVdzTlpkUENoaFUzQkNvWWdlMlJ2YjFhclJv?=
 =?utf-8?B?REgxK1BQSzZUU0ZOUGczdi9uNTZ0dDJ4M29jVzczWVROSVZBZkpKdnkvbktn?=
 =?utf-8?B?Zzk4cFVEaEswYmVERDR2U0I5bTl6UjZiOC9YSERVdStyYWJhVzJpZCtDTWdo?=
 =?utf-8?B?WkNOVG1aZTJSdXFvLzhhRFMyWXB6MTRLdzFlYmFEb21aSDQzK1ZBL2tidlBp?=
 =?utf-8?B?Rm02Q2g4d2ZzR0dadlFRU0dReVRDTGNxRFlmQ2Qyd3FDMVR5d1k3RFlRSEd2?=
 =?utf-8?B?L3hMVTJFOFc5OXVzTXczZjZ3MlpYL2Z1b1JlYmQvUXJ4NHdocFdFcEZFMjN3?=
 =?utf-8?B?NWRLMTM2S0lLRXd4Wk4xeUMvZHR5cEVuZk5iaHI1NmFGUG5IQ0k5S2xYY1Y0?=
 =?utf-8?B?RE1nallib1h0MTltenY1T2dLVHNpNkRnaVJ3Y0YzQXExTXUvc3REZ1NDSEhV?=
 =?utf-8?B?MWhDL2NVTmQ1TE1TeTZwdjFHcmExY01OU3RuZ1hualVvK0lTblpoZVF3U0N4?=
 =?utf-8?B?V1pDU3g2MXBIS2VoZzRmU2tYSjdVNG12ZWM3ajY5NTlGYkowNUUzYy9YNHZp?=
 =?utf-8?B?bXcxNUc5cWJoWWgvU0JYYW5DR0FwMy9RUmxQWHBlRFkrUWg0SlNHZCsxVWN6?=
 =?utf-8?B?aERMUzJ5UVFPS3JqTWF6K2VrQVNqODlkOFFKVnRTTkozblUzL0ZVbW95SXp1?=
 =?utf-8?B?M0IreXdnVjU3R1ZscWJZL0tlcldtWmRYK3JRREw1T1N4TldBeXJJUTA2N1o0?=
 =?utf-8?B?d0JXWkFmTk9tUDM3NU40T0ZmaExVMHo3cHRCZjRjTkNuZDRsWHc2enhvMGcw?=
 =?utf-8?B?elZaS2s1NWVON1A1V3dCY3dsTTJOTWpwQk1BTWo1eEZwd1A5ZGpITjlibWtM?=
 =?utf-8?B?QWoyb1d4cU81UEJkVlZ2QW9nSDZ4MGU2UjN4Qno2RjlUR2dZWDZDS2luQVVw?=
 =?utf-8?B?MXdDSUhyWndTWUtRWkZLeG1WcUFSSDhEQXV5UDVQOFpDVHRoSVRRNFBDU2dG?=
 =?utf-8?B?RE1PNmFtZU5EWWVwV2pla0xKNUtiMzNkWkVIcG4zMXlaRzJTWldCKzFYclBB?=
 =?utf-8?B?a0Mxd1hlZC9aRHcvMzk1a1ZjNDg5ZllaTFBKRndQTVFYWXYyWlJVNlBtVGNk?=
 =?utf-8?B?UzJXck0rL1RxU0ZOa0k2RmdkOGNhelJabjZFL2ZJZGZ3K21JcjRzNDk5TXpp?=
 =?utf-8?B?cUM2MW9VdkM5MHZESVRGcUZucE8wN2VoVEJIdmw0U29xWktDWHdjSklZbmxJ?=
 =?utf-8?B?K3ZTMFk5cmQxZXZQMXB0Zk9rZVgrUXN5Y2Y4SkJKd0NOMHIxQ3VSeUxTbVpQ?=
 =?utf-8?B?R3dMdnJoNGU1S2RFT0RLVThvY2pSNzVaazNhSFBCTzMxN25GTGc5Y1d4V2or?=
 =?utf-8?B?RHJlZStnU3NEMm1VSUMxY0l4VXoxNUNULzZUc05vbk94cjIzc2VKa0lzQm1V?=
 =?utf-8?B?Vll4b3J5MVd2VWxxYzdGQU8vU0dGV0tXQjE2NmZlYnFHTDBGU0lRL3Vxd0tm?=
 =?utf-8?B?ZEkxc0VzVVErbUFyOEZheEo4bStVYm00dmQ1YWNweXE0ekl6cHV1bm5nUWJX?=
 =?utf-8?B?OVY2Wndyb3VpQVF6bkRMMm1KcEZydDBaZ3p2OWJPQmQ2Z3d2RTFIQk5Hemk4?=
 =?utf-8?B?K0ZzbE1OOURGQTNkQzB0WTVwMWxYNmVPUXkyeTZiQUFxR2pXckErdDVpWTFw?=
 =?utf-8?B?YU8rcTVFM0tWT09zcjZPMUh6ZGhUK200Ykl5ZllUYTBLTHM4bFgrelE4UmQx?=
 =?utf-8?B?R00wVnNWY0JEWkYzcDlGb0QySFhkcTJ6ZWxFakwxU1N4ZXhsS1AvbTI2WVVx?=
 =?utf-8?B?aVFaYms5NHJlcHFiREpBUVlMSU05eWN4S1hLbnU2NlhLVlRBSlh5amU1bHlY?=
 =?utf-8?B?UUlrdXVBK3U3b0d3ZWtvQUJYTGpkdUhvOUpZK0NJY0REOUJCQUdUNHZVRGJk?=
 =?utf-8?B?bE1oek95VFdkVnYrN3ZCQVlOOExYbDVZL0FLZk5EQVlJSnl1TlZWRGMrTmQx?=
 =?utf-8?B?dmlZRjJVdG5nbU5WeWhMOTJmWFQyY3NRbGwwaUIrSXA0NEZMbVU0a1BnR3Az?=
 =?utf-8?B?NDJobi9zWlhDRWU0Mk1PMDRSa0FyQWRnWElUcWJMSmRpQURTdzRmeWsyZU9D?=
 =?utf-8?Q?KOb9LPEfrTg9aGgo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b5c3b7-1f98-48f3-840d-08df1b421e8a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:18:10.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgIQe2YheH5IquK+RtfdwVd33qFrbwlXLBsrTOpEmRe1Pq1MIXKCVOXDeGEUnTWGdzVseRDItY0Yadg1BSwHMwr0oUVEwnVagi/NhYH60nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9626

On 2026-09-25 15:19, Mathieu Desnoyers wrote:
> On 2026-09-20 11:57, Gary Guo wrote:
>> On Sun Sep 20, 2026 at 4:44 PM BST, Mathieu Desnoyers wrote:
>>> On 2026-09-20 10:46, Gary Guo wrote:
>>>> On Sat Sep 19, 2026 at 1:00 AM BST, Paul E. McKenney wrote:
>>>>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>
>>>>> Implement a two-phase wildcard scan to guarantee forward progress of
>>>>> synchronize_hazptr() even if there is a steady stream of ill-timed
>>>>> readers which populate wildcards into per-CPU slots.
>>>>
>>>> Hmm, I am not sure that I understand the problem here. The per-CPU 
>>>> slot is
>>>> scanned only once per CPU, and patch 1 already introduces flipping 
>>>> of the
>>>> overflow list. What prevents the forward progress?
>>>
>>> A steady stream of readers acquiring and releasing various hazard
>>> pointers happening concurrently with the percpu slots checks, being
>>> unlucky enough that each of the slot is constantly in a "wildcard"
>>> state, thus preventing forward progress of the synchronize, just with
>>> a steady stream of individually time-bound readers.
>>
>> Oh, so the issue is that we cannot progress over a single slot, 
>> because with
>> ill-timing a new iteration of the inner loop of 
>> "smp_cond_load_acquire" could
>> see a new reader while waiting for the slot to be released?
> 
> Correct.
> 
>>
>> So, in essence, the flipping is used to prevent ABA problem on percpu 
>> slots?
> 
> Yes, specifically an ABA which could theoretically prevent forward
> progress of synchronize given a steady flow of hazptr acquire/release.
> 
>>
>>>
>>>>
>>>> I think having a shared global read by all CPUs sounds really 
>>>> undesirable,
>>>> especially that it gets flipped for each hazptr_synchronize -- this 
>>>> means that
>>>> in the pathological case where there are a steady stream of 
>>>> hazptr_synchronize
>>>> calls, each fast-path hazptr_acquire will have a cache miss reading
>>>> hazptr_wildcard.
>>>
>>> There is a straightforward optimization we can do if this happen to
>>> cause performance issues: only do the flip when the synchronize
>>> encounters a wildcard retry delay beyond a specified threshold.
>>> So we ensure synchronize observe the absence of both wildcard
>>> values in each cpu slots, and only flip the current wildcard on retry
>>> delay.
>>
>> Another option would be avoid using WILDCARD if possible. IIRC the 
>> wildcard is
>> used to ensure forward progress on the reader side, so it avoids the 
>> possibility
>> of READ_ONCE(*addr_p) changing before and after protecting.
> 
> Using the wildcard has a few benefits:
> 
> 1) Prevents this retry loop on the read-side.
> 
> 2) Prevents comparison of a loaded pointer value against a re-load of
>     that value, which causes issues with compiler optimizations (I did a
>     ptr_eq() patch in a prior version of the hazard pointer patches to
>     handle this).
> 
> It does have a downside though: given a very long preemption by a host
> VM, the guest VM could technically keep a wildcard present for a long
> time in a per-cpu slot, which would prevent hazptr synchronize from
> progressing for a long time in the guest VM kernel.
> 
>>
>> One option would be to first use the typical hazard pointer impl that 
>> read the
>> pointer twice, and when that fails, use the wildcard protection. This 
>> would mean
>> that in the common case where the hazptr_acquire does not race with a 
>> pointer
>> update, the WILDCARD protection is not used at all.
> 
> So your idea is to use the hazptr load+reload approach (with ptr_eq()
> check preventing the compiler from removing the dependency on the
> second load), but rather than retry, fallback to the two-phases
> wildcard. This way, we get the best of both worlds: guaranteed
> progress for the read-side (with the wildcard fallback), and typically
> we are immune to long-host-VM preemption delays, because the
> wildcard fallback would almost never fire.
> 
> I like it. What do you guys think ?
> 
Something like this lightly compile tested patch on top of my prior
[PATCH v1] hazptr: Fix two-phase hazptr_synchronize race with detach
?

It also depends on my ptr_eq() patch sent in an earlier hazard pointer
series.

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d1670121947a..8a005a1125f1 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -233,7 +233,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
  	struct hazptr_percpu_slots *percpu_slots;
  	struct hazptr_slot_item *slot_item;
  	struct hazptr_slot *slot;
-	void *addr;
+	void *early_addr, *addr;
  
  	guard(preempt)();
  	percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
@@ -247,22 +247,38 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
  #endif
  	if (unlikely(slot->addr))
  		return __hazptr_acquire(ctx, addr_p);
-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
  
+	early_addr = READ_ONCE(*addr_p);	/* Early load. */
+	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
  	/* Memory ordering: Store B before Load A. */
  	smp_mb();
-
-	/*
-	 * Load @addr_p after storing wildcard to the hazard pointer slot.
-	 */
-	addr = READ_ONCE(*addr_p);	/* Load A */
-
+	addr = READ_ONCE(*addr_p);		/* Load A */
  	/*
-	 * We don't care about ordering of Store C. It will simply
-	 * replace the wildcard by a more specific address. If addr is
-	 * NULL, we simply store NULL into the slot.
+	 * Validate that address did not change between Initial
+	 * load and Load A. Use ptr_eq() to make sure that result from
+	 * Load A is returned to preserve address dependency.
  	 */
-	WRITE_ONCE(slot->addr, addr);	/* Store C */
+	if (unlikely(!ptr_eq(addr, early_addr))) {
+		/*
+		 * Address don't match. Use a wildcard rather than a
+		 * retry loop to guarantee reader forward progress.
+		 */
+		WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
+
+		/* Memory ordering: Store B before Load A. */
+		smp_mb();
+
+		/*
+		 * Load @addr_p after storing wildcard to the hazard pointer slot.
+		 */
+		addr = READ_ONCE(*addr_p);	/* Load A */
+		/*
+		 * We don't care about ordering of Store C. It will simply
+		 * replace the wildcard by a more specific address. If addr is
+		 * NULL, we simply store NULL into the slot.
+		 */
+		WRITE_ONCE(slot->addr, addr);	/* Store C */
+	}
  	slot_item->ctx.ctx = ctx;
  	ctx->slot = slot;
  	return addr;
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 13faa5ba7677..8c4fe0a45304 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -97,7 +97,7 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
  void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
  {
  	struct hazptr_slot *slot = hazptr_get_free_percpu_slot(ctx);
-	void *addr;
+	void *early_addr, *addr;
  
  	/*
  	 * If all the per-CPU slots are already in use, fallback
@@ -105,22 +105,38 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
  	 */
  	if (unlikely(!slot))
  		slot = hazptr_chain_backup_slot(ctx);
-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
  
+	early_addr = READ_ONCE(*addr_p);	/* Early load. */
+	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
  	/* Memory ordering: Store B before Load A. */
  	smp_mb();
-
+	addr = READ_ONCE(*addr_p);		/* Load A */
  	/*
-	 * Load @addr_p after storing wildcard to the hazard pointer slot.
+	 * Validate that address did not change between Initial
+	 * load and Load A. Use ptr_eq() to make sure that result from
+	 * Load A is returned to preserve address dependency.
  	 */
-	addr = READ_ONCE(*addr_p);	/* Load A */
+	if (unlikely(!ptr_eq(addr, early_addr))) {
+		/*
+		 * Address don't match. Use a wildcard rather than a
+		 * retry loop to guarantee reader forward progress.
+		 */
+		WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
  
-	/*
-	 * We don't care about ordering of Store C. It will simply
-	 * replace the wildcard by a more specific address. If addr is
-	 * NULL, we simply store NULL into the slot.
-	 */
-	WRITE_ONCE(slot->addr, addr);	/* Store C */
+		/* Memory ordering: Store B before Load A. */
+		smp_mb();
+
+		/*
+		 * Load @addr_p after storing wildcard to the hazard pointer slot.
+		 */
+		addr = READ_ONCE(*addr_p);	/* Load A */
+		/*
+		 * We don't care about ordering of Store C. It will simply
+		 * replace the wildcard by a more specific address. If addr is
+		 * NULL, we simply store NULL into the slot.
+		 */
+		WRITE_ONCE(slot->addr, addr);	/* Store C */
+	}
  	ctx->slot = slot;
  	if (!addr && hazptr_slot_is_backup(ctx, slot))
  		hazptr_unchain_backup_slot(ctx);


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021083.outbound.protection.outlook.com [40.107.192.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86B3E6DE7;
	Sun, 20 Sep 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919070; cv=fail; b=brzYDSGkxDFduwGzlHPN8wrr1BTfuP86tUJdgjnUGbTZMO6H7LWPtNyPhateREnZW9hjBDRBpIZEeEvcq/aEt3rtgxUyXH+ua3cOE0J5Nh+6H6mb1HeNxRD73M3OOGMvMZFA8kRYsybIg86AjDQknNeOe7xpl1jn6a0zzXc0vaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919070; c=relaxed/simple;
	bh=CGA7C/ReyLtWz0WW+9bgkWrf7a4OM6Kf1reCDIsM3aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hOoMuB6way/QFSvr0j6+SBOsU9oDOh/XDHJT72vo/G9W+6VhUS4eHwlU7TWD3X713F+pZeClC4I6PM1QgQTHNNmLzVgBEp9TtoXyuLQ7rStLkhmJwvumg0/tkxMU1UvDBI8DeJXhSdR8Nri81pJuFfXgcl+MzG7U5DH4O8T5xbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mBldj1wY; arc=fail smtp.client-ip=40.107.192.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mBldj1wY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEJziD1XuW1pDE0xE+DoC+UDfbm80fS4IcAjn6t5VWha8B2rUyIvc7XDbC6qP+R7RIZdDllotQgPyZxUjPEUoTc35vVpEJncROiJ275gHQc1PkJ1vo/yl0DtC3KciS1oJjX0B6aETClwrxDz4+IKGDt4/zS7FaTnVCpCAWdW4tDQlY1PwQS8FmPXvtDLyMSZw4Mfk7dzhjb8V5K/R4hpi2QjAx56aG51j6KGQ9rH4ZAkIqpMjytefsyK9g26krWBwZJnPt/DxbJiT97aSldM1jz8/gnt2AJ3RdY/1h4/95/uvhClwufXQSfU4k1CmnWXEDIuK2pRgEr0QmCz0krMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcyaibZEX5lwgq9vO141ibnFruaeYL2y1tvI0VSQ0dc=;
 b=Cq6TA3jP8K9uMrRVw1KlzfpGFNCljJ/42eJSwvEyP/OKSQGCxzS08LeWJqJSZG1XfS+pztTGUT/svGgRua0V7jMeUJPW5gPbLIYqEdhB/3Em44fIGW7894r8B5C2fzozSUkKX/L45Ipqojf64bRfiXa5DtY4f4muO6miO2ng8M9EJuAjWS59W8byl6cSctYZ3n2Z1akrRKNcx21sFHQ/5YRvJ6X8qDvA8I2goYz85jodLBfdbE5LAVBDrC2+cKP6EXfQPGUHqSqWZ26XrxI+80Q5t5WloiT5eTff254ATpV0yaVwQLf/Dnnu/NDTL9cByTVyD70kyzo+PStvxJmP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcyaibZEX5lwgq9vO141ibnFruaeYL2y1tvI0VSQ0dc=;
 b=mBldj1wYhe9z02yPwn2Izc9A/0ASC84lYgbFN1Sih3X+xHFS3bKsZO/sVJhtSPMhgdn4/KbR1CMo+Wu/pYnKaiIroSmirg5MH3FV+oL6QcZe+wgW40NhJIlyeamLSomTYiymiuyYWLG2vJSFYyn3u7mF8bgiUbdZpKo7FiWYihpWtdqw/Sbdgq9sRf3rDGVUj++O5ebK+R0u1Q4PwzXcNqKbRz5H/LYIqhc23vZd5ft2CdQr8nbEw5Gp0Csjj61jUxG67JtZqj+B59b5+/Hi8UnKue2sjh4dhEY/BVfEGokTdgSfsSvMNCzq+OH4l2I/JSN/BeOF9W9ITqwKzR9kyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by QB1PPFBF71136B4.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::289) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:44:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 15:44:21 +0000
Message-ID: <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
Date: Sun, 20 Sep 2026 11:44:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|QB1PPFBF71136B4:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7887ea-7326-4c72-6160-08df172e0a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Rf8J8TfN941KFniI5MCEHknHBEOXtnlJ8ujkZMpOECyQmrh7X4WT6tYrLoYAx2zgGDE3+Yi9a2fyr+j9BwrIEdWvvvEMUtTeJVlnVHqiqRJMjC4JKbAcEN3tIzmvL/em/ncdEhnqLCAvl5dolRnPN39L6CiG20l2sicQLlXB75j+0/GOwKKQE4DR5HWsaufJGAK+oqbqpUDBXgg7p1RXoGNvFxK1AoQzo2G9cD55oaoCNSl/wrNaMQTi4LWrRIeqNp3qoOLmnujPaMG1mhaLLlZxRFzAIEbQHcerMt7HGXOA6nfVoSUtAn2F3ABfJjxSr0TrB//HLGem61xcVX5oPMa7hN0JIsZzM/6gW3pP6/yhAs5V08aTnvhJ2tTqf2MAEKwCrd/C0cwLzi4geEdd828xj6ETXWPErdLgPj1nzmmOuNFZ4EJUH6DutB5ET5+urfT5IwTAZiw5PSxhLipVuAY/8pOmdQRPJmj2zchmdYLPRhoeCi/y25HfPWMXJJ4Q2zUQrYngkmIXf8BZ+3aabumKNtgjkE6sZ0p7+HUBpTMkAwsi82d5zs+ODgovh2ZSFOEYtT1Z8z0IRWXaOt4Y55N/9r8swU1y1BPNdVze/ZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZRYUsrenRPa1hZdGJ3WUJLQ2xnVmdaVkFrM3RVTkVyWEdPUUFWT1E1ZlZh?=
 =?utf-8?B?RURDQVNBYS9iSW1IYXNqc1NDcHc4cDNnU1JvQysvZlJwQnA5cjJRYzBnTjBG?=
 =?utf-8?B?cUd2aXZPUy9jS1U0d0NoRGkyT3AvaGUvYUhCcmlNVmJEdDBkUVQzcmFhQndC?=
 =?utf-8?B?Y1hoRE5LdWZmMC9EUVdoeFVrc2lWRTczenNXemhBMzZQL2lwNkdZa0xHS1k2?=
 =?utf-8?B?bVcyOEpkZHBkQkJOL1hZQndNc0E3aTFqeEk0c1MvbXVvUURSSzJwa2tQY2Fh?=
 =?utf-8?B?YTFBWHFGWnYzMGxFZXRPaEpocC9CTHlwNjg3UXRpNWJKc3BBcy9lOXBIVkd5?=
 =?utf-8?B?V1Y2RXQ1WkEzMHdVRFhCVlYzVWI2YjB0QlZhRW5PeHg4SXludXNraCtnZitw?=
 =?utf-8?B?RU9PeDBOL0ZnN0wyalc1T2RFQ2NOYlR2ZHJoZWVXS3g1K2M4Wi9jUnpud0Q3?=
 =?utf-8?B?M1ZwSFIvVGNwcnQ1eGhnNVByWnRhNVR2SThsTzU5NDJ6NkxON3dad1l4cElR?=
 =?utf-8?B?UjVVYUJXOE11Y3Y3QUROTk5jVGZLRXhZQVAzQjV0bkwxWXJteitqRFlXNXNL?=
 =?utf-8?B?UHU5K2dZT1VHcVBGUUtwZGtQd0RQaDkxZ251a2tTeU5lT0dxWHdQeTc1c0lY?=
 =?utf-8?B?a25sSW1OYTVUYzg1d21WR1F1K1dIZmFFSjNlam5NWXA0TWttUGpuSFNBc0dO?=
 =?utf-8?B?dHd2UHdJZ1NjUXpIWDdzdmhLV29kVHNvcmlnM2grNFc0Kytrekp5SVZacE5I?=
 =?utf-8?B?U0E1WGhMV2VsRUhsb1lGVERxdHBoRE02L0ZHb1crc2xSaFNNYnVlcWpsQ0V4?=
 =?utf-8?B?ZVJjTjZBc3RabU9DdHVGdUM4QlpBVWxub00zRVJYWU9iTjA3ZC9WV1haU3ZH?=
 =?utf-8?B?cExIeDhRU2orMnVjSXZPVEludkRpbko5eDIyTmpOdTl6NHhCL1JYMVMxYld1?=
 =?utf-8?B?ajUvMkNCajVFSmpYL25rL0YwcWVCOGpiNkRsWTZFZkdqOWdYMzlUMk00bC8r?=
 =?utf-8?B?STN1dGtVRjF3bkJ2ekJaMnlXaFpPSyszckFFZXJwY0JFcGFiRjFZcXB2MmZp?=
 =?utf-8?B?eitQMkw3cmY4b1daYnUvNWZBbVg1ODgyTmdIU3NuZWhUMXdhRndYM1NYOFpH?=
 =?utf-8?B?elpmUWQwTHp1YThNNFZuazNjTFlxWngrdHFhRHV2Szl2WDg1enVmNW1wbHR1?=
 =?utf-8?B?eENBUVUvTUxySU5ITTQzRnlScnNlUW1OUjFHeThhTHJObGk1Nm1TTkZ6VjYx?=
 =?utf-8?B?SytDS3hpempEYVNvemROeU9leEczc2lvQURJb2MxVm9LK2IwK2c4Q0Z4Vmc0?=
 =?utf-8?B?UHlTSjVCaml1ZG9rWlQxZldZZlZENm5KSTVkUHpnMjZlemxQT0FMem1qSDdX?=
 =?utf-8?B?dFZaOUhoNGwrTGJDWFdhRnh1eitnRXVDemxuYmlXOW1HNmlQb2lnZTlHY0FU?=
 =?utf-8?B?a1V0OGx5WU83bU9PZ1JZVExCWFJyK3lYcFRxOG9rRTJKVFNROXc4Y3V2UzVG?=
 =?utf-8?B?TmhMQmxoN1Bab3F5ZWpTVEhQSUhoY2ZIVU5LYWRsT0pqWi9Icy9pMEErRFVj?=
 =?utf-8?B?ZHlOZk8yOWRwcUdUY3phR1hHM1FlazhSS2RqckFqdVZRbDRCQWV6eEpRbGJG?=
 =?utf-8?B?b2VtRm1Wakg0cHR4Y1JHZVF2T0xrZmtDK3piem5zMlJsRzVlczRpZVJ5NWIw?=
 =?utf-8?B?OG41bkJPa2dYdnJmMks3dkZsbTZYVzYxWXRFQ3pyQkpPTmYwRUJRYlltUS9t?=
 =?utf-8?B?Qjh1SmRUbm1QL3dhUHhyTDAveWNVR28xZmk2cEVRS08yRHhRT0VrR0l4aXZk?=
 =?utf-8?B?dFF3eWdSNXFiT29HOUwzYXE4TWkxTFVlQ0dYYkUrWkRwSlFyVHhPQ0tpdDBh?=
 =?utf-8?B?RW51SmQxM1JmU2htR1R4SENHeGx2Wkp0Z0xEQ1MzYXlENlFrRlo1bjZZamQz?=
 =?utf-8?B?QW9iK0xDd1hMUFUzZ0NEK0NDVWdZNVVqYndqY3lZSHo3NFNZZ0NJQ1YzSTZL?=
 =?utf-8?B?N3NEU2plSkxrZlZiMndEZjFzVmNRQ0wxYWdYQ2FaZ0wvODJkbUw4c3ppTEJC?=
 =?utf-8?B?YkVaYVhLWDJRV2EzNnFieitxZmFMZUd2ckpaTWJUVEZvRjZtUkI5YlZ2aHlw?=
 =?utf-8?B?alhVUWwwY09kVGNjZjZ1THc0RytSR2VOTExKazN4cjNZS0l4aVB4cGp1WXlF?=
 =?utf-8?B?WlJIOFBLOVVteDd1eTY3bDZiV1M0dFF5UjNxTVpEZGUxMHNjSThXNlp2SFdq?=
 =?utf-8?B?S1o5Yklpd0NjTDVIUGpqMHQ4VVVVNHVOTmxzZFdVVnFyWEwxazN1NlJVeFJp?=
 =?utf-8?B?SHFBSlpWVk9vQytySmhtd2ZUcklGdDhlaU1DWVR3QjM1Y0xjZThyMzNCTmpQ?=
 =?utf-8?Q?/SzCTNhUSUj0Kbz4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7887ea-7326-4c72-6160-08df172e0a42
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:44:21.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7jv7wkZ/2SCtjAG2yL8h1pfHZif/+sm3GFbiqDTzN+X4nuWU4Dx5t3swcVLNHCQ9RuqOE69QtMUrHKypaWPKlB+7YkBJUW7EMW65Qo4/ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFBF71136B4

On 2026-09-20 10:46, Gary Guo wrote:
> On Sat Sep 19, 2026 at 1:00 AM BST, Paul E. McKenney wrote:
>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> Implement a two-phase wildcard scan to guarantee forward progress of
>> synchronize_hazptr() even if there is a steady stream of ill-timed
>> readers which populate wildcards into per-CPU slots.
> 
> Hmm, I am not sure that I understand the problem here. The per-CPU slot is
> scanned only once per CPU, and patch 1 already introduces flipping of the
> overflow list. What prevents the forward progress?

A steady stream of readers acquiring and releasing various hazard
pointers happening concurrently with the percpu slots checks, being
unlucky enough that each of the slot is constantly in a "wildcard"
state, thus preventing forward progress of the synchronize, just with
a steady stream of individually time-bound readers.

> 
> I think having a shared global read by all CPUs sounds really undesirable,
> especially that it gets flipped for each hazptr_synchronize -- this means that
> in the pathological case where there are a steady stream of hazptr_synchronize
> calls, each fast-path hazptr_acquire will have a cache miss reading
> hazptr_wildcard.

There is a straightforward optimization we can do if this happen to
cause performance issues: only do the flip when the synchronize
encounters a wildcard retry delay beyond a specified threshold.
So we ensure synchronize observe the absence of both wildcard
values in each cpu slots, and only flip the current wildcard on retry
delay.

This would prevent the common "frequent" synchronize case you
mention from causing cache misses on the read-side.

But I preferred to keep it simple and wait until we hit this
level of synchronize call throughput until adding that extra
complexity.

Thanks,

Mathieu

> 
> Best,
> Gary
> 
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
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

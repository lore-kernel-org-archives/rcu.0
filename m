Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021099.outbound.protection.outlook.com [40.107.192.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435622F767;
	Sat, 19 Sep 2026 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837763; cv=fail; b=dfyV2MCpS5cNnpBpoIYyH3zD3J4IdDkmjZoqDgBhe552/rv3nk6EyKfwpBrxzPlMSBAe/diVv6jMM2HTxPfPkJm5J5dd0ILHAkVA1j80lcbqrdKBYzB20ZD9buGDnVlq6rKyDVsBcBVHrUCuxtt/pnPiwUFWGf1oN3KKPD/c/MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837763; c=relaxed/simple;
	bh=+TrNebl4e814NZUeRRDUrK5MTkkkoSCZ72y7JpTeAQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIkcP1J3UvxUv6tAcasG3U1CZDNThyO1hK4mGzGONAqqh3nadfBENb6BsmlyUjZ71AcQ9ubkJYhkBpdaq4x8an7mp50oCmy+LJxYPL7ayIPaFMc7ww9G10mK/7ba/O7dfswzE+6QyNItd2jWlMq3958jLSXqAzBuxOR/KVZg1gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HmYTbPF3; arc=fail smtp.client-ip=40.107.192.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HmYTbPF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xtg6uoY1IGKsgYjXbAWOZnvx8HczVA4kzbbczCRroIIPtPGFTl8HhmnS4kPpNtg13vwEvtrXB6ZEymuQCHMeyLvJ/hl3LOd9T/zELmRGREkGZ9+9T/Q4pedfpyGL737V36tglPFsIQMe8YpjCEG3d/rBfIXK1nFYpZE4CoY2v0tUUb+mXPrqo1kTEvz71pR0tKSpJkYUsq+WyXCgkzijruoTjqP7qrylVTCb1PV5INx8ohJvzZyO976RVpx7a1XB9IObAv4hqkO24sWEdXSQiZSmXJU3pOXMAkZ2UN5gmoCMlMeSUFTsyOueJ1n5Jwe3cy4mooUYd+jjXBX5IKFtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyrJjfD0MFLSHkXRljLFQDy1aeMnploAGEOY/W11zLw=;
 b=efv53u43/kmji/aDrs+2Iywbk8hUp9RwOj0u4x5A6PxalaLvDCiAGHSKcpmDi3C2QHtMAdS5/e/hOlOGWfkCgxaPDaZH4JHED2t0gLF5C7s1bHxd6nmePZbCjAWbVXcNF2aF0xKczFOL9K3gQ862olepHnQDnGMHhwhIbf91OEVulHNyjPgAjs7ryO794hTyoVGJSuNDlFIboMRPIK/+Uuc7NSEWgUv0tVTPQSVbQXpFE0jXWPg0Oa6IpK0HwfWjR/H2U9g1De2cupJ0dc2oqXwRpXOG/3ocCCTrfU+bVpjEuV1ggC9bm5EMLbGAbcDlhpWIvdpBU4v4IsFlMFj9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyrJjfD0MFLSHkXRljLFQDy1aeMnploAGEOY/W11zLw=;
 b=HmYTbPF3z0mcVYvqPNGTnTrFx8CvRRhwwxR8BL6tNHop4MmrWRoR5OV9Y3DL7W4LoPvm7JlppiuGV0rN17u2f9IoXqYDiFGHGgbhMuYjChynvEwLk2vmz4dfOppqFDuTFBW1V6JYZ3oy0tD5Mq4GF1vjtQ/8jWYboI4Sjh7c9slIYDQ63bdSYuVVGS11gFi0c7JB9vWnlUk41teYCd/g5xyOWr9GyJ3icOAmb7BIqn0N+wln46w31eB/Etvsi2gVevA/qq95jRC+QDfpMeyJwcCy9q1xsKoPc4iQuav+ikcJ8zTewi5AsshJwln2zf74NMwYvakXNBV+WETMCaJFDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB324718.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 17:09:18 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 17:09:18 +0000
Message-ID: <e6177659-ee74-4dad-8fb8-ac2a755c5c1f@efficios.com>
Date: Sat, 19 Sep 2026 13:09:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] hazptr: Implement Hazard Pointers
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>,
 Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-mm@kvack.org
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-1-paulmck@kernel.org>
 <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com>
 <6B1FC39D-6EB0-433A-8E49-E5EFC9379AD7@mainlining.org>
 <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB324718:EE_
X-MS-Office365-Filtering-Correlation-Id: c841ca50-54df-48f8-5fd8-08df1670bd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|23010399003|4143699003|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z1easvdAkLxjYM8sKQYwy3eFrFcaL39auH92YqabfV3lQSA0iMdVE5PtlwOaOMMkJAO2f6lo6N7dLVxLlWs6fBi9FM5Qw1yofJAz3POibzHGtAMWjYPw9868tkM0I9dkxbPi7gEjCsZXTj44a13omgM1v1e2arbCcGZiGFSrM3Sb1wHQj/rTG+a1FZY3kup56MBrThxo8FOG1CKQiiCuGn4SzoYQ4FjDUWYThkDbetuEtaPAJPjnmczxP9ITG7bmCHMkZ/7Q9fLAIQwgSV/j/0KZZdBWJgHSkq8pmt9yvKn3P1AqGkGVKnBLBAGk2GcAxBUW6UYUPNR0X6S2Kka8Ar41Y7HFonXkFoX5BirjLlfE+KhyWHlFq9o1VfI+UwIIsKDQXbgdcYH7z9MdnhK4dHosNF+ivAiJy1RYqQsiX1HQX+NgcQIH7MVjUnbRVLXmfpe5OmSIa9aRJuBc5ZY5Xz8UimyjzL70c7P4kcO0jq15qfeTDaKMOBXAupt8rgGLQ/aX3+J1PX5jMt5Os1JdR+npeNvqcePBHerJY+HbON51j7TmqnPjh7lm8R8LirWIpVsDOecY4lDzJ6Jn3IHkAE4GtKV5kbaYC9Fa2Vx5+FQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNIaEVBeTBwNHo5MEI2TE5najhER0pYZ3o5OTRQRGY2L3AveEZqbEFBTUt3?=
 =?utf-8?B?YWNLazU4VGIzaG1KNTdDdk9vQlFSYWlhZklFMlllQzNtL1Y5NFRGQVk0VHc0?=
 =?utf-8?B?SVc3Mlp0U1BQOFRSN1lCRXdkaFNPenFvV1BEMUlWaHRQNFM2a3NGbVpmeU8x?=
 =?utf-8?B?YysyVExSOTFqVy9kY1hVakkxV2cwTEdpSGgyM0VpenVSLy9RV1dPbzMwSlYr?=
 =?utf-8?B?TmlNcm5FMTFTUDZta1BZTmxhMFlQcFo4ZzdvejZtK0JmeTVZNWNkcW9mNHhi?=
 =?utf-8?B?VFhtSVk1TzJIUEMzK09QaXN3UklicnFoN3NYclZuYmhHSWQxVDdvZkEwMjNo?=
 =?utf-8?B?RkNuRG1QM3MvdTI1eUNOL1VhVU9PM2xpclFpVCs3SFhlc3hEeTBVOWRkQlZM?=
 =?utf-8?B?QkZkdVpTL0tUNzQyclFMWVgrNzdiN0Z6M3kwelRJK1JlejNJRlVNNlcwbTBQ?=
 =?utf-8?B?Zk1pVWF5THYyeGc1V0JUcTdvb0xMemNidThabVZoVzF2aVB5WVMzNCs1WkFi?=
 =?utf-8?B?dzNZQ0JnZmpWckxyUFNvQ0JSL0FFRnhWM2tlOW1DeWVBSDVLQ3RYRUxEMWtH?=
 =?utf-8?B?b2tLVldMMTJtYit0NmFXenpFTUxFNTY0QkJMS3lweS9tcXl0Tkcvc0pabW5D?=
 =?utf-8?B?K0d0S3hIblJ3d0hmQTh1VXVlU3h2KzVhWnE1NmZVMEp1OVNYbzV0NHVRWmRu?=
 =?utf-8?B?MzdRRTduY3VGZUZGay9nRW54d1F5d1B4S1VXTkU0d0xyVkovTk0zVVAyUHMw?=
 =?utf-8?B?bnQydUtHMEExdmpVSGZHdjVXelFrb0VmOUU4cUZzaTMvMzA5K1lPQjdwR2k3?=
 =?utf-8?B?VXFEbmhGMFk0UkxMeEZJM1ZESVlqMHYzTGRRdmNBYVI4dExrZ3ZJNHRKZzFP?=
 =?utf-8?B?MTVKU0IydWhjSTlJMTFOVTYvSlllNVBOYStTSjhqWXl4SEsxL2NiQnMybDdq?=
 =?utf-8?B?SS84WDl6NzE1bFZOampTVGh6OXAvdjY1TEhvQTIva0xPcURYS214RU5yL1JE?=
 =?utf-8?B?c05YY0dXZU5uTjRVMFE3cTNhaEVTTVE2MjhqM1gzRUd0Y242emc2TWIzNkhw?=
 =?utf-8?B?WWFlUlo3NDhOTldlZndwOU01bTRuc1o4OGpSNlR6Q0JwT2tiZGZMUWJwTlNl?=
 =?utf-8?B?OUVucWVmdnhVUzc3dW0rUFcvVndzQjNib1U0R1Nxc3FmTXRIaXVmYWFxSEtG?=
 =?utf-8?B?bnB6ck9vWTlyTitFcS9vRjJQTjBreVBZSU9hMWxpcXlTOVFjNmsrTjd4Zmhw?=
 =?utf-8?B?Vk9pMkdBaWNlK1JmS0NXc2x6eFlMU0VmcnZJL1hHSTZ5Q1Z1Tk1rYUNHakdK?=
 =?utf-8?B?Qm1DZ1JhT1NhbGxQNldES1hBbm9zZjY0Z01RWXVMd2lFTGM4bWpRVzZwZ2Iz?=
 =?utf-8?B?MVZ6UUVOVU95R0MyRGhiR0FpYWpqSHRYQ2ZkK1p6RkJkblRDb2ZNS1ZNOENk?=
 =?utf-8?B?bUxOMGFOdDZ4SnZTVkJqWTNsQlFrYTdkTVNEenZ6L25Gc0VLMytTQk13VnBF?=
 =?utf-8?B?czRaSkREV2xvL2o4RDl2dUxhKzFiTXdabEJVaW1CRGZPbWt3R1I4aEVXNjZ5?=
 =?utf-8?B?TjRmUVJkTjc4ckQybGhwSGRYWSsvemloYVR4WTA0Sit4SEh3a1JpbWFSSmxq?=
 =?utf-8?B?THk5M3BIQkZwc1ZXVUZHUzVINVdTLzRXemtKSXVlUmc5RWhoR3dWOXFZd3NF?=
 =?utf-8?B?citPZVVaa01GRjhTd3NWZ0Z0MUdSYk1kcXkrSG9LelF2QmNtdmNFbllvbW1s?=
 =?utf-8?B?TWZveUJnN0FUY0d3aEhQQUtDTEZFaVJibzBZWVB4SVhSTGgraVF6Y1U1QUc1?=
 =?utf-8?B?bjNIcnVhTnZhaklGY0VRcFl1UjBnbXEwcFlaVVJxUXpia3RRNWZlc01BcnBp?=
 =?utf-8?B?YWY3VUU0L1k5VnIxbU1DaHovVGowQm9qRlFaRFBqcVZsbmJaSThJZjVFUWhh?=
 =?utf-8?B?ZlV1NjN0ajZaQS9YVmhHUFZ2QlloaldqS2cyZk1LMWRCdG5GZzlKc0tVRVFs?=
 =?utf-8?B?cVNaTXFaeXM1Y3FjZnRHUUl2aFVaZjJJbUpuMXNJQkUrZTNPSUdGeUtEVndY?=
 =?utf-8?B?WkdxU3hNdG40bXVDbXRvRkJsWDd0SnhuaDhSQXJmcVZMaWIwK0pqOVUxZ3ps?=
 =?utf-8?B?VmZlbENoK1dkNlBVRHdzVHlTN254Rk0ra3N6UzFMTUZQYldWeVpvYk5xbFZZ?=
 =?utf-8?B?R1U0N2JaWFA1VTlSNzdQVVF2YXdCUUh3WTQ2NDBRVlZybW01MVFubzJsLzhy?=
 =?utf-8?B?anliZWVNRXNHRzRKZ0tmUTNQZDlKeFVHblpKZExwa1RJZWhiY0cySHZBNTV0?=
 =?utf-8?B?emxEcTIyUTZ3Yk9hOFVkU0hsODNPL3huWmowWjVJNVpkM2tEWFlDVkZxNDg5?=
 =?utf-8?Q?/d/HmAXJ4Xw2nqKxPVOC7UMzAb0MFqG2fXziAYztphPPI?=
X-MS-Exchange-AntiSpam-MessageData-1: tB8FxsHLmMLZbnkcfV1QniRB93nQCG66PZk=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c841ca50-54df-48f8-5fd8-08df1670bd88
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 17:09:18.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr/nN3WCr/Z8a6Ei4Pw5hhC4q82GMQ7xb7iep8wLe9KlO5MQcekl+5FknimJ88lzeEAW+SR9mZJX+KnVFEqEafpadmmoyBsHUFATv7AsWvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB324718

On 2026-09-19 13:00, Linus Torvalds wrote:
> On Sat, 19 Sept 2026 at 09:35, Bradley Morgan <brads@mainlining.org> wrote:
>>
>> I think hazard pointers are good, what test do YOU suggest we do here?
> 
> I want to see a single real-world example of "look, this speeds this
> real load up by 10%, and the kernel code was actually cleaned up in
> the process because hazard pointers are great".
> 
> Not a microbenchmark that tests just the hazard pointers themselves,
> but a real kernel feature that has been converted to hazard pointers,
> and in the process actually shows improvement.
> 
> The ONLY reason for hazard pointers to ever be merged is if they
> actually buy us something real.
> 
> So I want to see that 'real" thing.
AFAIR, Boqun wanted to use hazard pointers to cleanup/speed up an
hot lockdep reclaim path. Boqun, Paul, how is this effort going ?

I suspect we should wait until that lockdep user of hazptr is ready for
upstreaming and propose both at the same time, because a synchronization
infrastructure without any significant in tree user is not really
relevant, right ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

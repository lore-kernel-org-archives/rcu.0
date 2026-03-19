Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22F36EAB4;
	Thu, 19 Mar 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953137; cv=fail; b=ldlOq1QoBrNY6H9hqcaApAfvsUsQ0DsYaWRWRvp4O+5eyJeuBxd2hZ2v8kURX271gre1Wr5ZVV1/gAHHfA2waiwpw7kW1D1ixFz7/nj0+xMJ2nwAb3W/A5rU1dV2rcMeGCfZDY95Z9on7NjNTb2GKA1z0T57GwM7xvRREKl1gpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953137; c=relaxed/simple;
	bh=EaGPDXXB+qx4XV8+okEUhNhlCcQ3hx88FVmTTeF7Yi8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nESSy0SfgGXtLXh4TqZ2swB6HHxKsWujH0Re41alsDje92EP6VelhfaxrP8oY7K78wx9AMe1AgZLggGLxBlL1TakrSW3b2VyeMv5Bvw5c6Fns1UfGllJceRkRKHx96XoVwSuAxlsfqwRvx82WjTl/7+tpESmCKoj61dmbfMP7yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzcZ7JtH; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzcZ7JtH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxvwzmJq74FIlA2lWBOvcd+g+6Wr7rRgExFMaCOyKN/bVZNrFuqkMfQEJGxxvtEzR3wfkX/OzknTRtXuGuLZf7zjVQCdgJONeldkZbZRjgmxvkXXT0VzLCaTmHNepTrvVYy9LDbJ42YAZCchbg+3G6+J/l411E+CH+RpMZdKGwSfBsXYKbn0E4fZh6nm3zdXmlsyQYVhqMu5bzCgUUH9itwJdPUxODa/RL5veOF3mJr9gBme0sJ2m6yLK5y0dZ/V1G3/tUp4O+mae19GxTFUKaqCQ7bb2JWC45wDyrtFUMI4VgvrgvdfOlraeGCKgcOj5krWCCbvwwQMv0uX/gH2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRHR/FOb3z3EwKoA6gIgujWFySPnpQ0e8Jm+pNwTrqg=;
 b=ndtWZbpY/STeKKyG1p/c09UXa4si55E5OsOgUFpyS7JG2vsRcGWlMmCFyUc8AzlApwWTz3DfPPVKmeZp6vjasixpCm1zy877GM7shLCTH1GviWxWcQle+U3pKyMH39dJbE9DOzl0iHm8m/OlL7PKeuQrGMYmkPYGzAccxxNDhahQ/SJI/1ys7hT4HV7TccyPHNVsijqf0t8WMnKcJCBzx2jH8C96QrAZkuJ/K7mWU65QmNlQ4J24fGRnh6TSpQbyELWRvBwntNqzhHGy5HPjBYV5NXrtwheFtt+3FjARJIaj0l6xSO9o+EYL0/fDOXZiCzu/OvcOfE0qcob1F4a43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRHR/FOb3z3EwKoA6gIgujWFySPnpQ0e8Jm+pNwTrqg=;
 b=FzcZ7JtH0tzdJlMfkYgJf5g2gDZUhVJO7/C0bNJI8lhG8fccgDWtdK5RkRfwqqEhS83HLb1hPPpY1T6XUwnCGj/ByBxEWR/vQ2cdnifBBYHEy7OWzE2Vn/hjZg2NSItFIMd+M/1x6q1hjN9Y/ujvEUIuwEzvJutVguZmiJWf7PLBR8sQqccxR/g4KJcMLDh3H+CaHhLXSWpwk3jin9UeYr5SwkBlLRFfXpFQYeEeJ8iegfdtzoz6aOEkm2ZFN2Jm9Nwe1QNigJt0HlxZCvSkunygaCBy5a9WV96lpfDEU0ITX1Ph6UbwZWA69cCeONQk/I2GmEHkZaucoM19bENRPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 20:45:30 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 20:45:30 +0000
Message-ID: <6b540ac4-09bb-401e-a233-e90597287081@nvidia.com>
Date: Thu, 19 Mar 2026 16:45:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Andrea Righi <arighi@nvidia.com>
References: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
 <20260319170244.jqndSwct@linutronix.de> <abw2ECYirX1tTwV9@tardis.local>
 <c520958e-78e1-41ce-b675-4a560305a206@nvidia.com>
 <abxap0vo0SoP5Jh0@tardis.local>
 <733c185e-9672-4184-ba65-ae5279f5bfd2@nvidia.com>
Content-Language: en-US
In-Reply-To: <733c185e-9672-4184-ba65-ae5279f5bfd2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 69164186-baa4-4c5d-0da6-08de85f875a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	H1zGSJvlM5B4C8hAwWYHvMZ9yhtpph+cSJXxW7i3guKm/r6jXJUaKSiu7/6KRnm5Ti9kk/xxJ3ngAU1F21dsIb+tMkZlQtaCmysUDdlVMT5ADo7jIX5nhGp8lUawYiswLrefvN19+vqBgr5puG3wkA5XyAM1y7U1iFGYS4k/7RwapEGor0sSP57EaZ6f1m1BbcjiYisFMV/5ICq/9fGFa87kwBtNCXSyX9tcAc/tQ3rYSbgI0e7GYmONqlQ3oFymPFbAtttPOzQ0x3bu4mbRDP9lWeJOYfQfYOFRHvIDMqE3Mn5YhjBynF3stApygto28vBUOVUVYGkMnNcv2HXerV0ABuQnEV9i9/BXSahRUlO2tys+y9VpC2pV1ylLmlcUG4D+NrzDHeAkQaItjEaHSwFeBlH2dKsEwggprax/BbdgYqFA/x8L0856ubsZpFwvQ19yrCn5L1ULllHxkqG9FsRJN1q2+Ht3xkC+G4fR3+diocI7Fpcl8Q7iEbP1eLgzy+VOb/BOzPpivUx+pFg14qswp32RPacy2UfSCzBNunKRI2j02gi+wkNIB0B4EDp2Ru6RCqek17Q8D0Ep4SGcoFDnF/iWB3EEvSLL4fg0cutOa4ApdZxOMVPm4f4wdt/DqWVEMXHK9wzUjKQYtJI6shwBDRNQ/HqDq5doyW+as17e3AamCSaM8P0/3cw10CcF0IhliM5MA9TqhPPtmOhkoJHvnqgKVzjxweyoY868K5i7Y+1Q7K671QOi+WvrKIMZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0tQbXF0aXhMRVRsY2pRUnBXZzBiSGVEOW9rK0g5TXpEdkYzQVg2WThGcE9q?=
 =?utf-8?B?Z0tBa1d1Wkl4dlRhbmY3eTRjWmFtcVFKRyt2czBHdzYvQkkzTFRXVlNzQnFE?=
 =?utf-8?B?STVKY0I2L3VOSWFXQjd0Rld6M2pzS1ZCa09Bc2tHS09KaHZQN1JlOGtPTzhK?=
 =?utf-8?B?MER0aDY4UGhLR2ZjSXdFdFZ4aFlqSStndG8xd2NjVEp0M1MvRFZ1YTE0RFA0?=
 =?utf-8?B?VzV3RnplcEUxbmlVc1RXczlVQkxYb1lLUGx1bHE2UDlNVThxd0U5ZGsrNEhx?=
 =?utf-8?B?aTFjY2M5UFREWlpzSjZORFY2L2ErY3h2em1MUXFZekpodGRCd0lqSFdoNWtw?=
 =?utf-8?B?ZmZqWFMyeStnUU12T1BPYlJSa0VSMWFvZ0tzejFySE1ZNk8vNXg3a01Gb0xE?=
 =?utf-8?B?Y0N0Z1ZjQ080UTY3MnRwODREL3Y4YUpXeFpmc1RBYUxLK0lNd0RrQVlTZ2Rl?=
 =?utf-8?B?MmZ0RkRwNlRyRFNibUV5WjJaYnpuQlh2YkxzQ052bllwbFdrQS9IVXhiMmY3?=
 =?utf-8?B?cllpdUxGWEZNOWhCc1I4LzJMMjF2ZGJYN3p4WkNGSlQvWHVCVG53aERhNFMw?=
 =?utf-8?B?MFFseXFnNzRCTHR6Mk5GWW53WGQ3UnFUbVEwTm9sd04vS1dVQWloOWlMQ1ZM?=
 =?utf-8?B?Z0hTUHR1QWpXTGxZNWtwMVZLSjhmb2RUang1QUR6MDFkMXZjRjN5Z0tINkRr?=
 =?utf-8?B?RkZFSVplbnlKTldMVEF5ZXp4ZXVjYzQyNUFnK2VMb1BxVk9jNFJLV2pFWVhD?=
 =?utf-8?B?VEFKWXp0U1VUeHlKelptQjVjcHZ4Q2R1WWtRM1NRc01FczZDT05IRTFXeEUw?=
 =?utf-8?B?amNySm8vZW42YmExZy96UGc0OVAwVDRDTGRvdnVsYVVaSTJ1ZGJJUy93YldR?=
 =?utf-8?B?SnNKWXVEWFVLcUk0aGY5UnNGNWt0VHFibFU3YnhiK0Y1UFNPQ2t0Mk5HWG03?=
 =?utf-8?B?SHNjWEZIeUNwY2hCSmhtNHZWNU02UitVVGIwT2hxWG14eVZGNVJYTmxLMUxq?=
 =?utf-8?B?UW5INnNWbCtLdC9pbTNib0RVU1JxaFVVTEdUOXNablpKRkt0K0hhNnVRdksx?=
 =?utf-8?B?YkRKWFBhTnBIRkJoYm16dk11VGVmdTFIRTl3ME42WFdQYWNtVllNVXFDbHBX?=
 =?utf-8?B?eERtU3NmOWp1TVpibFlSSnNUb3Npd296cUkxbmxMbks0cWZiTE1VMmhRRE5F?=
 =?utf-8?B?bDJicGRuek96MU5wMVFBTGRydG95SEpNQUxYWmQzalFCU2NlWkVXdU83YmNq?=
 =?utf-8?B?a2p0MVorUjBTdHcvSTExNDJiNXpNZVQyMUFRQ2hGWmxLeFJQQk1TY2EzMEIw?=
 =?utf-8?B?NCtTYUFEUGxWSVhFNm5DSnl3WTBSTDE3bDFmK1kwRWRCMlBweDI5MTFQV1I4?=
 =?utf-8?B?NStEbVRUY3ZCd0U3dS9OSVA0UUgydS9yT1h1cFhrOXZXL0RNZ1REbnVGZFo2?=
 =?utf-8?B?eGtTRnFsTE9yOG5vZ0FOSlJpRG1zUXNQRG5Kc1dIUlhOalhuNjRnbGFLL3cr?=
 =?utf-8?B?dyswWEo4K3ptd3ZkNkVNMXFncTBYUkRHWFdaaDk0SUtMRVJVYXVGOUlsM2Uz?=
 =?utf-8?B?engwNUJSU0g5UHNvY0JzeDJVemlrRlRUc292bWVVMmVZcTZ4dVV4aDBGWWFJ?=
 =?utf-8?B?M0ZjSjJzRElPQ0RIQ3MwT2l6Mkl4M3ZIbGpPb00rbDNhT1RLbDJscXhDMEJt?=
 =?utf-8?B?VHlVK1d4NmhuSUJtcVVqbjl3bDkzMGRyMEs1NzkzVUk3ZFJQNjkvRXFjNEJz?=
 =?utf-8?B?V0RWWUh3cDgyRHdZcXpkQ3NaMHIyZHdHdVVJVXg0bHRWNG1LN0RNOUZESDVE?=
 =?utf-8?B?UkpYTDlBVUtzaFFjSEszeEp3WnpDZURsT1RobXFSM1hWSE55cEN6cG1SaFc0?=
 =?utf-8?B?OG9aWmtheHQ1VnFLeSt6ZVFNRE1rS01Gc2JVNXVnQXZjYUxsL251OWo5WUhx?=
 =?utf-8?B?THRjTm4wbG8rNUR6MHV4T3pMK0hBK1MzcG5LMGFpMks4ZWNOTVZCdlFSKzc3?=
 =?utf-8?B?UmpGMEg1enlrTnBLRVR4RVdjd1QvNlg3M1hCbitnSzQ4b0JYU3ZJeDZPU1NT?=
 =?utf-8?B?ZmV6MVVBb3FmU0l3TncyazZOc2NMaFg0dHUyODRiQmJZNmRIWm9LczVTaGtT?=
 =?utf-8?B?OGdycURnbGVNVVFTakhyVFUzUENEZ3hSdzdWNGhCNWVTQ20vb1JxWkxHbnlx?=
 =?utf-8?B?OG1FaVZ0blpHaENXamRPZ053YkpXc2lxL3hGMnFjYWVRWUJBRnVMQzBOcWhN?=
 =?utf-8?B?VHdRSkRWekhSQlkyemJIM1dqYlpCdkl1RnZ0NzltWHplQ3pCM2tkemN3V3lF?=
 =?utf-8?B?dlpnblM2ZE1GWUVtczhLTTRJRFk0KzB1THd6K2E3T1NpeHJjSTdqUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69164186-baa4-4c5d-0da6-08de85f875a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:45:30.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qcSJV53BG3mxvAUOFH0WtwEnrJ9jwKZEKAu7RiC/14lbW8iOZSQdKgri3TdZbx/KdBNnGyaFPPNSw6UJeuNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505



On 3/19/2026 4:26 PM, Joel Fernandes wrote:
> 
> 
> On 3/19/2026 4:20 PM, Boqun Feng wrote:
>> On Thu, Mar 19, 2026 at 02:42:56PM -0400, Joel Fernandes wrote:
> [...]
> 
>>>> naturally happen: if the extra irq_work layer turns out calling issues
>>>> to other SRCU users, then we need to fix them as well. Otherwise, there
>>>> is no real need to avoid the extra irq_work hop. So I *think* it's OK
>>>> ;-)
>>>>
>>>> Cleaning up all the ad-hoc irq_work usages in BPF is another thing,
>>>> which can happen if we learn about all the cases and have a good design.
>>>>
>>>>> If we could get that irq_work() part only for BPF where it is required
>>>>> then it would be already a step forward.
>>>>>
>>>>
>>>> I'm happy to include that (i.e. using Qiang's suggestion) if Joel also
>>>> agrees.
>>>
>>> Sure, I am Ok with sort of short-term fix, but I worry that it still does not
>>> the issues due to the tasks-trace conversion. In particular, it doesn't fix the
>>> issue Andrea reported AFAICS, because there is a dependency on pool->lock? see:
>>> https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>>
>>> That happens precisely because of the queue_delayed_work() happening from the
>>> SRCU tasks-trace specific BPF right?
>>>
>>> This looks something like this, due to combination of SRCU, scheduler and WQ:
>>>
>>> srcu_usage.lock -> pool->lock -> pi_lock -> rq->__lock
>>>        ^                                       |
>>>        |                                       |
>>>        +----------- DEADLOCK CYCLE ------------+
>>>
>>>>> Long term it would be nice if we could avoid calling this while locks
>>>>> are held. I think call_rcu() can't be used under rq/pi lock, but timers
>>>>> should be fine.
>>>>>
>>>>> Is this rq/pi locking originating from "regular" BPF code or sched_ext?
>>>>>
>>>>
>>>> I think if you have any tracepoint (include traceable functions) under
>>>> rq/pi locking, then potentially BPF can call call_srcu() there.
>>>
>>>>
>>>> The root cause of the issues is that BPF is actually like a NMI unless
>>>> the code is noinstr (There is a rabit hole about BPF calling
>>>> call_srcu() while it's instrumenting call_srcu() itself). And the right
>>>> way to solve all the issues is to have a general defer mechanism for
>>>> BPF.
>>> Will that really solve the above mentioned issue though that Andrea reported?
>>>
>>
>> It should, since we call irq_work to queue_work instead queue_work
>> directly, so we break the srcu_usage.lock -> pool->lock dependency. But
>> yes, some tests would be good, the code is at:
>>
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ srcu-fix
>>
>> related commits are:
>>
>> 78dcdc35d85f rcu: Use an intermediate irq_work to start process_srcu()
>> 0490fe4b5c39 srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()
>>
>> One fixes the raw spinlock vs spinlock issue, the other fixes the
>> deadlock.
> Ah yes, with the irq_work fix, indeed.
> 
> I'll try to queue the irq_work fix for 7.1 and run some tests. Appreciate if
> Andrea, Paul and Kumar can also check,
Ah, but of course these should go through 7.0 (assuming they fix all open
issues) since that's when the bug was introduced.

thanks,

--
Joel Fernandes


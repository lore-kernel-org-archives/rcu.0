Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA233148DC;
	Thu, 19 Mar 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945787; cv=fail; b=CV9T/1NNW4OM25PsPjfMGVa+n5acRk6rsH35bGIHBisdEtLyCsb8yEMb93k5EmZg0bpytHv3G3WEHizrPD1hwqbURl/1pcs5VWlermhFv5JuTPKJOWkckzqjQEokKu7EIV2B4zKnZUVbdaLfB/qbEPziiet/+6jWKDbDX7WckXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945787; c=relaxed/simple;
	bh=9eSwPg0XQkWPeHOvCUExM9pKNl5hS017n2gqi8tU+Vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dz5UICWQcWn2lnnXN+3knPsN/dVNJnSjrZrJYv+94JZyyDXIsWyQ/T7Kox8PcJb7to+ZNiAbX+qrqd0Z09VmTqU1Vt9FT8gCm0oK+Bp9/38zaJt5OLaDeKVsZ3BFvcReUxQKgECCVXTb3E/AJ4DW3msWzJxRc+po+lgiVFNUw4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGem1yyT; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGem1yyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaedeH8B0lTxX6h6IxjxtaJ1Z5JaYg1Uf2U7igdcwGi/E064NXfdWuBtjnRaq355zjw9PsmwPw5db2kZSNyNZtvR2e1XfefvlyGZPM8P3hgtaev629DphREzCZbzrs2Zi9/qJnRaRhN57KlFSfP2W5CLs6NXNIai19WidqgHp7L9IFr7S4KUXhMFjswsmfPIh1zOfZYhh6AHCaq4leTq8i8XxoA80V8Boa1rOv7bPZE4DvuDFdSucwistAty2yNT6+6Nw2tqqlSuqrbKC7yfHLKcnaL8E+9cMclZd70+0uGtbbYfhPom34+F1KtO68kyz9aOBnE+AuNwLTIRKzVpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjE1KingJSUrkeMA3oAxTx1a6xGi03FGvHrMZbeTe78=;
 b=mrx6LwOgk3Y4n/tieWFDP+MgxdNTrGZOSStaP1xedMsUMatBLXqmKQff0DsRYcZJNXUsJI1FaPs//DlGDPU4jcdcgEC8QrvFa0RDBr0vzVhV7BZm9Fv+Vf8vhsCtaZP1QRSIa8DSeB8fhzgvHC0h7GxeAO5CQWXuwHzpq6Q8Ub0SY+PFuOXCI/1/OgcAUkJsQf1014AmPqPDv04ArSbPPZlhTd0bcrCVr+qjIPAPSEaEi7hcuKJkawgLog+clWxW8f23p94tkI9PCBx8iGQYPu4D2THfebvenB/Xku2VdjCCOoUcLkHHPf+ByV+OGJq9rHFoKO55lEh21nKi5G2k3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjE1KingJSUrkeMA3oAxTx1a6xGi03FGvHrMZbeTe78=;
 b=RGem1yyT6Fmowm6XwVDH6hjjMWLRtsTBwP6AIKjrm0tC3Gcqalk9WzfZiwwS9kKA3wy9hsinXxF4oT69JlfCyrUhSfQG/b1fYACCaVgjMnXXfsTIlRFoY+U3f89jSFt2lq2mQdSqv2Z24QGjw84ljBFC5XnGNjvmmK5Mtxn/eyfgyOowXVuUN4IsTow88kluuGkChOEBA+LkD01OBagKu6btHcjAn2nmu7Nw3H73gKpkIYHbxSKQHOjBNOwu5tjQycLLhwy03QP4/BVPWvM4RmnLoxQA0f2huYPxoLs8wfHlQ3fJx7Ze0ycFzWohqT4YVbquCh4hgjyCGmpB49GegA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 18:42:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 18:42:58 +0000
Message-ID: <c520958e-78e1-41ce-b675-4a560305a206@nvidia.com>
Date: Thu, 19 Mar 2026 14:42:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Andrea Righi <arighi@nvidia.com>
References: <absfZGD3en9TUA1U@tardis.local> <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
 <20260319170244.jqndSwct@linutronix.de> <abw2ECYirX1tTwV9@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <abw2ECYirX1tTwV9@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0029.namprd22.prod.outlook.com
 (2603:10b6:208:238::34) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6a1f5e-b470-49c0-40eb-08de85e75783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9GV4vNRw4JjW01JPgFedIjfv6fGIURfYm9vHlJIa4a+dAPkOZkKlJs2ogI10SSR2YkWdi0G1l+nA5T0HxSN0SS40C4Qb+sJVPJks9peBm6EjLWmbGCXN4bsIqyn0E1wLtmX/Zp8DXHsIfIXjZWoBvplSl8+L56SBO9L3oCJO+2Q4VZsOeyoS/HGpEdS6DpB82K9MdgkFYx4Ux3xtXkP6lyBVm5W7RUPB1VtFDIBT4t9n8HEGAbFiqTCMGBZ4571wZjoHYwc4wqK9jGAikrwr5OT8m3+5pU1QEGkAip4OEF1SxvxQGQL2SQ9xA9B2OuIj1OJXqF4mR1xAGAwCjpRLKUjx9xmzaK5lAArNfxxZe9eCVvBky0KCd7xNQGd+sxKOLC2irgNoTD0c1+379BM25Y/KFhtm/NH3T/xSlw58msIBGpuXdvC9H7e6MgTfjjmFbKRtQuRjd9CHeoGGf0YKvGJKNpe4EZjObFNk5sc1KownjMBA3OBmshLDqJIpf4GbOD0bkm2VtUUdUh87Fg2cuqEYmlyYl1fAJbdmvn/OJif4WpK/NbI2BIOnj3PMfVMQHFjeP7v/0Ykd4cR7cY7CODrLlykjQIjSeVgb58v507l25XhGQwXSdGRt3VpOqxlnX3PfGX1OEunP0TdFDjS1qQdKTX3v1DqmetmfhvAwcKW/0k/wQDrkm7sYdaLAKRKtWgM0H91nLdNrNbGuau/ROY26J4iSE+mNF++9R4H1DkFT2ku2Z4Una9r59A5zUaRS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJEeHdUYmZDbm9mN2VZTDJWV1ZCNGw1L0R2L1JXWHFGWDJRWUpmTEI2czNC?=
 =?utf-8?B?VHhPSEhGM2hDSGF1Um5wVzhSaDNMSEpUODY2RzZ3Z2ZBRHFMaHZNR1lLK0lE?=
 =?utf-8?B?R2RiMjVJa0dPVDV1QS9KaGVxYUNYY3g3ZEhGM2JIUnRmTVQ4Z3FBZDlwbXpa?=
 =?utf-8?B?UjV3bjdQM1UxNXByMmxjWjgrckdWTUIydmUrY0tJQzY2dFhMR3BGSEhZYW9W?=
 =?utf-8?B?MGJGcjd3aFpMS0FNb1IrN24vOGJLSW0zcHM2U0dtQ0ZaaTZZV3RSTDJBNDJn?=
 =?utf-8?B?clJQYWIyTVNQZ2k1R0YxL0FWQTVIR3dwSkJpaGZiUEZGRWNZc0xldHBuSGNI?=
 =?utf-8?B?MkZlV1MzQ21GY0JpYk9MbFlZWXBKdnBrcWdXMEQrWGRFN3FTTFFMVHptQlRv?=
 =?utf-8?B?YVZWNDVYTXJXQlZhZXNBVFB4c2JQWXFhR3NwUURrNS82ajJFM1g0dWlXa2Zh?=
 =?utf-8?B?Um5HeXJ3WnNxRHdPVUU4NUp3MDJJSERHUzZUMHdaMUtwOXpqUVlWS2craGNu?=
 =?utf-8?B?dmdQMTZyZGIvM01ZcDJkb3ZLTDQ1MkcvbnlTTzRMczFUZDNtQ0crWTRhb09a?=
 =?utf-8?B?QXZvN2lXbDYyL1V0TjJwSzk3RkZjYUp0c05EQ2FkaEc5Z2hTMzhpcE1ISVRT?=
 =?utf-8?B?d00zQ21rZXRIa0ovb0o4NlNNMVMrNzlGMWhiVWtmUHQ5V1kycGdXWGNZRDhG?=
 =?utf-8?B?cUxTUU5NenhsbEtwMG94WEVZUEVSYU9Bem9SQWliRWxyMmtOdlFkOEtjQWJX?=
 =?utf-8?B?WHlVRldibjBFUHN1QnhZU1FzZWlTVjl3ek5aYm00dE5xUTlUQ1dKWnNiWXVP?=
 =?utf-8?B?YVVGUmxlY2s3Z1VOc3NrdjFaU2MrWUNPRVhGS3pjTGNhM3FaR1grUGFyWUI4?=
 =?utf-8?B?U0RZZ3BhYVdtNFJFMGtLU3JBMW1EMW1Bc0JKck02WEFNbXZrUUpwU0RxcldJ?=
 =?utf-8?B?V0ZoemsvSSs3RXVoT2NkT1Zsd0xOclR5aTJ5dmo5aGpBd3JOaWVIMTZ0aGpz?=
 =?utf-8?B?TkV0R25OYzBvQUE3Sys1MFUwQmRoazRNcGRGYjlHak5JUDM0ZHdOQWFVL2VZ?=
 =?utf-8?B?Y24vZmIvTExuN3E0a0RiUWdudTRsNkY1WHVac3pFZmNvWTdRSGNMYk5xSEF4?=
 =?utf-8?B?R1pGbnVFZFpzWmdvQnFCdS9sWWdPSDNLYzFyY0MxZTlFWEExZ3B3b2RTQjUv?=
 =?utf-8?B?R1RFOGlpakw2QjFxWUU0ak44d2lVdjhFMHE0RDk2Nlp2RzJBVm1mSkY3NE02?=
 =?utf-8?B?M3hUdXZwWWlZeWRyVVhGcHJmWTZZMU5WUHl4d3ViMFd4WklBV0orbW1jRk9B?=
 =?utf-8?B?dGFBWldVVkcydnJNMTg4dG9xS2hZU2xMN1dIaTJ6R05IeGR1YUJCMEFKdzhD?=
 =?utf-8?B?cWJMWFh1aHQ4UTB0TGdRUGZMTFFUQkJSRHpYTDVhNTdxZzNnbzlDV3c3Y0Fu?=
 =?utf-8?B?dlpPb0ZPcDA4aE5XdGgwQTFxVUVLQk9DcDFJZWlVUHZVNlZTLzBUYXB2Y1FD?=
 =?utf-8?B?aXJRVVpiZmhVeFVrb0VuSmc5aXhZYXdQQnJ4bXVHQTZnWGhVZEdsYzNwaDY0?=
 =?utf-8?B?eEdSbWNNMTlNUUlXOWlFZzRkdzFZU0RZdnZHbGxMYlI4Y1JERGhYSUcwOUw2?=
 =?utf-8?B?NThVSGI3dkdIZnJDb0UvTkEyL2hKdVNxR3AySTdvWFZybDJDd0JsNi93enRZ?=
 =?utf-8?B?Z2E4WVNxb1BHZWxrS1pqRFd3T3hPeGVzNXptM09HUGx1NVIwNExkdXpFVDcv?=
 =?utf-8?B?THJaMFRkaytORlVkQ29zbmNNd29yeTd5bkp6OEVQOVkreUdwTXRXd1lzeUsr?=
 =?utf-8?B?ZVRFa1hqOEVUd08wcnVvRUduQnE1dSsrQ3FUcjBDV0JGeEtQc0xoN09EWHJt?=
 =?utf-8?B?WG0rSmxyTytmeFdYMDJhZjQwbHJVbm1nT21mUG5BQ1o0MHp0T0MzdnlSMjRm?=
 =?utf-8?B?U09VTVFuWVlnZlMrL2c0cDBLRDFDaHhzM2wralIyOHdWNmFiSmpTbGRtNmt6?=
 =?utf-8?B?NGdjR3lOREtKWWhxdWI1YUVqS25BNnFzREhPWjVHVVQzVjVTQ3h1Tkw5RGJX?=
 =?utf-8?B?YXpnOXQwZFNHaEsvVU1WNEU1Y0UvM0xPYzBDMWtZd0FLY1BrMmFiUGducEU0?=
 =?utf-8?B?QmdySTgrWkp1NnRPNjZvRTJFa0lUelFYa0gwVldpUXNSWG50TDlyc0RvRnE3?=
 =?utf-8?B?TU03NFBadTYwMHYvUTZlcko3K21ib1NVS2hiU0NKbDR3aFhhbno4b2xZY0J1?=
 =?utf-8?B?WGhCYVlHOFQ5TFRJREp1QzdiWFBLUnU2SEhLcHZ4TWZBb3ZsRGpkTXFYaXJY?=
 =?utf-8?B?STJENGZueDQrUXdPdkZ1Ukp3V1cyNGhpKzgwSEhjdFFKK0hpSlRUZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6a1f5e-b470-49c0-40eb-08de85e75783
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:42:58.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC5KG+TfOrhbA5QhHv7pkm5gM4EbggzO2EWztYyKDamwVS0GdPMZfLqvA6iqv2LlOoBzM1ZfuAu1fY/jGY4F4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

On 3/19/2026 1:44 PM, Boqun Feng wrote:
> On Thu, Mar 19, 2026 at 06:02:44PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2026-03-19 09:48:16 [-0700], Boqun Feng wrote:
>>> I agree it's not RCU's fault ;-)
>>
>> I never claimed it is anyone's fault. I just see that BPF should be able
>> to do things which kgdb would not be allowed to.
>>
>>> I guess it'll be difficult to restrict BPF, however maybe BPF can call
>>> call_srcu() in irq_work instead? Or a more systematic defer mechanism
>>> that allows BPF to defer any lock holding functions to a different
>>> context. (We have a similar issue that BPF cannot call kfree_rcu() in
>>> some cases IIRC).
>>>
>>> But we need to fix this in v7.0, so this short-term fix is still needed.
>>
>> I would prefer something substantial before we rush to get a quick fix
>> and move on.
>>
> 
> The quick fix here is really "restore the previous behavior of
> call_rcu_tasks_trace() in call_srcu()", and the future work will

Unfortunately reverting c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in
terms of SRCU-fast") is tricky since the original body of RCU Tasks Trace code
is deleted. Perhaps we should have added an easier escape-hatch, lesson learnt:)

> naturally happen: if the extra irq_work layer turns out calling issues
> to other SRCU users, then we need to fix them as well. Otherwise, there
> is no real need to avoid the extra irq_work hop. So I *think* it's OK
> ;-)
> 
> Cleaning up all the ad-hoc irq_work usages in BPF is another thing,
> which can happen if we learn about all the cases and have a good design.
> 
>> If we could get that irq_work() part only for BPF where it is required
>> then it would be already a step forward.
>>
> 
> I'm happy to include that (i.e. using Qiang's suggestion) if Joel also
> agrees.

Sure, I am Ok with sort of short-term fix, but I worry that it still does not
the issues due to the tasks-trace conversion. In particular, it doesn't fix the
issue Andrea reported AFAICS, because there is a dependency on pool->lock? see:
https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/

That happens precisely because of the queue_delayed_work() happening from the
SRCU tasks-trace specific BPF right?

This looks something like this, due to combination of SRCU, scheduler and WQ:

srcu_usage.lock -> pool->lock -> pi_lock -> rq->__lock
       ^                                       |
       |                                       |
       +----------- DEADLOCK CYCLE ------------+

>> Long term it would be nice if we could avoid calling this while locks
>> are held. I think call_rcu() can't be used under rq/pi lock, but timers
>> should be fine.
>>
>> Is this rq/pi locking originating from "regular" BPF code or sched_ext?
>>
> 
> I think if you have any tracepoint (include traceable functions) under
> rq/pi locking, then potentially BPF can call call_srcu() there.

> 
> The root cause of the issues is that BPF is actually like a NMI unless
> the code is noinstr (There is a rabit hole about BPF calling
> call_srcu() while it's instrumenting call_srcu() itself). And the right
> way to solve all the issues is to have a general defer mechanism for
> BPF.
Will that really solve the above mentioned issue though that Andrea reported?

+Andrea, +Steve as well.

thanks,

--
Joel Fernandes


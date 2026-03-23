Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B351D7E5C;
	Mon, 23 Mar 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306218; cv=fail; b=t8aiWrmCIhqc3Cbh+OYLcbalnDmQ/6qo6451Q/DqDaNlou+EEB24JPUZkOGVW7UDPq+HS6ndvhkzyrOIXoEXbCBEvOvKDRf0HHSOMH8XGMezZbFxVoIjXBUKIGNUXZIDZ2Fmm7fwlMiegH8Svq+5kJsHWQfUzl+cOIRPGnRj0JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306218; c=relaxed/simple;
	bh=WIN9RRTOBAjsGSrzZo+D7aBFASikK+Gd73PWLEff14E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uo8uUG16W6ouSRlzAfKJ8Bgy051u8md6oYxwTjoOFOwN41hwCDpoLXqjVnf7LXdB/pk5ICKtV1XemtcnPx4ne0H9RH3/iXmEnC1wYdx7LAxgnopvTByUH3O27Ndl9q1wO0vhqBa12n9CDr3swfE56J8mIWBlli0qDiqpyxQnKhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U1BK9ndK; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1BK9ndK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3XnhBXL2E4X0AebnTqrBPpep9ZRjpRRHSdiddXYMpyhIuCXfEDac1N1JClSRdxCqxKdj+O11edLaBc6anQdbOkA8YKH39tHPaFv0VmQb/UIv49u065S2e3Ld13Ky0uXXyAp8Y5sFhFlf7mHVe0kH5yqrWr6SCtgr0MrGjFF3ATr5vQLDTZJL6wGiLrmi4FFiXowapnk8TJzOm4Fn5fAM7WXE3B50uouqt5pVjioUh7h5lIkcKmH90xlykc/cKL6nEv+cc5E2wEyFI+C4lPiVtnfH9D16N1TsNNQnjqFEkUQcvCVbMo+QiiiH/gD61Ir2PAssV6FRrSFTwJx1ULxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAkl90plElaCMwX8pMDXgTnPn90eT4qZJ7a5pxTpPkU=;
 b=TTVWKaeaT0QxG7FwAE9Ss1SAix9AuL62As87Rb1qHrN4tgKRKL10KFp9avUP3XwsxRDH5bPZY02PqnrPbkcAOwZJj0SJz4xUwaKMqftKa/Zws1qEMs81TID7jan99DsO710N3qpBGn4lKypm4cOKzrlqyJ6jhimpMhyJwafkgE2hy8yLzyvO3cXBl3PMxMsdB+OXAXlYjI/uTpzl/XkwPqLDi8w9ssaycHn3tWYrQ0XRVvHnPHQZ7gdCb8ln/HYAe339d+oz+j3W0KtW5dZu4yZ9ACoCyRCjqByqRj3ZSHCLp89SwqX0PXvs+jsLxzS+KEYeSAS5qnEo24HXkaND0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAkl90plElaCMwX8pMDXgTnPn90eT4qZJ7a5pxTpPkU=;
 b=U1BK9ndKZig8VOpb2kND9m9YlGVF+d8BiDtK4TAqMkm96sQ7UfnSqGfL1p9Fe70UAvD60b2BnCumjn5P/u+a7Xq0hD2khIa6A/7YcBylLRDeGFHdlo9nUh86SmpSEKJjCHZW1pGK14EyfmN2ECG6akGIlCTAgv3ldGs6gLw2smMv/mAI440Gfo/3qwF/JHs/1u3VG/ymzMAEIHjMz70nDC8IUsuSTSNTwChWJgrj16LD7z0ASWWiAHeFANMTr8UF1mBlcFWMzLsEw+9P2m+MED3z3TL83zzzJajhBlzFeQojGvKl6Ow2QkBjD5IOtILDTuEk7UwdkppLfkS8xCkPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 22:50:12 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 22:50:12 +0000
Message-ID: <9a7c9bd9-2382-462a-9ae5-53351441fc7c@nvidia.com>
Date: Mon, 23 Mar 2026 18:50:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <8fb6b64c-5c75-4b42-8abd-8e85173710a5@nvidia.com>
 <acG8UyL4cFlXvs-B@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <acG8UyL4cFlXvs-B@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2b2f8e-dfbb-4210-62b0-08de892e8b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	ScHBRuKt6mm4j+cMfTPJS6Leq4fJM41el9u7CRXfqQArYqrfdDeKoamg5vzqpsVCyAFsKIqNVG0ry2QK+Jt/tNP+j6Xi8k8XGa1dOS7boZb1J7KAL4yhC0GowJqxFQ64VEvhab9CmKKFcgd6ETUcd1Vj6HA4wy1rqjHx0Q6FTcb7nWXMr9PNlx57vbUrBlP4uoGLcI4zb4Je2HCffLdnzGN2EFRMtTdlNkUcQ3P5ZYM2IXX/LHyIzqJE5Jf7sfut/CRONoDoP6p7h9iyHDJVGFWI2298je8gFYtifEuaIF5NmOlsulW0wmlf7I2j6yxCVUhipKoHWMFdXZMm2kUOfxDv0WzqY9njvtYXZSNejwWKCJ+SH9AiPR3scDoQZE12lOxxUfFfE9F65+G6QWBe+yqXjksrKbdBKPxNE4Bbl93fxl3NIbT3xylqDPGu1W4TXA31/MEGNNLJ1r9PC0exy/VaZAKGCyNwEGKVtuuNZ8ccB9n+5UAGHjB35MqkuWUHtYrLN/wxDHglHuDr/g5CD1Qz+BEUIHBFbGrPGpADXXdRVTdv97CbTtWiA4KyYP9IcUvTak+9UMry7NboWLVhOSVX8r+rt933FAkykv0zXCK5K55NLcYauHn0LCrI/zZgY2PfP24EMCUMKj6hW2kFpG82hX57MJ6Q9NgqDv/UuRxcU8YbdK0ACtoC8dnOByrF4e2ecMYm5i1kVWjO3TuUnduBj3x82SuPaihQn9bKeyZzehE9xxYzf6Z0f7Z4FZTZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFnQ2NkUTBYZjd4M0RTYXlJSWJrUG8ranJDNXAweWM1bFdlenllM1BNSVdF?=
 =?utf-8?B?TDdaak5BOGdXZm01L3RLRkYxZzA4QlpkRWZQVUU3bk5HcHlyZTA2dEtIVkJH?=
 =?utf-8?B?aEMyakROZk1iOHA5QjQyam82Rlo5ak5vNldTMmhFTlF6YWd0WXRDYUYwWkRL?=
 =?utf-8?B?TU83ZHBhMnZmSEhDWGd5cTBhQ21kN1liamdwZHlIbmxCYTNmQ2VhdzFEUEJV?=
 =?utf-8?B?ZkM4c2tWcUtLaDc4a3VYR0ZmRWlldFo5U1NrUTZkWnZiY1BjcVh6NEdaR0xB?=
 =?utf-8?B?VnJEdHlOenIzTWY0d0pzUlUrOEVVN2tWY3o4YjI1T0ZQdjd5Sk5ML0c3RHZs?=
 =?utf-8?B?REJOcFBTVW02cHhZcVNjYm1RVFN6b0tYSkNkOWlRMVVxQnJSS2RiU1I2eHNZ?=
 =?utf-8?B?bk5RSVQ2M0FlZWZlZ3d2bWEydGFHSUFTY3ZwRVpDczRPN25RZjY4REJlSFNI?=
 =?utf-8?B?OWk3K0ZEaUp1b1duTzA3dnpzSTltSlFYRGtRUGR4eXNVcG4wZkFNb3BpNXJ5?=
 =?utf-8?B?VW1uaTIrSm9rZVdTbStWVWFsRWRBd0paOXhkcTBialg2NWVBZGx4S0EzVlAz?=
 =?utf-8?B?b0xDNnA5alRUYVhyYUxwWjJvUmdScE16ZERsQnRaMnVUVVVMNS9Qa1l5THN0?=
 =?utf-8?B?RWdQM00yRzhWbnBNejM1V3lRSDkyRVAxa2t4R2lXSitXeW4wMTVOOUJhRTRO?=
 =?utf-8?B?MkttSnRQVytyU1A0OFpid0dieVNsNjBCWld3ckVJRWNFVUVZTE1GOTcrMGRY?=
 =?utf-8?B?cG4xdXBReGM0ZDlLTG42bmRjSk1tZ3NFMjY4Q2MrODNDWlFGU0NmS0cxTWQv?=
 =?utf-8?B?Z0l3bDhwanIxd0o4NDJsRk9xdHRRU3VLbFhZdXE1OVBYSGU1TnhJQWpDSXhK?=
 =?utf-8?B?YWpoczJxRitxL3R6eDQxNFZjYXFXeUgzWVNxdCtjYVZFekgvNk1ORGRkMXZQ?=
 =?utf-8?B?ZW1SN20zT2tsQkIxOUo4MUpPcmlhTDJ0b3FmK0laNVBsdW43a2hMNWRZTy8r?=
 =?utf-8?B?d3o1OUZ2Q3VIWWtzbXZIZW1tV1BzKzlEMDJvS0t0Y3J2L2tCQVBBNWJ6MTdy?=
 =?utf-8?B?RkVKUUpXN3hUQ05OWXRCaW5XQit4L09CYTZ6TWtEd1RlcStNV0c0d1EvUkc1?=
 =?utf-8?B?SEhPWGw0ZWxnOFlTWGtzUVQ3MEpueDN4TG4xZmVGSm9yaFRPN1l3cWNFUnlm?=
 =?utf-8?B?VUtxOHFJL0krRzhjSnhReW5Qb01UVmd2b3NQNE52ZkJGbE0raXNaQjVJYkRr?=
 =?utf-8?B?eGxQOGZIVTlCSk95MVJLUU1LeVU5T2U0WmpYb0xid2FvM25sVGFiOWUxQUEx?=
 =?utf-8?B?MW9ibHQ0VEMxRUFZc1VjWTNYM09xVFlxR3I5c3VZWXpKSVRBMXZrdFdpVFc3?=
 =?utf-8?B?cWxPZVhHdC9EdnNRMUk2RGJtZnVKVmgxMC8vaHlmcE9aK0NuZmE4QnBIYzBD?=
 =?utf-8?B?L3N0OWVTVWhNSUFmUnZuVFdIT2d2WjZGTmFpR0FLQVhYeVpvb2xXRmd3K0Fw?=
 =?utf-8?B?SVgvMUVTZTdabjVWWGJxYStvaVFWUWFnSWJGSitoa0VuZWFVT3oydXZKRFNp?=
 =?utf-8?B?aHdoZ3N0MDRpN3o3dmZCUnpUNzh4cGtpazIyam03Wk1RMG5VYytJUDhaZGt0?=
 =?utf-8?B?a3ZObEVBaVg3Yk1LNnRPTTRBVU1kTGQ4Q29sdWZzRzBCQjArZU82ZG4vdTJY?=
 =?utf-8?B?ZS9rQXZLMm5GTFdGb2dxeC9iUWlDT2h0KytJelV5OFVkUzRTQUxzb2Z5dHhu?=
 =?utf-8?B?TmN1S2pRaXV4aS95alQza1Zmc1YwMEJFV25FVmhubXNpSU1nd3RPQWpDVGJN?=
 =?utf-8?B?eU1zeTl4WGdWdWtSTUtCOCtldm1iVjZFVitTTVBJTDlVTmlWaktTRDYyYVNV?=
 =?utf-8?B?Qi96cVNFamtNd2NGV2hqNHR6R3NJRndxbFNnZGFXYTlQT2FONlI4RUY3ZXdm?=
 =?utf-8?B?ZmJoTndRbmQwOHN4bVVKckt1TzUya3J6UFF6cGU3bkFWUlBXRGhjanZZYk1a?=
 =?utf-8?B?NlkxOFN0QWNNcXRhU1BqeFc1UkhHQnVKeG03V0p6MFg3QUNNS1hLNUt6NGFF?=
 =?utf-8?B?TWFGZXN0R0p2bXd3K3hNZHRGUk03TVJvTjUwUDk2Q2d4ZkxveFR5VGdJeWNF?=
 =?utf-8?B?dXM4VEtWRGJIZGI5ODMzSE16L1JHV21kSExTeFZ1VUNHaGJKUFRzdldyd2xN?=
 =?utf-8?B?Y29aL0hmRE5UYVV5dlZkVnN0Z05lNTZjaGlMQ3hNODk2WmJQejBuMGhhdDAv?=
 =?utf-8?B?MDJ3TXNtTHdHaGdrdjd2SmsrdnZjQWcyT01WSXhic2tMRk5JbmIwZ0lVdzkw?=
 =?utf-8?B?VFdvZkg4UCt2TEUxQUJVYUlsSmY4YjAwVUU1Mldsd1NSdlkxY3hMQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2b2f8e-dfbb-4210-62b0-08de892e8b06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:50:12.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P5qcoPb0UO2Zlsn7PGE4I5G1wZlkgsCbweHTLqIqss69pUCheKcUnIwMd6AvY8dAKrQLWgI9HO1uPjiBjkBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501



On 3/23/2026 6:18 PM, Boqun Feng wrote:
> On Mon, Mar 23, 2026 at 05:09:53PM -0400, Joel Fernandes wrote:
>>
>>
>> On 3/20/2026 6:29 PM, Boqun Feng wrote:
>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
>>> happen basically everywhere (including where a scheduler lock is held),
>>> call_srcu() now needs to avoid acquiring scheduler lock because
>>> otherwise it could cause deadlock [1]. Fix this by following what the
>>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
>>> the work to start process_srcu().
>>>
>>> [boqun: Apply Joel's feedback]
>>> [boqun: Apply Andrea's test feedback]
>>>
>>> Reported-by: Andrea Righi <arighi@nvidia.com>
>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>>> Tested-by: Andrea Righi <arighi@nvidia.com>
>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>>
>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> I have the following in the shared rcu tree rcu/dev branch, but if you're
>> sending it for 7.0 -rc cycle I will drop them:
>>
>> 998608c o rcu: Use an intermediate irq_work to start process_srcu()
>> 15d921a o rcutorture: Test call_srcu() with preemption disabled and not
>>
> 
> Thank you. I think Paul has another one we need for v7.0:
> 
> 	https://lore.kernel.org/rcu/ad67e723-7f7d-4350-b886-c04e56c0b78d@paulmck-laptop/
> 
> I've made an fixes.v7.0-rc4 branch at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git fixes.v7.0-rc4
> 
> with these commits on top of -rc4:
> 
> d0f816d5e872 rcu: Use an intermediate irq_work to start process_srcu()
> 6b7fc20ab878 srcu: Push srcu_node allocation to GP when non-preemptible
> f627bbab8fd0 srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()
> 
> I will send a PR at Wednesday if I don't hear any objection. Thanks!
> 
Btw, I am getting lockdep splats on SRCU-T now for some reason.

rcu_gp_start_if_needed() calls schedule_work() acquiring pool->lock

I believe this is because of Paul's rcutorture patch. I will debug it more and
send a patch but all other tests scenarios are looking good.

--
Joel Fernandes






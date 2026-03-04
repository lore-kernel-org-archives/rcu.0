Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E31FCFFC;
	Wed,  4 Mar 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644014; cv=fail; b=BSsf0IhXLKADrkYqHkrK6DHqwLlr9q1mMlG3rPJu32S2JU028AVkJJzXo1IWa7rb7XB1iPBJPd48Z58b4bpjx7dl3OYP0ORvkpKKYx0wAZDlVUjnKmNb+w9uxKuiKfBrtQ0plVC+YlrNwagRnJXOEEK5/Gn+TL7dXuUmvpX2fMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644014; c=relaxed/simple;
	bh=oKLlnXqb3mLnShGnD9w4mWllQVDWqHS/f8BKY5vRcL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MC127s4JrJKKckXSN0+CFuWNlHt9dWTD+RwYp7TcDxvoIJLYih41VbEbGvgQdiwBZcSLryK09UWUFZIUTIbmNNv4lIWuC8D9BDVYf8AKJWqH9n2fL92zwaOeVSKyWJZiOwdxyjuvzWAyzC1FmT0HqwM8gbQJF99wHyEnBmPBTp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIWqiVe8; arc=fail smtp.client-ip=52.101.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIWqiVe8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIKuTeOuHB6BYJ7ABI2Rfp0Pzi+qupczw8ZH75y/AJC9+4unIEIhoBEJBiluo2bxLXxVnhQaKzeiy8a4WQWNX33f0XSDQc32RSf1eC0/6qRM828sZ14anFAoLmkutqJ+KX55IHGA35tBtAJy2Cj3zlNk7N4D7D+esqAHeCThdZPe0O+EjtSoPrHtPHMOmwvNrX/hNmqc6WomhE+rVVmA+SmJ3WE78wNVoNdCBWgHXhoCnJND479YYPQDMvxN4FVz4Jhfe2WxP7ZxsGiO62b1OcIawZmifrbp3j3nWGt++kLva4IPFed/AuvPHGUMThQ0IvzBV0ec7fjh+dQ2HfQRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76jkGBcMOCkjZwTnrhvqqEunoHd7MnA+9/fMWdtFxyM=;
 b=kyhTduvaCfB1CZAyjkU/efz3F/QmuwsdKLUETfwGQ0QgDh2isbFBoKiERSbtFFZOIZBnYplBUPO6JZpj7ZsiDTktU2Jfqpe8ou8kMwy4rQVcWdzzzoCI/tc3kiQTiBwFiyGISWSB++4JYShIxvzqPuTq/XmTbxz1xrzjKYlSnT4/DddVnBP9Fs98AVP7MKmpP1kZMwJLOTXiamk6MMxBXb8tfeiieW60pGwIFQqPXnUtEL5aH7MlXTIq1xQQ1T0Pxemlnjkveg2tQ7AIvk4pm3o5/71LnhylokAf9WDQYt4JQt34Bb4BkMazsKhP+GINtXw1zimm10KwB1ihxh77yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76jkGBcMOCkjZwTnrhvqqEunoHd7MnA+9/fMWdtFxyM=;
 b=NIWqiVe83Q394wAv0VKMmNy9XVg14qxCf4kkdQGalpmzN2Vo7cYPxqs9lWkNvTkjwcxZD7OecfI4iPkJCKUc25gW8jR7u1Y6CiO9Wo8BRmyRHZPP7qGehWTGPmcGg6eS2RCLU0HhBCqEaaC2JIwDlAOzdAoB9innv/cLbEZ1OX6go8XjB477ipUROn6ah52S6p64LCTBJjqe2mfE1Z+uTdJAaUcEjsTn7rMvIFXJv+KHF6XN0voNSfkRL3cRI1TDbEQRtXZmvtB5rdRIoxEy34d+1P+SINNqXJSHe20QheeBWVMBzCtlgqTr1LtrNXkSm2SWJAplhQs2pKCOWHLECA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 4 Mar
 2026 17:05:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 17:05:37 +0000
Message-ID: <155c20ce-b390-4499-9a1d-97f78ce8208a@nvidia.com>
Date: Wed, 4 Mar 2026 12:05:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/4] rcu/nocb: Consolidate
 rcu_nocb_cpu_offload/deoffload functions
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-2-joelagnelf@nvidia.com>
 <aahQhlPp3Qqm4Bwg@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aahQhlPp3Qqm4Bwg@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2615c-4039-42b1-e327-08de7a1041af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	paVvaJBkkXLpC6m6vb7OBi6eC4WUkSBsG/dLASIEZgipUOvH4ARg8LEGC6rVqNQG4uQyvupd/AwbABTyP6Xy5jSpMsK+TwDJxnd6OIB7f6MeywnlN53O1csqtZqs165i4hMkybZl0APDa0P+w4MRRYpnhdAFgk63+9HfV+4W+wiuJ9aScHWm/e89OqO0vDC3JqH05+vxK79goXLBOND+rn2YzoyOuZOgHLPCk0iPX6OP4E3n7hg1y0hm5bFpLb+l3whPuQKOziVEKAfN/ptQKmFQ6wWKmHh/tvWc8v34KN8UE5X6Et5vBM3Dk4SCtFGH6bAgnu6ZbJ9ZlCNzZA1MO+wiU+v5+2VC0kAcHRId8XKkTxhhFRY4Gfb5WYXikL22mRZ4XDJxBExq+wm3bZKTO4bln86GoW8v4K42dzLrlCy3l5e6lhu/Fz9WnjZh154AN80/lFkAuaoiTxFlTmfzYNcRTX3/QvKnOy9hRk0z5LoWOYrWGv9Ly+gd8ISe3/4AUh17C+wRe+XuWrIY927etNmiU3FHSd5hfNvyDExQz9sPlcXD+4pi9zf2zM38ih6HReGTpo7wcH9nGB46fBUC5a1QRXrR9vLhmby6nrCuACZNDIB0RV6jP6o7n7Qjkan22zyuWwHiw4Wy4QmJL45ik+0cpzgT6Y+C4ZOHF2CXriWO5zKOHd/TeQCZkg8RjJlrAsHLpecu7mmcijzmaeEDW/FwB833a3zoap3TNipUnyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDIveVVGaDQzQ29sTXVQR0wwMHduY1VCVDlmVmZwYmcwMll1eVpCL01pSTRy?=
 =?utf-8?B?UTlrVnJHNEQ4UWFTRHRlMWlybHd5d2VOZThxcWxRZFFwdGN5dTVoeDJjR2ZG?=
 =?utf-8?B?RmVTOHViejU4TUo4Y2xtLy9iUkVJZzFQNms3eHN2Sk9ONzVLWlBhbytCN3JG?=
 =?utf-8?B?WS81bmV2Z0EvS0JEajRvcHVaRFdYNmE0M2x3VFBWU0pHeTVjK3EwYWZ2Uy84?=
 =?utf-8?B?UXZMSk9QcGh4VHZ2V252QkJIalJyN1MyQWt4dzNackFXbGl6L3F0VFlHVGZ3?=
 =?utf-8?B?L3JZbmx4ZnEvWEp0N0NYOHUxTFFLN05TVDhwTXBKK0pqU29EcG1zajJ3cHlz?=
 =?utf-8?B?ZzNzWngrd0pPTlNrdnlKa2FIbUwwaXJEcmJ2WDFiTFVBN1F6ODRYN0NyZ1lr?=
 =?utf-8?B?VnpVWmU5Q2J0dG9EZWdqR2pYN05NQ3dQNWg4ZkE3QkxiNlM5TDhTMjdpejRJ?=
 =?utf-8?B?UTQwaUI4eUp2K3Y4WFlZN0JnSTcydVVUOHNpNE04RXgxNXpUaFcrN3dwLytB?=
 =?utf-8?B?eis5WmViZ0o4N0pvUHZXTGlmZ1lXMmQxKzdlSGU1U3Brd1VsbE5tbStOb29U?=
 =?utf-8?B?OGUwb2VsSHBoSUlmbFA3NDdqK093ZXZBZHZ6ZlFvZHRvTmVqK0RPNGRDSFlI?=
 =?utf-8?B?d0h2ayt6aVVoOTJCWk92NFc0R2RCQWovN2pvbzN5YUl1OFNvd1A4T0dDS2VQ?=
 =?utf-8?B?amxQQVBjVlFjVUR0RkZwQjRzOHA5c0xTRU1aWlNXUkpVbHRJZ2NoR3pRbEhQ?=
 =?utf-8?B?eXhQQ1NXUDFob3VBRmJFRUFiZFJLcTczeWY1VTZzZHVheUhORUVqQitVT0Zx?=
 =?utf-8?B?eEFaZTF0YzJ0OW1SQi8wcG5GYUFHWlY3Y2VUai9WM0E3eGtKZkhDb0czM0Yz?=
 =?utf-8?B?aElhU25XOForK3E3SWduSlhTMC91VExPSURCcjM5R3ZERldtQjhYbWNHR0px?=
 =?utf-8?B?SU9TOTNMek1pWkRHNHU5WlRaUHYrbXF2WGVjOC96eEtMbldselJBQkErRmJP?=
 =?utf-8?B?emNRdlQ1UFVNaDVCRjlORGsyUGVQMVE5NGRKZ09jNmxTbUVmWklFMDhsby9L?=
 =?utf-8?B?MzN4ZFNna3hteVUxZzZTRElHWlpKZmJEUEsxZVBIV0grZlNKVnpGODZRMDM4?=
 =?utf-8?B?OGtLQ2lYTWtkdHBXT2psdkorMjU1WFc3T1V0QytGZjZEcUVkYWxISlhxUFIr?=
 =?utf-8?B?TTFDV3JVRTVLVGlFazhzeFRMcWJDTEVoQlQrRDE3ZEFZWDQyM25sYkk4amlZ?=
 =?utf-8?B?TEFoZldLdkRmVUFLREtkUHc1QXJ2ZjhrdnhISHMrbjlkdURmOGpTL28zMlNH?=
 =?utf-8?B?Y2hYSUpEZzJQZmtZM3kwV3NqeUtJZXRPZmM2WStCOWpJa3lESHA0UU9aUHhG?=
 =?utf-8?B?d3BUOWFMb21ISWNwUlBxYXNZOVlRUm13WWFUSm03QklUV2lGL0pjQjVFRnkr?=
 =?utf-8?B?Vm5TTUJzQ21RclBRZzJ2OHhzZXlpQjM3QStrV3hodFA2YjF3bkNMalcrWFVm?=
 =?utf-8?B?SkErVHZndFd3blFoc1JNaUxaK2xZRjNCRGRGNW1oZFJvR1VHVWVSVVlESXhC?=
 =?utf-8?B?dHZLa0ZPaGY3MzFSRDIzVzRNL2puU2lhSmNRblBXcGI0ZytDTytzejVndzhn?=
 =?utf-8?B?azFyaW5PdUs3SnpaU2M1b1RTeWJVZmVxdFVuR2ZkanRUQTNvbDB1a0w3K2lI?=
 =?utf-8?B?SHBydXgrOWptRFBZNWp3L3E0NERRRytkUjlvZ3c3RmsvTnRJTWU5NGpGRTZP?=
 =?utf-8?B?azIxUFZrWnNTcnNoU1kzRyszb0hXNEIxajFOdEZHd3VFcjdZQUZEd0Vvc3li?=
 =?utf-8?B?TTh6OW1NYWlrOXM3QzIwUXcyV3hPMThtUytQSlVhLzNCNkVqQ0lzaWR5dGRn?=
 =?utf-8?B?Wk5DQytSLzZzN2pPcDNrdExYRmJ2RFBpTXhVUGxQZExjUU5kZXk0ZG0yQ0Vi?=
 =?utf-8?B?QVduVWt4QmxZRFE4a0JGMWloMDgzNXRDSTg5VmZNajBqMEtEUnd6bnNJdnJD?=
 =?utf-8?B?V25MVUo5Njdhazd3eGU4OXYwelY2ajAwbHM2alkzVTBwci8wWXpvNis5TVdJ?=
 =?utf-8?B?V0FFdEZXWFJLL0NzSlBrKytZSDMvMThtQXJ1N1lFOHpCNm5TanE0V2tjQ0hU?=
 =?utf-8?B?aVBBVE1LMW90TGtubVlNSlhlOHVuZmN5c0ZWaU43MG54dFNtY01iMjB4c3ZD?=
 =?utf-8?B?eDF1Z1FBRjFlamkrK1R2TURvM0hwUTUyb0VYZFpMU0ZiTm83YXE1S29IVzZF?=
 =?utf-8?B?aVZTWjJ6aVNldjduMUdwSElqTytYb1czZlI2OEVjOUxxMFNnaENReTl0WW9Y?=
 =?utf-8?B?RUQ0YTU2WURQb1JzQ3l4OG1rOVhuTnhIUncrTSswdUVJczl0b3hsZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2615c-4039-42b1-e327-08de7a1041af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 17:05:37.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 412blo2ebzPDu8sBbM2roD7byBCTkSb+9Ngl6SOZHILheOS2rcNnMPWEjjTMcSMdA5nHQgy0ySjlQZ3HREI7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096



On 3/4/2026 10:32 AM, Frederic Weisbecker wrote:
> Le Tue, Feb 24, 2026 at 06:04:32PM -0500, Joel Fernandes a écrit :
>> The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions are
>> nearly duplicates.
>>
>> Therefore, extract the common logic into rcu_nocb_cpu_toggle_offload()
>> which takes an 'offload' boolean, and make both exported functions
>> simple wrappers.
>>
>> This eliminates a bunch of duplicate code at the call sites, namely
>> mutex locking, CPU hotplug locking and CPU online checks.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_nocb.h | 89 ++++++++++++++++++++++--------------------
>>  1 file changed, 46 insertions(+), 43 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index b3337c7231cc..5b041134d6bb 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1081,30 +1081,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>>  	return 0;
>>  }
>>  
>> -int rcu_nocb_cpu_deoffload(int cpu)
>> -{
>> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>> -	int ret = 0;
>> -
>> -	cpus_read_lock();
>> -	mutex_lock(&rcu_state.nocb_mutex);
>> -	if (rcu_rdp_is_offloaded(rdp)) {
>> -		if (!cpu_online(cpu)) {
>> -			ret = rcu_nocb_rdp_deoffload(rdp);
>> -			if (!ret)
>> -				cpumask_clear_cpu(cpu, rcu_nocb_mask);
>> -		} else {
>> -			pr_info("NOCB: Cannot CB-deoffload online CPU %d\n", rdp->cpu);
>> -			ret = -EINVAL;
>> -		}
>> -	}
>> -	mutex_unlock(&rcu_state.nocb_mutex);
>> -	cpus_read_unlock();
>> -
>> -	return ret;
>> -}
>> -EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
>> -
>>  static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
>>  {
>>  	unsigned long flags;
>> @@ -1149,27 +1125,54 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>>  	return 0;
>>  }
>>  
>> +/* Common helper for CPU offload/deoffload operations. */
>> +static int rcu_nocb_cpu_toggle_offload(int cpu, bool offload)
>> +{
>> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>> +	bool currently_offloaded;
>> +	int ret = 0;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rcu_state.nocb_mutex);
>> +
>> +	currently_offloaded = rcu_rdp_is_offloaded(rdp);
> 
> Do we really need that extra variable?

No we don't need it, fixed.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

Thanks!

-- 
Joel Fernandes


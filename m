Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B193FF8A1;
	Tue, 24 Mar 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364175; cv=fail; b=VHtlt79c9U498XFwqfm/6RNVzBlMnX9O/+nvgSYRFEH1IWf7XeJMAE8v0ikH1dfV5+iuUgar3fD7LlyC02MzrU8k9PhkRbeHKpaGPmsSYDn+WYiOYDYsmRrlwRfQzdVoKwUyF8u20qcWUpP8pSyERXVjnGHYSLArxDxH3OSU+lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364175; c=relaxed/simple;
	bh=kekRAcg1E8X0Gz95QbkhpQbENsJwign415WB6pyXbno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SmdFNQUGHkEr4tZXuj3yi6aWpcy+4QejWVlSVFTQcAGPNDpLZ1SP2mB7vTNCZooUoWcf830LBhEhX00tmpQ536+KL5BpQba5tvPrkXMGq/4KTY0qSgXFYYx+8CtCOAV2kVCtzCRe7YWZFDQRhrD09jjSjkvUpCZfKaayp0jA/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBBMa2+w; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBBMa2+w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et/QkTcCVoYY+WcGMdBYb3PcGqKHCmL65caKEq3VTQ8KI6ODUdCbIPwRis0tD1yAF41dofP+l/o0QvvESz7ZRj25ru6wKfa78NWsXGHe+DZ93OkmZzbKQIWFzdulC0QjAC2rtEB3Z6iLlFhSmT501G5ZlHrlQP0buCHPqEYvCcEF/ygb2+vq87n/y8e0NkWYW6UaQPSH77NKrIEbSv+E5TnUbIYwdefLiS8bj5YhIN8YvbnBeNiwV04ILxfTWu9khQ/3l2JAkOYXP/RZFMgfEmVJbJjVqHCpKCSSq08StHg10Yl+o8mw6IBbuBLHscFg1h11UxPZLF7mtVSYuH5CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su7swep1kr1TaRDpJz92m7FQKU9oi1AsJYfY/L947Dg=;
 b=ylNTzUTKzwGm/lsxYDWtmxLgjq0FpnIv+5HLoISSaztr3ufqgF23Y/+JsVaMuIxs2a1XFeE9Rrw5/uUHV7Pl/HGSm7QHCJAhL4Qt6zqlGbtqss7v4E5cnaP1yxnFXT8Rvvlx3iad1dT1CNQ8oQ3ZZxZHULgZE2AwOqS4hTpH4sM9aUdsFzah93MqxwCVaMkt8vvZMufLBZNdACue2U0uetV0N95Ycsd4frvZfnqRH0gTJiSexWYmVBs9MOLWkgPjKyQ/zEPbyLXuBxQMB013aJ+9wlJWUI2cgfTjDmj6Rnn4V7OJUF0H6GlFerEzS2zfBd/fTfOJrOasH687rCySpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su7swep1kr1TaRDpJz92m7FQKU9oi1AsJYfY/L947Dg=;
 b=kBBMa2+w70MQcT0n8iaU54epNpmEfxVCVv6VBj0/ej/7hMDjQ1Dga7bctoV0ZGdXe1h7ov8rkA05SlA6En21HZmM1eRJDRqv0ovm/+c7XCrpwMeVEIXY5LemkpcbgtpSpI0rbKEa0pdMaS+EKvgIusZa4XnWyointoEHTfGhE2IDS5JtXj8i/bzA0SJfg2Wh9ghnYsU1GjlrV3YU02vnavlX8I3j0nZFUKMKh5JkYFQSkngaIJsCzjWAXFTmbizWvyqYyKQRE+fmjW22bL7DT9boGQAgaJQkGFYnU698m43CF5twU5NSylB8tYysIzxXhHD/54T2a2j22XHIH3uK9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 14:56:08 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:56:08 +0000
Message-ID: <98598125-b6dd-4ea2-864a-e6e2836948b3@nvidia.com>
Date: Tue, 24 Mar 2026 10:56:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
To: Frederic Weisbecker <frederic@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, neeraj.iitr10@gmail.com,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <acJ1HRXomQhbTN4_@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <acJ1HRXomQhbTN4_@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b86d0b-67dc-4bba-8fac-08de89b57b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3+LnXwxdu5s2+jDPkt+y6C+oDQllvRYtEoE2y6FMk7NOmhS4g8IkipZpQMXhwey9+aRIIFuB2Cp/gOH5WjaNkXHvJo0J4HKdXPsYYk5F/nAyYnIsCUezcpdFG6XETlkSwy0psa4JSnuPMb32i7s3sBSsiBXqVWglcURUyWxELUE8tee+tQPbzNzrd1L8kf8htG1TDI2k1mJLyWkZ4qdRWp50xJWv2PZytBDSFTHxrRkFPajFWq5rLbMOVULHEmJcX9EQrudCIP/GsUMHOy7ZeCNsSXhV5qlN1woFaQyvHp023EpcyBfSBngn5Z0kf4Ie+/ynQRIWKmM0N+j9P293BelgS+bVZ3iDetLXnptbgPI1OHCuuiN20hMzKn9G5iqSPjCVMWQQzJS7TesxgX0t9egjfQ9G+K6MnI1E5+JFXuAJMN9Mm5N9OhRxvViSo7NY151cxkWBNEx6x3UDetlSGwJuSSaEHZJbwvotHxKXc+DNzxaUOWBvHM10FY/K9wWFC7fdbVn/gs2pQ7tI8Udhv113Bsq6tq2qduV3OOEd5GPjQfbMccB3iUJidpoRIlaFIR+DhmRtPh9OCNP15Y8mHwRTXFt6cOtBuD3LCNS/gI5jfqG0XsLKxZThFOm3yy/E1n6iEEB8/hNdcky6OYFCmt2LR2omUgc41E+8tphawYE111ma0+BTeZiISHz6NmdhvW4LO20mW3baPsI2je1Z4J1Cs+X5gbNWUgmOs7zJvsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHFxY3RHQ21Xa1dia1c1YklVUEhxbnl4bVdjcGRZQ1FFb00wMGx2amhtOCtD?=
 =?utf-8?B?eWhxVnEvUlFhOU5mYkRlZjNnSHVwUUhxOUZ5V21wb0E2QVNsMWlLRU56Y1h2?=
 =?utf-8?B?cDdJdFh4bGY4ajlvaHJ5MXZKdUpGNzgyK1hrS1ZvMnlkY2NuRFhzOHo0N0Jh?=
 =?utf-8?B?WWtpUjg1L2lUN1VvOUJXME5mOXczMEZYbW45anRzNGpiNm9SUFR0cHlQZmRv?=
 =?utf-8?B?bTFJZGg3aHpoZHhIUGF1eW1GNTZLanM5Q3p4dCsyY04yeGxYcFNXUWtuZmVp?=
 =?utf-8?B?YTR5UUQ1MXlHZE1TMUd5SzhPKytFM2FQZE9FN2oyUWloYzFQS3VmdTRpNlNh?=
 =?utf-8?B?UEF0SEJJWXExRTdpcThmcVdoYS9UNkdrTVlqZ3E0S3JjZlFtd2ZNYjBHY2Zi?=
 =?utf-8?B?OWlKTmh4aXNGTzl4dDVMUjlZVGd6aE5FQXY1UFZONmJUUVB5SC9MTUJCY3hz?=
 =?utf-8?B?Y0RmaUUzclcyd216MGtab04ycEpVTjkvM3JnbExLQWQyWTZyQ1h6RjBGR2NR?=
 =?utf-8?B?WVE0THdRWXFhYVl5TVUyWXE2YlhLUW5yT2c1V042Y3RzT3d4a3RqWGNYeFJV?=
 =?utf-8?B?bVZiaFlRY0JCbWVPaS9ReUc5aTJoMkJwT0NSemtCcHJvaDBIeWRub1A0VGZh?=
 =?utf-8?B?cHRsMjVCU1VNSlJZWmdwUW9GRUpuR2xvb2IxdjIxMWlIN2w4aW9VcHV6NXlG?=
 =?utf-8?B?SWNYTUdkKzVIOTFseW9PT2FBU3RkM0tGbDVPRTVxUDdueGorSEdGYWNIb0xE?=
 =?utf-8?B?cE1aMWJGZWRXTnNrK1ZhaFZBSFkwYTJPc3ZqV2hQY0grY3RvMVA3VTBNUXp5?=
 =?utf-8?B?TkRxK2IvRXdsV3FoalRpUFhzNytBUzA3Rk43Mk5wdXJaWThncGc1WVdZQUdu?=
 =?utf-8?B?SGhKL2srVkJ6WkxaYk15K3NqOGtBajEzU2dBWEFrbktuQWdkSXUwTnpSd3VX?=
 =?utf-8?B?dHZ2Sm5YNUlYSFdmRGR0eVRPV3FvSWl2djBnTkVzSE40RUZENXpaVFZLTFZw?=
 =?utf-8?B?Vm5LcXdSSDJlcVcySjhVZlNIVkNYRkR5ZVBDUFk5Z1p0dlQweEZqelhNUDVS?=
 =?utf-8?B?ZmZYZWdvcGwva1diLy9XM2hXUU5KTUFqYW4rQkhHZ1VmekVBMS94U0lKdWpW?=
 =?utf-8?B?eGlvaHlUa0h2TUR4c0VxTzVzdytPbEEwUEF6eXNCSVBYOTFSRjVoZ3dlWHZm?=
 =?utf-8?B?anR5TGIxcDc5QXlSMEJBSFNJemExR0FwN3owS0U0b3RiUUtuTzdJRHhaNzRr?=
 =?utf-8?B?RW5NQWFqQ3V5ai92RFJGOXVrZ05JbHpSRSt4eEZnUnRnWldUaU9QNjI3RTlD?=
 =?utf-8?B?OXhabEZIOGJrT09oNTRJUXdtc2M5ZUpyZFBJN3FLTnJWQnQ0TkxJSXZhU3pk?=
 =?utf-8?B?SjVtUnFabFRQRDFLaVViUG1BeE94ZEtnUGI0Q1FKYktOUkVFS2pFYlphcFY5?=
 =?utf-8?B?KzlIWjNSekRzaVNFK21WeElycEZMbmt1TzBtSUlVdDQ5Rm41U3VaU3liL1ZG?=
 =?utf-8?B?Rk9QallHbUlmVEVBaVU4TzFvalNVUmJaQnlONXh4eXFmdno3eVQ1bGlNbHFa?=
 =?utf-8?B?eFZNc0ZOOVNKaGFTNGJ2SDdzRTUxU1hzcG9GU2VTSWZtaFd4bWZaVDZtVDR4?=
 =?utf-8?B?SDN2NjZzZi95RFlQVldtZkVYMzd3bGpWVUp5U2N2TkRIRlJ2MTUwejVRVS9N?=
 =?utf-8?B?YnlsK1d3UWEwc2Q0VjVWWlBkM3NBY0E3bFJqME5xcnpUTjhsdEVFZUVaUDlZ?=
 =?utf-8?B?NU9pOHpWUndmNlgrWGZJWXpIMEg3TnQ0c0pPRDZzMm4zTUJoTnQ4alhtR2FB?=
 =?utf-8?B?eXRPN1lUUHNWSUtoeExGb2cyejRZcndFZE1zcitXUS8xV1c1VFo4Rkl1dGxZ?=
 =?utf-8?B?ZU4wRVlUVTczenNHM1FZK29OWWtQT3R2NmFFUklXbDR2R2I3STA5b3B4UHBI?=
 =?utf-8?B?RloyYjRMakV3MDVicHplNTVEMnlRREFMTnlVYk1qaVc0bmhhMWtydVA1Nk9Q?=
 =?utf-8?B?M2ZOUGtGdzRaL1lSRkJlaWhZbUxtaHNQMEdYbUJiN28wdm4xRElXSnpKS1NK?=
 =?utf-8?B?WUQ0TmFtRWlKNXhMYkRZS1kwYjM3aHFkTXNqcTRpa05NRDQvYTlBTmJ1aXBM?=
 =?utf-8?B?Tm9KUThoR0I3dzkvdVVxa0Y1bmJWdUNmVGxERlpxUTkrRThISEYrektzNlVw?=
 =?utf-8?B?V3ZwMHFWY3pDaWM2NktTTzcrYzB4NEYzMmZ3NDYvSnFGcmJiYVFSL3JYUlRi?=
 =?utf-8?B?aDZpN1lxdk5HWGphWGhacUU1K2psVUJ6SmRqNnY2M01wTndjZUw0TVZGb1h1?=
 =?utf-8?B?czArYkVaenoweGE2S1RxdVB4NXovYTFwd0tzUmJxVDBLbWxtUWpDUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b86d0b-67dc-4bba-8fac-08de89b57b03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:56:08.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cijd8XeUTkfeCBPa75Qp+GVCKNYxnav8IOI+kM+sWXExXn4dWDMamT2w3eHzmhx2bRYYMNz1Log07fQTFxjqSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571



On 3/24/2026 7:27 AM, Frederic Weisbecker wrote:
> Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a écrit :
>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
>> happen basically everywhere (including where a scheduler lock is held),
>> call_srcu() now needs to avoid acquiring scheduler lock because
>> otherwise it could cause deadlock [1]. Fix this by following what the
>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
>> the work to start process_srcu().
>>
>> [boqun: Apply Joel's feedback]
>> [boqun: Apply Andrea's test feedback]
>>
>> Reported-by: Andrea Righi <arighi@nvidia.com>
>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>> Tested-by: Andrea Righi <arighi@nvidia.com>
>> Signed-off-by: Boqun Feng <boqun@kernel.org>
> 
> I have the feeling that this problem should be solved at the BPF
> level. Tracepoints can fire at any time, in that sense they are like NMIs,
> and NMIs shouldn't acquire locks, let alone call call_rcu_*()
> 
> BPF should arrange for delaying such operations to more appropriate contexts.
> 
> I understand this is a regression trigerred by an RCU change but to me it
> rather reveals a hidden design issue rather than an API breakage.

Sure, but there is a valid point I think by those who say that "This was
working before the RCU change". So in that sense, we ought to have this
(possibly short-term fix).

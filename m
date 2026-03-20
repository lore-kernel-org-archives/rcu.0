Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D992D5C8E;
	Fri, 20 Mar 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029272; cv=fail; b=BnQqqHTH50Q8R20jyFyvbCVLQFNPRqZf2t1tHL1gHAgq6fp33RI2C46kzGs0+OF7d5uEGmk634pnsXlIKQDIyppP8HxH03kGD9WegJVjnqhiBfU2ASC13wY/JCbhVHk7I9PG5dvo3lmclvd6X0lrPRDmXVyX+UjzXFD4vAyIsso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029272; c=relaxed/simple;
	bh=xxDAPdopk5qLTNFabZXpLpGiHDM/3b1Hnp/LU8BQipw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXReIU4fiNmpEQjYfdkSCVhl6h4t3ZP93OXdLwOquHjGSt0yvxi43Qbk0q1TLlYrFNwn8ZSNG0dDDvTr9iLpIibbceleTcv/RlIH0xHh9JSi/nTTO/6EXLIV2dAjTZEM8p2yTud+Y93e2HQFIOVW0ZzZVn3sjZw+UzcFRgl1sv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hb05EGVQ; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hb05EGVQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAqeGfKFAZfovsNz2bRTKGewXp6sp0tnHN58LrTZPe44YFaoOEn7ffYZE5thXTEYlXA33/iCTE3+NtBm1aEdKCrkXeJkXPGpqWvlImNMHz1HG9cACA+ZbAyfNp94lbKhawKGA6Hl0FnZFaQSmvh0A+gZbhtoJiyyE4H6ahBFYEg/NFHWGfu2QqWF3FgG+Lt0w2wUei844fdcyJsbnlEe5Mrg8NFNnYpJttDGPzbF0F6iFCESmk9+cX6TKl6IPGkiOlnSgSk7UkZJ3IJ02gsouF64c1XBTyBdp0Y9Exyw4f2yTE1QI9oUoyUSntIj6xZywJWQ5dftQLnZTSdwjSPFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Narya/d34ScpTYkmaYm5VN6iS3nKl4BiJc4befASK9k=;
 b=uZDcAdOWNpyC/SP2CBPx2Sb7dzdE51qt7B9gWkWn1iLwbNPxVKkxEZ9YI/32EM2ysnw7Qa/Q0jvfIccI84SGuSpqg+p5xaW/GNahnqQASTA52EUlpqCnuObvmarDJyTB6Ax7/tgv7Gu07RNOLv4zBmpXm2G6t5TerqrZdZqNZAR7lNcmyHT4sVbY9JVWWwvZ0n/ZG/7qbMuBEVSkH2tXp6T7JxeRMtHx2Lx1FWyDMLVo5p7c/Kl9nzDE2UpORryL4n9N0A38+WLPUaHEcwDKna6pIA/7dOC92dndTjWL+R/NOS0oasG5EJJXzmBiVt0a4geQJ5g2STwKCRF26Do+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Narya/d34ScpTYkmaYm5VN6iS3nKl4BiJc4befASK9k=;
 b=hb05EGVQsN3nSCwiyRqxWyU/PCpLdsqUNRN7QJ79ADOpm9EeMsHTVI0N6QQosfkujoZCaBIJ3FsbN47u7JsyJZvxxs6l4A4LvmN479pUGpixqIKXbg4fLET6vzq1/q+aY5FK14cCGVtoR5bSB+U0CHAvg9+uABNU2dY8Am8KEgr0SmDsNSmPZIhwYeEchpr5BVwQISXFroplEWJDEPQHCxbAFnHbgjO/q4+YEwAQgC07G0b95Pq0EwoBYVTwLikXlaiE5E0QfsoNXHShDbaaI3bEg212723iCb+yMQ5iynFsNrWSQRkG7BPSHnmHljTJ64IyffVAGsKcEFFrKfxAEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PPF04DCE520E.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 17:54:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:54:25 +0000
Message-ID: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
Date: Fri, 20 Mar 2026 13:54:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
References: <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
 <ab1u-AuqIbJakUYW@tardis.local>
 <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <ab18cUI_4jKA8wcA@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <ab18cUI_4jKA8wcA@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: e0206288-2f5c-49bf-4a63-08de86a9b933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	848ojUSgjMzqgucUWsInz0Bc6tuxuUv1strSoFTJDJhtYn4aqHr5lbBk42wXwWFhqjlFLnEU4GPFm3LQq+ascnPylwVZa+f0nov4uNoD1bdoIJhHzwqXrPlkDBtG3XbumfhtWW7OD7giRenawaeqrfBsvfhgrwgB+CgVEV8McxW7P0Z8jdgP76fB5bOEcyZMymD35HFruRghQDdahN0ptZXMCFvDxBEu7xTKSTIVVcZt/79oS2ll7ARgT47HoqLt+OEoHMMKX+FFuSBMn4EXG8vZcH+Gbe/IP8paP3ljButElRVRBYQKSwBw05XM/7hIAZNdj4KLnPe2EyJ/N0xBOZq6jgxNcCFVQ2Rsd+XV+AiAmTHs4JLsIQVdCkitB9sGlTJ4VKAuItWd6N5cLgVnCLuRuSeV2gUmbaWUPVJc1MVdWzHj8OdKfNOMa72qcIQ9bhqHIfbCg39IpjmXUth/NIuvm81sDJiNAvy6vBs15eD5rediaHlx4piWoG80NF/XN6kxRZ6NloxWpRJAwxfCbJ3ZWQSsw7G8bxTdPT3sVJeyl2BDYc891+/fx/ItVyREtUyxA3M7aJpHyWkc5TPrcFriPdnJdJfd7bRiT2TBc89PaH26w9ryb8d2HzWWFWVGEI0ehdXRvPs+XpDgLNSfQm60zP9oSaabIb4TDBVCz0D1xTJ4Ynvj7b8tE8RCSbd3Gf5a16NCcKbeLyMPuV322m5qH1nkE86FUYe4fIGEpmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWY3cEppSHFmekdEallUTmhOazQxOCtKaW50QTU5cHN5bFUwS2dnR0xUOEdx?=
 =?utf-8?B?WnJQSTZkS21yU0ZaTDdJaHowdmhPcVVNMDNpU25BRzRDVStvZ3R0NXVGQkNY?=
 =?utf-8?B?dlBaYWNRNWdlcDAvN1JPbGpYem50Uis3Y3JOUklmL0Q4QktyY1ZWVkd5S0JR?=
 =?utf-8?B?WTJoUVpJdlU1RWRuaThWVHp6NHNtMmVnOU0vMjZ6SlBseWFPeTc4Q0pzQk1Y?=
 =?utf-8?B?dXh5aWhRUDNJZFlVVnUvanVkb0Qrc2dOcHVpYXdtbC90YnZONlFUSGo4a1Z2?=
 =?utf-8?B?bWJkcVRPMlpYUDYxSTlmSnlOYjI2bkN3cW5jU3ppeUZPaFR5Q01sV2FORFVz?=
 =?utf-8?B?MEdyUGU3aEZueDMvQ21JMkxrR3VNcGREM29yRFlLVUV3QUVYUnplRGsxWjlF?=
 =?utf-8?B?OTZSMThjUXU0cms4ck5BUXV0cWgrOUg2SVhyT3FoM0dUMlNacktDNG1CR05x?=
 =?utf-8?B?S0VxSzFSTnVRTHpiazdzWHdVUWhBbmxaVm1LZWNkMHFBUjZnS1NkaTkwNWVP?=
 =?utf-8?B?OHY1cnNDU0hETmxidTl0M2g4NmJBdTA3OFBKQkVEUDVncDRLU2o2Y2hVREdX?=
 =?utf-8?B?QS9ya0lCRjVkR1NxS01GYlA4V3RJR2pYdjNTSmlna0Fxd2ZnM3JQY0dhRTdj?=
 =?utf-8?B?aXc0SW1ReTErYWN4Vm9maU1sTG9NcEY3MGRzVmtsTUVYbzZjR0tvZVY4Nm95?=
 =?utf-8?B?VlJDQ2huUWNpN0duaFVjVlhSTGgycGt1U1hZRDdLYm1TdC91YnJtMDhxT0xl?=
 =?utf-8?B?N28wNmcydVE4SHJLRHFhVHhpZ3UzekVQR1VsOEhqY3JJTHo4Tmk5LzFHazVw?=
 =?utf-8?B?R2ovWHJEbVdTNmJuSUxJNjd0MFhaaUNlZGcyZmxOazlGbXhCT21IcCtFT1lI?=
 =?utf-8?B?S3N0bjJ6Y29TQWhVWjNybURUM3FCYjZmYmpYU0tGclhtSUEwRmlTSFRPNlFm?=
 =?utf-8?B?Z2lNVDdYWGFKSVRia2UvY29kRkg2cWZGSEoybGRKZUlSWXZlT0l2Wm0xVWF5?=
 =?utf-8?B?ZU11TWw5VGN6aFREY1dadE1zSHBzcnl4bFVKcW9wTm1PQ0dsQUVjaEJPT1hN?=
 =?utf-8?B?ZTltSXdkdk9hZHNUZGFldFJ3RmJ2T0gxUWRpQkRGRmVFYmxQQzc0NllpOXky?=
 =?utf-8?B?Mzc0VEt2Wjd0U0ZRM1Zvd2ZQUjc5Wnk1d21yYXE0T2pPdVVITWE5VHcrUTF4?=
 =?utf-8?B?d0pqcklxcDQ3NExGcTdSMkR0N3JtdHVkb2IwS0ZKNW9VVU51R09SQThWYzdt?=
 =?utf-8?B?V2pIeDlTSTZacEVCUHYyWDR5eGMyamVIZWk4TFVvRVhKdVB6TkxJU3ljMklm?=
 =?utf-8?B?RzVKcEs0NjR3SzJ6WXU5N1c1YlllUC82QU1zNDZVd2tBRnA4QTA1UHEwdGpq?=
 =?utf-8?B?OE5RTjZkOVZQVTdmZ1ovNUl3WVkvWDNhRENwVXhteGZNekhQdFFWNFZWMkcv?=
 =?utf-8?B?dWJUWi8xZ0FqNXdPT29zZ3Vjb0t5OENBL1MxenNuU1RFL2Z5VlY5TEZMcmRJ?=
 =?utf-8?B?bUNNQzRrQ2ROUjMxbFdzc1k2YzVEMEkzbE5nV1hpRmZLNndEQnp3RHQyaDRl?=
 =?utf-8?B?TUFlNi9ldXJ1OTk4cVNPenovVlpDd0pTTnpVL2w3K0I3UHFiUnpyWTRsS0lW?=
 =?utf-8?B?V1lYV3U0WGdtWm1kMmVpL3F5Q1FMTFlxdkk1WXVhSmJ6S1pnMWJrQmE1WlRW?=
 =?utf-8?B?anBvWGttZENWYlhwb09ZWXowRGllN2l6MTFVYUZVcmJLYTRHVjNlZC9PNjdl?=
 =?utf-8?B?cklGc2ZGUUFqMkpGUjZkWTRZL2tTZ0FuZythbWFMWnBTc0xnandLRjVLQTNX?=
 =?utf-8?B?dUkvRXAweURoNFpuS1gzN0M0aGZBRkJncEYrT0JBM0JIUWpNNVcxRkMxNzFn?=
 =?utf-8?B?QVBZYmw2K1NUWGpIWU5wdVNCdU9ZRzZqVjNSdXcwWGtwUVJvZE9FM1dhMTFq?=
 =?utf-8?B?Z3YwQ2VWUC90VlVyZG5ySWlJcDJ2WVpkRnQyMVhXLzBHUm1QcWxhZ0VIamd6?=
 =?utf-8?B?TkhOdm5sY0ViZHpXQnpWTDZqd0dsZ1BCRzJJOC92b3NpUGtmeE5tcGZ0RXky?=
 =?utf-8?B?STAza1RWS2pmbW1ITzc2dnFhcUlZQVhLcjVFRzRROThkSzhZUktvT2RXSExS?=
 =?utf-8?B?Y3JjL3V5Q1d2V2ZaSUtMeFErUWRnSVErRWluNVRuNFBxSTBDK2hIT2xYTVVa?=
 =?utf-8?B?anYzZjhtVUE1clQ2S3lvWHY3eXBIcFFLL2w0dEhkM2NRQ0dhK1NTUWxHUUNI?=
 =?utf-8?B?VE4zNEhxWVRDU3dEWk5CSlM4UG5td3B3Rk1tSm5GckoyaEorUElCd3pZa1Z0?=
 =?utf-8?B?MUZkSjUzTjllOTQ1WGo2emYwSjczM0lQVUREZmI0U2pMUlJ3QWhkUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0206288-2f5c-49bf-4a63-08de86a9b933
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 17:54:25.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws1SD/ZtXDNZPV7k3QUGO5np9T8X2a9kgAjkhNjk1SSGNXxj2IIiuRIOcRZjNtq1j127tuXq5pzFAPzt7Og+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E



On 3/20/2026 12:57 PM, Boqun Feng wrote:
> 
>>>> So we really do need to make some variant of call_srcu() that deals
>>>> with this.
>>>>
>>>> We do have some options.  First, we could make call_srcu() deal with it
>>>> directly, or second, we could create something like call_srcu_lockless()
>>>> or call_srcu_nolock() or whatever that can safely be invoked from any
>>>> context, including NMI handlers, and that invokes call_srcu() directly
>>>> when it determines that it is safe to do so.  The advantage of the second
>>>> approach is that it avoids incurring the overhead of checking in the
>>>> common case.
>>> Within the RCU scope, I prefer the second option.
>> Works for me!
>>
>> Would you guys like to implement this, or would you prefer that I do so?
>>
> I feel I don't have cycles for it soon, I have a big backlog (including
> making preempt_count 64bit on 64bit x86). But I will send the fix in the
> current call_srcu() for v7.0 and work with Joel to get into Linus' tree.

Boqun, I get a splat as below with your irq_work patch on rcutorture:

Maybe the srcu_get_delay call needs:

      raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
      delay = srcu_get_delay(ssp);
      raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);

can you check?

[    0.459781] ------------[ cut here ]------------
[    0.460401] WARNING: kernel/rcu/srcutree.c:681 at srcu_get_delay+0xb4/0xd0,
CPU#0: swapper/0/1
[    0.460751] Modules linked in:
[    0.460751] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
7.0.0-rc3-00020-gc18a9e13ce7f #96 PREEMPTLAZY
[    0.460751] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1
04/01/2014
[    0.460751] RIP: 0010:srcu_get_delay+0xb4/0xd0
[    0.460751] Code: 00 00 00 5b 5d 48 39 d0 48 0f 47 c2 e9 45 b0 0b 01 48 89 fd
be ff ff ff ff 48 8d bb d0 00 00 00 e8 e1 86 0a 01 85 c0 75 0d 90 <0f> 0b 90 48
8b 55 40 e9 57 ff ff ff 48 8b 55 40 e9 4e ff ff ff 0f
[    0.460751] RSP: 0000:ffffb4ba80003f80 EFLAGS: 00010046
[    0.460751] RAX: 0000000000000000 RBX: ffffffffac1604c0 RCX: 0000000000000001
[    0.460751] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffffac160590
[    0.460751] RBP: ffffffffac160460 R08: 0000000000000000 R09: 0000000000000000
[    0.460751] R10: 0000000000000000 R11: ffffb4ba80003ff8 R12: 0000000000000023
[    0.460751] R13: ffff9de181214b00 R14: 0000000000000000 R15: 0000000000000000
[    0.460751] FS:  0000000000000000(0000) GS:ffff9de1f2799000(0000)
knlGS:0000000000000000
[    0.460751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.460751] CR2: ffff9de18ddda000 CR3: 000000000c64e000 CR4: 00000000000006f0
[    0.460751] Call Trace:
[    0.460751]  <IRQ>
[    0.460751]  srcu_irq_work+0x11/0x40
[    0.460751]  irq_work_single+0x42/0x90
[    0.460751]  irq_work_run_list+0x26/0x40
[    0.460751]  irq_work_run+0x18/0x30
[    0.460751]  __sysvec_irq_work+0x30/0x180
[    0.460751]  sysvec_irq_work+0x6a/0x80
[    0.460751]  </IRQ>
[    0.460751]  <TASK>
[    0.460751]  asm_sysvec_irq_work+0x1a/0x20
[    0.460751] RIP: 0010:_raw_spin_unlock_irqrestore+0x34/0x50
[    0.460751] Code: c7 18 53 48 89 f3 48 8b 74 24 10 e8 e6 58 f1 fe 48 89 ef e8
2e 92 f1 fe 80 e7 02 74 06 e8 e4 c0 00 ff fb 65 ff 0d fc 63 66 01 <74> 07 5b 5d
c3 cc cc cc cc e8 7e 03 df fe 5b 5d e9 57 1b 00 00 0f
[    0.460751] RSP: 0000:ffffb4ba80013d50 EFLAGS: 00000286
[    0.460751] RAX: 0000000000001c8b RBX: 0000000000000297 RCX: 0000000000000000
[    0.460751] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab614c2c
[    0.460751] RBP: ffffffffac160578 R08: 0000000000000001 R09: 0000000000000000
[    0.460751] R10: 0000000000000001 R11: 0000000000000000 R12: fffffffffffffe74
[    0.460751] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[    0.460751]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[    0.460751]  srcu_gp_start_if_needed+0x354/0x530
[    0.460751]  __synchronize_srcu+0xcc/0x180
[    0.460751]  ? __pfx_wakeme_after_rcu+0x10/0x10
[    0.460751]  ? synchronize_srcu+0x3f/0x170
[    0.460751]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
[    0.460751]  rcu_init_tasks_generic+0x104/0x150
[    0.460751]  do_one_initcall+0x59/0x2e0
[    0.460751]  ? _printk+0x56/0x70
[    0.460751]  kernel_init_freeable+0x227/0x440
[    0.460751]  ? __pfx_kernel_init+0x10/0x10
[    0.460751]  kernel_init+0x15/0x1c0
[    0.460751]  ret_from_fork+0x2ac/0x330
[    0.460751]  ? __pfx_kernel_init+0x10/0x10
[    0.460751]  ret_from_fork_asm+0x1a/0x30
[    0.460751]  </TASK>

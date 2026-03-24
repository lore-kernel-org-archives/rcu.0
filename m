Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF23B5306;
	Tue, 24 Mar 2026 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377648; cv=fail; b=O3C+6rb2igZUr804vuHflZP5NyggjwZiapqs0yZ05+nWpW8gdIY92rMWxEik4n5Vo4IpscAPhijWdpB125JPizOjVVsiD1aayNK7+KrULOeFA5DSzFuA1O2NYYNgdHxjpMJtakAfrwKIpbMgYwt5d9pqE0aw0pk7wTVR6A5sIKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377648; c=relaxed/simple;
	bh=zNgn86UvFLCeMQpKqMxsPSSdufYn16fQ4V9EH3j5/zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXDjLgYbPlB+ofYG+F8OqVPyD4ngTGVM7Xq2hpkPxliiQqa53tdRudpRVtidnVMaIE30hcMlYMPhq1RLMeNm5nI8iPZinBeNDKkJBXWk/x7Rr9igxro4cn6Qs1S4vXUczoUXsYKJPIP8Xz5NSYeo+HyptqZg/aj0wn4iO0p/REE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gndf691d; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gndf691d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE4mxDPbSRwGNpMXDd9JwwFeziJleYv6Rvc9K94Dgi/Yf9/b+vkX2TNs3TG9zqva93Z1wXMGdtlurvzuGAX3bww6tj1cwHo4pfy/F6Ey7rdTTEVJddqFJH+KWyqDU5eMJWCPOZIGtmoYz7RsJYe4arR52cX3q+cpScTwIequM+B6We//OCh8IMNQNLBNHHpJvuR17XnnqDEWW4YrGR9bWmoGgcqSqjRKztALPcW+ibVZPn4suwOnUaizt1YHdDJw3YtO0kOqGcrZUc75TlVbLCQtKf6OHQvxWy77PQ1fEO00VdGDqqL5exwSoBeeEpKiwCYkyClwvk+bYPCniZsQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9c3ztnUcuzB/Asyujqgu+Hj0rYnC1CLRxYWOe4jbyE=;
 b=ukohnPutArdYwNJfE5fIncW2s8gTfN/2ZGXdEaO/eTGiepdAFnlvPZNgGCA+QVA9qOiy1QFJpPvzmiBs3RZ7x8FwWU6dbrqIof3C6ObCwwaVWe1kphwyip83S2GUoiNrtGsdCWbTscP4iYxgHpR83Zux9+cYEYx93EhGSI8eS9IwHGp+d7tdqjMyVQ8iap2rwLkh9GLYx4hDsh9G4h7wWz9TECrvNTUS43hvuEjq7hiWG7FF4ZOgV+uGrCkNt4OcSzWrDOG0K/qm8NahRphWuL7nFMUWqsPljBopYTcAJ+fx5CbQzrnCpZQB9ntkf98WxALAdgFNXClDb7v8aXVKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9c3ztnUcuzB/Asyujqgu+Hj0rYnC1CLRxYWOe4jbyE=;
 b=gndf691dGh/ylfa5LZSBdlvb+H/Bkh5tzOHkmOVoRjkRfcVoimvaQR1f+0n6Dyg1k4owz7/Vv7dF+rRxvhmG26DEiZGlFHU4fJScKOtlRkqdbXUZXRgX+5kBRFwIUFBtmmfVOEuUrmC9nFRzgMolF3Nwl9jh5Wb79ov9glG57+HVfsUGopvwUigv/iJNdYzsxuw20X+0D30ZoqCHqDsWvvyohDC9vgSYxtLD0G9ZQ7K5pe7yqqoPjdtupNr6a2fLqRtSLsxOgTA1rFjVwKrhXvXshu58AFqyeKq3w9ZGUKjdGF4bXFZ/N40NEHwV+iSJyoYYKPD6YFg4zKT+RuuqVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 18:40:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:40:38 +0000
Message-ID: <177c042a-b05e-48eb-8824-113fa98f573d@nvidia.com>
Date: Tue, 24 Mar 2026 14:40:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
To: Boqun Feng <boqun@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Neeraj upadhyay <neeraj.iitr10@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <acJ1HRXomQhbTN4_@localhost.localdomain>
 <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>
 <acLLiKc5Ax586EuO@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <acLLiKc5Ax586EuO@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:930:8::35) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b756a73-89ad-46e7-29df-08de89d4d7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o2a5BiCNljXXQurnvOfyK0yu8/gr903b3sgebuwFDDeBVAi50Jvpu7bNlnpgOQ1Gwrr5CX3sd02gHnnOswgLqhDhEoxgt1q3yYhWdmdqiuqNJqqqScfQXx1sBeZcLiRYo7IZHJwTL5TV9CxJ0QgMOJyVYJJrBbO0VsdpMlc8yO13ZoxgoNyz+i/kSrg9SdD5sVJyng7xfqnC/XVUxHuUKQwAXLTElkX005qAw+OMEx80qBMPgNF7/qthhTHHI7aFwdUoAPpTLES5AcgOrvl0LKVtRXqjX3RAjOvXOnAJ6hqf6hFy+B3mLroHxwbxhURYay/ien2zC6MyrNdcCGp5nyABe5pw2fkpKsLoE5kCT5QSGPoE4feB7z7PW2X/JQGg7LQ5OpUzCmUltnkCld57XpVdp8VVvix3uUjgy5aOKeww8dvLNF0vqdo0SsHKALhDLEpW9DOa1cwm4NGvPy/twG+UFf+qKIhSSo9CLKsfGMc7DNwwdWSXQgGjQLAgN9qWAU5XDmUaXkNU8rE7ovNSvHKaBGxpoREWPYFlnZBLaIu8f7sdKkKWCSHf5V1tG3DZNV5VvhYNd40aY+YJFyGZQ/WsVErU8FLnjrsoPukz0ao1DxGoYSjkzTINBX8cH9ICRXnOv9n91BRDBiwJcEVN5TDfXXxbISUukJn/HBxxy7EZzfX+UiMI677WzH7QaB5HxWPz5vbcB2hNWcW2WKjxD2j7/72jSMioFsXo+DMKeI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkFjKzQ4NG9GMjBheWRuR0pKbWtMcUNrajJSKzdkeFo0MVFxUWNPTTcybU1H?=
 =?utf-8?B?Q2ZwTEFhWWJCb2lkUlA3OER5R2RXc2h6NERKWkpiNndzOHZRU213em96RUwy?=
 =?utf-8?B?Y203KzI1dHJsL3Uwd3ZaKytuTi9pMGxGTWVHQnYrT0JsWXl1K1BMWmtpeFhh?=
 =?utf-8?B?SThsaFNFMGxxcXcvcUczSmd3aG1YYmFJaDRYSGE1UGQ1V3F1Q1hhVStvMTBz?=
 =?utf-8?B?TGt0WWlvV0FBNHJ3SU5wa0RldW9QcmdOWDgyQjVXZWhWanFSejVtdDRXcURE?=
 =?utf-8?B?YWhRYkhGbXdZK0VoL0RNV0haU0V2clFMSUpPNzF4TEZyRGJkemtDNjZKVWNp?=
 =?utf-8?B?RGRzQWF4MVNIN0N3ZjVqalFaLysrRE5jQ1hMS3BOVkVKb3BZSWVGKzkzeWRp?=
 =?utf-8?B?NnQ4QWlyaGljSnoza1hISXozTTQ3ZXZhQ1g2Zjhmc1M0RW5nRkdlL0ExaEtE?=
 =?utf-8?B?VmlUOEtIZXJsTWhrZWNrRnRmUTZMVVQ2MkRmU01MYWs3ektvdklSY1ExSnZt?=
 =?utf-8?B?QytEYllWbHVCMTFsVDExRUlIK0RDMlpSMUdBb09rOFcwaDVORGlGWGpDWGx1?=
 =?utf-8?B?cXg1ZHUxT1VuQzloS3kyMXZzMU9TRmN2UEhMVFRzMGxNSVVhblBNVTkrLyt2?=
 =?utf-8?B?R0lzQ1NZOFhJMjdkMEFGTHNZOEdZMy9LR3lhSzZLaWxTdk5NbSsrdE9pQkxt?=
 =?utf-8?B?ZmtsaTdVekoweFVmbXdaWHJvRVFYUlFXcVZNZG1uMHg4OXZBN3gvL2tMWG8r?=
 =?utf-8?B?aEFVdFdkcEhQa2Ztb2hyTzdNWHJxYmlYcG5rNG9CbUdKbWFkMlNQMXJMSE41?=
 =?utf-8?B?RnBVQzNwM25ZSG9ZOWdlOVdxL3FMYkdRYU5SNndBbzNNUXUzS29vcklKMUJC?=
 =?utf-8?B?ZWdJeGlYUUhDbk91ZElIQmhBYzRxMGRhRklJNk9YMURXclA2RHBBa2M3a0NW?=
 =?utf-8?B?VHNnMHhhWWhFQ1BSZlFWbDFYV0Q1WnI1dUUzL3ZhTk1UOEh0Q1Y5b0l2UlJ1?=
 =?utf-8?B?SU9aT3pJOTlnNTJSMjY5YXV6YmsrNjF2cjFEdDFvTXVUU2hSb01QcGRVSzZC?=
 =?utf-8?B?TmZwMGVnODY5R09mTkZXcGV6S0x0MHFoSENhRzFyWWRad2RmaW5vTWFqdm82?=
 =?utf-8?B?TUtxcHhZTHNqT1dOQ0NFTmVCbFJrV3ZwMTk0QTBRdzJlM2YyMVMwaUdYZHlR?=
 =?utf-8?B?NjI3QVZLQ3V0VlV4UERrK2ErYzZKaHhVOGlGeE1GSUgvaFdSM1hQTk5keXc2?=
 =?utf-8?B?TFE2T0c2aWoyUnZ6MjlhekljRytSb214YnBWU2FybGNERnp5SkxwRVFjV0xp?=
 =?utf-8?B?RzYxMTVqNnNPQXkzSHhrbkQwWURCNGJ4ZnJIY3dJeDBoYnhhbU9Fa0QwWmpl?=
 =?utf-8?B?TUpVSzVIL0htUmNMa2gzY3pyOUtyeGVuMVlJWmdZdFd0M2E2ZHJkOVlTT1Qy?=
 =?utf-8?B?Y0YvNFBiYitQS0Nia3Q0SnpSY0h0a1NhT3pkRDFGN3BXMmU5aTZiRFI4bnZS?=
 =?utf-8?B?YnE3SGpHWklIRDhlenBNK1NWM2U5YlpLWGtoUDRTV0ZlTThTVWRSTDByWitj?=
 =?utf-8?B?N2IyMFdscXlwRlJiN2xvWm1ya21CWmZNSXBJLzdHYnNtajdCL09wUmVnSlRp?=
 =?utf-8?B?RmE1TndnU093dFhsVkF6Sk9nRTNIYWhGM05GWjh3Y21SNFFtbnJlSXNHQ3BU?=
 =?utf-8?B?UjdNM0FCOExtdTBWcDY0K3FTdmpFYzhKVFp3SUxyUXZWYUFxZ05RaHdEbTho?=
 =?utf-8?B?YzN4ZnhZaE5NSHU2emIvTUZKTENUeWM4TmJQZExrckt4eGd2R1UzL3dUQVVj?=
 =?utf-8?B?THRydEVvZTA3dDVLL0xBRHdxWlNVRFlQQ1N5aWFMditjeUpGbU8vcVRRaE1I?=
 =?utf-8?B?MnRrM3VtdXFsUmxhdFRWdmtlRW84ZUV6UWljTkU2NEF6VkR5OHFQdFFVYTBk?=
 =?utf-8?B?YmxFOFdsMlZJZVpWaUhnQll1d1hOalNudExmNWQxMDk0M3ZhTUZhOHFBSXc3?=
 =?utf-8?B?QUpPaU5KZCt6YWJMbmkySjhaUjF4Qk94V0lXRDNuZE1PMDlieENqMXJwQ2x5?=
 =?utf-8?B?RTkwdGxUUUZSanJRRE5uVUtkTmVtWDJSN216cU9LVzE2eW9KQ2IwcXhIdkNZ?=
 =?utf-8?B?dVcyaGlhS2tpSVpzRmUzbjNDUnUvTVpxcWZWUEdQVWtiODVOdm5tVFVKNVdN?=
 =?utf-8?B?NG1RYW5rT3YvSUdiQXFKYzVyZVBzY0pDbXgyRWp2cUxHbmNnUG5FOHpSNU13?=
 =?utf-8?B?eENaSURKTUJXWGc0aDRhYk9XUUZzUENrcytUWTk0bmlqQ0tOZ3VtcGU1TjdC?=
 =?utf-8?B?OStQekovYjZodHdKT09xVjk4Ym1qa21HWGdIVG5Fbjk1Z1lmb296dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b756a73-89ad-46e7-29df-08de89d4d7d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:40:38.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlFoEE7Cz8F71aZ7w0xC2vwX2S16lmGGpPHx8YExoOrKZbIE/r1R53rVG3xFEemcofumpuf5IRfKsoHWXDNrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717



On 3/24/2026 1:36 PM, Boqun Feng wrote:
> On Tue, Mar 24, 2026 at 07:56:44AM -0700, Alexei Starovoitov wrote:
>> On Tue, Mar 24, 2026 at 4:27 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>>>
>>> Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a écrit :
>>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
>>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
>>>> happen basically everywhere (including where a scheduler lock is held),
>>>> call_srcu() now needs to avoid acquiring scheduler lock because
>>>> otherwise it could cause deadlock [1]. Fix this by following what the
>>>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
>>>> the work to start process_srcu().
>>>>
>>>> [boqun: Apply Joel's feedback]
>>>> [boqun: Apply Andrea's test feedback]
>>>>
>>>> Reported-by: Andrea Righi <arighi@nvidia.com>
>>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
>>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
>>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>>>> Tested-by: Andrea Righi <arighi@nvidia.com>
>>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>>>
>>> I have the feeling that this problem should be solved at the BPF
>>> level. Tracepoints can fire at any time, in that sense they are like NMIs,
>>> and NMIs shouldn't acquire locks, let alone call call_rcu_*()
>>>
>>> BPF should arrange for delaying such operations to more appropriate contexts.
>>>
>>> I understand this is a regression trigerred by an RCU change but to me it
>>> rather reveals a hidden design issue rather than an API breakage.
>>
>> You all are still missing that rcu_tasks_trace was developed
>> exclusively for bpf with bpf requirements.
> 
> I'm missing this for sure. But what would be a better design?
> 
> BPF is also calling normal RCU (via call_rcu()) as well, and I don't
> think we can say normal call_rcu() was designed exclusively for BPF.
> Plus BPF heavily uses irq_work to avoid deadlocks but irq_work_queue()
> itself has a tracepoint in it (trace_ipi_send_cpu()), so in theory you
> could hit a deadlock there too.
> 
>> Then srcu_fast was introduced and then it looked like that
>> task_trace can be replaced with srcu_fast and that's where the problems
>> discovered. So either task_trace need to be resurrected
>> or srcu_fast needs to be fixed.
>> Let's punt to bpf subsystem isn't an option.
> 
> I don't think we are suggesting that, i.e. "BPF should fix its own
> issue", at least myself was hoping that we can redesign the APIs that
> BPF relies on and make it clear that it's for BPF and we can in theory
> avoid all the deadlocks (we will probably have to make some primitives
> non-traceable) and BPF can use it combined with other general
> synchronization primitives.
> 
> The current approach seems to me that we just whack-a-mole when an issue
> happens, and it's not a systematic solution.
> 
> (It doesn't have to be a problem, it could be an opportunity ;-))

The advantage of the "whack-a-mole" approach is perhaps totally benign BPF
usecases (non-tracing related even) where not using irq_work might be just
ok seems to be a win (no self-IPIs pointless, other irq_work overhead, low
latency). Probably for the best trade-offs, we need to probably deal with
it on a case-by-case basis that irq-work'ing everything randomly (?). That
said, I'm not seeing like 20 reports or something of this so perhaps for
now "case by case" is winning.

One argument could be BPF is supposed to be SAFE so anything it does like
map operations that relies on kernel APIs that take locks etc, should be
probably be done with a lot of care and extra precautions... simply because
you can insert a BPF program at any tracepoint.

Not sure where the line is, BPF is kind of an interesting usecase as in it
wants to be powerful (run in kernel context) but also be safe/verified at
the same time.

my 2 c, thanks,

--
Joel Fernandes


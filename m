Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793150009;
	b=Lw6dcSa91dY6uaiQ4I5ZwzxZ92FJ9cLS/sn/RFfcITbvijwKYv45dvi9UfdBtYI+yOMy
	 JMxizPmf+rozjWVcPMA/1WctCABQNgth4yV8LLzzss0XlptyA8xdBRYWmZT734s608dcy
	 4REqe1T/3idPDWcWg+p3EtMbKFPQJ7qG+61eND5ehlxPE1YJPhivX7YSAmwSmJSeDOWrX
	 LnP5+yRGG58tWp6K4LcnLba9yWJi7CwrKEQfywa9vCvz9MD7GfcfcOw+QbdKZzkP6wGTS
	 76KCHuXFrZ5eQCF8x5khTNiKk+XaHpmfeYBuVnllZWjtPeAsHONb1j26h8rOEKrKOLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150009;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U7kYcdMvpcd+3FTaKs0FxIPKZn834tJ44FXw7xrdjX8=;
	b=zMom8TL/JBnMY0b4cAlDrUAqLH96MVBuLSlGjq4rS4HK0Qh9qn/Zk0k7pB2TcIZkKOTJ
	 UetldLLYGJW5Uc1tBDe+U9jhghVqr1brV2oVmWcCcZxsogJ1fQ8TA/UwfweaIz/+T/bh3
	 DKwqf+R/oN6Fz+Sbdt6ui6RazOtaD1l9lvym4/pmvtC8t3aGLjVn3mJtePE8HNEf8PidG
	 mh8N8nc1JFE4d7wQKR6lfNgn2vKs6FR2mkWfU1npXdHR2GFv3xjPER7vWt5B9s+kBzNM/
	 X3yrxjEXqWNL2T6FLIMO+CR4bX9hmU5na8rlo+9P9k6p6GDU6yy5WSnFx8zI/TuAbYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.91
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020091.outbound.protection.outlook.com [52.101.189.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104F606A31A;
	Wed, 28 Oct 2026 01:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F104F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUOFrR7aZjCb5fxyFtyezz4X/3nsMqM0Pt4yX2qSJyvMb+CpbbutiU196f4wA8C84+yBM0kVC4T5tt8COM+jW5t7ZCLYUnaAJR+ygU0dZ5L5cRIDe9L+Ygc9ijMnw0srcKTAh5oQTWogNi8clBZy9sNB63Qo0fw9XhHGHXfcn/lXx6bvs4x9zR4sfM3NLxnB3wu/qYO3dOM5/ZpAuO7IeZ1P8hldahm0Vof/qGbjqJ8gKFIXqSVD4lHlVoh5PApB3tUAlgH5L9DVCkzigoTJEGHPFlaSNj8QHQE/5w/SUdS/D44xkL6UhuSAXLUghJUwvQvMXE8QqzrP0Rpqn4WciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7kYcdMvpcd+3FTaKs0FxIPKZn834tJ44FXw7xrdjX8=;
 b=uuoe5UPi7d+VlCMZRS8UJMOPqPmaEZ/NMtVgQ/9XpJt/0y8pWLnd0/y2hi0eh5uCxLGoHu4wCGo0W3318ryBA/WxYIDzrzPrI3FvU0WRd4a0M7VN+SRsimdHmkCWEp8wtcy52ML8QvQAsrirylYCyVWujbw1hFHq+uuMLdcDIuOLZow/jC6hTJkWEPDgdx5a1bRn9Dcl3cKfzM5eA/C4l008TqF3+kgkHFe7kmHuBP701zV3iwXw44A9YmfPjivA74SW/Hc6VbtfjSE1eLLsgP/GPrvtkH08kRM3Tn1nqnDwZoqC4KMd1voesTPSOuL4kdsChyn0BndNAtgjojvpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7kYcdMvpcd+3FTaKs0FxIPKZn834tJ44FXw7xrdjX8=;
 b=l9mu2wW6BPW4NO1MFrUzgLjAL0VZwx5Zn9nveZexq3cKF4CEYzU52vUt4Tm75dZS6Ux2FPbIJ+mrYRudqbEHd/Mg94Tvaybg31Bk4Ii87Br+nAwbpfSTKtGWQscpWzvgdWUK81hplZ1WVazMvUiIqhs3gGBHM2zn1lgb/xWE78fwSu2l5Z+uFvHediVALJXFARz+BeSiAHTMDNGBLg63NsE1VdX5J3gJ15S56HrSf2/Hj7qsK+HtLL1qO6SunhmnEX+NfQjkw87+blWDK1sb5bJ6MCGyeAllf05MTJeTpWh52G7mMtswxYngLBqdP9+7ZSEGlrprWsXOoI77lem5Lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB552502.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:d6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 01:13:25 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 01:13:24 +0000
Message-ID: <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
Date: Tue, 27 Oct 2026 21:13:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
Content-Language: en-US
In-Reply-To: <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB552502:EE_
X-MS-Office365-Filtering-Correlation-Id: 56284bbd-3ef5-42d1-e198-08df3490aa50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10070799003|7416014|4143699003|56012099006|261026140227099003|261026121527099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sdZs+bqf10BJE30WNTPQuN1BmRhDgIh9sr/yjFI0xRMEA7NmLl78KXEQ58OW/ms4/GReDCiwhjM4hh8hJfF1SwDXTHYh3tvxDq0pupUxgEN0ZMbE12lVvu33emP4jXz36Nk6yztH6mQ1642T+B78ft8nhtLLfBCAW+yS796TuPL0TPlW+fF9+y+qavZTwwoWQySH2N7qLDOiBXsyBjKN8GHmLQ0BG18lSUno0GlRVwW2lKpVRfjbFA6pwTtZl7qaX8tClj3ZhfxxRGvYUjssQhqiA1QED1lp+i00qQXQKt3ssrgbpGdqmy+OCTbvmKwp9PnxLoDe/KdTOkvFn6DuzSAUQaTPMR6A9fOWAazYgeYqwOtlzeyd5ADHpkW7CQI/dpbTsYsQwdEN+ER9UtJI/DqfATURE6E9iAAYLop2RjBe90D7Tsxuxd+cpwHj5wz56I3GiLMI0GJkwQd6IHf//urY3S8wfX+eDvEHqihiAB6QIGaYwu6IEiCAY79l4KGxYRn7G+Ao+Igy3BQT6+J7yucpX8FXIJXkj6Qm8Kd+3ITBkmEUST1g1gQ82DYm1rSQE0EY34vaB9vp28TwKzE6l443pHVETN1wUyq+pCj2onE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(7416014)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmU3ZmJ1UHUxU09FRllMQlI5eE0rNW9CMTd2M1FGT2FHQ0xoN2U3SE11NkMy?=
 =?utf-8?B?K2xVRVp4ZzVUY2tFVnB2YWRqemtEbjNsOStjbFdmbDdyYXZqZWR0bzZsbXV2?=
 =?utf-8?B?UG5SaTI4SU0zMEJpMno2MWkybzBuR2paUTNVc1ZzVHZPemJRODV6SmRVSFZa?=
 =?utf-8?B?UERuOE9ZYitGZW1IVFQ5YVJNZTRaSTRsdkVkNzhLaVA3TGlobXNZbHVJZVZQ?=
 =?utf-8?B?c3lZZEJnbkJXMWFIZkhUNnhLemJBcVYvYmtGT1NtTHVKREZqL1Y2ZVp2bHpF?=
 =?utf-8?B?WWd1M1FKYlkvYUd5K1ZQbGszbkcvNjVvemM3c2hVcFJ1WHlDWURWUndHblFv?=
 =?utf-8?B?bnlsT1cyVytTV1R2UCtzSnRET1NIMlgzQ1libDA5WC9EbDczUU9TNk0vKzRm?=
 =?utf-8?B?aFB1RGF1NXE5emUvRjRCOC9iRkVPUjVYa1FjM2lIYkZzZHNlMmhJcEN4Ny8w?=
 =?utf-8?B?YXdTTkF1V2t4ZnliWTFWVC84VUd2eERiRkFxYlFBeElIL1Z2UzlWR25kZEhI?=
 =?utf-8?B?a2NLRkFFUjY3aEhod3VISmRQenRtSDBRbUo1OUJ3TjBVT3V0YmVodDF3d2w4?=
 =?utf-8?B?Qk5qNFNUNzAvdGUrSC91OU9XU2czakF6NlFPNUFZN09MRE5peTdjL0c1WjhD?=
 =?utf-8?B?MTFBbDdETlVuSU9neFJtK0I1SHhZc2NJeHJvMSthS043QmhmSTNGZ2ZzN1pC?=
 =?utf-8?B?c21YYnVzLzlCTmJpUUJQa29YT1FYRTdqbkFSRTRPMmplclRJT0V6d1EvLzI4?=
 =?utf-8?B?TEc0d2RMTWdjSEpXeWdiNkdjdDJhL1BPUmJtQjBUWjZIUFVFRWFkYjFxNUNn?=
 =?utf-8?B?RFpvVElUYjZTOWhWdEZZT3ZMWjlnTDNRZGRkSDlmZUNUVE5rWG40YzJlb2hZ?=
 =?utf-8?B?cjRVUnlsa09HUnpTRUNFUWhNeVhlWHFjYTJ4QmJqUVI1YlhweFZzRUZFRStH?=
 =?utf-8?B?VHZsb2FtcjFuSHk1bzVINUNXUDRDZE8wUUxLQ3Bwei9hYm5iTnpjVDVVdWFo?=
 =?utf-8?B?d2U3WDg4NnIvTGN1MFZKWHc3VndvMWE5SXB4cnhGVGZpVUFSN3B6V2hScHdw?=
 =?utf-8?B?YXlPYmRIS3YxbHdwb2lXNVBoN3pJbUc0b1RXcVVKNk52UDVRa3BjQjV0VFJG?=
 =?utf-8?B?dTA5YTltVjA5SnIyS05MeDMxOHEzK2dROWdLdWJaTG1zNC9aNnYxa2F5NnRQ?=
 =?utf-8?B?ei91dVh0RnF5dnpMcklRV1kxWlFGOUQ4bkl6WG4rNExzVXJDMGlsZHhFS1c2?=
 =?utf-8?B?K21xN2s3RjdmSUs2dEhYM1ZMdkNaZ2c0UWQ5cUlaT25OK0xORTB3NVN6MFdB?=
 =?utf-8?B?VFI0RXNBb1dveU1POTJaSm1GZGx2UGtGc1hUb1ZvUzBoVHhyZFBJR1Q3TGxG?=
 =?utf-8?B?ZHFYd0FYWFpxbTBFSlZYN2hkNzhsRm4rcXJ0QUVMYmorL0FhRjN5dkdmRzQy?=
 =?utf-8?B?K3ZLRUFONnlRMGNDLy9JZVRlVm8zVzBNSzBzaW5FSTU5QUFJaDlsQUd1dGdO?=
 =?utf-8?B?cnF4V1kzODg5MS9FY2hVbmtrVHRqR2FpeE9mbVpBWW9NbDFaOEhmQ1hEZG1J?=
 =?utf-8?B?cnMyakd6Zm93WHFtVFlBdHRjQkk0UW1XUk5TQ2hFa0hmTXAzaTZ0dHk4VU5Q?=
 =?utf-8?B?TmNBUmR0VkdSU0RzT2JJWk80S25BREYvVG5JeEFHVjdKWWVJaUhKS3lVUitF?=
 =?utf-8?B?c2QxcXBOTVJRdDYvVmxoa0J5aXZPRHJnUE1rdmVrUUpLTXdJcXFOWWpuWW9m?=
 =?utf-8?B?dGE5alN0K0xyL3RVdVl5ZXNYQ2l0cUpRMCtLU20rUHc5ZUEvM0syajgwdmk3?=
 =?utf-8?B?Um9ZWGlpdFJ1V2R1NXRCazlqbWNSczMveVJwMWpKUVhwM3llNjhGK0ErTjFZ?=
 =?utf-8?B?eEJaRjBjUWwxTkgydTlDTi94OWlDemNOSEtJbEl1NWZiM1RIZytkM1ZuM0Vi?=
 =?utf-8?B?T1ViUnlEeVpwa1FjdWFJbXlDQWJTa0Yxa1phaEszNlc1ajR3WWZnWjlxUzMz?=
 =?utf-8?B?REtBYlgyeGNXaFBkc1hEaUFicTRXU2wxbXdBQVNZUDl4R1pmNGxGN1ZjOXF1?=
 =?utf-8?B?QWVoUTNMRjVpRlhLaXMyWEUyT1E4dnJ0b1BEZmZaUGJJT3ppRWt3NTNVeWdQ?=
 =?utf-8?B?OHkyN2xGOExhUEVlN3pBS1VnZG5OVldJUHdxNHpwUXRnRVFHVHpZSit1R05p?=
 =?utf-8?B?Qkt3WnRVaVQ0a3hkUlNxd0s2UzMvYURETXIzOWR4VloxN3ZXbmh1YVB1M0o1?=
 =?utf-8?B?TGpiVHJoTWk1bHFHeHRpLzdCNEtZZmxtL2k5dmd2U2huaUZrZ3c5RXNlSXhi?=
 =?utf-8?B?OWJtU0g0Y1FkaVlmTUROMFNWdkVzRThoOHk0a2dNVHdxV2xYQzQ0UVQ2MXFz?=
 =?utf-8?Q?b33/Kgzc2RW//WgGtuo1cgBuBPH+IQgdb17veEy8k2R3V?=
X-MS-Exchange-AntiSpam-MessageData-1: MK0fK5JafS+StxeMWLHZupeXMVVqSstDy9Y=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56284bbd-3ef5-42d1-e198-08df3490aa50
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:13:24.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tXdGTMUNBTrkpfadz99PklqyaZSfYNarSyOFpn0AVLgyx5I/3y2D7/RTopFS4bG42l4AXQC9H5GPAfd5gScXYzXRIpZUZv2Ypml33h8byA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB552502

On 2026-10-27 15:57, Mathieu Desnoyers wrote:
[...]
> 
> E) Use a preallocated per-cpu rcu-txn slab, synchronize txn descriptor reclaim with
>     RCU (steady state) and hazard pointers (OOM)
> 
> This is basically just pushing idea (D) further to remove the need for sleepable callers.
> We surround the rcu txn proxy pointer resolve with both a RCU read-side critical section
> and a hazard pointer slab address guard, thus protecting the use of the txn descriptor
> with two types of critical sections. The resolve would run with interrupts disabled.
> The "resolve" path of txn proxy is not a fast path, so we don't mind the extra overhead
> too much.
> 
> On the "remove" side, we typically have plenty of preallocated rcu-txn from the slab.
> In the common case, we keep using RCU deferral to free the rcu-txn in batches. This
> would implement a custom per-cpu pending list to enable the following "stealing"
> scheme.
> 
> In the rare cases where a user empties the slab, we move to a more aggressive
> mechanism based on synchronize_hazptr: we "steal" the batched in-flight RCU txn
> reclaims so we can fast-track their reclaim after a hazptr synchronize. This would
> all be using busy-wait and the only contexts we'd wait against have irqs disabled.
> 
> The motivation for handling the steady-state with RCU is throughput (no synchronize_hazptr
> on the typical "remove" case). Hazard pointers then handle the OOM corner case without
> requiring sleepable callers.

Well it turns out that this approach has potential, but the hazard pointer
machinery is way overkill for this. We can replace my use of hazptr above by
a very simple RCU domain with the following characteristics:

- All RCU txn proxy resolves are RCU readers running with irqoff, protected by a
   per-cpu counter (incremented on read lock and again on unlock),
- There is at most one reader per cpu at any time,
- We use a synchronize RCU on that domain on OOM for the pending slab reclaim
   "steal" to do reclaim synchronously. This domain's synchronize RCU waits for
   each CPU until it observes either an even counter or a counter transition.
- We disable preemption across rcu txn (e.g. list insert, remove).

So we'd keep using call_rcu to handle the steady-state reclaim of rcu txn,
but use this specialized irqoff RCU domain for the empty slab case.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

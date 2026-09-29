Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020093.outbound.protection.outlook.com [52.101.191.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C53515EB;
	Tue, 29 Sep 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696571; cv=fail; b=FLEtJDCz0dDy5c3t+c2M4fSuwkd/VdgctDL81Yee9HbmwXj1Z0Gt8IPqQEydTJPD/lIi78AV8XBNBnAwoH8q/ReZ6VB5qFqfi7N0R6THaHN3G9HCaEi3EA8hdG8GnFK6q+Wo5+bpL5FKV4O9EcG9HLzK/L6TW7C0cG1u4AjBsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696571; c=relaxed/simple;
	bh=kQtd4NM5YGAVSLcQNoexSmIDLgko4qaYXtr6vnA5DDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNDhpYMoyw1RgnksOJK3DtKDIp0hxT4kfGkZq/94DLQhkX4PTQ1HzDiTRSlyuPSNYyXUUrQflFoC4LkFKgxquilxgl96spPpsZs8lC8a0dpyfWBKZmyM/qlVIPe2OiswjD5cyrTYIw4oXNAJiOoNl8/WvRfShec+zSmqeCCB5jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BJAhbuYa; arc=fail smtp.client-ip=52.101.191.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BJAhbuYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdvEEnHKAsp7eEYPTrI3rETlJwYdC/jifM08Z4rRIQwTwstaIiLIa/ty8ETfOxGSfF6btdK5wEy8IFmVDTWdcyeVXAZi7/hYT4Inw2kADWOVBvKnrxnBnJ78kJq+8imhHEZpZ+Aeeo8k29gdWTWf+rCZt2GZjj3ICLKCX6mkvLl9r3+2fqZdmLwba5+KzHjeUhaWNVn9EXR7BeRt+rF71s953chz3YrSCV4M7KRNgBT4fp8KlbPXtIcH2ysOlumbzR7+OyCr3odTVQm4IcMaStkgOSlN7I657lPG1V2z4Z0hmFxjon8zaxnyGHkSANqwj8NqB93gny7tezvRndYhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC/U1LK3fB0NRovELjkcJdZ/E0d5pUUAOefJqICWYNk=;
 b=q4V7KyFqxiCB6wLqeBkdnVCPzXowDNQ7YHoI3MvooG0jBZu8swr1Wqc+VCaS42FCbw1+dJhKbTtDKP5DEhtxU6BBM8DCNDm7n3r46gFOEASkkf6gbkH2AYskcYKm6RcxU5HOHw13ILn2xi7wQi64PrzPJQ4CP849LUU9q9O6oJelvCrguyTAqaDRjSi57BfK33MHZ4kPYDV35/Q/cta+u8LtEDby3LRBu5EEgY67NNMil4lguBx3VSBwuWe9ZKdElyjuF34jZhaMUoBzpGaO4921OTroZvz+b1ya14EVeVUF7oyqYItF9RCziSVn7MIa9B3PmnX3luFxKboYF4wSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC/U1LK3fB0NRovELjkcJdZ/E0d5pUUAOefJqICWYNk=;
 b=BJAhbuYaRuBpyfbVWst6Kn1lB66H410s7sz2Q4CiGASSEYd27jBXumYxQQnwpMp7LM2sORWZgM6fjxFklQMI2u2EhT75Qea/tGTTLq2ydEmsUywAN5L6SSdA/H+7d/9C1wPZzx6IA4+OZzYZxCG/gpHdV50bk0pQ/4IgoXgy5sjlLFz/Ecs0iVHsRWlwt9+UZCfjxgvWLmRoiFFnB0ylyUV8N1cT7xYyLvkHyand5Hccx9cH5m0alifliflm54dfBanpg9SA4hhuU5OstuTEkwxdL0+sUU5xbTyThJ0PcuMWdHXcWminDf1wc/SH7ypm4HzfK5iG3MGgyVOcJ3PuEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR01MB10534.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:71::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 15:42:43 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 15:42:42 +0000
Message-ID: <5a695b14-d25d-4c11-87f4-83c8d299d79f@efficios.com>
Date: Tue, 29 Sep 2026 11:42:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 2/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
 Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-3-mathieu.desnoyers@efficios.com>
 <CAHk-=wgQyCdrWH3ZuSajOxZqiups6jYbPtqY8JR8OeS7yi49Mg@mail.gmail.com>
 <133ca8de-cf30-4bf5-9539-d0b73e347b22@efficios.com>
 <CAHk-=wi7BkCuzMe_zWi6KHUs09UQWJpCVNvuFg5wh_CAu5dgow@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wi7BkCuzMe_zWi6KHUs09UQWJpCVNvuFg5wh_CAu5dgow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR01MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: e9648738-b104-437e-47b1-08df1e404cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|4143699003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Al4ACkzm0A+vCt6IhpyO48bwJc2EW/DPOkWyrV+sK6D5CLM73OHTJlIw3eQDGgEaoQlLc4egcnmvK0sB7eSmphZNZZLxsPbA+M8j9YBBQqp8wqILkbV58GT6tgOkG9Fz8DhP12BWlEMrR9Zp2I1tWFqtYeZ6WS39aPpz5FvfB5YLb8Oz87TzTYOoYuxXo6JXvuDwq0dHT9ujS6eetVlEl2aureJntJ0EdZNeuWKmQ8ZbD7IEdRCTxBBI7pa0fLwse06g6uiH+sTvcpR8st/yJuXCMoZpXHzRkUyC/Og+7IdsA27hAXkmwzfOUZ0fPPIhspZkIhOl2J+YZf2iLxv3YGd2hd9KVO1URqY8rTyqHo+UWgSgNFKhpruLDWTjJInILbN1lG09hnT+5Sn1jPZyk0S0RnpR3EyOC+vvhL/EF2rxLVmbLifDALKqr4zFestBWNnHgsMlxloKbzDftOTrFSAvsTBErlEiSz2BrCHIwMuJhkpmxP/NI+komwf6QfePKl2/XURtvGsDYwxOQwHwghB+GqoUzlVyR+wDifsa3+pDbFHXVYtLE/wUMaTw3M2GmOUtawpxglt8EmRJsBfQGz0U5y2Zn03pixHLpHfWBuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCsrUWduUjZ5WFIyNWVtbndndDV6WGRFS1VFNWpteW5Ec1pNNmNjdFZ4TjJ3?=
 =?utf-8?B?Vmk1ZSt1OE9IQnJSZ0RJdjF5NEc2RGhHbGxqQ00vdUJZUjhaS1poUnhFRUht?=
 =?utf-8?B?RHF0Qjc2NWRCcjNEdU1tUk42ZXdkbFg4cXQxd0xrZDB6dmVKNVgxRU1xZm9L?=
 =?utf-8?B?U1JMc29jMlV2ZjBkdlZwNWFkVFdGRFBzNWJzak5tZE55ZVdNY211RFozYkI3?=
 =?utf-8?B?T0RLdFlxRU51VExlcWJWS1N4QWoyTHRZdVluM2NTQ3pjU296L0tma0RoM3U3?=
 =?utf-8?B?WUVycjR0SEEzTFRRazZRbmtNaFJDMldPZEFoSVd0eTFielN5ZlNYeThxVGR6?=
 =?utf-8?B?ZmZ3UmcwWTNwTmRZT1FwSllnT0JTejNqNkxvTm5VZW1hejlMdEtPbUpiMzdv?=
 =?utf-8?B?SDJONDRHN3kxcWZ3a0p0d2xEMWcwNnFpbnZtSjZyUk9BSGNCQ0F1bUZzdnFy?=
 =?utf-8?B?bUVtK1lVRFFqNjk2cFhXNDRQc2twRDhidGh2Zm9OcFNsOXR3TlBPV01GNlRx?=
 =?utf-8?B?UVkvU3dLOW9yRENjOTRqVEFrdUNCT2oxWERCcjFDV2doQm9KTW5iZ085S3Ro?=
 =?utf-8?B?RVBiRU00VTVCK1Z2aVVrYVJZWHVBdi9RMzBnM3Z3K1FVTHA0czFuTks3dDhS?=
 =?utf-8?B?aG5ybVZRVjdHM3V6eWs0bXZxR1hSWDlHZXFZUjVyczVvblIyM3g0RDUyMTk5?=
 =?utf-8?B?Tmdxc1NMUjhvZW5ha1NTK2tidFIwYWZSVVJXQklaVEx3U2V4ZXQ0QjVZQUto?=
 =?utf-8?B?Y3I0dGt0a1g1ancrVVdjOFNQdm9SYzQrT3dXbXBhYUFYcG1vY2dKTkliK3Jt?=
 =?utf-8?B?RDcwY09nRFpYalNvOWVEMXh3LzlwSkFaTi91NXFNODEwZ1BHdHd0VGFiUU01?=
 =?utf-8?B?TUI2UHFDeGJxSDBnL3BIU2lNK05xR3BpRXoyczVRU05sajBLZE9KaWp5Y0cw?=
 =?utf-8?B?NUlFa3hRU2U2aThSWEVRQlFsVHdZa0o0V3hWaTg3MkFRWUkwaWc3NSsxS3ZE?=
 =?utf-8?B?Y2QwaHlKZDhtRU9OVkpjVmtQN2VVNEEzRXM3WmoyL1V0RFZHbGF6Rzdya1V0?=
 =?utf-8?B?ellHZVFEcDFWangwTFRLRktlQjlJN0hvWlRINEUzOURGbEY2M3JoY0tKb09S?=
 =?utf-8?B?U09FOGxVa2V3MDZBcmZYQ252S1NsdER4OXVhSTkyanZDb2ozWll4Q3czcFNC?=
 =?utf-8?B?QkdBTmZUNEZlczNyRHV1OHlKbzFPQnVTTXhBbU5kb3lpcm9sekhMTGtxWnkw?=
 =?utf-8?B?MkpkT3I5b2xCWDVtODR3eWY0ZjloQUNOTElqYXRJczA5d3FGMlg2dzhBNUNM?=
 =?utf-8?B?SjN2YXNrUmZQQ2psbnVNRUZLTlo5WE0zcTYwU3l4UmU5RHo1SmxYQjA1Mjk3?=
 =?utf-8?B?VzZBNm5JWXltSmhpUytvem5GSFpVQ1JZZ1pzVTdUT2NqTjVNbU14RnpNbXpW?=
 =?utf-8?B?eElxSnh1S003RHJuWGNrNkFUQjdjd0hpMFFwTFdqU2hLU0V5WHdyQWJuVE5C?=
 =?utf-8?B?c05rd1lwdXFReVk4RUNlbkJJMS9EeU1KWmlJKzNqWmlQNkFVOU9xSUwxVm50?=
 =?utf-8?B?ZFFwZUxuWHNMNHQ1UWlOTmVGdGNxWWVxeDYzU0FTejgwZ0FWR1pReGk0a1g4?=
 =?utf-8?B?S2hIZ2lkeTY0eExEeCtDSUNYaERxM2I5cXhIbVpJMDdSZTRiSVNsRlpjQW8v?=
 =?utf-8?B?TDZsSmhLMDMwa2tQMVJsS29BVjRuS2Fod3g4VVJKUzluSDk5K2UrcWZJbEYv?=
 =?utf-8?B?MTdyTVBTUW41L3FFUitQTWxkK01BdnJ4WFFZK0ZRb0lXQ1V2TVZ2OTRDU2Ra?=
 =?utf-8?B?WHNTbjJSOHJUd3phTmFPN2tOUHdSUy9yUXNld0NhZTdVYXBkK0trM1pMYmYw?=
 =?utf-8?B?Nll6MnhGaGtTSy9Qb0RzRkFPZFIvbTM3VzFMVUlEbGY5R3NTRHlpZU4xajdq?=
 =?utf-8?B?Yi9RNStoaW1MVU0rckxicmlYVFZrZEdrOXVwZnFVSnlKNUFzNy9VQlNRK1FF?=
 =?utf-8?B?WlE2V3RIa1kyMVc3azJjZ2wrSUtUZmRwM3A4MjVUQWdXNlY4eHlPUEtzOU1W?=
 =?utf-8?B?dE4zWkNTclh5OEFJc211TzUvNWNtRmYxZnpwRlVWanNQeGhNSytWK3VxVW5R?=
 =?utf-8?B?QzdHOTJ0QTRCNGNkZ1d4MFlWTExVKzBidlNQcnhxM0VHQUZPWjFxZmw0ZGNw?=
 =?utf-8?B?bGw0bWZEeTdxK1VPRG5aV250TEpzNExOTllCdk94bEprVWZjV2g0N3Q2Rndj?=
 =?utf-8?B?Vk9pZG9BZWVzNHZXNVVxQjBYcDRnSnFPcmNuV0pvUG5GSFFsSWJZcDB5S2dF?=
 =?utf-8?B?dTIxRUovb1BYelcvSC9HWXVrcTlCeGdoS0JKempUeFJJMFlLVXIybXNpUzhS?=
 =?utf-8?Q?kaddFx7LjBMmZXWc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9648738-b104-437e-47b1-08df1e404cee
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:42:42.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJxgPl7F0SJRJHxX5Tlc9zUuG6JXk6EgfErhjsGYy+YWp4X2FbpQRREPjlHO1p68jWTnuIWEm2qg9/qE87/trEt7aSvyvfoAtHKY7JQJV0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10534

On 2026-09-29 11:16, Linus Torvalds wrote:
> On Tue, 29 Sept 2026 at 08:04, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> I agree that doing it in asm would generate better code. Also, I've
>> been told that clang now preserves the address dependency in this
>> scenario, so perhaps we'd want to use preprocessor conditionals to
>> select how to implement ptr_eq based on:
>>
>> - architecture (allowing asm implementation overrides),
>> - compiler (e.g. if compiler is clang >= version X, just do a plain
>>     comparison). Likewise for gcc if it ever decides to fix this
>>     behavior.
>>
>> I think this "hide var" hack is a fallback which can be used as a
>> starting point, and then we can specialize based on architecture and
>> compiler.
>>
>> Or do you prefer this in a different order ?
> 
> Oh, if there's some sane way to tell that the compiler already honors
> address dependencies, then that should be done first and the whole
> thing should just become a simple
> 
>   (a) == (b)
> 
> for that situation - allowing the compiler then the freedom to do
> whatever (which can involve not using a register at all, but a compare
> to memory, or whatever - the compiler might have reasons to avoid the
> 'cmp' and use another sequence entirely)

For the records, here is the relevant compiler discussion:

https://github.com/llvm/llvm-project/issues/34577

and it seems like they still have unfixed scenarios,
which may or may not affect the hazptr use-case:

https://github.com/llvm/llvm-project/issues/220206

Considering this, I would not be inclined to jump to the conclusion
that using the compiler compare for hazptr acquire load/test/reload
is safe today without a careful analysis.

> 
> Then a "if we have an architecture fallback".
> 
> And then that OPTIMIZER_HIDE_VAR() thing as a last fallback.

OK,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

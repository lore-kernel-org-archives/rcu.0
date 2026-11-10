Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323667;
	b=VDW5pU68UQMUEdk2c1/cH4zwQk+M+jfHAKEY1Qp7j3wMRHld6hQzQgD4aDT/QEKjmsMQ
	 EdWCTIIgmLb4vOrXm2LyqxYFMQnHum7HkLtgcG0M5DvuGjDhA5VDqNvtOI/9Fwx87LYYb
	 ClN4rap5R9kr1UmOKgte/tHLiBCt8xtJ+UgP3FLBW5E49YYNWjEhJNJq1npc2Egahzg1Q
	 etp5rAwyc8IL3Vs47KoHotNShlSI3AyoUKYgQg17ULW3AuKvmmoEDNgfQLSJmug2O8Ckt
	 vIp2CbuVxQX0wOFdz+GL7OtCUSR9xRqHDyYWkPi20N2D8QJDVJ3BH2cgjIsxXRXq8Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323667;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9BjMOpFcwxGi9DMOzYedbDoMJBY4pnhfUt++EtUQHyg=;
	b=jHG2xVyy51BCZ67czi9TpouSmzZ+iuzMrYVc/BQNa5wHmWMPtDbg+1mSFtrtrQXkWRHf
	 zqNi9i+ePRrNLwyTQtBS6GF0DpbDwOFxZmGv3IUVNrusNtu1zpMUGG/pYe4BLTnFhAB/b
	 z7PBQB1BfgFnUWL19zpp5VZN23zJ0lNsJmmLcFMEaTCUDQhBvVTV1davFu695Nf6vkp6Y
	 0l0tKYFGZOHOXpqP0eInrFxByrUKjuBcMT5ta9q7yBgTb2Cnkue4cXnlHpNeoXYRPU/Uf
	 wvSt9/2O5XIO74sb1PwMMLh++oOFHNT8i5JkG4gB8ZkXtLJeAprMX8u8j6ZkvovBkWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=RbQiqRSt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020073.outbound.protection.outlook.com [52.101.191.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0A606A323;
	Tue, 10 Nov 2026 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC0A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=RbQiqRSt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSHwm/6gtyhbO4AB6mkovHFJEZTmN+7qVHVAo9/a/0/t95ShHFenwNbGDW9Qs1fGcDyZo4so9iderit+o26UMATgsgqnayF6MK67a1dukj/xFCq4biryXd59/nLlcOxhSiijwOuJqPnT4d1qsxdm+vGGSwfz4avxoxe9etV5PqW35/uNwG6SjHUTmK7JAHdhb/Eh3tP48yIOhcG9Ej7VYP6SpH2nR30cYYaCIwvYU55DtEHsAzhYXbxJOvaG/JWFk16c8YVMZBQ7D9mWWVeAWZP+mdha55flYusAaSvoDrFLfzU0tuBD+YMcgryIxuUWdd+9Ua7/xIs1ApIy5hvq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BjMOpFcwxGi9DMOzYedbDoMJBY4pnhfUt++EtUQHyg=;
 b=d0U4YDPWvwcf5lyWpTYnZOtYqHLUfBxHqnfuMaoCSBWc1zqYg2qVNwp1+A4SFkYAAF39y4ubv82/UD7whzaTsMwnFETP/t6k9HvOpWuX6tB0XcrxYs/kUFC62c0imIO0OlLagAZZtjgpO3X9XWvbXfH5QPI5tsyM3l8fd/WSWZTU9rQTE2hUgssTmw00UEbJDPGPDVMWO3fomIqUy++dDw3vlCpy8WR3C04m8IT+mkZrPch2uLdCW1JLcLuV8JeIvSQNdNcX9Iv33he/dpjJCga2HICJCwSTj1Z0XIdCjL7V00N+qINoWSXTJMpaN2CWh5vfckBAXygzTCO6LoFTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BjMOpFcwxGi9DMOzYedbDoMJBY4pnhfUt++EtUQHyg=;
 b=RbQiqRStjPet0DZzawmSKIP9IQTWGDPlwsgKHXKozXjKQ0CgorTlZZRKnnW0TYs+NP2tgX6+76PoSmM4k0gKrADPHrbDLrKAdG9xdLmXRKMuODTiPnnL97Ctwv3Pc5mjKOOk8Mp/l89UIa/XwN2l65V0j49nxY3o1pdCHs0WRGCng186B0BG8Fs6apy5dVTbvngi8oqtfre6i+dgNu1vTmLX4l0jrazEzP+BYMvfphfvKYso560RdMvNj+xVZhLkN3UW0Jo2Je1YAQqAlLJmXQus6t4ALilIZivKrBHVTvEVwhfZ/UFFWwp0lDYmrw0SCJlkFa5sVUiAb50j0Df7Nw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB215679.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:19a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:14:26 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:14:25 +0000
Message-ID: <715ae7da-19e6-4017-8701-8977500a6d5d@efficios.com>
Date: Tue, 10 Nov 2026 10:14:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/12] samples: Add a cache on RCU pseudo-transactions
 with a lock per node
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
 <20261016133319.433617-13-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-8-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-8-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB215679:EE_
X-MS-Office365-Filtering-Correlation-Id: b44290a0-2f26-4f64-e340-08df3f3d4ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|56012099006|22082099003|18002099003|10067099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	PNgV4Ki1aTp9ZgRVrJSvH5oqUUrQavxyJm1pWnHDBeMZpD0mODHC3MqWA6KgyVr463Xt34+oMREJGI32eyN0Zm2EbKF4krqEfvKzD0DB52+DVuEDaHphkbR3dKGYShp/mKjSQzGkcSyowcy1Rjipap266VAniKqBJe2Hw/aKubUBO6XvMFVSmHWVCBNGmhGkcBHO7/yUbVRkYXgth4Kk3JLt9OWEedUibsen6ssQBmRa8e+1zOxLr+sjihFdCT4vSo5XAUZMaV/SKifkTlNYyOMb3yx9b4QM9/+StdItbqu8sybOWfWmiHuupJcBA1RAqSlTRAJzM1jc9XPHAXj0XVkhT9n0PV+avEvUi5O85HQpNfMZLWqUUFBVTlVj8+GVnyDCYrlIMW7Xbd+qLEEgbsBrjdh01khBdLITEpv2XOl56LqWZq59pkfAkJnYXGqB9Q9u1nN7987Ivv0QZqNnntwVZMvbWHQHbC9neal1abv5StNHJdFB2qdUfOXC9laRPifi2ofDn3wpuGPbSfyD4JrwtYt/VTSvUb04tLHeL2ms0/DqgEJG/9WZPxAM5uOkR3FCYtCwqaVpvTqZGlWWWUgbtzk101VqHtfgFPzOqTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRHQ0FaVDg4THVqc2hSZy9NK0oxVE9FSG9ENVlXZ0F1cWFleEc4a0R5cjRw?=
 =?utf-8?B?N3MwRVp3YW9QYmpOYXFkWVBGeko5U2svdVZwMmN3UXJMTUJhY1RLNE42UkNK?=
 =?utf-8?B?WXlmSExXbGRNZGVzc0VGajBtOTBoOGpuaDlBUmI2SkhnTUs4THZ5YUhZYm1q?=
 =?utf-8?B?ZlVVSU5JckdpWUpidS9WL25VcWRkbGtHbmtEWExBNGNESzQ2YSs4dk9NRlVv?=
 =?utf-8?B?RXo4bVlrdm9WZG51MnNBdWNpTWpCRjdnc2FTL2NWY1lHUlhVaEVnVXFrSFJ5?=
 =?utf-8?B?UTdPR3RNaHNSNWpCc2tXWTNVVDhyS3Byb2Y4Q1RzdXNkUGRqK1FFN3IrSTdi?=
 =?utf-8?B?M1p4Yy9kWE1EczVhcVZ5bmhKVWc5QjFKT3ZrUUk5d1JUY2dVVWRONmFaeXVQ?=
 =?utf-8?B?cDdVUGZuVXVkaUxlNlNVQXhGY3RqNUxKYmN4VTVCUmM2U05WWWhuU05jL1la?=
 =?utf-8?B?UWE1d3FYVzI0V00xa0hSZnNoNEJmaXB3QkNvaS9RNU1HSEJ0Qnd3MzJ1WW1x?=
 =?utf-8?B?TEFjVzdBclR5OThVZ1JiVHRtQy9vcjJmZ3VMTW9jZ1ZmbElRNExhcTBFdWlQ?=
 =?utf-8?B?YklxaEtFbGYySHJWM1dPdjQ5dGk2S2lWcE9MUW5qS0p2OUdrb2xjOHVWdzdF?=
 =?utf-8?B?cTVUSzZJaHhZaVpXOTBPaVVIbE9sTjVhS2Z2Y3FROHN1QmZMbG8rOXdOaDEx?=
 =?utf-8?B?cjk1eEtHUkNneEtGY3A2OVZLNGJ2U1JRMFRDVmpUR0liSGFJZUZISkdUSmhM?=
 =?utf-8?B?cjVwdk9jVnM4N0cvaVRYZVpPL1pHeFBpL1F0WVhSS21nUXkwNjRPSFdkaWpB?=
 =?utf-8?B?eE1URHNCUUVOaXpDZ3BYT0hua0UrMkd0QzhyMmZZd0I2cXJCV0dIMkhYMlY1?=
 =?utf-8?B?RitiVUx6YXlZeFJ5OWEwRmpwSTUvUHFleDQrZFRwRTVzVFFPazNaSUw2Q0Rp?=
 =?utf-8?B?cU1UTUFKZ1R5ejZONC9UNTdGZ3NncVNDaC9rV2xNdllkMGJBbXg2OGJKeDIv?=
 =?utf-8?B?VGlzdFdXRzhuV0tvRDJzYTZMUWhQTndZRittcko5cnByUk1oM04xc0l5RllT?=
 =?utf-8?B?SFpHNjlDeUtENkhOYnp2K1gzaHhvdCs1eHE4Z24zZU1qZEs5UU03MTFtRE9o?=
 =?utf-8?B?T3Yya3lxM2ZYTFQ1ZFJTWFIzWjZxZUI2ZUNCZEJFYkljVnpFc21mN3hLQ2x6?=
 =?utf-8?B?Q25JdzdaQWhtYjdLdUNrdUUzVDJNTUtmYW1OT3cwY2szMlZDSTJFTDY0VkNO?=
 =?utf-8?B?V3NkVlhWMVo5YWVobVhDR1RnRWFwajNoNHRGVHRqWlVVWUZtVU5PMExac0to?=
 =?utf-8?B?N1Z3YjVVV3YvU3hBSy9VekdlQlRlQWNwbGN3Yld2c0p5dW41WVVmRHFGNTkr?=
 =?utf-8?B?QVZYRGVwTnV1TDMyaE9yZGVsRXllZUFPVkNLQytJZU4rM3o5cGVFUVh3M2xG?=
 =?utf-8?B?VUNTN3N3UUNvdGxyNS9ZOU5pNS9xRDV2cXlyUXhvQ2M5eWZFbGxOU0p6MjRq?=
 =?utf-8?B?bklCQTRSQlNSejNQcU5jclVtbnV4dmFBSXhFV0JmdzBoM0FQcVBJM0lvS20x?=
 =?utf-8?B?ZDVYdzlkU1R4NFd2MnZ3WVRxblJUOXVERk1EU0lqM3VKeG5ya3N2WHpRL1VX?=
 =?utf-8?B?WkRXem5tU0pjRlk2bC9GaE9PNUNCcURsV3hWT2ZaellhQWlnODFUMVBUcHRM?=
 =?utf-8?B?eVRwWUlmYXczL3FzcUJYaHJXNzhLZy9KZnNaSG9hRnhkeThWR0VpVGs1eE9I?=
 =?utf-8?B?VjJ1YVNiMjljVGR2ZVptSktHd29aNVdudDkyYktmakR3dHdVMSs5YUg0MTI0?=
 =?utf-8?B?VENZbnBlam5BSUpBTG5WME82UFhLRzdrWFJVYzhocnhNYXkxMTdBVjZCdUZM?=
 =?utf-8?B?UmJrVXNheVBxaXdYeEVyaThtTjVWSGxjUjFhUTBHbVpuR2pIcUN5djcyN3NE?=
 =?utf-8?B?Y20rVVpmTWtGRmZrT3R1YlphYkpnN0pVUmpCdWdoWkFCT1JzS0c1SnFDdWVI?=
 =?utf-8?B?aGNoNEd1Y0RGaDlIb3VmYjF1WkowSXpBb0ltSnRlZ2JIVnVlM1dqc1VCNlBi?=
 =?utf-8?B?VGdpeS82Smw0dU1LNEFlN09SZEFQKzVZZnovYytiejEyQkExNVdYRUV1ZlpY?=
 =?utf-8?B?MlNBT3FwTHZwZW1RK3ZHd1dXVkdwYk9wRFBsbFEra0NSUjV5QUlDcVJjcUs3?=
 =?utf-8?B?ZCsrU2NHRk1tekNhUEJGbkJpdm9wbXd6OFgzWmtqekJCd0k5cnY4SnhyZVBk?=
 =?utf-8?B?cjU2NjJtR0FCVzlTMUFHMHZTTTNwSEhEZCtBNDl1RDVWM2dsQ2oxQ2dSbXY0?=
 =?utf-8?B?OS9WRnRwYlphbVZSNEY0R21xYUhRREx2SlZxeWxuL3pKVXBVendvWW9VZmNq?=
 =?utf-8?Q?JjbbWMptbQz70zj8ICiRxEq50VB9oFboDiQnn?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44290a0-2f26-4f64-e340-08df3f3d4ede
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:14:25.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw92s0c2OoaKgmuU58wquPb7BuOqrSfd5UeXecis6UI6Sri7pqpnQomYWYk/faeYCx+O4/ZHUUkAWC1+83U+q9+rSeTHcUAgFOTRIyDVLUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB215679

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> I think there's an eviction race here.  cache_lock_entry() re-plans
> from e's current links, but doesn't check that e is still the tail.
[...]
> Checking p->next == &cache_lru.head.node for
> evictions would close it, but then cache_lock_entry() has to return
> false when the check fails rather than retry, or the writer spins until
> e is back at the tail.

Yes, this is a race. The next version will add a CACHE_EVICT mode to
cache_lock_entry(). It checks that the entry is still the tail, and
returns false when it is not. The writer then reads the new tail.

[...]
> Nit: an allocation failure in cache_unlink() or cache_link() also ends
> up here, so it's counted as a lost race as well as a failure.

A fix is planned for the next version. Link and unlink will return an
errno. An allocation failure will be counted in nr_nomem only.

> Two more small things, which apply to the mutex sample in patch 11 as
> well: a bad lookup (nr_bad) prints the same "the hash table and the list
> disagree" as a cache_check() failure, and a kthread_run() failure is
> skipped silently, so a run in which no thread started reports no error.

Fixes are planned for the next version, in both samples. A bad lookup
will have its own message. A thread that fails to start will fail the
module load.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

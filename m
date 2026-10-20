Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523480;
	b=pqm4YJzlOrDAAiudWdRTCrznZHAUZSTALw6Zu/exw4n+NZy9VH22NJu6aNSQsFoTPY4/
	 edKLwN9o9EKBPXMX9NaeTMnOjMLN+ax9n37hxwpkmMRIw1XAcjih1uts/ZhtJp47pe4kp
	 cUCCweJVzf6Up0jzZZ8CAYf2uPCiWdB45c9ipEdTvfnL2BMJfJwJ7p01rHAFLq1awllgG
	 ZUPejUXvW8+mi6/i5bOPiGEX4tcbLiLaJScJ0hfMo/9yHQJ7ZpcU1xIFnu0ljzqzRnfxN
	 ZPqlLAeiVikqdrvB+ZHO2qsCLlnjdKzzh0Ppw1u30Wz0USlps3rjUA5idFRX2n3+BZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523480;
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
	bh=t33Y0nOrNqRmsedIeFJU52K4SHEO1Sh7k3v2A8kNejw=;
	b=RSt8J4KY66kbx2iJ7hZrp2XNGt16Xms0CXXBPuj988wnTP/26NtO5fLhnR6WolABo9p2
	 J0JfCTepJK7mvD7W20dQuGj98B7/EtNfYzRsjONGHEiGrK6SMaSRM0l23XPs0Vc2caRmV
	 ZB3iVAUpHp9trDlbrKp1UEpmTj/ZcPUsoF6rRkhqQgNeUPO8satxuMIIONhEV2QRvJC+4
	 Egf07ivXkbwQDqOKgfFHAVY0wwk6rNuEGYUEFG75RlE3ou6fgKi1hVLPOOcbh7ah7aHkX
	 uIhEHY8Cn8hK+9kq+ryXN2yqS/qQcgRZWMSy4qLwdTnEh0Hn/0WcZ1k6KAeEgW+Qqgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=JO0zdDnb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.106
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020106.outbound.protection.outlook.com [52.101.191.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA638606A31B;
	Tue, 20 Oct 2026 19:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA638606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=JO0zdDnb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjBVI+F7Q5GohVzpLbZGxoRPEDrE8Lnbyb67F+wovIT3CnflAFAxZ2kq9FP5kc0aQTz/MSwM83WCnv4xkwkr9bI8eT1Qgg2kUbpeuWJ6k7isCMB6jYr9SnBZ9gjyrb5Hs0/CW/4RpGsK1PDGbL3xjJSNibSrBL1J3rsb/n76bQqcDUaC0zXwiDs1Eqbd/Vlizn1CRzkH+gkv+OwKOk//fY0U1aQGShtt2C9cI7p1o9Pio6/rBe4BYyR7FONLP33Egct+gRpDE0bXt/YWd6z3IhlUbVe+sv/T7sP8Xp8frI7BJZjpL4ngw2bCfOTiGrS2rQMNFBFd6kfemqvhLBd8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t33Y0nOrNqRmsedIeFJU52K4SHEO1Sh7k3v2A8kNejw=;
 b=OWeWVWMoFkMsez2j7wf96yJfoOymv0imHR0UmLMDcFXfNk8SfXS5JdAYyfoxFKKp5UTcCqbrKh6464hjR++dAW4R/SuuPLouTuSX35Bj572g2Bkm82vKuN2T0U0lL+L/zaYeZi8XxLnyqTdPX+jAeu7Aksp6teiyYQJA4zJDIxoTTE1sFeHHobwCUkPU+cA5uPgSmkgvLzBS2q5U3eVHCKgBY12wEiJ4TWVMwrYbNqNSLIzVadop3T5djT3OV3Gzj+nl1u4tb1PLu2EqTw5QaF29B6ihqDP8A4jiuB4346eYN+HL9JOxZewB9jVYo9Z25m20GD4hTYeNjUvGH4zDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t33Y0nOrNqRmsedIeFJU52K4SHEO1Sh7k3v2A8kNejw=;
 b=JO0zdDnb0PfTNynxTaG1NKvxopenf9XLsovn5OFVB8lX/Kl5h8v6S3PDKVM+N5r32cdbKUXkn0CC1b0vU/9o+AC5CBU28uu+hlFcRq/zONbUVPykZVJEn1vef1/8WNOcvvJp72XzHkQZqyaYzwc39UJtJilIF2IYKyXso9m34bs/cDEQyFk1++s+Oenrv3GvPG7Tfl6ZN89CYpel6K+WxQaPeGQVX6oYjXjGQFlMwSFbLU+3NRJoHY4bZhf9qYSDGnTENvmoh8e2AIKycfiRU0UunfIcUMCUACAlHfKQNfenkWimjfyoHMMAczwZhwT2uTSpIhzg8j93+NJ59vp66A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB8446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:11:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 19:11:14 +0000
Message-ID: <4defa4de-ab42-4809-9645-100cad68972b@efficios.com>
Date: Tue, 20 Oct 2026 15:11:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC -rcu/dev] hazptr: Record per-CPU slot owner after
 claiming the slot
To: Andrea Parri <parri.andrea@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bradley Morgan <brads@mainlining.org>, Kunwu Chan <kunwu.chan@gmail.com>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261019161852.12783-1-parri.andrea@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261019161852.12783-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 41683807-5875-4819-1477-08df2edde95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|5023799004|261009223027099003|261009221227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	51Z2fOdkrvZq4oZdlEHvBRmFNu8JZJb3IFdHdnHdWc/b3hNwEvN3FZBpSJWdx9hN8uXTn/eMHcN+WTPBEtn1ixJorxikw6JFLT8to28s+fKiYxWHZpzIKL0K4KSc2ixFy//JK96pEx9Gb5/ePM6fT4DZI3XUdyS2bcZp0YYZEDYg29sVPaWH+PKIEfR1aKionGPPqkUdKTwmylBQwFz5rEu6OOn6aSLG4Y4o91FwXQ/fZWXlq5KGIQOxIK5D6d5tDP6Q+LMldjVnpdJMHfiaioyw+OM3Ciui66RXHdYvDdm7iLpCqAGD1J/b0Ai1OteMfEdByciZ1KdncN0z4dVx5Q+FXC7Tc0MY5e/L8umvCDGl/jAPxV6Kc4ghjtawqEW1FyQ8VSwq9LBkAJPA1H/fSjJHd0Guf6SWT0ribiy8u7P8SPfdkUm3GGm6H/yeNDOh8M/roJOkCGhQ3ji0SzayAfchO6CD3pApFy3KROw+Z/GXJTR9aiw18YlG1bQ6DMmyfeseZxhOO+VI/yiULTamhOiFLmROJn2FGGdeMYpL/Gm7HuCJyEubDlo1XBSWIZpZF5eo9/fDQgKUXVgSCXHENlDl4Nl+Y9XBIp4Xg/ms6Ic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1JYUHFQYTllU1VtNFYwQktkYWRabHAvM21sOURlL2I2NDk4QzJIenBQWGRr?=
 =?utf-8?B?TE5QMGlGMWY2dEk4aFlLRzdwL3YzOExMeGlSOHZkS1I3SDM4bEFGcW9ibXRr?=
 =?utf-8?B?M01sVDFUaHFUQUY2U29iZGNVc0l3c2FjR2wycHBucThtM3NETHl0UDgrcHJr?=
 =?utf-8?B?SnJtWmxlYVc5ZjFtcitWckltMmVia2YrU3NzUGZLYXVhWjNMTllDQkhrSEdo?=
 =?utf-8?B?Z05BYVdTekQyeStUTDZDUkxGWXdxV3M4dlErWW1VKzJjbjM4b1ViNzhhVHZt?=
 =?utf-8?B?LzdCNEVCTFlXWXlWTVJnVktkckUwY0ZpMHd5WFZSZnN3blVhV3RtWkdTQ2tM?=
 =?utf-8?B?MS9kMW5mZTFtUjZWZUlXdXVEMWpvV2FjOXYzcVY2MnlyRDd2REZyT2p2bDJx?=
 =?utf-8?B?TDFIVlZKdnk3c2lUT1JLbjZyU0xNMkNwMDhZd1pLWnJVNDd5QWp6VUF1ajhV?=
 =?utf-8?B?bnNScUMzcFVMUWhzbVJoUTdnd2VEWUVVL1RzeURkclVGWm81QU5WaC84S0ho?=
 =?utf-8?B?Y3VIcm8rZHVXc01XdHZIcWF5bm1wK1ZuYm9lZ3p6MEI2K1hReWFvV0RMMnpr?=
 =?utf-8?B?a3pqUXhIK2xpb2pNZ0JmRmVmR21namFQSjNRZm5oS2xUZmU5eWREcFhMQlZ1?=
 =?utf-8?B?Vmo4SXhLQVNwTlBOZ01rNzBsbTB0cFpVYXpXcnpyZVlvb3pXVXB6WDd5RE1r?=
 =?utf-8?B?K0sxa2FSTUEvTXU3dW1jYndaaGVNWDFrZjJXZmlFUkhMakNOeFEybjJTdkZo?=
 =?utf-8?B?SnFjWFdaSkdQdzhOeDdMYkp6L1JuKzJhYkEvWlhGN3oyek5LeCtHVnFIc0U0?=
 =?utf-8?B?TENHQ01KWTh0aEhiTTZlTzNCM1BpREtDWjZlOUhXSWpzZkFQSFRKMHp1cnBk?=
 =?utf-8?B?NVpidVNYZzQ1OXdmcHFnUHhmM1c2eFR2RHY0d3Fta2xqeklqMU5BK0dZSGFy?=
 =?utf-8?B?WDUreVFzRklpdU1ySDRpOU9pTEtIMVJGN0FFNkFDMjZNS2lYRTBBT2hGTisw?=
 =?utf-8?B?STM0NTlIelJjNUFoSHZDdFJraTZ1eTZPam9qVkp1MEdHMklXUERQSzh5UVhB?=
 =?utf-8?B?R0IrYlBzdlNsT3pVSnhsU20zK09weHdOK0xUenpvU0huTHpMM3h6cFJQakdV?=
 =?utf-8?B?cU8xMW1LbWplWDZJdUg5YTdQYjAwRXBxNzdGRE9Oa3JOaTdyQzdoT1hLR2R4?=
 =?utf-8?B?dGdtcEJHNjhhYzlrU3lkL3N2THFiYVEyS0gzVlh0VWxMR083V1VCWEtBd3Y4?=
 =?utf-8?B?TjJKeGo2UVAxbk5BajZRTlNiR3pZSE4wVUdQZHdsY1dsTmdrVkhtcXBXVnhD?=
 =?utf-8?B?WlFkaDRPUFg3bXRwaDdSVG00S1d6enBnQkl3ajZDdnhCSWtlNzNDTVNLSVJx?=
 =?utf-8?B?SWVsZUZyZC85Vnl0eDlYajdKWlRCaFQwbVhRTjZLWFJPODN0bEhHYnV1eDVu?=
 =?utf-8?B?blFPNy9waVNLSE9tbElhNDFibjI4NHQ4K1QvY1VDY2tkMWl2bkVFOFBmZ0tG?=
 =?utf-8?B?dkZaTXVjOEQ5VVkvVnlyUitGNmtjRGpXNU9SWEhieUxSa1VJakt5cWlsYlJn?=
 =?utf-8?B?b3FncEFPUnBlbmVocng1SnFYbEdieW5hY0Zqdnd3OU5XaFNQSHNzT1Uzc1hU?=
 =?utf-8?B?SW5GeC9aa2tUbnRKb3h5bVB6QXZ5MGdIWWpCOE5oSTVicUVYeDBMczZwK3Bi?=
 =?utf-8?B?V3NJdTJNN1FDYm5xUmdmR25OSnRkTXdSTERLSXE3SldkYlVqeEw4ZXVudlVQ?=
 =?utf-8?B?UndIbFltS05jOU95WkNIOFA4dFNEVEFXSWQ2YmdrZFJLcS9BbVpDUSthanRP?=
 =?utf-8?B?SHdsYVc5RGdTVWVBb1RFN3EwTjZMVngvTzJKQnVrS2w3NUFDK2k4SjJtZEhN?=
 =?utf-8?B?Ny9USytlTmd5djBQRTF4cFozR1QwelB4T29hQXc1MXI2RFVtdGFETi9QRlN4?=
 =?utf-8?B?WkdpS3J1M0RVQkJTa3JDbTFldmJJZkVCa1Z4NTk2RWFKcGx5aFZubnBYQWpM?=
 =?utf-8?B?SWVtYitqbEtPU2hKTVQzc2gybjNnYkVmT0VIUFRxbldEcWErejBGYWtLWDZT?=
 =?utf-8?B?RHJxSUFWY0JsL0F5Y2h6ekVDU2I3ZXpDOFQvcFhLRitjeFFUbzZtUm96SDY0?=
 =?utf-8?B?eDRMM2pQd1Arc1BySzJvWUNhZGRLaVo5bElUcHNnVER1cWZpM2gxUUVGWGZl?=
 =?utf-8?B?bGZmWVBQbDR5alZ0dElja29XQitqQU9FZjBEci9xcW1wc3V0a0ZnY2NBTkRl?=
 =?utf-8?B?RUd3Y3Z1ajR6MHg4MmlabUdaSWVrNUdRcnhiMmtIcXg5WWgwalRWMTR3bTlH?=
 =?utf-8?B?RlhHTjN1YVJTcWY4K1o5QWl0MUFrQmEwajgzdDhVb3p3SUVaUHNYdVdjUUtV?=
 =?utf-8?Q?+KWQCS2NqP6rOYxM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41683807-5875-4819-1477-08df2edde95f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:11:14.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/jw8q9oOWLqIoMpq7LgkXVuwU2WyyqCUgxMuysDo1VBNsR9cU+DNGyohMV25jFwEmBoKlv2mO5yKmo5ippzemDRuxaELHHvFO6BZ0Tf73g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8446

On 2026-10-19 12:18, Andrea Parri wrote:
> An interrupt that uses a hazard pointer while the interrupted task is
> in the acquire slow path can leave its own context recorded as the
> owner of the per-CPU slot the task then publishes into.  The next
> context switch promotes the task's pointer with the interrupt's
> context.
> 
> hazptr_get_free_percpu_slot() records the owner when it picks an empty
> slot, but only Store B in __hazptr_try_acquire() claims the slot.  An
> interrupt in between picks the same slot, as the lowest free one:
> 
>    Task on CPU 0                        IRQ on CPU 0
>    -------------                        ------------
>    hazptr_acquire(ctx)
>      fast path fails
>      __hazptr_acquire(ctx)
>        picks item k (empty)
>        item k->ctx.ctx = ctx
>                                         hazptr_acquire(irq_ctx)
>                                           claims item k
>                                           item k->ctx.ctx = irq_ctx
>                                         hazptr_release(irq_ctx)
>                                           clears slot k
>        __hazptr_try_acquire()
>          Store B into slot k
>        (item k still names irq_ctx)
>    sleeps holding the pointer
>    hazptr_note_context_switch()
>      promotes item k with irq_ctx

You are correct. Writing directly to item->ctx.ctx before having
reserved the slot address (store B) fails to prevent the nested
irq handler from using that slot as well and causing confusion between
the two contexts.

Thanks for catching this !

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> The task gets there with k > 0 when it already holds an outer hazard
> pointer in slot 0; no other task can, as its slot is promoted when it
> is switched out.
> 
> The task gets there with k == 0 when the fast path leaves slot 0
> empty: either its ptr_eq() check fails because an updater changed the
> pointer, or the pointer is NULL and an updater publishes a non-NULL one
> before the slow path loads it.
> 
> The promotion moves the task's pointer into irq_ctx's backup slot,
> which nothing unchains, so hazptr_synchronize() on that pointer never
> returns.  The task's ctx->slot still names slot k, so its
> hazptr_release() clears whatever another reader on that CPU has since
> published there.
> 
> If the interrupt detaches instead, as hazptr_torture_acquire() does,
> the promotion chains irq_ctx's backup slot a second time while it is
> still linked.  The overflow list then loops on that node, or follows
> LIST_POISON1 once hazptr_unchain_backup_slot() removes it.
> 
> Record the owner after __hazptr_try_acquire() succeeds, as the fast
> path in hazptr_acquire() does.  This should be safe because an
> interrupt that used the slot has released or detached it by the time
> the task resumes, and only hazptr_note_context_switch() reads the
> owner, which cannot run before the task enables preemption.
> 
> Fixes: 50b568234163 ("hazptr: Implement Hazard Pointers")
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
> 
> Notes:
>      With this patch, hazptrtorture's NOPREEMPT scenario passes a 30-minute
>      run on x86_64 with 8 CPUs.  PREEMPT runs clean for 30 minutes but can
>      hang at shutdown, in hazptrtorture's release of deferred hazard
>      pointers; that hang does not involve this patch, and is addressed by
>      "hazptrtorture: Release all deferred hazard pointers before stopping",
>      posted separately.
>      
>      With that fix also applied, 30-minute runs pass for PREEMPT, for
>      NOPREEMPT with torture_type=hazptr, for PREEMPT with
>      torture_type=hazptr-stack, and for PREEMPT with CONFIG_HAZPTR_DEBUG=n.
>      
>      PREEMPT and NOPREEMPT also pass without this patch: their readers hold
>      one hazard pointer each, so they reach the slow path only when the
>      ptr_eq() check fails or the pointer is NULL, which happens only before
>      the writer publishes its first element and after it stops.
>      
>      A KUnit reproducer, with a test-only hook in __hazptr_try_acquire()
>      between the free-slot check and Store B, fails on 940793b926aa and
>      passes with this patch.  I can post it if useful.
> 
>   kernel/hazptr.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 3ca73b56a5c25..b15b84ebd4ceb 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -54,19 +54,16 @@ unsigned int flip_list_phase(unsigned int phase)
>   }
>   
>   static
> -struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> +struct hazptr_slot_item *hazptr_get_free_percpu_slot_item(void)
>   {
>   	struct hazptr_percpu_slots *percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
>   	unsigned int idx;
>   
>   	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
>   		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> -		struct hazptr_slot *slot = &item->slot;
>   
> -		if (!slot->addr) {
> -			item->ctx.ctx = ctx;
> -			return slot;
> -		}
> +		if (!item->slot.addr)
> +			return item;
>   	}
>   	/* All slots are in use. */
>   	return NULL;
> @@ -78,6 +75,7 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>    */
>   void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>   {
> +	struct hazptr_slot_item *item;
>   	struct hazptr_slot *slot;
>   	void *addr;
>   
> @@ -85,10 +83,17 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>   	 * In case we are called due to nested use of hazard pointers,
>   	 * try a slot protection with per-CPU slots.
>   	 */
> -	slot = hazptr_get_free_percpu_slot(ctx);
> -	if (likely(slot)) {
> +	item = hazptr_get_free_percpu_slot_item();
> +	if (likely(item)) {
> +		slot = &item->slot;
>   		addr = __hazptr_try_acquire(ctx, addr_p, slot);
>   		if (addr) {
> +			/*
> +			 * Record the owner only once Store B has claimed the
> +			 * slot, as hazptr_acquire() does: an interrupt may
> +			 * have used this slot since it was chosen.
> +			 */
> +			item->ctx.ctx = ctx;
>   			ctx->slot = slot;
>   			return addr;
>   		}
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

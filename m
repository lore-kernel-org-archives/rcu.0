Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323626;
	b=BK6Jwg7PG9sSbpxtam3Ksa06q7LfIZqMqrFGakfK+R0kPJ5z8O97cRv7I0zBfc0xc8D0
	 edRF6k5FTTenWC8c3f5vUH7Bcok4i0UphNOI7GLefQZ+uJQ+ZykzbFHnd5CqQ36ehP4zm
	 1pR45wvNbpgaiDXnXxi5XOsVDSBcjo7ODxfNG5EvuxD/zQ4zGFm6ebUbDfnD1DhrGzt7R
	 fO0CZfD0HvV/SZaPtD5H4gH19tDdASg5TfjibgxaLUjxInHKiqvTPp7oVjVW5sc6SvrEw
	 Kpav5LVjuF8uCWVJtPq6S24N0UGetxjC/nF4d27NuhqkS1WO29nTIsBt089PGSrURnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323626;
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
	bh=JvmVyoWJybVA7ifwK7GF99085yMPDilaRbOneRNJbL4=;
	b=li0Zx1GuUTgnWSuaKe4LYJhLHjicZQspRRQnthqM6Iq+zFzzFWKHYYJ9fiDaO7aldPB0
	 6qstanIWKvQZZlW8RaUlTJSF4kde4zpoZC/iPrHGOBS7V3bp1ZqV+lX/mBuPdaHEc3GH2
	 fSbSoJBujYW59R+9u/jgozgmCUAA01SX8pZePtIfA5jsjnh4yAi+b0X7sfGk7urllMhs1
	 /qgHZrHeqDpItG6PPGUEL0JJalgk+CipstQBaOL1w7NdW4txxB3fhZsqYWz88t1Pa1gr+
	 nwymmZa6voYVZ/g37av4vM2BmH/YB7ev6vpNn1BsmYmBAPGnuSgrKcAwMjhF7GwKPow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Lo0sN7pJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.121
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021121.outbound.protection.outlook.com [40.107.192.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C0606A31C;
	Tue, 10 Nov 2026 15:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Lo0sN7pJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEMSl3Gnh1+zBpgQotISaPvLLyDoZ+MmPxE6xNitPR8/0lq8ai4O2bmtxcmfFBCeG9wdMR0wh+1gA6JGrSNpd9YE96/o3uCeTq6SXTBWLvp5+bRZs/d6dhL3pcW9Tm+4l1n6b9p47rP7fJ4S6+11HF7M8v1rvCyXq2ZknE3p0tVUtbmglwhkEn5Ny7mlTJwTuT2mYzwbk8bUG7tn0z+gaHULrte6z5NsKcEA0Z+rAsfeGiIx/5SUDbJgoO9/ijFdyomQukpJ7oxZQDvIMqRe50JeOn+JMyPRznN/aQDkpjDFp29659lWCpRxiC4huXRciG5mrdoMfgoo1XNg5WDczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvmVyoWJybVA7ifwK7GF99085yMPDilaRbOneRNJbL4=;
 b=GphW6d/sqlexuZVSliYSoT8ZbuNP+sSqcpQadWh8xpoOkR2Xmj6TQuGgtyAoESWu7VBvThORNhtRSI6uMSda7nUOiCLiyaQQQfi7sz+2LCt1+wQK1taNT5i97cI/LU4XE2VwoEYdkoMLlv5OOYgiGrs05afMWjQf07pOdDfFwYP0nxAA2rOuaUyAGnpFuDSbpCgokgvP3ti7sKk90exi9ZSLZvd7OpnDoT5fxXtNKnhP7wO4jryljjR3TUBbUDjI7CHC9691QnBeqr92nGCZmpVSMcR6sN0s91k3BsXCK24/R0K3K8vyRTf5TOQwo3vAMpvkGhcx9uFjUtZv1nGPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvmVyoWJybVA7ifwK7GF99085yMPDilaRbOneRNJbL4=;
 b=Lo0sN7pJzqk454rlKGT1F/aoZvysQDYf6hI9a/Bn5fthlKze8B7UNmG8z/7LaLp/H02CMY6VNUoVbc5dMlJMSdS2KliVzhdNmtKe1rkUHC6hsbYobbCszm4RfQQeI+/69YQYzYHjwIWHtG++lSdOP97DST6bnICAZWXPnlnNBOtH4DRUDR/IArcoj9F4BZuFqRvV14RCD386oWH8jK8L0inWbKrSNMAUxj3q/56K6BGKsmW/P1cnSTESg3s34Ig9yzYiDkynGYYj+G145prg5qRGgl6llQNvlfTlsy2AA8DAfUxthtxcF9EMcVPG6F+DRoal7kRedBwuVKD9PghUvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5460.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:13:44 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:13:44 +0000
Message-ID: <5282f0a7-6df3-46c1-a668-9fc0a1c57aec@efficios.com>
Date: Tue, 10 Nov 2026 10:13:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] rcu_txn: Test a list writer against concurrent
 readers
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
 <20261016133319.433617-10-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-6-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-6-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::9) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: d7099cb7-d5ec-432e-f105-08df3f3d362c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|5023799004|261028144727099003|261026140227099003|261102123227099003|261009223027099003|56012099006|261021123027099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	hY9t6qxzBbdDKPfyYarCSVC/UtAmjKw3eSl7SJP9kY0TCgm9WvK7de/oLM5MyROGgFX/wnllPd5YK1O5By9hWT78Hj0oCstdU4N2DWX2doskt8+Fvywoa0h4ihRwolyknVd50fnY2tnHqB3oRDH4xx+L0J6QZwANBF+sJSdDHNNmvICh9w0GebV0xFMG+ng4iBTnWWgIQhyPmpmYl+6pbhOCG+IbQXUjiRxklZsjStNlm26IY6LLMn5xa50youFV3HmEF3DelqwHSQaZUSHNLZ+B5ewDqZtXnR2DZjKIs8Ch8zIIR6kdAZk6ZKpHbPDv1ewyWzVFHAXs5VaB/FLZNIwgO2gGIExusXk86Rfc5ixO9OOWIXorsuPa0zadBUS7/3A92IqV5y7E3CDhsGOr6869LN8EX3o6Yk4JOt/XbBkYHy8K1d8Zba3LAcaIxcfhn8H1zhPPdZtjenyku9rGveobkB38E7SGCUALNfT9J7xOkE8xVgKvCipWvhIOysdlZewTHlS1iOxqfhCFtWdColPrYCyPZ0etXWxR+NI6EBkBMxR4jqsQOkM7TgtdDRxsgcKezqEcGjMIlpcXSREFI8rLgpkjJZNOQhqVyDvHv2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWlqNmd0TEcxdjBKWXdYMzExaG9GMENQZ3FWVmRVZFdBcDh1U0kzSUN4aEVk?=
 =?utf-8?B?TEdoQzdOM2RYT2JXZU8zL3JnRFRaZHV6cmxDMTlwZjQxZ0sxVVgzSWZSVTl3?=
 =?utf-8?B?Wm5Na1Y0Q21LYjZCMEJtTHdYLzVYR3JRL1BIY3lWL2VSOHVoZXZNUnhHOHZY?=
 =?utf-8?B?c01NVEVKZzdkWDhIdlh1YkFXNDZpMEtVU01mb1MxcDN1c0VKQ0w4Vk9wd0Qw?=
 =?utf-8?B?T2ZpZVZNQXZvdzJ0RXRkK1Iydmw0L1hseEtpUTJWNzdMd2psalljR3J6MkNn?=
 =?utf-8?B?R2Y1RmZQMmFzQkI5TERXdzJ6WFZPZzVWYmVxcHFFcWlidituYTRCcjROeGlO?=
 =?utf-8?B?VlZISUd4K3hwajY3b29pWGRXZWdtRkR5TWdyL0hXT25Tblo3d3lmTHdMVTMv?=
 =?utf-8?B?WGRpRkxCaGt0bW1XY0R2Rmo3QXFVZ0hOeWFhcnJIREwvTU5pZkRiOFpBd1Iw?=
 =?utf-8?B?ZVZienAzK2JaZXMzWWZHWC8xUnk5TkpKTTRLMGJ0S01VZnk2cTlGdlZRa1dr?=
 =?utf-8?B?a1hGNzZBODN1SlhUbFE4SmdDQVRSUkdoR1ZDdEpzQkZKMExlbEVVdzJScVg5?=
 =?utf-8?B?TDA3Y3NXYnpzL3FzUms3QmJDcVhlNjVJYXNTdVBxMUU1Q1FlNitnVytIeFlR?=
 =?utf-8?B?aVhDRUlSbXcwZmIvUFhFTkV5OFZGL1N2K3FnTmZjZXl5VGxjUmF3Z0dKbGJt?=
 =?utf-8?B?UlMzRm9VMEJGNCtQNHFCNzZoWEMwaHNGQ3IxRTJyYnNxVDFSNDg1b3ppSlVu?=
 =?utf-8?B?NnFvRnJ3dGpSSDNjSEtrNUUyMHVuNTMxMnRBaTB5RTZKT0tvN2s0czcrL2M3?=
 =?utf-8?B?N0plNVpJN1hISXFwTExQajl1MXdueGZyQVFDcUxBNU9veEUrK2F4MkJ6Q01T?=
 =?utf-8?B?MXRrNkRlakVnQ1V1aUJxU2txdVhUQS9YQUhnWUNrSDhPdlNIOUgyc041VXFU?=
 =?utf-8?B?NE9uemVDOUsvcW1CTXE3OTRjem5LVVdTR2dOUEdNV284QkY4alhqTkhNWlpT?=
 =?utf-8?B?SEI3cGxhTkdRMEc5c3BjejBIaTVDU2tmVnZsRVlrRjBYS1B2bnJ5SWEyaHkw?=
 =?utf-8?B?ZW1OVVl5WjIyMFllMnBxem9FeTFyZDFmeEpmM3RWc0txc01kczU2SFU5UGgw?=
 =?utf-8?B?cThhYUdPMWlJUHhVZE1IM09EdkVEVCtaUkhNVUZtWHR0V0grcWhqTS9IMVdt?=
 =?utf-8?B?ZDRzL3FSamJwR0hpNEIwTThhVSswOHN6dXZxcWUrMEVyb2t1bTh5VjFFaGpz?=
 =?utf-8?B?dUxJY2p6NE9SdjhicDhjbWNtNmZBQ0cveGhYMUIzUTNIUEdQcUpLU0ZMZlo5?=
 =?utf-8?B?VW1wZ0NEc3FuTFFFMW9kMkJpK3ErUEc0RHd6RDVRdDdEeHM3eVhyRHN6dGNB?=
 =?utf-8?B?NVIvWGVNNit4UTh6cVRIa1Z0czRudkJKYTNUby9ELy9DdWFPakpoemtLcExH?=
 =?utf-8?B?SEkvRFhZY2s5RFNlOHV5aE4rcVNKTzhzWkF2RVFOaGZHbWp4SUhTdE5XWHNB?=
 =?utf-8?B?dkNwb3d4aFZCaXZrMHpYNkZSUDUxZHZwSnUwVkU1eTE2cjlFckorVjlaK2hx?=
 =?utf-8?B?RXlrMG05aE5RTTYrSHVlSGVieTQ5WVlzTzhxa1NQM0xiWk11akRGbkxiYW9l?=
 =?utf-8?B?bFkzelMyWDlUak9tc0dJRDB5OTBLTXc0T1hwN0x5akwxVlRLZjdYTDNsZHR0?=
 =?utf-8?B?WXBZeGxQSWd3cXk0NEVQbDF4MTg4TzVPL2lhNXN2RDdkVklFc08xRGVwVnJN?=
 =?utf-8?B?V2JHNTlqT0lLMnBMSGpGakxSU0JjUDVOK3Ntb2l1L1p2UkJzV0FxMDZHL3lN?=
 =?utf-8?B?aVpGYlB0R0YvdE13M2dtMnJjRk05dlpDSS92RXhQWGw4NDhXVll0UFZCZTA3?=
 =?utf-8?B?Y05Sd3pwak51dDdXcWhoWGVWQzNLTFdsM3hYeHZvcDhOZ09mdFJGMWtBaHBC?=
 =?utf-8?B?eGxWUUxjYWhlWjZST3RtUFNFQVFWNVM3WThQZW9NOVdUTVNxaktYaFMxeXBT?=
 =?utf-8?B?K2ZmdEVndXB2OWlLK0NZSXQ0VDl4ZWFtM05TUlRwSTBQVU15dkd2djUwVEsx?=
 =?utf-8?B?R1kydE5USDFoc2RqVUVFTmRENnFpdzhwOUJhcGc1K1ZwMkFDazMreEtGa2VQ?=
 =?utf-8?B?QTFtL3FrQ3kvZVI4dnBoOUVGbDdRVEZ0VisvVzQ5b0c2T1FKQis2dzhwZ2l6?=
 =?utf-8?B?cVBZeW9CMzVudUNtcXBidUNrZWx1WUFqZy8rczVVVDNGTy9EclBrOWg2RHg0?=
 =?utf-8?B?ZFZSK3ltVkRJa3ZLSk1OVFRCaTBlQzNON3pmVDVJUnQ2OWd1Q2l4TGVsaFJ0?=
 =?utf-8?B?WENzcGtVaExNYjRFNlVrRStZY3hGNHFEV1B3dzRidWg1dHJNK1paMXpWbjV0?=
 =?utf-8?Q?ILEdRqHuU8fqd/pZitqG34z5fPW3Ye4dnEt2H?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7099cb7-d5ec-432e-f105-08df3f3d362c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:13:44.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyuc1ERYgMFvyoJBObSpb7ijr/vohFP06FueAiVjg/XRy3OBqNIqEXqIKV0PaqDrmdvkpQv1Eu+gkoTjLttN+UwaX/u4bHtLJwV0UBhds2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5460

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> prev_key already skips the first step, so I'd count 
> back == &head->node as a violation.

Agreed. Counting it is planned for the next version.

[...]
> If the writer oopses, KUnit fails the test and frees c and the readers
> array while these threads are still walking the list.  Registering the
> stop with kunit_add_action_or_reset(), and calling
> kunit_release_action() where they're stopped now, would avoid the
> use-after-free.

Planned for the next version, as you describe.
   
[...]
> A failed conc_del() here leaks the node without anyone noticing.  The
> readers are already stopped at this point, so the leftovers could just
> be kfree()d.

In the next version, a delete will no longer fail. The test will unlink
and free the leftovers directly, without a grace period.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB8374E5A;
	Fri, 10 Jul 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690926; cv=fail; b=ht3cPJ5fYxST0MFxKBb+bD9CQ6Dy4bnRcvN8/29C5TUzDei6OliWpquERIk95CjtZayETcB5g9CUZSMAco/uk/nC+mmQmI0BsDg7JttY6TA14S4aN6lHWKvnKpJNFSjKcwCpyVIaFKb2Rkf4QgjM8ynRfzrckxUCE3OmYs/e64k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690926; c=relaxed/simple;
	bh=xPuZgzr7rFTploh73+N8Isx9TTwZUiI6my45TjgHuXA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=V9MOR8aRUiciGwyTKJ/sBfE+GB4/1TRu8Q74sWoFhO0VXombwkITUXJtkE/fccONret4jubiFTOoToMtSZp6YDJk4uNzcDZVlIuSw19QIjV+CUGTX/2gtxqjQwe5pCjti7rYLEOtb/06CRA6qX6HvdxGdT0tKPbgNpAhuhlxCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jsvzuCGt; arc=fail smtp.client-ip=52.101.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jsvzuCGt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ31jPAE0vbHb3pOR7C65sqYlbVdhQwFAT0oe7frxPDVmXtvmr30od8Egm4AgW+A5OxPHNQlgGpKDkSKLIeu4ztqfgkn50xdBp50yUQB9Mvvx5SOjFTUMmhXhbZ+uOZstxB1oxNp5syBm88kF7CHgaxyhvn+DBlR2EEKuHEo2jt3iJm91TBnvalSvHWWxWaXAxRdsub5SeeIOfvkcxNPNdRa19t3SCxmKFBZP9Dd7y7edp2pTT9fUED8dtmrXbACJIoruZqiMSKfTogfdXhPAL5R0qcicQpwLjhG1zc5148/ltbbN0MlWEohdEbaAhDJri3G389EJJzwIDR5IDazQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je3COxMdvOkVy+mqm0i0JurE3cJuS/ogi86P4bC5DCo=;
 b=d9sozK5tngATCVDbVSPKfhy0kToaJErFTBi8kkPnvTJpsWvCHY+3j6Vnihua60ryO0rDhsQbW1d+OyOpSrhMhQaT/xO263hOvu+nGeOJR7BL+fuBUHXMJthElMQSn/aOIX+3+jL3roB8qW+9+kFWzniH8kvSY9e7XHjnhjfp7KULTAmsbhJQqzzKdXvSaIoThTHXk6K5QQAaq8UA1EYpaul+byFfLDmtp2cGcj0HTy2d0Ui/qFUrk8xEkjUpBi5GZEfxIcJe0uzn0RDzAML15wYTNMhndENkYzTgAPN/f59Ion65lihxBAmZoIUCy6EXNGK5oXRgpbjCIgwOe1lpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je3COxMdvOkVy+mqm0i0JurE3cJuS/ogi86P4bC5DCo=;
 b=jsvzuCGtJZMCQMFSdDwygdRRTys0NCNb4K1xMXihQVKyIMh7j6xNnE5cmbzNQElV2qk64d7NKN/YOgXmBRN41UAy3DLAf3I1B/C6GryzPy/jqZ9+ibTImTTCQphdD/ouECNuw47OewgmNxoLgnKMaRLqWG5snxZAL7qgdTWovtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:42:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:42:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 14:42:01 +0100
Message-Id: <DJUXNT3MAGQ0.2HNFY66YDABZ3@garyguo.net>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 4/5] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260613065348.96750-1-work@onurozkan.dev>
 <20260613065348.96750-5-work@onurozkan.dev>
In-Reply-To: <20260613065348.96750-5-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0322.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: e9907af6-e67c-4dad-da86-08dede890593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0sUkDQQNxt9ggtiiDF8yIUL3iCmNReG5Fcr1Tn/Q+RF0+q2+q1lh+vzh7WXRrrTs/BXhPdiq4eCHPWnNeUvwRnsFNUTOGtzEtkWLTaA3eIEBEmi5SYkF3fXSv/4qsFMpQq6QIcWrdeeMaqnmVAjWM3gWIuLqkrz11sZ2lmdQJTDHFaYKbPJEHcotgPO0/xPAhQIXPPyoMOMkbV/yJtT5mfAwteGiyV4HTKIomsTQSedOpe/yuBlavENFBmtF8/0bd0kr+6UJLnQ21xuvaB1sH+h3qkGkOc/NFkNkZdsXU2P+sF+bAnA/6AlqNddWVXGSjtjMcLXvMmmG3TG02OdMbjurjK+b14W1cg8g+wl6z6MQSGglaUx4PFI69F1iPW/FfVWwq/9R//amkptiH9GyVSZjv96+IYdnUsDI/XZw/3Wj6wNspCNvEod93alzHmCkOFtM5x4gpNJIUpD7yXvmF+MrG5CtKG3E4k23pgd9VRTNTzLoOPz4OYyAFHkGDWgbNjusVNQRSk9C8PZWH4Ti44rxZZaqfZYKT8BpdBtsr129M6qhl+GuibC6AbnqC8yiWMcTASEiGZPy8GTJ2w8Vfl2hKb2mo5UMBCUjzW+fPdv9fJvOIfpTKg9CTGx4zrejamcbctBbnOPDCmaHED4/V8bGifZcdWLxqDh+t80MuR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDcvQzRLVFpOV1h2MWtRZDFwMlIyLzFETmpaVXRjYXBXL1p3b2l5bVZjOURX?=
 =?utf-8?B?SGtIN0tZYXgvNVh2V01XRUpsVGFmeFVOMUtlak5PNXAyQ1lncng3czk0QnhH?=
 =?utf-8?B?RFNmb2l1SjZGS3NDVjlMNTE3ME1DM05ycmxDOWdzWFZiaDVtSjZ0R1dmSUZU?=
 =?utf-8?B?TE95MnhQUUx2d3BnQVgydUltOUU1TVlrNEZ5U2ZpYXRUaDlzRlVEaUJoaHVu?=
 =?utf-8?B?dWtRS2c1bk1rNjBRRi9UN1JzM2pjdEkrK1p1WmxhSWl1UVl1bGdOeXZ1eU1Y?=
 =?utf-8?B?S2FpSUpJSXRib3ZRYWhLMlZ5b041VDA2WVpZK0tIVjVXS2J6aFRwaXI0Nmxo?=
 =?utf-8?B?QjdlOUtSUHZqNlFUTGliTy9LbXVrd2ZtZkxZS0FKZWd5djBRQk5xd21MRlg3?=
 =?utf-8?B?WWVBOFdkSlJzZll2T1pwM3djZHVyY3QweTNLczNSVGdFL0ZtMEwxckk1Smdk?=
 =?utf-8?B?dnprcWRyS09sNml2Z3pHaEZOdzFZcGZKNzlKcDNvbVY4cE9Nb203RjhaN0x5?=
 =?utf-8?B?bE16NHhuYWFUS3BTKzhsd20yaUhFOWpwM1lUU2ZjVU5zcFMydVVoQWxrVGdo?=
 =?utf-8?B?V2dOeTBCcXFVTFJXWVUrbUpPbzRxdXk1OVlrWTlEb3dQbW1IaG9qQzFaNnJK?=
 =?utf-8?B?SlNvb1RmMkxLd01XTzVmdUtFZ1o2RnNxbmIvQklvWi9DdXNwV1dTYzlvZ2NP?=
 =?utf-8?B?Y3A4aXcxQitLa2JPTm1GSlhWUEFkY1lwMXBDUkpFNGtYWTlYSXZJbDZ2dURJ?=
 =?utf-8?B?TE5kd3JUTTFzcUZUbXFiNFBhOWlseUdNWFh4anZQUTczTHRPMUZXek5TUk9M?=
 =?utf-8?B?OEVjY0dlekJYR0xwMWh5aWdJQ3M3U0dxZHI3QjF3a3dIUnM0UU0xcTg5ZU9a?=
 =?utf-8?B?NjMwNHRBRDVnYkYwTGwrM0prZVFXOWZMSDU0NHI2aU1SSjd1K0gzai92NmtS?=
 =?utf-8?B?N0pKVldBUVJLVWNFZVM5ZC9IQWxsQzVBMzRnbno5ZXF2OFBUdTFpRThFcFZ4?=
 =?utf-8?B?NFNFZW4vMVFjUVdNaU10VHdrbVFWWU9KeURiOWcyUnM0V2ZmNC9JT0RLaDU0?=
 =?utf-8?B?dDFsaXhCakNTZys1TUlRT25JYjFROWVtR2cxa1RZWnEybFpBOHVwUEEzbllW?=
 =?utf-8?B?b2R0U09PRU5CZTlybUdqZ1QxV3g5M2xEc1k2bmVYUmlGUTVIbUZiRG5MWTFn?=
 =?utf-8?B?Rlk1NnJsM3BENlozZWV1cjJ6SVMydG5wekk3S2ZYaUk2YmdLRFF4UlZjVGcz?=
 =?utf-8?B?RU8zczJBQU04UXNqTGMra3pNNlhCa2ZMOURkbHJOUm1GQytiYitVWlpUR1dt?=
 =?utf-8?B?SEdyWjFDTE9LeFRLSFNIeDhDK2VjcytjMjJoZ1FXZGk3eEIxQzB1dVdQQkRL?=
 =?utf-8?B?R0J4WmFvTW1FYUcrWHNYaHN5UG9uSUI0aVljeXRSSkdXSnhQWHRlb3lOUFBs?=
 =?utf-8?B?ajRYVDZwVnk4Z1RCZ3VSOFk4Y0owL29hQzgvVmFxZlJnRi94Tm1NRWlpWFJI?=
 =?utf-8?B?WFRuUkFqNUZJZnU3anNFcFJsWnZIdlIxd0VqTHBTMVd2OGYweHJyUWI5M0xX?=
 =?utf-8?B?UUQzdzQxOTVwMVV6aTFJY3lCT3paamxmU0ZvVjJnc0R1RUJTWjVOMXJGUnpL?=
 =?utf-8?B?Wm5UeDhES01KN2lFMjBFalJJRUdOQ0tNWDBrMEFmR2o2VlRQTUlXYW14Z0dQ?=
 =?utf-8?B?OXhrV1ptcUttbUdtSW5TR2hRZ1ZjeHFJMUdRRHU0bGNtbm40NXBaNmJHWHFR?=
 =?utf-8?B?eWZBYzB2K25ZbTZEaUxxNVVhdXA2U3pkV2V1eEV2N0VHQXlmSjBtMXc0czdu?=
 =?utf-8?B?WkxkdGw5MTl2R2pwdFR6QzRYTUJ6ZHU5OXVGVG1td0gyaGZkMUJtbE5wZVpp?=
 =?utf-8?B?TlI1RlVvUkFHd3A0ZlhDbnBncFFIYUNpRkorRE1POUVhcDg4UmJ5NU5YMDFa?=
 =?utf-8?B?MDhxbnkyaTJvZ0JhZXI2UHQvY1I1cndzb2pZTG0zZEV5Ni9TWU4xOW9YN3Vj?=
 =?utf-8?B?OG5Ka2xaZUp0ajFVNmxFNVVqeXl5VU94eWdITGlkSFVkbzIvR25iaFlVTVRD?=
 =?utf-8?B?RlVMSlJVT2VEUDhWSGxmUk9ITE5SUDZVeXljOXYraCtQazJPN29GVk84Q1BS?=
 =?utf-8?B?YVdKTmVXdHJrWlZoSFRjM2FaRVZ5dWZJckpaR1hhOElreDhYQjBOenJqM3Bp?=
 =?utf-8?B?VVo5T3VlUGtvc2Nmczl0U2h4THRkaWJNNTJsVXBKZGpqL3lhb25LVHFESjJR?=
 =?utf-8?B?MU1iOEdKMXJ0QzcrWmhidmNmZTBBOXZCZEpRYUFWM3lCSkF1QThHRjQrakpR?=
 =?utf-8?B?Z1lvd25qZEVIUE9HbGhvVXNwODcxUVVkUjdFUTR1MmVqRjBNWU54UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e9907af6-e67c-4dad-da86-08dede890593
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:42:01.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm0uhHFeUbsZVmdIGF/QC2OTXYPbRlm1lPRm4zfGYFegFhwfuVBUt+Ex8aSuCiYcZLi74ybc/wZAlYzvoMNrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8770

On Sat Jun 13, 2026 at 7:40 AM BST, Onur =C3=96zkan wrote:
> Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
> Provide FFI helpers and a safe wrapper with a guard-based API for read-si=
de
> critical sections.
>=20
> Cleanup is handled via `PinnedDrop`. It first checks for active read-side
> sections and emits a warning if any guards were leaked. In that case, it
> waits in `synchronize_srcu()` rather than risking a UAF by freeing the
> `srcu_struct` that is still reachable from the C side. It then uses
> `srcu_barrier()` to drain pending callbacks before finally calling
> `cleanup_srcu_struct()`.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 171 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 rust/kernel/sync/srcu.rs


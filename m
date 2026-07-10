Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020128.outbound.protection.outlook.com [52.101.195.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F342314A;
	Fri, 10 Jul 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690768; cv=fail; b=jAlnnoMUGWwCKJNZ+QeOWC6PpQetWvTmXRo++nyiqTDRCtV6HMwSQvWp02LT+BzmfuO2F9/H1qNiikuFNLgPeD0gXOxiQHIMqbNYshiX0ejFY4XvZGwY8WoTXphFld0It+Zop/QsxVdzZrc6/+kfCa34osh1Z1DIsjxXL1Wk7Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690768; c=relaxed/simple;
	bh=SJMSPWKgKnxzuyE8CHYkd0ycJL/x08jkIO52WsylsEk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XsZXF0zmFXp3lY9UMy9G88H05JA/1rznMuVQEjRI2NIK7yQLIwxZ4g94VTi2VtsV2NbqLFStwuK+NaQXQipcKpeM7UeSQzSenm1Ap+hvrupD2+amKAXQJ3TZiMLGV6r9HqUoioyGDzMd4ueKyHiWOk3CGrHJn0/mDbssPfMxFBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bnLdDBzT; arc=fail smtp.client-ip=52.101.195.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bnLdDBzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOfRs+Chq7QcoqFJohzhqGkwXMtZst2eGOBO1j8tD6WdN5Tp+jDLmXRrXy1bQnGTxToDeH+IpWaw7qhFPH/doH3PIPzNN67VmYALQCl+MY0AQbWlVI8ZwhiFBnVGkyQj+OBh/gPPwQSVma9tC4i0uP88iw8XrPwxz2ZFEv4YGRMJxfi2JxfFEEJYQ2aC5m0cJ3pQNgbYhsY0R0E+Y0n5XNtoY3weKI1pyNph6Ivk8t/KAMzx8uO9OBqGDsTLiPGqwPgJMuqIGrZMLH5+g9A4Cdrbktch+GcEvYKbhx1QMBwKlTI+PVPGGLH9UJoAOPxK0LQhSn3cdAnSTCv1zfHdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8PMKs1rqajCpLG0VuV92IOHywXjZ0lTofOK6NzmZ2I=;
 b=I6qUPVhfOocLeqeAV+wN9vgoEm9Mj8vcUg34ElIfwpoOKmlH6A2Ticd2cugnI+zzw3p2frdStcCjy3gTHNYeMfyrZDpEvNfChD4NaxDGYBEJBnIuwlJquO0GfX21z5+EAHYotJBqyfj42rp68tUZcGMe3BoU0qN1zGJwtR56zy6ep5f06/ifdl+yzVZWmroXpJWcNEFmPfMkuQKQgAjSeoOPbMcjJ8zZR17Mnir+tA1x/KcJW6S7oIxNWbewEExGhc312qUT0SNycakx5l9IC+Awo76FXdmQ1GOsmh70608elWe51TWwpgwjem9Pbysosv3wYHM5kmDhx4DOwZ1akA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8PMKs1rqajCpLG0VuV92IOHywXjZ0lTofOK6NzmZ2I=;
 b=bnLdDBzTWguGsReUAFyLO98TmnAFpf1KFVB/WeCA7CyMq0N4ljRQsR3JvPY8WA4aW8vri2RUQ8ViflhbPkflumxUgOwTCw+pKZvApRuOC8AIU56wfCInOnbpBn/uNU1wJuIypnjhqvviM57gL9TZy2ZbVddNgEvfLN1RkDKm524=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5634.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:39:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:39:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 14:39:19 +0100
Message-Id: <DJUXLQYVU1W1.1DZO1M97OBOEF@garyguo.net>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 2/5] rust: helpers: add SRCU helpers
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260613065348.96750-1-work@onurozkan.dev>
 <20260613065348.96750-3-work@onurozkan.dev>
In-Reply-To: <20260613065348.96750-3-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e913c77-e689-4660-7e1f-08dede88a564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|6133799003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	It8FT/hsbNPicKFxNaJnQQEaXe+U6YL85FxhdH+B5BXm8ebSZcL4Es4iLnjrryPZYb9Nk1ygFa8lZdeb/3RpjRd+KsMH7/KI6411u+I695/uaDU6bYCKyi0VVrblHROJvRYB1vMCHSdIChFELWp7VuHYr3i5+R0DKlWil7Pfpzr4RuWL8PxQRN71vzqJceFhDmETaD8J1MLvi20R0tbNEIQ7iIfo+Xin03qTkgDqf4uHUbSdk/Euy3WaG7kzsl2yESl43g9PoE3/ynbjjpsUj633YDmfzeXBZ/klOLniQN9nff+rFH3b7gAJ4KjQ4Cy7snankWc87qz9CGX9YyBvDyfSuGI3sKMpZNsawd09xWlI6KzP/QlRptmoffg1eqXpGBKXatbLtQqhLmKF6OlpzMnCQxW4iZNdSoOK6oH6YkHncH8OnQN/5O5OavtQHcWqq4GVw5ZzQxsK8aXiKZW3YHuqSq3BI9HvWhJOvBANEjtlVMGHaqmDGAWRBnizK08OSfi4OdhL0bghnxc4B5xSc31/XzDk6FT7J4HO9fyUih29ubZXk1sUkFXbZ+/F6Zbu+uZzfqgaEL10lk0FvLzJ0SF1XyPdIhjsNN8zBOBllroYrbTN00nlIT97qs2+DMcMjLpXmE0Fprq1H9Cqzt+kGhGYwrVyKXSxqeR7t30gt9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(6133799003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZXdG1FcERTamJ3RnVJVURDR1lBbmloZ0Z4L2RtTllEUFJHWTMrZjFXUkw5?=
 =?utf-8?B?RkllKzZTb1lpZVBLUWVtS2NETUpGR3EzM3RZaVhRd2NYS3hyN1ZyZndiRTN1?=
 =?utf-8?B?R3ErTFJGVm5EZDN6UzY0SnhYTER6NEZwRGtHODdXbkNsMVZSdGwxSWVWYkx4?=
 =?utf-8?B?L0Y1bnBGRlhSVVhDWE1lNnFmdUpBc1I2cGl0R0x1akpWRHl5bEREYlRzTUFF?=
 =?utf-8?B?L2Urbk45aXB2OUF4MkpoakJReDV3STllMGpmb2VlWXRSK3RHSkJ5eUFDcXpu?=
 =?utf-8?B?QlN6RmNiTnRObDdmVCtwUk93S2FpZ2srODBOQWpiN2tnNyttUmtneFVyREtQ?=
 =?utf-8?B?VVR3WU1NN2luUk5nbGFoc1dna2ZubkZrUVd2cmlBekR6QlZLcTBTRGpKZ0pC?=
 =?utf-8?B?dGF2d0M2N2hOUTZrc0ZoalhaZHVSVGd1eko3dW1TMTR0YU5sdUxiOWVyZnB1?=
 =?utf-8?B?Y21xbGxkS1R1cmJRZWRmWHc5bDVBbWpuM2x2SnFVNGhpUGNYNUc4ZWJDNGNY?=
 =?utf-8?B?eHdNZTY5U1RNUXcvZEJ2UThJN3ZvVlZMS2N3T1NRWkFvSlRUb0JvWEtYc1Y1?=
 =?utf-8?B?R3NxWVdYSVhCWnlBOHViTXRHdzdPMHNUVlBic3VZM0FxYjhrbzgzRTIvVDZL?=
 =?utf-8?B?SWdzTEVWQy9FNWl1b21BM3JkbnIrMEhveWhrRzJNU0VSM0hUcEFhUThkbGEz?=
 =?utf-8?B?OWNlcEdTc1lVUU16Q2Nqb3luanV4alErRGdVbFJBTlJBUTdoeTBzRHZjeDBK?=
 =?utf-8?B?TmNreW1EdGplMzVkL0k2VUl2dzcyTG9BM3hhNXFZVUNoWUc4U1RTNFZIbHNE?=
 =?utf-8?B?SElVdUhRd1RLRlplSWN6ZWVUckg0UVVuVTZGZUd3dkthTGUzZENQT3NKaWVX?=
 =?utf-8?B?VU5GeVcvbldDQkZ3Y04zdUh4eENLMVdDYnhpcEV6Tzhoc0lmb05HajN3K1R4?=
 =?utf-8?B?Q1BNMWVTMmxrUVdRTWNQc0pEaHkyWnFMd3NJTkNWSW9rK092dGI5RVdzZVR4?=
 =?utf-8?B?RGNRM3Qrb1BIQUFnanB4WVZvaGJvak04TjhEUFEzeXY3cFEwT2Nza0lQSXI0?=
 =?utf-8?B?S2JodFdZN3hYb0Eydk5hcEZWYkpyOUJaTnJOUnlJcUJHVnJNTFF4MjZOS1di?=
 =?utf-8?B?aVBrYi96aXlpSmtuM2pGZWZ1dzJWeW01bTR6R2o2Um5pQzZLS3ZKK29NVGFZ?=
 =?utf-8?B?bVRCUFVMalZCNXErMTRkQWVmbzRUQzVOT1NmWFprMGZQWXQ5SnN2eXhKS0FU?=
 =?utf-8?B?VzdBenZMdlc4dnBOL2loWHBXOER3Uzhoa1U2Y3NnY1Q1THU0UEN4SnE5T0tz?=
 =?utf-8?B?cFpwRlg5d3lpVjBabEh2aW5wUU5oNHdWSFBNdWo3cm1rUFcwVFJoZXBUUFJ6?=
 =?utf-8?B?cGthcVp2NHZFTHg3dnBHNDN2RnJCdk9pbWg5TDBHdHg0WWg5N3J0alR1bHUy?=
 =?utf-8?B?bE1oQ0hkZ2xjM0MvMTFQTzg3dmdLdXB3a2I4UXRsS001OEFBNEVtbkVsM29l?=
 =?utf-8?B?aUYwTVNlNFllK2ZaS2NXd1NNVTZhdndmcTBCUXoxNUhTU0xDTUlpaDRiSGNN?=
 =?utf-8?B?SkR4eFVBRXJkQ3ZPT0gzQlF0MGlqVmJvdWJjU1ptSllETWsxSEg3c1o5akJx?=
 =?utf-8?B?REhObGtuTHNuVjdTdlFWcXFHclVBZUtIOUMxRzE0T2xMQjZtUVltdDBoUGdk?=
 =?utf-8?B?NFIyQitDc3pMR1BUcjVpTmlxbVdseGVwWFpuaGtGR0w4UC9tb0RuUXhRNmtI?=
 =?utf-8?B?RnFSTnROMVhUSUFKbi9lTHMxTngyaDFLanJxSm0reFFDVEZEMkJXY0toc3BL?=
 =?utf-8?B?QUhIQnYvNXo4cVR0WFdibXVBVXdScTd0U3cxc0luamdVVnpYNTdld1pJamFC?=
 =?utf-8?B?WGw2TkwyVzZmNnU4WUJwSjFMcHhCUjh2WG9XeVF0OGNFc3pvL21YVkdEWkNz?=
 =?utf-8?B?VktpMlJJTFU1NDBRazdmc0xiNjI1cEFvRG1zcFpzdkk2SWtweEdPSnlJdEVB?=
 =?utf-8?B?eU01NGhpV0RUajY3bWlHcHc5S3ozMXhHbXZXM0NiSUwrb1ZYcU1OcGQ4bEpO?=
 =?utf-8?B?SzgvYi9XS3dCK3dORHJPdmN3eENwWlBsL1R4WjQxVzNsRVkxd2ozWS9uZzVa?=
 =?utf-8?B?YVRkWmxRQ3E2QkVoU3N1czNnUmtNQkZRL2lFVDFWZ0hUcHJLczRGdnNnWGFs?=
 =?utf-8?B?NERKRmRRV0pwb1lXb1kvb1FEanJxK0NJR3lwdGNGVzlGd2NwSnZSMWtCT2Qr?=
 =?utf-8?B?aG5MaDVOTEQvc1JSUlZ0aGc2K0t0NS8xbHZUMDFLWDNGdEw2UzVETWdseE0v?=
 =?utf-8?B?c2lhRVFJdHB6VTU2Rlhmd3ZFVTMxSTk5ckFheCtVVFI2QmlpQWI2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e913c77-e689-4660-7e1f-08dede88a564
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:39:20.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0trtqvrq3S4oJTIC3NCC9+FXRjTrx+SgofXOQK/Lwu52w3jqrHFvkeWtywTONEcFBmeBKVSqy2xVlDVxRRYtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5634

On Sat Jun 13, 2026 at 7:40 AM BST, Onur =C3=96zkan wrote:
> Add helper wrappers for SRCU functions that are exposed to Rust
> through generated bindings.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 rust/helpers/srcu.c


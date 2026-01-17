Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022108.outbound.protection.outlook.com [52.101.96.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972F35959;
	Sat, 17 Jan 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669402; cv=fail; b=mtbHY1mQGT7+hVbTJ+moKMpVFGBnYkNIMVVxxvTPR2SZbehjmbZ2QhSLZhTGUbrbKriwNIDX+h7mBBjhfzWr6poUSYKdU6HuFC0GXVYtQpu6gm/o0CZ3m1EHwk4ZUYfcXgh1sOkMjzh0WjF5V3C1h5uSWt2sT8aBdsRj01QyVxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669402; c=relaxed/simple;
	bh=aqOCcwCfWVSY2Chs7T4nnRo7ogsAEm2n4q2nwuVxJ7U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ix1rnqbFD7RDX639yLI8ES4kbrOC253bxpV1otvkb4BJW5zTHP2MOxM052z4epyfnPpGqWhnhNFHxlK2oo5y9yrYb2CqeALW6Gi33yrYiFD5HN3IbgGE+N6NE4SBCh58giI8sc1hr90Y96AI2fL6ZASw+Jce8LqoQybZAkYLSbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TLum0tcn; arc=fail smtp.client-ip=52.101.96.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TLum0tcn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJ7xD/5k8fuBlypOmQ3BpA9j5AwmFHx6a+zmzZ9eKC1So1iazhp1KZzv74vwkXo3NKOVzN0t/KgUoKmBbX0JLQuSNnDuKfL1OHLbMW8Na9Z+vuSu6De71DzWXxNQer403i3Od76ZEhK2ChiBIfcmd7hotHe34Nw2nnyTq++LR5vJiZV8bcFPK/JO2kff3BrYY3k2gtHYrAPSl8+EByBrLo67AshbfcNVWpv9mOIQHbovPUQUmSnMogkZ05BqcjobExmmsY6Un96Kf+ffUlww1V0+YipdwVaHZIgDlI4O78TQE5KoYACcN9ZNLCl9Mr5bUVLmJscewoBHq+DqR7rvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2viXxzIoCJQ03508/1IJQFljWEp1j2YIA51mMpQgsVU=;
 b=Zc4b5acNS7YQbczLjQFGswHbShs9dsgKz51xddOFf7/JsY1eec0RIMKVwJ1CNI+lQiRtoR+zS7jhQ2RPZXS2KTp4zzp8GuNd+A7Z9kLpTpamoQT4S6UYDDc2RY84PXPyhkFZUj7Y8Roz8/A6IWnEbJiP/GthDXkUvQHh7WzYvMRWakgqC48Uh8vgNC8R4Dbir2DzGh3bNdh2tUZFiqE6tih2LLa9mspEakJGSlNVA4xIf2ZhymlxJ38QR/u0Zt3gXfpTswWIG8FAO2W/5Sxfa2WXB7lQ+IifrI+tdv97ebsSGyj308O/wRXPP62QCabaEFNoB/6186knQDCn7vpSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2viXxzIoCJQ03508/1IJQFljWEp1j2YIA51mMpQgsVU=;
 b=TLum0tcnPtCseabLiu09LfUrIh5c6Q4qsWeSxfuLsH9BNyfP2+53w3kbMAfiSs+CcIYZIYtfZb1fbDKIzoKgy4VhkLL9PSYuO7GUBTFbUtgDKBjNbtYKeD5EkufyrMmg+LNY+t8QNc61SBW/zrnSZQ07XBDLBiPxblaX/FpvINU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3215.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 17:03:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.009; Sat, 17 Jan 2026
 17:03:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 17:03:15 +0000
Message-Id: <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
In-Reply-To: <20260117122243.24404-5-boqun.feng@gmail.com>
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3215:EE_
X-MS-Office365-Filtering-Correlation-Id: 393cd55a-1c4d-4416-6072-08de55ea4ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWQ5VkVWVXhRRTYyNmFCRjhoVTJkVS9TVUpNdVU2eVJ5L3lLbElFZW5jQnVn?=
 =?utf-8?B?UXRTVUZIa1F2bUg0eGZyNzh0eldsaHRMUFVGQnFVNCtBN1JDbzcwb0JBWS9v?=
 =?utf-8?B?eWpxUzUvbkVXQnhOM0NNdkx2QnVneGt0N3R6OUVGcVJkZGdkSGVLYnlzSkMw?=
 =?utf-8?B?UjZSL1V5T2hVVHYwSFJ1b3ozK0lHZ0tDTE1YcngxZlhsRTNtazhZYjVEWSs3?=
 =?utf-8?B?MFBuc2QreUR1dlBXSzNDUjFndWRsZVRkL1dLaFhMY2hyMk5RaGhFOWxUc0tU?=
 =?utf-8?B?TktDYzF2UGs4SU16NEYvNGVLRGpQOG9CZ2RzaGFsWFFwZGpvL21Zc08vYmhY?=
 =?utf-8?B?RU9Zb29vOWpPajJ4YjZLN0lRdFNLbmVhbDdyV2JBZUMvOVB4ZkZTVVFsS3dU?=
 =?utf-8?B?SStUeWNiMlRNNTB1VmJoVDc1eS9WNFczRGFHU05MZlpDTEE0bVVoQzZqTklZ?=
 =?utf-8?B?VGRQODh5d1ZRWis1V0U4WDdyNjdRMUdLRE1Xb1QwUU5ZM3lyZThwNWhxOVJ2?=
 =?utf-8?B?cnJIUHo4MzhCMWxXTjN5WWFnM3hxNjY0c0tzZnM0T1d4Qjh5d0VNM3hIMTFU?=
 =?utf-8?B?OFdldkhCUlNHR0lDUGNWb1FkLzQzYWdCb0JoM0JRdmIzazhiQkhFTTIyVVBR?=
 =?utf-8?B?Y3hHWlZYcEduVStWVjFjSDJqWDZ1TEV2bU1VTldxemtYUG11YnVYVmY4S2tr?=
 =?utf-8?B?eG9NbUU0MHlqNzVsRE1yWVZpRWQwTTVJWDNkMElvRldsQkxmbldEUTRybG5M?=
 =?utf-8?B?YUtmNDd5eUkyRG1iZTZqRkwzVUJySGkwZXdhZ2I5VmlqN1N2akVkRGhpV0Mz?=
 =?utf-8?B?SDBSN1ZJUHJaNlZGUmg5LzZoWUF5NS9QNHJkd25VQ1R5RCtTY0dNTVc0SE52?=
 =?utf-8?B?MHJUS0EyTUhkYktqdHVJSXJPeWZONEhnSnFjZUtNamNGYXdxL0x1cGJnZGxE?=
 =?utf-8?B?REJUVENFeEVwdmVNM0dCeXhYTW80dHRmK0ZlOWZraTZVVTA5anlMTDd0T2to?=
 =?utf-8?B?N0sydWg5dkdUd1Bra1JXU2VJT0xUVkl3aVNmYStqL0VmUHhaU1pwbFc2QTJ4?=
 =?utf-8?B?WXpjbTdiQktnZnp3WEI2eHpBdmxHUGd6RzM1dzlsTGU5NWszNFA3TW5nVDFQ?=
 =?utf-8?B?cTRpZjB4OGRJV3dsNElOQVo2cTJiNitUZi83SDQ5SFFNRk95OUZKQ2FVL1BC?=
 =?utf-8?B?MGxaYWhMbkFrWnpzY2NCdEYzbjJiOFpWbk5wNkZJUmgyT2NONVRJbjRYbkpz?=
 =?utf-8?B?OXovazIwOTdsVmMxRWdNWUpXYUprK0xFSWFsV3YwR0FEUUF4UDQ2d2dySXlX?=
 =?utf-8?B?M3NSRzBuRi8rcm05TjlFZC9xdmFLMytpZEk3aFNQcDd0Zmc5SFZOM1c2MnU3?=
 =?utf-8?B?RzRLdmp4cVQ0blhLcWpYQ2c0azRSM0RDdWVxcXM2dHRxR2crR1lwSzJRMWJP?=
 =?utf-8?B?RVJpY3dhbDh1NStYSlFuSDJmNEVoMEN6TW9ZQmZ3Uk5TTStSWXFkMHlOUENj?=
 =?utf-8?B?WTBYY0cvcS9MV2JjUUs3VERDVDM5Mm5hazg0VDdqV05hQmtpeHJ5R05GZkM1?=
 =?utf-8?B?VlJMcitlUVNCU3MyM2dDcDJCL0lhYzg1cFQrdWtORkZpemdLNUExVXpzcjBK?=
 =?utf-8?B?U0lYa1RtZ1NCZjRPYUcxTTkzbW50SlVUTnVQZWoxK3QwWVFocE9vUnl2SmZD?=
 =?utf-8?B?ZXF6ZlpIRG0yZ01sQm12RzdxckdHZ3V4cHlQZG5WcDg1TSsrUnVMY0s0TGdV?=
 =?utf-8?B?RXpQTFA1T3RjMURPaVR5SVB6VXZWTEZXMFNIb1hJQyt6MmgzZnlPeWxTQUk2?=
 =?utf-8?B?eUdSZWRNNUdPYjNKWHZhOXk0M3o5M09mRmRzcWZkalVLWmppbUFZV2dvMVZM?=
 =?utf-8?B?NlE5WXRPb0s3dy9NU0RjQUN6ZmdhWUNHd0VtaGNPOFpSeW9UbnZIRmcvV21k?=
 =?utf-8?B?cDVBVGcwL2NWTlNOMCtUS3dsMFU1MGVnRXpDdDRGMGFSOUlBMUYyeDJtRkN1?=
 =?utf-8?B?Nk1RRWdGWDZzZ2pIb0FGUVAyTEl4QTJoTy9jQW95TTlpcG51UXpqVXgyTlJj?=
 =?utf-8?B?RGI5VndEQVhSaWFKSDVCM2VRMmJVdGRoQm4yYjRReS9qazVvMUFocnRidjg4?=
 =?utf-8?Q?i0R8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q09IZEpBdENKOUtYNzJqRDYwcHN3YjBjeW9OdlNxRm1hd1d2STRadXpka080?=
 =?utf-8?B?eC9id29uRFZLSFRoTnpXc09sVmpxZndqYkRaUGN2UTVQRUpYSEZ4QkQxRnhM?=
 =?utf-8?B?bmJqeThyMEJ5cXovR21hQk1JSVViZlZlSFJHRmpzUGJ4d2o5Y05hNEtOSnFJ?=
 =?utf-8?B?NDNjeWxLVk5ydmhkWEVuc21EblNOcmlycnVpRGZRdHBoRkxQbU9uRnBid3Vs?=
 =?utf-8?B?a2N2OHl4VFpKVjZwVXdCa3VtOXdnR3pkV0EzUHpmWGEwUndiOWd6VkNKckNy?=
 =?utf-8?B?MXBKODVITng3cTNlbTg2amFkTUo1MGRNdGF5VVNrMlhoTWY1UWZETENwOUYx?=
 =?utf-8?B?NjRTaWtkQ3VVM1FvZVJLR0EvQmVWeUhQZEpRdlVta3ZhT2JINzRIejZFbnps?=
 =?utf-8?B?YXROK2lIVzgzeFFicHlEbVFQSWlmNE9CZW1QczlLMG5idUVrL3JZTmxvVkx0?=
 =?utf-8?B?TXpHU1hBSFh0N1JQZUQ1VS9jK1JCbmRXN0FpRytyMjBzblBsSmVmRS8xS0J4?=
 =?utf-8?B?ZG5lQ3R3a3B1WjQ2S2VxSFFlNXgrTGg2UVc2NUpqZ0o5YzIva2pPZG1hWXFU?=
 =?utf-8?B?QWZjV0FwZDAwTjc3dVRMVnNuY2VGTzlxbmZ0Smt6NEJEcnMvckhOSnkvQ0Za?=
 =?utf-8?B?V2E0WStqeVo1NW5MaHUrRUlCTklOdHlqdlYrQkNGWFhJMm5pbEhKaTRqR3k5?=
 =?utf-8?B?c0hwMHVrSXZNT0FlT0xlNFhBRkMvY0t1bTMwUDFhNms2SFpDN20rOGhwOGs5?=
 =?utf-8?B?WlBpeERGRUIrWmE3L3IzQmVMU1JCOEhoblgxZTZUT2pTUXh5MmdzMjlxNmFv?=
 =?utf-8?B?YTI5L3NFZTVNbjNCYmxZVmlDV25XVWNYektPN2dpZDl2eVd4M1FUY2lneXZO?=
 =?utf-8?B?WENZMmNoeFk1RTQzMW1ZNVpvRWtyZlR2MGhkeFMzbjdQTUYxKzd3ei9ybjhv?=
 =?utf-8?B?eSt5R21xK0lYdG5PcGdmZkxtNENEV0JkYi9ET3JQN3FKc0YyWU9YZ2x5WTVs?=
 =?utf-8?B?N2NoNXlvZmJVNUQyY1N5UmVjVjI4ZTZvREF4cUhYUlpQdXVuNUU5TGYyVlQ3?=
 =?utf-8?B?SkU0RFlJL1ZvbkYydnJ5cEQ0K1o0WERHRnBlSExZRC9hRnUwbXZUZldtL25q?=
 =?utf-8?B?cHByVlNlb29rWkJLaSs4R0sxdE1hWDFUYWtheU8xdE5JODJ2L0JpQ0FIclhp?=
 =?utf-8?B?aG9rMmlpRVZsWkdBR2RpYzBTdnFKUjE2dmMzRHhoN1V5QnNhYWZvdTdHQ3Vp?=
 =?utf-8?B?STI1L1VobW96aTNJMFh2ZDBPbU9ETGhDWm1wVEo0WWhaNldveStTUWlUUGxh?=
 =?utf-8?B?YklvRVB6N0FOaDdWaWdZK2prQmcvMDhaWFlPM3ZabXZ5enBobm1QNW9yRk91?=
 =?utf-8?B?VFF1a3AzbDFvRkl6Q2Z6SFpiQ013OFdwRnI3Z3dZRG0zNzZDS1lOa1hTL1p4?=
 =?utf-8?B?aDBhN1VtVlZpeGFib05xOWZYMm5XdUhIV3BOMEE5bjBwQnV0QnFvejVBbHNy?=
 =?utf-8?B?L0d0MGFwakF0Znl5WGhEN3JXamc5VjNyWEhheFZEdmVxaHJ4cDBiMU8vM0tU?=
 =?utf-8?B?S3FST2hQRDBHWG84azhKSzlhZkV3bGEwQ2o2d2RvU0RiNEt1SkZpZEg4UUc0?=
 =?utf-8?B?Lzl0cFJDbVVRQzdiZktucStoNW1Sc043RkEzblBWWm9OMTkxYmpWOU1tSE9x?=
 =?utf-8?B?WnJEb0NUaWErWnkvMVVTb0FSK1FwbDc0T2p6b1IyRlFSOEZJRGR4NTB3RmFt?=
 =?utf-8?B?azdLTkd5UkxPRUx6N0FOREZYWE05Q3ZJTk1pbUtlU0dKZWZ1ZmFtRmgyZlhu?=
 =?utf-8?B?YWNrTGsxOWI2eUU1VmhYVmYza0F1TktMSVAwVlE2cUVlT0xVTUZSQm9TUHc3?=
 =?utf-8?B?c3hGZHUrWHdzRkJqZ3NTUGVac3ZoOXhDZmtrRGJXeks0RlVVWkRhUzRyeW5n?=
 =?utf-8?B?cWsvWmQ1OE5LS1NJU3FyMW9qd2FaclFkOElqRk5VVXhBTHAzb3FwY29OUGd2?=
 =?utf-8?B?SjdBQkJLMUtLZzBOaDdEZllOWmJUc2RnUVgzTkFhL2pRenFHRUpUL1g1MWVN?=
 =?utf-8?B?STl6MndnYnJIT3c5NlN6SUtGY1dabi9ZNk9YV2FzYk9oMUFGclhwMUFSVFlF?=
 =?utf-8?B?K1Vaa3FYZGJYQkZ0MnAxVTZ1ZkRRYmhqSVBDdGRFTnNGb3ZuKzg0Slp0R3Qv?=
 =?utf-8?B?VUNQVmZqdXFzTEhVT2NINVlrbWE1L1hvS1V4WVlsRndtWVhEZStvNnltN04z?=
 =?utf-8?B?SjlnL2J6QTRHTVAwOVBCT1Q2UTYzNFRyd1hTNWJuSlZvSkF0aFdIOHZuUlhy?=
 =?utf-8?B?U0lIYUdCR1dpRENzcDYyZ1BOS3l4ZDdBNG1zejdVTGdTSEl3LzVBTDVkR3JN?=
 =?utf-8?Q?z/zjr+eT8882E3qUMKWCOtz8WVLTNDA6GWzZR?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 393cd55a-1c4d-4416-6072-08de55ea4ed2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 17:03:16.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OTJOSv4AELkXfZhzz6CMhiiRNpw3FQUT+KMO1Y67eNoofMhHRCLjf831iLQo5xvLXWTQgsqL1YoYnCtFs8PFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3215

On Sat Jan 17, 2026 at 12:22 PM GMT, Boqun Feng wrote:
> Atomic pointer support is an important piece of synchronization
> algorithm, e.g. RCU, hence provide the support for that.
>
> Note that instead of relying on atomic_long or the implementation of
> `Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
> atomic pointer specifically, this is because ptr2int casting would
> lose the provenance of a pointer and even though in theory there are a
> few tricks the provenance can be restored, it'll still be a simpler
> implementation if C could provide atomic pointers directly. The side
> effects of this approach are: we don't have the arithmetic and logical
> operations for pointers yet and the current implementation only works
> on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
> issues and can be added later.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

I am happy that this is now using dedicated helpers for pointers, and not g=
oing
through an intermediate integer which can lose provenance.

Some feedbacks below, but in general LGTM.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/atomic_ext.c            |  3 +++
>  rust/kernel/sync/atomic.rs           | 12 +++++++++++-
>  rust/kernel/sync/atomic/internal.rs  | 21 +++++++++++++++------
>  rust/kernel/sync/atomic/predefine.rs | 23 +++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
> index 240218e2e708..c267d5190529 100644
> --- a/rust/helpers/atomic_ext.c
> +++ b/rust/helpers/atomic_ext.c
> @@ -36,6 +36,7 @@ __rust_helper void rust_helper_atomic_##tname##_set_rel=
ease(type *ptr, type val)
> =20
>  GEN_READ_SET_HELPERS(i8, s8)
>  GEN_READ_SET_HELPERS(i16, s16)
> +GEN_READ_SET_HELPERS(ptr, const void *)
> =20
>  /*
>   * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
> @@ -59,6 +60,7 @@ rust_helper_atomic_##tname##_xchg##suffix(type *ptr, ty=
pe new)			\
> =20
>  GEN_XCHG_HELPERS(i8, s8)
>  GEN_XCHG_HELPERS(i16, s16)
> +GEN_XCHG_HELPERS(ptr, const void *)
> =20
>  /*
>   * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
> @@ -82,3 +84,4 @@ rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *=
ptr, type *old, type new)
> =20
>  GEN_TRY_CMPXCHG_HELPERS(i8, s8)
>  GEN_TRY_CMPXCHG_HELPERS(i16, s16)
> +GEN_TRY_CMPXCHG_HELPERS(ptr, const void *)
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 4aebeacb961a..4d2a5228c2e4 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -51,6 +51,10 @@
>  #[repr(transparent)]
>  pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
> =20
> +// SAFETY: `Atomic<T>` is safe to transfer between execution contexts be=
cause of the safety
> +// requirement of `AtomicType`.
> +unsafe impl<T: AtomicType> Send for Atomic<T> {}
> +
>  // SAFETY: `Atomic<T>` is safe to share among execution contexts because=
 all accesses are atomic.
>  unsafe impl<T: AtomicType> Sync for Atomic<T> {}
> =20
> @@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>  ///
>  /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
>  /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> +/// - [`Self`] must be safe to transfer between execution contexts, if i=
t's [`Send`], this is
> +///   automatically satisfied. The exception is pointer types that are e=
ven though marked as
> +///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `unsa=
fe` to do anything
> +///   meaningful on them. This is because transferring pointer values be=
tween execution contexts is
> +///   safe as long as the actual `unsafe` dereferencing is justified.

I think the discussion about `Send` on pointers should be moved to the `imp=
l<T>
AtomicType for *mut T` side.

>  ///
>  /// Note that this is more relaxed than requiring the bi-directional tra=
nsmutability (i.e.
>  /// [`transmute()`] is always sound between `U` and `T`) because of the =
support for atomic
> @@ -108,7 +117,8 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>  /// [`transmute()`]: core::mem::transmute
>  /// [round-trip transmutable]: AtomicType#round-trip-transmutability
>  /// [Examples]: AtomicType#examples
> -pub unsafe trait AtomicType: Sized + Send + Copy {
> +/// [`NonNull<T>`]: core::ptr::NonNull
> +pub unsafe trait AtomicType: Sized + Copy {
>      /// The backing atomic implementation type.
>      type Repr: AtomicImpl;
>  }
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomi=
c/internal.rs
> index 0dac58bca2b3..93f5a7846645 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -7,6 +7,7 @@
>  use crate::bindings;
>  use crate::macros::paste;
>  use core::cell::UnsafeCell;
> +use ffi::c_void;
> =20
>  mod private {
>      /// Sealed trait marker to disable customized impls on atomic implem=
entation traits.
> @@ -14,10 +15,11 @@ pub trait Sealed {}
>  }
> =20
>  // The C side supports atomic primitives only for `i32` and `i64` (`atom=
ic_t` and `atomic64_t`),
> -// while the Rust side also layers provides atomic support for `i8` and =
`i16`
> -// on top of lower-level C primitives.
> +// while the Rust side also provides atomic support for `i8`, `i16` and =
`*const c_void` on top of
> +// lower-level C primitives.
>  impl private::Sealed for i8 {}
>  impl private::Sealed for i16 {}
> +impl private::Sealed for *const c_void {}
>  impl private::Sealed for i32 {}
>  impl private::Sealed for i64 {}
> =20
> @@ -26,10 +28,10 @@ impl private::Sealed for i64 {}
>  /// This trait is sealed, and only types that map directly to the C side=
 atomics
>  /// or can be implemented with lower-level C primitives are allowed to i=
mplement this:
>  ///
> -/// - `i8` and `i16` are implemented with lower-level C primitives.
> +/// - `i8`, `i16` and `*const c_void` are implemented with lower-level C=
 primitives.
>  /// - `i32` map to `atomic_t`
>  /// - `i64` map to `atomic64_t`
> -pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
> +pub trait AtomicImpl: Sized + Copy + private::Sealed {
>      /// The type of the delta in arithmetic or logical operations.
>      ///
>      /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usua=
lly it's the same type of
> @@ -51,6 +53,13 @@ impl AtomicImpl for i16 {
>      type Delta =3D Self;
>  }
> =20
> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence th=
e atomicity is only
> +// guaranteed against read-modify-write operations if the architecture s=
upports native atomic RmW.
> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> +impl AtomicImpl for *const c_void {
> +    type Delta =3D isize;
> +}
> +
>  // `atomic_t` implements atomic operations on `i32`.
>  impl AtomicImpl for i32 {
>      type Delta =3D Self;
> @@ -262,7 +271,7 @@ macro_rules! declare_and_impl_atomic_methods {
>  }
> =20
>  declare_and_impl_atomic_methods!(
> -    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> =
atomic64 ]
> +    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, *const c_void =3D> atomic_=
ptr, i32 =3D> atomic, i64 =3D> atomic64 ]
>      /// Basic atomic operations
>      pub trait AtomicBasicOps {
>          /// Atomic read (load).
> @@ -280,7 +289,7 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
>  );
> =20
>  declare_and_impl_atomic_methods!(
> -    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> =
atomic64 ]
> +    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, *const c_void =3D> atomic_=
ptr, i32 =3D> atomic, i64 =3D> atomic64 ]
>      /// Exchange and compare-and-exchange atomic operations
>      pub trait AtomicExchangeOps {
>          /// Atomic exchange.
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atom=
ic/predefine.rs
> index 42067c6a266c..1a4670d225b5 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -4,6 +4,7 @@
> =20
>  use crate::static_assert;
>  use core::mem::{align_of, size_of};
> +use ffi::c_void;
> =20
>  // Ensure size and alignment requirements are checked.
>  static_assert!(size_of::<bool>() =3D=3D size_of::<i8>());
> @@ -28,6 +29,16 @@ unsafe impl super::AtomicType for i16 {
>      type Repr =3D i16;
>  }
> =20
> +// SAFETY:
> +//
> +// - `*mut T` has the same size and alignment with `*const c_void`, and =
is round-trip
> +//   transmutable to `*const c_void`.
> +// - `*mut T` is safe to transfer between execution contexts. See the sa=
fety requirement of
> +//   [`AtomicType`].
> +unsafe impl<T: Sized> super::AtomicType for *mut T {
> +    type Repr =3D *const c_void;
> +}

How about *const T?

> +
>  // SAFETY: `i32` has the same size and alignment with itself, and is rou=
nd-trip transmutable to
>  // itself.
>  unsafe impl super::AtomicType for i32 {
> @@ -215,4 +226,16 @@ fn atomic_bool_tests() {
>          assert_eq!(false, x.load(Relaxed));
>          assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
>      }
> +
> +    #[test]
> +    fn atomic_ptr_tests() {
> +        let mut v =3D 42;
> +        let mut u =3D 43;
> +        let x =3D Atomic::new(&raw mut v);
> +
> +        assert_eq!(x.load(Acquire), &raw mut v);
> +        assert_eq!(x.cmpxchg(&raw mut u, &raw mut u, Relaxed), Err(&raw =
mut v));
> +        assert_eq!(x.cmpxchg(&raw mut v, &raw mut u, Relaxed), Ok(&raw m=
ut v));
> +        assert_eq!(x.load(Relaxed), &raw mut u);
> +    }
>  }


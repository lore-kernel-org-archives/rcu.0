Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0DF410D3B;
	Wed,  4 Feb 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214816; cv=fail; b=Fsw00EZmV/cq5DmtwKqyt/KubHquK1ygqqnDi7x8G4yapryjXpZs4pOEj/mZ74I3UPHG0XF/vseOZnIgDF2/4RWH9sW2I7NprzVG8eGLg8OdUH2vw6u+90dQj6/sWVXJfvvi3vUDKrh/H0zFB0kudOdTnPS5DiQ+Nq6Re2QTGRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214816; c=relaxed/simple;
	bh=9s3cG9tJ8qorrvrBx74cCEHApERffYBvE4nnGvOCXtU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=eJa4Iz3qfkp3PiTY9c9OOnxgz1yxztMch1azCXP2Ow6flsK4Ls2O2zNQQ+MDG88kX/eEE2MGLmXJJiE0oRrXQ12DnXWdDm1BkJ4oFf98gXkXRMs5aecc5YeKHoZPX+UVIChqX7PG+Iu99xrquhzIhQ1RFvouBrPMpySMgydVYcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UdLI0Upe; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UdLI0Upe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw1KhWba4B1cWPK0p8et+gNMmjpvG4r8k08KrK0SJalhyFkN/kqVh5dSZrc3VrYTJz1XG/sZMrgDRoY7Ctq87sLKHUXAE+KvKyjvQq7c2UgXWu3KhBDAv/TgI8UQKTm9n7RmAsnKg7zWcb1JsRd6LIGdXEa+dwVM3Gs6TD63vKfrg/HTxZmh1HbEUJUmrisSZ3pzeJNjHH1bejoZ1dqh/SWZoqxcvvSxZFelWNagw3Uzz9gFpjqGlhtMHEY0kf/v0flM2hZexwt8vv+w4uhFwDlMTQ8OdJlQ92Wlfa2BKt5g4ks2xY2C7tPBkK3AN4C9T67UzVgkHeeP/1qgiW4hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOVhdyrxxH9+T1JWyQG40jenZ8luBmRttpuUHr5bRZ0=;
 b=q+pkCjUgP3h2nZQz2zjDTY+5AGTi/G1nehSvPxojPvEVu3LNMnPJW0T0ZhD07ttQUUfw9mgSSCuR9RYY3HCRbC0RuOETk/ZLV4TSozTZeGdTr46PCJZnp+cNKSOpulq9ky20nv6BZZ1yrQVjdkvsns+8idyjL74/228kFx8088WELyTPWJo5x7uGkPf3y70HD6KJ2BhdtLbfxtjLj0IN2qLaFeUdMELiX3PPmvDaAIJOpiZIQhXNow5yJMvaTfLKD+eJ8W9+5YNFAyL7gVPPZxM83xb3Na71jp9UgLmbb18YrKLfzJDWHiMlc6uiMswLCbwfYYTzvWBZsf82ZXlZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOVhdyrxxH9+T1JWyQG40jenZ8luBmRttpuUHr5bRZ0=;
 b=UdLI0Upewukpz0NfIdgK29iw+xu6ikQ4dbzfNiwk3gL4SA72UooYxYbs5GDjCWLXMRMlgZuPHZubcTFPBk7iyFt9gKP5WfUuCoJAt8GuCBjtW8XqXBhE40iKEsXOHRAJiVu4yLMGsVTnmO45qDInfV4MgiBg8oay/3aWHTfevNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8476.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:471::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 14:20:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 14:20:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 14:20:09 +0000
Message-Id: <DG68S0UN78BE.QUG4A0Y08XKN@garyguo.net>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 "Vitaly Wool" <vitaly.wool@konsulko.se>, "Tamir Duberstein"
 <tamird@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "David Gow" <davidgow@google.com>, "Peter Novak"
 <seimun018r@gmail.com>, =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?=
 <jose.exposito89@gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce HasField infrastructure
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <rcu@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260128215330.58410-1-boqun.feng@gmail.com>
In-Reply-To: <20260128215330.58410-1-boqun.feng@gmail.com>
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9b01f5-bb65-419a-1730-08de63f88168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlFTNlhrZXo3MWtTcTNxRjhTWlROQ09ReHJTMnNmRkhKcHZteHZWWit2eUh0?=
 =?utf-8?B?Nk1nMEIvRlJaMWUydDdmOXFyTkx2NUhFVUNRWW8xQlkwY3RuUng0ZDF3eG5R?=
 =?utf-8?B?akE3MElITVZOd0lleU5ISXJWc2ZtZVFaeVFQWmNTempiU2ZwMVczdi82Kzl2?=
 =?utf-8?B?RlRSY1NuRUYvUjl5Y2w1M1pTL1BubkNEUFFXcVlhM2VFbUkvL2M5WS8zaGVs?=
 =?utf-8?B?OUtZWEpmY0ZKcktUWFVTelM0Y2VLMVlwVzZLOStuajlBQTBhVUNuZUxka3B5?=
 =?utf-8?B?OUM2Tkp6cm1KRUpRWE02aitUUHJvUk1LNTZlWUEzMk9sWDQ0RjlRdFBBZzRN?=
 =?utf-8?B?Rko4YlhiSElmSUh2ZEh6VDg3UzZoRGZsV3JNUDNZbjhtSk53bExFU2d1WWc5?=
 =?utf-8?B?NDJXc1lmbGM4Q0pMLzRPQ3dhS2ZVa1hMNEtHTDNCUktvZUoyc0ViNDFaQVR4?=
 =?utf-8?B?R25GbTlSdVQyeHhuVXdQMWdHTVhMdCtxbElnaXZ0VG5Hdmkvb2JRZ1lIcHcw?=
 =?utf-8?B?RkN1eWdFbHJoejNueUNwM003K1pHUmd4SkRsR1hKVjJrRzN3c045Uk1EN053?=
 =?utf-8?B?QXNEN2hXM0MxT2JDalpOZjlYUXlTT25ieHNwS0NhcTdvRFF2SU5mNnZRcGpG?=
 =?utf-8?B?M3BJQ1lxVFVGZlhhY0xOV01pWS9oeGNIZVBSczYrVitHdll2anA1aUswL1Ir?=
 =?utf-8?B?WW0wMjNBMGlqT1MrMWp4Mk1hb0s1bVBOZTJvaWxjOFdESVAzbUhqOU82NW9t?=
 =?utf-8?B?Z1poMkdBZEljZDVBVmhtbmpqNThBUkFrS0pnOTkwTk1QYy9lRFBjMDVydUMr?=
 =?utf-8?B?WFl0UVpHQlpSRmdKV1Y5NXBkbHFuMDUvRlFEVkJNQzFYTjRHaCtOMEhpTkFW?=
 =?utf-8?B?bU10ZHZCYW1MR1J6N2syQW5JZmNOVFBXTVpYanJiNUx0WHlFUyt2R1NUYzFO?=
 =?utf-8?B?WlFIOG1sU1BjWC8ySllaWEVJWVE3QVVvUGY2YXhZSHZ5MWJvOGZqL1VYc1A2?=
 =?utf-8?B?eFlwU2VqL0hFbDVCeVJNZjhPcEc4dzZOZGJaaWIyWVE3QUxlRGRYNWZMOHhN?=
 =?utf-8?B?M2lSTmc0U2lFdmltZXhJVTE5Sjg4TWlwdTlhcFNkNmdpbzJ5MEUyMUlZTkJ5?=
 =?utf-8?B?TUJYTVg3bUcvVm80M2VUeEI3dHJ1MVJIMC9OQThrVThhaytTcnI1dEcwOU9n?=
 =?utf-8?B?MU5NcWg5bnhibzEvNGpBbnNVWDdwenE3ZEtDa1ErTnByN0h6WTZpRFQ1bGJw?=
 =?utf-8?B?RUFleW4yYktGamxGWmM0WGQrUVltTmJnQXRoNHF5UThpOW55MHpXM2MvdVZ6?=
 =?utf-8?B?TWpqWlVEQlE2RThWQ0JOUGsvelI1bFpmMnd1SHZhNFgxeklmMnk3NndzV0c5?=
 =?utf-8?B?Q0t1MkpWanRHUjByR0ZBWjR4eGg4bGo0QlQvSENZMTlUSUpzSkpHTTgzWWwr?=
 =?utf-8?B?MTZ4amN4dmhsaFlWUVBGUXF1dXAvbHpYM1ZRTHZTUS9IaVFkSTYrT3JCNzVx?=
 =?utf-8?B?dzNFdlliM2JyNG9wTk0ydzdOSkVvWXdNaHZjNDlPUWE5RHVDZExGdm1nOFhp?=
 =?utf-8?B?UjhwOEM3S1c3ck81QkZkVnJVbkNYcno4cnpYUXV2TUY0Z2ZveHpZOXBDbGxT?=
 =?utf-8?B?U3hhMG0rNzFpdmlsSGVaL3dtUTROcTRySGdhWkc3c2FUd05JZmllUFQzdzdS?=
 =?utf-8?B?TjlBQitrMWthRjcyeTVFWUU4bDVzRkZQVHFtQm5sY0dTMUpJZkhvTlA2eGRI?=
 =?utf-8?B?a3Zqa0liM0loY0ZVVUNBaC85QTA1bHpBYWdxSE90M0w4Zk1IWTVvL0p2Zk1Z?=
 =?utf-8?B?TzBiNE01MnhqTmpsTE1aWU90NFRXRXVEU0NzSFlWbDFnSWhxbloyS2UzVXM3?=
 =?utf-8?B?cHhaY1p5aS9BM0hicEdrVlU2eGJvWEZYQkY2TWdYZ3hEUU1ySnBNNTJ0WG9D?=
 =?utf-8?B?UXVlVmJTTUQwWnRFTWcwNStOcm1uckZJcW8raGJpQ3QrWG8wNHpPMXlhZDVY?=
 =?utf-8?B?RjVyMmNWaEZWM3JKcGRqV1NyVUh2aEdGQnhYWE1MQ0RGTTU5c1BCQUh2bGFv?=
 =?utf-8?B?SkpRL3VSWnA2NWhoOCs1RWpyb0p3Z0U1RUY0SHhaRDVOQlY5Q1Z2blFXUHg0?=
 =?utf-8?Q?+faM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1tT05iQ2tId1FOK0tHSkduUUV5a2RQeWFDYzU3Y1N4SmRMbmt4R21rUlkx?=
 =?utf-8?B?c3BES1Q1UFRRZUQrSGV1OW1aRTJqUkRPdkxiNmZJRjBtc211blhiSUJXQWw4?=
 =?utf-8?B?M1JhL2ZOWjVuU3lxYlQ3ZytYY1lsTjB0bm4raXJQWm44bnV6RXl4TlVZYVcy?=
 =?utf-8?B?TmFHbDdnZVRxV3NHNjRTd1gvMEZjVmNySG5Id1lYMGgyVmUwU0F1TGNqZmk0?=
 =?utf-8?B?RXZYZk03Y3dFNDBFalVaekNNQTlZZEE3RDJBK0MrdXgxTnJYb0M4c1hYUHl5?=
 =?utf-8?B?MUdRVERTWTB2OVNrZXdZaTlUMEhpWG9NMDZHTlJ1N09hTU9YU0c5VlpKUnJs?=
 =?utf-8?B?UjBQUTdJNUJHZVRaS0hkSlZaK3RSVU11S1JSankrR3J5WFMyVGE5SmtPdnBV?=
 =?utf-8?B?U3g2Smc4c1NzT2IrSFI5VGNoSXRGUDRjbno1Z1QvWXV3V09oemRwdDR2Ry95?=
 =?utf-8?B?cTFwZitaM1JRRW1KS2pPREZ6OTRmclRIV3NWQzRWdldWdkZPMzB2OCtvaGhW?=
 =?utf-8?B?MGxOanpOQklqWUhVTGovVHh0TGJQL3pkL0lrb2tUVnhid2xRZjdGSTRncDVY?=
 =?utf-8?B?R2xvKzIrS1RtamhOWGV5clJoRk43WFBaSkh6WVgydHBqYTB1ZTN6Nnk2M3NR?=
 =?utf-8?B?K3gyeXR3TDFtZ3U0dFpLUE5XaFJqa3RyYTZJSWI5QW9wVkRZdE4rb0NaWTEx?=
 =?utf-8?B?ZzJKUDVialhhSGRiSFdJMkxMKzF2aURMYlExelJiR2duM1BTNkxFTVdrVW52?=
 =?utf-8?B?LzAxaTFKaFV2cW51dmt2UVk4WEQxK0lzSDA0OERCbmtoRytaazNqYVNTakFr?=
 =?utf-8?B?cUYyejgxVGVyWEdOWFM4MEkxL0dBVDdiNlcyb2tiSVBDN09aZHFZd0N3T2tt?=
 =?utf-8?B?ckNEZWVVZzVVRzY3ZkNMQVNOVTdwOXlEVXZ6LytUSkRzeTd3dUdiTEV3VDdX?=
 =?utf-8?B?aW8zVXBYRnR2TkVBT01KelNSL3RrRXVzRGFNYkxLS1lCUnd6NUFHZWxQeUYx?=
 =?utf-8?B?elJFR3J5ZnpjNHBqZ1ZQYnp2dENpVkhLbmlKUmVXZjFVRWd6MmF2QzVqL3dt?=
 =?utf-8?B?NnpwK202MlpIRlFyTkVwcVhOUVNiYUdKUVd2Rmkrakd4STNsTjZvaWhwd1VD?=
 =?utf-8?B?UmhmQUpMODRvM2VxdmpjcnMyNWREUzB6MGNKNVh0S3IwR3FNdk9MOC9oQTJD?=
 =?utf-8?B?YkF2aG9tTWF5U3RWYzlwRUxtVE5PNmttdS8xRDRPalR1emRTdm8vVFZjMWVz?=
 =?utf-8?B?SVdxd2tpaEQwRXZmMzNxTzJGaEwwL0Zra1FaOFdZWTdaTlo1SFhwZVZMYmhq?=
 =?utf-8?B?eDhjRWdqOHNoVHlMNlQva0dhalhDRHlmcDdpeEd3RU51M2h0Uk4zL3FmVDlG?=
 =?utf-8?B?MVBDaEFCMWsrTkNWaGVFQVFwbldZYXF3TzQyM2Z5NWZHZ3JnNjFIdEhwK3NM?=
 =?utf-8?B?Q043Z2daQ09RZitGM0wwWjUzbGVsYVhDWS96T2lnVmhnZHBGdmJZSkVnNEZ5?=
 =?utf-8?B?eDczS2EwWkppY0YwdklGV091c0dhZmJVTHhiSWVwb2p1MVpRTG1UYUo1K2hJ?=
 =?utf-8?B?ajJBc3F2a3QxV0RiNDd3UklHam9mcURSVzJOTjg4eFpGbEY1Q3ZaY3V3NlF2?=
 =?utf-8?B?L28xUGQ1NWpKcktNRzRlNHNUTVBWWE51UVlNWU5xSkJ3azZraWc5NWpEakZZ?=
 =?utf-8?B?NWtOc2JGa0Y1L1hzZkhKS3p0bzFMNWYzaXFtU201aG53MFdFL01RSFZISyt0?=
 =?utf-8?B?TXMxbU14WFN5emlRdFV1K3FKZjJibVZReGwwbVkrU3lGcUpTRjhkZmlmQmI0?=
 =?utf-8?B?bGJ6dHNST0FKV3M5a1F2Mk9iYkk2c1l3OTVGamZJa3M5d1RmWmJ6L21GV1hl?=
 =?utf-8?B?dEkrYjg2WkVLak1VRjZnRkw3VW9tYmtnSEtHdmVYRVUvR0xWbnhIenZHOVhL?=
 =?utf-8?B?Mkd0ZFBrcm1rN21idlZ3ellCNTVSRm5idjRwRkNqQ0xyRUVvT0xkSGZOSHY1?=
 =?utf-8?B?eDJhdk5FN3BNblN6aE9ydmNNRGJ6ajhGNEp4d0tFbGZNaWZkZ21LdEZsck5s?=
 =?utf-8?B?MTl0SjVzcHRVUmxwN0R6Zmo5eEx6dEh6U2V4N3hqTWZuWStIbTkzc0ZEdnE3?=
 =?utf-8?B?K1JiT3B3QnJ0L1hzOFNvVHdQbU1nMkZkdnA5ZXZNZjJPVURvTGcySWFTWTNC?=
 =?utf-8?B?ZGdDZjhJTHNQaFZUTit5Y0hNckw3dFZZaWhFRHJyQUhXblUyRHJDUHRPekhq?=
 =?utf-8?B?UDRsN0hZTEZQOVFNT29DTU5CRDhiVGNpTXgzczY3K1lxRDNiY05taDVKS0g3?=
 =?utf-8?Q?/Gmxgn8vaZ9vPhXM5R?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b01f5-bb65-419a-1730-08de63f88168
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:20:10.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e+8cEae7dkQILSL2Mi20k0ybGZI8NTnmaB1TDeSL4ja8O5i/QsAhuHXzgcFQuqtXzpwAK8+Ai+k2f2yvU4CiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8476

On Wed Jan 28, 2026 at 9:53 PM GMT, Boqun Feng wrote:
> Currently we have a few similar places where we use a `Has*` trait to
> describe that a data structure has some types of field in it so that the
> containing type can do something with it. There are also a `impl_has_*!`
> macro to help implement the trait. While it's working, but it's less
> ergonomic to me, especially considering the amount of the work we need
> to do for something new (e.g. rcu_head).
>
> Therefore here is the effort to unify them into a proc-macro based
> solution. `Field` and `HasField` traits are introduced to generify the
> "Has A" relationship, and a derive macro `#[derive(HasField)]` is also
> added to support automatically implementing `HasField` trait.
>
> This series convert a few users (Work, HrTimer) and introduce a new
> `Field` type `RcuHead`. These improvements demonstrate how this
> infrastructure can be used.
>
> Some future work is still needed: using `HasField` for `DelayedWork` and
> `ListLink` is still missing. Also it's possible to clean up `HasWork`
> trait as well.
>
> One known issue is that `#[derive(HasField)]` doesn't play alone with
> `#[pin_data]` at the moment, for example:
>
>     #[derive(HasField)]
>     #[pin_data]
>     struct Foo { .. }
>
> works, but=20
>
>     #[pin_data]
>     #[derive(HasField)]
>     struct Foo { .. }
>
> doesn't. Maybe it's by design or maybe something could be improved by
> pin-init.
>
>
> The patchset is based on today's rust/rust-next, top commit is:
>
> 	a7c013f77953 ('Merge patch series "refactor Rust proc macros with `syn`"=
')
>
> Regards,
> Boqun

Hi Boqun,

Thanks for working on this.

You currently divide things into two traits, `Field<T>` which doesn't seem =
to be
doing anything (actually, why does this need to exist at all?) and
`HasField<T, F>` which defines all the field projection.

For some prior art that attempts to have fields, e.g. my field-projection
experiemnt crate

    https://docs.rs/field-projection

and Benno's work on field-representing-types in the Rust language, we opt t=
o
have a type to represent each field instead.

I think we should have a unified projection infrastructure in the kernel, f=
or
both intrusive data structure and I/O projection and others, so I think it'=
s
useful to have types representing fields (and projection in general, this c=
ould
also extend to the `register!` macro). For clarity, let me refer to this as
`field_of!(Base, foo)` and the trait is `Projection`.

With this infra, the `HasField` trait would simply looks like this:

    trait HasField<Base, FieldType> {
        type Field: Projection<Base =3D Base, Type =3D FieldType>;
    }

and the macro derive would generate something like

    impl HasField<MyStruct, Work<MyStruct>> {
        type Field =3D field_of!(MyStruct, name_of_work_field);
    }

Best,
Gary







>
> Boqun Feng (7):
>   rust: types: Introduce HasField trait and derive macro
>   rust: time: hrtimer: Make `HasField` a super-trait of `HasHrTimer`
>   rust: workqueue: Add HasField support for Work
>   drivers: android: binder: Replace `impl_has_work!` with
>     `#[derive(HasField)]`
>   rust: sync: Completion: Replace `impl_has_work!` with
>     `#[derive(HasField)]`
>   rust: work: Remove `impl_has_work!`
>   rust: sync: rcu: Introduce RcuHead
>
>  drivers/android/binder/process.rs |   6 +-
>  rust/kernel/field.rs              |  73 ++++++++++++++++++++
>  rust/kernel/lib.rs                |   1 +
>  rust/kernel/prelude.rs            |   4 +-
>  rust/kernel/sync/completion.rs    |   8 +--
>  rust/kernel/sync/rcu.rs           |  69 ++++++++++++++++++-
>  rust/kernel/time/hrtimer.rs       |  70 ++++---------------
>  rust/kernel/workqueue.rs          | 109 +++++++++++-------------------
>  rust/macros/field.rs              |  85 +++++++++++++++++++++++
>  rust/macros/lib.rs                |  11 +++
>  10 files changed, 299 insertions(+), 137 deletions(-)
>  create mode 100644 rust/kernel/field.rs
>  create mode 100644 rust/macros/field.rs


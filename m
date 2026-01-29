Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56D27B357;
	Thu, 29 Jan 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648472; cv=fail; b=POskh8kqwBaLgSQu5vzyOBoi+SwAcIy41iWpceArLiDMT/bQo3DiwYz4OMAuFPkGqoksUJMvHALan5s4yyc/Vfle/wEBraZj89qFaIXvYSwysGABleIsGaNnLTDCqs+yjE/blM2IysX0sE2fgYZDgIrridFT+TRWhrFWNZC1MdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648472; c=relaxed/simple;
	bh=YvC52MaWN1tYS28iakjzSpnOoOYIqXCUeylAWACLhPQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=vDgEGdXr039rubrGueftpUVDll7/owUEV+cIjYkEJ3iVyRh2xC2QzJYjBkkv2OvAEzvL2RSV51or1R9ntgcozTrGJLEfSH/eAndzJumQO5yg8zVlpYvPtsMqrIXS1pzDTJuflqWE3QFUpcznFz7+epC5lCgLd8Zdvsu4U6YrUVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qj7NlS3s; arc=fail smtp.client-ip=52.101.196.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qj7NlS3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q543IUheumDgKsVnFBzqc8atUzI4OGbXPDUCwPn+MK+h9DZPgTygYhqLj3M0hmTRrkacx8vlBkU8z3NU+oVEgtNLCmlWRz8SmK0gSkIFbuTr0Y7YS5XqlbEMGQjCsWZ7WhfQ3Rf5QEJOIMyji1uBdODmQt4Eh/3mA5AgQgyK6QzKHlMYt2RqVajEcnJ3FcxUYqM3hlD2KEzLQVs7jLKABVBc82j8NaQzpiHfwqkEpRsOeMKe9yT8SNfpHK2vLtvd6WxABP2L2RFKzqH+nQIcagPU/KqCSY7iK2xCSFuUSP3o6MmU2mlrleKgO2DZDnmi6WKzLHlrAow12VDguvux5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z68j9uQUB3+n2AiueJLgn46+KdtfNq5Kic1wipgcz94=;
 b=pe71wZvECPIjNOIGqDkhE7rj5kbhhwxp5f1ZgIqM7CmTcQX/QH/3yGXge/W3mDGPNDaZ7esaW615FDi/pS8hgXg9AT86Ww+zakswKowI8/LfGGVmTZ646x8LPOVjeR67enHqRrymszRtmMkD9jxR5BIjIrO74cjDsW0o8XPosvV1IhCvnUQKhyQSXFTNj7RAHdhNMnOO01N75eE8QI5Fd/SU6Z4iqnVeC43gk0pHy0bmIzDiYieTeFjrDlQhF2n4y9PCPwlqPWzvyUU9HDiD+tmbOUGna9KZbNKXCc3njCWc0nbj+WssaSj690k9HdxkUm/c/wc7kIVYlXh/J/uyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z68j9uQUB3+n2AiueJLgn46+KdtfNq5Kic1wipgcz94=;
 b=qj7NlS3saHwChFQio8mB8yrIrRFaITcgbaIUu74mX0IVsSI9rUQb6DVYxM0iuwreUn+TDKVUgfLxa0e62wfokLksS7k8Mny1MIMDb9p3MIvU/KbT7YXXu9c5y/96aL8yy0wZjO38TrAu6N4dWP2oppJhQAlfXCFUCCdKm9pYv1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7900.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 01:01:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 01:01:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jan 2026 01:01:04 +0000
Message-Id: <DG0O0XP5QNLU.3JDYZ3VI75FMI@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <rcu@vger.kernel.org>,
 <lkmm@lists.linux.dev>
Cc: "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Gary Guo"
 <gary@garyguo.net>, "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Lyude Paul" <lyude@redhat.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Andrea
 Parri" <parri.andrea@gmail.com>, "Nicholas Piggin" <npiggin@gmail.com>,
 "David Howells" <dhowells@redhat.com>, "Jade Alglave"
 <j.alglave@ucl.ac.uk>, "Luc Maranget" <luc.maranget@inria.fr>, "Akira
 Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Waiman Long" <longman@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Benno Lossin" <lossin@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
X-Mailer: aerc 0.21.0
References: <20260129004520.62697-1-boqun@kernel.org>
In-Reply-To: <20260129004520.62697-1-boqun@kernel.org>
X-ClientProxiedBy: LO2P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::28)
 To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eef1c32-aa49-4a33-5d13-08de5ed1e170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3Z5UXV1cHhtZUMybDdkMlFiL3B6OTdjd2U1T1M3eTAyVEpPQkNVNXcyNXJo?=
 =?utf-8?B?dE1LOG96RDd2QXplUTZaVi9MRERBMXY4VE9qVzJZNjNxeEpBa0x4ZnBHUmIv?=
 =?utf-8?B?dzEvZjhwTllWRHpZUjQwZDFXZzcxWEx6a2NBa0JWN0RXMURBcVpmc1cvYk1P?=
 =?utf-8?B?ODNHNVNuTjBqREk2aklSUmdmSXdFMUxhWVh5RU9DMG4zSElReFFEZnFhbmlU?=
 =?utf-8?B?ZjYvYmJmUlBIclNxcmF1Z2FqWGFsRkFOTUZOMXBFVGozOUQ4N2xGR1dvaUVj?=
 =?utf-8?B?a2t5bTdZdVp2UU5ZSk5YWFBhWHJWdm5XNjB3aVBPQ21TK09GdFBOVUVJakk3?=
 =?utf-8?B?MFA2dFg4ZnJVNjRpQVFXRFBJTVBtZDlndzV5QkdoRWROcG8wajVwQW1mRFps?=
 =?utf-8?B?eFU4aVVRb3BIK2UzWU5oRmFzL3BIVUVaZ0oxL05MVHg1Ly9jMW44dmp3a2VV?=
 =?utf-8?B?UXZpU1A2YkFncnFTZUhmdWk1NU1Ecy9HUzZtN1JHU2Zyd0EzRDVyQVEyRjBY?=
 =?utf-8?B?TDNyck1kWlc1MVlIZDJKOVBzNlozeXkybXMzVE5GYlhmNHQ5ck8yOE1mVXZO?=
 =?utf-8?B?WUIwN2xTSVEwMmtlbzhaWWJKclRMOXdpQTAwQkEvT2VRRmRPQitnbkh4SFdn?=
 =?utf-8?B?elUwSEROQ1h4OHVsdEdkZVpMWDQ1NkU0dC9vU1JrRXdDZGJoOGIxSzN4R0l5?=
 =?utf-8?B?WFZBTklPUnczNXhQMkE4bjNTQWlTdGJZRk5sSjVpUFl3L3AyRGpMc0k4R2hS?=
 =?utf-8?B?TzV5b1NsejJTM3d4bHR2Kzc3SC9LWUZyRzR6Y1d4K2IxYlhqLzJPVnZ1dnNI?=
 =?utf-8?B?OGdWSk54L2N5T1hMSlBtYjhlRGxKZ21vSUNTRFZ6TCsybWdQMW9Kck9hdGlP?=
 =?utf-8?B?REJvR0VZcHV0WDBWak51M0l4SDJCUXRzY2dQQ1V6WXYvaEZRR1dMREdLemZz?=
 =?utf-8?B?SDA1UDBscU00aGdzYnkyMnBrRGtRSjlnZnlsM01RellleW1CMWp1c2EzN2li?=
 =?utf-8?B?ZG5zUGNHQWJaZ1NudG9iRlBDRDR2ek0xMzB3T3FtbDFocVpna0RqTzFreTJH?=
 =?utf-8?B?T1JmbkN4RkEyaktDUlhxNjN6dWViWkRRUVl5bk4xcm84T1FXMmJuYUUzRFpn?=
 =?utf-8?B?NEJCUEtIRllrbnM5R0tremFCdmplL2Y5bk5PMGhJUCs4RWR6dTRZZjZ0Y3Y3?=
 =?utf-8?B?WnptZVIwcm9EVWRSUkJQWWFkc1ZnQklKbHJiSzFaRDhwbFhQZWNkYXlkaXRU?=
 =?utf-8?B?NDFCS3FEQWp6UGsyMUhGMWV0ajVwbnNCYU9TSU1NZWtzVHJkOUExNU0wc3NX?=
 =?utf-8?B?YjlYc1hTSEdmRkl1elNpanJVZG1kVmJZTnFpQlFqd2JmcGYxaDZ4eTdSV3J0?=
 =?utf-8?B?aUF3Y2orTkl1Yk5YWEVZV2hFSFhZNytSUGwzNjhqd3h6RzlrNFdsU3VpK2Mz?=
 =?utf-8?B?eVAzR25yb1BCYjFQM0NVT2hLVDg3T3hCSzZ2dHhaMWF3OXpHN1JuQU9WYmh6?=
 =?utf-8?B?NDR1Q2Y0YXlpWFE0eVFkc042Z0hjSHdUNnRLdkdQSkRITnVLSW1GckQrOU1H?=
 =?utf-8?B?SEgyOXVGSFNmNUFQdDRqbTB6cjNEY2szYmFEcjFoMktBOFFLdyt0K3EzN0Ra?=
 =?utf-8?B?WXI3ZlozSnVWVDRPaXA5QTRtK0l1Y0o4SWdacjA5WUlFVEVXWFVMWTJHVGlU?=
 =?utf-8?B?UDRrODNZTVgwSkZoMjR0Ymtsb2k1OWZIVkdXRlhjQW1Dakd2azFTdXZ6OENT?=
 =?utf-8?B?SHBZNUhrejhKR2VJVi9LWUhhb1NudnVrOG12Q1RKTVFDVVBWWlR2RUErNW1y?=
 =?utf-8?B?Z0c1NFJpeTVaeThYdDBkQ0ttMjVPK05BN0QyNkFNcGU0eHViN2tFaFFDWi9W?=
 =?utf-8?B?S25rQjJUaUllSWJmc3JRdmduTmU3MkN4djBzTGRHVlViU29TK01pSjJ4YjFk?=
 =?utf-8?B?Yk0yNFVWaHoybjRQR0FMSlFoMVc4dVpRY1paTVF1UEczR3YvVEEza01iV0lP?=
 =?utf-8?B?V1E0S1NVNmk0ck9tci9XSnhQQzRqdjh0cGo0cklsSTJxbXl1SmMxM0hGbjJu?=
 =?utf-8?B?djBneEJwdmhUay9aa1A0MEhVNzUrZGYvR25BREkzTno1QmxsSFRHNGlYWm9a?=
 =?utf-8?Q?Ik0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUt2b1VGamY5UWdmRVZPVnplM2lHb2M2dVB0MmVEUmpwVmpSSFd5b0cwKzNy?=
 =?utf-8?B?WEpXdTRXeTJBM3VOdmtrbERiNnZieFR0WXdhajl6TzFUMm5jQkI5TVVsSDFF?=
 =?utf-8?B?N3VRK0hYTmtIR241cXFsZzhHQm1scUpQUkswZW9lc3ZNblQzMHVKQ2QzTFBH?=
 =?utf-8?B?OHpldXNFcUVabkJLTEh5djRDczhaN3RBSzdaenVpeFdZaWlEZzhpR0kwajFH?=
 =?utf-8?B?cjhWTUNvcDFPYnZ1UEFnL1poZmNydFNzYk5mZHBLSlhCMlBmOUtlVWFXS1ZJ?=
 =?utf-8?B?ZFRYeHZwQTBVTnNqWU0xSVJwL3c0UkRGT1d6WjdITlZqNEZmUFUybjIybjZz?=
 =?utf-8?B?SkNlSWpxRnpBZ0lWMVI2a0VPTHBSZnJBVUpiTmU0RjdVdnhnaW56MjdOVGRr?=
 =?utf-8?B?NHp3bkM2NU1TME5TLzNOL2FKRkV2TkJncGJCU3JmRk9JMEpsY0VGckhYRG5w?=
 =?utf-8?B?dys5WHM3SkxwVVpWRnFlZDZueEVwUXdtdFB1eTB0TmZ6TDJmemZSdU1QdXZQ?=
 =?utf-8?B?NisxQWFjUFJHOTJXSkdORXJqcEtpQjNEakFESFBpYmNabTFTUkt1NXFvWVB1?=
 =?utf-8?B?M0h1U1NIYnhTMkFBVmxqOWphdVgyb1VsOEc4d1A1UG9iZ2ppVm9NRFovRDl2?=
 =?utf-8?B?bDV6NG1YSE9nR1lkRk54K2NITCtxaEp6RDVmZHRUNFNoSm1jc1BtZGhyOWND?=
 =?utf-8?B?OHE4RENwdkY2T21vbmYvYkxGdUZ2OUtFb3pPMGM5L2t2WFJoY1JwRlFLeWh6?=
 =?utf-8?B?NDRZejVzYklEV2tNNWtjZnlrbDNlM2ZwN2RpOENEUGE5dWVFbTB0U0xZN1BB?=
 =?utf-8?B?S2xYTlprVC85YklOajNqWVJVcUZlWFVRZGhnclY2Tm5aUSsxeHJYYllyQ1E2?=
 =?utf-8?B?OGoySE52TjlPTnNYMHhrdkMzTkkvRm1yYWtJcUdvMlRiS3hoVlJUaHVFQzkz?=
 =?utf-8?B?M1BSc1Vmc294N0MwSHZCRUV1U25FbUlwQnVSS2cva0JMZnlMSXhXWVRpejNn?=
 =?utf-8?B?dUhob1FvU3RkanJ4QWc2N3Yrc1lXYjI5K1NYcmc3eTJZaVZTWUdUaDlDaUd4?=
 =?utf-8?B?Mk5EY2xyMm82NzBTbVNPcVl2SU1BQlE0L0QvMi9oNWdtYi9Hd1VZUzZKWVdN?=
 =?utf-8?B?RGZkVFBpVVV2UnZnRmpGTFVFM0czSGRZR2VReVY5NHBsNjdzU0w0TGZvSnpE?=
 =?utf-8?B?M3lpWUhUTjhUR0Vxb1p0UlMrSVV4NXBnMXdzV3VZM1lvRUlLL0lQME9UZXlE?=
 =?utf-8?B?TkRybm9sU0hGV245RXJ3SndSRFZhNHZZTzZ1WHN1dXdidjZGczlId2FYUWxO?=
 =?utf-8?B?SFE5WHczaGFQZEhUODluR1FBaXZHdXdYL3ZXSTR3endyWnBES254LzlkWS9P?=
 =?utf-8?B?REtLdDdQSW5MNWtxWjdTU1JjTlpVL1pLVkxpNDdFSVRiUkdzbjJ0ell0TC85?=
 =?utf-8?B?RkRzZHE5ZFN5ZXJVRVZOTHZCd2hTN1RNRVVjcU5sTmNBaURUMEgzcDMzSVhR?=
 =?utf-8?B?VU1SV2t2NWw3a3VycStjOUxoVVo1YkZGU2tndzRRaUt5ejVZWWFOM2NJRFpF?=
 =?utf-8?B?TVhMNWZMNG9FMGpiTWRuUHRaYkFJYjdPeGt6eURFRmpRbDlxekY3RDdad24z?=
 =?utf-8?B?TU9NandYU3Npc2NreVR3N09aem95RDYxS1JPR2p4aVpKQVpRa21sMEkyMXVF?=
 =?utf-8?B?ZzFRZjBsT0pOc3BqU3ZkVDByLzVlTno2U1o3c1R2ZUJ5ZCtUUHRFSitxelQ4?=
 =?utf-8?B?QytyOXNBbkZESy9td25RQXo1VVZIUDMrYXVxTmUxUUhmd2VaWVgxNGw5WUVV?=
 =?utf-8?B?c2tUMVpiM3BmMnRCMmMwYWVxYTBzbUREV2pjbWpyTVJzM29HK3NwenFVS3Ny?=
 =?utf-8?B?NHJxMnFEWUhSR2RSZDYvdStpem1PRzRudWFraHRwWFdvcVoySDJ3Wjg5TEJU?=
 =?utf-8?B?enBUeldmQ1FZN1JjVWZlOFBhaksrUVphaVVyaFdSWVJBZXpRbk0wTjVrOXdp?=
 =?utf-8?B?ajIvSExUSHZOSmZnUW53VjV4Y2I5RzNpSmE3NnlVTmhOUkpkRjFLaVlVOWlE?=
 =?utf-8?B?L0N1NTJPcDJEOE1jOG5aUTU4QTRFb0ZxU2J5aUpqRTAvektIL0JuQUovWUJn?=
 =?utf-8?B?SUdTVEtWN2xCcUgydmNOTWRSN3FqU2JCMWptOHJQM2N3MmZqNU1TK0F4L1BM?=
 =?utf-8?B?QXF5QlhDRG4vdjhwRlc5RFBXUkVPRExFbWdqWHNZQitCUlgwQUorNk0vVnlp?=
 =?utf-8?B?alYxL2xtRGhReTZCM0ZHT1dQckRzNjZJT0FzMVpoLzhjbWM4OFJTZnRlVUpx?=
 =?utf-8?B?cHJUNXlRUENnOFkxZ2Nrc2VTRExGaHRvOEVCTkhxbXl3djNPQkI1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eef1c32-aa49-4a33-5d13-08de5ed1e170
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 01:01:05.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLLzIOd9fuROM7mxDHUTsvfLLXKOJ75vU6m9grMY0wkCTmk4ydf9r07d1fG1sq0D5MSbDZZwfB9Iaq5lkXZazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7900

On Thu Jan 29, 2026 at 12:45 AM GMT, Boqun Feng wrote:
> I had issues using my gmail account multiple times this week, hence
> switch to @kernel.org.
>=20
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>

Acked-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  .mailmap    |  1 +
>  MAINTAINERS | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)


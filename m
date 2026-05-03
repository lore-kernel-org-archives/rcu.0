Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022081.outbound.protection.outlook.com [52.101.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AB34C9A3;
	Sun,  3 May 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836311; cv=fail; b=Cso/9fVH66Cz3KgFt2Ql8lNPICNOeBmV+ztkMRTXXJtkcYcZPsGKpdvoO8kQpvEGr0kpeHurYQ7ZC4NQL80RsT04N+QTIe04ZIwefO+gxhuwEdF8mWh0hCUeL4SFvufZv8a9SMVN3EvmLVIIx+7bblTtODdW9y5sMtquZ/aPUA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836311; c=relaxed/simple;
	bh=0pcJ8iaqrfkSnhgTqiZF3YfaFakh1h6fMFg7PXsu2Ag=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=m0RvdGnXSVd1B1rkHgZy5eBUokQ26ZxUzo6ak3CXRyw4ljC484UJk2hDwYzKQnuc6g1tMqT7wdnSa9M6v3b83MMwNChGYc46+IPBEbHR1oHf9m0snXfHbinBe4keTkgFz71XteHrRlAeefYW2NEpotoNQqrqgY9M8bY3d3/UR7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oizc9Z/Z; arc=fail smtp.client-ip=52.101.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oizc9Z/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh9wLLAR8cnI2iOUO71nuujbyKRJI9/lt5fmRmxJ0+Au3y46GU8wT+VETYv2MSnX+TUeuP8n3/wAqTqK1q4WGPr6gRCSo+pn71DpV0EuRUdJI73EccXt9nDQKKe2ZBlKhNscBdSyaT5qmW3w6PM6HjF0OJRo8oPpEn/xzN3rDQ6yqjGKd1/4IuAIyDuF2p64b5LQENJiK/Y6mK5EKOHofWEbfdGSUtLCTLPTbTFRIHd2EBuwT77+EEcrabVu8AxCOGuZNvR4+5z6mPKdwjKyIC0ViO6e7/Lyow1V3Wo18PqkyA5yd3QHEqUCMsPxG5UCtcYj12ud42iQUzT4skD2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+IjCepHFQUV+lb+DGmrFYuPU2D/6s3004wCR0VmuyU=;
 b=bTGnvoFBH34MGDGgvPUHB8wbPkpE8BiCK2/ZvMp4wcXlyzD2JKr+1O2ZFUPyeM09FPfyYAQe8QYMvbGiMuY9PLWSfya3mYwJJ2glcby+yhUpieeRr6mQZX4WwTiMXZFcAWKHw7wH5m4fJyeyds3reEV5h8lSM/w1+aaCkrEeGxsgyzdMXhTKp3ak8yET/FjJDluduQc3Fjvs123xRMpOvsy8QTZ5w3r0IPtROH0833+6dyZO4kYPRZFo3CuUPSuhPaDyphLB+Q2LsZ8qad8WDK97lCvv77H4+XkRtgNGeFKATTAzUc9+RGV+w0MMe67lNhwgwDY3EyM2T32pyA2ToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+IjCepHFQUV+lb+DGmrFYuPU2D/6s3004wCR0VmuyU=;
 b=oizc9Z/Z+zCt7iZfPw43N4QcRsHTRQ0VefAtLK9G4DZBTSfSnOpSiu/Jf+p+R68M0QXlRsSIjkPtB8z3U7LD8R5nY+4c0J1VpYT5oWd4H6nh42+8dRnlgl57Hk8HrbLLrtU+dP1lFVusNorUDZ/gcT2lmPvm7+wCUkgpxIqoiTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB8623.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 19:25:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 19:25:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 20:25:03 +0100
Message-Id: <DI9ADEUBBUD2.22OR0R12PKVQL@garyguo.net>
Subject: Re: [PATCH v2 2/3] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
X-Mailer: aerc 0.21.0
References: <20260502162833.34334-1-work@onurozkan.dev>
 <20260502162833.34334-3-work@onurozkan.dev>
 <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net>
 <20260503034008.36917-1-work@onurozkan.dev>
In-Reply-To: <20260503034008.36917-1-work@onurozkan.dev>
X-ClientProxiedBy: LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: 842dc287-3e25-4173-62bd-08dea949ad87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iMrhwymChiVyQnTzR7EYdXOd2i36p9FIdErybBIBk5Upfvl56w6nSReWa5LHs/eu+cjWK1vC/pDEDkmZtTYzpXAr6Fq7coxmWjtOAVkt2MDJFhrYoh/J0i1+ngthrFgOr8voexJI31xGaV3WBf7bRlq3kJUOQuq4oNyCuLTUGAXGpMLjUQwfaTkMgP5aw8LfpnYDvN/ES+1I5vth4OgxTL4wTpijkow+D5e2z9FdBUttwUlOjnUwTVjCDeIFlZE61QSqJbhgBIHr6J5Aq6wdv0zSLe4Ve1f8DrLm4U3UaRq8AW0dauWZCDq28eYryHgyRyFaZkzBppjfW/gjzDicZT2hSjLPHgRUxgfhXmkxBnqiCIR497JsexgyTuMJsyw3G4OtjxhvlmkvI2h1SpAm2wATZ9fvG3jfeK4FD+VlZnlKtRRJyl4QQxeDR0TWAMxhnxkxALoYY/QlqceeTzGkVdSexruoFDg1CDkoYcQHrb7XA0q+WRsIqA9WSxr9e/6NPLsbxgUJEL0kWt0p+MTzgGIwE+qjwI2AbPOZsMPq65GNHE8suvBMqZmONVRB19YvutDJ5gvrbHHQF6oWp+HHOMNaAU5LJ7KGx6UCiGMjTATc7i4dHzlwou7Ek9SgyynEyi7JqlJx5GOYXN/u1NLJoW6MsjuN5noAzLLCfEYA6dLHR8aNM4mp82xCaWmX4ePo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjNKc1JCVGgvQXF6S09GYzRqd0dnamZNeXR2MHlrbGFxd29FV0h4UXFnRW1s?=
 =?utf-8?B?VXBibU5XUklhV1AxeUwxN1BPOVVBVnJscWlPdlU2b1RFUFRxTlF1ckZhVVBp?=
 =?utf-8?B?RmJuU1VzUDZ5NUtSejZ3YTBIaC84K3oxUjlnb3F0UEsxVG1GWGhEYVRUVkl0?=
 =?utf-8?B?S3lOcWFKdWNWWHY0anN2WG9MNHMrb1Y0VklFZnVXT2lvQ0VUeWVIYStIbkVW?=
 =?utf-8?B?QklzSFVrT2tVclNuN3RmU2dEaWpub2xPOXFrcDFmS3hXUmRjbE5kZVI1eG44?=
 =?utf-8?B?YWR4UFdWa29sWTBpcTlVUUJMZFppcVRCQ2VXWE1OVnlaZ3VGenUzS1EvTjZN?=
 =?utf-8?B?U2hEOURoanBIMCtOditndFl0MnpKMWMwNDExdmozYlVCcGhrWFIrTEliK1h1?=
 =?utf-8?B?bFZicXlCVCtNY0tsTk82OFNJdDVwQ0g5S0dYUEJWS3hGM0YwSS81SEd3a3dD?=
 =?utf-8?B?S3V3TUVhK2dLbkxnQTF0T2R0dDJHbStnWkZOeVRzTDNrRGtVYldpazZ2TXdx?=
 =?utf-8?B?YmY5WTN1a3VtWXRSRFJPY3VEek0rcVIxUjZZRURuOHpyNVNxQTY2QkZoR0N5?=
 =?utf-8?B?ZjVXeVVreUtPQVNDTkY0OStnbkJGNGNsRUsveWRramdsL2dZQ2E5YzVaazg2?=
 =?utf-8?B?SjRUQ2lnREZ5TXpqdkptNUljemdlYlZ4SGNrTHJNV0pjamJ4alU4NmVERW9l?=
 =?utf-8?B?ZGpoY01UaGVjNkQ2d0RXeitIVjlmMU1XZkJIR21wQnJZWXBoQUVnUFdKNzRm?=
 =?utf-8?B?QVhhQ3hJTkg0NXI1aVJ2c1lST0tocmdzWkpZZklxdm5ibGl3cFFlNlBVUTV6?=
 =?utf-8?B?bW8yZWorQnd4NzdOS3J3SUtCMjhxVzlKcnpOTjhaQU1QdmkwMExLYktkYTVT?=
 =?utf-8?B?MmJ4cUdTTVlhWWlTVXZxWmo2MmNYL3hOVmMzNzhyc1hUL2VsUFBUcjNHa1I1?=
 =?utf-8?B?aWZXSkc3Rzdkby9VRUlqd3lnNFpIZ1k3Z0VrS0d5US9xUXRsS05JUjYrbEtR?=
 =?utf-8?B?MDZaeGpzb2YrZHBjd0V5UFRZU05MZjBWMEFEQ3Q1OWFmWHY3RzNxL2JSNjFZ?=
 =?utf-8?B?QTNzTkk5N1NpRjdmWnZBV01TNlBLd2gyTnFObkpPREdOSndyemwxWFBCMHgx?=
 =?utf-8?B?SWVtakxzN25SU25ScDErUkVVZzBranU3V3p4Vk1ZaTlIbTQ2R0FUQmtCd0lo?=
 =?utf-8?B?Wm9sQ2VDS0tQZ2EybmtEUXNwbG5MMkI5NVBGYmZRTXdGeVZ3MXdNTGtKcjZD?=
 =?utf-8?B?NDB2OVpJdStLNnh0TGg2WElYZlloTGNjSzBSeFRqWlhmdWV3UmFWK0VpU3FK?=
 =?utf-8?B?U2NGaEdKZEVQMDBSWGp2em1SZ294Sng5MGVNOWVjWEw4SE55QVdDcHo2U092?=
 =?utf-8?B?OWFFSDBROVoxRlBGaHBhU3FsY09CWVprOVJoWFpjZUVRVjdWZjlibXZkem5y?=
 =?utf-8?B?QUJUaU5OcGV5L2ZYMjBlQ2NrODc5SktLTEFVeTZuRFI4SVdBaWRFeXMyZlMr?=
 =?utf-8?B?cFl6MUdjZzkyZlFDSzF5U3ZZL05UcVg1cEY2OXVlQ2lNYnJYSktJN1AvN3Q1?=
 =?utf-8?B?QnY5bm9SdDF3Vzd1bkluRXE1YmtkdHhHWnZIcC82c0hjNTlIR2tpdXhwcHJO?=
 =?utf-8?B?S3FwaUlkUmxNRHpoRzFCSGxjYzRIQjQ1T3dCb0VETnBiRTM1dzE1cXJxbjJY?=
 =?utf-8?B?bTRpL2U2V002a2dod01iUDYrUnliQkxTYUs5U3ZHUWtXUGI0Mm1sQ0hmV1Za?=
 =?utf-8?B?NVQrcHZoQ3ZNVldHM09Vdjc2OE9QQy9LTW5wU20yazYrUkd2dHZvOHhaMHhs?=
 =?utf-8?B?V2ZRWmtoMS9KRklqaEFRRDdBdXlRaW9lWVcvL2p0eFdvOEgrZkV0SUxUZ01Z?=
 =?utf-8?B?NzZTL3E0S1crQUNaSXljVC9IdmgwRUFzalNWUFlYdllnWTkxVzZkNDgxbTF5?=
 =?utf-8?B?eFBvdE5lUmtJaksxdCt5T0x1YS9PM0RWQVNMU2NsK1FFRmR3S0hWbmxqMnYy?=
 =?utf-8?B?VDg3TStpaGtLdUg1K3Jpd0NmZTNWZzdheExrWGtab0lEUmFSNEVRV3VCQUZS?=
 =?utf-8?B?UEhNckVibUgzKzZKK2ZyWStvdTFqa1ZmN0RqcnVqYW16RldWemk5emMvSmRO?=
 =?utf-8?B?MnowLzdPejkxWGxyQTBJK3R1dGF4STRrZFpkYm1uZDFYc2NzTTZ5dEVDa1hO?=
 =?utf-8?B?N2NuUXp1VW41cXp5bmxBcnl6RmF0bkZjN3RrTk5vcmxHMUlPL1lGMHBvTFRS?=
 =?utf-8?B?ZzBEalNWQ01NdExTNy9NM0NSZkNpLzh0MklFL1ptdFZzNGgyQjlJak5RQzEr?=
 =?utf-8?B?OHdiVFNVYjdTbkMvd05vM2RoWDVoS1FhWnlLUzVaTHdjVU02L3N2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 842dc287-3e25-4173-62bd-08dea949ad87
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 19:25:04.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2T8co4wVQgo3/GVz/bs/zUNKQhVPPriknmjrKItM8SNS+Kp+gDdHgCISWyvd9su9fwWs29XZu8drgAL3BnnDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8623

On Sun May 3, 2026 at 4:39 AM BST, Onur =C3=96zkan wrote:
>> > +/// Sleepable read-copy update primitive.
>> > +///
>> > +/// SRCU readers may sleep while holding the read-side guard.
>> > +///
>> > +/// The destructor may sleep.
>> > +///
>> > +/// # Invariants
>> > +///
>> > +/// This represents a valid `struct srcu_struct` initialized by the C=
 SRCU API
>> > +/// and it remains pinned and valid until the pinned destructor runs.
>> > +#[repr(transparent)]
>> > +#[pin_data(PinnedDrop)]
>> > +pub struct Srcu {
>> > +    #[pin]
>> > +    inner: Opaque<bindings::srcu_struct>,
>> > +}
>> > +
>> > +impl Srcu {
>> > +    /// Creates a new SRCU instance.
>> > +    #[inline]
>> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) =
-> impl PinInit<Self, Error> {
>> > +        try_pin_init!(Self {
>> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_s=
truct| {
>> > +                // SAFETY: `ptr` points to valid uninitialised memory=
 for a `srcu_struct`.
>> > +                to_result(unsafe {
>> > +                    bindings::init_srcu_struct_with_key(ptr, name.as_=
char_ptr(), key.as_ptr())
>> > +                })
>> > +            }),
>> > +        })
>> > +    }
>> > +
>> > +    /// Enters an SRCU read-side critical section.
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// The returned [`Guard`] must not be leaked. Leaking it with [`=
core::mem::forget`]
>> > +    /// leaves the SRCU read-side critical section active.
>>=20
>> I generally would prefer if we could use guard-like API instead of forci=
ng a
>> callback.
>
> Me too and developers can still do that. I think the safety contract here=
 is
> very simple to handle. It's essentially this:
>
> 	// SAFETY: Guard is not leaked.
> 	let _guard =3D unsafe { x.read_lock() };
>
> To me it's very simple and straightforward for both the developer and the
> reviewer. It doesn't add any overhead to the implementation and it ensure=
s
> that the developer (and later the reviewer) is aware of the potential iss=
ue.
>
> Of course, there's also the safe option if the developer is happy with
> closure-based API:
>
> 	x.with_read_lock(|_guard| {
> 		...
> 	});
>
> So it allows you to use the guard-based approach directly with the requir=
ement
> of a safety comment and also provides a safe API for developers who don't=
 want
> to deal with that. I am not sure if you fall into the third category, whi=
ch is
> "I don't like writing safety comments and I don't like the closure-based
> approach" :)

We have been avoiding using callback-based API if there's an alternatively =
way
to achieve this. There has been quite a very precedents with this:

- spin_lock_irqsave requires taking and releasing in correct order, which i=
s
  easy to solve with a callback approach. The same logic reasoning can be u=
sed
  to provide an unsafe API + safe callback API, but Boqun & Lyude reworked =
the
  spinlock IRQ design so we don't need that anymore.

- `Task::current` API could easily be replaced callback-based approach, but=
 we
  used a macro to achieve without unsafe.

The API here is not inherently impossible to use guard API. It's not safe t=
oday
because a very specific detail. The callback-API is the "path of least
resistence" approach, but it's not the optimal one.

>
>>=20
>> I suppose the only reason that this is unsafe is the "just leak it" cond=
ition
>> when cleaning up SRCU struct, which skips cleaning up delayed work, whic=
h could
>> call into `process_srcu`, which accesses `srcu_struct`. This however is =
*not*
>> leaked, because it's controlled by the user. Only the auxillary data all=
ocated
>> by SRCU is leaked. So UAF is going to happen.
>>=20
>> So in some aspect, the leak caused by `srcu_readers_active(ssp)` can cau=
se more
>> damage compared to just continuing cleanup despite active users? I think=
 this
>> could be changed in one of these ways:
>> * Have SRCU allocate all memory instead, and user-side would just have a
>>   `struct srcu_struct*`; then leaking would be safe. This is probably a =
bit
>>   difficult to change because it affects many users.
>
> We could do the same on the Rust side only. Basically instead of embeddin=
g
> srcu_struct in Rust srcu, allocate it separately and store its pointer. T=
hen,
> if cleanup hits the active reader case, we could leak that allocation so =
any
> remaining srcu work does not hit UAF. I was aware of this option but I wo=
uld
> prefer to avoid it because it adds an extra allocation for every Rust src=
u.
>
>> * Continue to flush delayed work and stop the timer, and then leak befor=
e the
>>   actual kfree happens.
>
> Can you say more? I didn't understand this particular solution.

I was thinking that doing this _might_ be sufficient. I have to admit that =
I've
not very familar with the internal implementation of SRCU to make it an
assertion though.

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a..5d75a4dbb6e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -717,8 +717,6 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (WARN_ON(!delay))
 		return; /* Just leak it! */
-	if (WARN_ON(srcu_readers_active(ssp)))
-		return; /* Just leak it! */
 	/* Wait for irq_work to finish first as it may queue a new work. */
 	irq_work_sync(&sup->irq_work);
 	flush_delayed_work(&sup->work);

But after taking another look, I am not even sure if this is needed. A quic=
k
glance of the code it appears that __srcu_read_unlock doesn't do anything a=
part
from adjusting the counter, and the SRCU grace period and thus the timers w=
on't
actually start unless there's a pending grace period, which won't start unl=
ess
there's a call_srcu or sychronize_srcu. And we *know* that none of them wou=
ld
happen, as the lifetime guarantees that nothing accesses the `Srcu` struct =
when
`drop` starts, and inside drop we have already invoked `srcu_barrier()`.

So I think, even if we hit the "Just leak it" scenario, we can still safely
deallocate the backing storage of `srcu_struct` and nothing should break?

>
>> * Trigger a `BUG` when the leak condition is hit for Rust users.
>
> We need an atomic counter to detect the leak and I thought that would be =
too
> much overhead for this abstraction. Basically each lock and drop will cal=
l an
> atomic operation so.

You could just check if srcu_sup is NULL after calling `cleanup_srcu_struct=
`.

Best,
Gary

>
>> * Declare the `WARN_ON` to be a sufficient protection and say this can b=
e
>>   considered safe. Kinda similar to the strategy we take to the
>>   sleep-inside-atomic context issue.
>
> I think this is a rather weak precaution.
>


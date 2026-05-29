Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2473BCD19;
	Fri, 29 May 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056443; cv=fail; b=fuBrBIuvCkET6ifAjSWgmO8UQCHYaOSb0XD+DrbKsi9aWt1oWco+BmuScz0Yr5+JT9Ku48wvs1cI3rtJ9+luPCiGTLd3k2NRtTMx9ZgNYBqFiA2AkLYJwOx2sVLtnaYPzsUzfKyQ2fSuWCLrOwKE0DZHECCtheApOC5uJxmOdZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056443; c=relaxed/simple;
	bh=AirKscfC/D0t3sLi3mpE7NJpg4cfKNG4sds3Ww5YOHI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=kJjJq+xmHsBpK9PbBSwAGW/NkGWKGuEZJwbhgCxChamgUKxCDYosh45Aq9MVDXaXixtgNga3Aw7opEB9OT0jKdKX5uD3tMV+tTytcLPlyFfL0fWU5yT5AUOME8Ke75pCs0bDQ5No0Bm8PfhELT+gilZET9v8oeYdqHqcyclMlag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hk1DpdKq; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hk1DpdKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcUSfxsAoEG/v7cSWTV0Xk+Jds1RfXmWcKSQpJ6OVDXo02QHq1W3yzopLJ7Bc0Pb6aW0UhPtAlfGHjFru0aaIkCqJRLP3OMnNL8UHDYyo08HZRfBq0iHvvDUn7HaVx3zelmNJfCt/J4AMJaRPi9Lp06KIGQJG7RICIfqlONaOGnv8pliU3c1ZoLasouT45DlKQXOw2BeSPJOROJ4ZpZxxV0rgbGhJrzub1BZ2ERVt5b9kB7yNt8kE5nYO+a5hpl7ndImNzvEekeiUsqkt8TU4kyoNMZ03Km19cJlZQslBI7QQdJsbsibQEbsNxkmTZjTIH3tLw2MGNcmVHeUzqggzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G+x7pwNlawFIMnzsq6tUfkI9ya273nVNvWgwkZW1NI=;
 b=Ar6ckXAtJxke1DLn71PRpOvbeSdD0s/FknmWSZKLoBz9sF1gHLX7TbE1u4HdsPmtQbPPMMtxUg9nOh/3MU4q8Rp1paQpV/puskHoXkSs3rNHzARzeGRqYXzH228yPQ/KyNqujgsjUAr/dzSi4OSqIJteCg0RbxSVBATJgxhKVwKHFdYwLunKhzae1Nqhy+awVHAmQY4DPPa1t+WWvGdQCgyqIkTkadKZkBnLxLYo66bTw/qasfIRatlqPwx8p3nk6kwQ0NDNwbHhcMaWODbsgpc7yH/lpj1SsHw5OO6rl8XmUjXbBkUCakKuRyoxp7uLzfZdL3of/LfVhss6uKxj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G+x7pwNlawFIMnzsq6tUfkI9ya273nVNvWgwkZW1NI=;
 b=hk1DpdKqNWdkc2GMMF75S/nDYBmgrRZAJtGJiwDHzoOXSgOntqygeuhBWIzzEjTcZemlPnd+9ika1X4xcfqXpI/JOOXQAqOor0l0HQb0raJPZA98iFTb+4DUNns+/L2rZiRmLEhY4uW0drL+AeLcDUzN7QxRrT7TAUy+FKQcJuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB9123.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 12:07:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 12:07:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:07:18 +0100
Message-Id: <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260528062810.256212-1-work@onurozkan.dev>
 <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
 <20260529065744.59786-1-work@onurozkan.dev>
In-Reply-To: <20260529065744.59786-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 94355061-9dfb-4d52-15ef-08debd7ad502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dfyeOqbNgQ738603QmqUKPcyrhCltyXhuFYrnkx64KgNOOWFkWw8OLZ7poQZELEP9QWvXGgexEkyzwBWj7btQyIuYwgIanSInpYp/pcgEa0na6gV8/AyYwakLtLi+hdvkHKXimXDD6lw3AUp6dbtr/pjqejYLVHLxlFbfjWduuyidqGno3J/2AeCsx1OJVTCR/DTJhPEdMl9JBQCsyVevIMYt0PdUX8Q5nOq7IYiGINxilFJLGkO96FpcyQnYJ0hhG3Dfibjl6/ELMXiRWjSZtYQk++RGIkdSK8VyaD8SmhZGKw7CaWHjjPx1BgeceoLjWim4ViGZPTA4SaDPmLOHWrQNTN0YEP+sHW5g9DiCmKwoF1Gd/XeO9gLXZ7bwueltDo59qDY/mcfyD7l4r0R8DR7OUBtmgNf/CjwYTkhAS+pcpCl1l23DoT2l+i9C8m+2pervYgRydktqcavaexP8GSXrKHN/1gcN/I2cyr4SYPOn0a3vtsgICsQWzgFwnz7TDnWUSslofqJPDhDUctmtYRdYFVEpCf0mODdDaKMuUmLZ8JFlBcoI8zPWlaGRR+w33CsrzaL1OPAtKjtyWQ9oeVM1Pu0SCN+R/q2LVTIQS0YuCFpCjLNAW9YRpcNC8DREkrPQUVAayM/sKr6VuMfoBUHHBQPsscyWmR2BX9cAafwAMYsTNfv52O9Y7JP1DSesXclqgWjC8S/8yC6JJ1lKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEhpaVR0WUR6dWMzZ1pDcHdlZHEvUXY0amtnSUhBNXpMSXFqRUNEMzBsMkpM?=
 =?utf-8?B?cUFLbEh5N0MrdmdZWXl0eEtjVDJOcVlOZ1U3M0krdFl0SWNTbVI1OFQwS1RZ?=
 =?utf-8?B?RCtFUGtKRGU0Y2labERsY2Zqalo5SUtUS0prQ29CSnA2d2J0N3NDWkp1UnV6?=
 =?utf-8?B?STRkT1pIVXhVTU8zUExlcGs3dWM1Q2I4aE13Q0JOQXdzbmV2SjlPNU5pcnZ5?=
 =?utf-8?B?N1lKVGN1NU1TdTh2TlRnUG1GL0tMLzUyaHFib2diVzlheFNqeFFpN3NVajg0?=
 =?utf-8?B?NjlCYTlOa2JsTk00amdQQTlwb1FaR3kzYXozdW41WmxPZ1gwbFUweWhBMjRr?=
 =?utf-8?B?Z2lNbTNFdno2ZGpIUnptSXNXcjBPRTl0N051Wlg4em83dXd2VkdkYzFzZ3pk?=
 =?utf-8?B?M003ek0xRUJ0a2kwcDJJZDhpdGR3Z1YxWk94MmVBNWlZbmxPVHFsNXdhRHhC?=
 =?utf-8?B?ZldTZWtJRktETDJHZ01heFVCTnlobU0xNWYwdHEwZ2tKVHFQYU5KMUtza0Ix?=
 =?utf-8?B?NWYzVVFlNFdBSWh6WndDaGRieHAvYUlzM3JwNmErdUdFZm1OYUd1dy9tcVVC?=
 =?utf-8?B?L1RoTmhjaCtLeXdHSktwZ2NDVnVVaXo1cTRFRXprRmFiSDluOHJHbUovank5?=
 =?utf-8?B?YjJMWitpaUR5aFV2QmpYRGd4Y0ZjRkhNcGhPd3l3YmV6Ym9pRFlrdW55TWM2?=
 =?utf-8?B?ZjEzZHpVOStxN2Irc1RYdDIrYkRYcUt2ZmNicGtZWkF0UWV5OTVkeEYwZDVJ?=
 =?utf-8?B?VElxUlMwMXRHTzNDWHZWSTdkMzdnTjdIV21RNkNJanczUUp6MEJTM1Z4eU1U?=
 =?utf-8?B?L3YyQkdUYWduNXVYWENUYnFRMTQyU0Z1MzBiTmlnTVpHMVVXRXFXNUJqVE0x?=
 =?utf-8?B?ZXBiSEVjUjh3QkczOHRnU3htd2xXSXpQdWZzV21pLy9CK3o4eXgzT3gyaWRa?=
 =?utf-8?B?UG5BYVNEVTB5cllkM2VwV0VVYTRHa3VzTERJSmtBRUw4UjNybFlBWWVNbkhz?=
 =?utf-8?B?ZWpOdWk4anVBdkhMOCtxSC9tdStyTE9GeXRhZHhoaWo0SjZUdGxRdlVaK09x?=
 =?utf-8?B?MEQwTjVFSVNHYWVHQnFYNVJTV3BsbkxrZllRZ3Q1S29JN1UwbnRqQzhvcHdG?=
 =?utf-8?B?a1lTaWRsMDl4Qklqa2FuZ25VM1pZZjB5SkUyeWt1Z0dKck1KQlNvRzlGTzhm?=
 =?utf-8?B?T3o2b2lJdUVQbzFmb3dvV2thcGY4eUFvTHl5RkovRUVlZDZaYjk5L3lpUkV0?=
 =?utf-8?B?Lzh6ZUN3TzVYS0lvYjhqaGRWbUtFS1Uvd1A4UzlGYXllTGdKT2lXSC9nNzZS?=
 =?utf-8?B?Z2pobDdLZFRKY1BTcklQdHFFTXdNK0dkaGZ0RktyVG1TazdxVnd1eG1oT0hk?=
 =?utf-8?B?ZXZTSEh6WWswZHhLQWpwMkRsTWE5MVVNcHNUMTNwYzg5ajdtRU1oMU03S1h4?=
 =?utf-8?B?aDJYUTRObHBYUjdYREF3bGNwQlJnSzZGQkNBY3pxbUJLcDZzdjQ3dm1jRHhh?=
 =?utf-8?B?TXJocFZack10cHJDaHUrbTUyTHNKUjRoSTAxN0lpWGNzazNlcm9jUk5QQmZV?=
 =?utf-8?B?Zk1XaE5kVTZuMnY2dHhCSUx3eHRndWlCNHNiL3ZzN3BkYUhRS2c5c1RKc0dE?=
 =?utf-8?B?U0VCbXFOa2hGQmt3cnpkUVpnZ3lRaDEvcHpVSkRMSDlnUldjOTRsOHoxYWxQ?=
 =?utf-8?B?SmVuYkNESFh2VHBISGtNdEVrMmcrbG5FcTJIM0lqejdNdzVibTdnTHNkUmRp?=
 =?utf-8?B?Uk9vSkZxUTdJYTZoQTdtWURNb2Vhc0luNWNHUGJWRUIrV2twMWcrQ0hoaXZJ?=
 =?utf-8?B?ck9zaFQ0cFk5V21XN1FlSmY3T29RallsM3lVMmNkM2FqRzNtZFB3bUFDc1RU?=
 =?utf-8?B?V21UWXdQOWtXU3d6QlAxNy9pOUZNYmdFZnJhcm5TOWJsZGhIQ0FpVkM0R0p2?=
 =?utf-8?B?WnFsdXZWY0JsSFV2TkpxVmpSOW56YXo3TWdhck9VN1NNTVBkTmkxT2FvOWdX?=
 =?utf-8?B?UkRuZmJZRGxhelFWZy9qRW8xWm5XTk5lTjMybEZ1dkxBQnFiRVZDUTRCbzJS?=
 =?utf-8?B?VFQ0QS9MQ2pKNmh5RGJBL2NQMXdWWHFjQ214SHRTT01ybkwrdm5QVVJoTGFv?=
 =?utf-8?B?VmpWenhXKzUvR2xoaGVucXo3TUt2dllndlR3TlUzVU5XendpR1U3QnhBbVJr?=
 =?utf-8?B?R2FqR1hBblNhczJvdmNsclNmZUJPYk05bFlKYXBaOXRvSFgxdGxCd3ROZ1V6?=
 =?utf-8?B?U1NRY24vRmM4RGd0VDlSRCtKOG1ZbzE3Nk1mSUtUWEgrNjVCdllmeE84V3JI?=
 =?utf-8?B?dWltT3k1dWtwbTNoRXUwUWRqT2ZpckZkKzlIZlB4eGdQVHp0K01iZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 94355061-9dfb-4d52-15ef-08debd7ad502
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:07:19.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9G4IEfrTWsPli0rBFiMGWTSU1/f93GWBm+tdAIwE1F6pscS5JhBP30Pohwysy0LhdcJrDNiNKcCZ8DEcV8vFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9123

On Fri May 29, 2026 at 7:57 AM BST, Onur =C3=96zkan wrote:
>> >> > +#[pinned_drop]
>> >> > +impl PinnedDrop for Srcu {
>> >> > +    fn drop(self: Pin<&mut Self>) {
>> >> > +        let ptr =3D self.inner.get();
>> >> > +
>> >> > +        // SAFETY: By the type invariants, `self` contains a valid=
 and pinned `struct srcu_struct`
>> >> > +        // and `srcu_readers_active()` only checks the active read=
er count.
>> >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {
>> >> > +            crate::pr_warn!(
>> >> > +                "Leaked `Guard` detected while dropping SRCU; drop=
 will block forever.\n"
>> >> > +            );
>>=20
>> I think this could be a `warn_on` similar to how cleanup_srcu_struct han=
dle the
>> condition.
>
> We also call cleanup_srcu_struct below. The idea was to provide additiona=
l
> information, we don't need to call warn_on twice.

If the code blocks on `synchronize_srcu` then there's no call to
`cleanup_srcu_struct`.

>
>>=20
>> >> > +        }
>> >> > +
>> >> > +        // `cleanup_srcu_struct()` may return early if readers are=
 still active. Because `Srcu`
>> >> > +        // owns the embedded `srcu_struct`, returning from `drop` =
in that state could free memory
>> >> > +        // that is still referenced by the C side.
>> >> > +        //
>> >> > +        // Wait for all readers to complete first. If any `Guard` =
was leaked, `synchronize_srcu()`
>> >> > +        // will sleep forever.
>> >> > +        //
>> >> > +        // SAFETY: By the type invariants, `self` contains a valid=
 and pinned `struct srcu_struct`.
>> >> > +        unsafe { bindings::synchronize_srcu(ptr) };
>> >>=20
>> >> Sashiko got a good point here which is calling synchronize_srcu() onl=
y if there
>> >> are active readers. That's a nice low-effort improvement we can have =
in the next
>> >> version.
>> >>=20
>> >> Onur
>> >
>> > Actually, now I am now thinking about whether we can come up with a be=
tter
>> > approach when we detect leaked guards. Initially I came up with the
>> > synchronize_srcu() solution because it would handle leaked guards auto=
matically
>> > without requiring any additional checks. But now that we can actually =
detect
>> > whether guards are leaked the question becomes:
>> >
>> > 	"Is there a better option than effectively sleeping forever when leak=
ed
>> > 	 guards are detected?"
>> >
>> > I have no plans for tomorrow other than finalizing this series includi=
ng the
>> > question above.
>>=20
>> The best solution is to proceed cleanups anyway, given Rust rules ensure=
 that
>> these are actual leaks and not just srcu read-side critical section that=
 failed
>> to synchronize with the destruction of SRCU.
>>=20
>> This obviously require changes to the SRCU code though.
>
>
> The issue is difficult to fix purely from the C side. Once drop returns R=
ust
> is free to destroy srcu_struct. If srcu still has pending callback associ=
ated
> with that srcu_struct, for example from a future call_srcu() wrapper then
> returning from drop while readers are active can turn into a UAF. There i=
s also
> no way to handle callbacks in a reasonable way in cleanup logic while the=
re are
> active readers.

Callbacks should be flushed during the drop due to srcu_barrier. Am I missi=
ng
something?

I'm pretty sure that, if we disregard potential misuses from C side, removi=
ng
all "leak it" paths would be fine and won't leak to UAF if all users are fr=
om
Rust side.

To be very clear, I am not advocating to actually implement this way. I agr=
ee
with your conclusion below that this is broken code and a warning + blockin=
g is
good enough. This is really just my thoughts on your "is there a better opt=
ion"
question, and I think it's better in ideal world, but I think blocking is a
good pragmatic choice.

Best,
Gary

>
> I mean in theory this could be fixed in the C code, but that would requir=
e to
> re-write srcu cores/semantics for this special case. The $clean_something=
 helper
> would need know that the active readers are abandoned and will never unlo=
ck and
> it would also need to decide what to do with the pending callbacks, which=
 is
> also a big problem (as gp will never complete, callbacks will never run).
>
> It's also worth to note that calling mem::forget on the srcu guard is WRO=
NG
> CODE and very easy to catch on review (by us and also Sashiko/any LLM). S=
o
> finding a solution that doesn't add too much complexity should be a key
> consideration here. With that in mind, keeping the synchronize_srcu() not=
 really
> a bad solution. Sleeping forever is a bad failure mode, but it is better =
than a
> potential UAF and either case requires sending a fix patch for the leaked=
 guard
> anyway.


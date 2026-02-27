Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022096.outbound.protection.outlook.com [52.101.96.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB442982D;
	Fri, 27 Feb 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204456; cv=fail; b=L9xm5xZjcwJYFPtvpFxXGgdOvPkzeEPyMrNEt1mR5ecU3eYfoFOAYk42CGmjgM791wujZaffr8+21+MQVTrW0+/oroOmMmwIUjsmP4J5DPl7nrNbklqCykvf9StDsvjbddXVJOMHGndD77fifCf8fCmty30Tgv9had9H9kREB9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204456; c=relaxed/simple;
	bh=zlS65OBlynkXWz4LvZ+rU1dUKXvgkc5EQSDY1S8YTKg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=UJQK5mzmIGQ7MISXnoy1cWTOIiYF9u0du6q0e57CQ61mprEoHw6QmNMyWfvP37O9SPHwb9H9PWLDFm/HZCxW9A1iJgp7ML5bCYZ0F6lK8XE9fj1I6ZsonFvXJSzGgj2P2aqpWMjhouzsi5eqxnMpAmsUAAViJXT3nBlnNcO3M1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rPVth1G/; arc=fail smtp.client-ip=52.101.96.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rPVth1G/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUfSi8pA0PHLnOzoWmjoV5//ZlDDDtAqNw+xEiZFos2DbzenvCiHVbqciFBNUFqz49JD8mj3Lnx1KX4qIHZhMyFq2eaiFM5/vc09biIMuVvYuEfqIjyEYW2ITuJkIObKUmCNcAQ7RRw8GtjMhlj2HNy6XMWgDp9HZ+3HxA6HTtIKdPSEBIZ6sw0Zfa41R/L24V1ftkC58DnAn3CyWEOq+i3HE2oxaYKJiIM4vBU72LW23QS2rGdboOYH3UI+l4Kopkcpw5jK5RTVtNkhbXQzmVGOnOlsPP20PYuvzJ2b5cslFND9hMUUfbJMfdDbtqnkJqt8oALAsNQgCBGX5VabGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50zo5vkJbMvFySZNV/bH5qafy3aLqaQHrAvX0Ue+BLg=;
 b=yB/ErlXvzHDL5N/JPTRPLPx/0U5IgW6hanGCNUuQAitS1+zpLYDR17Bvw/r9iqat1+w6bpsMpGTs8MNAcQ4DiCMHg9D7FzH0YapWmdPZ2CcceruUJ5JwvxWj5ScOONdRFg22D677CQQEBBd3bGI2P8G68IA0R1TyEp2Aj2Ggbb3uTewgpHQKfkfaghnMpZu6uPkJLacQQeYzE5bNYxvX1a8ILDz/s+i4isGFaO3D7SYdbdR9ntUm4V15E5HW4wAB2WF0rjhvWXrK+pTPIaiI3J0uw8YXdwQbCx4xUpUGXFzQekP5xbxg5t4QlTFadF+CC2fOVegv8VSKuWz2h7rRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50zo5vkJbMvFySZNV/bH5qafy3aLqaQHrAvX0Ue+BLg=;
 b=rPVth1G/ALwkSyuPatVcIRMh3mVZsOaHQeeR+hN/CHkvaYQzMlcorPO4B3fbckIISHntjxiTUzzTAcJ0uCKOs3ngYBR5s2hTSa+7r0Q+/kCNmyHMysVPsKWq+Xh69kjeNvL2TYcq540HU0dJ683lEiDNoC/Z++vaqaHatInsmKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7381.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:326::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:00:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:00:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 15:00:48 +0000
Message-Id: <DGPU1OF7TWG0.3EW2BO61C27C6@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <rcu@vger.kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Tamir Duberstein" <tamird@kernel.org>
Subject: Re: [RFC PATCH 0/7] Introduce HasField infrastructure
From: "Gary Guo" <gary@garyguo.net>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Boqun Feng"
 <boqun.feng@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260128215330.58410-1-boqun.feng@gmail.com>
 <7400643A-02A9-4FF4-92D4-3F94F868B789@nvidia.com>
In-Reply-To: <7400643A-02A9-4FF4-92D4-3F94F868B789@nvidia.com>
X-ClientProxiedBy: LO4P123CA0486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0383f1d1-bd6a-4f36-68ce-08de7610fe71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	UXAjDqwmW8NrWcGWCrDCO9Bj5ZAUPejlaBs+JiqUWzGTN8mv4negtqxyolyXQj5uWOUUmbBfHflbHzTfqOIVjDgVBObg22lNLEyV+vkTkosVpCsg/j/qRK8oOub2LuzmvZgEY8GaAgshXnL8MWadeSMZ8o4cheF7COdYkFOH8/bgZ5UHXxRJ40Sgpey2yaxhXZULrlBaBmbMnbxCRyEZOjQFWagCdkH+nGmkNE1qHKObtALeAmWWblhpRV4sEWY3AwajgTpRUPUT52V65uYm9LBKSA03otUlXNX+ogTS2UctVzJ/ysRmckKCSq5tJxvfcCHeUqqxdzIRabXtOFQPUBmUqTFpUlbLfp9Q4cTO8a6Rc41TROjY1OcI4z6k8s+z/H7V0MTNtFetGW3BnRltpeaLSJyoQvtUenF8J9KGOYPR3IY7cIqISGyaveDXPh9m9KiM66vlAqnftN3KY17hYdnUwcbWgK+tMMtYgSMNn2mAtAgyj5FrSILQHf+S2vyAEZpAJiamII9eALHDj25aKSXGoJXbAU871csKQCNH+0RBVRqy4irF2+6u/wGS/x1dW4dS29rUx7Afs1M8RsGuuRC0+tDbenyrsZNLPBbiwNi19PABMtBgcNC7rAazn0gewN0IpPlARYXEYItr8OoyhsmEV4mVGCk857GsQKE2zXe2OTtKbbbNMNmsTdySHRmwbswebmMjcmoB4ucJgYjzEr/Ub5saUqQy/1xmINa6puQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3J6bU5xODhEY0g3ZnhUREdYUmZ4NXN6eVM2eDZTVXZzTHlmK1cwbDQ0c01V?=
 =?utf-8?B?WUkwMWo5M1FqQjl6WmZBVmRabVJTUkJKWjVTclNGWHlZY0Q2NUVIUm1Fb1py?=
 =?utf-8?B?L1RjV3RLNm5aNEczT0dHcS9EMWtHb1RXM1ozRVpOdnYwTXpsejJuK2FxSDJD?=
 =?utf-8?B?cGxDSVRpY2lqdnJuTlJ5Q09qS082dWNKak1NcURuN2l3aHlQZ2NrYnJvNGln?=
 =?utf-8?B?bWszVzNIYkdoS0N0TWxUTFFhaGVrazVQY1NDT0VNekYxdFN4aWh4OFdaamtE?=
 =?utf-8?B?by9rWXV2L1BRNkw1Q3RMdXlValpyL2Y0M1lYUUZ3ODVsNFFxMGlxZEtxczN0?=
 =?utf-8?B?QlR6ZFd6OE5rR29uRExBZnJ6OEpyR1RVRUlHSGE3SHk2THFndFhJT3hVT0sz?=
 =?utf-8?B?ZWpBek56aCtqRG5aSktWY3V1QysvTHFTbmZ5MTUweHg4MDR1VjREcXF2dHpK?=
 =?utf-8?B?eWR4bnlCWTM4UXNqd1pEc00wc2Vzbk04NHNsYUNJcmV4cmtjL2xOYVlHY0VT?=
 =?utf-8?B?djRVL1Z0OU9hQk9xQjNQZjN0MHpsN0JMVkJHdlVSeXNMa1FWd2c1TzVkcTF4?=
 =?utf-8?B?WDBhN0lwK3V3bkRUWis4U2ZDTVBLTUxNbVA4MUtFSmdISlZXeW9lbUpkSWFq?=
 =?utf-8?B?dlRoRHRSejI0WXJjUnBRQ0NIdVRnOWRIU21wUGk0MUM2N3dqR3NVQ3pxMnRl?=
 =?utf-8?B?Y2toUWthUXFOT203alB3b1hZRHpKZ1dQMmFPeTV2NU1UNVFRN3RpSTUydGNl?=
 =?utf-8?B?MzBtbHRGNXUzUVJuL2k2VE9uUlhBZ1RkT1U0Um1ENm1qNlQxU1Aza0JJTWxy?=
 =?utf-8?B?cFVEYzJTcWJOVXFlVmNma3RkM0txUHRiUHdaVyt5Q1BFUUdCbkM1UGRzNDVi?=
 =?utf-8?B?ajN2OUVRMFdiQ3FkRzlESzJ2RjlBVXcxQmZ3bElTYk1HWm9Sd2w4VWJJSGVp?=
 =?utf-8?B?L0x4SWQxemJzVjRTTkpGa0g0NjJPdW9qNmVtMXlHWFVkbTljdDNZWjNCTHI5?=
 =?utf-8?B?RXh4TGxUTWF6V2pUK2hBNHBTaTlHQkEyY2NUd29GbDZXRTF3MCswMUhnVmdv?=
 =?utf-8?B?aGd1eHVrTmNCQThoUnNJbmlCQXVFcGFSV2IrL1REMk9hQUFWc3VHcndVL1dQ?=
 =?utf-8?B?SzhvZXZ6dmEvREF1enRFaVJXSzJKM1hZb3o4U1Fjb0U5Q0ppQU5Gd1BqcXpp?=
 =?utf-8?B?cDVTTldyckdXSVVST1NxYXlBQU9ON3Fjbm80anQyWEJOU2hUVFJXQXBNMTF2?=
 =?utf-8?B?OFUwK2pHOUdJQ3lhUnpjQVZqZENUelR1VnF6MkpRQ2xkTXQzWjRWdEQ1aHE1?=
 =?utf-8?B?S1QwS1UvTy9QYU5mTHB3bjVNemc0Mm1iK1d1bHlaK1NjYXFoU2JhN0lvN0xs?=
 =?utf-8?B?TnM3bjNSZkdXSHlsR0pVcnA0aXdOQ2JPYmhReitCaVJ2THYwRGJtNFg3Nmxo?=
 =?utf-8?B?Ung2a3BHbFZ1TEhxMTlRK0JlZkhkUy9IRzh2UlBDY0ZycGV5Sk1VY0lUcGZa?=
 =?utf-8?B?RVhjS2pCY2xCZFdGTUNMQTF6Z0FQcFVaNmFDQ08vNzhDTFBiczdmYUE2aGFS?=
 =?utf-8?B?NVVGYS8za1RBVTBOTys2NG1SZW42MEY3WTFWSzUvTFlhbG53MW16ZjVpUmkx?=
 =?utf-8?B?UW9FdUY2b0g3Tll2Q0Y0cUNlZUhzV3BXczFSOHpVWHlxZ2dQOGFsTitqTUFa?=
 =?utf-8?B?cm1BSEREYk5Tc3lLVlUxK2U1ODBwRWI0WE9ZNGNycEdQVlRRby9tRTIzWUNF?=
 =?utf-8?B?TWlmUDR1ejMxM0p1R2ducktQb2xWTVgyRW5BNkEyTVR4U2V5WXRqZFMxUDdo?=
 =?utf-8?B?UFExNFFsZHFFWjQ1Z0I0Y2t4SWVTUXBIZU1PaTVkeWwzcWtKazA3VzNRRllC?=
 =?utf-8?B?dkowcWhROS9rNDNGSjNXMWZrNWhWV3c2cEhnYnJJSXplSFdrcEVvanF2aXg3?=
 =?utf-8?B?eWNwTjZpbUlQSWxMR3FnMC9HUng1U0Z4U1NWZnNMc283WXBkSDBOOWExTi8v?=
 =?utf-8?B?T0IvV1JYK1U1bXM2anI1QWR2TXAyeVQ4dmhhOWN3eHV1R2FOdHRBSTd3NUMx?=
 =?utf-8?B?b2RYSG9VQzl1cG9SQU9pYlI3U2FaQmFkbjFscVAvZUZ4QU9SckZBbXpwMWYv?=
 =?utf-8?B?U0ZEZ2tUb21XVk9GMEYrRll6V1FpakMzTkdNUnA5cFlnZjJYd0FTL2NGQStt?=
 =?utf-8?B?ckd1bWMyeld0bHNkWllGNUFNK3oyR0FJdmNKV3MzbzU4WmVESHdjOUZBa1Fv?=
 =?utf-8?B?WEtkVmFHZGFaNkI0b0Z2VUJ5MkdER3VrZmc3RG9qaFpiQ1p4QmxLZDRtRWhs?=
 =?utf-8?B?WlJpYmNGak14OWhCV0VWN1R2Z21kTlJPdUVLQS96VUpXbG0xOGpadz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0383f1d1-bd6a-4f36-68ce-08de7610fe71
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:00:49.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4/qGAboiiQ+V+PLyDah5HHKsk0guctOnTMbfu/2SMJCTUsXkis+hW+ZmgrNFFEReOixMLVhuG8APC7V6x8KwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7381

On Tue Feb 17, 2026 at 1:21 AM GMT, Joel Fernandes wrote:
> On Wed, 28 Jan 2026 13:53:23 -0800, Boqun Feng wrote:
>> Therefore here is the effort to unify them into a proc-macro based
>> solution. Field and HasField traits are introduced to generify the
>> "Has A" relationship, and a derive macro #[derive(HasField)] is also
>> added to support automatically implementing HasField trait.
>
> Hi Boqun,
>
> One naming concern: the #[field] attribute feels ambiguous since in
> Rust every struct member is already called a "field." When reading:
>
>    #[derive(HasField)]
>    struct MyStruct {
>        value: i32,
>        #[field]
>        work: Work<MyStruct>,
>    }
>
> it's not immediately obvious why "work" gets #[field] but "value"
> does not, as both are struct fields.
>
> Would something like #[project] be clearer?
>
> Similarly, HasField could become HasProjection or ProjectField to
> better distinguish the trait's purpose from the general concept of fields=
.

This is not just for projection, but to establish has-a relation. A struct =
can
project into any of its fields, but for work/hrtimer use cases, it needs to=
 be
able to find a specific field.

If we want a different name then I'd suggest `#[has]`.

Best,
Gary

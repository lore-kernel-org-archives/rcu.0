Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020109.outbound.protection.outlook.com [52.101.195.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867553939B9;
	Fri, 10 Jul 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690705; cv=fail; b=fyqGU7il/2sfuTzBSrIygfII6jvYKo+FS16krlrZVpQXl5B2e2XCvJHOV3irE7e9CBCLYqogHzmS3ncuwG8OK+f/0q3KMtvCL0n1IKJ1Zgs2KyGqyQXqfeVo/zUOamlpDIIN9WdnOxm/Z4KN/REpxOS5Cr5CM2Z/QZ1ARi39kKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690705; c=relaxed/simple;
	bh=9e+F+6qPhJ8mPYna49Kk7INok4Ug1U0g/fmUKbCTM1Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LmuutObFH+oaXIP4E9BeS9UL9mcKSNUxG9hiIZ5SgBVvbTGuZnyDHrI2UdFRysi6/CFiBR5pZ0FCY0kwsdGQTperNNO6CzPCZ+Jy3dFxjAnsXKlnsEcK6+cu5/Wwh4pt5Pdsd3Lyl5ZrJI9RIXvhE4fwjfcE1laz3UFOVBYn6e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=P71UitPQ; arc=fail smtp.client-ip=52.101.195.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="P71UitPQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcB2NxK8zHARGou6qY5GTQeGn3fDIcKIm4LBr/EWmpTu4Y2RufuFxLTf5FOYyEJKaRJGLn4/f/C/knR5Ha1bCqrg39X7BnUcBm0J6PdLtPhEGtRGOH5pRQZtuyXNz/BlJXBX59avVHR/LQ20ubxgpvWDvOgSY63SyD5+mlwnYhJ7mI5JneU3+9MsY3rdUywe3lmdpVmNLo7BEpgB/EegXj7G5wCcwEqN2EWXN0v5RDdBLeVZsImB3Th8agMz7y+zJUG6HnRd3Y8zxidKROw6S5Edl+x9P+dDF96+OZsTM+cDxWrTj+a5oyEySbbOrRU2dR/JpK8D8gKNEnxaZoJUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxLe7gmnfNqfVrIDUR3SG8+DcSWqV+4P0lKCWEcdoWQ=;
 b=H8zo0wA5lVbUeQ5kE2P2QGZzT1MJcGhkDLC4odvonXY76pxoX/9FpuYO/DOv3a0TkYgar3df5ZEMcgH2AjGtkckJCtAIJEhu0McZb8MN6O5/JdpfqfYqjFRN2rFy6WwiKFZ5rd7XXIbwjHQF4JMLz7N+C0NmVMar01ijuCZrPHtqzNduZ+xsC3UQ/RjjvWtV11X3WrrdlBm4u15OIfgW5Qv41CPxQ4ZYijFa3kfzFn5apXwaXiMpU48n8QNzJAC2mquHOSC4mNSc+k/DY1+ZnrO+0KbsNBeRgChHoY1pBDwjAC9KgdnajXP7NxJxjHWrfcOfvxVvvfHJPjT1AV7zQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxLe7gmnfNqfVrIDUR3SG8+DcSWqV+4P0lKCWEcdoWQ=;
 b=P71UitPQlX0ufMZugC8f92YoeXSeehs3VPjRXPPmh1ugCi9cL9hogyTHLTC97NTp54w2Z9hVGK2Tk4Gd012rl/yYwRGjTyLSoqVHrDwhDhpFbrPx5HGQSgECa5nAQbVImPGfJ5By4ZwvP9ghEr/xQ8ILxx30eYIzkYGvGZrRG50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2085.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:38:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:38:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 14:38:17 +0100
Message-Id: <DJUXKYGNI7B5.2VUY1SPIG5RZB@garyguo.net>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 1/5] srcu: make init_srcu_struct() consistently wrap
 __init_srcu_struct()
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260613065348.96750-1-work@onurozkan.dev>
 <20260613065348.96750-2-work@onurozkan.dev>
In-Reply-To: <20260613065348.96750-2-work@onurozkan.dev>
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2085:EE_
X-MS-Office365-Filtering-Correlation-Id: af6a87c4-e3a2-4624-54b9-08dede888075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WmRLOzDZgFcTd1/TaBQSkcoPbU+cXTltaZPsU+sn2pIi7TefrqLkTyhjHzUzO6rJ1RmSpWq8LzSvW42QZcPXE9I83UA7kMjNMrHP9sl5sWoJMktUhe/8vx381l9Q+6Zz2AQ+4P6ruVtYBKYESAn40b0u/vocxhZE1CyZMs7dNHO+FqYGILAALT60Ow6aGG8H6T8Xl0Z4MQAAlb5/wav4kRB7YuRNqJpWZkBe3q09WEd/vyfePD59mZxhgujwNx3LnDY4DtNwQrqUWSCsf+OPWOHi8nw51RBfNDwz5ZHQ9/kEUWVt3BSI0bKcRSg2hprBQg2+r3px1N28koR4/OpYyUikxg6qcAYcTmTH5wjVvH7l/m/sbw2swHLA2PxfN/wvZNeS4U446zEZYZrae1w8+bkad6YPwbGfsfO8mwqqaX8xwYotW4IljmNBxzxKF+zi1yUfGiRNjyBu3ZT3LO1dxFUHAeqH3dk4kTqlAVVMrMGFnP+RJoVG5bG73vSYaX7RhGYc+ctENBMoIJ20F/4SNswtDhIu9D7EfAAEtg6uL6gqmAZcKEiSMnZhgmJNxcF+aFYiWPoIA8e0zWthAt+UbbkWIjmn9fNZsYyb59zv9XPnD1rnHLoO64T4c3TNnVXidmdN3SrOS1k24jMleoCfK2CYB/sCgHjSwvFYf/cCMXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3A5MjQwcTNIdVJGcGUrSXVMSWpkREI0UEdXRTZwOHMrbjhPSERzVUZXYkxO?=
 =?utf-8?B?ZVZMY09ZZjlhSG9YLzJCTk0wdzhrZlpNdmtNVUM0citIc3N1ZzRMSy9meXFQ?=
 =?utf-8?B?R3BqRllqcmJsRGUzYlgvdGxrc3pVekFZNThnNUVJWWl5WGFibkwyb0ZJM1pz?=
 =?utf-8?B?NjEvYW53NlhBdUNDOUczeTMxQ2ZTdmpIdXRid3hBc2wwZzRqdTBNQjgxeHZl?=
 =?utf-8?B?dWhHOU50RGNLc0M5TE94SFIvOUxMdzh6ejJ6M3BXRUFOeFo4aitLSUwwNy9l?=
 =?utf-8?B?ZGtNNDNBRjVFSGZXazVaVk1aZm94YTc5R0VoQWFwUnNteVBudGQ4MHVFMXFr?=
 =?utf-8?B?MXZHNzdsRzdBdE52RzFSb2ZsbTJzOHIxQlhKQVRUZHFxSTNTWkpZb0xIMDhF?=
 =?utf-8?B?VjhPZlBzVzdyaWJLRXpmUWlBR3daSXYvdFVYODk5M3lXdUtMRmc1ZDBySzdC?=
 =?utf-8?B?MUZuaXluSC9DanlOY2poNkpCTnlmSGtQTEFBUHNmMHdhZUlWNEIwcWE3NzVj?=
 =?utf-8?B?UUltLzdON202a2JXN3pEbkJWOE1NbURldXJOUlBMOXhEdyt5NEFCSGFUUjlK?=
 =?utf-8?B?R2dNVVRVdHJ3R1FJblk2eE5seFVsVzA3RmFiMTAvbThiRFhqSUpmRWdUNy9F?=
 =?utf-8?B?Y1NkQUFDMlJBVFU2dEdBVDRzdVJlZUJxakl5bU41UUZoTC9BTGVVNnFlR25M?=
 =?utf-8?B?L01wVE1vM284MUoxNWFmSkFwWXhvckRFQkhFMmtQbE83R3dIcW85RE9uWjEr?=
 =?utf-8?B?QzVQWjZtQUZTU25STmJVTFY3ZU1PSTRORURkQVlVekYxNFdkUGNvZkdOQUgy?=
 =?utf-8?B?VTBzT24wcGN6dzlGZThLT0VzcnlQbEltU3hNVGg5cEFFdER3SmkwcXFKMEpY?=
 =?utf-8?B?NE5wRHdqdi9tMm5GRjBCb2F1ZFMwcFkvTElBdkFSRzM2UHpBWkx3Yy9yRmN3?=
 =?utf-8?B?VlgyTXh0N2s3a2tNNDBibmlpdFNtdXlnSkVsTC90QjBSbGExWjBIUDFpdkdy?=
 =?utf-8?B?SkN6OUpPWkVPaCtEMFNKcGZJRU56SlNNWHMzcUF1ak50c1p6WHd5VmZyYTAx?=
 =?utf-8?B?U0lSYUgzeDhQbmcvY3BvY0pqWmd6Nndrdnh6SWFCcXNlYmhnL0owWmdhclN0?=
 =?utf-8?B?aWoxQXJ2bncrM0ZHQlVxNTN5eVIzdWNoWlJsaDZ0N3B4OGlZdEpvUkgxRmpR?=
 =?utf-8?B?NmlRS0lsenhkRFo2VW0vcFVWNytEOFE3VGRzRWk4ZkhDVWpmVWtXOG9qN3My?=
 =?utf-8?B?bFJ4Qkkwd0MrY2N2eCtnd1JtMFczVE9RazUwSWxJQVNUVFRNRkV0alBzb1hL?=
 =?utf-8?B?a29wWTVvUHRSSFEzSHZqVk5ublRTaDFQbEszcG0vT2ZNNDdjVHJhS2lBcWlN?=
 =?utf-8?B?Y3h3V3FYZmFlRnBuOXo1NjZKQys3dXVVWXJONFdDWEFwTVRHc3pLQlpweTFv?=
 =?utf-8?B?MXRBaE9xakpZRndjcHRlY0l1KzF3RzFubHlkKzZGS2Q5emRsdlJoSjAwTUFK?=
 =?utf-8?B?SW9FVVExc05PaHFuMG9tVEp1Q21KOVIwbFo2RDI3V050RS9mTGVLTndMUG5E?=
 =?utf-8?B?R3BoZFNJbEJLNDZoNlhEOCt0TTM2bnR2WnFJNjgxUTF1b2NseFpuK3NadElH?=
 =?utf-8?B?dGxnYjRQVjA5Vjl5NjM4YURZdVVjVGU1MlhuWGFWTmhrZm5sb0Z2OWdGS1J1?=
 =?utf-8?B?ZHEyUXJYVmlSNUVHeFpjQ1ZiaEpHUzRiSDZFa3hVVW5wSkQ3cDBmcTdoL1FQ?=
 =?utf-8?B?akIrQXJNZ0tBN1F1SGkzVytJQWs0cS9QdU5uNndTcnJzOEpINjJIS2s2YStW?=
 =?utf-8?B?L3RWVzBqdlFJaTdIb1NURzdvcjVSTWY3MEsvV2xWVWFDMC9temRjS015OUVi?=
 =?utf-8?B?Tzk4NVQ3VFRvZGdlcUNkMU5WUW5ZMHRzUW9RclA1R3BmWitrekhJOU1jQTAw?=
 =?utf-8?B?M0xVS0FTM3dsbDJNSENhcUwvZGUzRGVIVCt2WGNnTDFGKzlnWTZ5Zmh3eG5N?=
 =?utf-8?B?d1IzakZ4dk8vcFV5YmR5M2Jxa3k1aGdjQTJQYlg4djVabVlncUNVY2kvM0xT?=
 =?utf-8?B?V2RISGNQY2Y4bXhFUWZMMkpjYmFIaFJoWnpIUCtZZlZlMmJXaFVkYVk2NExh?=
 =?utf-8?B?dW5VMmhucUlWS0NLR0IvVG5zemI0V2hpaFAzdmY1THBUcDduUmNlTWxZbUNw?=
 =?utf-8?B?VCtRQlQveGpyRlZHOHFOQUhvSG11eFpDM3pYNE9nbXBRQ084SFVmRmxLMEdu?=
 =?utf-8?B?VjJWTjhMbWVDOUIxRG5DSm1lcmlFWWdwem85aVpveXpGb0M0ZVRNa0gyQlcr?=
 =?utf-8?B?bjJYMlh1cUlwMjRkUEhNWTRjaE5pa0pjMWVoRWxlc1FwNUg5aXFxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a87c4-e3a2-4624-54b9-08dede888075
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:38:18.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /auw1+M/SpvudRstbkRMXeCoznsZUZZHnG3nKEA8Jv5QurFINks/T6H7msONPWp4u8+SfT9N9LhlpZ+Kk49/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2085

On Sat Jun 13, 2026 at 7:40 AM BST, Onur =C3=96zkan wrote:
> Restructure the SRCU initialization functions so it always follows
> one direction:
>=20
>     init_srcu_struct() -> __init_srcu_struct() -> lockdep or generic
>=20
> This uses the same wrapper style as mutex. It avoids the old confusing
> style where init_srcu_struct() and __init_srcu_struct() called each
> other in different configs. It also helps Rust side to have simpler
> helper for SRCU initialization.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  include/linux/srcu.h  | 29 ++++++++++++++++++++---------
>  kernel/rcu/srcutiny.c | 12 ++++++------
>  kernel/rcu/srcutree.c | 11 ++++++-----
>  3 files changed, 32 insertions(+), 20 deletions(-)


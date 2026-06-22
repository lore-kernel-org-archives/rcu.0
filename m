Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020119.outbound.protection.outlook.com [52.101.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D1221FB6;
	Mon, 22 Jun 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150433; cv=fail; b=InEDwyxMa7u19kS23qpo/56aJHzSL/puOttNME+AoEtzil1ZPp/88ke8Ckwzs0Fb7ve6hsuu0Xoka6ba4fD5z6RcSTyhxp1NYF8eWBNg/GdI7hYlk8kl+HF5FA1/uIMch9D8xLJm4oDqG3SY4V4Zvcp9HAgSjpmEU8mzcS693PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150433; c=relaxed/simple;
	bh=zRJ+dUmKVNziYD4Bb3nLMvnaiWzi43MrE3UhcdKb85g=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=n1rSktdzKNkLTOC89Z++3QAgwW74xCbT6Iqx1miRMjT63r117ZMaZVFtmLZ01BmW6xuWS7/rpjrSEoJ2IC5/n3MoxBKdRwtzAIzTi1WhcHqdRU+JTx+CphLpdsZsMKgrpHg4T+bTuG/Hx3G0ckC/75aH1p2G4cfqjvFmlD3Orgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GfzepjaG; arc=fail smtp.client-ip=52.101.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GfzepjaG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxXvnYgZ1yVzBMn6lP3fw7Tv4m/vfR76n+gD+TyIvcTET0U05sSisWDbwIVDRLOn1EVXr9/nz8KUsGYq2D8g+ICyvH9JW2EI2oKwGaTxuqVP/cOhPSlJ0k/kElhQ83mqg2BgsumMKuQtcYtVvHWoID/6w3NKKKanFjz3JJidwgjzXTK27Vj/GfsBEe06IFOO58YNt7L8K6wOCyYgVqCtKQCoSPOp+Wa1LO9j5r2yCpGZB8YnbIWyIkZtLMB+obJNmrV+j0/WNHrObV12di9zG6FxRUzBZJrDuxJg5g5bptw00mzzeQw9gO6lKxFWbWtENjnUYG98h0gwBRx62kB5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLwqM4zpdPgMK1ZRn9tEaWXHyo09K8FQ8dEDs3rofs4=;
 b=OJmTwnNn6+sBi3JGHz/IWDgKq+g7aOtJMj9SNtUZelceouv/+OcJcmZjtu7FcjXY8EfZweRJyxUsWmnqMJ45PnPDCrlnPBVSz0gYWjSjmnHe+jOIAffhD40V9+9ttl06WK4d9bbj719r6NBJ8+ivVooxBHEIz+m55k5ReS7FNhpF1yH42g9xZGhsQmTH1e8sQnRVmSX/nM3BIdQA1yU0dPktipBAjbJ0fFoH+cb9TtsLFc1uCv6ys1/QWCuuOnOSlU9Fzbi/Jlb+MZZPi7AnX9sGCLfflDlM0BUyGpI4N4Dx2xawAUffedLxGw4REUgg4gUpbUEa6UnHd6Pdyb2N4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLwqM4zpdPgMK1ZRn9tEaWXHyo09K8FQ8dEDs3rofs4=;
 b=GfzepjaGFEQytQQhbGyb9w2Rgvl+e0ipTc3pmIUBfu85IOGagGlSSDto/EgnKi22yxqitqMt8ghPhBwGnM1D+MN1jor2vedTDq48m4cQIGs62uK+3nPpVFeryTfugvu2Wq/6uBpfycDVJYK9GVD36IOaYaTcIbdjLRI9KyX95Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 17:47:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:47:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 18:47:04 +0100
Message-Id: <DJFRLMN8WQ3Q.2N6EATIKTNWFZ@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Lyude Paul" <lyude@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: revocable: Use safe synchronize_rcu()
 abstraction
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-4-phasta@kernel.org>
In-Reply-To: <20260622173250.411377-4-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fcc41d-25ad-4433-2af7-08ded08645f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|10070799003|921020|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mjCPm6tBF9mcXt35YDI1je8J1dc3wrCacsksnu0HbiF/4YcdkO6jY2+GioKBFLGYmG3/tJd5N+sqCc1DyZZuV9DGRRlZBso+am/bitD81B1ilzSz5HStxbZODk/fv8TFp72lTRiqqmbwk/DK6FRE3TG9pNY3fqs1PpH72TM00pObZOORg8UroGmK5neD/Cm8On6Qipy0B8AnkUwoDaBeVtWjsTcY5pQf01SIcJ8RQUk3Hgg9cgfGxVMIwcE8GqAEYmnjvISyCST2GXQ4AaL1YBFcBqJDSBkF2mwRTOx4Fgzf9hFTuJDgqYHIrzTbOjTpNh0TdyJCxmyY5N/BJVGG2KErwA6B3CQlrCB8EBdVopC7Rn2kCgtx4heYEWuE9UPffBMSNdwmL7pfAKlzVSFjhTzZXlvb61MQVK9fl1EGwnw4aZ90rA8BvCiZUGksTQusNi1KJaXBzgWFcpxbhqBQmIdJRY66yUlCAyQuKDaFh/6tJUOcTqs1krahTn9JHWjZ+pV2zc1mjpniqaH8LW+/fhYWaWR2/KxZb14R8qFXuxIlixhKedOfs2Rw00NEn78PmKE1p9aFvzjRt437u9dEBjlwwsup/7CrQCQ3Oe7/Z+qj0cn0fFx277Ybz3tn90QnOdYmVpZ1m9ltfjn/kvqA38wpnDt2NjYP9pBza4YDWzml+unVzOrNkC4S3LNbgXQBwmohhCnQFsMK/ecnDzaHoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10070799003)(921020)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUpjeHBCYUYramQ3UFQxeFNveGlBcDFJdWRWd0FnNWM0VUZkOE5ja21jWUFR?=
 =?utf-8?B?VXZNejZaVHZMVmg3OW9CdmtBL3R5andFK0llQmh6Z1FSUVhUZU12ckxhTGVr?=
 =?utf-8?B?YUU1MG8xWHh5bFNOSXl4SFJQZ1pJU0RZdkdBVXVoM3RRZzM5NjdXUmZyLzVm?=
 =?utf-8?B?ZGdnd01qN0dkVkFSZytoQWpJcWQ2VW9YWThsc0lsTE9Zd1UyKzViUUlQSUR1?=
 =?utf-8?B?VE45Qm4rWUFZVVQ1aW9mSDlQWUN1T0RWanRydFpLTDFkN3ZtcWVhMUtrbGZs?=
 =?utf-8?B?UkVPTCtYemZxUlVlOUlQaXlvS3A1anZGYk9XMGppNnVWdUtJeEVjRGZlT096?=
 =?utf-8?B?dXRYUE9yMktsZ1FCUzRoQW5ibnZJbUVWb3doQXloTC9TcS9yZHlYTW1uRHd2?=
 =?utf-8?B?TFZjVklGSmxLOExEMWFqcS96c2NxdEVDdW1NZXJxbWR2UC85UFVab0lqVDNN?=
 =?utf-8?B?eTdCY1RkWDNhK3V0Z0tUUWRTOTJEWVA5RUZkUitMWFBUa3hSZ1o3SG5HaTVq?=
 =?utf-8?B?ekF6SjM1TXZBQW5GWjBiUU1xOFQrWW0wVVhaMFB3QXp6QjBSUU9NWi9iYktG?=
 =?utf-8?B?MVRMakttVmhmSmNuVllxb0xObkxCWm8vWkNjTzRweUZqZHR6K0drR3FWSVNV?=
 =?utf-8?B?MENGazJ5UmNnQy9UbFBJY1FtZWNuZGd3cnB1OGl3NGtWaCsreDVORzdXanM2?=
 =?utf-8?B?aGF6WWN2R0IrVzNGWlAyNjhvak9hTDRNQmN3RUV1aFZ4Sm5SenVDbVhBNXdr?=
 =?utf-8?B?d0tRYndDZTZ1TkNCTGh5NGM2M05OalhJallZR0NzNXlzQ0hnV085RndEMTVV?=
 =?utf-8?B?R0ZCTnhtODBxSzljN0QzZUxNVS9rN29Nb21aOURUTUlsVUVlWnpTS3c4L0pk?=
 =?utf-8?B?NXZsUy9UU3IxWHIwNHc4VGVnNnpUNzUzeFdsZ0grQ3VRWGRvaWtSeWRvUnJP?=
 =?utf-8?B?M2MrYi9YYUcyTSszTFp4RDVVR1ppUHIrYkRhUDhwYnhUSlo2TS95eDRWQzBV?=
 =?utf-8?B?YWRaaG9mSml3ZElZbUVTdXo4eVNQVEtnRVdqUW81MExnTHZTcTBoRHFneDhD?=
 =?utf-8?B?STVmdUMxU3FnYXgySG10MjZNRE9JVk83dnMzUjlXWGtoZVNXTGpXWXR5MEht?=
 =?utf-8?B?dlRIZTh6d0lpcmd1V3lWZ1NZNnYreE52bXdwbDhreVJ1bnh0dVlVbzY2eXlo?=
 =?utf-8?B?OU1KNEREL3hHTFkwc0RHUHBRMUJ6WFNjS1Q5aWp1bWVySjV5aklENjVNVGVP?=
 =?utf-8?B?UkpESU5TK1NDUVRxQ1pZdHArUDFNQ0NUVE5RT0ljd05KQmtYT0ZMeFJtOFBt?=
 =?utf-8?B?SEUzM0hXc1B4SHdnTS84dWhMQmZqeWs5ZEowbkZhd1RIM1pIMUJLVjBaSXk4?=
 =?utf-8?B?ay9pSU4wbFdEZUtrUkgwZGozbm13N1JaVjNVUkkvaXE5c04xaEM3U3J5T2FT?=
 =?utf-8?B?OUdoWkNRVE5ZVWx1RGtLL2VZT1NnTVNOVDZNZHA2ckVJZVpSWENMVDZJMEw2?=
 =?utf-8?B?eWwrblJ4SkZyNU9mMS9jbHN6cm81dTk4b3J1VFNPdkg0VnNUZU9tb0VYdTlu?=
 =?utf-8?B?cS83WmVuOXFzcVM4cWpLL1RKTm1rQUxDU3h1cnNUdW1INE1ZSGlxUmxZeUJh?=
 =?utf-8?B?ZzQ3L0YwQXpGTVRsUDRpdVFKMUxSR1VyM1FrcmlHc0I2MFFsMGVEcDJ2ODJv?=
 =?utf-8?B?QWZjNkRvcmtDNjFMQmdQcHcwTy9HaTVneVp1U25Yd3I1Ynh5SHZ6NktKQmg2?=
 =?utf-8?B?blQ3M3BJWk0ydG5UN2wydDBLQU4wTXI1Yzh1T29SanNvUEdGdFJ5N0J6TDBt?=
 =?utf-8?B?dW9XWkpqRFNMSlRGRnBMVGhaeTFzVFpCeU81R3Y2TnczOHNPcDQzRDNhTW0v?=
 =?utf-8?B?QkFBd2dMT3dzSjAzMnJweHpGT0sveXEzMWFaei80SWxyd2RMSUtCNFVJSUdk?=
 =?utf-8?B?RDBaV0hZN3R1WXo3MUMwcXV6TGYzUVI1ZHYyazZIY01XNHVSQWIxTmhOSlho?=
 =?utf-8?B?c2JWQmp3RVlYaWREN1U5cFprVllQWmlZY09rSWtCWkdaMHB2SWRvR3RXaVha?=
 =?utf-8?B?M2Qwa0xBeU5FNEZqMFBQUE05NjR4VE53S3BkYVhOYlRqRWZITm16RTRVNmVP?=
 =?utf-8?B?eEtWZTUxQ3dIazFJbHZGVE1Hc3p6aml5LzdNM1RvQkV1VENBdWR4dnc2b2VK?=
 =?utf-8?B?WW94VmpwYnd6MDd0ekQ2TU5KdHp6RDhCdUNuZkpRajBHUFhXempBd0lFL0JF?=
 =?utf-8?B?RmlUYzl1WnF1OUNPNWR1M1JWY3pnSjV4eFRoM0FpRGJ1N0hiWll0dnlEWGlt?=
 =?utf-8?B?cU1ma0FOaUlJdGlKSUFOcjI0R0RqTDZqalh3Q0JlSkNBRHFGK1ZYQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fcc41d-25ad-4433-2af7-08ded08645f4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:47:05.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+5g7rFZ0VF/mc9jxdYwrfliIYrM3YEJ8C0baVEDo2YdOpCTU5rCmqrZtQNO1OzVt8TPRoxzMz93kKJfMct3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5525

On Mon Jun 22, 2026 at 6:32 PM BST, Philipp Stanner wrote:
> We now have a safe wrapper for the foreign function synchronize_rcu().
>=20
> Use it in revocable.rs.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/revocable.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


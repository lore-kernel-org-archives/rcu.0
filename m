Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021117.outbound.protection.outlook.com [52.101.100.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2968221FB6;
	Mon, 22 Jun 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150446; cv=fail; b=gtPNTyHFEQf52zpQFKqxu99lXtjO1SCodyfuV1Ekqt4WnXi2fibVe1FKVMI4Jh+bBxMTTDC9BzqjoQ6NO0XMqzYigcEMfK2PaDHdglFYLBpYTozpM9V4m85e79eyqtuEJFQZ1f05zy6uE6euTzCvjBAJNef6bdzHpjkzelqmNvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150446; c=relaxed/simple;
	bh=C6HCg33FkqmtEbkUvbdb/QCrGRvNyRzxgEwHgcsSvrA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jPeatcT+ck1AyOxyqkHtqzts7GtZs3gvFtQwAmbWAdQyaBNPNKbB2a+YLbKmw6fqbLER6tarooRN2WGFTcyibVGz8A5kJr7DIfez+9kUo2eGoEtu8pssmXJbCMaOXPL1vY43UOtz2MG1E0SevyLyzfJMx9VuYBssRSblM9n6J9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LqnB+kZs; arc=fail smtp.client-ip=52.101.100.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LqnB+kZs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWvd1phqt9rBzVMFKblhWogpHNTFjSnvYOFYbKcKflSeCPaTV2dUB0e+TagVAEqmouvTRI8A5+M+XrMc4/Sj4V4n/lYr+w66nw4TSkz6TyhozCEHXXQGb3B76jpDgQl7OKqEpOoukg+7Ea/TlqrZVDFYMBR1Joarb+wGSnp2J7kwSGeAdb3SD1u2Tdl0aqBM2XULLQhvyTS+IHIlY3H81OwPSbrQJcITcw2KViHFaW6NDL967xZ84n44Zw3QtW0NHxjgMGRsXGs7KXl8L5R5ME8j/7o84spcsmfPole+2F0TcJd9N9gpNmKRfVKASqXuL7T1Q2lv8ZSZbsk/ogHlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCH8bQjFU8gtgtjmKOT9u3ciUbaOc8bKewtcsI4Ryaw=;
 b=JVpJ/N3wK2KUkTs1MWhmXNkwMZiWnCvfY1+HGWAkBysNQOG60Sl9dM1DY7+I0CdhWSgzW2ctKHqwh8wdTsuPyFilfEunh110YVRNACQBl0DRVOLyJ1BhaLmePYyfaHGVasEV+mkmnbUDaUf1QTot18OpJ+d/bv+TOxYJyAI7vx6yB1/sP7zziWQgASOH+n/OC3ah9rvHf409LU/KLl8ltlf6kVlmd2ccPn5sGBxTQzHFRbMjWBL+zLwAIuy/ZlqfIGuoc3WOElj+LEudWI7Iyl58SsqeyHtLnIPxQkQ3bT/9Qna6jrBfsbexp0w9X/1m37EvLgWD0NK6+MAXB9qZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCH8bQjFU8gtgtjmKOT9u3ciUbaOc8bKewtcsI4Ryaw=;
 b=LqnB+kZsyrEyIYYoxYoH5d6uY2I4qFVKqUhXCr6Vd+9ygtIz6xTvAsaGK8sbKf5Y27eFxFFQ1E1z/N69kVBVlsw7KHiFMfvqwjM42km8b+mbE0y/4F8P2QPkMs+bfRB/lbBmukI58ISxsMLEzTQrvqziax1Mkhwbdi3mXnP3Ef4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 17:47:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:47:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 18:47:21 +0100
Message-Id: <DJFRLUL6QNEP.2RNRVNH06NCBS@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rust: sync: Use safe synchronize_rcu()
 abstraction in poll
From: "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.21.0
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-5-phasta@kernel.org>
In-Reply-To: <20260622173250.411377-5-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a674db4-c07d-441b-cccb-08ded0865039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|10070799003|921020|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LgKRlmboQ8eETVAHGgolZY6kSW2NHDiAIQw6lo+PcWdccjVjYYYG2kof5PsvwRC0nCV+svSD/kAGzbCitbdj8PKniYhPOQfmQzQ4T9sG/v5bspV1hzzD42xoKDbPNC8lffOpLPBJMl2a2ky0NwODR7IR/Z29WtZSM4cECW65GgKTbwt+7oAI/e4aVbvZB3aoTsGlkEm8/0y78eMP5FqCPfhHX+FXBq4ydxRcmMhEbX7Rff7I2qrbcB04jfLT1mt6h8FRPzQk/OBf2xyR5pXOj6zDJtXfStBjvShkZnsZVqttkcYK6zECUvN/BGXhszH7fRbpRG5ezdGscL9MF/hJZ/GhFdxbyhHT8AXA2YVomiF/WHV1B+HuILhwodOImFYPQEPu/QbsnPdwNdpqC7bIX1xKVc3m523jpi0af20nmCy29Nzo//CHhJbd1YcsIIeTBNFe761oW4H8ou2CsxPZjvby0yvWkw0J+RyTy+BoU2T+UtuneAITLH4Ex2N0aIJTsKJTGwJqGfVeVzeSs6YUpgsnY/DwabhZH/G0j8RG1rd3T8LZOcjzrXFkyoCTzHLrlNZpMjvZAwmBqg1e4QPSk4FbvprVSsVVDOEslZTrtzRi27Ks9WtXoIApdIQmjddSzyzAxH0t/5ibpJCQPHEEUlqCPqCBWn4/BMTqjeTlmkaZhxJ2QVAdAjoABUp6bGAUj2RRlji1j/H4+MEmzXT1Gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10070799003)(921020)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lpWER4Ui9qUXEwMGw3NzhaQkRuZnM5R3UvRE96bFlaM21lWlpyVXR5bzBy?=
 =?utf-8?B?WmNXZWRYT3FncS9iS05Kd0JuZ2w2R3pBeVBveUUzT0ZjV0JzMDcrOWY2YTdt?=
 =?utf-8?B?TG1tbS9EYlA2NnZOY2hvNUdQQXNrNzRSSU82c2l0TitaYmlVL3ZqdU1TcStX?=
 =?utf-8?B?MEVTWFBVZzFDenBheVZGR1VQU2FCenZTQ0hySmF2VkhLTEVObmwyRk5QK1gv?=
 =?utf-8?B?NnE4aEhNNEdLbWNrR1hDejlkVkpaRGh1Q2kzTzZMcEhMRTlQeUV0YjF0NWNi?=
 =?utf-8?B?NW9UdVZBVGNCeDVSMzUvWXNXKzRyYi9WcmFCd1VRVFVzQlpRK1FYNWVjcC9D?=
 =?utf-8?B?UnM4ZzREazZ5OWoxbGFuMTRJTzNIY0c0aThlTHpkbk1iNW5KQU9DcXFuQ09Q?=
 =?utf-8?B?QkZhb0VKeHY4ZDMxcXdnVmlZaU5VL1pyOFRLcjZuYklWWnRLVTFJRFpGZlVs?=
 =?utf-8?B?VkJubS9OSW5hak83anRzUXhVMkN4V3lDRjdPQ2FWZ2R4L2xMYWcrdElYeDkr?=
 =?utf-8?B?ZHA4LzdTTnk4SkpKMGE0Vnlyc252UHZQMk5qMk5UU2tjUVVid2ZmcDlkc3pq?=
 =?utf-8?B?cStHKzZISU9KbUxISTJRbjk2YU5IU2NQckNpSHBuclFrUEZPY0d3bFF5YUY4?=
 =?utf-8?B?eDlJVHlhWVdLZjczNVhsRHpRV3pIdDcyc3A5djFVM2lUV3BxL3FYR1MxY0tU?=
 =?utf-8?B?NjFwMWIrNGNId0NmTXFaMytTUVBaQm5PY0VoY0VydFJ3Nm5JOVdNN1RROFU4?=
 =?utf-8?B?aGhBL0xtMHZoeUphdTk4L2Q2Tk45OEdOd3ZmbHAyd1JXY3VQRUxLSWJrODNz?=
 =?utf-8?B?cnk5MjBBS1Q4SmhRK0NwbTVHSWw3UEg3Z3daQUxTR0g3RUhEL0h1bFNUanFq?=
 =?utf-8?B?NHI3RW5xNmVwRUkvL1BtZzAvc090UEVtdzZUeFBYMVBIU2c3cHdwL2FXeXdG?=
 =?utf-8?B?UjZoMlZqQzFaN0xQaSs0Q3pJcmNJQTF2eUhsK2dkQll0eDB3dm4yY1c2Z1Uv?=
 =?utf-8?B?VzdIdm9vUWRreTlqMWpPaHNiL3FteXdMc2hwZ3NVazVCdGdPRFpmOURKZUhI?=
 =?utf-8?B?aUhFbTZ0eEdkSmVmOTFoSjE1ajVDUFRrSlBQclNwSEpYTlRaTWZBS09XUzl1?=
 =?utf-8?B?bU8vUXJTbFAweE5yOUdiT2RTSVRWTDhZVUtydldodXN0T2U1eTZEZU4xMkxC?=
 =?utf-8?B?QnhIS1gwOXNZbTc3aTZ4NjREM0NTNTNOenlKSVFkZzVCTllleTQvQmM1akZ3?=
 =?utf-8?B?a28zVjVMbUFMSk9wVnl6SVg0U0NRcFlzZFY5ZWVrSFJiRGdML01GNGcrZzdt?=
 =?utf-8?B?TjQxYURENTVtVm9wNWRkcVllV05uTjlnUVJYTEVPcmFkZm44UXRNM3dsYTda?=
 =?utf-8?B?NGU0QzBZUlNWT1pkaG5Qby9PWDduU0hWSDFuQkdNR0E2RkxVdVY2c2lLN0xT?=
 =?utf-8?B?RUYyVTI4amsvQ1FWSG5BblNZNFQ5Q2ZqaVA4L2pMQkFzaFl5YUdYU2VVdGQ2?=
 =?utf-8?B?Vzh6aURYaWtaNDJoOEpyTE1KaDYzZFE1YTk5Vk9BZmw0N09mY09NRkhaZkFi?=
 =?utf-8?B?RitIQTFDV1Fsb0V4ZzdFbExueExvYk5JODNmcW90a2VjVExBemJaWUM4R0JI?=
 =?utf-8?B?S1hyeHdMRENKUk5QTmFVakRKVnp0Ky9ya1o3ODBianFrZEhHZ3NjTlFQRjl3?=
 =?utf-8?B?ZUxWTWdzUVRpRWZxYXF6ckluS1lsNmNsRWpzVTBSeFlpcDBJRjU3ZGZra1I5?=
 =?utf-8?B?WHBoRVVhVUkwaHE5cDM1SGNXZWRQcCtic3NCc0NtSHRRWU9LbTNjaCt6d3BR?=
 =?utf-8?B?cC84Sm9zbHVIa0c1RUJLVkNSWnVVa1Bsb1hNSHhlN2N2TU0xMHhrZWx3MGgy?=
 =?utf-8?B?VUhjekRVZllwWXhEM3pGOURHemRTbllrdWVDMVpUbmZqNWttQ1hFUXJBQTZL?=
 =?utf-8?B?eTV0ZXZ1bXYwVytidFhZVGFJYyttTVN1ZzMzODY1cXdXYnRDblJvSUxKU3J5?=
 =?utf-8?B?QzkvMnRocUFPOWUrdXYwaGp6cDl3WFV3WnBSNFZKSThPQWVzQ0Z5M1VzalEx?=
 =?utf-8?B?b25sOXNzV0ZqdzdPRU1SeHlpU0k5SWs4eHlnbXZLanF3Y2hZc1o0UDZJU01w?=
 =?utf-8?B?dnRGVDN4SyttSnNmaW0vdkFwNGJuRTU0V0dIUk1vSEROUXAwOVRYRXFIVC9T?=
 =?utf-8?B?WFdyWUpON25MM1BncERmMVFaS2pqeDlEOElhMGxvdmxUc1I3U1pwTGtPQ0xH?=
 =?utf-8?B?bHUwUEhYbytKOUpYd2RaajcrT0VnUERHYy84Wm5LZDF3M1BqMmJibEFMTlNl?=
 =?utf-8?B?bVVja1YxR0ZVMlJoL3lhKzBVQ0UrQWQ1aGI1cGtXN1lxekRWWVREdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a674db4-c07d-441b-cccb-08ded0865039
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:47:22.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWV1gc4PuAn8wG2LKKfUDc84ZIrnjF9jFNuc6BQOIp/9k0dcZDluwN+tfe9uCzBro0SZVgAU3Vi9vYkKKPsppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5525

On Mon Jun 22, 2026 at 6:32 PM BST, Philipp Stanner wrote:
> We now have a safe wrapper for the foreign function synchronize_rcu().
>=20
> Use it in poll.rs.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/poll.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)


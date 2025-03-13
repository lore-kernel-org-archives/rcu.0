Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00A14900B;
	Thu, 13 Mar 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840213; cv=fail; b=Vmi8Dryl0JBT/7rUwVNe2XE/NI6i0UZW42xMAqICxzUsvTZFM/X3R9Gr3755uf/osSmR+bC1FgGAYUF2Cmq0htlqmY7mtS2I1qRdRsAdhHa0rkrvr7DE38c1YrjpmhLZ/UnNTacU8mD7CrM0bR4lRtDseUD4YSjbiA0sgH/doyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840213; c=relaxed/simple;
	bh=1GGUhsMhm670NXvHt+3QLj7BYysHoRZXU04KvaSK7z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=juzwUZQakbSOFFVpnFLncy8Goob5NfDk6b3sOIb7+BF5h5kh7iBTu4S+saxcivmJ2uJNSl1Z0vwyFE342fqAW32Zto6VMwTMusec2sQlIcUEb6iUgRhLhbYcQQ2eNULoEvcN9RlL0wajYZDpBpkBvqjoyH+PZMSU0t/XQpo+lCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYj2K3UJ; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYj2K3UJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGK9zklqxxisfPRuWL2E/orHZqO3qobmNxhEZZDVg/2djLcIg94eIWPrGRu3GEosKjABDeITLr8CMnCgtX+5SJjrrX3a6P+Uhf+Xj9ElNRAGvbDGzL+fMuQzYdE7jE/3Dy81QtGz/Fu+7zvYrs1wWns7Dx6exvgj4DVQi8Xk8OAk43NdaUKlaIisFqIsYMRqzsv587OmEoxPoeiV6jwavA2vCySuisXHJtnQY6uPBCOF6PVMcKdZ7/sRUZFZA46aRgjEa3BepHBreGnc2tVzJgMXKftdq43lUnP6WWWmQJTsF0VhwgniQSyfDus6RSrFVEsKtA0ScRP1lPliwictEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qjsZObmlUCnPEafKaA0f5WxGFQSE7bKcPIyxYFNSqg=;
 b=kjGPOAuu72KK87+FgQtS0mDe1ZWjXqzlSgvgZK9pkZEwdgmy0PhzvkgAaFOo5iRBa3i1TBArLW/x8+cFKBjZjDjb+JuUsU4GjmPJNmYpPj+uu1koZorGk2Q4HZAMH79qp0h1Cb6cHWX48m/ZpoBD00vmjG+0steYHTYRDRuUXZJqiatTiITg/PTa2/frgGwSwJ8dXva46e0aU//9FOgP/MM+BTyZj89IyqkSQH4xtoomDD77cbtXTcG4zAYwcuoUAyaTH/q8PE8ZfrTRHm77UxP3LqARKlvOCtlm8pcqR0iXeseyE3OoFeRIcuDNOZ/EM4MfUp/xMK0spkHRATsgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qjsZObmlUCnPEafKaA0f5WxGFQSE7bKcPIyxYFNSqg=;
 b=sYj2K3UJ3nHskjVtP0NoV+zaYg3rxWmlwDgfIDgYHWBcawO+9qEwOgDPtdDQHokt7NOlfbBOemqFNCqFpXS558+eTexh7VxmldSxJk6FDmhzIyR34OeOTiuMpI5rSYxmdzy/5ZdAzt+H6PxYiqLa6GPAkM3yOOsCBG+RvIRgBtWhH8zzHM8x42P8kpD4AnPPwOFH2zfme3IfOjj3ZYBbl2cOrnOwRaJWB6wzTLoXFYfZlkMXq9VhGLCoiD+1ye6fRrpCdxUJuBaKWto9UUDI9GX87dF1+WlLjoWYcCED4trGnIGw+A44DyKSyDZGO2EgvThZywbPJNnmH0Xa7IGpaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 04:30:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:30:08 +0000
Date: Thu, 13 Mar 2025 00:30:06 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: rostedt@goodmis.org, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] rust: sync: rcu: Mark Guard methods as inline
Message-ID: <20250313043006.GA1396688@joelnvbox>
References: <20250312101723.149135-1-richard120310@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312101723.149135-1-richard120310@gmail.com>
X-ClientProxiedBy: BN0PR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:408:e5::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d56d6cd-235d-4e29-0b32-08dd61e7bc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DN1NdX24hkdVSJhrWgdxtS/SgEppmaNM04V95LjQLpZoud997GHOeiarY1om?=
 =?us-ascii?Q?CIkTzU29dPI7WzJOa09Xkf+ww4GBQvDoLhIoju081eDnXYlzIqVTyD6tRZbd?=
 =?us-ascii?Q?oYTX1s0PT1ZvL2gePOquHr3nU8mBO7DeMnXxN1XRKduwBCLObE50r6DDARIV?=
 =?us-ascii?Q?K6f2d48u9H5Q9d6RvWWOS+7XX+rcTFASXE4YtOqdNsl3y9YBWnXQ73SG4xG0?=
 =?us-ascii?Q?f96bUJcHtWUs9XgEelGmh52LwyADG7f0EtIIQQXe/KoZjnBdXj6rNGUdHh5H?=
 =?us-ascii?Q?UUgHDh3SYQK5ftKILs1uj4XjTueHuymYKkA3i7oK172qo/z72eeEKptwDyhh?=
 =?us-ascii?Q?BtCg1QdIXLPpMEK+jS1K38RWrWPyW8+CX+n/dB3jE153UcyBx4l7v64jVor3?=
 =?us-ascii?Q?U7L7/1rIsOaYPVc0Hz6E/uV5BIHV1JOvLrss9GGr0MtwLahXh320xlWsfI/R?=
 =?us-ascii?Q?XmfU61vZ66m4e3qVa5oX53cMLuBzH33c1bAfm0L1QTpjpncs62C9yl/Hr9aa?=
 =?us-ascii?Q?pzRU/K3dDPJV/AnnLq0qNCHIApOuBoWS2qWcFbp5DoMSygMAuHSlCOkzeuDG?=
 =?us-ascii?Q?hNsyby9oPp5P2dAoO13Mjvuxt3X9x6H59MKzgGS8wsQVWqFztDHGteQ18/rX?=
 =?us-ascii?Q?DSsMlPYU5y6xgqxUKHoIGu/v9N0bbSCLmESqM6ISxu6wTAKiigYv7H6f2LwQ?=
 =?us-ascii?Q?Y9QH0xeGf4l94B2JiOWwgAMYRxbbnuitD09UW+eOTpAyP75DbBCNl0a7GFBD?=
 =?us-ascii?Q?cANJn2kmw4bc0zQ0CM6iWmMnwh7r4RTEokE5LZadyIddVqu4+41oVx5Q3ouU?=
 =?us-ascii?Q?Ca7BEBPNLLlNcUlx86ND1s+3lvTwyNhtPVfRbvAJm0jpp1+zP2VRnNZr8POo?=
 =?us-ascii?Q?TYcaRfK/wFxqGfKQf3IQpeo5YiDTbScuh2Fzc5pzIIFxbRuEa6eDc6mHDcm4?=
 =?us-ascii?Q?ElDLPqe1RXz7Dsefq6xSo0tLIYHFmzLlAeU9iMUfe4YcShGXUg+gGou9fJJ5?=
 =?us-ascii?Q?RNiD5ItxLDTvTeGz2gFGsFK6tmauHrBo3D6FmuCJQPazO+HVwSZAUT9VgJ4l?=
 =?us-ascii?Q?so3O+QnGzCnGTkSvyhvQcBN+lLmSQHCYkCRbDwMvS5pmhrO/Ub/k3GQ2dIoE?=
 =?us-ascii?Q?Ql6ylAmx5ywfJODEhq1h9hbgdmbIp5lp0lsB+ajHB33ZaBc3dXUpDRq2SC6f?=
 =?us-ascii?Q?c4QR+eFe2NLaKnmTgOGTosxWCQXAZ2buwZjzEMCODMwnE2n7nONUIP6eNuZr?=
 =?us-ascii?Q?iq0T5NOFVt/mKdMqBb1BJgl7Upv1jNlyvbfMlW4FVZGe7guaG/mLscZB4ZX+?=
 =?us-ascii?Q?WH8TyfAZH17mbFEt/E8d7pSssGWF202/QQXC6WTwtSBIJ2fktGqiIluoHYjW?=
 =?us-ascii?Q?pf+HnXN11ZdwDYRuHf+QyxIz7tMx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/rT3H4k4sKaQOdmenanMFAemvsS0eL2AcH7Y94nQHsCvJeBeuOSAQeJSSvU?=
 =?us-ascii?Q?0+RgGFcg4kzw5Qex2wgrjJnUaE79z8Ay8CvoaCHaCmmIjHCmImXBejKRhvng?=
 =?us-ascii?Q?x742ezunJj2Rs5P9AbKIl7eW9cJWZEjF+29hwxYZDGI4gES+rUBcILzj1TWU?=
 =?us-ascii?Q?b7UG0ZyWlmxRFqDOWqCjO6Vd++Avnp+EGy+WcoPPVJnerAS5pn0nQW1wM4Ou?=
 =?us-ascii?Q?QVyc+XUwmNz5OOIkcsSH4GsMlqr4T3k3fN9/J61q7m9ZmbMRUKLa8wK++VsF?=
 =?us-ascii?Q?066OaIyiLggEa4PO7/wpXsQeBqjXMtgXOZg/32gdl7oaracZZRwsbp26kCK3?=
 =?us-ascii?Q?Rywg1M8LSvnhXclsE8ynKmY90s4lTmIXC4Kk2IRXdoB3mEacPCRVfVbhnUN+?=
 =?us-ascii?Q?0Ma8aYDgj0g2OYlctRWH3RpSkq0zhBMX10Ce2UbPvmtbcEfFyUFddRufXBMM?=
 =?us-ascii?Q?32qQhhei07SGBhgZulT69lqRW+28Oyp5yynAp2w/BbCUfckO4DMxZ5k/SpWz?=
 =?us-ascii?Q?GcIGmf0PlKbf55DbE/MKy95MiTZjt8M/N6BK6hmXMfb8X6fxiQxMtWf9ATLh?=
 =?us-ascii?Q?L43pk6Hd7ZtE580x9KZuMReEpyx0NcTC0nCFbubCh1f/RmHb84l78EOdyhMw?=
 =?us-ascii?Q?/83Ao5LEPDAlFGxM216rbh3OVqqHpYgGTup2nzkmuMpoWEbV5MPXeA2QOF1o?=
 =?us-ascii?Q?YjIgOuyxzfk7FoW4Xv/YsmWSWPB7HrfL91Euf91+7Is+SLpjcMJAhR1CooyF?=
 =?us-ascii?Q?yTNQLZBUjal1k+Yzne6C3TOO8LWbvSgcsjH2BZEVzG+yFJ6EmkcsSCjshovr?=
 =?us-ascii?Q?DE39Z8S4Nr0Jlfq/bQf7CDlKlsWZoyaN0feJJPWuBoUO5LG9lvzFktDwqETk?=
 =?us-ascii?Q?BkX6geOFurL4uNcADFX6Qys4OGrn7LlYl+pMmv0kNmFK443AESKFbLv28EfS?=
 =?us-ascii?Q?DkfdVX3Swz4Bg1MJTIWYc/IDgggy0o3WMPcCGlgI35SrnuYg1M4ZiKg3g3a1?=
 =?us-ascii?Q?vo4x+WjW6+V148ggIYB6AHl9EGKm9D0Ir7wZDclbMgaE8eEGPwa1z/hJbfTC?=
 =?us-ascii?Q?WdVyuo9doO4gyGTIanBt3eG8r8Uu69fMShg1qAR3/nl57LmwMOq1YzBGISJU?=
 =?us-ascii?Q?SkonZ40Iczr8iCxv9P+JBftpff885hoKnt8qwiR/ve69NZkxUFkUEZ4+o3Ab?=
 =?us-ascii?Q?I/irDjPiaTYGYpjv6tZmGsJCE6D5pAGCIFYvwgywT8XtZzGOGWoqp/Dqbbrv?=
 =?us-ascii?Q?zzYFGRIVYHaQG+Tb93dyvCPnUpYNkofJjkPBezqBVOVTPNmUgfNVVgX4B66p?=
 =?us-ascii?Q?kHY4ARPjMhcuPff/2+9+Y8o1ndeRr499EIUZXET1VZPLPLgtozfXJmaOAuu4?=
 =?us-ascii?Q?NRzC69Aw6C8VNrAkZVm6qSXShfGHOwbvNvlqSi4cYwcsqQARoBSKynCJWDUc?=
 =?us-ascii?Q?BDZ3IJmmMlODDssOSqQ9MtuSYR2WKYvg9kw1wF063GHvMm8qjKiJ3P8x4Mmd?=
 =?us-ascii?Q?0t0ailuBWGF0LKb6c/rObcvsmztXBZ1Pi89wYaSAhAJLIPSblwiiRvR/giZY?=
 =?us-ascii?Q?AthtAEWQgE2PUfSQNT9+2ZBojR0MP8TGC3zlPVz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d56d6cd-235d-4e29-0b32-08dd61e7bc91
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 04:30:08.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GClvtP5JWLNrYpcSgB58Dnv5Fmy652hWt4xFB5Sd5FA+YNQ2JgEFVtxTmrxu5L1UJeUf4qfthOMA1fHkPzN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

On Wed, Mar 12, 2025 at 06:17:23PM +0800, I Hsin Cheng wrote:
> Currenyly the implementation of "Guard" methods are basically wrappers
> around rcu's function within kernel. Building the kernel with llvm
> 18.1.8 on x86_64 machine will generate the following symbols:
> 
> $ nm vmlinux | grep ' _R'.*Guard | rustfilt
> ffffffff817b6c90 T <kernel::sync::rcu::Guard>::new
> ffffffff817b6cb0 T <kernel::sync::rcu::Guard>::unlock
> ffffffff817b6cd0 T <kernel::sync::rcu::Guard as core::ops::drop::Drop>::drop
> ffffffff817b6c90 T <kernel::sync::rcu::Guard as core::default::Default>::default
> 
> These Rust symbols are basically wrappers around functions
> "rcu_read_lock" and "rcu_read_unlock". Marking them as inline can
> reduce the generation of these symbols, and saves the size of code
> generation for 100 bytes.
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/8 grow/shrink: 0/0 up/down: 0/-100 (-100)
> Function                                     old     new   delta
> _RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default       9       -      -9
> _RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop       9       -      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock       9       -      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new       9       -      -9
> __pfx__RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default      16       -     -16
> __pfx__RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop      16       -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock      16       -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new      16       -     -16
> Total: Before=23385830, After=23385730, chg -0.00%
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  rust/kernel/sync/rcu.rs | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index b51d9150ffe2..26df2a6cb09f 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -17,6 +17,7 @@
>  
>  impl Guard {
>      /// Acquires the RCU read side lock and returns a guard.
> +    #[inline]
>      pub fn new() -> Self {
>          // SAFETY: An FFI call with no additional requirements.
>          unsafe { bindings::rcu_read_lock() };
> @@ -25,16 +26,19 @@ pub fn new() -> Self {
>      }
>  
>      /// Explicitly releases the RCU read side lock.
> +    #[inline]
>      pub fn unlock(self) {}
>  }
>  
>  impl Default for Guard {
> +    #[inline]
>      fn default() -> Self {
>          Self::new()
>      }
>  }
>  
>  impl Drop for Guard {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
>          unsafe { bindings::rcu_read_unlock() };

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

If no objections, I can queue it for 6.16 but let me know if Rust maintainers
prefer to take it.

thanks,

 - Joel


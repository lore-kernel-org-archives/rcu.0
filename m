Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2902153ED;
	Fri, 18 Apr 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992964; cv=fail; b=pl25frSzIHJxOoA4n2TirudzuaqoCNqdkrm9K0q2alom2bm94bmONy3MTRcmlhaKpfQ8Qejp0Z6Y3JivYgHZ2wVOI7dGmWBMYzwUWZwdwKEvrLkupROFxfvaJqrtF38yXrxnpLQvGVkxMMIDD7QpEs5GzPXjFDSD/fema/72S4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992964; c=relaxed/simple;
	bh=RCfdJZQ75bnrJNXrnKqOx2QB7qoasYlPFpjKNx5Q0KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HC4C/Gp2alXr03ibcbgzVN+LstFa9R2c3e4yDgFzx7USvFM3yDQCKbhbo3VYq3BBJtH1tuDbvUqOm9ojNdQbW4XcfjuP9xli1EIih8N4z5HRfawqFZEMn6WuI8c2UbtPcvE9Vy1IbBmphOdegqOFoiBei5cgwZAposi8HIMeGrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=laj6EBZH; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="laj6EBZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3VeM91tTz8Z0G38EQRrVwl4TMCznaUbCOeV4+rc+23cV6FfZs2gtGgPr0mYhN64c8cX6tYT871LP+rWb8qFmuCLI/LX8x5anANaAuzDVBy8JEqTGa8vxckOv78sM/5C/pa7eFlquaszBNI0Xe9VFGzRY40mpdsOTBmwroZ+UpKiJl6UYbjxzNFXjh7v7UAMBUhhasYYvrGnjsAkS7NAw/qaiP83CRWuyhS2ltZZKLcDBF+Kykb+AtqDJLKoEkp4w8BZ4T4nqR+cmwsG2CRJItgEPGUQS/VKzQOqKLAHgjBZhV+AlOXNegz3Vm2Pq9HMLe2mPlEalmFGHaGeSn6YrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWrVm5wwxoUa7O/NQ9vHH3d8io7nbGvKuxzmGz8aaJo=;
 b=WgxT2dLB+jW1XGLNqs57wbfTf6hN5ZzhugMEOMId0MbjAMmPf7zAUi384pnSeZGzTrbSAv+y2owfnJ8/ov6ps1TIp1+KcR1FWeE1vOnwJb6mYd9VMojWP83a/+BgkUeW5GfLR+sD94HAdkRuscp6uxjgCywCr821L7vUV7I6tfiFcOokmvhRJ1sYZ44HaXTX2fOBECdPXaO4LAyDKLSlAuqHX6CzETtSSIEqlDrT0hSSkpcCrVe9MQ+vJwfHUKiuyf3NUrxA9vhI0ESSUU/pfsqVmlTwxn9EsAvZ6Yo/51GFumnCTYijixl6JtbwELxu7wBIfYF2HkZzqc27Yv3chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWrVm5wwxoUa7O/NQ9vHH3d8io7nbGvKuxzmGz8aaJo=;
 b=laj6EBZH18M+GuXTuM92uRjSGlEGgCa8ZghRbQxEvLFEgxrac5ilLTjoaZCTgwvW4jILfbjVKCcFEAr5LjRqlkilZZ9FRT4nu0BTI5mj4IiZ8l+dubHeJPVvbqdYHYvW9tKWptXbsdNZbWmTYHwLaXhEruvE7CYrhtYFIeX8hdq30F0xgPFfgT02V8DW/esY/eTmCVcuPl76PQU2eP13TNAJiaZeE/RxPDpXabEIdArB8fa4FKnieRznww21I/mSx4QnKrdQXgiQHFgsyAFeHmrEeSc0EaFNEtuO5yn5nVZaxsH0vYcafSvzpH+tWWJxjIXYnzeHwaNNpQM8bG0FxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:15:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:15:58 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: rcu@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 4/7] rust: sync: rcu: Mark Guard methods as inline
Date: Fri, 18 Apr 2025 12:15:37 -0400
Message-ID: <20250418161542.2429420-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 343dcc5d-c17b-4cfd-1330-08dd7e944e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+avmD13voBZhmDpcGn4zHZMUB/CPHjjIv1n58joArZtfqjZkoknucQGicdg?=
 =?us-ascii?Q?XgPcTJ6k2cw6hBCHhy/IB4/lrgqbSLYGhZkuIaVEkytLqp0QQZ2TKFdpmazb?=
 =?us-ascii?Q?qTE6GIHNjrSNlI/lFufRy8raQArkTrs8mAqQto598ovnM02Gcr2vTHAS6PpT?=
 =?us-ascii?Q?kn7q7J21NpIGmI8MEWup6R3XhmVI6QXPKEWqr8m5oNXe7vyfzxUvPSreFi+s?=
 =?us-ascii?Q?EKGqghx4QBYjauz/w+8RVXa3OwHgMLJC3/pEmnzzrCJB79WeniQZxWTSVJx4?=
 =?us-ascii?Q?kEXQmE1a+1AhxiuprGukRuSKnka81LEC8UKHZCICnlAYsTDyTJaxzilDdjCR?=
 =?us-ascii?Q?JeV2AQg+VrLTq0amzQ/Lu8O6UJheIb3sR8YtIVDnGuZUoLRbF/XaupOZkAoC?=
 =?us-ascii?Q?mJBB4rOHMyI18Nl64Irvi0ad73BvcdE4cOk2ubbkKyS0gNryqojHsH8e+93H?=
 =?us-ascii?Q?1Wk1/molr/+kEs8aIYCR04wvhRTYpxpETuMZ7BWPAkzCEEWl0Apqn9RgYPEz?=
 =?us-ascii?Q?QZbKmEtaV2n37zFsCtG9cF8tUVaBGkWxDCaJMJaIkVPLoMJTmnyBUPwmfLV6?=
 =?us-ascii?Q?oOw46atHe1b95YSzXT/1pH4kr5Etvta5N2uCOKE9f7pAOr3K27whRrSP2uh4?=
 =?us-ascii?Q?LUnrpiBEOT88CBTnPwiGqRoIT7XvaFbEG+EF3Zf9ofCynnL0voy4BXIv6YSU?=
 =?us-ascii?Q?olYzFLKbYuenoPoLBaeUmSpUzRirM47OTX999NevRKtTdSvZmfbY9bpaAXiy?=
 =?us-ascii?Q?+WMfUj78u8B/qG/1qrH1aMCIfCBPgysbxgDbmYdJKQAQsx7dvtWUJqyDd+vU?=
 =?us-ascii?Q?GQfrSPjnUvgFmbXftmVhAwuUf9kFWBYa4kJcBFPnGVaVlf/8kZ6eiKeOt0B1?=
 =?us-ascii?Q?vFyIAHmXycvBrnhQo3Ojc1GnBVRngdgaVzeVFoNB4hvCpQ6N14bx6Y1Y96t4?=
 =?us-ascii?Q?jFAx2xLqHAPM4x7uo1Eb1uu0dsmd5Wg0fOKY/AutGi4p3CXGVXCFgk615le4?=
 =?us-ascii?Q?+lHQ177cGQCBSTVMGeG44vD683gB+z1UKDKb6yIe3UlwTBKTv0IgR7dEv6Zh?=
 =?us-ascii?Q?nnqOBt3NtfsgEMQURGwgUFkGJtFoYqZgk6UTBsCUYTAfXkDe1P4si6QSKYGo?=
 =?us-ascii?Q?+eeuLrceu8kCQlzcN/FrBTGH0zMRXFnoae4/RhMmF+qq7H1AptMf6/vNmmXm?=
 =?us-ascii?Q?POGndJfn535AZkqDAWzOZsg3Sq7vY5bF1itOgvOxkXCXz/q6H0wJBv/Niu9z?=
 =?us-ascii?Q?uPuNpdea9H5V/Q8zUBQOzpqDGCc6/PQx+K3U6NGVIz+MuRw9UEnnETS3tzNL?=
 =?us-ascii?Q?dHZH7lZeSKy3uGZCTsT8A2B2EKOgenAczhcVtiiElBhNWJTYB6dVmSTTzYRO?=
 =?us-ascii?Q?xddEjL1SOjo3601REYzxHj3i8ko9q0KEUAjzIFHSmctgtKF17gklak/n1x8E?=
 =?us-ascii?Q?B+gcaaPkAwGGBP92kWbBzLd6ZNqz07HQji+A3ESCoepA+oZxepA/yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6TmmlfwV4J/H5h6EdVTeBoK/r93192XoJ7YVC+o3195VHQUH/t0j2oEapOu?=
 =?us-ascii?Q?DwHMKdLZcnhkvMQ3TUkhIw2/1xa6k2vQfPFOBMsyCarG+ID9zge78X+2DiHY?=
 =?us-ascii?Q?l+QKhfTezBS/vMC6ewk0Z1x+G6Gan9Q1z54Kn3ivO4lCdHv40xSpFZDX1Awm?=
 =?us-ascii?Q?+3ENjDZ6UcL73OUQj5q0PVpzXhqC03PEO0jcfrH90Tk99AL90A3kyzAR9mX2?=
 =?us-ascii?Q?0PMwoxsp5b2n2gG0yolErmFv1E0qnuClIwcqEuv+Se7c+GpjLR+kpmpgGckb?=
 =?us-ascii?Q?thQhMAfbnptzz0vHv0YxEuV7TWTC0Z8JxT7bdq2dLo/xKLxSSOfR/Sdishwd?=
 =?us-ascii?Q?zlyEGFPAYN1NNnacS8u7Bh0wzp1cEs0oJr+QYe8AHqIcBNbsu+qMbNxPSpe/?=
 =?us-ascii?Q?qm8wZKPK/1SGSaULvbbM7mSX2HTAC9YVHZGtGxkuMS0lHDJxAiNbPv5tCLLz?=
 =?us-ascii?Q?GBJgzzBGqScbVCJ64F5bcjqhy5aiRnTRYVoHqX3R3yh/hSsSFOvQKnBpu0LO?=
 =?us-ascii?Q?8p0sELXGaqbv0UMpXdUCdLiWH/NjZpbdvMlq8oAz926J1P5OAmIUz4/xsfey?=
 =?us-ascii?Q?ipS+naOARGuE6GU6rk6YWHWFs+LlekT3C9qHMF3axJZ5SizFY6SpVzsa1hQH?=
 =?us-ascii?Q?nAzSb+YV62Xr3kGUskTZP/GvsN9m91v76cyiwEP8H3p9fBliUHrx7WgaMuG3?=
 =?us-ascii?Q?+kTubp0M2lFVvKqbKy5ViRZOgMWBB9Znb3bWE/wBwksK6OXENO4LqqAwX4Kb?=
 =?us-ascii?Q?JMhC1CVeelPbIaXFDZIFoRaenHcZx01qfxu4p2WQhFPri2Pn/JnsXk6is+hJ?=
 =?us-ascii?Q?NgAgLB7H1x4wNX8gHaEX+ui01SygZL09Jxo+ZqSxQSYWmMpO5sSAxbziXSDC?=
 =?us-ascii?Q?6t5pAmkaoL2dnpl94Qair8qQ0wITREIy43QWsJvbd4hrSoKmEskHH7qSRMR6?=
 =?us-ascii?Q?/VUQ7itqkjMMR9Jmx24e6tpEvolEUMi0P/+s9WXI/1n2KJ3YJpgWQmH/JoV9?=
 =?us-ascii?Q?6OKc6dQquRXqJqEr/Ff4w7dv00l3w4CNfDZsKHjt0bqNrBmFHNhFgDOV5ELv?=
 =?us-ascii?Q?CeheCJjnB73RrvBMT/YTlfl8oH/zFajeNlrmVJIIBRhk5Ta37jt0WrbHeX00?=
 =?us-ascii?Q?K++k2cOpFWX3IZ/JAZWZSc/ZieN9DbUExZybwAx2KR+EEnNkFHH/kxTOwTvf?=
 =?us-ascii?Q?jZYGUMrfMl0HLOqWKm75QWkXd+lIQ5ow2exUUS0fKj5q4YUyripOhLcowRDi?=
 =?us-ascii?Q?yeHnTgvfhxlWlGu8kuhoOFFUVmhVjE2E88Er6qWLYmXixwnaARu1ZMNDHahQ?=
 =?us-ascii?Q?ZCx5T8hOhbaoaTJceKTFuDvyFwd/fkSCP/0NGjiRxVGLMO27WXG/TbdfW7in?=
 =?us-ascii?Q?c2d89SNFIlWM/IItggBncWxRAsSjAmMgj3jFmBveN6AYEOSnaJPsb0i3NR7D?=
 =?us-ascii?Q?j0HwAL++Bf8BVOvas380W+wheoIrL94RXrI6+8ftT5vQwf9bZHSaBaQ86/5P?=
 =?us-ascii?Q?d9b9MAAYUFvhVoOS4qSY4eyux3Htt7rz07H/lE5hZoWUydrK00MM+IYVa58g?=
 =?us-ascii?Q?UbjUZ/QUZe5jO8lVSJ9IV13lK8rL8BnTVUUh3T64?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343dcc5d-c17b-4cfd-1330-08dd7e944e0a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:15:58.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ChoqA83a771WgmJgRALWcvxcrXYKZ3dwgGkgjmYI6PinZlTRHSbCmIHYerQOlJxr4oMx7YS3H6xTlX+v09NIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: I Hsin Cheng <richard120310@gmail.com>

Currently the implementation of "Guard" methods are basically wrappers
around rcu's function within kernel. Building the kernel with llvm
18.1.8 on x86_64 machine will generate the following symbols:

$ nm vmlinux | grep ' _R'.*Guard | rustfilt
ffffffff817b6c90 T <kernel::sync::rcu::Guard>::new
ffffffff817b6cb0 T <kernel::sync::rcu::Guard>::unlock
ffffffff817b6cd0 T <kernel::sync::rcu::Guard as core::ops::drop::Drop>::drop
ffffffff817b6c90 T <kernel::sync::rcu::Guard as core::default::Default>::default

These Rust symbols are basically wrappers around functions
"rcu_read_lock" and "rcu_read_unlock". Marking them as inline can
reduce the generation of these symbols, and saves the size of code
generation for 132 bytes.

$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
(Output is demangled for readability)

add/remove: 0/10 grow/shrink: 0/1 up/down: 0/-132 (-132)
Function                                     old     new   delta
rust_driver_pci::SampleDriver::probe        1041    1034      -7
kernel::sync::rcu::Guard::default             9       -      -9
kernel::sync::rcu::Guard::drop                9       -      -9
kernel::sync::rcu::read_lock                  9       -      -9
kernel::sync::rcu::Guard::unlock              9       -      -9
kernel::sync::rcu::Guard::new                 9       -      -9
__pfx__kernel::sync::rcu::Guard::default     16       -     -16
__pfx__kernel::sync::rcu::Guard::drop        16       -     -16
__pfx__kernel::sync::rcu::read_lock          16       -     -16
__pfx__kernel::sync::rcu::Guard::unlock      16       -     -16
__pfx__kernel::sync::rcu::Guard::new         16       -     -16
Total: Before=23365955, After=23365823, chg -0.00%

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/kernel/sync/rcu.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index b51d9150ffe2..a32bef6e490b 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -17,6 +17,7 @@
 
 impl Guard {
     /// Acquires the RCU read side lock and returns a guard.
+    #[inline]
     pub fn new() -> Self {
         // SAFETY: An FFI call with no additional requirements.
         unsafe { bindings::rcu_read_lock() };
@@ -25,16 +26,19 @@ pub fn new() -> Self {
     }
 
     /// Explicitly releases the RCU read side lock.
+    #[inline]
     pub fn unlock(self) {}
 }
 
 impl Default for Guard {
+    #[inline]
     fn default() -> Self {
         Self::new()
     }
 }
 
 impl Drop for Guard {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
         unsafe { bindings::rcu_read_unlock() };
@@ -42,6 +46,7 @@ fn drop(&mut self) {
 }
 
 /// Acquires the RCU read side lock.
+#[inline]
 pub fn read_lock() -> Guard {
     Guard::new()
 }
-- 
2.43.0


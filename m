Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561128E7;
	Fri, 21 Mar 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589663; cv=fail; b=tdx35zjn+naoIJrWVi9zFhHo8doZOlLmSD1yXCcp8uWS/X8w/KpaAFzbnNJEz1UH6YZrBzceyheB5n/2/5LfjiDwegBcrK1UUrwQPxI0BrELZ9zwp9u0Z/1bxcwh170CzZKCoLklmYwDZfmsCHiNHesJ/oyxnls0BCd2nLvDs6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589663; c=relaxed/simple;
	bh=OTuFn4ui7owcMk3jh+3O/6M+A6RTGDsWqVTuzuBeBpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZWC4cymidldqkwZRDDtY31AvSuih6Hswd8PkM/CFf0pDVUvP4BKU+eKQpwgtaBDqxdVVML1Zfa2wpwNfys5GbKCfgEz1xnLs2ir/qQD1A/gHp4sftUQrNK8AMh1kLgFOySbPXG4j8Pf4/SgKmniXhwN5MRsyQWfLCYJJkys1tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ac4//di8; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ac4//di8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izN/DDS1UIfEDmfDle0knxnjmTWtJYEvj106hlC0sO8BxTZR4y54r/9NoukIyEq2Qc6XZnL+5IPYaWjQwdAaCRVcCrUbFxiOuArhy/CnxEIR1Uw3S7pjH5OY14NIuhVJvCMvmJJs3MUDzhQuEkzcIUHJfsoeXnyj/N5SnS2CXOvyZCvzrxYsfvonBUNRLEpetizn71LG1NLFEwFALL9hEHQ453ZQPcb8tljefwrFLINPlWPO46P0KXPPyc2VX0Q3PDRHzO/htiL3W9KlhKSzpFFK0ivax5Q+GD4GpO8InBrwjDk0Gw79dbCwAtiytNGxz5oHWr6Y5EWffyifBJS71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+JfdrWOuR5ddOq/xammMFp9M5K+hLGssvd0jISsI50=;
 b=ZEQCvp2U3A7wu8/c/wL7zcyVjpT6J9A+e97idnoMFwWAfSJlqi6BjsZQdV/7cHLxwZhqxbEwwdUMXxxZeesSXqkpYWpMs/SEdVtA8lEIxDI5790pCfvvcJAAI3ENrtqWEsYD0eZ6fNimEQ61ZZRA9vnsNrxuqCU2rEx3l6yb4V9wJXXeVT3kv8qy1y5sjeGFe+UXyqNMzNR5G8UmX0D5TnKroWzjoWwrfer8xc/as3kFR1s/iPN8Aik3UyOcuvFy8VP1dvIPx60XHu3r13xE2LO9VeYQHENcxwwMkseWYS+5eWgkz/hs9WWgIobtL3cDAt8IQa4gKnD/krgHF+Z7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+JfdrWOuR5ddOq/xammMFp9M5K+hLGssvd0jISsI50=;
 b=Ac4//di8G3HlykyYUhbpLokPk1Z13jv7Njqde8RotmNm8PfaZqlR2j08qXyPkHML1mYCBZpzFIW5DVjt3+/K7z3cdcwvX0sZ6YtMAAnXi+53fiomLzfvAmoTelrlD/9WVo9PaWUp4U0j5FEADEF9wEDY2V8KpRdfJ4yyWwT7ZkDMatNqs+YzxSj+z5LKPQcJOKz17MOfehm3Jbmp6lfO1OGFmMc/DE5ZdLatuoOaEg9nUjVyF5aG9Amhz+HXWxouNbegxu5AA9mbQjVyE/gLavxNS0CKUysud5YoFl6ooc80VIhUUugKzKR8zv4oyGXay7PvhLfP3AYkM3YhxXYY9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 20:40:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 20:40:58 +0000
Date: Fri, 21 Mar 2025 16:40:56 -0400
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
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2] rust: sync: rcu: Mark Guard methods as inline
Message-ID: <20250321204056.GA121221@joelnvbox>
References: <20250319022640.970207-1-richard120310@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319022640.970207-1-richard120310@gmail.com>
X-ClientProxiedBy: BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 548e9f00-0d30-4322-f7c2-08dd68b8af4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQL8RAmPkE4u6SjB+kaq10Q6fnE0t1NPbKPUE5IAR9OPACnVUAU/eNJ8wv6s?=
 =?us-ascii?Q?6pnVt9MaBRrUm1+sG78Xqi1zqJ8E0eeaZM4wtjRn7mqHElA1f7rXVEJhX9bR?=
 =?us-ascii?Q?0hQvn8SjUlWjrIGJmbtfpd3/7kDh7CMZd7WpVD7h4oeYO8gyIEhkvgLZ6nfl?=
 =?us-ascii?Q?9oJhxfLWMFJqiftcyDimzSnqjuXLpKEOVJUSP7pKVb922mXt5qTJfrl4U4+t?=
 =?us-ascii?Q?D04VEW6zGGG2eFC/fAvk3AGSjhOwMcYeBCse5SPioDAZCa3iKbseAa4IXEyg?=
 =?us-ascii?Q?kDfKNrDiHIr2KLbb6C4NIm2leyKgzLh/vqUC7M2SrAbit2Fu+XImR74BI6y1?=
 =?us-ascii?Q?urX8FzG57xGtB/EgABJLo2FYcgS9dhqcC0O5pWkYv7kfmEJz9dOprHvqLI8R?=
 =?us-ascii?Q?XrrmQ4B6hXvQbLOVGLFRTwKxDHYWQg/WUXRvP1D4/p1pSlvpRU6hYCzPycSf?=
 =?us-ascii?Q?eBhsw8LIpNo0w3GANR6zrlL+RdTIJlrgl2EJzb5ei5hrQjxx5YSrfr1UBWUX?=
 =?us-ascii?Q?qgc6QkBPnMF+73C0Q0Pmd2luGNULMzBN+auAIw1V4EWlE4qXL9oVc+FIe4IX?=
 =?us-ascii?Q?GnKWZHL/GTuOImq7ISzN41XbBHNcU6TrJ4TH2hKO/qHtW3ivVIfjMwRoy4VQ?=
 =?us-ascii?Q?UDh5sy0Er/3frjiKUzz/HxM/ydNQqh/epVpE02qIG5JEqFxfBhW91Dm1jUIK?=
 =?us-ascii?Q?9ngV4qyr8FulaAAI1t+I+IDJDyP1239UBc9ixQoHeMtGSNpTtzoggnC0w1ux?=
 =?us-ascii?Q?+kBhYXUfz5j/9evNFZXQ3cozOfJTVIJ1VnIx0dJ322CM4pfd84cQgbI7hOtX?=
 =?us-ascii?Q?WKpQ7wViIEyJlc6lBwIuYMT6paW5V0DSD5R785GAH6FTCoycfesRS2omN9lY?=
 =?us-ascii?Q?qVO8Q8qVNILCN69LuE7rTb3hsi4Yxg3ZzegZCSLyOCqYVoSirnsKUVgHDcEQ?=
 =?us-ascii?Q?i+b84KVtBa0w614OCp+8HhnK3IDLgGb5TmFqIxInK0NyRjNJ7IItcQ4hWS+P?=
 =?us-ascii?Q?+hUIC7futy7ugjIE8atODGP5X5sDXD5JGg0KdqJXRVz9sYDY60B/XX/Ibee2?=
 =?us-ascii?Q?7rxOg6h95R+I6Bqq6I+UHT3NLugZcDV3vVIuhLudeNyukK8xGcxwYEc5uf5U?=
 =?us-ascii?Q?7YofWgnWXmDcnB4Ga7BUIiC1x8WVyIBDFaBtZjxUfQiwyd3IG4gg0THKZ36B?=
 =?us-ascii?Q?wLzJv5W8PoQiWWNdAPqnbaaBuuazHjx7QujlZ/RSHFVuJZV0GMIE6OwbUPmt?=
 =?us-ascii?Q?GeNAIIGQYCtsd9bmRIPqNjY1GnI7QD7QhABOa96Vj6pEWZIk1aanKRo97XZy?=
 =?us-ascii?Q?qDBY0VFVNL2dFeytEjxAo6jmbYebujsTYHh3595s8ieThlwOwdwCQDF61ZaY?=
 =?us-ascii?Q?AUc05DjEXnWRDdkQqXs09u+pCZDQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKouiTFv92aNJphPTPL2N5JGYAugjgozr8MndQkgRa+5JyA1vP9FjOgHsJMn?=
 =?us-ascii?Q?ea2FU7PbwhPAv2kgxQD9Rw00EE27X55gorDmugnSPLvfsuAmjXnNTJnL+FR8?=
 =?us-ascii?Q?sWE6zxgtmgN4rTEiaP83IzPNSIqjw1Xu9hbwQmHtDttFF6a3I51jpypnXQaH?=
 =?us-ascii?Q?0YqyFXkaLZvUR+0/M8fLyOxklgjwy6Q0ccvsMxxYnzpLqCO3NbkPOglPAYnV?=
 =?us-ascii?Q?/a/tlXPOjbEtB0ngUvNi0XOICsIyymGjp/JHZ4YaZfdpQRXtKHLxNU/Oj1u2?=
 =?us-ascii?Q?ipF8R5PLSwsSQtpuo6do6PBlf9M1Gf9epTppeghM3+P7sdNiblG+sx+VFaY2?=
 =?us-ascii?Q?VdwUmusRSBOwVAPn0yYpiXPSGM9GchfU6P03Z4oxdSH8FQRQq2DyBPDNCLAY?=
 =?us-ascii?Q?EZYyxEn6Sc+LS16+zZZvXS2N0l+MLqruAY8iQ8/AoFAh+2/eH022EQHM0Ud+?=
 =?us-ascii?Q?mUsBXE09j3i1CXaD0rlK54EiBUZ7l8DzqYzw6+E+4gQL+NzmfHEvn12fjnVv?=
 =?us-ascii?Q?aUlLul0m+DcacB9Un+dpPq+TYumItcaSaz2wVtvrj9a/QyM/2D6UaQhrfDxr?=
 =?us-ascii?Q?m5UHielK74kVQvqsAJWfQ8566pZEPolmO/dcJXDaYuv6z0FRDeEiWxW2PsOU?=
 =?us-ascii?Q?0hWnbN9RS+LRuRUDfyvXFifATjF9po7x2DExm0fxxWF+GN+Ebkt78e/k/iWa?=
 =?us-ascii?Q?21QTQcRKqQTuPxZTyX+v7hkLPwUEeIsDLuQVRyyOR8onl4SlizrmJ/PPVhxx?=
 =?us-ascii?Q?qBFgywIp4j7QrWvZf8c/EtwiQipfeB/z5kD0fA9slF+B2fkx8x5DUPWUsT3I?=
 =?us-ascii?Q?sJDUYaE3KjsC3maGiN5Q9cGu4D2mdKG6iQQD+GRdyIhldRYoAZiEVI1ScaKx?=
 =?us-ascii?Q?K3DBa0ERlp6BVTWewU107jp3SPW2kqwq3Friq53AuI4ZJvs8nDXCThkztSrb?=
 =?us-ascii?Q?VUtmS6h+Mt78AwYKjh8tnHGTP1lyrypbflW4zLvH+wZMqqaYWAXYXn+VCVUZ?=
 =?us-ascii?Q?L0yUSRiRk9u6SzvsSXwVKSgd1uXUnoEKDxkl6OrmROL5ee/dVmJ++AETZcLr?=
 =?us-ascii?Q?lY0HuZR1umdLl7PqM1oRUM3AorskrZRHxQRL7C7+x2m90+z9C6CYhrRCm1uH?=
 =?us-ascii?Q?SHeBxVdtFK6F7L2SOxpqWBX/JNeOZ8vM8wbIU5W5mHvKtraNKxgdWrNZgNDV?=
 =?us-ascii?Q?1MK6qdl0SsDry176Bzp3UmcuW7seCSMJqqZDZ+9yg6BfCy9cWCkLpnYC15bh?=
 =?us-ascii?Q?cPiOTAoty44cWKo0JwnWujKz5pVWw4wwywKnn8+bfe3xP0UOf/zM6JRDGirG?=
 =?us-ascii?Q?mp7Oe3FjKJREHjWZlMImHI++u9k1mkqltSRxZTJmm/AWFIFpf/1kZ567kr1F?=
 =?us-ascii?Q?4NpWWESWqaTqnv3lV2eWWA6Lzp1MoWWkpC+FRra8ImIYP4YOJVZN/2bcgMcA?=
 =?us-ascii?Q?1WiMRp1Ycbcfow5mTuqNbTFtMVfY8R3jg8pFkvpe7XCTMwstxJnH1V2gdOlQ?=
 =?us-ascii?Q?RYP42moqZAKGJoyEBqTbvkvVCvFrNPqVmMazG8sqFFy8WzHqhW0WKjfzxC1c?=
 =?us-ascii?Q?CAf0+EHxLtS/kxcGhJ7cgqP4Qciu0SpyxMwxjWIY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548e9f00-0d30-4322-f7c2-08dd68b8af4e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 20:40:58.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1U1CVauWLHrCwyeqDP9QqCZ0yApusaGJBilwI6xXj94Qe6yUol2Wjp0BKGW2QZ5R03RTbsd93VQKdsZxnhxNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

On Wed, Mar 19, 2025 at 10:26:40AM +0800, I Hsin Cheng wrote:
> Currently the implementation of "Guard" methods are basically wrappers
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
> generation for 132 bytes.
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new

[..]
I am queuing this version for 6.16, please in the future add all reviewed-by
and acked-by tags on resubmissions. This time I added it.

Also I fixed up the demanging to make the change log look less ugly, let me
know if it doesn't look Ok.

------------8<-------------

From: I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH v2] rust: sync: rcu: Mark Guard methods as inline

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


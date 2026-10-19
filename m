Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DC10F1;
	Mon, 19 Oct 2026 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368164; cv=fail; b=t7iI1ZeZX5VNMzoCnvU9PwcoI3MUDBckU1kD1/EVF+fgJK/ndCjCYv5dR/cPGGbPQQik6kjVBRutJVfKb8tfcGZd7XEvKiq2NuFc1+sL+9vNJOP0vYbGg+V8pNVaYp7ReuMPcBxGJpymDmAPYKWz9y5TujPZK2w7uSm3UYDkqQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368164; c=relaxed/simple;
	bh=VtFd/bEvjBGJAaZVuQtCzRoF/K0fjAYY11cProOtHNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wl5nNr1cQjl/X0559R1l3oB12j2EOg8XDtPzHSkXsC45lT1VjJKCUDNI58XR4Ej5mG1RPFFK9uDOkD5THUpDiq4vZmAM3wOWWqVKVEkxu7rBmJAanKyl7pq1nBBUqJ9rnJy2XjCmzzN9WjHNTgP6EbKOLs8vy0uTN09Buv6tNNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4rtng37; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4rtng37"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOO3XSStogNNrkWY/3tvanJf+PVjvOaLOpWAqKPlIx+2rBIxk6VFr+8kDS2lIYRZtY8BUgyonP4hchFeI949d1B2S5Xzg2PfTnPeUvh4SumRkXia0aAdYH1/yGCCpTRmULku3nwJhFcZhJwI7FP5hCTfpA9mYs9E52x2gy5+nzOXQRVRn0gdOwEJKA/JnM2+wsYysFQsmYTDrh21JeHxepG+aHtkwDgvRz5hCDJ5OJECBg58GMtpyw/puQ+jd1zZGlHKoKDGcPkCBXd8KUq4DPwYCdoaE2YDU9h90F0drjyboJdfyro8aUshDBmeYaIJxb+zC2Hb5+QqsoY5yXC0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWlG+phaPw+1192G2NqcMTv7zJf3RNzZE7F9hhNK5ao=;
 b=jdLYkEqbWgZmIE4CwxZHLJ4Wwtz90GTUfceyuFdCq0sr1p+/ujMxC8rBwCRKVXmkn1ZpC9YlKEx+Xg5XaLDRCWZrUXbGz2wLcskNE656Azgny0KxCHDKcqlNTWaCljc961ZJa105BOlEFPy2iQzk/b4KEGaX+O4S9KtQlFdYuqbFR8tQuK8e7h++WyP/mPgmmUWiFAA3yf0yqQHqsj7Wtp3OrlOHl34vFhwn6MvRgEWVmY2fcvCAMbOGYS2RjpbrYYA98kAyBfTcxEo2zBjw76OZ6wSTiD/owCTqrbiZowb4Xuq5vZfSz7qNAmt8IWTpLfgeQgRcKf897ekeIU7aFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWlG+phaPw+1192G2NqcMTv7zJf3RNzZE7F9hhNK5ao=;
 b=i4rtng37e4Fgy2yXmyHjB4oRTR3LpxRkxo+DwJpcP9AGFqC+CHdLJ9wdF0fMMOHwiBdctL7q1wP8/aW3lWG87okKGOsa1OTc7BmLWpKr5mJFJwH/dYmoL5lSoRK+hzWbkkaf+gGhXd3CHVqNirLCe01NEUNU3ObjnMNRXdnIJqr+rT5ivheh+oxLva07+rQo4mGpLN8KY79O/XwC0CR4s0m/w8hu3xWSV0WqbpiSAGugZkr7QqXqXazgGd9Cp8dLXtWhVE9aMtUV9MYbMgYIra5wGih0M/W1aC/ZZ8vjRbi+TgAtvLTt7EZyI4vu4+5QPzjhuVZnE/TPzup/JvbM5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 00:02:39 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 00:02:39 +0000
Date: Sun, 18 Oct 2026 20:02:36 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
Message-ID: <20261019000236.GA123764@joelbox>
References: <20261015094619.8773-1-qiang.zhang@linux.dev>
 <970F52C9-3198-4BD1-B1A9-6A4B24F550AA@nvidia.com>
 <0c9fd241b8bdef73b3fe83683a238ad7df13bf65@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9fd241b8bdef73b3fe83683a238ad7df13bf65@linux.dev>
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 64865cfb-a546-4db5-a944-08df2d7449f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	n65VhBb3RUOa/6+a8vlnlfXDzkC1A87wsX39a+Zy24SH0IYZXsdm1aK6OiJoYC35U3ACTII9sA0V3ttHbHbedDXlcmwKcIIUdlIhbjyoHi483ctnTBjXZHCRqOyN72OhR2CI2fbSTHfZhxDXRz9P59bfbniMAmTYpbqkwPLSiQAAORBxoLhO/Yil675KMscDSkbKwb8E5Xx358rsBy6oYVgJzQQ34fsSnIu+dotm89fbPNtpdmbCAaXK7WBKu57YUijwkcpMJiINuHgX0zc4K7HtI64qr8FZGjvh/WaV5wJy1yjeHrS2ZFurgGcW1Dul/tjICbDNNJR4X2E7tPYpAwjK/0ev9kcd017rQUwbURYtlnBYDynRX0TOT1gfCPv1S192gVX7Nx9vXEugC4plYdwUdNNy4KwYgTmQ5Lau3ztat3lSpypmX9/ORZPqYh2QEgxJWSLBVkoWAYQA1oyuyjpcFbhacs+sSSKZvEsXtTlLivkH7aCdAA18dqHP4VG413fUbtZ51E7IdxM69uzuzFHiy+E93XRoRii7ebBBA4Sjl9ZM8KfABI2cRAR7HMQoiaU2UK7qTzo7vRQGm4kBOaCed3pRhJDFdMj40TefjPWDMWVhEu7gnd6TvdMsapDqzRmr5IzeDyZrNjZFZm19OnIaI5uxFO2J55XE5vB/gfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u6S4Q8fCGcKU3cEin2sl1hdu8i/n8cu2CwsnawcaNOKy/XeYn+uv7H3ocyra?=
 =?us-ascii?Q?PZYtF4c9ALgwfojZeQA4mJoM52ajPyLegpHbg3YIgBtKOdhlfj9P50GCqjDU?=
 =?us-ascii?Q?UsILWRTqm5lYLKCZRku3P0b1Gf9xLXNp39ZWB9v29X+hMcjhdXeL3XfotuuA?=
 =?us-ascii?Q?88u+dNwIJm7tXNHiVTi27gMzN1lM15N69dLRbrAACeihRFE8MUNSt3x3OIwv?=
 =?us-ascii?Q?3mAYGgn9o/mQxxU1iUnZihLxd0nPtLTjTjyU+H4IvqtPdn0RzI1esc7duC+U?=
 =?us-ascii?Q?BjnAJCnktCnuBcWzAUlem6VA20/BYYzCM97xb1zjSZv5kGEpLk41hXrEFwNq?=
 =?us-ascii?Q?NU7IjOJ3iMuB//0/5eV+sjbG915U5C8GWt38l4yPvM0w4eZqHscVMRtFUX7f?=
 =?us-ascii?Q?Z87YpAqKL55+qcRXhwSjUXbVIRLzgTPGbhJCsuG4SD7co8qL7k+36lkUVFx7?=
 =?us-ascii?Q?9Ca6nAfDDX+IZqbK82kaP1uaG6jpPVkPUjlX2tGQb942S6qMd9GYHQNwcfjc?=
 =?us-ascii?Q?W7UNiDHcAGUaKithcAb3gGd//ePlmWks+RSgl6MkEtb2Yhlfp4NYOH0gWjQM?=
 =?us-ascii?Q?90v0hoJbVrLVz5FmmuAR5EG//ImT2muM474hZiVxz8bO8kqQF6P6dWiGak6V?=
 =?us-ascii?Q?8eYyYPF/+rkUADjTi6aVqYmYZXl/Rm2y2+rXH1YXQoR8/4etymBQh/GzGlso?=
 =?us-ascii?Q?M/xeWiJ9Tsm5GQL6uV3ZeqHx5gWasHuMJ1htPzkWBYLIY1EpfKUQOp5Do7gW?=
 =?us-ascii?Q?2S0qtxz1l7H8gLsGeEzMsiZyaYT1HhQJg5dgDdKd9aEFDfHeoaPJ3plrPH6h?=
 =?us-ascii?Q?R9Lmd6RZ9tpP1LHis9SfS5pJWKCnuOSGOR0zZn50YBTRTOIM/QMg8wf1mRBb?=
 =?us-ascii?Q?WTA5mNTFtQsej/9NRNEmWnVfNZgyQZ75wffdFBMuBydJ/HIZCl2I1Xx+1jv3?=
 =?us-ascii?Q?jbhhQB0o3YskwFPZe1FVfAHV+2rzC6iGJZohcq0PI6wl6OpKbBIKB2L1aM5Z?=
 =?us-ascii?Q?AHecjV/q2dux/qY8TTS2N98fHUoGC9ISWvvUrh1r7K/nrqCG9AcKFMSRQPbo?=
 =?us-ascii?Q?Yd2XHEhJNm8nxSj9+Xhl0au95Ib7aHBlOcS3J8zm+1+kpcUyY3U/1Aw/qqgK?=
 =?us-ascii?Q?j0Rw7MBygsSm5j653d0d5mBZMtBYNrxGMlSjW7iWj0awyaAJMIi/Fb45zsBO?=
 =?us-ascii?Q?32Ko5J4IQ/UBKBHFQgPxs3ZQvj2fZJLzhl4pqh7lNS9wixrKxhcoj3aHSaln?=
 =?us-ascii?Q?28YzZwX7FJNo1FG7geFEU/k7e9iKZjJaYMpCyRsMMq0a3eSDWJRcXxnQjrI0?=
 =?us-ascii?Q?Ty0HJ2BX+s5Llmaekl8UpK3TLqvowl0Xe3LWk1RiVRrUhHxI+5DBhccNO286?=
 =?us-ascii?Q?FdqVTFL0b5JLF/apehsITeXox73PLZTZnKnLIiB0Z7Huug2JQaKAEflncQvM?=
 =?us-ascii?Q?8b1Oi+i3j4VFyBCea2V/hoCGqjOrcJvHRU36wuJmXmGbPTjedI6+8CbuJ+hZ?=
 =?us-ascii?Q?R4VaOOCF9DtGRs45nSSt5CKdMHH5lCeXzbMjma0bVcmEvKwMZyAq6iqbdJgb?=
 =?us-ascii?Q?bJbIdcfWSJsgSAp9ieQI+z34GSw/KheFDAzJSHNsaAf9zanC958+CUiKKAeI?=
 =?us-ascii?Q?SeTm1DjrdEZYWN/lL9hk4UV/3sifOiseAg72Fe2Wx7ahV1gqXnUVnvGbKHV7?=
 =?us-ascii?Q?+QCBFjKlpJXmxhx8r1YvrEKxu5gSRQNx+IZ61aBbK08T5SK6xxeq7Oj9vQp7?=
 =?us-ascii?Q?DGLWq6TPkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64865cfb-a546-4db5-a944-08df2d7449f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 00:02:39.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxF3+ry/3DAgsQFwSmDljD73bIayPDsnoCp3xbg6rvDaEJp90lTLsgBOvk71rcnYCaxUG/KXPTG309m4L26wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

On Sun, Oct 18, 2026 at 02:51:18AM +0000, Zqiang wrote:
> > 
> > > 
> > > On Oct 15, 2026, at 5:46 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> > >  
> > >  The RCU Tasks Rude grace period is implemented by invoking the
> > >  schedule_on_each_cpu() with an empty work function, which forces
> > >  a context switch on every online CPU and guarantees that all
> > >  rude-tasks read-side critical sections have completed. However,
> > >  schedule_on_each_cpu() can fail (via alloc_percpu() returning
> > >  -ENOMEM) and returns immediately, in which case those context
> > >  switches never happen, too-short grace period happen.
> > >  
> > >  This commit therefore wraps the schedule_on_each_cpu() call in
> > >  WARN_ONCE() so that this failure is reported as a "Too-short
> > >  grace period" warning.
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > >  ---
> > >  kernel/rcu/tasks.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >  
> > >  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > >  index fcac7361ec51..91c25717402e 100644
> > >  --- a/kernel/rcu/tasks.h
> > >  +++ b/kernel/rcu/tasks.h
> > >  @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_struct *work)
> > >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> > >  {
> > >  rtp->n_ipis += cpumask_weight(cpu_online_mask);
> > >  - schedule_on_each_cpu(rcu_tasks_be_rude);
> > >  + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> > >  + "%s: Too-short grace period, OOM is now expected behavior!!!\n", rtp->name);
> > > 
> > Is that the best error message? OOM is expected when grace periods do not conclude.
> > 
> 
> Hi, Joel
> 
> I will resend v2, use DEFINE_PER_CPU() to replace alloc_percpu() to allocate work_struct objects.

Thank you! Looking forward to it,

Joel Fernandes


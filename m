Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E471B7910;
	Mon, 19 Oct 2026 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370020; cv=fail; b=WWel4WiIEHkJBwHd+X21+lTZ4qDbFrodgrSiIdQwML1MgLOmBzVb8IaMT3bKartUU7aeKQq8uKTU1q/u2BXvLgNgxrujXvEUH9YsYDUyE10xC7bag7N2VxLlZJJam809L+os2EIZUdN0ygYA7+Kmp0xhn2d4rUoNS5bF69bM8KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370020; c=relaxed/simple;
	bh=YKtcySuVBfLMqT9pV9sm2lNWKe3Njfbk/hD6c5LsZAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hvlu85a/sSVA5pFt7irDgqf/ofDRGTyn8SNhclT8KYbpxAkeebetFvaBhZH2G2vBAVj2PNOWErPEvrtX3gR8K26hYZdyDj6gLy3rlavEuWwchK6eCiOhZ1WpkjOds5mtL9vj+1tPF9VKbXEtbeQwfH/2ds+On0KUlqMXySKbQyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkcoV/4W; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkcoV/4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNLjK04Xxpg6Pc8GE+mlR69rzuhIbysBH0HD06hB7xEY1poDI2hTAKiAAxgMmGbYdktW5bw+WPam0GcgjFvR9RlhaKp70xQVtdcK+X0saeV8d0r3fLDP5V9fJrGhMyfF0tr3dzbFp1KG3R8ppDGv3oeP+8GUrQYn+LSZYCNJqPy44Qc6aglXO4cC4H2O/fGJaDM8LQOquUHKU76Qvc4bdfuf6jdJR9KcYtqMs7fPAcIMtjz1yhk4/Sc14fgh/pnsMJfvi/dIXom4D8pNoTS6T2PUC+AEHmta/H4zsJBejbZNsO0+8byunHvW0bHc/e5fga2LUlkXtH4HLUSxiAXzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/CxgTEW8HbyOegMHI7SRK1x5uixhhKzyLP6855MKU4=;
 b=coyH8xyUomnQfkQoYgUzI+aqKEFp+nydtqCth0P1ClFfN2Xg6Az1OMGdLLPmudyStQlPAupu5dzD+2R/bIU4GhGY9x/KmSbUMLqEK3QoKmaTqWAJ3y59CXIpfnBgHgrj3o19yDQeihcN1+o17L8sCZiXQVMj6PpRFx2/ogdfhjddMsSTCmYI+CtQQ5Jm+2OayeUE+pvkZd1NPLhsd1A+pa+1QgS+Ppfyts8ZvOWtBoxFi6jm9SSsSRioyLECAslCulf+chEdunAFAT747jaGOMbRqtus9kmINVdf2OO3ZCbfnfKspwPCJK5yjbz/dexAVg1w2meVFGW27pEJx6rp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/CxgTEW8HbyOegMHI7SRK1x5uixhhKzyLP6855MKU4=;
 b=lkcoV/4WSUjktlLE91gB9GmOBnNHnxl/7of4dbLMzjgYNWXLpJimzwfr0CN3em3VwvvxW+gptplf98//J5dn2uoeZYHynHsFX1htnbdTSmOzfNpG5FZ8WMglSV0ON8tdQhp3ToUA8VTvOS4f67SlUnPVxZMyiM32NhDXD7W1VKEUYepvGogruLunxvMCy7cF6yRMVABO6E9PgO1+MHx2sAnuSmXQYuTh/y2j2WA9bvmjPFKiS2RYGKNha5yK+ZGppQwoaek03Sb265Y9yn4Kubf/DRePYtCwzrmjJdmaYsvNh2ka0bKu7CTsIiShcdC5a5n6qhnEY2C3Gz8KSgFZNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 00:33:35 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 00:33:35 +0000
Date: Sun, 18 Oct 2026 20:33:32 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Clear cbflood_max for tasks-rude and
 srcu-atomic testing
Message-ID: <20261019003332.GA645187@joelbox>
References: <20261012104134.16268-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012104134.16268-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3145f307-df11-403e-fde0-08df2d789c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RYwCUgo2EI1N82GEgRQARxmRyjwNm7z3mwCOtiOlnPiLN1NztQvBUtzmSbYpMRwS54ksyffFr0kYO12kt3h7SwpTS63o4n9ykOFzrs3ZM3Jkk9rYz/mmvFH7k51lqQVSrUbnqHNdy2G85dE+bYeFcdPOQpTKTPByLv4Z0KsQ+hQPcnYKc095Osv/lObzsIlq8RTvn3Bg4vO9jwQLqIN2EErOn1RNVBWw0ooKa5+YYXr9cAQkHvAbqzTKqs0GaMgRPbdQOXh0G0wzMQmjNGDwZeOQaH5eSirKF5QCeIhTlNCmRKCyrYlbqpk08pVW6OZoaAORWY86A4/hdcgqaVW+Zx6Hf55YrZGoXDy+KGp/skV/NAV6cSUIs+IfatOOqowHjIqfBrd+/zRNFOvBz3kFZFImVPsb/WmTWrbhq4zgD30OPvqI6U/x25/mBMGbkn6DGR011twhWL82PAgFAMjO22hWMZjUK6+MmSJlmmOdJ3gwlcJny/JUJ/yNFRlLKQw6G6WW6p+Lmljy6cjEu8LTFCguLfmkB4FTx42BFrCxANFGYRBWlwaFl6BO60C9XDVrruHa86SQeg32FUICFKip5NQesETZLekgK1ss6OBuJhm0qi+KatzfOPg4xjMsMKMQLrDyD8AjJxxzkFkxpLbZpTJyX7z70DzKxvlPfMuaGX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNSpARPTDLTGK2YWQu+YYmRhf/zhL4y0gu1cWXcNTT+1iREDjdyYdvV9TtNB?=
 =?us-ascii?Q?rtF1b4gIsxr/eILa1TRdHrRBxPjuVmHzyrlYjWP+mRBroaPD2aDjs/XPGC+4?=
 =?us-ascii?Q?WG7MlR0dFIu8HY7tHjhdKHbYwVP5xVZ8OEXnKnzZvRUo876hrhctfM9MIARC?=
 =?us-ascii?Q?VWe6kCIBZkv16s0H6fLKePxStJWEMHXHaLy3k6fJMASUeXpegRJU03fC53UZ?=
 =?us-ascii?Q?KFFXUsRr7UKrMKf1zSWkfbYeAbUYCE8oMKV/O+hozX+w8jXnGHLHUZC7i6Ah?=
 =?us-ascii?Q?3Lj6iMBwc29CchHoFfbeScxGq4LWafgmzHjdJsdOIu1aWNhP00LVWo54N+KC?=
 =?us-ascii?Q?DsOpLN2vutX0gnx0mxird0D4cpiTA9mCPLPn6IL7v96JW1goxMl+V+cnNdH/?=
 =?us-ascii?Q?KIwuE867v/YvsklT/ofOHqxiNjgrliexpNselEHepIKIa0BjHEzQa6ohGgID?=
 =?us-ascii?Q?dG3HIxRaNTP/YItvwqM4iHTAEvmT2C5O/Sk5zsF0km4taIX9QBGB1q1Yv4X8?=
 =?us-ascii?Q?E5v0n2Q8qtxV4+y8fq8OJiGGQIh997qVGPqrWQ/0LAzw+P/XDBY/Al/DSwvS?=
 =?us-ascii?Q?lNg+FyYNoxQcOROh+cPmV6R9MNGrKoZGMNoeoo0p1IJ47VPQOwabG51S/WR/?=
 =?us-ascii?Q?e56sAc2sMuY8OsWR+mwDr2LqI6Yc88WOcuThxt3k7iEgrCvKMmkNecjQwXxm?=
 =?us-ascii?Q?hwW48Zv9jku3DLmv/muw8n6d6el0psZC+/QVJRMF8baIgpULQghkPRH/lEAc?=
 =?us-ascii?Q?ec3qjcjTKdGoBQPxWqA9JroIRm4+38gX9/N3g68pGLFxTVecgVIz33Jl/LTS?=
 =?us-ascii?Q?3y1R0yqkYzQ0L6OqRLlSPF4nO2aaCq36KizSgC9qmuhAwj43hkkEzugvlP6s?=
 =?us-ascii?Q?v+NChpMlP7qN08sYnZt3A5K8vOELQBGJXcN7WR5jp5T2Qe4lFaVzibU2G9Ky?=
 =?us-ascii?Q?k72wKJI5Nz5b5vSYKkzmDEZ0a0LZMJSHgTBPeObxVj7rSwlEXVxCleh8HJcA?=
 =?us-ascii?Q?HBehHK/hhXuh2z08Axj6NMGFFoU+eEyWnG90ePsAjvANqR8Ik9sRKefcid8a?=
 =?us-ascii?Q?so3qYyJ1Nvq3ZAf+MaF7KHmZJDEx5/9eMUSsJXDdHingI6xcp+JMfqo32+cS?=
 =?us-ascii?Q?TCPIzd1jBaMns7x2bZRiZ7YDSMsJ0yAgLsNXUW7ezmylUyX8ts0D+GdRThy8?=
 =?us-ascii?Q?5DNzMXn5QM+MbqvvHEkukFCSsU7ndSad38bFxgfYZ7WAe5xWrorE0tOzIq1t?=
 =?us-ascii?Q?64EX2aYlOo+GuLS3mFjaBnnk7aunnutjbKr7LplV07B76SXDnZQsmTBA2yWm?=
 =?us-ascii?Q?7Tk1Sz/3QqZYpw+TsAtpKZQSlJZDZa9Gqrt+jC7Srq8LAawskQ0b3LL1LONV?=
 =?us-ascii?Q?BMgf8Mu8zaXHzqPBEyS7ahqDtImUO4tYeIaHBpWQCLChlMseLa68DOpsEqnc?=
 =?us-ascii?Q?Y0PntHWMYZuZ+VFYgGRUVyzWPFsAr5V9ZUqyGsURQzi7XHAdzby3AcxYgkX3?=
 =?us-ascii?Q?lUWrBt9JFTrpVl/CUL5DV7dogwC1w7XgFyzVZDYCHFEXHk+I2rS9WFJjA36Q?=
 =?us-ascii?Q?Dih7+Xs8FsEy50byxptTpWl5sMSyCyDgoNbrfNhxYrY13fet4im+snMrqKMG?=
 =?us-ascii?Q?kPSsx53Bpp7W1ga7+aKFnJxvLf6yXIpfdjxHUugCom6LoNVHuFWtyF1BWXUj?=
 =?us-ascii?Q?Uh8V9qw1b7HBZOYJrFSIJyv7Mdg8lNnD3AYEtKKe5JYlr5liOUZv/9kidLV9?=
 =?us-ascii?Q?DQ4PGSQWlg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3145f307-df11-403e-fde0-08df2d789c6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 00:33:35.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9hDnfQL+WCvXX/ATRneXP038RfFgmi4IeTcZtC8Fbw0VG+xWwU5KY8Y/PsdDdfUc1TiAoIFSzl+FV/zYK3cMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

On Mon, Oct 12, 2026 at 06:41:34PM +0800, Zqiang wrote:
> When running the tasks-rude and srcu-atomic tests, the fwd_prog_tasks
> kthread is created because the default value of fwd_progress is 1.
> however, the two RCU flavors not support ->call():
> 
> 1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU Tasks
>    Rude asynchronous APIs") removed .call and .cb_barrier from tasks-rude,
>    but left the .cbflood_max = 50000.
> 
> 2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to NULL
>    for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched.
> 
> In both cases, the non-zero ->cbflood_max fools the check above into
> creating the fwd_prog_tasks kthreads, even though those kthreads cannot
> possibly carry out any forward-progress test:
> 
> 1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops->call
>    is NULL:
> 
> [   68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> 
> 2. The rcu_torture_fwd_prog_nr() is never even invoked, because its caller
>    requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
>    provide ->stall_dur (only rcu_ops does).
> 
> Therefore, creating fwd_prog_tasks kthreads is pointless, this commit
> removes the .cbflood_max from tasks-rude and clears ->cbflood_max in the
> srcu_torture_init_forbidden_apis().
> 
> simple verification output:
> 
> [    3.062959][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [    2.922323][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 968343be4e0d..00db87256e78 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -723,6 +723,7 @@ static void srcu_torture_init_forbidden_apis(void)
>  	cur_ops->deferred_free = NULL;
>  	cur_ops->exp_current = NULL;
>  	cur_ops->start_gp_poll = NULL;
> +	cur_ops->cbflood_max = 0;
>  }
>  
>  static void srcu_torture_init(void)
> @@ -1250,7 +1251,6 @@ static struct rcu_torture_ops tasks_rude_ops = {
>  	.exp_sync	= synchronize_rcu_tasks_rude,
>  	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
>  	.get_gp_data	= rcu_tasks_rude_get_gp_data,
> -	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.name		= "tasks-rude"

I'm okay with your change, but I have a different suggestion. Let me know your thoughts.

Could we fix this in rcu_torture_fwd_prog_init() instead? A nonzero
cbflood_max does not mean callback flooding is possible when ->call or
->cb_barrier is absent. This also avoids changing the SRCU operations table
just to suppress a worker.

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3842,3 +3842,4 @@ static int __init rcu_torture_fwd_prog_init(void)
-	if ((!cur_ops->sync && !cur_ops->call) ||
-	    (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
+	if (!cur_ops->sync ||
+	    ((!cur_ops->call || !cur_ops->cb_barrier || !cur_ops->cbflood_max) &&
+	     (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
	    cur_ops == &rcu_busted_ops) {

Thoughts?

thanks,

Joel Fernandes


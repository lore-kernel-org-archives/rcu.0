Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085519CC28;
	Sat, 15 Mar 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742083192; cv=fail; b=g0fe4+BzAdOB0WBS6mUiHPMHvq/jihzPaqaNrQn9NfW2IuhCeoClWzJR+azhpNESjEB3mtpaXMk91u+83Ejr/TBk18S/KKNxkFckp0hk5NZ8NUkMVtu0IJ6Nzsd2jQpW2/20d2FZFKnIuEQOistsyPKM+5LgUgrW0TPXz11HUcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742083192; c=relaxed/simple;
	bh=3s4RBFXMVpsQP90KhX5oeR4KHLSQzEzCQyIqbRc8Njo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T2KpcyMElqYFToTOu6ACUV6vcS2XgfHWu/y2MH/776AJkkchLZXUlr62K7JcVwVcRTAiKPMla80QjvLH0aeDaKMFd79WqNy9IjZ03EpPRCEHGH+f8VJViThRINoxowDExAUFlz2GijwB2pcPvuDMaSJTig/envm0rtf3EkVjAUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bsC8zXm6; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsC8zXm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkhG2iNHqWDCaWttOu63KvaQ29Rgcmz57HR9NxVQpQf53mX2e0tk9MgqSMeMTqFglXndHF2U5OEcDIkEZc5HGuRV/2j7lkBCVSgo07wfXZZNXMjv6AI1BUNCjWLd/7XlzoLH11THxrno+kFYKY17tmOFU3aL9YJ6wip0qdO5ipbdioNX9kjDw9ehAcMsZxXuJiflNzt/4aSVvxaBVmbHX86dtIqoHumtPDn7hc9q5L2LrNoHHYAVrxqPI/hzDWJkPJTpD2bMeEQemy7Z3pkNiIwTFuehwkvnMi3Yrxq/CBFCCIyxFnj+OZQOBO5dwpL0gpaHl0V6B5pJ8VALgrKL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loXb53ll1NbNoybRtcXjN8DaDotY/A4qXTV7rCwVn7E=;
 b=jNLr9FcgR8xzREVdcvbtegY4L/kC7QYiciXQr2tJ7r7FlFrxpceZwSI4uc8kBCRyweD9taVivntu4WuDDRW4PpO8IJOWM2EJN9GRQmd5UmSE6xq41Ii1tKuWDconYtNTKvlE/kBcsSHEM+X/7bLeGHWEWtAstIC+0FrUpYZy6CoMRnbA/URXXGIjjlXzXYl/CcG3DGlb0KXW5Ec9KffvnVp4I6EsjAj+pjtGJA7Nq+3ggRtLl60C8QBDL04H1/8/+sTo5NzivsDdCI4hujSfAYE0tCtk2x8IIHHyVRBEnOFyByWuJGoC2gBK+y3z3gdW8UB4d0y/qUswKcy5ICj3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loXb53ll1NbNoybRtcXjN8DaDotY/A4qXTV7rCwVn7E=;
 b=bsC8zXm687jDqvCqLm3Gl4IxCa8fk4HlFfpGZgnoA5JbtseF/DjJGgcIxM7wU5vN6wTz34f5XS384KbH+QRpjGfLkItpeLae1OqfUCeA1OCbyrjATQWIhe54L0QP3t0y94G8eI8YViQOw94R6rA0iFe58p3UCx+f5QDXKK6XOTv2+u9s7ioT6YWmllk9UqsK+MYWoG1fEZFdlTJMdjoxOpjze6Df0SMYgrZMV1T1jzcscKUXHBj5OccCCy7hSmCwM2vwHjsSzMzE35TKcO2tL/8k0CsCV+wmQiPnlZI7F/m/3GFEeRe3iBPddLRBI7N6yA29lNsuDymtPwdVtLs2+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sat, 15 Mar
 2025 23:59:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 23:59:48 +0000
Date: Sat, 15 Mar 2025 19:59:45 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
Message-ID: <20250315235945.GA2634509@joelnvbox>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314143642.72554-2-frederic@kernel.org>
X-ClientProxiedBy: BN9PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:408:fe::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a1ccf6-6234-4b98-5405-08dd641d7783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDN26J+vO3IDelMeY4lbbEp1Lz5hsDO7JsOmlVJJsafbz9frJZQt+7I28k25?=
 =?us-ascii?Q?kG6fXscX4xx+XsfyfPl7oXOdX/PDxIpNUCCWaEqA5TIOXLXMWjCVXUHfsWRF?=
 =?us-ascii?Q?DoQJ3cGFtKJN5hl9pppgFLkMlDMaZuXCSKK88+xQ6HyHP/vg/UYTVQehovXB?=
 =?us-ascii?Q?XWc/GWOthHb4soiyWyvqvPrUYmcQ1lKU2J52mA7mVsTyCbJocuCPjdYacmq8?=
 =?us-ascii?Q?HM7mIf6Exq7lgmSFuGdNNYkXwClM0iGyh67X5udxzpI7+7prMMgeCe8I8Afa?=
 =?us-ascii?Q?XxyVLakqlU5Yx512gMz6/Pjnxw0/xN0vNynJP7HRxx3qQStsuL3kKF+qGJGX?=
 =?us-ascii?Q?oTQk1qcRUmnDW0P7KW7oHDgfnHLREUXCWTKHHg3IiRH71BDTEk80+dlHgItO?=
 =?us-ascii?Q?vfDJ75cLfCSrcxmZDL+j9JhuWEfFV++9qKmzG/HMid4xOf1bVfbGLg24dJT4?=
 =?us-ascii?Q?D0CQxdCBv9kY0S5ow8i9xQmIk2kgpcK2XLaedwztkYc+N57wZYhBzEj071yp?=
 =?us-ascii?Q?H7M6XiAUJOr9Z4ArYAnboHQe3UZBUMaL99sUi1jptSWNUTHJyo1PSo1tpEMU?=
 =?us-ascii?Q?0RjpSY2I/G+x7zKHmaaOYnYk5CLX0hoOB3QlEeU9xau2Qd42RNyDS51h8vqT?=
 =?us-ascii?Q?Iova7J14jlqHZFOO30yeiggEpwN/e0V/cuWUqHvQTpNcvCUZ5figCWFKbujd?=
 =?us-ascii?Q?dyXWoIZbekZZWYqO4slby228JtZeOyjV0P8wD+GknPUtCcYCcsDdlestQBds?=
 =?us-ascii?Q?tVQVLG4zxgagduyjC5G2RdkGKtmOXe6htjTt6ruYSh5RoJcNZe7LW0va7AiF?=
 =?us-ascii?Q?7j989rekTMS1b6g6FI0MSIswnjv9uIfWBdky8AShin98WboatiHq+seEbM5u?=
 =?us-ascii?Q?EOtPFAqxgdMOD/ssE383FLSt1Z+flp/5WfNkFK1ot3ZC3kpq+IPj110/pLFD?=
 =?us-ascii?Q?wwEkC/kwvlNPjf7TTwbI6ttsFLOjFAe05H9fSCtde8wz5n2u8DdeW6YK1aS4?=
 =?us-ascii?Q?auV46KPegXzXIMqtdw8O5nRspvzQ+WaYv45bZqi0VOZYfTCxQO+xxmp3uWZg?=
 =?us-ascii?Q?o/MfrL7kfSrP/+1Ji0ZJ3Y7XpJXFfuX+/JWvRA1+IUMBmP5lGPRFRVzuKZqm?=
 =?us-ascii?Q?7i/AAw0XgH9aXtwWzASu0udugxpPvwpAwES6xmNqyGZ7/KpGklnIgrrkiXuW?=
 =?us-ascii?Q?snRdZjA2CNqT0PCygwYdu2uzsu3DVmPVlILLwkBjlgVf6TTX5l2r9ewgqRWq?=
 =?us-ascii?Q?05rfTogKoG8FbW8ayt59t6LW9krHArPQlVoADgcvqXrY9kgNjRXR6zA/0tJH?=
 =?us-ascii?Q?ujy2bpTj6edX0A6NiaAj/LdiSQcYfRUs9Jx2Fk1z563ydzAFDgKzD1x2JzOK?=
 =?us-ascii?Q?jmEQQotUtXwMDpGqkF7IOnc00aZD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OpyECLmraWK8SEv0UBnh3dprSurRm87PpyTayhW3/ILvkMM1rtormKTuGvmU?=
 =?us-ascii?Q?/tee+vUUaN+5G4HNv75m/+b+0djy5iJf1LFn+S+lJXCGj/39LM2/ybk034Ex?=
 =?us-ascii?Q?B2sFvzNMlaCFYxz36S9TAAfRppiOhSwhwVbNUuADESjoeTCBYSdvOpFV4zor?=
 =?us-ascii?Q?/Ea4VhznErazD8SYJNRtjNbaPf4amqFDLZnaSRRfyaQSu8fR/rwDohvMuMQd?=
 =?us-ascii?Q?OEIkF4q03+vjHW3VBNJHtb+bAi8E53maXPjnosKA1ueHyDW/paWdVmbKiQJn?=
 =?us-ascii?Q?j28R+pQVQFR4FdYV1Bt1Ah8KaHRu2dRCnAQXpbIxSV5dqYipTmEbZ4c45L8O?=
 =?us-ascii?Q?k6aWj6UwyqNNQyHDOWKv9XePVONhiNqhGU1bTtCtDeBfz2O+d4mEpMKK0QgJ?=
 =?us-ascii?Q?geUFmzcji30lQtVO1DUB/obbjQjQL75ToAVwZHNN5uxzDSnC0zZDg3JipvLR?=
 =?us-ascii?Q?rl2/Cq0eOo4THGgp34Wu7rb5+VI68UJEnBJQG4LohEFTmabDPO2zB2AN7o9C?=
 =?us-ascii?Q?9YKOlRIlK+BNmAyZastP8z0G1B/Xt87LBQHeOP990DJz9OwzaEPNFMBOy35p?=
 =?us-ascii?Q?z8NOteSXrncei09hwgkd7DxcyHzDawSKTny3eaV5GWj3ger9oG3h8LnfHFFz?=
 =?us-ascii?Q?2LENx05mj2doO8y5NQ4fdnYDwcAfwEjO9Bb3HQWpepCIKGH0qCXds1M+pvai?=
 =?us-ascii?Q?EqLH0mhq1OYivdD3HbbXxM8RG5G9BAQrCR52xxMhHOVZL6aoyjj9yMH/XM/F?=
 =?us-ascii?Q?ON3WV9UjkcYKVakbgFqadk2b2TOcdiG8npYuBpzDb7OYlT8s0HvYai43/W9H?=
 =?us-ascii?Q?nEI30TE2NpYuE9wJ8Ecv6APTgbF3MaBuTFJclnXWuDymdE3g3ppNFjSMH5Qv?=
 =?us-ascii?Q?zVKpTV5bLCPs+nydf98HqlRDQu6munQXYcI9ydpsUbl3WrHWJZUv6t73Teja?=
 =?us-ascii?Q?sArQ5PFSy27L3eYSUwZPls+zGQU8ADRHOi+yxQH01GqN5k2qQQqc04KU4sjz?=
 =?us-ascii?Q?d6/hreGXGjD9mSKNdcOcTPSKRa/eUtpYDBiGX0I/SdYTxcm4pE4nGtBsOTZZ?=
 =?us-ascii?Q?srWlIcyKS/U1nsyYLPiZMd1gxWrQOtysliMKC3uoMUQEV0FJAcb0k4mUuFY2?=
 =?us-ascii?Q?eCF11v/oSBDbWsrI/MwPaRRtnO2iBRXQSnj2ZHuesy3r9MNEw8Vc0/5DCQjH?=
 =?us-ascii?Q?pm3qpzhLYU3ACldlZvUoQtIPzuYqGbNOQ/jdL5X0spx8wkEBpMRybYI0w6zj?=
 =?us-ascii?Q?7RbUi97K74q6Lh6f4kQ1DvvOH5Kkm0g5wGdYjgR9/LmgbVAfBrcHH0yniazi?=
 =?us-ascii?Q?1bg6TXaqdYy+p1JT1CUMUL126numk0vN6mO62VXWTM9P4TyqFFrXzxGiOAAd?=
 =?us-ascii?Q?tFoAgIpeVG/qgCMTVaGZ88pJDvMriQD8KjAfubxf4+4Thpi30k4wdlUNd+G2?=
 =?us-ascii?Q?I0pncFWfwMr+b35g67383IhqjzDZg6on6hNYHUKxPwwzmSKF4qGB1Kn/K3BK?=
 =?us-ascii?Q?ssvp2GqemedkPJmrHe9PfWDbUc3PbfFHQ4dJAzvC3KIREvIveKjSASoA7d74?=
 =?us-ascii?Q?sWrIXLF/yVTOAWvUqWSNOV+6nBiMk7Ay23ySE/y0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a1ccf6-6234-4b98-5405-08dd641d7783
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 23:59:47.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcgsZpYougEZuXZV53o4mG96tgulO7fCimK0+PgZBPl/67hheBW6M68ltF70w7t59+zODUm6QaCKlac8lYfI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

Hi Frederic,

On Fri, Mar 14, 2025 at 03:36:38PM +0100, Frederic Weisbecker wrote:
> When a grace period is started, the ->expmask of each node is set up
> from sync_exp_reset_tree(). Then later on each leaf node also initialize
> its ->exp_tasks pointer.
> 
> This means that the initialization of the quiescent state of a node and
> the initialization of its blocking tasks happen with an unlocked node
> gap in-between.
> 
> It happens to be fine because nothing is expected to report an exp
> quiescent state within this gap, since no IPI have been issued yet and
> every rdp's ->cpu_no_qs.b.exp should be false.
> 
> However if it were to happen by accident, the quiescent state could be
> reported and propagated while ignoring tasks that blocked _before_ the
> start of the grace period.
> 
> Prevent such trouble to happen in the future and initialize both the
> quiescent states mask to report and the blocked tasks head from the same
> node locked block.
> 
> If a task blocks within an RCU read side critical section before
> sync_exp_reset_tree() is called and is then unblocked between
> sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), the QS
> won't be reported because no RCU exp IPI had been issued to request it
> through the setting of srdp->cpu_no_qs.b.exp.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c36c7d5575ca..2fa7aa9155bd 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		WARN_ON_ONCE(rnp->expmask);
>  		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
> +		/*
> +		 * Need to wait for any blocked tasks as well.	Note that
> +		 * additional blocking tasks will also block the expedited GP
> +		 * until such time as the ->expmask bits are cleared.
> +		 */
> +		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
> +			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
>  }
> @@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  	}
>  	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
>  
> -	/*
> -	 * Need to wait for any blocked tasks as well.	Note that
> -	 * additional blocking tasks will also block the expedited GP
> -	 * until such time as the ->expmask bits are cleared.
> -	 */
> -	if (rcu_preempt_has_tasks(rnp))
> -		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);

A small side effect of this patch could be:

In the existing code, if between the sync_exp_reset_tree() and the
__sync_rcu_exp_select_node_cpus(), if a pre-existing reader unblocked and
completed, then I think it wouldn't be responsible for blocking the GP
anymore.

Where as with this patch, it would not get a chance to be removed from the
blocked list because it would have to wait on the rnp lock, which after this
patch would now be held across the setting of exp_mask and exp_tasks?

But I think it is not a big deal either way, and if you feel it is more
future proof to do it this way, that sounds good to me.

thanks,

 - Joel


>  
>  	/* IPI the remaining CPUs for expedited quiescent state. */
> -- 
> 2.48.1
> 

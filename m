Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3120D4F0;
	Tue, 25 Feb 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520754; cv=fail; b=thiD3WkdSN+7bBk4UD8u4PemRT2bzTvZ9yFB87WKtbhhvSDHk3pwH0u4+xYMf21fBj92I8DyRmKfFrMCP9fYgZN4CAdtQABVi4+yVZNBUFAlH82bnFhnE2oepRnjuszkWKzIm2TF+8cUHeLNeAGZZ6ffkXUYyMp+A9DNB+LmCAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520754; c=relaxed/simple;
	bh=Qh1emhWsYnIhhxUN4MtQ7q3oCUX/rn+WlEytd+nKIRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CbccOO2nVTNTJT3iML2cawX7ztGi8dtcxrzKTqprYtfpoPUxSgJ+zz5qFhRTpyYOT1CyQ4ca8aHv2prDp4GSeuS9XzA4Hi84z6Mj+SErHTWYuGJszCAmu2yKAhdJRqBlmdQVjgmdNPxEpEwnSr9xeZfT1UB26m8kDQL/+Y9Pk7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MGdKQ4p1; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MGdKQ4p1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMIzEBVQpXGKfvbPjWVbkur0TNaP9SXwekmq0khgSXVKRouQzv3qR4D3H+biWvgHtzAt7tVo084y+UdAR3vbMQ/ZEn6Zeka32eG1BLcSNesG5wRTblJe53yexvh9pmu4rsAMTCJDYl9rTbLgh+8izaE/Jwt4CLPx+cPRx9FPxXvstMje/mWaOJBzo+3C7sbDgFFpnyM89Dhll0ESZQV/3rhtIJyO5pXfmtvlquTJQPQTVW3hyw4iH5ZfsHpeLQ7tMNtniMNYdsh5hcG82le1xqT0GKbbts0rLMOtt6c1tq///5drH1B/t731PdOy4az9mwJ2FZzTYhsLylwOWrvb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi3gMGZh5S9lPP9K8AxrNfkjSZ4iAQiAeOhpCFkxA3E=;
 b=k2v3HYf7Ac3psOKhPrDq/Q1t/3UZFMpWXHbTUXBwvw/EUowhsJwq9bexi3t9rmkyot+lTV6yONSlLTfNTRsdqCCIVrNKeJzVzrtC+XV9TxREZyk0IhOOT/0pWft7tCz2XLuIjddClgF2JttZfx9yG2FSrS+fUl9tTn33YYtNIF30h8wpRuA8SEI4HY2oUFnVPTGB5bb0JD4wHuBr9xqdBBUMrV6MqZStwur3D7VT1iIAn292r+JU1473iSJ/Ivp1NKCa3FrRzPVRg3pnmNOBblWEV7uFCao3H8viNXa4m6NlwRqNsTfHSM/rEUHG6GAYDxtQ7K/tHux0L4LzpqViWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi3gMGZh5S9lPP9K8AxrNfkjSZ4iAQiAeOhpCFkxA3E=;
 b=MGdKQ4p1GNle1CrL7dTSp7hbKvAcTyblnmjlXinm44oq1SZBLDQ7ljQwk+XdGOkETlqSEi+YhTcIyybWyQ6imuHkLrCWllKV9dtz9cleEniy93aTYULDwTvczj9+/L4YB1qEpUsLFC/ujO8zc4tixOoI9+LD8zjDVAlF7JFPMrRNzNheBtTDg/C1RCrnccKYq+X+MGYaWtm2EClirH4k991+BKO7poGivqmfnuogkfpEGxiON5mD79wPODlsVtEqe67KZnLs/ev6pKIGXI5RQefIU8goalf6As+rzX6T4zFQiWQt+VuNhI1mmwb0LdQs3vUQt852MS+yWawPWLraZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 21:59:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 21:59:10 +0000
Date: Tue, 25 Feb 2025 16:59:08 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <20250225215908.GA1812344@joelnvbox>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213232559.34163-3-frederic@kernel.org>
X-ClientProxiedBy: BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 61157bfd-1946-4986-ed23-08dd55e7a22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ckJP6DtDWnDoerSSr4QLnl5a46hYUWGyVs27Bg26lUxXF1Rgz0xOlBVnCab?=
 =?us-ascii?Q?3IRTGxUC8kHezFfKTSO1JS7otehIKR4XzoQobMD8OdO1Ua/ATq4kPfWpylBq?=
 =?us-ascii?Q?YcsMqw6t11J3dh4dTtuPisMZM24w4nBSB2J28UXhkqPveAnL8g1RxwTUGoqM?=
 =?us-ascii?Q?bkBzJsXMbbEX6v6UlzwrmGPrmy3C3K8DqUFs+DTqCRKao2Cu8TCGIJKSijzX?=
 =?us-ascii?Q?yPddPKDkBWzmbQCmt689BMfR53vsMoIw4cs+vmV3u1otTfwh6/VPUTQxX2D9?=
 =?us-ascii?Q?zCbRx33tU4Pg+U57v02GTvwUym6JDiErPpzbhV6OwCGiAmfPTRBhwaUAfeiv?=
 =?us-ascii?Q?oZ9zBSaYveCIeqpwAL5kHCLUDUxOctHNBbKUHc+RRMzuuwtlUftLJBF9QRCB?=
 =?us-ascii?Q?tNQ2d5dF52BuEyva2Gv/4Rlg+KaN3Rfh8ZoezTy97P0CGXdtpXOMIBmc5VtN?=
 =?us-ascii?Q?oHvThXibsN/BUq/W+vkCqzJe4+KNGjxI5aXTFnTa49qgvj94ve2AL2ivzznb?=
 =?us-ascii?Q?1erEJ5ISUhWBd0PqlUs/2bhK/8QZJmCv/AxmkuXC1f2DOKQpR3HZZUE60iiz?=
 =?us-ascii?Q?U3qhRwiTV85m43Jq7snUDBxzPUz47leDPd5JFINB4padnNSemK54bYRBVFvT?=
 =?us-ascii?Q?f132fZBVuKxMrgkmNylR6kqka5flHdJRRBZSaaaOwVD1amaae9r2GtctkjqE?=
 =?us-ascii?Q?ILNiYLJetu4FiYVQBHqtYTDi6y1+yku0lBpQ9bl1VZlAERHfOEVoUF7PtWa+?=
 =?us-ascii?Q?1q86cAmDYX9tisxl66LWWZNog0iODDTgvNdSjGU7BhtJz4l3+0g2dtbTgMW7?=
 =?us-ascii?Q?CTnwvfwMwrch6cPT1fE25NZ0O5wiYYBjHm56feZgmjWGMzHXiKfDR0BDdACG?=
 =?us-ascii?Q?knIXkka5D+bfj96xDQyi+w2XWgmZNtCfjDp5ms+I+zdSOc+IeVczw7T8HLQf?=
 =?us-ascii?Q?mm+Io4879hEyCZG9wDgbOqqTEWtZkq7opVp7kByqY7Yno98t5GFF1moj6PCp?=
 =?us-ascii?Q?BeWPC9SxYIPdv/q5hJnw0ru/i6qq0eLxvtYX1lj+iCCDeK10xJ+FfcnRZbvB?=
 =?us-ascii?Q?OwmWaSXpdF1SB9OFQ32Bk22WPhMVRypfBMBOpsJcFSrnEgToUvDRz2Cn5Klm?=
 =?us-ascii?Q?l2HpgSLANzLzqmm52x/oPtD2KkT6idqCYTCok14Fbtm5QHEE0rP7g2bqIHS+?=
 =?us-ascii?Q?QuPlYnmAg+4hTDmgpSweOhiy+jcK4rDJ3vAxJ6gs/PHqPNM5htrLI6n7O7uJ?=
 =?us-ascii?Q?R2M+vUEtAzTzPWcY7Ah9RHq3dB4iKkO18+Nx4zlWZDVG0Cxcyaeuu4JxFRIG?=
 =?us-ascii?Q?qQvlE/C8uFncrVZq1fs8VqggF98ylwXEO4d2HdFSG7nhqtwApU7+ifcJp0D7?=
 =?us-ascii?Q?i1h2cHqfWbVgeDT8LuyBEK0lR+hT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j3DsJtjPoOtmpcBAwgUSjEmb70dE3r2Dvggmk0VvRgA8acVpSDA9woKwQ4FD?=
 =?us-ascii?Q?ggQMgN0P4NcTxc/GGOpCtu/lcZybze6PUGqulZzI7DooqN1iqtOxmBX/yIc/?=
 =?us-ascii?Q?rRxAUH927YY3jth8gafWpw07bbUM8TN5t7jm0T990qAbb6BhYNNvxjAXUnVU?=
 =?us-ascii?Q?VQmHI/S01JCcYIaCwpoaaNolqaqlz4UVrAVEuy88Oz96sZDUIRbHySVyz94J?=
 =?us-ascii?Q?BfiVwJYgKsy91DQK81OPpe8YtBZYCXpLoRzCgAnZGq4RuF29CRt3mS28cRJ7?=
 =?us-ascii?Q?bMQPKPnEYYN/feJJHzk+LXYqGX0oes0yk9hgfP899jgdc0yyF+GupwhLo93/?=
 =?us-ascii?Q?T5k9tVJl2ro2hxRtH9odT6MgOCbJjiNqCyrOoQrmMu7edPNDIS8Pj7ioMhIm?=
 =?us-ascii?Q?kW7EhY+y3GYZdft8miro5SE3n0PBe1ZLlS5Ezikgg01j8aQOJRHGtHFqLpzY?=
 =?us-ascii?Q?MeiRmZspxgqVUk9rWLxoYVsHxF+MCj9fmGH06wviQs/ZNP6Jsto5y56kMZlY?=
 =?us-ascii?Q?X4EYn0cbxoLvj/4vI90e/Ti8UUxDeP5Vbhos75bf1l3mf8knCO88S6uSLGS0?=
 =?us-ascii?Q?yNrHICkIe+lRMe9R7LkwimzRjl4USHW/Od36TP3j97XzGjpv7PA8foMpLoxL?=
 =?us-ascii?Q?jIEEGPtZ+Xg0+FcQEZzXeLCyuzUecDiov6zr0NFRZjarPdww3UYsdGHptua4?=
 =?us-ascii?Q?IspbwEeujOSYK0oyp168DRuZ+k+k+u2Ae71JqnrUKmMBqBuIYoHhmRpXx8+d?=
 =?us-ascii?Q?633hpmrnT3TXPre4/uZzHE3PYMeeX+biYSR+uI33tUbLyAGFO/YyFy2+z1AT?=
 =?us-ascii?Q?kmER16iHm2WcOv6k9Jd+n4+AlUDQh5Qu004e2i7uiAKIYyJ53obWJq8/QqxC?=
 =?us-ascii?Q?bS2HBFYxfn2pTifH5TsWkyyrEiIEpZXSJCjxc9VfOUCkFQ103+jeI15VJmkr?=
 =?us-ascii?Q?T+E3CFq9tGn9PVgCuAYCQ6UAHLmaRd4Vwn++uFrHTgsmAnhyiBxkur3tArvG?=
 =?us-ascii?Q?QlB+IyAKVlb0HE5sVEfRr+MFCSiBVweaj+HffyAYCpYWB0KqqOdKlkMLBkBn?=
 =?us-ascii?Q?5xUgo9odkGcE8XxJpMmrqLP03UqYb4w5/zJTa1RXz5mT05qE8IaBCcNTODcP?=
 =?us-ascii?Q?LpS3L1L2nSvhdtvOx4EItEP1nF8j2F1mb0s/aq7NP0eZIlq7/vVEPYuxicmM?=
 =?us-ascii?Q?s96uj0Qsb4g8tVkOS0Jsg7ALeIKLus4RgY+COpku9FOk8cctqF4kAOyXyZJQ?=
 =?us-ascii?Q?0BmXFny9WplMCECmSMPkxY5f/cQ92KpOVIYnYA9EGsE7B/A1VCqRL5aAJDHQ?=
 =?us-ascii?Q?4ZZLS1B+pBL5MEEfcXAJRy3Kn/W2C6ij6SHj1XutjacQbgLnlHxctTytKBUh?=
 =?us-ascii?Q?0nwDm0V3IsXxOsF0xhSTt254JY8BKLq6Knf/nv3BswOP+0yjYrGNpyNvukWO?=
 =?us-ascii?Q?VV9jJTAaZbUzR0hrpBonbAox9Wem4HMs67z54FO+lmdDz9glhOStlOQpRRYn?=
 =?us-ascii?Q?8yDSCOp2xDr8K7waDSLkyVPoaffoyVAMBPW4DZpAxwTD+09kfw94XbXiJQGY?=
 =?us-ascii?Q?aw3gWqUpaE3rdf1inoDNJZ33QxRYUceUoNGU+RQA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61157bfd-1946-4986-ed23-08dd55e7a22b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:59:10.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0JDSgRhzlem0xH7XWq89oUYNsQeRD6p1jlLNRSQKOyKS6oIhvSNzq/WQAY/7jA+zTyho0vcyVIG3y33cgJwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351

On Fri, Feb 14, 2025 at 12:25:58AM +0100, Frederic Weisbecker wrote:
> A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> to order the context switch (or rather the accesses prior to
> rcu_read_unlock()) with the expedited grace period fastpath.
> 
> However the grace period can not complete without the rnp calling into
> rcu_report_exp_rnp() with the node locked. This reports the quiescent
> state in a fully ordered fashion against updater's accesses thanks to:
> 
> 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
>    locking while propagating QS up to the root.
> 
> 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
>    the root rnp to wait/check for the GP completion.
> 
> 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
>    before the grace period completes.
> 
> This makes the explicit barrier in this place superflous. Therefore
> remove it as it is confusing.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_plugin.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..d51cc7a5dfc7 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
>  			     (!empty_norm || rnp->qsmask));
>  		empty_exp = sync_rcu_exp_done(rnp);
> -		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */

I was wondering though, this is a slow path and the smp_mb() has been there
since 2009 or so. Not sure if it is super valuable to remove it at this
point. But we/I should definitely understand it.

I was wondering if you could also point to the fastpath that this is racing
with, it is not immediately clear (to me) what this smp_mb() is pairing with :(

thanks,

 - Joel





>  		np = rcu_next_node_entry(t, rnp);
>  		list_del_init(&t->rcu_node_entry);
>  		t->rcu_blocked_node = NULL;
> -- 
> 2.46.0
> 

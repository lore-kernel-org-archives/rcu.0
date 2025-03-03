Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21A5661;
	Mon,  3 Mar 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961038; cv=fail; b=o0ecM6naFSu9GPhYlHJbayX5GoxInYCW9S++5b7YzgrE5zz5kjlH7aL8S18kJFjisuNnJp5Vg5/v+e2eZNynUcmiMFWRTqqsgANjobZRfvMgggMHpW3LOlSTh2HW/X2qFXnCyd2ogAUd5nV88f6uGBEO4ltz6SPfmgajYJEZOOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961038; c=relaxed/simple;
	bh=j2/G8Cg/A1mOV7Z7EZWX3aX0HQt/V/5XULr8mhWsQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2XbwN3XnTEd38zFTB5D80QF5BC7EkTaj5Mvagmi9vUfQOfHfBLcH4B9GEv49lb4gUQRPS3ezNk4WT+O0C6MpmC6Lov+mU3y4C/rPDMjy7vkkYZ9/NYsMfov78XxPlaP+6QyzMm8hcV7RJPvuCLmlJW197XBOR0HkUPbXiI6TWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BqIRS6RE; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BqIRS6RE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGwqwkCL7EbpkN6PMran7Q3cB5azCgF9f9i0zIjz88fxE7I/yWO48o4zGzCgunvkMjSixDKIXr3aGn2HVee5nkuyg56YdH7Vnl1MfDBtkGZ2qs0P4mnny2yW/khGxFMJLer2vC/Lia6jBJD/STw7QSc4EVkKUriqbDE7/TXQk1zhJjdP2D+1XRKaNDWYLYN3yeF8KrYjHjyw9OFMyy9mIJnxCyfHJpK0iuoTitRGTX3R0Pz+ByozhEi2jGP51Xg+jTAt7SIFtETMwNNZ4DZd/q4Pqg6L3+Y0RwBV1QY0lGEEitgBRCLwAdYiDcYhgvPA36wPbI4fbJHzh4gRWZn8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeyuQS+/ZfpKBRbyJHxo7E1mabF3YRxb9v0dcoLwUsY=;
 b=DzCKyZKmnJx0sB6FRBmt2YgxHWJcDDQcWnTXbx6PZvzESnnfXyPONzu8sPnJDSloWhwavhi4g8Pkr12J9ZspBjtpJsxT1GYFsHx8M/pUE5oa21zJPhMZ+kGQtNOJSmJmZttQrcJ2B0diANJH2ywXKFCTYDjVF3nIoS7grhvqdDNGUZXn6ndclzguq0/4YO33JVtmVVOKPq6eak46x1krnopKSN/Qv1DDoVeAYRBVjSoBoiaLQXHrS/GlaK63zK19kuVb/WWp4kohkt8HYvLmIFqDu7LqJJrDZCqR/ex0VB/jXY5Ns2ACpcKgq9CX+A1EkMFr/shE3IZCKjLPUd3HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeyuQS+/ZfpKBRbyJHxo7E1mabF3YRxb9v0dcoLwUsY=;
 b=BqIRS6REL0l5T/I/tMXqRY5BzjInQU/eIwGevxEGsXAB1QMc7+hcHaMpIcsys8c9EQDN2fRKrOfRgKM+oTSFjlB1eqkZf17Q2OIHLX/ieIdyypGRAAP2BgJhziFurv+CZNLlXAWBVK6lZb++qps9qwAvk7zx8u/pkjMtxRa9Yo4SOXSd7NVkip75/GKrads49pfQramoroL1JNxz+PcZz5a3R7L8EXe5PQYQBYotgwl+FAj0rEy232avPXnglfPbWxU1H2jns7+0khOWttFO/2+uKMKEcMaPD4SFOG4GuOv7HyFKc2A2V4Q1ZJVqoo23w/TIUPROb//oAkt3GZeXgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 00:17:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 00:17:11 +0000
Date: Sun, 2 Mar 2025 19:17:10 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <20250303001710.GA3997787@joelnvbox>
References: <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303001507.GA3994772@joelnvbox>
X-ClientProxiedBy: BL1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:256::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2acdf5-5d58-46a7-b074-08dd59e8be5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uuwspHCCJh2tgZuGoi7QP/CpOlREkIpQnGP7rSd2FV/JguR8j8VG7wldaC6P?=
 =?us-ascii?Q?B6/BCoSeFMC8hEIaEta6jM/bu9nbi25cdhlbsjiQACOdE1IAfh3KE6fkRmVh?=
 =?us-ascii?Q?xnuIgnZVhWpD6yf6sL/9QzRwrEfdv2dVMpIO+LE3tCgFWQeEPILLnBzSRbfk?=
 =?us-ascii?Q?onpuL5T1Tke3GQ0gfWV09Y1AKYl0UIUpr+/DKFh8KUrbYQYCVOmjhwrQsfuq?=
 =?us-ascii?Q?PV5EW7I1tMUU1Q3bEI4wTxulNbtBeL7KrfwqTJh2SnO90O4G4Upm92bItK9/?=
 =?us-ascii?Q?f64QvK7IZcbOQsWUhY+aodfxWTfBzluzMoLTabpfjj+9/NIXqRjKT6gj41Cb?=
 =?us-ascii?Q?gZ0QkTdYSTFTiRfga1klLixKpIizjAQATMDQJFHJ88rv4RQTIb5ZfSICJ35R?=
 =?us-ascii?Q?QO6x+LdA3X5aPhyE8PiQ0Hwp+ca+vx7DDdoRWMInfcynOMtLOXeDu5d2WUbn?=
 =?us-ascii?Q?8vPFiy7VEpPH3mucYer2tV4rXs6T/yx4wL2Dz+snnqHJPLAD3Y2QKvqiuFB8?=
 =?us-ascii?Q?v3BRZW2In2T274R7oXnGXFs0L6uq3njGmMtrEUH6x0o66nflusuDVCyX/2gn?=
 =?us-ascii?Q?KTu2qCylNCxNoGEy8uDTXKn6iKMzT2MmV2JVdIwmP/GZM0CXn/f64lFMTwxo?=
 =?us-ascii?Q?y48QvONdNeuVGQ94h4ktLRF3DM7SVzPu9yMZ4RtvIIbm6JznTU0juTPfWp2i?=
 =?us-ascii?Q?8dSAuWBZEoQL6uuPEwBjQ5CIUTsZ2x8tZ4e2MnXYtcfqa/hEQILCfBmKUCCZ?=
 =?us-ascii?Q?qiWv5B63dwRj7TOaZ0NeYhK/oh9o3nauYTAaHK8bO3zIFx8QNHo8DYmHWX2b?=
 =?us-ascii?Q?lhVp8NuzSJcHVSVJEkrITgosSqx1vurcQ7dROIQboLmN4xOtseXqNBHZ6bbT?=
 =?us-ascii?Q?Ow3F1N5jeuPR/C5JUqDiEYgcxvZ7JqM+Dh9Rsbwoql70Z9MKk8li3IPkziAT?=
 =?us-ascii?Q?bgZ+OVRp+r6YSsmQasNh6xTOxCg2ytI0bqwI1w1yDPMBdNThh0XYsqRBP6zT?=
 =?us-ascii?Q?XbUc8dSd94N69Q6CHKPTTawdiua5eVy7kmKynzMNGe5m+q77Kyo/gw4vijCS?=
 =?us-ascii?Q?8ACGu92m5K488s5sj/I5jGxcxkzE3TXfmIiKvGEUf/aj4avNKnV2gms/CSaO?=
 =?us-ascii?Q?cUu9No4Yz40zZjf+On60Nj7x6VMQ2Zlni5wbNSf0LWL9p5NAN5ffhUZYcqLb?=
 =?us-ascii?Q?Y7qmxCyk4npa1HyKaDLmTmt8uhq7W7prC94ovRmR4UyMYzBdk/zU6QPDxe2p?=
 =?us-ascii?Q?TLG22c241VHF+ZsEkSKPleJBOHmviAY0CwwuvGfIZMH7SvLebvBc8GAbvo8y?=
 =?us-ascii?Q?YsPmHD9eN5BmsekEvVdvGynIA9KsZGAr2ej8H+40vr7+fmDukV5X7HUiN0xx?=
 =?us-ascii?Q?Hl/TP0aiUSlSNV1bLgJmpEVPKMLN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sj777zcxElX5BXFmS5sxvgNwyaLJd9HDJAM6MbSLKkn5YQL9c9+taMNypAAG?=
 =?us-ascii?Q?x6hH3MajrblDfd4AAZDFwklkP2jPQrBphBzte/vC4fOhU4OsFkik6EWxKBaY?=
 =?us-ascii?Q?PMfQZZ3x+idiRJKCWPpuMveked5qHXzyuPd8YupT9OVXPQMMcMe3k9hLL9i8?=
 =?us-ascii?Q?ixRau4UKg0GtskYekF8pydHmeNOWtqVg1e+irstRHsMH+7SsPzjrSvyGxeLv?=
 =?us-ascii?Q?Nmuf2ywYJt+CddanRqlun5LCa4+R5oiCh9xMn/g0GKQH+RTZGcBCdA+8VU1A?=
 =?us-ascii?Q?0lBArlX9kJixg//6+0a0QO9M/ihgrjCAo9JeeD8YBq+lVTvBv8Jvo/H5Btau?=
 =?us-ascii?Q?m662ywXDwQ9MmIn5OViNX+fZYgwQe25idajRgw/95ZOIZKKVp/1pQNSPX3m9?=
 =?us-ascii?Q?kSiQ7zMeE+2WpmPbWdhXgeSvEq2+CypXEpf1JddyEajMTp8YwUx3JZWp+QdT?=
 =?us-ascii?Q?QtZIp864v90GOKKwgsI4NeDawjixOqYtSAnVegdFKcHUxeH0ZDEFoyK1DrEo?=
 =?us-ascii?Q?DYbXd/NuNnHdbrc8AcB53iGhznnKeI2s64l++Puyd/sbUVUyVEGAYjbAFhKB?=
 =?us-ascii?Q?IOtU0WLuHSE6dIO8DuJARmBfeRYaSq4TSKzrLkWPbQP4rIltYvdv2kpntDaA?=
 =?us-ascii?Q?g6iIBcoegHZmh/SXn4jjnv/R0bbXocdQmGK2SjKk5mbpzYHFYXf2JBb7Fj8V?=
 =?us-ascii?Q?jhYzJbn8wnteolIz7RdBgANsm1yqEnxazUoYgRpQzz0EIlGUhHoNjFR7Mqem?=
 =?us-ascii?Q?IocSfvK5eyBKziBeNRiFlAhXWgb92MrXwrNTR0z4rX74/MCw07FAmQ5nB3bY?=
 =?us-ascii?Q?0uwI29OJsOElYG3DQC6cPlg5/aOy9xOrrUKchm0bnRa/u9EyTzKzeCQ/fZIE?=
 =?us-ascii?Q?cS9ZbLqQLdvY/Q28B+qTPy0SbEO45BSwGuxcUzspaVQ0DWzOObBjm/4tuobA?=
 =?us-ascii?Q?6xuIJ3VWiggPh7fU/SqE01eMzTiLCdd9MKuyZ1SnOKaj2tY1BQQ/EmGPYGKm?=
 =?us-ascii?Q?bNK0UPFERAKEHwi3Wx3l55isnUBtoMrf8KeGlA5YeKccE2p9rtFEmZnOAqt+?=
 =?us-ascii?Q?tJleVkPy12ijbf8It2U8K3OiG+yQa1JPJhtvdMxcod7gP/FkOqip4by+VOpi?=
 =?us-ascii?Q?ntPbkCM25z2nPc0NZVzQEKseVeW2mwa1u5+9OgjpXBylJHel0LZ4AxQyu5wk?=
 =?us-ascii?Q?j+t7X2XQ1hbvV68Cz5LhGqyA4ICKSnnRZlm5G/WlmrGY0A3B6bKwUQ6XRu+7?=
 =?us-ascii?Q?As43kZ9LGxYzxAfvBWyCsQ379KCBQ0bTCay4cZU+mvnXxK3aPw8eJVGVOCX+?=
 =?us-ascii?Q?Zmbx4haNsHwYJEMOJWuz/QU2LCU4gMFVsMo+lBbNvlt2KlDNjUgtXPuv3EI+?=
 =?us-ascii?Q?MVhZ77SXgXrrZnelX9fYrCTw3ul5rbFVofSJPAex+jTq7iphMCc3odh0SQRK?=
 =?us-ascii?Q?y62uwWA6myIr/4lbk8ExzlMwXFCFXgekBqXrTJK7dGC6wibSx4UBCflJK2Dx?=
 =?us-ascii?Q?JXz2/+p9LVixYRoYiynf0DKDD1/qcfBj7doO+o4e3AZfxquUC91XjUCTLqIm?=
 =?us-ascii?Q?uNOeS38b4xHa0JGuamxfs9m+uHa/VYqSdhyUTpM1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2acdf5-5d58-46a7-b074-08dd59e8be5b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 00:17:11.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG9/a+EHX/DcqKoNf5PAeri6ALmq4vzbnAxmMYM2qCDgbJmj61a8NVluCLZI8YpYDqSwZf7j4e1kOya+L/INOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

On Sun, Mar 02, 2025 at 07:15:07PM -0500, Joel Fernandes wrote:
> On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Paul!
> > > > 
> > > > > > > > > 
> > > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > > RCU tree:
> > > > > > > > > 
> > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > > 
> > > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > > 
> > > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > > 
> > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > > 
> > > > > > I can trigger it. But.
> > > > > > 
> > > > > > Some background. I tested those patches during many hours on the stable
> > > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > > right away.
> > > > > 
> > > > > Bisection?  (Hey, you knew that was coming!)
> > > > > 
> > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > > 
> > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > > 
> > > Huh.  We sure don't get to revert that one...
> > > 
> > > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > > do we need to capture the relevant portion of the list before the call
> > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> > 
> > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > Which does not necessarily mean that this is the correct fix, but I
> > figured that it might at least provide food for thought.
> > 
> >                                           Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 48384fa2eaeb8..d3efeff7740e7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  
> >        /* Advance to a new grace period and initialize state. */
> >        record_gp_stall_check_time();
> > +      start_new_poll = rcu_sr_normal_gp_init();
> >        /* Record GP times before starting GP, hence rcu_seq_start(). */
> >        rcu_seq_start(&rcu_state.gp_seq);
> >        ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > -      start_new_poll = rcu_sr_normal_gp_init();
> >        trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> 
> Oh... so the bug is this? Good catch...
> 
> 
> CPU 0                                           CPU 1
> 
>                                                 rcu_gp_init()
>                                                       rcu_seq_start(rcu_state.gp_seq)
> sychronize_rcu_normal()
>       rs.head.func
>       	= (void *) get_state_synchronize_rcu();
>                    // save rcu_state.gp_seq
>       rcu_sr_normal_add_req() ->
>             llist_add(rcu_state.srs_next)
>       (void) start_poll_synchronize_rcu();
> 
> 
>                                                       sr_normal_gp_init()
>                                                             llist_add(wait_head, &rcu_state.srs_next);
> 							    // pick up the
> 							    // injected WH
>                                                             rcu_state.srs_wait_tail = wait_head;
> 
>                                                 rcu_gp_cleanup()
>                                                       rcu_seq_end(&rcu_state.gp_seq);
>                                                       sr_normal_complete()
>                                                             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
>                                                             !poll_state_synchronize_rcu(oldstate),
> 
> Where as reordering sr_normal_gp_init() prevents this:
> 
>                                                 rcu_gp_init()
> 
>                                                       sr_normal_gp_init()
> 							    // WH has not
> 							    // been injected
> 							    // so nothing to
> 							    // wait on
> 
>                                                       rcu_seq_start(rcu_state.gp_seq)
> sychronize_rcu_normal()
>       rs.head.func
>       	= (void *) get_state_synchronize_rcu();
>                    // save rcu_state.gp_seq
>       rcu_sr_normal_add_req() ->
>             llist_add(rcu_state.srs_next)
>       (void) start_poll_synchronize_rcu();
> 
>                                                 rcu_gp_cleanup()
>                                                       rcu_seq_end(&rcu_state.gp_seq);
>                                                       // sr_normal_complete()
> 						      // wont do anything so
> 						      // no warning
> 
> Did I get that right?
> 
> I think this is a real bug AFAICS, hoping all the memory barriers are in
> place to make sure the code reordering also correctly orders the accesses.
> I'll double check that.
> 
> I also feel its 'theoretical', because as long as rcu_gp_init() and
> rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> synchronize_rcu_normal() still waits for pre-existing readers even though its
> a bit confused about the value of the cookies.
> 
> For the fix,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Oops, this should be:

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

;-)

thanks,

 - Joel

> 
> (If possible, include a Link: to my (this) post so that the sequence of
> events is further clarified.)
> 
> thanks,
> 
>  - Joel
> 

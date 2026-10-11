Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA71A9F96;
	Sun, 11 Oct 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678017; cv=fail; b=XMOBBMpKm2PpiYG+dWJkfXIZy73v5X23jzaGGAT+llZ/g6ZtMvSt893N/gbXj3nd/Jf3DIqXGXMlovgdVdFe7qL15rsr7NfLxN1MqWQ9BGUNXqE+QMP/ZabpfbkqTD8KzixuvawI7+5Q5qj1s1nYEVE/9C0N4d4xdNW+f83Y8Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678017; c=relaxed/simple;
	bh=JNz3FmxR8Dhn3ZeMSs2hHOMnYiHe+UciB/zOJqprReA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5StoQc7I8KRXvb1BG6swuEBDpSFWAgra+ROaAbZCPgn1cWy9ZaUfyKgK1QNrtg88t9JepNFrWsT28t9ZgDyOlXXkuUNJ7rrUFsfSTs8TS63UutlIi6swDor9oD5UZRRDprji4XwSLkzS3HVpWYsYKa/z42B+UqhpNpbOqhIcI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQimtYtK; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQimtYtK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA33EOUeXGAdUkxk7Dx2WR+uuK6yfFOTaaULsDrbtLOG0iNrB1iUuDWJMseA6qMmoTVyI0f1QnomvC6cklsw3hChXCOK4yHdYfft2Ox3En68ODTtcL8xJcvYgny/jpxo3jEOt25AHORL9wz+n6BlBYiP6JvrD093W2rhHJf8bsDrKQgYU3xFecAl7KB1CG+iXJ8RojRbf3yfoGzLOE702MsyeMvP03Yed0gfdlcU6rOG/s6e2Sev2t/Qixp+TyaZwEKnDflHw6TGgASs89BsrPuMz8ZZJ0BCRv8Ztab6Cs5ZqKZpOphslgngzn3PYVm7Iw8l+ANMm1FCUwFfI6ACTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRW53ZzfHNBGh2Lb9u8d228Pp9P70bk2fdcuGS9ixdE=;
 b=wTMhfcgDXF8iI+/wYWBuJOF3x0JShcYYmZr3iD1OY5Y6QplS0lm3SaQ52EDIrStNbJHEbFvPhiry2E2xRWkjVKjoK0hU15MNjTWOPEqz4eaQojyK1MBUrpX1aI2xUKvY9lpLWZ6jTcqjRRVQFVh9wXBG3cvlCxeAQ4zbbRILCsCPN5HpfWB8jVJNZrAhCC8usiu5rSkUNrETaJWRY6lUvA6oivk3oquUlzB1LeWK1hEv2i+oBwyj1vLLyLyvdQ11fKN9wGY/Sb+KR2WP0YyXoA7HaqRJFwq8bGBrPQsIqc7BBWb3wdxQ2Pu1hCqVFSHKQhPkPz8PS6rSPpL8ptqEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRW53ZzfHNBGh2Lb9u8d228Pp9P70bk2fdcuGS9ixdE=;
 b=DQimtYtKhyIV0BcdQca0jzw3d64IbJ2tmzfPmfqqRY5OiS5avBIO+8hTNiNJKwHVr9dGqwCYz1EFk+1E8nAIArhNekK8fsEkt+hVUAeZJQAIKsUkPfTL7SLlCVSA0J+QMj3gMPZJf7pI/XHbBt1SQ/PLxtQJZmMLAjbfDR5lQe62y/py3MklCLNEdaLQHyzMczp30AHqFTTIEV6esJoZbWW2ZDjfXTLqwKPMTN4hsxTwA+g5wOeob455+uFx5Nt9aV0t80heegcbeVNJudJ+ogfFfzJkSAg9GptiWuS5v4y5BElzllC7XCrtuap0xmnnSXop9+BHdmfcAOuzDaPemQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sun, 11 Oct
 2026 00:20:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 00:20:09 +0000
Date: Sat, 10 Oct 2026 20:20:06 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, boqun@kernel.org, kunwu.chan@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
Message-ID: <20261011002006.GA2604508@joelbox>
References: <20261010083107.15086-1-qiang.zhang@linux.dev>
 <FCDF3652-74F1-4EA4-B39E-3F74F1EAF5B5@nvidia.com>
 <88e9dca361959a297f854200cba0c5c80d26877a@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e9dca361959a297f854200cba0c5c80d26877a@linux.dev>
X-ClientProxiedBy: BN0PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:408:ed::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: af29d2e7-1e2c-4c45-d099-08df272d68b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0uA83HVP99cawz/70gAcmQAZplZdk4Rv1GHT7KggCHaVl3Mww5iH28ZUHmxYgrKr9M2LR3q5GPQ9uauTMrha04mpSS3KbSRMYR23ZuKv0x77dKoKC1AtzMBm+UZd75Wzb9AecvxBFp2EGip5t0Cn/z/UB1hFUgTDXXOf3GlJk/ijTcKFs5BqPI/oE4hb8waRNwB8evj4JeUvCb2OLlmJEtL+uNdn8UHxDj40xlLMV4+LEI2uWUZw8279T52iZkMbW6zO0sjhkGMHPtXZKo79FuyAVT0ycP43MufZUm11edReNYPB4GNp3h9Hkw+veGfY7qY38UEsg27/UaUgxm3qEh+YQViYiIgz6pcFB7AAWVjzvW4mL/rvLyYLwG7URV14bMOWtx/l5VJ59BYxLcuW/nCWvIR+91wt/pJSK0kgtwchM4SGRoF1OWKuAJLRX4+KLev/gKJQFfm2jnxCXQw5SQXcMVDpskU3h7Hjerlz4XLd7IabmupcvLEQuDk9+SVp9aPccNO1y+NxfeHBzx2VpJteqfL0YFwax0EewbE+gXIoJLzF/nToh8PIotWQVV+u35QIemAIIi7peSAMw8X0zIVMrDyFdrzu0xpdVf2G6zQVtposcssBPlVgvj4Yi2ECQknDRAW60osSYVnHMQT7PK5LByMQ0pfu8XAbkD2ZxfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KWa2O9b0+iuZJfQiJ+78H/Vgp2dqZZpGVjhu1ceuGWQioOuewqle9JbVcZ1?=
 =?us-ascii?Q?+sR26i+Mg6O4mfDxNiEXzI2PfLwAjND+IIjTRBRZvD57vA9YBecrAH9M+0GG?=
 =?us-ascii?Q?VDHj2EmkDj3b7enebSMPjObkECJHGn2GL0Tf86VMnAr2h6e5cXHMAykv99yw?=
 =?us-ascii?Q?5JEIqYGSumrs/8RKIaFW9q8HhZ8Wpcg7pi13XMFCmPSGbertWFGU28HyNJxW?=
 =?us-ascii?Q?qK0J1H+BlICIr+gky46douNKA7VIIrpF9c+v4nuRh6bietffBHHsrLBMDyTx?=
 =?us-ascii?Q?U6/5tnHxb5ksnZaMje8UDmb1uA+cxpLGRzHF9KFUcOB7Ot2aBZtAgqBdotQR?=
 =?us-ascii?Q?Zt0mPlLubx178EbrHQBZct2VOJPJ9utBcUnp+30dU0kgVRfNA7KE5sLt1Wzu?=
 =?us-ascii?Q?E6dScVhGu5ExJSgV9FjB0h5IQUXwemIK9TiCzvX09DtoX3w2STouEKgCoUJ+?=
 =?us-ascii?Q?Gww7KVTjf90L4d0Z5M5B7PekbMQMkIXO2+kXaCKVcjzNtGsCri88aitQpkEJ?=
 =?us-ascii?Q?tGe6tccwP09cU1BHWu5sAQa8kI2Q0ZJFnYrHMxjt8nanuIX9skbum4YD+o6G?=
 =?us-ascii?Q?Gw0qTDgaaFuiaLlSODHU+9/LJ+TefrBYUgp2r19DTCMBpd/LaWsPND/dqJ+H?=
 =?us-ascii?Q?p1Q9KEtPr9e+9pIlyq1AZefdPydqhxq6ukPxU3Vaiv7EcVbxW95SulPr+dyb?=
 =?us-ascii?Q?nw8+qNe807FYAPxqYHrzst7PScxumOMy3rJL333eSGBI9graR/4teVTmlBx3?=
 =?us-ascii?Q?VkcdRm6G7xR8KjqpJ8Cw0OqPe8vD1VCFPkLCA3AnMYN4vP3Q4R7dzxw3Yhmy?=
 =?us-ascii?Q?u9MiVQFxKZyGuAU/06WxvleBUfQmazFoej3Sa/G0sOPdut8mnKa5E8no7en+?=
 =?us-ascii?Q?PATjGFhiFefIPXvK/HCj6IZ3VXdiBFJ6gtEscN1rNr7ewZ9Kg8cQ0q0PlDn6?=
 =?us-ascii?Q?SOdTdQaz5pg8RvjjJqSwh97/8TPaluNSYKx+cOIljE6Xdj0ej1YWHgNpHIo5?=
 =?us-ascii?Q?fdfmosL0eMtyhZlr9vcUNXCVio7yD75bzNVrL/AzJcsPyze0MVmOkjXno/RF?=
 =?us-ascii?Q?6+V+KTN6vkvQvE4OkKjdZxomrUo1KDBlR2aHd8ZHOFcyOhRe4HlmabN4v8C9?=
 =?us-ascii?Q?FD+8KT/7J8nHQqDLJumhi5WG7hNLW/dXJo5jzkrpwUDQZ4WNeEejrMeVW0SQ?=
 =?us-ascii?Q?AfZvHejsdWc2X/mfDflmsI2maeaPOj75gCsxzg3QOrT3vYf+RBCQ5/svSQ9r?=
 =?us-ascii?Q?4oIz0S/meEtnRzk6L53cZyV/B+/4XvnmX9gYEZpnLRFwdTFYcJWQfds1n/lU?=
 =?us-ascii?Q?fBpCbeEHys/8eB0EtEh/CHB919CuIg9vHYpEQcDYmxjzVhGmtYlDoVmYJlnr?=
 =?us-ascii?Q?vCbi+U3HiTq3GSrlAoEQCNzSq5PpYMg4azX1F+hjlP9xVF/y1NW7nAHrI1sM?=
 =?us-ascii?Q?aug6sruq8gXpW9AET/ERRQV/ipOO3KaWTpIsZHKi1XGQRiEJwUDkNWxllbno?=
 =?us-ascii?Q?fT42a6zvAZvZGKwLHIYp8sG5mjqGnusP3mmdBsTEbDCCO7A17vjFznnlddHb?=
 =?us-ascii?Q?EQWKQhuAzTLrTMvLiM2l5KJ/0DkWZLO/o0ZwI+gYmOxgsAPprdNB0/dzWFpS?=
 =?us-ascii?Q?fOBkbWLo+q4AdE3w5K3lp0BMe/TvIvbQb1d+tIZZc38mM3jNlyj/sylcIdDO?=
 =?us-ascii?Q?thpTb9R4rm1RItgBfCuYATjSqpVb+24nH/IcScmgBaNV5HvVAAl1ErZg4wgT?=
 =?us-ascii?Q?djOuR31Z8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af29d2e7-1e2c-4c45-d099-08df272d68b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 00:20:09.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dlgGZW8cS2Oe04+HAbL34MDQdq0quKCTeDbV/fp7fgGgjPKugY6e6HARaoiU1qKu0Er+wDZ2tZazBEBWwwOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597

On Sat, Oct 10, 2026 at 12:17:31PM +0000, Zqiang wrote:
> > 
> > > 
> > > On Oct 10, 2026, at 4:31 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> > >  
> > >  The following commit introduces some new APIs:
> > >  
> > >  commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> > >  commit '8df13f01608e ("rcu: Add full-sized polling for cond_sync_exp_full()")'
> > >  commit 'd96c52fe4907 (rcu: Add polled expedited grace-period primitives)'
> > >  
> > >  synchronize_srcu_atomic(), cond_synchronize_rcu_expedited() and
> > >  cond_synchronize_rcu_expedited_full().
> > >  
> > >  Sample output when running rcutorture:
> > >  
> > >  @counts[synchronize_srcu]: 48
> > >  @counts[synchronize_rcu_expedited]: 74
> > >  @counts[synchronize_rcu]: 102
> > >  @counts[poll_state_synchronize_rcu_full]: 443
> > >  @counts[call_rcu]: 2498
> > >  @counts[synchronize_srcu_atomic]: 8717
> > >  @counts[poll_state_synchronize_srcu]: 14849
> > >  
> > >  @counts[call_srcu]: 22
> > >  @counts[synchronize_rcu]: 103
> > >  @counts[start_poll_synchronize_rcu]: 1093
> > >  @counts[cond_synchronize_rcu_expedited]: 5339
> > >  @counts[cond_synchronize_rcu_expedited_full]: 5375
> > >  @counts[synchronize_rcu_expedited]: 8134
> > >  @counts[get_state_synchronize_rcu_full]: 17248
> > >  @counts[get_state_synchronize_rcu]: 17266
> > >  @counts[call_rcu]: 119168
> > >  
> > >  This commit therefore add thems to rcu-updaters.sh script.
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > >  ---
> > > 
> > Nice, Thanks!, Could you update the documentation too and include in this series?
> 
> Hi, Joel
> 
> I have already send patch for the Doc API update separately.
> 

Yep, I see it now.

Applying this and other one for 7.5.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

Joel Fernandes



> Thanks
> Zqiang
> 
> > 
> > > 
> > > tools/rcu/rcu-updaters.sh | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >  
> > >  diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
> > >  index 8a5df3f22550..a0f03a144f6a 100755
> > >  --- a/tools/rcu/rcu-updaters.sh
> > >  +++ b/tools/rcu/rcu-updaters.sh
> > >  @@ -34,6 +34,7 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
> > >  kprobe:synchronize_rcu_tasks_trace,
> > >  kprobe:synchronize_srcu,
> > >  kprobe:synchronize_srcu_expedited,
> > >  + kprobe:synchronize_srcu_atomic,
> > >  kprobe:get_state_synchronize_rcu,
> > >  kprobe:get_state_synchronize_rcu_full,
> > >  kprobe:start_poll_synchronize_rcu,
> > >  @@ -44,6 +45,8 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
> > >  kprobe:poll_state_synchronize_rcu_full,
> > >  kprobe:cond_synchronize_rcu,
> > >  kprobe:cond_synchronize_rcu_full,
> > >  + kprobe:cond_synchronize_rcu_expedited,
> > >  + kprobe:cond_synchronize_rcu_expedited_full,
> > >  kprobe:start_poll_synchronize_srcu,
> > >  kprobe:poll_state_synchronize_srcu,
> > >  kprobe:rcu_gp_init
> > > 
> > Ack on this patch.
> > 
> > > 
> > > --
> > >  2.17.1
> > >
> >

Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A874C97;
	Tue, 30 Dec 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136758; cv=fail; b=jEzi5kySk92ZIpP6wjZokS+T6QPAlB06f6DgvgoNXP588UaUd3bVGlUTJk84IXP/k+b4exynKUPryJUOFv6mEXikCvJHsyX/EhX8wCFj2VUJhhoz7su9078mJQwkOMWO+3XDTi8bJmo4kOvn5EswNZrwh3YCvZttwmhH+9Qrl20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136758; c=relaxed/simple;
	bh=GCKTEg8gZUFa0oMel4kk0FPLx894l0yAEvvxo8qLeU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUCVNkm3KC/0P5plvbvxJzuxRTLtStlIS0nskrlBCqRPoUwiDxORdkjlLGSKY8zJr/SXMP9h0n+gFqEZvMmlaGcLCiSvT6cBy5fK0Lr3RDU6Wk85gXPv/1Fp6lWmYybmMRgWpJej4KTRWRpfdTY1wddKxWVnchsQUFCSX0Ooxkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0iHKLEW; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0iHKLEW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkfwcktXRjfrfXo62a8h+rZXoJqLFxU9Uz+Ld9gsKZwqE4AfwUHa60LCVIdNdqJhuK0X2gNTUpNEhMJacj8fwsO8wVuK0Ji7X62zv3Q3tWDe4mns1oYM4neOdFsHODXZtpHT3ARO2y98JwdhmtH3i9xq+/4MLUSOaqo7+E/qNK5JoO+ejCKAWbJrEBsvLk7n8Zj8/U8/b0IFzUfBJykNdamtKhZ3+rmDkuUX/yC9Aa9xHwBXN5rhLokho9y1RDQ+DE+pGo6RHQjS/tGiiwjF43QZsua4K9u/W7912mQI0llL8j7iVDqIELzZfuEW6owS9TmXoo34BrUzBpd2uAR52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hfVQTTqoHx2A9UvniK0JsuIhD+0fSH46Drahll9Zdo=;
 b=wseU99NoNxacSS9kpaIFkIX9BF/jCBYHR6UneimTqbCPAMvjf/PP0rHJ3Kmp30vAjFgCfHidavA1UjS5kZhJkrvrqoynwxduBMogOH5TxJkMrV9NrbvFcDLgmyLrDcJU+IASzEakwKTe5OJ6Uw6NhW6D4P1mXXM03V37WZBk5Hbf2YlfKXwrfNe1C9vv/cQP31vkLPoH0zXuyvhrEz+KrFRNTMxMqMFLRJ02jQaIIcCxlbdjX5iCQOTKHLvAPWPwzHxjLy5xYWFtTYzkFbxJSf+cVXMeF7ukgfGyVozQuultYPpQcZ80AAKANyL+G6K+TlzLLu6m4vmC5cvfX/slGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hfVQTTqoHx2A9UvniK0JsuIhD+0fSH46Drahll9Zdo=;
 b=c0iHKLEWdkDwHul+BHFo060NcSbiYiomjmeJN/YSeCxJVT4ynF3r6NzjgSej01/sw8XOpDrPhxKrco1Tn7rK5eN8x7J+xElSv1cAdDVaaVD8V6T77r+2rj70wRV7GwQGCFBiizJF9MpKFKYdbPL9jar7ZPzhEWfb7hKFBWZ3HusfjlFMnGf2V4X01E8jGhwwMMZKNGqjU8fL98Af+CgivDLQ8pSJ7a9Dde4JIx6p2jhpSf+D17IMDbXxzZVvQJlVu1KgcuLLNrWskXuWW2Z8D7v7ztstWw8eyT8BceOwvqRGNa7T/RztodKlTsEvVDD4rffPJASnxk4ZldqqnLqtzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 23:19:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 23:19:13 +0000
Date: Tue, 30 Dec 2025 18:19:11 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v4 0/9] Implement RCU Tasks Trace in terms of SRCU for
 post-v4.19
Message-ID: <20251230231911.GA2605197@joelbox2>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
X-ClientProxiedBy: BL0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:91::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ab9e98-0603-46ef-1b16-08de47f9d80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4meo0FsohAZqFvyaLm/15vuM+s167IKJWKOpIdH/6AVkXzXD+zX6JtP+b+x?=
 =?us-ascii?Q?7lKzngvcZ1nYiO0c2FXJ8lHGXK8Dyt4++zfwKi8E7aNScwYgJMEWkeJcgSIe?=
 =?us-ascii?Q?zJJUYFaN7xf694J1i6HNtyKo0Yuui32qWGD5EHo8LTT5p7R2Va/OfZOPSILk?=
 =?us-ascii?Q?xa9DJ07zSgsyYYZ7c6G9SeSLvnE21TDfcidjzI2kodiSLVVUg2spM7n4GCed?=
 =?us-ascii?Q?UJw+H2MdDW9qcKzi5DLObs7tmOV45FNLjO8OxKJSNhTNgGiJaMuv1skGR311?=
 =?us-ascii?Q?cGl7cHQvEbMg+2KHyRQ4Y3ozAbzWUynRt+Hoo0ecNMLi4bhXgHKjM/LRI5LU?=
 =?us-ascii?Q?5M+6dwx2TLhSuFJdXwH4SkrpYVQEj/7IXQCmLwau8yequSwes38I+oImKK4x?=
 =?us-ascii?Q?WPihkUnSd+/pMyqTK0isoHCeO6OUEtEC/UQciYuwxiKjIXA0Z4Orl/crWkQ6?=
 =?us-ascii?Q?4/PydNOjZbk3YI/gGSvD8aJjfvp7736KG8p3f4VI3374+x+UH5Cj0dKUhrnM?=
 =?us-ascii?Q?WD/6pK6Fx1YOMmB3v9knxmY08vRznI7R+YqUty03xL+6gy329RSBqvwIzUcF?=
 =?us-ascii?Q?oCv8aanV+QgVq3Mlg0hK1z/EKE0x48TaX16Sh7ckGcMb3QrSb2cjTNjT2AKx?=
 =?us-ascii?Q?vDU2Z5VA64Xp1zh8JCsWtykYp8c5ELp2KHruUtdXaIZS72Gn22I67qbLP8bR?=
 =?us-ascii?Q?E47DJJKgfg7Cf9hcqam/+E33YpyFKJvfhrKIw0pEh/4YvVVxk1zyURjyIQ6o?=
 =?us-ascii?Q?t+vtKHJmVHfNdl+sLtGAmE8tW1K4468DJduONQyoern9Zu11UMm5bN+ntJ79?=
 =?us-ascii?Q?3wmK4Hcg8tMPM3CYRZTzRQ5+NgjE7gTngtGFfu0tXQ3O1RTbxyiw5eheR6FC?=
 =?us-ascii?Q?UV1LhUiG783K+jof1mNm8dzYrK2DEOi1IUvwqIz0bOqTvos5/BXCoS2KYuKg?=
 =?us-ascii?Q?n0Pvqsm3ndLZiGlsuFySJru/ID/GUOVHg5tfHWkZ70PfGxAdmCqxu6xwHiqd?=
 =?us-ascii?Q?gTjUgL7i3h4rwyInlvnaGKoT9chDsBBRfBCZAo5obhLEiwhbBc0Eqc4CyV4T?=
 =?us-ascii?Q?8ut4ea/fFGFYxraI67sBzuE+ftcKf65LHt6tlI7AkJtJNTBucBqKxd0TOf5q?=
 =?us-ascii?Q?acBbIPsWZNcsvOyKx20FS4RnGZC+eyRB8b5qhV2UzVOkHpN9k8I6QDqkH+f3?=
 =?us-ascii?Q?jYXGTBmeRk10I+YiD96wzf3ny789/mZ9Gs1tZb1pEedusQUVWUzEmCCwjyu1?=
 =?us-ascii?Q?jD8W6f0nQnVUrzvqEiJsnOM+zNomXAQibkVmXqKYYYUI71Xt6Vun/MG+8uPK?=
 =?us-ascii?Q?iUuUkv+wXZhY9IAw8rKdyHJQ755FXannGgDXtGpoLYgJMx4udMiEIrGXq/ol?=
 =?us-ascii?Q?NhTI0gyEzl9uFlqiGLKOBIjhiBy56SL4/jWckkIX8Cixs1ou2f0ZU9Sn1uC0?=
 =?us-ascii?Q?NtLA9wBF3+qWpEOha9NxaVZzPLxi8agX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M471c4F6xT2fNvkGdgzx+iAk6DelMNpVU5LS2ZHZm3k/ZwHjaAb5BDfjsJaD?=
 =?us-ascii?Q?KRGqyAhFLgKdRG4ahGph9oDebWHZSwGuZXl1fbNEaDZMjobZf+z5Dp4XJrG5?=
 =?us-ascii?Q?8dk85Xd3+Mbz4xh0FQtU7lX47JtwF+6/X1Yldk5JM28zDMkfft3l0NeaBBQQ?=
 =?us-ascii?Q?a8bq2ORjAGEZm10rWeVk/nfiX+b5Oo4471oTlCnWD5Fac7SM4qACi+lCGzb2?=
 =?us-ascii?Q?CisWlkW9ug6xBEti12LOnN7oV6HGh4iNh4NPYzE+8v+PxF3bE6ABriO4YeUW?=
 =?us-ascii?Q?VVzIrl/mwJNEsPrYa/LmHHgXY3+fX3lIGFwHiTcB8WJh1/bac8ItEyIEXiSs?=
 =?us-ascii?Q?ZVrbS9K7uKs7KGWSbMHNnUjaue0tXgUVeE9HklqPbjLkQE2tAeVZHQFTRY5w?=
 =?us-ascii?Q?Dw1b56RhfwVAc5LJipD7OVRma84+Yn2/PksKi4pqTppmEi8JIBPQMSLq5DTV?=
 =?us-ascii?Q?VG8bYccRZ4m/SQUNszc+JcbWu6Na6j9QufWBTE/cVFctx5oRMx049cwnRlsh?=
 =?us-ascii?Q?jPkTrw47JTdyuKPpzXDPdRofS/g+OwRHe2ervBBzmxrq4Xx2xB/5APhQqpBa?=
 =?us-ascii?Q?IdvQiUGV7oQUwdg8Dv3Oyb7q0ICOau61VT7BjaPvrQ++p3Fj2aypnQG4fFOj?=
 =?us-ascii?Q?0nisAC1l0YndgMamQPVkpUpGplnWTiOw/btdrnrDjDZzD6+HhFHTG2bdv/Sv?=
 =?us-ascii?Q?dtNVPG8ZFNqcmXAXW2nIc88MhGizYlNPQVognZ0Z/tbNHCx3zuSomF5qESFw?=
 =?us-ascii?Q?ayYLdgOVJuKDnpsdGntOtduxtS5cw0rRezSL8qfpOJ91nWR67G5mKWlUvC3t?=
 =?us-ascii?Q?n6DcnlqvwTagMMypb8ET+3jCYw525PAXBPr4Xgl6isKD5ANDyTVPEw5E3+1Z?=
 =?us-ascii?Q?Slfk2Q/302ZksSB9aDzMdb6u+U3SgdkM3M6Akb4BFnY+5BDVfsd3giG/VbpH?=
 =?us-ascii?Q?FnSVpOe0aBO9R+wr/76sAWOXwS8nRCVKyV9lCnILo2ZEiTWa4FXnAY7x6wnx?=
 =?us-ascii?Q?yaH55lRIxOya0o2AjOmJfsP2snTf0gyXJxv8fGUJJVad8187XG8xyD72JNsW?=
 =?us-ascii?Q?jzXx3I0CQGjuWA/oBbJ/WAgXMlLa+9t5EVjvqq+fo/e4bGfQVTk0D7GVyUo5?=
 =?us-ascii?Q?c1h1UI7/Y6XyXU0UCdS4lphLemtPW1NVsb0B214Rv6RagBFUvbPmLldH++jp?=
 =?us-ascii?Q?4uJKWKav3ndPZeZ7PGDosgPtQdkDDnYT/qrl2PzRxdGgia5bju9jmdyePkzd?=
 =?us-ascii?Q?JzOKe622Z86x0o+neL46sosfDxrYbbdpex2ee7H38ZC/O6/n2auaQtM8cLZG?=
 =?us-ascii?Q?pnDEwPGVY3wNWs791dr4ElkBuEatHR1XTRpxwBhho8Ew+91dadCqwX05mgZE?=
 =?us-ascii?Q?F29Wzq57WhlnVAZ2XFtv5D5D3G86oNb++ID/IMP0mRVdbdlcDI5csVMfYHd6?=
 =?us-ascii?Q?qEGUrJK6H6weHhZzWJMmCMEIILTEx4sXPi7CFPSrKWCb3jdCZuE5idvb4Khi?=
 =?us-ascii?Q?m6RCxB65Gocd04adfYC48x6NxLaWoxa8ngOApGjPYcbOV2IrsP/i6Ph9yNPs?=
 =?us-ascii?Q?XqYJaLFNGgjyngSpnRwgXpOXDy2R8Db+KJKbAe5fid3oRFAqink4tDD19utD?=
 =?us-ascii?Q?xJjqZztHsZQv/NlqNswIxt1KAW9WhdenLIpmYHYll6dQVHzx3aV3cDG19Htv?=
 =?us-ascii?Q?2clkmNFbXRqhLOgCXDWYdZUeyDmnI7e/qSrL4YAu+bIgj2VM8iknTRc2KRLT?=
 =?us-ascii?Q?/NSC4qT0MQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ab9e98-0603-46ef-1b16-08de47f9d80d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 23:19:13.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ6Xf6S1aiURgr2ourBS9RImCbKaUjc0brWlsMUx8kiaofB6fYyMdMHv6ZWk9dyYwT+ggQ2pXbLjfKefHV9+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

On Mon, Dec 29, 2025 at 11:10:55AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> This v4 patch series re-implements RCU Tasks Trace in terms of SRCU-fast,
> reducing the size of the Linux-kernel RCU implementation by several
> hundred lines of code.  The patches are as follows:
> 
> 1.	Re-implement RCU Tasks Trace in terms of SRCU-fast.
> 
> 2.	context_tracking: Remove
> 	rcu_task_trace_heavyweight_{enter,exit}().
> 
> 3.	Clean up after the SRCU-fastification of RCU Tasks Trace.
> 
> 4.	Move rcu_tasks_trace_srcu_struct out of #ifdef
> 	CONFIG_TASKS_RCU_GENERIC.
> 
> 5.	Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.
> 
> 6.	Update Requirements.rst for RCU Tasks Trace.
> 
> 7.	Deprecate rcu_read_{,un}lock_trace().
> 
> 8.	Create an rcu_tasks_trace_expedite_current() function.
> 
> 9.	Test rcu_tasks_trace_expedite_current().
> 
> Changes since v3:
> 
> o	Rebase onto v6.19-rc1.
> 
> o	Wait for arm64 per-CPU variable speedups to reach mainline.
> 
> https://lore.kernel.org/all/a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop/#r
> 
> Changes since v2:
> 
> o	SRCU improvments not strictly related to RCU tasks trace have
> 	been moved out to a separate series.
> 
> o	Use the new DEFINE_SRCU_FAST().
> 
> https://lore.kernel.org/all/7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop/
> 
> Changes since v1:
> 
> o	Consolidate RCU Tasks Trace cleanup patches per Alexei Starovoitov
> 	feedback.  This explains the decrease from 34 patches in v1 to
> 	only 21 in this v2 series.
> 
> o	While consolidating, consolidate the noinstr-fast patches and the
> 	DEFINE_SRCU_FAST()/init_srcu_struct_fast() patches.
> 
> o	Upgrade comments per Peter Zijlstra feedback.
> 
> o	Extract Tiny SRCU bug fix into its own commit per Andrii Nakryiko
> 	feedback.
> 
> o	Switch srcu_expedite_current() from preempt_disable() to
> 	migrate_disable() for PREEMPT_RT kernels per Zqiang feedback.
> 
> o	Apply tags.
> 
> https://lore.kernel.org/all/580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop/
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/Documentation/RCU/Design/Requirements/Requirements.rst |   12 
>  b/Documentation/admin-guide/kernel-parameters.txt        |   15 
>  b/include/linux/rcupdate.h                               |   31 
>  b/include/linux/rcupdate_trace.h                         |  107 +-
>  b/include/linux/sched.h                                  |    1 
>  b/init/init_task.c                                       |    3 
>  b/kernel/context_tracking.c                              |   20 
>  b/kernel/fork.c                                          |    3 
>  b/kernel/rcu/Kconfig                                     |   18 
>  b/kernel/rcu/rcu.h                                       |    9 
>  b/kernel/rcu/rcuscale.c                                  |    7 
>  b/kernel/rcu/rcutorture.c                                |    2 
>  b/kernel/rcu/tasks.h                                     |  621 ---------------
>  b/scripts/checkpatch.pl                                  |    4 
>  b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    1 
>  b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    1 
>  include/linux/rcupdate_trace.h                           |   81 +
>  include/linux/sched.h                                    |    5 
>  kernel/rcu/Kconfig                                       |   25 
>  kernel/rcu/rcutorture.c                                  |    1 
>  kernel/rcu/tasks.h                                       |  121 --
>  21 files changed, 219 insertions(+), 869 deletions(-)

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793750030;
	b=D9lF265tgJfZf444PITBAi+02zvp9gVjnHVu5qHUXcmrHDjUPYiwgyKXTkw6yTF8BFTC
	 sY6147Yh793Z4LIsDIEUAU8eJ9hDOi+6mLOy1AchGaND2w5jEOxiDe6559TK+5e1a43+E
	 WAkiIp5kNjgbh2JBOmwpcoLCE9nN1HpweaQOuQTyv494pDQzc2vj02X034jTLkpYC2QXX
	 +TgWaM72ntSgGV71Yb+s3Y/9MGUoNHhHZ44Z69cXoB71Rl3aQR6t0H/f+mYvmMtjw5fd6
	 6GdOU5/sKsT5PqQD4ba9aqecYiHQoTR5tQxfqcSykpPu8z2y7IkQ/Ja1Ge6K5qtb8pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750030;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=s4r5bSVojRKcNkUTojD15FdheNrK1abhODM3ds8JyHY=;
	b=0DlhVdxHum8iHbjMGQ02Rs3r27k0ILnWbjRPWgdWfKmlwr1tu4s2Mq9cKXKM29h4WbDM
	 uNZgOlN0NigDCAu69HebNlBDEmoVE0DtxqVKpqKEQZz+mNdhDbC5FnOvCyTNHi61TOWCG
	 g8z0rlwtKnnhpDtaForEdwMqHJTSTATdI0gQ1bWVayRACzuoz7PqTzLwThm0Lla0PKtb+
	 IkepRwbuI0oehkZfCuWu4oAwNa9OFQaYjUUr7a4ZvRSH1pdm6LvRLnyH9iuA0MZ5CYj/M
	 GakQRtEWgGyxJuQdChQlGcwojeHEOnQfU+pJKvu9+Jrww0BJy9NbuCVwlBMAOD7tXaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UOMrBNMN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C025606A332;
	Tue,  3 Nov 2026 23:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C025606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UOMrBNMN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6irapsErNfJgszhizUKWP2i1VQaVCYBESTOtwRBz9j6Rp54btsph2RMSCpfpUnqTIK32ygNi1QWBUFzJFiwW+ddTv+hTejPeaSJpbFano6R/lCpE7jKnbxHgp+sdXJD4vBzdSn7csPenVH+7SKu1862IVGNKot+S+x1F4MNDCl0w3lyyb+bBc0EKDndZ4ez1ZgEMBbKvDyLQgMd2cDgV6re05DDNOL6HMrm/KidQwgVBXCKnJ/Zj9Cm8bW6OifzGPifmxRg2NufqL3YLZDhvp7FMHcRzVDQLduE8PiL757GUQwv8D1xbGAezgmoDSj4tgcYoSxGRtd40Z49FYlUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4r5bSVojRKcNkUTojD15FdheNrK1abhODM3ds8JyHY=;
 b=txi8AEsl5Un0xx1H/GgVI75DohL2J4IXELEzTD41XrRXGifitrLL4vmt0e/KJ4GjehUGHKP8Sw4Ioa3sd+WUAo4vqBAtRSziMQ+ngsCWwiqiHFQdhes7NqmmKDnyF497wlEFih9sp/UsKdq74jAnelXomOY+In/Pg2Ey0vvF03JDGEbNqMi3qtvhLhbNVKHz8vVTSce9FwWl0Va36RPR13UgCQNqlvy6kvaj+ixISX2gy2FuwvSzdzMO/KrX7G5txZLkRdGhQyhNT+NUtVzT66HTEPktysx1cIDvbC7HlWsPhAQjmJtzxcK1/0kO9skDo03DtsTlq2MkyMkDMzi1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4r5bSVojRKcNkUTojD15FdheNrK1abhODM3ds8JyHY=;
 b=UOMrBNMNmZekPHvY65+8Oxw02jkpCNx5i03TFUKEdra/UUFHO/lLRpUW/vgdq5mk2wdlXGDIPXUHqMgeuxW//Zn0bDYQTLQXUWPJktL5p2g+MmN+Xs0vkgRB+se7ce0bAhFhGPjotQ6GwqtFqsf9Vo8IArVHLaKE3WOhoSyTeFJQ3QJUrnD8yGyRkhD2wfIb3qqT6xYScDUHSYBIs93FuXZscjQ53uWF7Vl5PywztreUiX3ZTMyZEocRpZQgLCQBjkW+KyOmOtHr1sQOz6gZJiBBhHSkKVOZub+x42w4YGNtZXz4p3FY3jhkmMHmD1H6ddYEOujfwdsKgFpR1GP3eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:53:46 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 23:53:46 +0000
Date: Tue, 3 Nov 2026 18:53:44 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for
 tasks-rude and srcu-atomic
Message-ID: <20261103235344.GA4137395@joelbox>
References: <ACA82057-9E74-41CD-8EEE-1D59E98D2D41@nvidia.com>
 <2b7d3fd6bc409170cb5207d74eb9ded4a5874b53@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7d3fd6bc409170cb5207d74eb9ded4a5874b53@linux.dev>
X-ClientProxiedBy: BN9PR03CA0973.namprd03.prod.outlook.com
 (2603:10b6:408:109::18) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 531a3520-4000-480a-0ad9-08df3a05b329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|261022075727099003|5023799004|11063799006|4143699003|261102123227099003|261022105027099003|261021121427099003|261022115727099003|261021130227099003|261026121527099003|261021123027099003|261026130827099003|261026140227099003|261028144727099003|261021135927099003|261022113327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	loXO/hda1VEBqLbHIP/z95XerHJXeUlzLZFroWwnmWIXz/h7TE8vAXeBXThBKDLbsWhfOvbLZtxnskJcKcQcGc17rLPS4k/KWAVkOjP4jLxrzK+YK9h/hJBgX/efrwFcPjehCHpRmjrThiu6fZafrA+mXYUgOLbUtQW1Vb1XeG8Opapjcrki89xFXN5VjH1tfq4IVnfGx/54OpTnM6w7QB9+r3pK8ltdi2dudBxkEPXojJ8YGGabTP943p7jN6mRRU8fxl22WjA+dmLAfvFPBTfSLH5Fvo3YyqnJYEPH3kI4spnuV8A11MALCDQzk+ni7rSr49ppmRSH/DCVgwr3W01ij92dntCIddKuXeJLQtlA9MrMrVqRS7DFKOQrxIO5srSa42YyFaMIBVRYMdE+YW6kHPNPpuv18SVEMzb+L7nnMLbQvNWr+JHnV1ooX3sax2otMxcqvBRDpwA6JVc0iyMrLhX26kC2PmH/Z37sTxGL4/Rx9g1GH3RwDmVYoPM8g/Xf88tWi/Vjd5FhJsVk9yFNn1Kf0DfuFJj6W0Rke7uVLzdazHJ9hBvIINL0tGedTesLDvwqYo8uGwcGkB0QEG4nfJ3PFmS8dPIvUEeoamNChi6DB3tD9IrCBaygF/4JXEGsdGUdFive2HKNT4u5AxHuzypSFQjmgs+4GB4Yu/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(261022075727099003)(5023799004)(11063799006)(4143699003)(261102123227099003)(261022105027099003)(261021121427099003)(261022115727099003)(261021130227099003)(261026121527099003)(261021123027099003)(261026130827099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022113327099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHn8zr+e2/qqeX+tkBMx65Fn+29wB/u2vuwCLKCuB0oeaAmHmzxOerWwxGEW?=
 =?us-ascii?Q?HmMoJk6KTNOaAILGHaHUpX0QKWHqo0aSXFmlkBWYv2TI8hP/jZs4a3U6njNW?=
 =?us-ascii?Q?ZG6XLvnN81dCuaIjMyAJ0LnV1h+JYQjZ2+wQ3WzPC7gilDPK/YFiCwkJPZHz?=
 =?us-ascii?Q?bRTw/hqbZJybCeDsHT2FC43wTGCoyXVQ1BoKnoiNGMRjOUR1wRPbvPnyFyNP?=
 =?us-ascii?Q?zbZs+dUydZdYjBK/fUP0KX3aE3ETkoIiXdZ8sh2O5NrHnnbUu5ijjqQSpoDh?=
 =?us-ascii?Q?aKwEhT7m4/+e9TIxH9v69pNU8FStdfRI/CaXb121w8fd11hY9HWqfmxJu2fQ?=
 =?us-ascii?Q?KjN7mkI2xbeDL7rM0it+vb6FQSGRBSTescYymzjEmI8oOg2hDZGFy1lqpWg7?=
 =?us-ascii?Q?dB71sANWei1qVsqucxPMpH+oyup1bk5YTT9HbQmO+UTDf+zvVifIsTXaBcPf?=
 =?us-ascii?Q?CoRotXAKq93r4Lfwk1/39uD1LRa+Tx+z09TuGBHQ+V0fn3+HwI+5f8nIYqD6?=
 =?us-ascii?Q?SQL3YCyQTQtFJc8OfyB0RG70disY5xdq0dIOxEUjsCbt+S4yNIeXegdXSw/j?=
 =?us-ascii?Q?R2YrfxqHK9g983u3rEqNE7IpERJwcnuFrUgS+oJNGjFPuVTf46MdrXDey9cv?=
 =?us-ascii?Q?HVcYh2qn1Q2TzFG8dhPWxWjJ1gTO8rQ5WDuP/P4O3y58AeIzTW2EwCxuQYqi?=
 =?us-ascii?Q?QgXbGrYYVehovdEMr+HIhnR8Clzvt1ncqcBqpSrSocaBrb+HjL/X6U2CQSrd?=
 =?us-ascii?Q?jxsK2tzfxHM9kzyoLh+4AuPKWRYjztHNSl7G65zRAs/B++v6oUi+B5PVo+BF?=
 =?us-ascii?Q?/JtFHoMfFPsPDzDWsoL3JB2xyts4UwBLBZJqBZ9puIaI0bAzLNeTgbCUQ5Kd?=
 =?us-ascii?Q?T3KtoUq7dsCxWUlHXBDyMKVqzo4xT4oVr5AnNAt1d5A+o3/yb+VFa8WGFnaM?=
 =?us-ascii?Q?FIjv/DfBMPHxY/6p3u7IAk3RutEIPnwJGdbiU/874TkuV1HfMuI1dzlgNRu+?=
 =?us-ascii?Q?2hmSZfTjETUIEf8CioWuwS/oEf3F704fBLvefnKJGfeLu0VmibN6ROhE9mc9?=
 =?us-ascii?Q?Bvx6YrA54roJABee9TemxFIJZqOlYIunsUunTpgqTnfNssdZ9rkDWkG46+Qw?=
 =?us-ascii?Q?Nmd2wpytkTWPZgNUYMx8xaErcyY8FppzR1VaqtJOBaV0QjLnMK3zuAK7M5yo?=
 =?us-ascii?Q?HpgAhgzHvcxekguSwKb0bOVbxbka/6fJxkFMFTm2nx8bEcbQMZRsNxR7yerl?=
 =?us-ascii?Q?Bqyjvdx/yZrsQx5XIAxJn++srD3SzEnYPhvbVvDpera1dDcxGHQo/msjXzDr?=
 =?us-ascii?Q?bId4VlEkxFFJ2PV6Bh56wqDsnLZirmGsAITctHbC6TAZ5O+NFOhtQZ33stgX?=
 =?us-ascii?Q?g0n75AWKwnOwBbXsIwjxIY/u+PVZME/K2QlQGx7qUKVx+91QDOumWV+4QugZ?=
 =?us-ascii?Q?yieZNmgiuKt1fGgWwSjIYCpMiw1tqNM9vck/c/Oq/Nit04OZk/IjprUMLi0w?=
 =?us-ascii?Q?CKuHKioVoH0fV4te2ba7WnTiy6KxG/sB3tYl1LEN0iItfmK0mw+vrsyY53Ck?=
 =?us-ascii?Q?SJKiHhgFgHQmRoTJa/wqwLos5VcivaRMRTAyrsU/iY4Ho/C6udfaAxLgresf?=
 =?us-ascii?Q?+9TtSPYK5EjN7q1plH5kPeF4atg0ltR9m+Lxw+Uq9Jrxg+5BTQm92OLgaZPU?=
 =?us-ascii?Q?o/HkN3OeDtE8177uii23RNu4HD+8KV03W+dPl5cIGjyhfTjnZ6Alej0ViE8t?=
 =?us-ascii?Q?GJ3ssIJQNQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531a3520-4000-480a-0ad9-08df3a05b329
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:53:46.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5m5wlwhZM6aL9hc3dgn1+zsM02ZB9kg46wDesK6QFf4MpUxRZVYPdlTOfjq2Wo15VWonM5egvvMsWruAYqp0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124

On Mon, Nov 02, 2026 at 01:50:17PM +0000, Zqiang wrote:
> > 
> > > 
> > > On Oct 30, 2026, at 8:14 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> > >  
> > >  
> > > 
> > > > 
> > > > 
> > > > 
> > >  On Fri, Oct 23, 2026 at 05:37:16PM +0800, Zqiang wrote:
> > >  
> > >  
> > >  When running the tasks-rude and srcu-atomic tests, the fwd_prog_tasks
> > >  kthread is created because the default value of fwd_progress is 1.
> > >  however, the two RCU flavors not support ->call():
> > >  
> > >  1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU Tasks
> > >  Rude asynchronous APIs") removed .call and .cb_barrier from tasks-rude,
> > >  but left the .cbflood_max = 50000.
> > >  
> > >  2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to NULL
> > >  for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched.
> > >  
> > >  In both cases, the non-zero ->cbflood_max fools the check above into
> > >  creating the fwd_prog_tasks kthreads, even though those kthreads cannot
> > >  possibly carry out any forward-progress test:
> > >  
> > >  1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops->call
> > >  is NULL:
> > >  
> > >  [ 68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> > >  [ 129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> > >  [ 190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> > >  [ 252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> > >  
> > >  2. The rcu_torture_fwd_prog_nr() is never even invoked, because its caller
> > >  requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
> > >  provide ->stall_dur (only rcu_ops does).
> > >  
> > >  Therefore, creating fwd_prog_tasks kthreads is pointless, this commit adds
> > >  ->call and ->cb_barrier to the forward-progress check, rejecting flavors
> > >  that lack the cbflood_max set and a positive ->stall_dur.
> > >  
> > >  simple verification output:
> > >  
> > >  [ 3.062959][ T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> > >  [ 2.922323][ T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> > >  
> > >  Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > >  
> > > 
> > > > 
> > > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > >  
> > > >  It would nevertheless be good to run tests demonstrating that
> > > >  forward-progress testing happens and does not happen on the same
> > > >  rcu_torture_ops structures as before. Just in case I lost my
> > > >  way through that boolean expression. ;-)
> > > > 
> > >  
> > >  Ok, I see. thanks Paul ;-) .
> > > 
> > So let me know Zqiang once you are confident on the testing from and I will apply it for 7.5.
> 
> 
> Hello, Joel
> 
> I have make simple testing for all rcu flavor:

Thanks Zqiang, I will apply it.

thanks,

Joel Fernandes

> 
> rcu:
> 
> [    3.871868][  T158] rcu-torture: rcu_torture_fwd_progress task started
> [    3.874347][    T1] tasks-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [    3.862128][    T1] tasks-tracing-torture: Creating rcu_torture_fwd_prog task
> [    3.857800][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [    3.435733][    T1] busted-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> srcu:
> 
> [    3.676067][    T1] srcu-torture: srcu_torture_init normal SRCU
> [    3.691425][    T1] srcu-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.467289][    T1] srcu-torture: srcu_torture_init NMI-safe SRCU
> [    3.482983][    T1] srcu-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.457597][    T1] srcu-torture: srcu_torture_init fast SRCU
> [    3.475676][    T1] srcu-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.381378][    T1] srcu-torture: srcu_torture_init fast-up/down SRCU
> [    3.397417][    T1] srcu-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.479642][    T1] srcu-torture: srcu_torture_init atomic SRCU
> [    3.488532][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> srcud:
> 
> [    3.898271][    T1] srcud-torture: srcud_torture_init normal SRCU
> [    3.915141][    T1] srcud-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.586829][    T1] srcud-torture: srcud_torture_init NMI-safe SRCU
> [    3.604943][  T146] srcud-torture: rcu_torture_fwd_progress task started
> 
> [    3.617095][    T1] srcud-torture: srcud_torture_init fast SRCU
> [    3.635608][    T1] srcud-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.915194][    T1] srcud-torture: srcud_torture_init fast-up/down SRCU
> [    3.933086][    T1] srcud-torture: Creating rcu_torture_fwd_prog task
> 
> [    3.866575][    T1] srcud-torture: srcud_torture_init atomic SRCU
> [    3.883949][    T1] srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> srcud-busted:
> 
> [    3.382474][    T1] busted_srcud-torture: srcu_torture_init normal SRCU
> [    3.389525][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> [    3.423111][    T1] busted_srcud-torture: srcu_torture_init NMI-safe SRCU
> [    3.432941][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> [    3.364002][    T1] busted_srcud-torture: srcu_torture_init fast SRCU
> [    3.372654][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> [    3.860358][    T1] busted_srcud-torture: srcu_torture_init fast-up/down SRCU
> [    3.870796][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> [    3.364909][    T1] busted_srcud-torture: srcu_torture_init atomic SRCU
> [    3.372280][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> trivial:
> 
> [    3.858080][    T1] trivial-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [    3.689060][    T1] trivial-preempt-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> 
> 
> Thanks
> Zqiang
> 
> > 
> > thanks,
> > 
> > Joel Fernandes
> > 
> > > 
> > > > 
> > > > 
> > > > 
> > >  
> > >  ---
> > >  kernel/rcu/rcutorture.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >  
> > >  diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > >  index 968343be4e0d..92ff197f4789 100644
> > >  --- a/kernel/rcu/rcutorture.c
> > >  +++ b/kernel/rcu/rcutorture.c
> > >  @@ -4007,9 +4007,8 @@ static int __init rcu_torture_fwd_prog_init(void)
> > >  } else if (fwd_progress < 0) {
> > >  fwd_progress = nr_cpu_ids;
> > >  }
> > >  - if ((!cur_ops->sync && !cur_ops->call) ||
> > >  - (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
> > >  - cur_ops == &rcu_busted_ops) {
> > >  + if (!cur_ops->sync || ((!cur_ops->call || !cur_ops->cb_barrier || !cur_ops->cbflood_max) &&
> > >  + (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0))) {
> > >  VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
> > >  fwd_progress = 0;
> > >  return 0;
> > >  --
> > >  2.17.1
> > >  
> > > 
> > > > 
> > > > 
> > > >
> > >
> >

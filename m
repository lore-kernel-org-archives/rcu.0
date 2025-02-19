Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FB1E00BE;
	Wed, 19 Feb 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971546; cv=fail; b=dNipcX+ytaWpKeyPbMW3DfyQ4PLrvcSvHixfv2t+3UDz7iuZhkOCdfsdU0XFA+JyYij2Rvmh3lfn6dM2NyJ4wXqvZ4s5BBrflM3Z0jd1TmSswJhfLLVfwX1tvETkpaFsLk48Lzbi0zqfDM59jBETx7SymOnH/ZXcEsfPiTX6LuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971546; c=relaxed/simple;
	bh=0Cc48uHlKe9GtTKHlQVknq/Kyp8XVx2BQtrWKC4AaiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sCM2K+wFnXysAjHhlrq4mgfSxWPAA8sbrDUjAdCdTdH81tPJvqK5KuPllpmHoOOgigxTNTDKDaLz3Pftc7XW1Uj4qlvxaKjIp68FyEKW/WorOTGYrTEVvAhyxYEgyHx7ypCwL9/0RxFSnsgQ48NK37BWduZQRkKul+sL/mIzmqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ik9y7GuE; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ik9y7GuE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJmDOQmOgwrAdxszDJ9N7eQ3G18TWTzCsU302XBg6eMgusII8LQsp1y21oHbe+FDjfk72J91QbAugnfIEQ0mM8m/QEMhwezool0TPYUPMmOTupv80taxMOaWUPPozfky649+Mq+tSAF1kgkHHBaZnW9hQgZsTYmIrE95Cw8igQSfihu8DqU4MAC1COX7EGZxeana0nAel5+ZAWC1onQrBudIsrZqEV+tleJj55obLv0fR9tdA0a+1D6hugxRBWY9QOxdzjSg1e01AmSjw+0dZ7Da/eiE4hWgOnmdk4rWC3RbR/CPh2lRp0IfbRcZVZU0nxv4n8nbhQ8Gl+q8vB3KIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MXFFtkqEOnxl4kf3QQ3+C8nFe7Uh8zGA/0XZNy/ST0=;
 b=iOea03axdSDMX62Q73OKjofMNxYzEfutmnxDa9BqykU2dlunE13r8j0B+73kKNli1hsPGW0t1f0jkAFeCiEWXZ8u/5w/UFawN76gPZfAx8F2ocColmyg8QAi6vLFgi4ImAolg7bC4a6sDwNd3F0wuieU0dW7b8UpgHd+9dyaJQ47BK+rLAPbhMf63vFI0lkDOpgNWEYQWZQMsYxZBF2WEkbU/ZNmuUYpKbEfCKXr4Lj8v71p157LfHSxBPGj4nToLHhz8W8Pti4uSWarxIaE2UFfO424ErJdkx0wuwBCOadPkzXVYu0gm+PB/4GxR9nKf3nUJ6Jx50nh5lamtrjQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MXFFtkqEOnxl4kf3QQ3+C8nFe7Uh8zGA/0XZNy/ST0=;
 b=Ik9y7GuENz0JYM9+pOAl3Z0K//k8rXaQpmjYyFigNjPG/BrPlsiBK+rXgxC0ZAURQonLtaBF3kqDFKVRv+PlZwXC2nd+Ej9UvW2ZjwZvCD+aINCWmGnX6CD+em0VCtYeSitgmAdZpzKOUOL0u8LxQ9o/WrTvoPjzymxWKkWgJIJ7pyf6/7nmYfiFkfk3HVWEzFbSLwFMZ6vVHipknZqzE9EU2CvcwqOjvsslNcsF2kmmsbMqH2sJa+09krKl1uWu1hTXjLl3Dqks3BQJeGcyWapc9mmfCn3pfMWfzW3gW3xQPJ1uuhSHns93npu5/UyGbOQzex0jurXM2xYM4y3QBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:25:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 13:25:41 +0000
Date: Wed, 19 Feb 2025 08:25:38 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: syzbot <syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rcu?] WARNING in srcu_invoke_callbacks (2)
Message-ID: <20250219132538.GA468969@joelnvbox>
References: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
X-ClientProxiedBy: BL0PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:208:35::41) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 33473865-b771-4c23-2bed-08dd50e8e7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qi0ysM5omZHXp5Q6yz2cNFyVb+dA9y+qPhQ2WQPAYkdHMQhI5Xqa71UXvsWC?=
 =?us-ascii?Q?ZY+MQDajQc87ou+YClFYWaQOjy32lAxKvd7PM1/2DIK/esaoLofHgT9S1/r7?=
 =?us-ascii?Q?rNIERfmD8754Km1S5TcS3s0vCyukgepJwYaJ1E2qGiKl0wqtbnRiHVB+Wq61?=
 =?us-ascii?Q?wHSwIO61R3hzxmumIH73sTfEjbd2gLKaWwWTIbnkB2xoly2tuoIxxPBbuqMY?=
 =?us-ascii?Q?ndma/Qx4lMh3G3Bf6bXRySVjpN3Gb6GvjgNNctIF64IAjjFTaD4VSpPcUfa/?=
 =?us-ascii?Q?4QB74DVgVfwbl2wXCn8gXgK7s89dq6qOQoeX+Y+yKQp7HtiRLUbi8toWwBey?=
 =?us-ascii?Q?0k+GQzocFsv6y8StJInmwub13tNOaLN8Z4KuxJAd9xrWU5JDck+0aI/iBD2n?=
 =?us-ascii?Q?azgmJOu7SrTXJCaxi7Ws6C0b6TI1J6ApRXbs8EKSz06AMSlEkiCEAtHaknEY?=
 =?us-ascii?Q?UjHyYlojuCoqZZDQY5pntR6HUCSk8Kgs7DbN57CrZIRAHdC1HqehGKS8edb8?=
 =?us-ascii?Q?xeNLALd6ueTBnM4A99qxFTmUZ0El6JuuMlDJsJX/eCtoGtHIktS43NOU2QXf?=
 =?us-ascii?Q?ghDaNT7r0Z552Vgg2fOMJPc+0GKzFNHQn7xBKmGjqpukrGSTYGYqD7biJm69?=
 =?us-ascii?Q?JBIs2kwkIQ3ygyiEdEJAkU9JeeRlPfFqyWk82Fo1b1L42wQtIN50LdNscDFD?=
 =?us-ascii?Q?/OB/aQRd5mamVz+YwYEoGfdL/Cij4OsFhpAummaV5xsGos9wNjI09SnU5DeE?=
 =?us-ascii?Q?JEgu8m/U+U47OqzSyxQu+hymePMrvcNrr0dO7SgdZH9g/dKPzJf6i6zHI040?=
 =?us-ascii?Q?01F8msCOufbAf7+pocP9P2Yl5ifbo5PdFVlWtSgUa9MVBkqJPQy06OMnEeCp?=
 =?us-ascii?Q?JnhEz5yMKThMtJB7DrxE+QXDZfhzAaBD6EErmOXLxeNtIMVMk/EzKUWgQCkU?=
 =?us-ascii?Q?YpFXRNSFKejigEc9dBVdNb8a5+OW3J2xxTJbdzX4SK93YojRj1AlRpnHsffC?=
 =?us-ascii?Q?xAyQAkO7tGfMZp/bPXPzuN8KjYFAKxqdE0a6b4NoAl4Bu7TTIkCQ8k6d00lq?=
 =?us-ascii?Q?Mt9OP65ODEleL/ipb3XsJ2oJe0ZXMlvIASKdBnlHHwn4olGFfRfXcHEMNusZ?=
 =?us-ascii?Q?+O/wcEv8P95FqTnlc73tELfJeevhcTjsPSqFqtqShQttVNfpigiI8ImO3RpC?=
 =?us-ascii?Q?7sYRM7n+y8jQjdrGV3HPbuPwd1L9Y7lkqcafOzkRO4c4YWZNzPGgiPxZMSrS?=
 =?us-ascii?Q?hLslymIUxtPpgxgKuRCvi+7PjQj0qwi3iPTYRtqCAGZ4xLmo1rbePFme/q+2?=
 =?us-ascii?Q?4WDQAGMRmlq2Lm+ZaNY9PzckywKnLHAnSdQvpN7UKfNVsYJVROmVdJJuEyGM?=
 =?us-ascii?Q?CIJW4m6ikeBpM+wWOa9LG6gekFKd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/Zp23q4N4+N2nuYeLWhzZIGvKwq0Ow6H14mKqQpz2nhLBWqDp4tTlNsfcln?=
 =?us-ascii?Q?LHXS2tYifi9htE5aQixy6XD7TYFwJ/wunxlgzPjHiWfWj6igFmhWemCJrRmM?=
 =?us-ascii?Q?Ip4FmlIxg+FZrUNbREpSAwnS7pX+/cUBp6U1S51cQ+Vm/cIddbYtg/URfeYR?=
 =?us-ascii?Q?XeXVJ9FG6JfiFRBO0E8CKTUtTjzL+qoenTf8CK0Q+PLiy08lrizCrzTXSBJz?=
 =?us-ascii?Q?0LGubjz9CwxpEl/xYDVO5JgW+QuhEmD/ocBmj9K60eNaqHqdKPpRo7TYBcm9?=
 =?us-ascii?Q?mrJrc1axwl3iAyDM8s/AwPKJqEHKhn5XHzPOy3Vfzn/O2ZTAvZBRxCQ1qmPw?=
 =?us-ascii?Q?raRHYt7aOfTmA0bU3r7iLXgV/NNB0ONYZTMAus4GkdfdaXBvW4mzpe9zPWlJ?=
 =?us-ascii?Q?URjVKXjShLv9Qr3Z7tWifKCghEHp0tg536mFujF7FfIV74Rn2zP653cZOF2Q?=
 =?us-ascii?Q?xWIsEuoHsR+lUvB9oOJTX//knC7RPhvHaVghsUzH2ptkF7DCuYr/m+2HJO4g?=
 =?us-ascii?Q?FpQ9FtfDxwJgYlOwLpch+TCF/jCNvOe5PxN+V6WlnsHAUFZa6utVkfJAq9yH?=
 =?us-ascii?Q?zTwbGKLS4Qq2C6/5ZmB7xWu6JwlrW18Vye8xJJqSgbD9JE7BvCsNMTi/jyo1?=
 =?us-ascii?Q?+3TXVJUkmCHm4LoPvF7lXFqvshCi6tqehujS+0tnzOP/GxyZsMvPwkIncIEf?=
 =?us-ascii?Q?AtgjXpHLjkA3o4Px5iY5kkrbOGQrlWc0kY4kzycAxK4efzFc13CdeDhhknJJ?=
 =?us-ascii?Q?qchgv1+4NKAkmPFbThwHzu3orC1goL1RBcgh9qRGen5sN3SeBrukFTS9rhrR?=
 =?us-ascii?Q?a5sHRkQqr339wQwsHiaz3UQFKpY3O4Pmp5XmrHA/2IJyOI83iLvPMaCc4QtU?=
 =?us-ascii?Q?B6ubm9REPfhPUCfWdxju6XguKXOgWqicowMNAi8NLlkFTZ1L3nGVWgAZErZ6?=
 =?us-ascii?Q?vX3w8GeDZRNTXHv3rhjy9AOHuUMpEn9TpeMvCycJoxCd3iP2P4uCUZLF2tcT?=
 =?us-ascii?Q?fomCzm5TCDfNAUqtXWcSWetSb05DPr9Kci4RhtlOYXW/KxGU2qbnaL98U6LG?=
 =?us-ascii?Q?YQe3kRa+yvttgO1pwqQepswi3EKbK72cgxUXBLkxJzk2Jv8JdAv3/ZiBujkC?=
 =?us-ascii?Q?5b3366LlNfanXpc9B/0zWUa4RrFn+En0S/Ow/L8L0XlxtI7mzlwQirhwxyq0?=
 =?us-ascii?Q?n7Or02HrRI37oIhc52Yqt7Rksx8AxHxx74oArZHMrwPy/Wjg7FB56ShguuAI?=
 =?us-ascii?Q?XwrmF9NMEbVY9wDIBo0+Zs/n65TsMFNCy46vl7tqd1mVwTbz6djicdiSAIIF?=
 =?us-ascii?Q?Pc3FbX2HBCemREeeEsJcHV6qp7w9N0q5nQuZpWxg8CTbWVXt7DIIkrKxERtP?=
 =?us-ascii?Q?W+8Alo8XTWFyhJtzcOh/iuZ36gBBqp6xVuqWeDXCJH6vTUrAzXyPpgI/3VfL?=
 =?us-ascii?Q?sLeaSeR+scKLp0T3nCze1B44F8gSiDXPYMWs21YgIymkShhZe6pxJFPnowOu?=
 =?us-ascii?Q?fDNzGAHIZehCyNvku/dnqdvx6do24No0nnpsDltpB1MLLx6w2qbi5532lRxf?=
 =?us-ascii?Q?rPizCjHvhI0bFNRdU3X8YGLolgT18f239yZDbccK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33473865-b771-4c23-2bed-08dd50e8e7db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:25:41.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMg9lJN7AE1EkTgLKf+rwI7F7m/ztqSqDEuK/5Ma9BCv5XfEHY5YUqSdSZ/ZmkRXZkcsGR65AHuoxhD8IYEqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

On Tue, Feb 18, 2025 at 09:47:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a64dcfb451e2 Linux 6.14-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=12398f18580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c47badcd079906
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c0a862fcec77/disk-a64dcfb4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f03793fc001b/vmlinux-a64dcfb4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ae71c33eae14/Image-a64dcfb4.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6430 at kernel/rcu/srcutree.c:1798 srcu_invoke_callbacks+0x368/0x3d8

This is weird, happens to be WARN_ON_ONCE(ready_cbs.len); in
srcu_invoke_callbacks().

Perhaps, stack corruption or the SRCU cblist's ->seglen got corrupted?

thanks,

 - Joel


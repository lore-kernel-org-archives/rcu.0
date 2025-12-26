Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF54313266;
	Fri, 26 Dec 2025 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766716424; cv=fail; b=oAJWW4BWFZHI5sikTbn3zh8Lzf1Li23Qfx5g2P++DN5nsS92dIeOelvOAhUoeYg84Eg8F39OwIphGbTQJlUPoWHQQHB/NTsWgsHTRU2xzUksw2pnMjaLGp8DU3NyA9vTHAvALfY6+Hl4DpSkbxPpNDe4YwTpol+fXwAyc3W8gJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766716424; c=relaxed/simple;
	bh=fYXxT/g1iwz0VnMqdVnNBVKRbvaPn23ibYwYVjid8bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OB2Nf6k6v2fX9dtOoDtX6zGisLJyRrSYc49WkKAXVeUvyf5UqKSPY825x8bJCJA05O3gFpc9TbOyLmCtSODvd+WfnD+43G7UeUmlzSfWa2n6/9lTF8f1ETNbg92TN7hi+D3Ahf3AlKkwUPiitS4PfITVdPhqiCDmkxG2DRugzrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jt+JkY+0; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jt+JkY+0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fzz3UOLCDlC2VIWaDjMdslBrLUV6G/4oH402BYH8sbOeM6hIwLBcGXCqbC6wtH6NBnYiuOzMV9fG3TSUbU8SEkvhyK5+OpXo8JJ/EMIvDlWdXqDqZCWJsTNFZyvh/3gPvmw7JZUoaZsQqWdQwe2ao5Y0R6S90ELbdsMHAbijfKQutyXHXHMQ9tga5uirRl+0H6QcD9Xp9+DI7/KKFtCq+ovIflbR/Ig4MnFJzJakQKNn7fbwD6aQuKDoEH7rBHFk89rcYeSJEdYwkn5Gvx6MeCPID2SIWL3t0LFjceEYyzxzrLPxRSKSro71Ylqkj0DOwzxa+pQMCvXqR7urZblm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMiXY4vjqATPtEyZWAM7Mz7zdvU27qK9rMUzrobB938=;
 b=JCIWGioHS/B4ByIJWEeeR2Hu8ur/VwMGDqwRfcamISPnrL6W3dPVX4NO1FD7eBMrxuzd7ZA8He5Ap50r+6C9vDHuyi9MK9CFIukRpzbZFb4PU6JWEQ6ip6Xiq6D2CYPrZZb6VnJ3mCQKopxmiTaJkVV0M8hHpfpovyAiw6y9qRBg0giVjedTImFawacK/LcIP0aA6G/R9/rO3FWAfL1xPwwq0ETRucTh4Q1MIb47D/Rz7U4FTkqVyyzlAug4FegzteF/osc3qPjWs9QsKYR0ook8/h0SlhNO/DCM4fjY5gbFnEzIeFatue8jPPZCDuXBfKkZQvziiJ4xdGywZJaR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMiXY4vjqATPtEyZWAM7Mz7zdvU27qK9rMUzrobB938=;
 b=Jt+JkY+0YGgVuvd397R3uE4pgxadffMprrP+y3x2QipJtShKq2r2brqlEDjPCwa7LPYGdmFrejok79BfibKgbWlvTU+wQ2zHQZvmiFFWXKjmXMyKsFXHg4Cs7JwfQGx0N4GqkiGN3Q9HUxypTOI5cYF/7g5cWQ3ldrvp9vebwsfBU+LwDWyYn99JUPhKDAyJEee6CK3lp3WQDb1Mwtf48ASif+dYa9xmT0zegYYWwwCM9Wc/+rSt4EUybM+KTqTp3FekFAnUUr3HgtT53ZKOZzQFbE0xtBjtWEbQyCiV+0ymDlJKSLeLjYn15p801MRM3pSZIqUC5L8zZ7cT9yy40g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::985) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 02:33:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 02:33:40 +0000
Date: Thu, 25 Dec 2025 21:33:39 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <20251226023339.GB739018@joelbox2>
References: <20251223034630.1092719-1-joelagnelf@nvidia.com>
 <b355f3ed-3916-4419-951b-33e3788427f4@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b355f3ed-3916-4419-951b-33e3788427f4@paulmck-laptop>
X-ClientProxiedBy: BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cdb233-41dd-41ae-b9e5-08de44272e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2syClVssxecHXFvGpvi7bnAKehBuGNgZ7M3Eyi1DEYyjiEKlSRm2bvv4JKZC?=
 =?us-ascii?Q?YIHMOsvH56VtSVcoz8fPnruI6skh0iVK8LUucsVbZ8m9mQMAykRaMXru3jGu?=
 =?us-ascii?Q?62s15VQmknrd/xROvFqBP4P5JEu4pZWEHuMFGVqNZC7uRidY3/8jGCsriOe3?=
 =?us-ascii?Q?r0eXmgcwGD00KW3I55t2QlZcNs1GPUS8WeuseiIAUvEdwsPk9I8cXVn5fy8b?=
 =?us-ascii?Q?4bdFIB5b5JNam2NQH4ilRt5My5R20xc7yv3U7SLp5q+duZGt5Dhw8K7g1Izc?=
 =?us-ascii?Q?EmzF8ly8Ec979tYmChiDez8OOsgBXDLst4rMghtF15dofJHx8Rtc/onhSLa1?=
 =?us-ascii?Q?JDMvw+G3jcpMoKATaApNpIGHmWx4OuREa+ocw+fBJicEclsUugSacZ+SU48Z?=
 =?us-ascii?Q?zJZGluoh3b24KXwbagk4DrwKgaqWQULaLSOM3YI5U/uXCoI7jaOz12IhNz7E?=
 =?us-ascii?Q?tgBwzGlGH8klmO1EASTSH5CzRfYC8aVwSaoZ+74Puz7yVK/4xkgNrXqrByZv?=
 =?us-ascii?Q?YxWWz5cAGiV9av45sVbGxvM/TgM8JnsHOv1DF5C2rN+iV57HW2u7h9paJ/wA?=
 =?us-ascii?Q?z+r9JePyv8R3GKGzPwcuJcOzZ+96I7+qslaa2z/LPmi+SsswQATHOavU/hDq?=
 =?us-ascii?Q?t8l/3Lc78RTgT8MI6lp3K8T0t4f3L8Ktv5qGwI80ssXjMHyD3a534hvyVhWz?=
 =?us-ascii?Q?Pj96TMbzJihL7mUxXPm1/cTStrGZNCU+ciU8v7rh0SR9Y8tLroIc4zaImjzN?=
 =?us-ascii?Q?IR9/oRO973wDQ+hC2TW0aCy/UqkBUJ03hhladXr63AkxuE68eyOwG6Q5FHpw?=
 =?us-ascii?Q?MvQE6WOOYm6LeWX5v8MxOy6hQBnKjyFMqa8IUmtGLp8OOizhLs8Mk/1FCioW?=
 =?us-ascii?Q?wnXTdT/v1vLgHhVXUanTim1HWKnOkui10c+PTcpOjQLEZK4HzsX0PlmrjVYd?=
 =?us-ascii?Q?hUkg3ABGIjaG/WzvqwVRHnfd468Rv+FYGeHvXjVC830HWuAOeWvvRnK6yU0x?=
 =?us-ascii?Q?r7pi82cVKZflqSHwFIEpXN44FbBTxYS5rwz8xtuJlp2PwXp+9xN0U8fftImA?=
 =?us-ascii?Q?Taj72KhIDuhCig0+a69jKECXW1N+SUb2yklZcIgE73FZi04XlriGuU2O/nbF?=
 =?us-ascii?Q?CfhX0nAKamLGqwNRynIhRVB/mYtYwnCpzrewstZB4TWsKABnA6peFuV+n9UN?=
 =?us-ascii?Q?TWSYpfPqcLfmqL3te0ojRYR1qG0GOxOA48cCiFKE8+yj+t6O+Vfv24/0FSF3?=
 =?us-ascii?Q?cZ5UGYWjgwEyvCWFGam2zEy5zXh6SS19PG6d+4Qi+SmwrlfVU8RRsmnqC7Lu?=
 =?us-ascii?Q?CmnG+wbe9FJQyCC/ssVd/Z/KCJQPOlOEfOzfKYcysT2lTv+7dAdC8r7UlOon?=
 =?us-ascii?Q?V0b+/dJ/oUVf7zSMR3ik7bcaaksAixJz1mfe1ARCK/LmaFId4uX7P8WXA8Lc?=
 =?us-ascii?Q?j0Ak21x3QGA7cACD4s/loLCAf8+QPQoW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IIXbVIsPh2mUS1WhsIH2Km7inVl1tSW6kmdvn0fiSduUofAPjb1CidD6veUe?=
 =?us-ascii?Q?yRGVtXXj5JfEfg7S3sNlIVok7rfSt6moJUmbC4q0CSctAizjv20xZcbHKRXs?=
 =?us-ascii?Q?flc9l1SVW6cjJRa3hWdVUbAJm+/g/uQBSDceElnLYKVwd8yDbLuWDQy2zzzO?=
 =?us-ascii?Q?SHJV6IFKY9QMtcnryioHHBIOD+MyRceG5rKJ/6Sb3MNCH9rtYHPRI7/I67TH?=
 =?us-ascii?Q?VdGhrfudOx2eVeKwpydGMmBDzAzk9WGSCAOehorH03Cbx6QqltDE7mBGDWth?=
 =?us-ascii?Q?vXTOua7Atg5KzEHV4dUyuMBGGvI6Hx+cMZYi+xxaZ53pjmoV+Cf79H49QcQY?=
 =?us-ascii?Q?kNUpQIpSyyVouDL3CYFIAnWN1+iQazANmT0BgQznxYDQOMkj4ERIbDyAd5kY?=
 =?us-ascii?Q?pOkFAplM2fn6vYMdF9jli/+pv3ai8VLPxD5NGDo0bt/3gClLYEoodHer3hd2?=
 =?us-ascii?Q?Ja414fSzr0hkx1hZqaO05hJi3iiyHKVkk16Rtf+mYzDLFhdAtufPQNADTl1d?=
 =?us-ascii?Q?FVGRTQNufA/y/otjUjNNUty5Kd5emGUP4QSi2+5TjNDI39Vh46pWh+C1dvOt?=
 =?us-ascii?Q?pIkkeFK8rLPgu6Bk6NyTcddfAypgLoCCvGqBQbiv0TyajBFpBtIs2joZY+Sv?=
 =?us-ascii?Q?rFX5Tyc2Qy713B/U8cvJU/PSPZNnxwFC8xhcrPGdc6FTjf/vanYrtPp9Jo55?=
 =?us-ascii?Q?Kq8XBeXLs1rPuFamyVI/uMmFnEqtCdL9sHuK6bp5kBHGDTxgIqmFb6VTXmnJ?=
 =?us-ascii?Q?da59ClEQh2Y9amokYTKVP6laJNtKnRzJqrBYMu/w3oJ+fhomoMC4DebwKHi6?=
 =?us-ascii?Q?ohdQAwatrmoBng3DGNKgeKt1Oq35y3kNpyTaCdbRK8wZAVOszcgp2O/MIQSd?=
 =?us-ascii?Q?lcSzMNMBTZ+OgP1urgRdfFlSuzhKmHLMm+F3gR2/MmxVakkE7kfkAUprVfWp?=
 =?us-ascii?Q?8/emPY/nYc4MMjXH0F9M3DL4xQT4mdcwQcq2gUuA7xH/BbjtX2uTgEJWS1Rv?=
 =?us-ascii?Q?ezL+5AU8JM/nwKcvF1TofDkCKspk0Xl6JIwR2mYXpPCSDNg3mQwsjRckPW2v?=
 =?us-ascii?Q?QhiLmVQueeJ6/OiwmKCFnSTx8P2fCzTsDGIEo23dnacWKHg97QdCGiS67sSP?=
 =?us-ascii?Q?GSNt373qSpDQXpTYB9a2YPhbw+lTLVazbmwstVghVlYVbqqYd//ys9JWtHP9?=
 =?us-ascii?Q?CP55r7sJyuia+FXrVYLQNGH2A6uEAyV0xak+pEXP3whJNKZ3sk6AYF24kMWa?=
 =?us-ascii?Q?shlA77JgiOMWM3W7/72JRK/52x9KNVn2dhMEKyPgqpl4V2SeBJMoa0A5wqMn?=
 =?us-ascii?Q?HXqjZuFQbjaH3vu6TRDSHQkbBUjDmqfw3XNI0y59+hF80ud9vJDQAsGwR2+h?=
 =?us-ascii?Q?GYAs3yRFSHtBDwB0Ewu8EFyW7J7sHT0lKaSWhUG6r7rdWCMjq7e4H7pWOGIc?=
 =?us-ascii?Q?jtEldviuisypYGWzZ+HY1ZJ54+XVKy1DKqdRLxk4VY5VMjXp1/T+AND/UfsK?=
 =?us-ascii?Q?1uqMaffkUG5W9x+1RmscoSk97k8KL4S0OvRi2M1BVrWegNS6GYYjGf+X/pNO?=
 =?us-ascii?Q?lPMotHhyo8fq0LVy449KErm9a1OYPYaWN1U/a4I6S1BSP0agq1jIMIcQuO7v?=
 =?us-ascii?Q?mO5e3nW/Sg/WjYtB/otKzmel95b2xmnx6zEthUwI6ztsSabdrZEqSLhVddC0?=
 =?us-ascii?Q?HgGojV5/h0ddS15tWeH8pegYjgxKvftOC1dfsz/uG1gZnInxxpVvOnUrW19/?=
 =?us-ascii?Q?51VtC1Gbew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdb233-41dd-41ae-b9e5-08de44272e23
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 02:33:40.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkOVOHN5NB0FYPQWjsOyj6yw/GnnlhJ/T5w/PCHqRMeWUETTx8BuhtOqGukCT5ZeyaTWOob5P6RzgVzpO/2LVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2

On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
> On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> > The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > State) design where the first FQS saves dyntick-idle snapshots and
> > the second FQS compares them. This results in long and unnecessary latency
> > for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > 1000HZ) whenever one FQS wait sufficed.
> > 
> > Some investigations showed that the GP kthread's CPU is the holdout CPU
> > a lot of times after the first FQS as - it cannot be detected as "idle"
> > because it's actively running the FQS scan in the GP kthread.
> > 
> > Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > GP kthread cannot be in an RCU read-side critical section while running
> > GP initialization, so this is safe and results in significant latency
> > improvements.
> > 
> > I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > showing significant latency improvements (default settings for fqs jiffies):
> > 
> > Baseline (without fix):
> > | Run | Mean      | Min      | Max       |
> > |-----|-----------|----------|-----------|
> > | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > 
> > With fix:
> > | Run | Mean     | Min      | Max       |
> > |-----|----------|----------|-----------|
> > | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > 
> > Summary:
> > - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > 
> > Tested rcutorture TREE and SRCU configurations.
> > 
> > [apply paulmck feedack on moving logic to rcu_gp_init()]
> 
> If anything, these numbers look better, so good show!!!

Thanks, I ended up collecting more samples in the v2 to further confirm the
improvements.

> Are there workloads that might be hurt by some side effect such
> as increased CPU utilization by the RCU grace-period kthread?  One
> non-mainstream hypothetical situation that comes to mind is a kernel
> built with SMP=y but running on a single-CPU system with a high-frequence
> periodic interrupt that does call_rcu().  Might that result in the RCU
> grace-period kthread chewing up the entire CPU?

There are still GP delays due to FQS, even with this change, so it could not
chew up the entire CPU I believe. The GP cycle should still insert delays
into the GP kthread. I did not notice in my testing that synchronize_rcu()
latency dropping to sub millisecond, it was still limited by the timer wheel
delays and the FQS delays.

> For a non-hypothetical case, could you please see if one of the
> battery-powered embedded guys would be willing to test this?

My suspicion is the battery-powered folks are already running RCU_LAZY to
reduce RCU activity, so they wouldn't be effected. call_rcu() during idleness
will be going to the bypass. Last I checked, Android and ChromeOS were both
enabling RCU_LAZY everywhere (back when I was at Google).

Uladzislau works on embedded (or at least till recently) and had recently
checked this area for improvements so I think he can help quantify too
perhaps. He is on CC. I personally don't directly work on embedded at the
moment, just big compute hungry machines. ;-) Uladzislau, would you have some
time to test on your Android devices?

thanks,

 - Joel


Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88901A92E;
	Sun, 25 Jan 2026 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352368; cv=fail; b=R7szlfETq9miMiE3/mXGVbzkDD9+f89iVNClXUwKGqtUxvqHNNRn1/ld9iTopDbDGIjDvYVlhOwBcqigEIBFC9okjMb7wzNp253sbxCqe+IhYwYawDBxtiJZa2h3kJ8hVWhNp0g9RTyncAAOA5jhIdv/EeSvedjvSYtxHrLZa38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352368; c=relaxed/simple;
	bh=D5UwDGX67psgmS9bFRJd18WnInrtHrboNfz5/nhZ7U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QQugA4BHzLYuVG6NKNYwJZ68z4z6DKruYD/tKG97QjddXtuaVXXDDikxP2/yoYBWwYSm7eisC5EwXsw2AhShqq1tT/FW7u1EsQCmsmAgikuFcyh7dXEykyxRXC7bMc+lnAWXY2tnMi8tvz4+yz94cGEZHZbYMb8eHqGEEkDIInE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNMZMKz9; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNMZMKz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDFOzB8YXOhXk/zcYyCt4NXGyByEgqF/klbb08joMoR3/H6PN9vIjvW2qeaGEQ2yVgNyQA6QNlyJWvBXYnY96ju9/9EkAWpVjoD7/vdzJx6X9il+F7Wn1FKvSgT/POdiDFwfVyS9Z4H+KD0tW2FTjj38ldrCk2/vsWUvtE/YC2+Pu822xB0seC+a2Hnc+nTx3fNpBvD2955tXcGF6gnt9GLgw5esg/MJV2jvlwBiJdkYHYrQUEby84J8SS+8iG4xggo20KuS2Ekithik3ZduQamoqUm/pUSZx0NEyz8SkhvpxenYJpPX4h9LMUeOyx8cUYrgcqaVOdcUTt43TTc9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CIwM1u4wRGKQGP71jmy7plSQT59xQktAR9x5/2BxLA=;
 b=Rbye8Xi39BKWj8j2OE3B0KAvFwoXqpgoXKll1GE+/ZwXimSIpahZpWiJMm4dWhCODr3RtwyBalJnja3suGgBJrnzMy4qTUa0jqQ8cK/bR8gsJA1YX/5lfjjg5fXlJHmQ14aHbGBxSpOP5iUpKIEYxwC1GsgMLObYrJ4wnftknsUL81xJdJaf0xSoEdoadTYiccd2qYaD3eroqZvLdSu6vUCQ2tWF6LGTY/rsF5ceiSqW2aSwmJh1vMjsjjyjCPDRh2rv1J7nb5RSy+SaC+ijEXQttsOou7GzSRByZ/y/YwhshflvuuFWMeiVcjNynEpYy1CJoDMlgUBJ8QccVM+TPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CIwM1u4wRGKQGP71jmy7plSQT59xQktAR9x5/2BxLA=;
 b=TNMZMKz9nuIbZFggmfcTMYFUQSYx9R9iLzHQnaKOrOKCrVDiAIusZWccndIVniHXNdqJiBCwn6u7z8XsaNWwH1jtSyZF/xu+FgN/B8H1FEMadb4ZLVZyHx7Cn1BD4/xYu/GhUGuzzA/TT46o2dRzU6HZWUkA63SLQ69QtiVBL/UhXpftPOw1m2VpOxA3EQ2FaiWtsQvi9ZCG74POLkNYKa+EIRTY3o9DOguPWlP2GKHwvTXyjNE87x7b2QT8q434fsun9Cue8ilIQMdqjJFhQyTnxUSTCGFarJyXD32lIMKbD1ku92M59T3OzOLho7Jik/9NTcWmGezIpD+MFOwkgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.14; Sun, 25 Jan 2026 14:46:04 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 14:46:04 +0000
Date: Sun, 25 Jan 2026 09:46:03 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <20260125144603.GA1679006@joelbox2>
References: <816a14e0-c06e-496a-9c84-512c76d98157@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816a14e0-c06e-496a-9c84-512c76d98157@paulmck-laptop>
X-ClientProxiedBy: BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da04199-03fc-4035-cae1-08de5c207744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRxlD1IUZetJ9IiRxClMHj5Uj1/Q85chOp1PUf20IEbwpDeruGz+erPyMkYg?=
 =?us-ascii?Q?NMelkhKyv4mN+kYWA6INSsdH3l+hCI+eove9OoutSFe7rZGQFZikprt+LGOd?=
 =?us-ascii?Q?bDRHcRMUOEMkHkBSrxXUucUYdWFG6SJlzUHTekSv96R0M82oP3eVR47WL1Cr?=
 =?us-ascii?Q?wJflqZafLBMXNJoTDMtINjMOoYO/9on88wocB+iwk5hT9kePlozu65GYxxCw?=
 =?us-ascii?Q?Sg0GCzxY20QJi/5Cv1ysKk/K513Jhn4suKUiHR4nME/yhLRqDciIxGKJwC/2?=
 =?us-ascii?Q?CzQsI2IXqqH648bKxObe2HoEw08buy0PjLVxwn6E5Uh8E0w28HNVIvXRfn/z?=
 =?us-ascii?Q?INvA0NN40U5r50wgfkIFj4+oCdZVMAASA6lTplSPJsDs+sFkC9nxqvBVD2yD?=
 =?us-ascii?Q?MoQABKLVg/fT4XTjQPlGQedvRQubVLWHna56foJj1nLT+w91mPv3xla/sKx6?=
 =?us-ascii?Q?MS7mpsbBfLF/S9WYxurnIGV6RTqIhic8aVAtYwglLhJZjb0ADnuNRJHaXhuZ?=
 =?us-ascii?Q?NInaQDmLYl6uGtZpYq1bRMHq/7o/kl1pIg+ChjbB9bnNz04XKX4MX0WtE03l?=
 =?us-ascii?Q?XLF/u3ece00AFuW1U2xm4O1neyIpHS4eHeR0BCwAEFEvhJZIUrkndtVqweV3?=
 =?us-ascii?Q?GvPszFF54fMvScFPmnWMEkcxYkH17k7AVXGKHKvYO9nBP5Sa+QN/xxHggwUP?=
 =?us-ascii?Q?M7hBdJ3HBhNQZRIZ7XLe+zlOJBdwKUgIXJnbhG9y+d2OMhH6RbpcZ9UpiqWA?=
 =?us-ascii?Q?EPRcxxzPxfUDp5+m5IYZlwB0g700blKZiCVQnAGWTjbn0vPGg5fwq1aIQ/kO?=
 =?us-ascii?Q?5pmTzCVWOSj5teGwuYRNHDxJewwQCTKDd1umLfsnbPFVCQU1KlMdYSky9yhj?=
 =?us-ascii?Q?MId5XEwcrbGfcQCIOWviK7qtjf6j5jMl/HT8+Bo1Tge6eAZtH6F5TIKyPSV2?=
 =?us-ascii?Q?8AFm2SEd1a8YmiPdOFJF7YL+qMgMiqvNBP1X5EsL7AfEzoBrFWszTsWNLYd8?=
 =?us-ascii?Q?FPm8MPkBwkvMYA5a2bIvsruAY8TjnzBXGKFHKH6bPqoal4fEdiy0yZSDxp1U?=
 =?us-ascii?Q?zLvlIqJZc8CurS3qIHVu3qebwxWnzoazhC2kqNwOmG63B+6nZgMtu+y74Lho?=
 =?us-ascii?Q?P844/DbpMEv12OqkafFqWGEpz+w2DyTo70gLZwuBOe5bFabg4T81Rsbjs/1c?=
 =?us-ascii?Q?d3jPGIq3r/UdqO9uR4rEZoakVRMyspYjXISOHpWW7k4/q7dQtMwV/ruSq7cZ?=
 =?us-ascii?Q?gTWOWnC13hZrnL8HeEwgULBHz5eCI5M+fC7xTTuVFHDyzhaEXj3qU+KNQ9sH?=
 =?us-ascii?Q?TH2tRr1h5s+F1CuiVOlOoPfjUdkcN1pGpRficyZcSOUSKmbGcVdwMzWdI/Uf?=
 =?us-ascii?Q?S2jc0HJbc1B78pGxhy04nKloItGgj/iAcQy4BqO0sCJ3jbmdmXQta2fmkK4s?=
 =?us-ascii?Q?nyQIlCxQMUW9N7tDTLCuLZT0/23uReXac/MFAfiX5Y/TkfBu/aKZXApLpPky?=
 =?us-ascii?Q?mKBBKwqh7KItlhXqtTYdLgCvdz3w9U2U8FAHuTGhLt23RfucJUf2Gs+MPdh7?=
 =?us-ascii?Q?ZUNYn8qw+D2wEajRe7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vbc/tcBHSZu9SvVoGOsOKeEcrpoDHOM5JtbbDhDQJGKWqhnbHUM9m61WD4yG?=
 =?us-ascii?Q?KXjMjjr52hA3jxx0Hi5w6+hwUGbMstHjTm4WoY+m4h+MW/JShWTy4qFWy7bb?=
 =?us-ascii?Q?R9LENV2YC3hN2kyu410e1M7DmsM7eMAxrI88/0mwHWgtT3/StG3ba7cZbrtT?=
 =?us-ascii?Q?xMsuB0RQaq3XdZWVI9PxnpAvhjfDYRamgisCmn+xGy6FVaLYScGqUSSfByuJ?=
 =?us-ascii?Q?syHAuczqgU7mnzsB0RhDIACIaOgn05/WlAjtMGSotK8T/14PASvEtAT403EA?=
 =?us-ascii?Q?gLUd8bTC+NNvyNyB71PD7hCUWS7fn/mKvJbBp5jnVsl7FNFJv86iKQNVoYjH?=
 =?us-ascii?Q?J7SWIeSILpZq2/TFSglaMczhxyMM2sNjHv/lss6DZOcAg018o7wnDgYuXPnc?=
 =?us-ascii?Q?it7ALM5vvvmFaNUAidRM5aNYjWbQR2R1AQ6umKWi3+yfNBExPWquRDKNeqrX?=
 =?us-ascii?Q?xEsbQgZFznF9bSWEodMJzqNyJw9iyJSnfeaQ6djfUZeCDxl+E/11T1CryIWM?=
 =?us-ascii?Q?wPyxzIs33vCL5/oyMsm9WHN/G3nYMx3EhRgD1OavG+6Z6JRVUFruO9RPlYiU?=
 =?us-ascii?Q?qsLxKRsWpm8gcy1wsH2p4/tKvHk6mw3ZxSQP5+6vJnAs+yW3s5uhwnwgd0i0?=
 =?us-ascii?Q?JbF0T6topb6uemlqwZvhFKLQpURI4qv7CJZf6beBMR1X2JPjoH34gAWzsNed?=
 =?us-ascii?Q?UiJMAaZTndMWRncjl1OWNBTMWtcnl2kLS90L7YrOlKyZbdWmUtx1EGQsaSh8?=
 =?us-ascii?Q?JymZrM4121dqaUWzjcZ6b7YYswU7vWavYmbkk2hFd+u5ZAxoxnve/U9sWaGm?=
 =?us-ascii?Q?FVFl2KK45zaJMn/W9bf1Z46oNmmpwZ8OT+eZcrcf0ULucNs164HNx/DFoNWp?=
 =?us-ascii?Q?Sw3F+NOqMh6zk1z/1BR9+tcgd4H8+vDYDPkddg/Dxji7p4SJZ4kQDYBiyXgB?=
 =?us-ascii?Q?E/1tpgl6LjDK+bjoIlaxVUD0RP/R4pZ6fg1RFgTq81Cfedz72OFF5jQYJhne?=
 =?us-ascii?Q?1CWCPGq50knMFdE16ccLyV/fZJxREa16h9/x91kywQwkUPiGexplPJzllwgT?=
 =?us-ascii?Q?Dv5NgpYkSUOq9L+zlTv8VFQwYTqDMxdwtbuv0/4nNx7tV6gwE37vFXuAx7O1?=
 =?us-ascii?Q?ttryWBXDvN1i9APMAY85sEPct/UKuFHOhhTPb6pw8yTiTIvUHyylJUX8KUK0?=
 =?us-ascii?Q?LVC6kMlQhWoo4EO9dS8ZkVul9dqGRmiZcZcA6e2uhMVloJ/V/mLgznGU2LeW?=
 =?us-ascii?Q?eYYoLy50IORFUEHpENf0h8KyJosBe8zWf8b9GBfGMOiMImXPf6NJL8q3y4Xk?=
 =?us-ascii?Q?XRQ1+bRn+qutz+cSDpxM1PW/H+G2917D4PpeZ9jTXD6w4HYk9t36/quX7800?=
 =?us-ascii?Q?IHkeTlp+XZX76DWl49Iu5T5UU638NRshJ8J/nrUOHFj8YrC6PlIg10dk3FqB?=
 =?us-ascii?Q?97lkZBpi1A0z2TLfciQ8LPJBZ6r7NGB3dRMqLcDjaBBG5NYAeG84aEii3CNL?=
 =?us-ascii?Q?QEppRIeupSxSiIYwXAmR6bMY6rKSbliRoxkTbU45qcOHcfHP5u5/Yi1CXrso?=
 =?us-ascii?Q?V8xNAKo6IpOBtglpTiDCOJXL2qq+PYU4JCShui0trrGYfGLsYi5batUAiFbC?=
 =?us-ascii?Q?2q0m/V2dT8LWd2OG7yKlkofl1z1pFQDZuE4akzx6GdPv6ReJ0WCGbNV7LTFZ?=
 =?us-ascii?Q?AMGEmW53HfGOXS5RsTeZHQfzoqQPzHeKlcCQnwtnAAJ/sVJhswMu6IU/cEXM?=
 =?us-ascii?Q?TN4mxw3EDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da04199-03fc-4035-cae1-08de5c207744
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 14:46:04.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EMANBHJnvO7RmaW+qMCQJ3PJ3WaTe31XgPrvDIe3oSqVatXDDBZaW31ZLNuXpoiM7zOrbknRq7Z3CAWjc66tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

On Fri, Jan 23, 2026 at 01:27:46PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 23, 2026 at 02:36:37PM -0500, Joel Fernandes wrote:
> > I was coming more from the point of view of improving grace period performance
> > when we do have an overload, potentially resolving the overloaded situation
> > faster than usual. We would dynamically trigger polling based on such
> > circumstances.
> >
> > That said, I confess I don't have extensive experience with polling mode beyond
> > testing. I believe we should add more rcutorture test cases for this. I'm
> > considering adding a new config that enables polling for NOCB - this testing is
> > what revealed the potential for grace period performance improvement with NOCB
> > to me.
>
> The main purpose of polling was to make call_rcu() avoid at least some
> of its slowpaths.  If we are getting some other benefit out of it, is
> polling the best way to achieve that benefit?

I only started looking into this, but there is the rcu_state.cbovld flag
which already does similar "extra work at the expense of more CPU" when
callback overload is detected. Specifically, when cbovld is set (triggered
when any CPU exceeds qovld_calc callbacks, default 20,000), the following
aggressive measures kick in:

1. FQS intervals are shortened making force quiescent
   state scans happen more frequently.

2. Heavy quiescent state requests are triggered earlier.

3. Priority boosting kicks in immediately rather than waiting.

These are already along the same lines as what I was suggesting for polling:
do extra work at the expense of more CPU cycles to reduce the overload
situation faster. So perhaps the question is whether dynamically enabling
poll mode during cbovld would provide additional benefit on top of these.

As you said, the idea was to avoid the call rcu slow paths. But perhaps it
can also assist cbovld too?

I will study this more :)

Thanks,
--
Joel Fernandes


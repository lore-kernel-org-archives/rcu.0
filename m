Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431121B9EC;
	Mon,  3 Mar 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021247; cv=fail; b=fuUu7iXxn+iwRbuGrtVcG9Zfo803uGz+6CD5qFc+vNT4PkfPCb+vcbca672ZIhER8ONTTYdrRBPYLhNqGlaBrZtN8hj7LKx+ppcjbzmjyuGZPLwxqoyV6ZXFBAUyswm5xDVzojDkEBar7VTgSKHHcivR5D6Al+p5ZYHpO4AiDDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021247; c=relaxed/simple;
	bh=RUuHMugkIkZ09GzCdNNDeWga3HMSm9yTWIayGoiZhHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBFdV/S1f+xN02JHC7IfPdl27kGrJvpLDbFJKsWPXYi7h/DnohDyLmT2c8uHNevEDlK3AOzXRnsnPFZOmh60gtoudfNBSLSOcl0cofKtXYUwh5H6usrNwULOOxfpcziIDSIy36kaIX4CXi7IJdlaLMRJX3wN0v9knDxXUwoBStM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7UVtoD8; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7UVtoD8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlAE48KBO6aFn287Jr5kxWZ4Fh7t7DfAlw95jjYcszlvvplaDw3ERgHFcQNpdqmFrKIiYQDnmnCd5oiO15KCi1/sV6kIwRiinBAWu3ac83u3FjgQ/KAVyEFXfyeBTRAMy0fT6huWwL+Zp3BjrtAT0YBFQ57wpFPW7i4pTREnMXc7crIKXG9rpHAyq6S2hSG/cM2TGgIOWzeqkkpapl5qNWBt7d1FvlZCmkHF5nwwBQCcI/n/2QRxnuQq8M6JAHHThGc5oHNnAz73wYpjFpNgVsrDDXyD8Hck5ucGGSfJzZrbrDNt9i5PUzyVyT1ThYa2Ys1GjseGAKGofZ5AiuoGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GFohvd3iZ0FLd3fbV6gxa8/7j1nhcexShxFVwgkzJ4=;
 b=fOj5rWYKdHLTTWQ9CFk2P2rxME5W+xIMWLYG4jlnz2g09Q6F09bMkOLjy8sCcMKrxTVCxrgFr44c5RbW4Lk2oZmHjh3S5c9Iv11bode71sEvhkNVT8e6vv/v0APxCBj+8UZG4kjWHweeJv68vBrHzpqNN1OQAGYWPxmfOxClcOGWoNSTPfGUa4WShc++5HxY5kXa4/NSQ21Uo0+o6eOLluKvxks6BOd04lbqxvTrKyZahb6+hfJYOyCE1FRf3DthxTdQb6/FY4FQU83nxaJwu35ZZwa3X/prC+b4c99JjBOmsvNg0F62CmpPdjBa723RVJLHxUg3ykNj49XGES/LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GFohvd3iZ0FLd3fbV6gxa8/7j1nhcexShxFVwgkzJ4=;
 b=t7UVtoD8dzuAGkkeJsozdils4Tk/BXghcJKTyJHQzC0feGBw6b6dt1fMFWlMnGN/XOR7unx1wq7YxgDt2Cor+IWSPPfyoqd4eYjkNvZ4xzk1AW5dq7aIK1S7RtH3zD8uQn5W5JjvxgNhuQuaD54sN/SVQ+0n75VGrJsc4M35k6WV54vJ0fqC9h+NmJQX7muJ6nB34uG59GuFg6CwYGa2KWcvccJ+7zMWW0XG6UDxHP6Otca0Xr8VN+mV89QALNrZmW8CgCwF7h48aNj6zriNHu72kV3xaOsCR9tJgu+hhtPs+0tJJsysnx8C64lNeDm9yg/DfVU6K4kmeVExU8AHrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:00:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 17:00:42 +0000
Date: Mon, 3 Mar 2025 12:00:40 -0500
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
Message-ID: <20250303170040.GA31126@joelnvbox>
References: <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <20250303001710.GA3997787@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303001710.GA3997787@joelnvbox>
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d640c3b-d9dd-41df-b437-08dd5a74ee81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdYridZGmYw3jJbgabSZMF6y4d9P6LolqsHKB/ctI5D9S5+pD7o4+2mHr51l?=
 =?us-ascii?Q?yAd3CtFttZBCybqf11oXtC+QHZsnDLYKW41QiQDdOcrXdOkn5IDOODF2nViP?=
 =?us-ascii?Q?PhFSrmuZrybyt6r8r05tJ2wmtCrgNgz//o/IZi1098bpSKvXIQExgfAsx7bh?=
 =?us-ascii?Q?gbUtdyHXZY5rfEXuoT815JaWMWlj1ptECl7ogVlOwFPjM9nZjFijLY40rDz6?=
 =?us-ascii?Q?K2wDivlQDLRRWpwWkRL6AUX2UF67rN2poArLpyHFQdFQNpNiFup2PCSBBoZc?=
 =?us-ascii?Q?pLRb+esUZO2hM4aBs4x1OWJuTWZTnRMAxoU+lUP9WTifuN2yRTtJpXmwDCSG?=
 =?us-ascii?Q?Z/BnZnOLGR478hUnPuHKob3qX7dWNWadB1FPaCV4FmzG3l+43kle5YOxqYtm?=
 =?us-ascii?Q?lIoRflLr+11QEiKCvM2Efs2Ci6kgO7D027j7PlDVWOM57rvM+052ySiV3iKK?=
 =?us-ascii?Q?Gi+9DSwNu0A+gsS0BnRLOGyejMLTyHXcH/PMcyUSrN3Lj4l+L7yqOi4jNvXp?=
 =?us-ascii?Q?FPVg1ENZBDR7XDfaHNcvY9bwknBSoJ7qVrYcPfxDSLWd0HGIfey+Q6GLGiwZ?=
 =?us-ascii?Q?ouGgtS4GxS5qPcv1UdN+NcfkeTOgreWT4LtkfKJE4QOD1g3ZzMrhnlVanhtZ?=
 =?us-ascii?Q?UoHv3bt/wRGX6isW5DEg6+bcAued18Z/6A5PJEF50vnpXbcbSUXPL4cXJa+Z?=
 =?us-ascii?Q?odYMz87spWYLv5h8hHFnptt6nz2/OCx10g/VVjeWHAgCTwvjb9bobY93bkna?=
 =?us-ascii?Q?qRecR3HATVOe/7VCiaAuLGzTuxCGLcB6PEwnFWneu/tRKJT8Cj/rqEmAFlkg?=
 =?us-ascii?Q?XBao7ImpokQmWi4sk8XeITn0PCONTNHVF8ogY5ThOFRCIufILNvUhEzcjUUe?=
 =?us-ascii?Q?30b23Cs0SdpFmGOZrhyXgp0d25InbZw7SvfgpPGOPo2QnfHz5ZButK7OjEXQ?=
 =?us-ascii?Q?r/iP8ZweDODt2huItg4COoahksGn+XlvnF8Xilywz4qITnvs8kPqbLNoxIzY?=
 =?us-ascii?Q?0XEnfd4PqdMW+EyK2ntOy0H+mXRGaPAGSu/NMxSUbFGF6Psdmw+QWGe0VPmW?=
 =?us-ascii?Q?01c3rVCAzlYxYr/XnNd44H6VaQXwxTHdOKLGT473i4Y0HAkQWpTHexdmJa0V?=
 =?us-ascii?Q?jvRp61Jf/It9t4eJnAYgxKEOLiTbttgTGRrwAQSVCZCWlT83a6DKZCEoOE8t?=
 =?us-ascii?Q?kk4E+eI7iZNAH23mkmFV3S2HznkWgTOb/XFnLfX/5mrNcHUJSqBycz1mDXXW?=
 =?us-ascii?Q?BmFq3mDBkcuD5yUcOcfllToeoVU7IRkT+aJblo78TzbjDzmFmuVPlXKePpP0?=
 =?us-ascii?Q?xtSEujaezWQTTztJmMpQGygjZdubtK77gB0nD7etd+ad3tE21u7teTqsGk0T?=
 =?us-ascii?Q?cIREfAD99a9S4zXAYz63I8TbQQn2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SfjRqpikFUOHtNKOaKZq8SidoAIOCRmXaKZd9P+UCci25Znz0+sP1E5N+EdP?=
 =?us-ascii?Q?zgasUnTlzlz1AOxgzT0AiPH+cOa4JK6sou71LA9rTfm/We0OlL6SPKXLnZiq?=
 =?us-ascii?Q?qR+HlYp2qDhyUCSKMtxbbAXubZ8QeWV1f6oaBQxqOudRrlwuSKWGM5SwWBv6?=
 =?us-ascii?Q?gE4khl2V7wfbSlnyUudtvJSVXGX75w31U311a3J3jLsGCFHu3IRDM//gInQO?=
 =?us-ascii?Q?RUS+5mTARY7jMwBA7XQF9KoeeKOnsMdkfhFmIYBdt7/b/GO9KjO2/lCoBAHv?=
 =?us-ascii?Q?ogh5DVtgAh3iuTrzJ5e6O7Eg5cC165BBXhldag7nl3/KZ6i0Fp5Pgn68KBqA?=
 =?us-ascii?Q?HUwqt8dunYqHEQuqp6zpDWh1jHaWK2DfuHpwBQCbO0qc46U26Jf/mgK8IOGo?=
 =?us-ascii?Q?pQEXlPqsSo+5RxJHrhZG/74R5Gh2mhdjfmypXCoYSDaDYnaiqhDwcjDRBhYJ?=
 =?us-ascii?Q?LCnaFsKdk8fFx3038yyJeNFbLJeGtkseVJU+bA84VO7fPSm2xXR/H/u3fYrc?=
 =?us-ascii?Q?AHMgeSHvltbp1i+yoQAkvQ4oJ0OeCvMRKjaK9Vl+2hwE4x352v8TQ8loUx8J?=
 =?us-ascii?Q?xuvZk9nfFNRFchouvxEfdiL+gvYQNruUiS5Cp7BjuqhrT7hOH4w/Ud02R5fA?=
 =?us-ascii?Q?jRujx27fuaBwfZOtuniccsgBpZBEWQK5W/0mtwU7ikYbIuOQElmW2a8r7MV5?=
 =?us-ascii?Q?2ekftZxkRv75mn3B5yZ+ppor3UJeYLDw4z/73wXCF/XlLaaelhM0PlJc59vx?=
 =?us-ascii?Q?N4P+7iW3tQUDljS/vhRNWcKv1lotq9Y3K3ByvwaHkFxRsjuGWL20ExwAm2j/?=
 =?us-ascii?Q?lvum5GDywOed80tiXTQtMHWcwwxaZ1mJ8wuEZCj3kVYyRDJHb4gIkLtFOKRp?=
 =?us-ascii?Q?/C+A33dgO6jiRj5+IQTwZQ1my5Ik94ott4D64xCLx4Xci1sq4kgJNBvZyUzi?=
 =?us-ascii?Q?owCN283q623IodsCXppCMnaTQ6kVx7x6KUwcOmYYFb+DFP24RN2ftjmHZUc+?=
 =?us-ascii?Q?mfQ+hYZ616LxFfg+dbl2Ab3NeOLuGcmwBRNRroXmEKjRCaTwlukN9AFeGr/c?=
 =?us-ascii?Q?foPKvBVEzqPNVKInQxHssXBl8uIJOUsYsGtdA4BWkjaSUbWf4volJiZf/RMY?=
 =?us-ascii?Q?yJzh+7v6b1LHDFcW2HPuSDRKfSvMWq6Y1lHHJelRhAe9KNUOpHMOdXSoBMhl?=
 =?us-ascii?Q?fRcqdszQYVkaHaRLeAKwcrhiCy6qnN9jQSvEm4TW6GToeA3uSHt1cN3y4rC6?=
 =?us-ascii?Q?FNGl+Pb++hK/dnxsz3ySgAyHvWZIJ8jIWUOVsdQAetl+4x9R6BK8dD+YmLj4?=
 =?us-ascii?Q?+Kv8n7w76g7HsX2YcjpkvqK2sPJ0Vt/lZMcHli4HTjaS7toGy7TBnaZu+YaE?=
 =?us-ascii?Q?xO/NUKZ9v5IJHTNgFD4viWhB3JOQikeYTOlBQJtPqiZqC5yTadxwDy31Jy18?=
 =?us-ascii?Q?OPSJqDyPx7BoG4W5aVXMhnsyVUSuofm/OgBf6y911j/hCxGlFK5cwHccUV+L?=
 =?us-ascii?Q?Dkt5Qzw1K35ezhSX52+cNivX891MmpVF/NAaXWPBnh7E0XKfzrFByO812Mdx?=
 =?us-ascii?Q?31SuoY0XrENhZouDSEJO8Q1VybSi8ZtA3CtY6pSu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d640c3b-d9dd-41df-b437-08dd5a74ee81
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:00:42.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9buRfMUwE+pBV8jEkXUlFwe4lkkdGRwkzIIKPDzeTD9GhOiRVsUizysLOJUdMnSN3EZeCL6gfOwn5YkcuQO7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

On Sun, Mar 02, 2025 at 07:17:10PM -0500, Joel Fernandes wrote:
> On Sun, Mar 02, 2025 at 07:15:07PM -0500, Joel Fernandes wrote:
> > On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > > Hello, Paul!
> > > > > 
> > > > > > > > > > 
> > > > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > > > RCU tree:
> > > > > > > > > > 
> > > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > > > 
> > > > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > > > 
> > > > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > > > 
> > > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > > > 
> > > > > > > I can trigger it. But.
> > > > > > > 
> > > > > > > Some background. I tested those patches during many hours on the stable
> > > > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > > > right away.
> > > > > > 
> > > > > > Bisection?  (Hey, you knew that was coming!)
> > > > > > 
> > > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > > > 
> > > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > > > 
> > > > Huh.  We sure don't get to revert that one...
> > > > 
> > > > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > > > do we need to capture the relevant portion of the list before the call
> > > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> > > 
> > > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > > Which does not necessarily mean that this is the correct fix, but I
> > > figured that it might at least provide food for thought.
> > > 
> > >                                           Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 48384fa2eaeb8..d3efeff7740e7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  
> > >        /* Advance to a new grace period and initialize state. */
> > >        record_gp_stall_check_time();
> > > +      start_new_poll = rcu_sr_normal_gp_init();
> > >        /* Record GP times before starting GP, hence rcu_seq_start(). */
> > >        rcu_seq_start(&rcu_state.gp_seq);
> > >        ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > -      start_new_poll = rcu_sr_normal_gp_init();
> > >        trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > 
> > Oh... so the bug is this? Good catch...
> > 
> > 
> > CPU 0                                           CPU 1
> > 
> >                                                 rcu_gp_init()
> >                                                       rcu_seq_start(rcu_state.gp_seq)
> > sychronize_rcu_normal()
> >       rs.head.func
> >       	= (void *) get_state_synchronize_rcu();
> >                    // save rcu_state.gp_seq
> >       rcu_sr_normal_add_req() ->
> >             llist_add(rcu_state.srs_next)
> >       (void) start_poll_synchronize_rcu();
> > 
> > 
> >                                                       sr_normal_gp_init()
> >                                                             llist_add(wait_head, &rcu_state.srs_next);
> > 							    // pick up the
> > 							    // injected WH
> >                                                             rcu_state.srs_wait_tail = wait_head;
> > 
> >                                                 rcu_gp_cleanup()
> >                                                       rcu_seq_end(&rcu_state.gp_seq);
> >                                                       sr_normal_complete()
> >                                                             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> >                                                             !poll_state_synchronize_rcu(oldstate),
> > 
> > Where as reordering sr_normal_gp_init() prevents this:
> > 
> >                                                 rcu_gp_init()
> > 
> >                                                       sr_normal_gp_init()
> > 							    // WH has not
> > 							    // been injected
> > 							    // so nothing to
> > 							    // wait on
> > 
> >                                                       rcu_seq_start(rcu_state.gp_seq)
> > sychronize_rcu_normal()
> >       rs.head.func
> >       	= (void *) get_state_synchronize_rcu();
> >                    // save rcu_state.gp_seq
> >       rcu_sr_normal_add_req() ->
> >             llist_add(rcu_state.srs_next)
> >       (void) start_poll_synchronize_rcu();
> > 
> >                                                 rcu_gp_cleanup()
> >                                                       rcu_seq_end(&rcu_state.gp_seq);
> >                                                       // sr_normal_complete()
> > 						      // wont do anything so
> > 						      // no warning
> > 
> > Did I get that right?
> > 
> > I think this is a real bug AFAICS, hoping all the memory barriers are in
> > place to make sure the code reordering also correctly orders the accesses.
> > I'll double check that.
> > 
> > I also feel its 'theoretical', because as long as rcu_gp_init() and
> > rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> > synchronize_rcu_normal() still waits for pre-existing readers even though its
> > a bit confused about the value of the cookies.
> > 
> > For the fix,
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Oops, this should be:
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

I see the original patch "rcu: Fix get_state_synchronize_rcu_full() GP-start
detection" is not yet on -next. Once we are convinced about the fix, do we
want to squash the fix into this patch and have Boqun take it?

Yet another idea is to apply it for 6.15-rc cycle if more time is needed.

Alternatively, we could squash it and I queue it for 6.16 instead of 6.15.

And I'm guessing Vlad's series is also for 6.16.

thanks,

 - Joel


Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E15101E6;
	Mon,  3 Mar 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740960914; cv=fail; b=US8nMpWjbhaN8e7fyPWwLNW7MpEN77m7hh/ZzbWEr5v0Ctq7MpHz3IqFPgvxRO6QJpRUQLrXYY4N8gkFYwoauOq2qCubore/vDL6AvtWDypiK1KrKEb8H4Dv3Vog1Qy59pYbbX9HSdR5iyObt/ivS71M/C/70BTFZPA3D/yaXnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740960914; c=relaxed/simple;
	bh=74hDCKhZM4F0Us7Gtz9rDBiT2IO8QQ21ZLhW0xo+vFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eftjBArGLtV0hNlvH61aqLFs49VbMzh2B2GT0cGlyCPYffqPJ2vubMHIgON8YUHfE3/EARVPUaCST6ajiyoHslUADJljFHai2Qk2qRij7qdf9PUrLmt4kwvWZMm3GDFTy9YAXNNcB5rttu6lf5DqUoDj2Z8s3wiJWOJRvyYFwnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q4NMQR4b; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q4NMQR4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUpCIrGT3QYRujp3iN/ZZvmFTauJXU1GNWpqnUwc5kaj2EVY30qG1oKrJAZasXix+iWsDvFUFhrzSBik5ibgLoRy1dReHTvVctqdHRhaxCg/MU6xFve0EDmVAyIfQ522ycXWIem4yn6ZNPux7yCVT3Df4DAb+JOiG3nnmwF9kkMBhfZi/Oc4yVof1WBdY8VLAQHS+JJNSXk3AHRVz66ytrDfSQtBC5Qj7uIxbgfuRmRdKC0wgNz87IS76485L2zK5qhn7QxAKcYNp50n8MjyT+8NybTer+eQP0VHyhN7ODtOHC/xYxE0yfTWLCutXi9/ZxDFxl3P8b9YpD8L3jbYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1Sv4M39kKr2JxV7VtXBFA/WUX9vAgevDkiTrkrv3aU=;
 b=deQG3sFz3QdAvOdyJ4qcmYGRKPckRafIw4uZAakDzkHcahUqrSqC1kVQyyVSICI79aNhO7fjx3OFktt8UO/yI+1He5+J8Uhxsk7A7eO5qLbjab5ylXmUt4D4RUn1HFtebZxLBsMY6wLNOyMcuCYIS9vB3K62I778s3Laf3vMKVgLXmELs1ABBzgiJ8VhgFJi5hkhzC3ufa4wBaqKD/CHiCuqHo7pB/g9FpmKor+TRLDHY056x6xAwB1jESqKUQ8DSM6qTMNH3ivjwL/nfr0qgGzuANBXVAe4h7j+DHPHk12DzPNZfLAGW/w2xMKoJTiJ7OTJsv9IufhUwuLWXhxvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1Sv4M39kKr2JxV7VtXBFA/WUX9vAgevDkiTrkrv3aU=;
 b=Q4NMQR4bMW1WK2BsOcAkJuulw/GgOqPcQcrCo++0VHYUSnTJQUmUbnfP17c1/Q7m6c77yu3+hB20MyQ4n3EEalfSgTAVm2MQ3IhVsyaDyH+z8sqbHWkypK56Fq6rCwckHt/L7jYWu8BmJ/DFik/eECBGX+30pBv/sAsvDhT47l8/iclgC5kqhbvmF+9+MUzUdFDexMP/dNxE9tVnrjRvWon0InPqOc8+J7KyIsogY2zPWDD5xo0/fIQLpY5uDcGdpuQsA4EcrGh0u134Oq9jJQDV4xflrDikzgG1KrsXjb4kGTi28Zz5vKoxz4l8wqhjE+FxQ65HSav6Iw9yYSZWIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 00:15:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 00:15:09 +0000
Date: Sun, 2 Mar 2025 19:15:07 -0500
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
Message-ID: <20250303001507.GA3994772@joelnvbox>
References: <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: fd753225-0341-4f80-78fd-08dd59e8756b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gY8N8I0JHP4rZivahW9QC5zXu6Jo8xMp21ogOyZq04zE81CsCXFCXyhEuhIO?=
 =?us-ascii?Q?rzh9jn8mQHp0961a4wDwNYMWg70o8nHggKB/6t6XKvXxx3+dyzSwjPgH9fNa?=
 =?us-ascii?Q?JiZPBT5ii3Yiz2bndK9kcryWBP1P643mEow8mOA7z++fL1LYEJc4FFRfMl7g?=
 =?us-ascii?Q?mHV7aN0yeV8wsOoGVGIMoAF7P2KcTVv+z6VMqvRUHzq2c/FzKiecNnNGTHYj?=
 =?us-ascii?Q?K/ZBl0Pf8srg22dtXWkCJPEogQHMHoj7FRqolO8pKb1CREucEvFdqGamKp/O?=
 =?us-ascii?Q?zqjE6HpFgxJm0QAokEzz5/pQfy2rAc7F3lU068BWSz/op0dJy10mUSAjcZqY?=
 =?us-ascii?Q?/tbaKnkZMiETrzEst4FDp37FTXA4pd5j5oabwF3OQZcobHBFNGVmGAl/lsIu?=
 =?us-ascii?Q?B8EsJZqxXMNw/sulYfqtYFfbXeGN0+uT43ZJOSIuz4wJdyb4U1usV1fbEAaf?=
 =?us-ascii?Q?FRgam2JyQAfR6DORGKcVCrFBUDbeATrVqUUqbMufBTX50pnL0qaHqjxynFhL?=
 =?us-ascii?Q?bSfuIuDk0jiK3DD+uv4zUmO1/bGgM4IgHcW3Ce+3CAYy9BV1eP+v3I2LyuHL?=
 =?us-ascii?Q?ThJAsiDLsDdul1cmoT05YGf9e9L2V3aiLS/WbpUeM1hdYh1xoe9DRh8s5g3j?=
 =?us-ascii?Q?1VCBxIC3DSJEm1IeA5EOTHHrTDn6FshsscqETbYxxlwCRdgLpTy7pI4+fYRw?=
 =?us-ascii?Q?WD1WOARAHWYjlfQHZ197zxOxRcaohLAOdBRdtwIt+xU0Qts5Ery+jC2RvQNL?=
 =?us-ascii?Q?x70Lfq/svP4x7hFOT8J8lLlQllbLD1VjLv9CL/abvJetSgf21R2RCfVY6bRw?=
 =?us-ascii?Q?wyvNJI5KEjLrc7KewOEgplBqClYT+Vwh8AfYysexcuO7u8nXIShKyOecDUOX?=
 =?us-ascii?Q?Xo552KycgjOkVm0z1yeKmf8u5Ii4cJcjXOIaEmvCJiJ2hQk59Lnx543l3mGR?=
 =?us-ascii?Q?oe7EE41jnFmJl9u2Xf2AmtdPQxC0ocI29CJ+ztR8sQsrXK9r5OEcHsEixa2c?=
 =?us-ascii?Q?o3PTo2mz26q6WBAHRmlbnwDWaKNQBJg/ZJDJqGX4metlCYbUPkT9iYTwT321?=
 =?us-ascii?Q?4I1pypENZZsZQxpecLcAndqFYTe29tgT6Q/Y9FSfnkwYhJ/lDzBONoWdfAJE?=
 =?us-ascii?Q?YyfmNC668fHm5+CLbxEpHzab+jz0gPHSVRZwigwTq2qK85KCdiPiP5lGb95f?=
 =?us-ascii?Q?V18bUVAm+vL1/cg8lWqCJc6sJHydTMsO3rNxwbPuscY8UnW2lYaXP+AmwsO1?=
 =?us-ascii?Q?JS8jGvxzSHZDILE1Utd4tuzRCp1mtPeJ+nF3bHO2XvahQ7N2qWS5FHb7rHEK?=
 =?us-ascii?Q?w9T+0qjkz56K9jsSnYu28rtDgT2CKOCp92rXvqJb5B6DH3/2v6u1KSgm56h1?=
 =?us-ascii?Q?IgrMwh+sFVExS4OUIlPRgh70qKfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ab2mbdNG/XIjoag0lnytJHhMJGw6xHVSoVf4yJg9Ksp9LoCLslnmPVjLE3i?=
 =?us-ascii?Q?mhG8c21elj/f6JmEliv1PX5htFKt49PJcMt4HB6ktkK8SOx7gPwCD/2UfdNw?=
 =?us-ascii?Q?AWU1oBxgEGSlCrdvT/fjJW1VGkrHgAFIhMOuNVX4jwCy8k/xgSyrDyKZ9dUv?=
 =?us-ascii?Q?jgSsYEvM3D5ZQBpknAaITUKmOCl272yr39Y6wuu0hvqrwM+mBdkkR9ML5iWW?=
 =?us-ascii?Q?EWo8h1sQll1u2TMIPiOAbB7nsVhq2Hx0JZgnnP4twpBCgXcG68F6rL/gulpb?=
 =?us-ascii?Q?WgZfa3CrLzpDwzxroWFtOc1Am7BJUU60Q1GBXoq+Yzya1YQhBONR5orDGvgO?=
 =?us-ascii?Q?elHvsxWKlQx8JYtLq0sFz8XyuuOEJeAdz6buB/j23zFt/P3qvMHg7AMOaTU2?=
 =?us-ascii?Q?3xzEipsi7PH4R8BUhFbDJjJp8c17kkS4m4UMRtc4TM/DgzgErwti3sp7Q12P?=
 =?us-ascii?Q?fzjnGtTWAcm17eP7q5qkBo1IY2XOR5GqXaTU2S2sIiwSQgVYi9nKBd2Hkpkf?=
 =?us-ascii?Q?2kuv8vDsywlP03QutQ+h/uhKfAmdjAGOMxZE/V2irgWbxfJdh/A0mm4O17b/?=
 =?us-ascii?Q?oy3r0Ggems5nCMdb/ys8spV75qrIVac9qjW1l+qSrcpWsvRqGDiu44tZ7q8B?=
 =?us-ascii?Q?oqYIColcf1I0K5Hi/NuHoa1Df8fs8vBNDEpCXT3cnpEF52sjh696/ZbV+fPn?=
 =?us-ascii?Q?t82+wXKUMeOmuk7ogKojYSj3RrSVp02MI61Vrn/jUaAEOvhO1z089Fcgfes8?=
 =?us-ascii?Q?sayS9XGGFpxvMZGmJqwSTbO2ZLLEjum06Fmgb3b/e/WIaeZuUiYuK8z77fst?=
 =?us-ascii?Q?HcjyF+ZoMiC6SSok6NwyPrAk5+6CFkxkGH1bkMBly9AhtJ1v0LCRcQUvtI/h?=
 =?us-ascii?Q?2mJ6H3rqmMSBX2Qw2mk/R//URhybpWJ1bb4yaRROciq8/ndjIMQ0P2r/VWKR?=
 =?us-ascii?Q?r5/IDeSkXwvUc1Nyi+iui9RuFhKMGjAQwkO4u79yfxFj1ZfHe1mNAobVYayu?=
 =?us-ascii?Q?acNpgZXrGJQ+09xIpc7Z0mXCGFs7YDLEY1Wa+y8FhVT3h3VWPRnTDQVNxgYl?=
 =?us-ascii?Q?d/XfUIvlLIKsIiETpPDEaeZf7tjbqvFwq+88rI6Ur8V4ixnxZHzsmz87ejEj?=
 =?us-ascii?Q?L/HeSbq73eby7Oa0zEpvqs070E+rQsnCD69JkA7Qtor1ttyaS7CszmFkW7VK?=
 =?us-ascii?Q?hgP3exTku1Mt5/fMR+JDuIHxUqYOybAblaMma37GEjvdQAuX/LXib+WPx/bl?=
 =?us-ascii?Q?fHNoErYP7mkSFmbj+K3KNDjJxb5DV+zgOCW+nYgP+vdqOs43MP7RreJ4jup8?=
 =?us-ascii?Q?798wSsN2LbbZOD5RSqnXepKaCZ1avr4TuEYzyqaWcad7WOHcxEC7Ix+6wVcE?=
 =?us-ascii?Q?JthN2kRmN1SnHMEK5yoEEG2fd9pph3imYJ2wUbJCDpEvvZEJtMnwc07sgLHW?=
 =?us-ascii?Q?3EoJK9W/zyPnwKckxi+oIpNxuE9G/emH0YK8E2j5S6H/2OzVdhsZjMvOTlkF?=
 =?us-ascii?Q?Ygk4RdD1NyfVzgK1nID3XXT0tKa5VyakPF86b7gxvx3+0Fxtu0zSd1D7qKKx?=
 =?us-ascii?Q?a/+TV1XcrdwkcFX3EHVkzSrAPNsLfpbxvccpkSB9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd753225-0341-4f80-78fd-08dd59e8756b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 00:15:09.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuvnFt4wwAYqZhj2WyBQw7B4jtr9f2ZSd9lly4sNgtGtbHWUlKO5qepXXlz4D8WxsTt/B1G0Er4dTMtY532viQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > Hello, Paul!
> > > 
> > > > > > > > 
> > > > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > > > RCU tree:
> > > > > > > > 
> > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > > > 
> > > > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > 
> > > > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > 
> > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > 
> > > > > I can trigger it. But.
> > > > > 
> > > > > Some background. I tested those patches during many hours on the stable
> > > > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > > > right away.
> > > > 
> > > > Bisection?  (Hey, you knew that was coming!)
> > > > 
> > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> > > 
> > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > 
> > Huh.  We sure don't get to revert that one...
> > 
> > Do we have a problem with the ordering in rcu_gp_init() between the calls
> > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
> > do we need to capture the relevant portion of the list before the call
> > to rcu_seq_start(), and do the grace-period-start work afterwards?
> 
> I tried moving the call to rcu_sr_normal_gp_init() before the call to
> rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> Which does not necessarily mean that this is the correct fix, but I
> figured that it might at least provide food for thought.
> 
>                                           Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 48384fa2eaeb8..d3efeff7740e7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(void)
>  
>        /* Advance to a new grace period and initialize state. */
>        record_gp_stall_check_time();
> +      start_new_poll = rcu_sr_normal_gp_init();
>        /* Record GP times before starting GP, hence rcu_seq_start(). */
>        rcu_seq_start(&rcu_state.gp_seq);
>        ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> -      start_new_poll = rcu_sr_normal_gp_init();
>        trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));

Oh... so the bug is this? Good catch...


CPU 0                                           CPU 1

                                                rcu_gp_init()
                                                      rcu_seq_start(rcu_state.gp_seq)
sychronize_rcu_normal()
      rs.head.func
      	= (void *) get_state_synchronize_rcu();
                   // save rcu_state.gp_seq
      rcu_sr_normal_add_req() ->
            llist_add(rcu_state.srs_next)
      (void) start_poll_synchronize_rcu();


                                                      sr_normal_gp_init()
                                                            llist_add(wait_head, &rcu_state.srs_next);
							    // pick up the
							    // injected WH
                                                            rcu_state.srs_wait_tail = wait_head;

                                                rcu_gp_cleanup()
                                                      rcu_seq_end(&rcu_state.gp_seq);
                                                      sr_normal_complete()
                                                            WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
                                                            !poll_state_synchronize_rcu(oldstate),

Where as reordering sr_normal_gp_init() prevents this:

                                                rcu_gp_init()

                                                      sr_normal_gp_init()
							    // WH has not
							    // been injected
							    // so nothing to
							    // wait on

                                                      rcu_seq_start(rcu_state.gp_seq)
sychronize_rcu_normal()
      rs.head.func
      	= (void *) get_state_synchronize_rcu();
                   // save rcu_state.gp_seq
      rcu_sr_normal_add_req() ->
            llist_add(rcu_state.srs_next)
      (void) start_poll_synchronize_rcu();

                                                rcu_gp_cleanup()
                                                      rcu_seq_end(&rcu_state.gp_seq);
                                                      // sr_normal_complete()
						      // wont do anything so
						      // no warning

Did I get that right?

I think this is a real bug AFAICS, hoping all the memory barriers are in
place to make sure the code reordering also correctly orders the accesses.
I'll double check that.

I also feel its 'theoretical', because as long as rcu_gp_init() and
rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
synchronize_rcu_normal() still waits for pre-existing readers even though its
a bit confused about the value of the cookies.

For the fix,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

(If possible, include a Link: to my (this) post so that the sequence of
events is further clarified.)

thanks,

 - Joel


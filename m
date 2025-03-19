Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447A1F4164;
	Wed, 19 Mar 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413119; cv=fail; b=bhXAleNLu4A2j2T4mvk2TZDTueWARetL3TVPBeRFy0i3lS3dsjpikY3X3BnCgiAEA7BNJJ7+KM55wDTe4gDh2RQFbRnp7oCKiAORroy9Mq8qDF92z52VVlxgLmpAXsqXkU+iBQt7hbU/dxkP0E1L1/ytOuFG1S3wJ2H6xqfYf58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413119; c=relaxed/simple;
	bh=bdChecd0vw9FidND0JFOHwIe98n9J5aeePx+gzC1cBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jit9KuCkwSBd2+mUso3UT3VZmOhW+2whRNRh/rXwZjwzdzb6vgW1n7ERw9Uq1uaDAK+7FzAqwhIFg8cqrotwjwRmIbdPzPwK5mnQwKzfzBemznfiXoaOkGGoLIR4cYndl4B0NNSuPp+b5wgvLtVJSF9g2bHI/rYJOvz5NqNLCaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDnRKDK3; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDnRKDK3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwxO5FeGohNpPZjg99F6Ru3ENLP4gt1fbHEt6UBu3PqK1xCKd2ls/n72M4Y8XB6d4wbxazg+lNazSeN8dD831z/Hbn4NhqBSRf+fh4dIUVLt7ErpHgpfd2MpXwJisxmgjG7SyLtYF/vt8j92PMNoGdbRfdSwse58oJYapQWYM1GjlPeFszNSP4KIVVVPcT8DwstiSE27b4/VnbUkMjahsWrZyAn44626zhJ2+AN+Go44HTFVp/mtLQUOUHFx3FKMIcp3potcnkqKAgUAf+3uaImi/vqsj1chNeFUaN6rRoDVRT2xp1LoW1mCqLVfBfSydsAAZWaqIck7/DoBS58N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXg/R1oM22SjCvJz0WNqZdY5Ore97jI2GFVkNHFLmTo=;
 b=k/ErDacSQKO8LBvxzAf9HpGlHBpQ+fdrhz6/OL2gP9hFRCcaY4r1a+m8ZtgNuzXNLZHt732qPpo/d/Q6iEb6ld3hiGgJK70E8QEncyKpl7xaRvHHEdoAUBW409aN8Jk8Nx8lHvTiUzSC60HFPqU/SlSXs9TpOqwicc/mvNIzZYSxH2w/k+20fN+PMzxM6/qwZyuxmNboD2+X6ipH0rQ+5dnlcuny5tSmexKMH8ZecifO5RgaPAyut61iWtCknap9Nb1znLhPWnUtYPqAHe42wM2r9atfl0D7xMHs/1fr5Fhy57RLZaHjTjpMgnhR94OOrsdHjNkPoCZMM4dimmJMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXg/R1oM22SjCvJz0WNqZdY5Ore97jI2GFVkNHFLmTo=;
 b=mDnRKDK3kILPCa/Iwnjre+vvd4hWXa0CMv1bCTBDrMLqP7yMWa5JPHIM8CeDQBtvBMeyptkVkjvjTjqsWv4AI7TSWkiJM4yiaEW+UuJrereTw8lU2RVhMwTyVrSMKyYA72afe+rn+p3d08wuD6nzM8Fwh4Mt1Yuh1MYsqv/TDNbOzv4rG321OPjSAvdfMK+hmYj2blpxA3mQAMPUOgHM2I4nOKzm9zYgLmvlfmKjyMuNkLBl5VH0+CQ2l8hjhNvQeBCfky8c0thpXlIAzlxOVcRRDmNUoCPDk/M774QRUqkmv48E7kO37tg0dZoW5ccF/TXqXd8t5xoAi2++QBMVIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:38:33 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 19:38:33 +0000
Date: Wed, 19 Mar 2025 15:38:31 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <20250319193831.GA3791727@joelnvbox>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
X-ClientProxiedBy: BN9PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:408:fb::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec0d284-5d56-42c4-4dae-08dd671da24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IptOEG5rp7pkFdbkEsMr0aW5mTzLdc6xB3KagSE/rNmudZKfmsvNZ64yf4V6?=
 =?us-ascii?Q?pGgaIeBwwdtDGSIbjN8PL7BdwAV96EKWqidrz0BwGxUM63aku5CtbvCdyB7O?=
 =?us-ascii?Q?nhywRbHOBrIIVmvnF2lnV6n9bI8Ybb4zmCxynDhIpxzZT0MnH6OCruzN0UH7?=
 =?us-ascii?Q?tsGbcAKf9s5tLrE2ypJgOPWosNUOxaVYxUVBq5UiTVY6OXmi1XnSYNwpt6+x?=
 =?us-ascii?Q?7HBDkepBPJwI0sFdSgI1Y/EW+1kU2GSI79/2OPQhItR6+38jZRD9JfRR03Is?=
 =?us-ascii?Q?m9YM7NZ5hGKLg3xRRhRTHG606e83DIfDVReaHQRtU316sp0Qgo0usAghTLod?=
 =?us-ascii?Q?bnXehTdYqIuyJ8wrqF5DHVd/t3IFPSeNjVUemhJ9m+Wj8T+OhEGeaFC3eEzv?=
 =?us-ascii?Q?PZX1CnDV4byNAEvexz98kPHXGo3Xf3OA90zBo78E+nYxIQwmJr+lmntpCi8u?=
 =?us-ascii?Q?sQDl5QcN/9qmbkKsSYqz2iXlhLAPPwB2BQKfpcc4MgeDnMgKWvJCDUvcXgqP?=
 =?us-ascii?Q?MCUZygp/J0na/FhevZCLFohOf6bRFDJXr79DBKOlVlX0k+b1X4WIHysdasGc?=
 =?us-ascii?Q?A0lZk7kanlWn0AehvtIHIs30AzgAYJ6PoijrDj5X5e0cD7fLIyWPCAVzoIZV?=
 =?us-ascii?Q?EFmbhf20xqMCfqMSY/xq3pOFuxDw22WrZYPw5fNFW4AKiHGMMlx8phRb+ea6?=
 =?us-ascii?Q?4KyJA0af0UfpGr1+P1ByGMfpYaxawxKNFmNtSID5jm5kIWw9Nq/dA4/q7P+2?=
 =?us-ascii?Q?wQqH//3ftwlS0wn2K3bL6MenZvu/HtyyVstKfPItaE7ky2XgFqtkVXnsyhJF?=
 =?us-ascii?Q?U1m+J+5asG+Nu3gpqLv5hLcF40n1xXLwO89/6gj39F9JGfUiPpb7WOj+SLWb?=
 =?us-ascii?Q?I3yAXiZTl+x9f8GC2olZxg7fQPANxvK93mb3bvjj6URpyPvkA6igh7kzkiRA?=
 =?us-ascii?Q?IFh752C189plvlD3ZTmpt//POG0ITW1VDE3MzFplxUrQ/zBnDVIb70BZe4o4?=
 =?us-ascii?Q?Oh0Vssz3zZeM3wHXLk9fVBQtop6Lr46Xvw/8IepO0APB/Z7IX2Fw9lwMqrUk?=
 =?us-ascii?Q?yH+SnBy1VYrTcKyLsP1ZeMtpLG4CFY/098f57xSHNLMg9miBkhIEQH3ljzYy?=
 =?us-ascii?Q?91mUyHe0BY6W5ajqCVQGAjq/agted8TgDufu8yL2MXLbnUZUhL/6rY9STLYo?=
 =?us-ascii?Q?TPZU2FOgTTsH718fbEHQC50pCiJmpDPTOHcR0Nw+kHeelDYUx3+8HZY0p2ER?=
 =?us-ascii?Q?nHKH231x+5AYpqsdtipA8rsE1QPqqwJU0Vt7dd5KL/ucv5vhCCMlyTcEHuoS?=
 =?us-ascii?Q?agp/aVE3JWg6ik18nG8M6gRH47hWr7B53C6h0Mhat0A4FNgoT6+YiAXmk77l?=
 =?us-ascii?Q?wth/3U6uCA6eCuvxQp9FgdZarBj/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p17BI4jQxJ1GAWsOuWQYQ7RHieqg+MDLGvQw46sH6hZlybtqVaz43nwDatjr?=
 =?us-ascii?Q?6lDthfAbtMXrHtb17T9iavjpqFzqRRRvO8OoE8sBVhC6nq3/+wsUYG7hnK5s?=
 =?us-ascii?Q?hexVGrx9cDuvdlGBd0VpAwUI5bH9d/fjKoupq3k389hPRq8FZFp9gGep4T8y?=
 =?us-ascii?Q?MQC0QxmZfmpd/cDMZqf1/PkXMJTvcdsI99JIIiIH1Hbc7Q4ykChkmeZqA8/D?=
 =?us-ascii?Q?KXRypC6143tn1SGuhwjPNn30v0w3UnYTOhHLDJMKGaUlr0u8cFqpUbUyc2FD?=
 =?us-ascii?Q?L+hSVqQlaFWNKXlM2rhutYL9Z8xNHD5vk80o64fiKuwaEkL1s3ui02+6RnKM?=
 =?us-ascii?Q?LPrpwntYvXdKqiC6TlpJHIA/tY5h5hk6AcXg7KFIAagPCFFUoMsIRRV2oNh2?=
 =?us-ascii?Q?5fUYBPQBRODW4tSGGnrHj5IOLu/H8dun3liMilQAiG3Z8vGePNhd99k3UTRx?=
 =?us-ascii?Q?9uv0DfOGwQLVsgH4EPwtOaUSkv/lDeMtK3FgAk8VBE921mweBT4ATjvWgFJl?=
 =?us-ascii?Q?SECqwJ2+1fsh3K+uhDTx7cr8AZaHJ53fkx1/hC0cmOxmlGi5n+hY0XPzopx0?=
 =?us-ascii?Q?TSc/cD6dskmxASWozRPAapcmUhX/oMqmjHISegHTDLJLq2zXBq3wEjioEKUu?=
 =?us-ascii?Q?2yUyN0d6rHbQ9Czob93D8cQWhftqPcHUZWanP2xW1hIiwbyACP3XzUUIN07e?=
 =?us-ascii?Q?mroeNRq9DhOLoHdFgHGBQAgkL1eq2+6rQ03YBIcVyXc8VCaKp6OENNZUErbP?=
 =?us-ascii?Q?qbig/B4mZMzcPg+vNm7nUzdRb5VSaqK6lIiMEltmjocQcdD7xp1xLdvd+6P4?=
 =?us-ascii?Q?JYbl+nHWOO1Azo4h1TWfLKmiWQY2wQLm9pvJOoEQQ3BasdmJF/Dfz+Fz1T1N?=
 =?us-ascii?Q?f6pzpNG0z4BY4cm73tHtu3ZtesQK8J0pncNWZiAMcv+3lkbWho7XTz2YpKI0?=
 =?us-ascii?Q?1uBVQTTAF5MoVTsweJ7R9Menq6YQiqQXuF5gSIIuF4C1JFEUpYDrY02rZtD+?=
 =?us-ascii?Q?Qx9Zh54UHPNMLrZNaGfnCr5f5T8VKdND3ue7/PsOD7GiXstiQ/PCHuoyjein?=
 =?us-ascii?Q?+oJqsZ576Xrqg/gHqFrL56RnPsVjqtlHEwEldTlFTctWKFVVxqG6jpYk8IRd?=
 =?us-ascii?Q?LAxWWZREAioD5vFAGvZOkuZlNBe4pf+xmisS+bBUcI17GHD4tZjNKt6Y7CKR?=
 =?us-ascii?Q?anTzFNf/12Y2p0CsaMgtjTrmSIPW8cfvrU/Z7vnOp4UIr/Xp+HYZwTfUAd2R?=
 =?us-ascii?Q?Gc+13vGx1c+qJmTEHH+WLpcnY2Fl4VaLiX18ILHtoOj7AY6NZqKgxbSoa/SN?=
 =?us-ascii?Q?2gHHjWmCZAPWd83b1VcBaE0tv0pShNPOTl6Hh18zSQW9/yXxldCOz2UiwBNn?=
 =?us-ascii?Q?34ByWj1uBnr2MuIzOAxqS7FPS1f12MDzBYezEN902wXSGcSjVjT7HJ4Fn70B?=
 =?us-ascii?Q?alQSLyASSTJVpwQLoZ9xr+xGNOHucuLIUM3X1n4aHPd6axg3bFI65eaypbPs?=
 =?us-ascii?Q?oTauOa0ZiWajMKriK94tHSRcCF4znR7TpW1k9FTFvciYIqpX963UJjQsm2RQ?=
 =?us-ascii?Q?Nkr1bJd+jN6VYIENMFU+oL6FxKXOQC3OFaedJjmR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec0d284-5d56-42c4-4dae-08dd671da24d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:38:33.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gGm8PEqBX8lDIwOiuMZa8kHqe3Pu1Mh2pQ0lXpvP1IyMx1VNehO16/uI/RLEiW6xwbrd2fDOzWkURN6IQkzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
> > The numbers used in rcu_seq_done_exact() lack some explanation behind
> > their magic. Especially after the commit:
> > 
> >     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> > 
> > which reported a subtle issue where a new GP sequence snapshot was taken
> > on the root node state while a grace period had already been started and
> > reflected on the global state sequence but not yet on the root node
> > sequence, making a polling user waiting on a wrong already started grace
> > period that would ignore freshly online CPUs.
> > 
> > The fix involved taking the snaphot on the global state sequence and
> > waiting on the root node sequence. And since a grace period is first
> > started on the global state and only afterward reflected on the root
> > node, a snapshot taken on the global state sequence might be two full
> > grace periods ahead of the root node as in the following example:
> > 
> > rnp->gp_seq = rcu_state.gp_seq = 0
> > 
> >     CPU 0                                           CPU 1
> >     -----                                           -----
> >     // rcu_state.gp_seq = 1
> >     rcu_seq_start(&rcu_state.gp_seq)
> >                                                     // snap = 8
> >                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
> >                                                     // Two full GP differences
> >                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
> >     // rnp->gp_seq = 1
> >     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> > 
> > Add a comment about those expectations and to clarify the magic within
> > the relevant function.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> But it would of course be good to get reviews from the others.

I actually don't agree that the magic in the rcu_seq_done_exact() function about the
~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
because the small lag can just as well survive with the rcu_seq_done()
function in the above sequence right?

The rcu_seq_done_exact() function on the other hand is more about not being
stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
least ULONG_MAX/2 AFAIU.

So the only time this magic will matter is if you have a huge delta between
what is being compared, not just 2 GPs.

Or, did I miss something?

(Also sorry about slow email responses this week as I had my presentation
today and was busy preparing this week and attending other presentations at
OSPM, I'll provide an update on that soon!).

thanks,

 - Joel









> 
> > ---
> >  kernel/rcu/rcu.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index eed2951a4962..7acf1f36dd6c 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -157,6 +157,13 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
> >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> >   * full update-side operation has occurred, but do not allow the
> >   * (ULONG_MAX / 2) safety-factor/guard-band.
> > + *
> > + * The token returned by get_state_synchronize_rcu_full() is based on
> > + * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
> > + * against the root rnp->gp_seq. Since rcu_seq_start() is first called
> > + * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
> > + * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
> > + * periods ahead of the root rnp->gp_seq.
> >   */
> >  static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> >  {
> > -- 
> > 2.48.1
> > 

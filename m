Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C42AEE4
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518414; cv=fail; b=T/ayd7uY90DxgOb8o+veV63MHYtIejAWe4B33e41rJjz0OWTe/sQAAKzici4y0T4A08RE1rzFbYm14zhLkGa8pvNCxPfDNeVT/uLC7OHrDTDCbvO/69FIIDrCuPXzTRxsmUeza+jcOpNy9KloJj8fZR5VXGfbvpKuAZTEu/Q6eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518414; c=relaxed/simple;
	bh=dpP1ZPii4R5jftuzP8KedcyLB5jy2V2V1CJGstUnTaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O4lPeXXtz10Vrqm7XDSp+DEfFalG6SCtNK7nyncKvM3XPPWSn5WpwnTczNYm6Ga/eAzXT/PLuLT/BbVVymWELvXXnKfhGYpTNdcxoVnZFrLHDpysbSLoBc8DUG0Sib7Cx9JwVuxfX2M2SNYfS2YGdJCAYU1Vkezjtncu6i3zf28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KTVWHRSJ; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTVWHRSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVSsGh6TXdwE3xIP2rp8Q5T16rBm4BDKEDHrrE+LCpx/s9UUjbmjziaPJW0MrPjdCR8JJ7xCL77keLjlXsDV21ZO7kFo/erh4Fwg7QupGLCWPmCL1czhK68/Map5ftX/1awpaXWRGpwEepYelZDtJDyG/sFh0RRKeBxdhM84sbo7APnVdp7zeYfoHg1EaXuVLylFX9yGiuM/ImgsmpJBOKI6CI+pxUIQnaBl4TiwCopjRwREVtV6t+jHweUqJ75eL8SkQCp2OBSx0pxmKnujF4LbF024+R2UcoPFHqaDzMUFY/+nq78aI5WzOT9PX/rl4tqVI8cRdhvaBltTKKqh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44l2yE0DBfRG25SWezrMM4KEFcijq88DndkAI+dw4d0=;
 b=NSAr/M8h0+JF1Ehrh1hl40SW0uZtEQ0QVvIO/Nvty3s+VD1CHtSR2Y2rJW6B+hz8jGtz1s2kx0+ooreQTa3s7XAlTvGTuL8u7+NLCjWlH10ICTzNW6P4VJoaHK7Yguca6wwJMkxFbWq0SqedUvOgkAgZvVwO+niakSOQYCYD+ufW8TZpMzNb3ssGHKErQaDIHAm34kk69jVskeQlDNqgJDdLaWn8Zcigdd6tdgthIrhW0VskO1zvDnG7H/bLbjv/zj+dy1jVFbSc8jNlGZS25MAEw0UXVQji/qlhWwoXF6uCWsxIg5krkrFjI9kAd5sIfj8QuQqvo6sw55F65MFOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44l2yE0DBfRG25SWezrMM4KEFcijq88DndkAI+dw4d0=;
 b=KTVWHRSJB+0hI005zfKcel+InM8FcQ5DWHC1QAE/3Lli3CeV3qZczCPOPDI63o4AylG/qiYDKjEjFyZbrH4D7JqDUonQPqgdG8KZigXowB4DGvu7OGvKcCZxU1kAsPHPzzlGk07iq6zEVbxRodVic55bFs/mwFxVejO3MwvqD4IVM8Z0beztt3W/1EYjCmEDnT0AR8qIY8vmcmSe3jP7ta1okhagGk9MVt8DpvCn+tSWGE7Sg/lRyI1oxdTnzMBfrc1MI4QhqoC27JBAtol/s7Q5lQWAPrzF8VRVO6UmrTWobPtDWesVgiyAYtc1awPpX+n+NhVgXNPsd+NHwqg/jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 21:20:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 21:20:09 +0000
Date: Tue, 25 Feb 2025 16:20:07 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <20250225212007.GA1806882@joelnvbox>
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home>
 <Z73rn9nqlCwns1IY@Mac.home>
 <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbafe71-c07b-4ad3-6af2-08dd55e22eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hxPTejucIxbBxcyeriususkHmqL9Ol1J3yyAf3+SsO+9rk/owZNe2Ozf2nj1?=
 =?us-ascii?Q?WKYKs+JyKMxEuAVaNtRboNIkoDAWLLlvVUJTj+SrVXcK5u0HNyfPbo9GXtPW?=
 =?us-ascii?Q?d6GkT+rrgGzGP1ilEkbSoYjkzCbFvxrA/jJKlaDFuzdCnrwxDsuxKfwRNIoI?=
 =?us-ascii?Q?/xWEtoo4UwoYwklkVO/hyUbL3QSvK+sZmOD4ivquZ3tWal17k9kxl7QX3bVb?=
 =?us-ascii?Q?xxbpy4yDoKtnllCMPkFghuHr6p4hVhegBOcMgeHZYadImIwLxcd1QesKWqXh?=
 =?us-ascii?Q?h/DJD+gEkO5J6pf9bYHrNrQJ0UPYW3CWTynwWvAP5ay4pPL8O6OuF6ufmHGf?=
 =?us-ascii?Q?6JWmb/DcVKCjoFq30bsv97PX0FEujjdGIQ+Kv+NWGQuueFmriSup8JmqNJ1g?=
 =?us-ascii?Q?+EjPdUFcdjoGZi8oYV2tP+uf+ClAIGMe8vF7x/aySHv83hj6FCo/83qa15vT?=
 =?us-ascii?Q?/X7DkM7WjNlzb4JHGbbc5H3A/0JtdXXqHCk5VJE4bThsGOGqMITf/A/cSv5b?=
 =?us-ascii?Q?073nW0M+in2ONIkMKJ/oNJ+EZVGfIeicsBeXKL/gyavAdSHLsjgzE+7yV9Fj?=
 =?us-ascii?Q?hitzYJb+DClTuE7aKGEALZfap+/9klfWNUtwyZworjMAfBInNxPVwxkUf9WS?=
 =?us-ascii?Q?rszGPJIVX+mpJCZdjlSK5Pi8EbBQv5EkTZfEp/J9Lj9igXX8DrSqZXpm/2A9?=
 =?us-ascii?Q?Iix1U0zjZHTKs6/7RpCbNhUWx7BeDo1SxdZkW0uGhAwOewj6/8MkFs4lqfIk?=
 =?us-ascii?Q?Lgfoqcu/R/eK59vbvvSeCw4MV0fA8/3LEDpZSlYUf2NxFXpddLq+mTv7PIYV?=
 =?us-ascii?Q?yEXcGBmDmU73o90KDdiNLD6ZbqUQKIByEwI29lq0Rmjupy29h6qHf6GQ0OU8?=
 =?us-ascii?Q?Hna1V+ABcjlRObsh8rw7QaSp1/wbfxL56g+F4iarHaAfzjF2ZUsjWSrTHpGt?=
 =?us-ascii?Q?MgPCA+BgPYXEYJ9SD4GBgC73gIsXYK9lB+sRH5tuLzrmZ6/jbdnOZ2TDbdwI?=
 =?us-ascii?Q?aGXJJc53xg6l5F8ZLhtsCQ4SJbNbssXvticc7BTf3ZIeq+PyQZms/eIMelzY?=
 =?us-ascii?Q?HJ/nvTuWFXJqdYl8+L7UVHNrzCUk6DSbdTuK2LgK9ArACEJ051bn0WHqqrI0?=
 =?us-ascii?Q?g/Fd8YBM55Qhjm3k5DJyTqu1mL5s0XTPv4IH1Lx5ycPmp2D4KrFKEySITi+4?=
 =?us-ascii?Q?7XhGtkPW6jC1W3VpH9Gq5dmRTetECEJY73IluGNIzwHMAmoGVFB7McMsMr5E?=
 =?us-ascii?Q?/ovmQsU6NMJBoZW3l3yEo1BAJ143ULDcVk5+Q7lqTXQGQ7n6ETwVhG2ec8fn?=
 =?us-ascii?Q?L63fTpsUFs+tRhTVjRMZ44YJ1wPI8dNDbA56Ry1z9WZzWyjOk7Jv6CuXUbUW?=
 =?us-ascii?Q?2hy53OR4x6HZEGzpbFQAoVksKPgZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zDm9cwLajWRn3ad4oVV7yMxJmFefnpuIQGBBVPu2trwu3SMebl16eOVX6Hp6?=
 =?us-ascii?Q?3KJ87g/aDVA2mVHAOBe1N7pfT0e0uxVzfy5zDiNrM/NsL8OLne87WtZGTbcV?=
 =?us-ascii?Q?w0d95RGy4Elp5IEqh7gaqc9Lf+ogK3JGIPdTPyfkNYkv6QElTDe6l/OrmJjQ?=
 =?us-ascii?Q?ulonZXzJU471kiJTOAiNCkcAmtk64LCr1+gBC6/veyNHIT9z46PzlxRW8B9i?=
 =?us-ascii?Q?gdoJizkiPgIpVh+giqzQ5pbcVX3CYDJY1+mSvELY+uQm4GshLontXpyfjvFM?=
 =?us-ascii?Q?yABWqIWuz7Yfor1ynctDNb3RKHuinlg3UaTr0Jr2aXkVZXkLzUqHUnw+yz7j?=
 =?us-ascii?Q?4E2LcKS6zL3BpPnFv97dXOk7okR38wEHRolN0wSQXCkTx4bRc3mKgDaqk79u?=
 =?us-ascii?Q?/X7vLkAimGW/F5hdRs+erJT9bKTU3wSeXj/Fd/H2Q5Rn/LLsmcBxin+fWK1M?=
 =?us-ascii?Q?WtN2E0eanuEJM159SleONGLFwjmPCZFjVykkKhBCiRJuLJ4SUMaY2etwFTCL?=
 =?us-ascii?Q?liFv04UxCQhlqh2x2WJHkixNKFPLnyqX1itPfKyBvYpLwhZsok9owlz8ma6J?=
 =?us-ascii?Q?wTlXaLXDllnIqz2MJk3xmQ4BZKamWb+hCKpSypzWZtZZ7evJIW7HKNS61nNd?=
 =?us-ascii?Q?eZSZxNtAAGlPF8jg1ouXoSyBSqFNhjNZVDD2qrnB6EdF4BViecFKFOi4eXen?=
 =?us-ascii?Q?BGHy7EVJV2FPVgtdNYyO9hZRa3msTLEQhwB+fuqo5t2h7ecS1tYB8da/g9gb?=
 =?us-ascii?Q?4HaCK51U56rUToiYstDpT6yvJ79jq6SsgZ3R8L5r/+sLhguBhMV8UGufj8Qf?=
 =?us-ascii?Q?E5ICEcf1qzKXs2YPAatHJaIT79h/f527n3YklkbtDVYlm/qyQSK1AbTLedxb?=
 =?us-ascii?Q?B7JMtVM3A0+w5x2FxliLkWfby1j5CjDlGRkjxcUCBv0OuKQf5KXnPLBGXQV2?=
 =?us-ascii?Q?IA84fQgpIXX9q/TYjvXmiiT1BCvaYQ+Gv9t6toAuDZiBgg45RigPRpPX04jN?=
 =?us-ascii?Q?Ijvz6Tx9Ko78+EwFaWsfmyOFN4xyKAMZ7RCrggLLhtTIzwBAa9zeIqlXCkID?=
 =?us-ascii?Q?l0hFedmpfmNYtMnz0F1+iKlkNCgdB8MvNJmlEz+5gW8afGUTM/wB97Ux+//+?=
 =?us-ascii?Q?lY0OJoCkrChJ/lKk0LpNlagBouWwVK58H/D/BmY+Jc6OlOstqPc6USwniHuS?=
 =?us-ascii?Q?AEsjjsztZJ4OpzAiqm6YUVUJikVH7t5s2dyQuhOwUIbaRIkTznr3bi5rIJ9a?=
 =?us-ascii?Q?AmcZp+aHRdZd+sZR8JhQAHo5G8aVAEUCvUm+4t8U1/q4uW7f1Eyefft0+u+5?=
 =?us-ascii?Q?nntXl/tqeK1J8CT0zMAhK1my/8/on7t+nii8avSeLnYkfqZzop8jTS2HXvez?=
 =?us-ascii?Q?d3w0Wqo/hwhpdogIEQMNAztxnKjmYX3eb81XoopbL0UZo0iFtcZSwt8VNJQA?=
 =?us-ascii?Q?HWUNx+2Rp9Q2Z6yMksKgcG+NDSbLgwg2pse0KscTW+a1lDgkETjsrMxe4ohv?=
 =?us-ascii?Q?qhZ3+KrSgXffZQezY9zXdGasBTmklbvGIycc8ZjBfjw+7spkn1IHRNt7eO+o?=
 =?us-ascii?Q?D8ZNz3IDnKoloh+/pxqyVsYIa0wQrEaBhDCRxHoc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbafe71-c07b-4ad3-6af2-08dd55e22eba
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:20:09.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33cdoa42PFnZZM2t7vEPPtsamVW7TeIV3m/Xt04qy7C+ucJOvhUHm08NBS4voqn3KoXmzaE4D4QbyOUodUflmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

On Tue, Feb 25, 2025 at 09:54:29AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
[...]
> > > > These passed other than a KCSAN complaint involving
> > > > rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> > > > This looks like the plain C-language writes to ->defer_qs_iw_pending.
> > > > 
> > > > My guess is that this is low probability, despite having happened twice,
> > > > and that it happens when rcu_read_unlock_special() is interrupted,
> > > > resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> > > > IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> > > > data races between task and handler on the same CPU.
> > > > 
> > > > Thoughts?
> > > > 
> > > 
> > > Do you have a KCSAN of this? Also this is not a regression, right?
> > > Meaning you probably have seen this before? Anyway, it should be an easy
> > > fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
> > > and put it in.
> 
> Here you go!  And you are right, if it is a regression, it is from a
> long time ago, though something more recent might have made it more
> probable.

In my opinion I probably wouldn't even call it a regression because the
data-race is happening on a boolean element. If I am not mistaken, this is
thus a false-positive and KCSAN has no way of silencing it?

thanks,

 - Joel


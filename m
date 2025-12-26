Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06061237713;
	Fri, 26 Dec 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715581; cv=fail; b=O9mV0zP+FjyApK8opz2iOhBgR2Pg9Vnc7iJhGLdG6AZCsllpDu3JyNp9chc/7heW/VnsKiH5rbpKdE0R29m4sJpRJpy5RNK6zBOLvrWeQ1BiSmu7UhK1nr75WCnnsMGxcTSJeDDk6k3KW9eNsSrre6VQ04JyJC1cUpQzIwJ+F9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715581; c=relaxed/simple;
	bh=/sEnWb0JoR+NElPsKNniD0NvS085s28ZxkIgkb78C+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8+Sy4pkMSJHz4JsK8PaphX25aPqMaGuA1iNkkg8AE8y6hk+r6vVlT+G8Pe2GpKQSmJey87FuhcQ8B5I9ivMwSHHeTxwJdrwWaNXwj+gXBJ6AKqXXBAaI9mplB/dw3cLwnzZaG6+4uH13Ahq7MKieq5/QwVT2/WAfK9efTe/0T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hK4aMLFf reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hK4aMLFf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwntU8r36fvAkgPpYLbRT3wOIAOKY8S2dlewt6296QMar2igR2/NTxNXghpZDvB2vzetBn3c64yE5aNcup/RWxf0NxU9h0OUNUvsJEmNO40xjwVCpx31fRePhYE8eyZo5+XCqKyFN0Q+eavcsYvbfPDy3LpchV3plcw2aBq84FF+MX11jBbtoAHR+BaNxxH12N2b5gF8Cn1Gbt8T8B76+vLbh40PlrMPcGxWgfoMRi4JFV4E0lIjX/++1UPvmfUvRnNl7wNBzhoozyiXGr51SgwFF08FoNqWTu+Qzwco+jJuYg559M4scXyRdgdYhxzhGDhWpRmSfom2Ss/zOQ9yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtrE52wgvy/55xzaACxjgOpQ0BUJK4qtd8+lfVnn3gU=;
 b=KOI5lpA75/kOa1t+y009WCuLNNx5kV7Es5QbaHRwZ9h3BEgG7/xQpuLcCPqbqwIqFYiuoh5CJ/FsFR4M68+X8cmH/OEcKrzUvQyzsu7a9nf846HfxpdFT39UDo8uYUL8mCahL2hSrR+NOPOOFpKU6vr5Vl/pbY+33vWcR2zGHf6KTS8t8RhMQIu+Kjsg5RyB1xnx8MS+cz+jpwR3V6u5IHewGjvPmzUHcTMa5nSb2r3o5QMJ4+yVtYuUSZHMRqicStmAJdBUKiq85rKDiq2dVRggynEqJNkLy2kRK8FUanBYnFh0N+rQHft/IM69BIraSZ6gVnzcKoFESU8pRpX3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtrE52wgvy/55xzaACxjgOpQ0BUJK4qtd8+lfVnn3gU=;
 b=hK4aMLFfrdfPWB0CMN6Ji5ycyt7Zc5vqJYMjDGTPEmqGlYPrtzfojxIsUGihyEq2tr/KAnkhdNrE0C6eSZYxP9NHlIq6qIjdrymbV/cYXA1QKV//5BFXB+C4BDH+9Mjxk0k01eCQYFw3RoUiJrH+9ncB84zJh7/XFPjPQxyOgfPVhI4wA6SyYXUmUukWL9bj/AmsqgewAhk5Nqa9TWqzBhsOPbCxoDz7DJQKd6IvzIwZa5F6SkfwvyhU+x48nZdNhsCpjTFRT9UB9hOsKOk6EhVsaa7Y0H8lUToZgiT7z+JOrRuoajZOtA8i/CADkDFE8CQD0GapYJMHvktEsv8Sow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Fri, 26 Dec
 2025 02:19:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 02:19:37 +0000
Date: Thu, 25 Dec 2025 21:19:36 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake
 path
Message-ID: <20251226021936.GA739018@joelbox2>
References: <20251225074451.2405584-1-joelagnelf@nvidia.com>
 <aU24p7he1T63Qeke@pavilion.home>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aU24p7he1T63Qeke@pavilion.home>
X-ClientProxiedBy: MN2PR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:208:238::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: b026c49e-8d7e-4852-0541-08de442537e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?QW8yV3yjQ/iQOAFj5J6Jup1DVT9it5oNOgJn55UszvT+tvvScIFx+20Hnq?=
 =?iso-8859-1?Q?xhDIg7SEoI4RtfFvP7AzNwehWe29jTL8YD8iGFDIPZB4zWopVdpyADwBse?=
 =?iso-8859-1?Q?YqdOhXpv70nyPcQOTSsUCcxYm32mTO9sXKhH5pEdpMLP6ba3hXOQ0/+O/k?=
 =?iso-8859-1?Q?kKPk73V+UN8mAuxWdbvHbrq9T5MoAeAow3YQswDU8VFOPpuUTX6hec6YbR?=
 =?iso-8859-1?Q?CeiY2HivinUxlVurD5zmZIHURK+SOPtiZHUmUNpA9xDlyljL7lkvnzzAyo?=
 =?iso-8859-1?Q?jMT/ewCmsCkXSphDGHVhQrqIdMfBr4YX63PEFUChOCicmoOfspchlhvIF5?=
 =?iso-8859-1?Q?lEL3VMocep926o5AJ9TRLiLoFhKPDcOkkdjAZFnMUTnWdsX5bX7JeErl/9?=
 =?iso-8859-1?Q?ZDhmw2i454ySkHwClYgEmndJN1QUCJiZi2/9IyLV6QwuRE/XvbuifUAohi?=
 =?iso-8859-1?Q?C+qGibewPixvLfLFFdXTPPOQof1ewOGjOwxX5vFsT868j0cq3fpMv/sQNg?=
 =?iso-8859-1?Q?WLFvAdh2e2rDy+HTjnj2hYtiXBypD2bh8T7DPdCVYeYVrldiCz63AtWiIg?=
 =?iso-8859-1?Q?QAdzPrPGjMEOIg071izJCGtBMFymAgvSb5nzbmPAZvOBYst+j9rTslrlgZ?=
 =?iso-8859-1?Q?XCGUs6fvj+kqTwnHDoNaQT80SY+cxnPN5XjTq4sY3U09WcvxD2UhfTeoW4?=
 =?iso-8859-1?Q?UvzWJc2xg1MBtatMVhB8/kdteVNZX2rkqdRVaybCH8kmucQj5WrC3WVe6b?=
 =?iso-8859-1?Q?MTodpk5t5ZoKNzuzecUepn+1Rtu/5GzjKAEm6cSY3M8La68O2mVZHLhBmF?=
 =?iso-8859-1?Q?oFknI5Uo5yvEg5mTzB/WtqogEIJsgQK1Kh6h3PcVsFxvhFnqaviKK+6+Ni?=
 =?iso-8859-1?Q?8vs9VvqUrPNJ6yhF/N9fTMs+0+5fhcNr71ibXWv6cabei71Nb2MTKJXOaF?=
 =?iso-8859-1?Q?9Fmj+6FCBlhdDdHO7WXa+XDiy9Py8tUPRg8PLp6AKfVvvaAUbmZXnKskIZ?=
 =?iso-8859-1?Q?p++o6Td6R+eo2sUUAYA4U2WweNinvECBbvaMYQ4V8vbxjJo5tEJgzqu6Us?=
 =?iso-8859-1?Q?O8v+9XoOTnGDTHo8cJTJ8q+Paax3OrVT49wV0fJ0cOrRbvSTXdXbfvh+RH?=
 =?iso-8859-1?Q?tS9ukc7ndOooW9QTWQNM/GDKNa+5u2+4YXDf6IzT1F3t7cO3dqK6RarC1E?=
 =?iso-8859-1?Q?6W+c2Yvn/E6Jm515HbxlEak76peTDr/Ok2uKIsfOsfSISV8NrxX9kjLGdD?=
 =?iso-8859-1?Q?8Ravaw8DUU5B3+ZrBtSeORl3eHWL9zE9+sglhI8RBRP0YbHkzUvg79ElWf?=
 =?iso-8859-1?Q?bbJZWGFJzweqe+mtogDqHAB+B+nCUaXpsCpWpYWuyNPoXPip0caWCheXkU?=
 =?iso-8859-1?Q?fJaNIIxO9tj61BOokn0sOvsWYZgqAMMFXr5DKLivycJ+O7cH2FPjvjTwEL?=
 =?iso-8859-1?Q?xZRIZ6M7IY/BvoUnkck9aqoMJP+XunsltK3af60OxrTmfBzZmHKBh24CEP?=
 =?iso-8859-1?Q?xVmrDIlDxgH6FpxwO1+BQW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?i6ZgWpBcks1oMsEpukPPl3zViqAQyidrnOPcUqyVMciB9TLGydzFnH3noU?=
 =?iso-8859-1?Q?zqNYYZJst46Jy0tGLdu2toACe3BX6Iwu/SUnGudy04Se5CAlZLLy6lsKEV?=
 =?iso-8859-1?Q?96B1FrqFcYJ/62pOBUwqhras/JTXdpVzk6Gy3aQWstK9fT+YW3dAfW21kr?=
 =?iso-8859-1?Q?Tu6I5xymR5YyQ7WP2BTvz+h2HjnPdXLHmRMx7WpmOUUch1Jy/oujfYSVJK?=
 =?iso-8859-1?Q?n+bifszYQj8bSqwMo1kfjHzyohlNVMxNl6IjvtVHCkpxGiXS8v2p1F57P3?=
 =?iso-8859-1?Q?SazilAGBAIFK4J1mFnzGL3fXWmwBc6SZAxM6GYIUGBGEMD8qga8CVjO95J?=
 =?iso-8859-1?Q?hr4qiVosMrQ9ZTEUQ2fVKO79M7pnl57XDhTa9FPWUYVLwjRJz3zFLP1utZ?=
 =?iso-8859-1?Q?FaH7emgFlpFdzNrcIw6Bodp2cRc5p8WhlaF9ExVfJKzvN/hbzRfPsVNXm0?=
 =?iso-8859-1?Q?FtgyejVSoul1E/RA7AHvJre6zLz2XDO3eo+aCAFvWkGc09dkwQxIGQVPL7?=
 =?iso-8859-1?Q?gGkKc1I/1Nmm6Lr4veqNj4ghypJoHwRHMb2MHRRXDLQRYznkkLpvo1iW4b?=
 =?iso-8859-1?Q?nQjDvHNq3sRvKgbDtaQr3UjigxG93KD4XIDzlx38wfeHkbjOjvscsTPbcT?=
 =?iso-8859-1?Q?GQVTKHU3rvQiWtSCYAvl9VyskRj54Gwff0kquhkBR9K4Rl9Rg3FIcibiLE?=
 =?iso-8859-1?Q?4IulEgRu/RQe7Jw6o67lFrH7gmu+5RnaVl4/yLjEMRRrJbRAPj2cvnlJdw?=
 =?iso-8859-1?Q?E1s0+lZDSSr7Zx7V2Kr8thcYd//hDFcQ9RqNFZ0wycHAkt1myPwB5Y/VgH?=
 =?iso-8859-1?Q?sOyBLyyHiSwQPnYSZWDJOIUP2WonUi/q1sifuaHwuImRAEh/A5X1m0oIr0?=
 =?iso-8859-1?Q?ASaHGpycrWMHA3x2D6vJfUY5Ct0SR7B88dfwHmKqs6ZU96z+ImEwUVlXd7?=
 =?iso-8859-1?Q?nmQgczNj13Tr2w1isubeRGcJD15OiL9ZQfImtg1v6sDIKuQe7kW2cC9NLi?=
 =?iso-8859-1?Q?IMHLRoPGBb0yObh8WlrQlkCMo3OfjIZMtIurUaC5wbiAPZC8WoGNCHpItz?=
 =?iso-8859-1?Q?l1AJvA5wKVhBy7A2b/LgIYI2ecVEx0HYnHQeAWqOehlvdND+Xh+nBDihgw?=
 =?iso-8859-1?Q?ji9+ZUS+QlXTWIAnQhVtSI0ixnK6eecp7td1ouMDIggF7Pzy56l4TwzYVv?=
 =?iso-8859-1?Q?to/5V/Nu77WuzlSinovRHHr5VX/Cj/RN835rADH4TtkM2YQfMDqaoCPgtm?=
 =?iso-8859-1?Q?CY42oILbk3v34D6wqBTHoEMDr8YgpsLrEmofFVHyc62RQA95FL2MY1tSCB?=
 =?iso-8859-1?Q?1MWbj/BaJZJDkk1uI9SlBbWIgxpQKjaXoIdvcpZFrLw/5yBXCggcriVo+6?=
 =?iso-8859-1?Q?g7MHFvdjeLWAs0C0hw/a8tLmqdT/A3rGzrL0DatU5Ij0RZbZOHfaBfKiE+?=
 =?iso-8859-1?Q?JZoP/O4IUAqfS2bAEsjaEt/9aOJJIuD5IA4thn6WVv9QY1+yWCKZprPTYp?=
 =?iso-8859-1?Q?fMoBVm/8CykbBDemWKUyjI9dWCkUjN1AfRMuRQ1MVAeEwrZXabZxriwI5I?=
 =?iso-8859-1?Q?lfREAoRHqJUzNV7GhOazWOR3Z9uUN3DoHP96LkARbThyL7qXfShoEQpF2Y?=
 =?iso-8859-1?Q?6GBWLsrPyyN+sbvWBljCRZsrZuEz5qLDDSkPFvzBgMvxK4OrjpFJGcLs0g?=
 =?iso-8859-1?Q?OjtXFOynXZ9bPcfRG74xmnVmFUeMZXcrj6RfA24cc8SO9iVvD8DkcMysDL?=
 =?iso-8859-1?Q?GB7SyGcqjDY+ttsg2wu5MoAQdAbiwOQDsX6z0XRLUMkRU8ijuS3RWEn0i8?=
 =?iso-8859-1?Q?9mQdyQCKTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b026c49e-8d7e-4852-0541-08de442537e5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 02:19:37.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvc1QluEBr6mnKrsHCtzynIRgJIyXnFfr1PWnDPhxcrxqLHKMCVL+aAW8MQ1O5PvWPNjCHYqQiS7s1cdRIaUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

Hi Frederic,

On Thu, Dec 25, 2025 at 11:20:23PM +0100, Frederic Weisbecker wrote:
> Le Thu, Dec 25, 2025 at 02:44:50AM -0500, Joel Fernandes a écrit :
> > The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
> > wake rcuog when the callback count exceeds qhimark and callbacks aren't
> > done with their GP (newly queued or awaiting GP). However, a lot of
> > testing proves this wake is always redundant or useless.
> > 
> > In the flooding case, rcuog is always waiting for a GP to finish. So
> > waking up the rcuog thread is pointless. The timer wakeup adds overhead,
> > rcuog simply wakes up and goes back to sleep achieving nothing.
> > 
> > This path also adds a full memory barrier, and additional timer expiry
> > modifications unnecessarily.
> > 
> > The root cause is that WakeOvfIsDeferred fires when
> > !rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
> > accelerate GP completion.
> > 
> > This commit therefore removes this path, which also adding some rdp
> > counters to ensure we don't have lost wake ups.
> 
> There should be two patches: one that removes the useless path and the
> other that adds the debugging.

Sure, will split.

> > Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
> > configurations) - all pass. Also stress tested using a kernel module
> > that floods call_rcu() to trigger the overload conditions and made the
> > observations confirming the findings.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Cool! Just a few comments:
> 
> > @@ -549,24 +546,26 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  	lazy_len = READ_ONCE(rdp->lazy_len);
> >  	if (was_alldone) {
> >  		rdp->qlen_last_fqs_check = len;
> > +		rdp->nocb_gp_wake_attempt = true;
> > +		rcu_nocb_unlock(rdp);
> >  		// Only lazy CBs in bypass list
> >  		if (lazy_len && bypass_len == lazy_len) {
> > -			rcu_nocb_unlock(rdp);
> >  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> >  					   TPS("WakeLazy"));
> >  		} else if (!irqs_disabled_flags(flags)) {
> >  			/* ... if queue was empty ... */
> > -			rcu_nocb_unlock(rdp);
> >  			wake_nocb_gp(rdp, false);
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >  					    TPS("WakeEmpty"));
> >  		} else {
> > -			rcu_nocb_unlock(rdp);
> >  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
> >  					   TPS("WakeEmptyIsDeferred"));
> >  		}
> > +
> > +		return;
> >  	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> > -		/* ... or if many callbacks queued. */
> > +		/* Callback overload condition. */
> > +		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt && !rdp->nocb_gp_serving);
> 
> With this test, the point of ->nocb_gp_serving is unclear given that both
> states are cleared in the same place but ->nocb_gp_serving is set later by
> the gp kthread. ->nocb_gp_serving implies ->nocb_gp_wake_attempt so the above
> test is the same as WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt).
> 
> In fact ->nocb_gp_wake_attempt alone probably makes sense?

Ah true, I got a bit paranoid about false positive warnings hence I added the
extra variable, however on further analysis I realized the nocb lock takes
care of preventing potential false positive warnings. So yes, I will just use
the single variable. Thanks.

> 
> >  		rdp->qlen_last_fqs_check = len;
> >  		j = jiffies;
> >  		if (j != rdp->nocb_gp_adv_time &&
> > @@ -575,21 +574,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
> >  			rdp->nocb_gp_adv_time = j;
> >  		}
> > -		smp_mb(); /* Enqueue before timer_pending(). */
> 
> You need to remove the pairing smp_mb__after_spin_lock() in
> do_nocb_deferred_wakeup_timer().

Ah, will do. Thanks!

 - Joel


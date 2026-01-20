Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FB7260A;
	Tue, 20 Jan 2026 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871284; cv=fail; b=ofALKVk/e8AlMJFQr9Y1y5UEaqDhpJYNVJyFcqCRsWDmyLf+Ua2Ov8jgc/wfs8n67ESLZgq4rPtv186YAGw8qesnodWBANL/VTylUwKFfvD1EMYdVYyGExFEuL6k2iFaLO3fw3bcmct6LFKkgbMSVp3g2ZuilAwnmspytJrybNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871284; c=relaxed/simple;
	bh=wzW2zyU/vjrmrMnzfd0LBXYEO36dFJIe6kdV8Mkc6mg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Message-ID:Date:
	 Content-Type:MIME-Version; b=k8mkR7OS2Dh+U/nRA/i+8bY5UB4ws83tGPh3DXn0svzpTLdlyqiqXUwCX7p7kO/zb/BKmPm22Jj1gZGTKgkxHzijpzwQ5Ncxbq6vIjbm44lqfOdZWGn6bhugYHTFeFmvNDJ5km33nbjXNV0PczvTo/aCd0E+a2PQG/p44VlsGag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AheYWaOa; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AheYWaOa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYV8lK3jLZkvAhWDMrQX6iDP712x4KHp7ywhXYPeuK0cNEpYbi0JGUnXGJHXqhjarTJ6TbhKkjgAFkDhREeDb3qJDcPOmh0nXvRQeh0t9BVZzBY94KJU9zLrPDtdtVNUrewERjqsuO8h3i36wK2RII6DitgNTVV1n5fF/F1f3S/DzE4VA2MxdawwvzWeZDZz3FvAmQYZU0Tp8zxtX/aHs5brQCAE3snORNOao88xVcfLAVoqRJIuH8H2fkiqHYrWcZludXnMwkqx2x5We7MVpL3Vz4grFiYIr4r0wnn2R0jHC4Fny8roXrHRr5vDLd8gXGRwhitth8DWyhh9OfTchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCijXn2Py/bCtrW7BvZFWLdAvKDo1PTJ1KWXmRVqUbI=;
 b=IBZSRtCuViBhJQKGKjVjYPrBwswMYxSsJbv0Rf3Uts6rm75LJFOaLZsGoJOKuoqlsDKrR1WSJiqfAteclHWrGKTHjyjMlbS+/yiNqepZ7ILDrKlLReTLblKesscIHH3ufut4jOly+TRqabyurIUU4x0lq37cawFyGX5tOE0ehcwTPbF4BAEPWhh+gsCWovvwxwsGYZO0bo+sroiZXJ/+ggwt4CDFeu5jvvpYZQph9p2s+q2WfBbSPwWJ/WZQXcPzBpPPODvOqQ8e0Y75weZ1JaFmI77KoTT9IlfZRNolmg047kYjVBHNNZVkT5TIwyW0RtDZ3JILJ4JJdfC6MukUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCijXn2Py/bCtrW7BvZFWLdAvKDo1PTJ1KWXmRVqUbI=;
 b=AheYWaOaTEuAmysIeDlbuxpyaG0dM5K8DkBJtjJ60kN5cJ19eBTVUdkvwtWCYlefDNoxNYABHtAEKvyjVBFLFcEmeV7bgSzKBtfeN/ekjlugx0VoGnag52AOc0Yjj1+I9FtXUx7Jz8YWL8GtF5SJ3K8kD/Jqpuk90aCpEDiEfNWEAP3tn/q4JRO5xH5hbC7oPZ2WTVh3PyBq9VuGx45GewfHxIBh/1KywuhGNxgm0eP7ac1am//hX6BmJryokSjkWQk/vAE+ek4cwzI65ywynx61LN1jMSglSjs++4fUgfGGMq6LZIcgFdgh4ThNv6WuTlJ9bkccB+x07/GiAvNLPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 01:07:56 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 01:07:56 +0000
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload handling
From: joelagnelf@nvidia.com
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
In-Reply-To: <3d6e5ca7-5944-4add-90d5-97b672447b5e@paulmck-laptop>
References: <3d6e5ca7-5944-4add-90d5-97b672447b5e@paulmck-laptop>
Message-ID: <FF0E8ADE-F5BF-44BB-A1A8-723299C1085C@nvidia.com>
Date: Mon, 19 Jan 2026 19:59:33 -0500
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 62969e4b-e5fb-400a-26ba-08de57c05874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JFS21YvLvnGabikNZa6QYXokSJoLD9sR/QaBmhwypG/jmA/j5rdeqEeYv63V?=
 =?us-ascii?Q?31lnYqaJmwImtpDC0E0gsKjg7QehPS1s2wanHhJ18J6qBpUwGwaV7kl1gYSp?=
 =?us-ascii?Q?poLTAhAmbAwD6QNzQHnv9X7UfLEB9CfI+2c0CvK8w65CShlXYviWnZaNvCEn?=
 =?us-ascii?Q?8P7SIalToIWjq6supJJU9Wlz7F7MO+m669qbuXIsqFJjMIIl0Su2Uv8xTpCU?=
 =?us-ascii?Q?nu8KN7j4BUa9P+Ag6q19r5ImCXEZSmCKHh1zPaMQnlaceWHDVURQvFVGne8J?=
 =?us-ascii?Q?dxHtD4HA4uJk5dS5CV15k7r2q7ccES49E83BJjgTewtjbIDJ3SMvm5pxFDtk?=
 =?us-ascii?Q?EhzDNDQCRzWrtHQHoIoO0biL6bmQyurmE5QB097wAiJBAp6Xg1KtJCNM2AFn?=
 =?us-ascii?Q?xG51/ZOM3nx6egTIl21hWpK88ccR9yBaK0iGovzGKXUvz0ShXWd96EXeCCVb?=
 =?us-ascii?Q?wI4XuNj2zOWSuiKGtWQth0cUOb61ksU/uR4HZvh4rpjqb1n9Yr6ZTO6ujm16?=
 =?us-ascii?Q?HLEWJTvoIkcDW829+apKB616sz6zfHHHAcCTJP6HwCumWe0dsH9QGsHDmbCv?=
 =?us-ascii?Q?27CfCDgaqLRSaL8aQ/hHwIY74Vs4UX+nevyZHVxJ0vpIJS2mKIe30W4loisC?=
 =?us-ascii?Q?YKnzZ4lk+SmLx619YNIwTQJ5ku2WZgFQ+GcSdia6aW6waQs7KTWNTZHjHCr7?=
 =?us-ascii?Q?fSgt1SYXPsmZ9EWPH+x9e/A9VXeEtWj+K6r3+ueEaHyOQnLOtJW3rn9kpDth?=
 =?us-ascii?Q?eJE/kg4T1kH5uBbPlOgSY3rm0AwhUR32w41V7a8DnVtW6CJSA5m8agT4/piF?=
 =?us-ascii?Q?py441P1OLU9kbhpJe4/+m7r69jvYfhX1Ur3LlA7hd48/RTjiMN/0N7eJJncQ?=
 =?us-ascii?Q?fx3eFeBAAiR+QrMAlsylk1rl83RwaDl+3DU/+6gGrrE/hWyBj/b/SQzfB7ER?=
 =?us-ascii?Q?FYpI3FbkIyrj5zT8S2hUI1OKowjV+bJM+ysgL9c4hdNaDi3UAxDBimsAvw1s?=
 =?us-ascii?Q?D2JbffdDs/Rx2sKbGueRuxXyF0m8GZh0KW6JSFN5JMHj/yfdsEe/zvfP8fYl?=
 =?us-ascii?Q?F+v/A/SzXgoCu0XEHDY897PLpL7umSAaT/pPizIwlfRuXtNCbc9bDLIV42kR?=
 =?us-ascii?Q?BYdv2Q68G9TTN1D8j5v82zd7HMHJmcrKJyxtE2rTJgQN1ubPF8ugheLfWV0j?=
 =?us-ascii?Q?S/HFNGoO78WdSFIdKrdTQthPsfo/iJBGJuxduxHznko9pke7qlW7p3P6Z7SD?=
 =?us-ascii?Q?bdupCqvIXwYKtsVriA73zuSohQKuMK2AswxkjQlyanlzqtByOSCEqAnzoGIJ?=
 =?us-ascii?Q?7ENpt8ryCrs1HcgFP7qApkLAxk4sdsF42lvu5o04R7NAgYxUqzXrNRBNzs7y?=
 =?us-ascii?Q?iaoZJA6xL2JTjoQkxfwXE4De/EPptkBFHlnoDqLUmwoJLVHZQOsv/OjghCEY?=
 =?us-ascii?Q?kVigd1K6MgTnD1hJWVlmNe0UI2nv38P/4qv259821E/W60r+5mlEHgAvKBzf?=
 =?us-ascii?Q?Eo7/GEYvRM768AohelZU/FA2eKLi03UBAErYb3LGxnZl71paouqtXk0q8lYu?=
 =?us-ascii?Q?0qQ/0zhVxyT0ceI5bS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pii2DAfTY++2i3JFXNV33K17qAFRbAuTu1RydXJB2nYTlFqt94l47zn6A3rg?=
 =?us-ascii?Q?hwvvj1cfHgMMpr/hJdwE0EU5WSPTUKl26KyVs6xFyhV1PDh6gfwu758Ouwn3?=
 =?us-ascii?Q?Fv3Y6aV3Is7ZPESgoJ1yG9PIR++zCNRIW1J9ynvHv7lze+T6+j4BY9HUtjOQ?=
 =?us-ascii?Q?matzL2iKftqiEg21xloAYju27Grm95vdoYnPVs+B2G3OXKuYefNBIIYtYJJn?=
 =?us-ascii?Q?0uHMS/64pv0wSWeDh43pGiGQVfkrROMUy/0Vnx4AKN7TX1Ty8jwS5EITciPY?=
 =?us-ascii?Q?KOf6CSA7I145kCE6mYC2YWG7lUdoAfjaYeZvsiXC+Kj8U5vSYkmxzJ6NHcB3?=
 =?us-ascii?Q?5KpH5S55qigiPD2yXx9m526ayVeKAhij0dxrqfSRe6rbJ62G1VW9Pm3ilGoX?=
 =?us-ascii?Q?jRRND/BrKtEPlXY4aeBqoF6lVnUwF+VVdg3fYnBZFO10wmHb9sQ3e2ph+q18?=
 =?us-ascii?Q?oITgH2KAVZA0lVB9GYLegmuYSyvtlbWDpC4cc8gH/cU/9ejv6LO61j3/1O4v?=
 =?us-ascii?Q?wdS7FNhI9oV1zXe4MCnbuWkMs9RYBa6UYdlc3PYFJBEMeNvSxdiygrmQr5AI?=
 =?us-ascii?Q?BMka35uHPBg9udXMMRDgTh3itCxrreVTRTuRbXBjweDW7eytCWiyzWxulP7i?=
 =?us-ascii?Q?S+ajjkccQsaFP+rYBDq+fkUYrKDHGixM89C3RDB3mz5ZGgCtoLqh4p3d9sCy?=
 =?us-ascii?Q?3r7JIHxFX7g0opioJB+0zmmDnhQKIcilIlYNS0mCml6A19RfYrEL/TJ57yYV?=
 =?us-ascii?Q?FGFQUxN/zppcFVgL+gZtR9MeI0BkBz+Aysnu0gTrfE9+ja9cNBKV/x9i3AG6?=
 =?us-ascii?Q?Y5HgHZVShXFl6FtzNXNeAYNnbYOweVafMTxgeLH2+MGEdOG1UzxeUicNLJfE?=
 =?us-ascii?Q?9tc0DfKByMBLMXoB21mRdpiiVLHHwABv8ayFc4qeWwJaWpvYMcpxNt5CeGBx?=
 =?us-ascii?Q?znGrWCTl16pqKebMbUoxJC5MsliDcN4r2BG2v6rdj2O6mtNb3rljaS5RMTDY?=
 =?us-ascii?Q?+XxbWX6FaxrGZwi4ORVRC34m3NUtnhxZW4Pdch607NDYT7+dghYt814DPNH9?=
 =?us-ascii?Q?Sz+g4PVncSuFrjnpNblt5z5iNzFzI6Ktf8s5cZGbB4hshlFXS53lxqhT811s?=
 =?us-ascii?Q?e7VGxfYTLd0mi0QBh+o1ZoOq0mLqLHw+zu3LXXFIU9hbOlEjlLfn4+anxcnF?=
 =?us-ascii?Q?y6zmXXf6v1s3SX/hhmXgcgyw1aUP+4OCRjMG+Nuv0PZ4BIiokIKpH4iQwAgW?=
 =?us-ascii?Q?YBiooYCvnQKNxGHI8n8L2eGmXwPcfAQqvgQjHaz3jOcMEB/jhf3hXDqND3yh?=
 =?us-ascii?Q?LmU2AUu1ufmSBFfRv0kSQ6hjDuamVtQu/JpnUH41zCUi1srUEU6d0NMz4vZY?=
 =?us-ascii?Q?AdgTwMOJVfAoVGOUZa00IyszDyGuknhGB8HLwh41twg5eKv9vOehZkmHXieF?=
 =?us-ascii?Q?wbvM1tOrSTyLMM+9+M0Vq2QXHiJ+n8jGwEIkIeNJMbV7TiyShywegntApTfw?=
 =?us-ascii?Q?pwO4cam1I2gu9kfdhJQdQ5elYe3QiiFAoBVCl2nCmiTbcDkth/ax3h5PmyXE?=
 =?us-ascii?Q?pygk5S7Pc72vL5UC3VMUjuAe7IueiF5CVEN+tUJdk9/o5LHXQSmaldEjcD3b?=
 =?us-ascii?Q?fjjdugZyTFXOco1LEqsvUksikOfZjyiHdCkiWN8wDXNfto0grr1RVhO2RRta?=
 =?us-ascii?Q?ijCmnbxOiZZLQVzptif8WhP3hqQydo12eT3BsiPVsuNEAr2waUmGxA94VaeD?=
 =?us-ascii?Q?1svMmJUgQg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62969e4b-e5fb-400a-26ba-08de57c05874
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:07:56.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfeRJdyDZ5t6XZP1yYFwGaaztQhBLlZFkQtazF6J6higBsn/15txq1iJ6Sb6v5WXIXtGCVNrvWctJBzvKmAXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

> On Jan 19, 2026, at 7:07 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> On Tue, Jan 20, 2026 at 12:53:26AM +0100, Frederic Weisbecker wrote:
>> Le Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes a écrit :
>>> During callback overload (exceeding qhimark), the NOCB code attempts
>>> opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
>>> this entire code path is dead:
>>> 
>>> - 30 overload conditions triggered with 300,000 callback flood
>>> - 0 advancements actually occurred
>>> - 100% of time blocked because current GP not done
>>> 
>>> The overload condition triggers when callbacks are coming in at a high
>>> rate with GPs not completing as fast. But the advancement requires the
>>> GP to be complete - a logical contradiction. Even if the GP did complete
>>> in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
>>> it is pointless.
>>> 
>>> Since the advancement is dead code, the entire overload handling block
>>> serves no purpose. Remove it entirely.
>>> 
>>> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> 
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> 
>> Would be nice to have Paul's ack as well, in case we missed something subtle
>> here.
> 
> Given that you are good with it, I will take a look.  And test it.  ;-)

Sure, thanks!

>> Also probably for upcoming merge window + 1, note that similar code with
>> similar removal opportunity resides in rcu_nocb_try_bypass().
>> And ->nocb_gp_adv_time could then be removed.
> 
> Further simplification sounds like a good thing!  Just not too simple,
> you understand!  ;-)

Yes I have some more queued in my local tree that I plan for merge window + 1. :-)

By the way, I have another recent idea: why don't we trigger nocb poll mode
automatically under overload condition? Currently rcu_nocb_poll is only set via
the boot parameter and stays constant. Testing shows me that poll mode can cause
GP completion faster during overload, so dynamically enabling it when we exceed
qhimark could be beneficial. The question then is how do we turn it off
dynamically as well - perhaps when callback count drops below qlowmark, and
using some debounce logic to avoid too frequent toggling?

>                            Thanx, Paul

thanks,

 - Joel


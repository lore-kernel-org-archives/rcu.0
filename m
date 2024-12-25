Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275DA41;
	Wed, 25 Dec 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735090316; cv=fail; b=jZ0venCilh6RQky42zQeF9mmLbO6537RV192LvsCv6F62ittM3iJutSZtwzc2xNkeIZCIhc/YgBmBtkyhOG2oUGoZKAu1xYuxBU38hEJr+txLYnkwBxeADlbrVlFdrz8EeCmoAB5iQA65bRdQVDlBvdTH4qjT1sbWlwBKkW0dGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735090316; c=relaxed/simple;
	bh=yTuWwVYu8hP9lZ492DfDpjVDic7nhJ5R+Yj/mIpC1bw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GsH3hRb5tQhtXFSPk3z21T3izB5tJXyVwO8lnddi0RIHNtYDCVI5+9KmMqwGPqBEEN+T97dt42fWVGK7JfIpjJzphJmTBbvqt+My4jcqROtg6gytG9iVK2GeEFgqqj9tKvMZnKSsXE+DsgIG2X5Mi2sLgCNa5BZHSdcrNKs9H18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxCARLUU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxCARLUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735090314; x=1766626314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yTuWwVYu8hP9lZ492DfDpjVDic7nhJ5R+Yj/mIpC1bw=;
  b=UxCARLUUpL07JnvuKCBEQw102vRkvC6HDTJaWxoiv/bs2DyzxvT4fQ08
   vQw8m+p0dVXIs6wj3lspl6vuH/SnYpMZZ7l56jyrHtRinmU9pAVLqDeof
   kTm/4+jHu1p+YwToYWuO8HakhHZYmJwLQER01rmy8/GHDHry1YDD9L3uf
   Py9tp4u4XWjOJWnggBirZWxX7BZZG6Vu7haseDCCiXsZ28ua2qBlO07bH
   4Y3ZgmbJ4s70n876CaSOvwt3fPhquN3+gLCMPcJxnYJXzIp49F/VnSe3Y
   mUb51cecTL0VGyA0nUAwu+KFKXTOpbJZcovhRiumoFSbB7v5b5sJm2OAh
   g==;
X-CSE-ConnectionGUID: t5sbVpVaT4ay7Rr2Jj41dQ==
X-CSE-MsgGUID: x/+scbKWQu6ZygzYNkx68Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35715723"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="35715723"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 17:31:53 -0800
X-CSE-ConnectionGUID: K5yzkfi3RNqKL3z5Fc/IKQ==
X-CSE-MsgGUID: mwHQujFORfS0EvqJU04/og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="99358731"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 17:31:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 17:31:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 17:31:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 17:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHwwosKBMRy78ZFp2TxPSAw7upu3EBxde6FjjfBMJ0x+ROaAWBWs8iCykkspt8DpFC3CK3YjGaHSeOPBbVpL+Q5uXgoymi79+Zo6pM1N/a3h9iiKMlWG03PdIxMxKhFNlDzEnF+MvY8fB0ZMR9Pve/DC396kZ3Rt2BCy5rdNcJwEi5hY8bEkoNMjq89ekNeNKOxoEzOQIWdMTeHcK1E1DKeCmijeuCoD06KNJJXYQN+V5Ei9mmXZKUlA4ZhqPRVYulhNYL5p7qap2F6jW9gmdFHgO2wYnA67khPDmHj7YLmic4j507bTOY0/mww675VhaL1VRpNAC9aPG4eQlgNPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2CuwwrErPqqyHXSRsPav/VGFa/+DM/H3i990Ok7DbE=;
 b=GSUv01uaBt1Us2mTyzXVhbS2E1ELRQKGioyksdnDm0KEivmqECe/wc3q7D2eKdGH2DEOwEypKLDGjFl+beQjnsbmZFkBQgyImeQ5SPM+GOPXR9XmI9UFIULw1K5ZCgxD/Wp3S2ynCxMW05TJH1iNYGpJUEYvB+G9YnCvgcdqvV1wLUKH0xlsd/S4s+vRxC7wJ2o9xQ5I9O6qBV6X1uT8VJLGTQnDapQSV93FF8nMJe3BTgqdt5IjWDCbxLj9mjd2YXUmzhdCjbcB4dbnFA3u3cQN3Lp38cK0ZmsoxFUdNUm5JK+henH99El7pybunYl/Ut4PS9uXG7tSpgKK2bQwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Wed, 25 Dec
 2024 01:31:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 01:31:40 +0000
Date: Wed, 25 Dec 2024 09:31:32 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.12.11a] [rcutorture] 774c4d7adb:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <Z2tgdA4mNLxP0z0r@xsang-OptiPlex-9020>
References: <202412241458.150d082b-lkp@intel.com>
 <4062c4c8-50c0-4f49-b985-8b59331b8bb3@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4062c4c8-50c0-4f49-b985-8b59331b8bb3@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: e827b912-4653-4396-cf0e-08dd2483e1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YHBKMMYJQq104y294Uul/Wlb6lK+AhgekBDeJLqK8eK2wla19UwAXiOdqRqB?=
 =?us-ascii?Q?7i7Fu0/UxRDk1yezFJzLXF4P2ZM8kfC/Mj5mRDOqkYbB3rIZPIt3Ls4Dh+eO?=
 =?us-ascii?Q?5QlIOimR00VJxn+4kPy7V+AkvJJdlZdXQWygbm97Sr4nzzge09fPqfQwHfxq?=
 =?us-ascii?Q?IL4LLsXXPZQKLp7HTenFa6JX/P2l6xSk5X9I5x+lnWu6S9jy7Pj0XwW0f/lC?=
 =?us-ascii?Q?CT0QFe0P3Jgn8Ia7hR55RQlxu4JTCiBHAQ35Vx7PmKNw8E1o/mxRsYF93Ms5?=
 =?us-ascii?Q?zhE8cOS+UPOYBIT836a9JECvAMZ7XhN3jou2iUBpNjt5OVAPgk9SFmTmEfNC?=
 =?us-ascii?Q?/afGlXv5mU+gbVci9EvJIx1ZVey1wa0KFuLJPONzUEwnyjze+gr1upjlStKO?=
 =?us-ascii?Q?S46eDaIKpOltLlTovdMhR2YYZm5Woz5BWjhp61a2FBKXyU0QVuKpfDRBEcH/?=
 =?us-ascii?Q?M8JGj97Si1LLDsU6ArXhvxJLS33yfL1IL53kjCGKBMOamA6T6VFie/kIb1cj?=
 =?us-ascii?Q?/GgsNZ0eswEP1hX3oc0jtiiQNSIbo7jT/RBoS4Zix2P4nF/vwQDWTWBBacLr?=
 =?us-ascii?Q?dtCTwFW7Qk92YYTBgS8ASEHBh/j/seNsGUOMjHY3IlgM4js13VTFYmbsd+wk?=
 =?us-ascii?Q?FUS15gKEq0jeGonL+ZuDPCth9RDfA2HBTgu0AZ18H5Y9jFwfogtci2ytMP6I?=
 =?us-ascii?Q?XdZn5kzma/KZXJlQQitqkXyl98fS5tatGx9+MvIXDBjomhoz9OK42exapJIS?=
 =?us-ascii?Q?QflhVFs1bJx73AmSouReyiXBONZWDhfXHKxJv5/Ch4/4ku8OMgCFN+o2gUqK?=
 =?us-ascii?Q?L1vnoUt4h9ErL4Rk+8lcv9fl/NTVY/EjddrwK0wgcdttse8Grg8eiWjhN2Ek?=
 =?us-ascii?Q?D+Xvh5N//DI9Ork762qanNAs2v/MWmVKtQ/y7w02VftPIYosAyARTaJmFsQV?=
 =?us-ascii?Q?SDhe7vuz89FWChmtkzJwds72RB8Eos/6j9SLVh6hybJEHvbX5HwC0fOrywHx?=
 =?us-ascii?Q?zY8BsdjMNcMBKgL/FX1w1LpzPiZSXjMUfCuSjKa4qem+nmjxB6wLBvF88Cdr?=
 =?us-ascii?Q?FBufX36DH+w6I+zCvsmWVURjyZK+KRnC9rbyJmicR3OQuOm1ZBTs5oN8K8XH?=
 =?us-ascii?Q?7F6Xs2pdrb2vAw/Wv7lX619JIp7FmcInwVBrFSGGOZKshsKO3q6dlHjkTT5F?=
 =?us-ascii?Q?gkQenX/5Vzxn3i8k9ukSMWn8CQ7KBnVjm8FVzQR8c3osgpDEVX6iZ6SytvzW?=
 =?us-ascii?Q?eClVusVMiTEFxIzeEfJYkuIQaJNPv98cDY7oQH5Jfr88hbTvZcfh+zORxZiZ?=
 =?us-ascii?Q?009KA8DJGLSCU0i+e+Oos0avfei9kc9EeGWtn8XK1mAu0SFfw+NfUpubRpnD?=
 =?us-ascii?Q?EoZVttAGAfwJHO6QYgSP+ji6sbgE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgp9XaPIfIsun7E3pttzRmHP/ou0ir42XFxhxZHxKY68rNm8Y6OsHzMYTCCI?=
 =?us-ascii?Q?uyR4233u0eTOFfUCc5iXeLRcCsj9GSeSrjoOFrxE+zcWneHg6XhGJQkptJzn?=
 =?us-ascii?Q?OjrtjMG45yXNO7aGVUm+1yzGNGbKEWwhWbCVwKarFMSBX2LmxyT3mMEN/qcM?=
 =?us-ascii?Q?gYBxy8S1kDyuFLjzNZCRiFDpdrFw9n/Q6dFESDbLAhe/rSzQ+1W9ISj0oSqt?=
 =?us-ascii?Q?vEWa9YgMfR5UqJMRC0vuVXU/kCwcx9aUkKXEAJqJthjmmbPTTlwSBBplsMlF?=
 =?us-ascii?Q?WKu2EhNAz3tIgDo9Lqzh7UbcSFK5DqCyc4zWGa2xxf+QC60d9B5yq7FIp0Tx?=
 =?us-ascii?Q?S8hkMqE65Iz0V3yhMjjp9Mm0wPP4gG4Lf297tprMv/tiki85NbV3L0anFo2X?=
 =?us-ascii?Q?t1dNDUA6wRKpZUtTRhlkyZcHpstwgbuSWw958K2lxDEEzuRe8PM6+ZPw8XnJ?=
 =?us-ascii?Q?1+2nleyblFksywdF0WQDjJBdVX6N6wA8TIcTUy/qelNXBYtZMo9uZ9lub2sW?=
 =?us-ascii?Q?ZKkxZMB8WQDcqFf/rrvXdJ4esh1/ZjbuTb7K16Fe3zGnKDzdikwcRNFSc4en?=
 =?us-ascii?Q?XRntiLFKmV2XGPjQL6JmIuq/9uMOvNHZ0t1uh+mAK3cJBDXBdeNk/eCDh/2z?=
 =?us-ascii?Q?Tj5zRezMFegkvi9BFYXWgqdcRyHsiBsAKJNE+Tzdh2IZUl31YYhnX0qM6kXv?=
 =?us-ascii?Q?7Kdrd7UpGdLMNNylGN79rZvEv2H09Nq8POCPU9ILsQ4UH/6ey8CHfHAzuUoJ?=
 =?us-ascii?Q?zigGeF9zS88tfeTKMXR2p9VcGBV2yJ1x6x1VyYveLmMr1q9qzHAyKizSmvcv?=
 =?us-ascii?Q?duBuV2BdtmQZDxrfXRudCRYJ41whcLXLx35ynulOoAjFyIhfJ0w8IYYMXbxv?=
 =?us-ascii?Q?0++c4qjmK09uObMYvZt7bMZJ1VCh3N4ATBcWs6tl4b9oDmDbzN3hskTjOQYw?=
 =?us-ascii?Q?8Fc4qu9h2siKlZPhxZD6e0q1KLR7CJNfpEE6XOxg3TumXPjKbjJ2Q0cThUf9?=
 =?us-ascii?Q?j0dG77XiogSjQm+ewZHMY144wjjQIaW3xkqP9wUUiAPpDNeJnCbFGpS6xcQz?=
 =?us-ascii?Q?IkqTKkXchsarboHCQ3R8Lq0g/LQovNZBnYrmwISxWfDtg7BPQZ65EUeP5DcR?=
 =?us-ascii?Q?P1hyCwv4G6cIl9w+vEkwNmM9SO73572wBTcTolkh7H9HDrJnQUQmkIVL9ES6?=
 =?us-ascii?Q?7rWNxYAOtS3Eo/T8UDhvrQeyymaYGOccWWI19CqXhAWKW4fVgP3NeYSMCQ7I?=
 =?us-ascii?Q?cLiCCVgSeivNcZrga9s9/iXO+0pooxiYzsGlj/CxD8p5KIel30L/GSmb2QpW?=
 =?us-ascii?Q?no95yeJzR3qon5zgSsMBoIk8r6ZD9yNQd1uqlMWBeVkaeSqjIRaD7fl89JS7?=
 =?us-ascii?Q?2aSBVMjiFnKxjlVgZTiG03mrQG/M57K6Rio0MOM9q9rzYfMPkh+r2G8UvMkI?=
 =?us-ascii?Q?3hCxdhWb9I+0PHEZUgW+T8WQN4VSbSgEcjnAurX23sa4GtPIugzyt5bu1Rpi?=
 =?us-ascii?Q?LdLs7HKu6K92tb8N/AzLpXtOhoge0Ohel80ziuwapxNXdmExAlqd7tl1Zq+M?=
 =?us-ascii?Q?syeWxor6JONCl81MTgh2m8RUlfxKVUkNxdR4N5cZoRmor4vImKPE2yfcBfWo?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e827b912-4653-4396-cf0e-08dd2483e1ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 01:31:40.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqXYOGoOmUpkPkh6OrOVFP8d7SvHIMYz8HMajF6dI746aaok1fc3aCA4KgjNhZZBbqVdzjywWLcfoD/RTfUXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

hi, Paul,

On Tue, Dec 24, 2024 at 09:57:16AM -0800, Paul E. McKenney wrote:
> On Tue, Dec 24, 2024 at 02:48:26PM +0800, kernel test robot wrote:
> > 
> > hi, Paul,
> > 
> > we noticed there is similar commit in newer branches:
> >   dev.2024.12.11b
> >   dev.2024.12.12a
> >   dev.2024.12.13a
> > 
> > if this is out-of-date version, please just ignore.
> > 
> > the new config is enabled in our tests.
> > ==================== PARENT FIRST_BAD KCONFIGS bb02a67f70d8d58c675403f1f716cf5885967918 ====================
> > --- /pkg/linux/i386-randconfig-001-20241220/clang-19/bb02a67f70d8d58c675403f1f716cf5885967918/.config   2024-12-23 12:46:05.807021581 +0800
> > +++ /pkg/linux/i386-randconfig-001-20241220/clang-19/774c4d7adb4f9134aa265c5fee4e8b07d98c53cb/.config   2024-12-23 14:26:59.938500419 +0800
> > @@ -5864,6 +5864,7 @@ CONFIG_PROVE_RCU=y
> >  CONFIG_TORTURE_TEST=m
> >  CONFIG_RCU_SCALE_TEST=m
> >  CONFIG_RCU_TORTURE_TEST=m
> > +CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=m
> >  # CONFIG_RCU_TORTURE_TEST_LOG_CPU is not set
> >  CONFIG_RCU_REF_SCALE_TEST=m
> >  CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > 
> > 
> > and since the WARN added in this commit is hit, we just make below report FYI.
> 
> This one is a bug that has since been fixed.  The condition:
> 
> 	cur_ops->readlock_nesting() > 0
> 
> Now reads:
> 
> 	cur_ops->readlock_nesting() == 0
> 
> The updated commit is:
> 
> 14f8cc687ce6 ("rcutorture: Make rcutorture_one_extend() check reader state")
> 
> However, your Kconfig above does in fact show a bug.  It is supposed
> to be bool rather than tristate.  I will fix with your Reported-by.

thanks a lot for information! always our great pleasure that our report is
helpful :)


> 
> 							Thanx, Paul

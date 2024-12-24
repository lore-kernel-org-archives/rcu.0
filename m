Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747A14D43D;
	Tue, 24 Dec 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735022936; cv=fail; b=DiBqKmaVifTroqDcIcjINe+TjuWPo1mmr/0v/QGhOVmxwc6ZYQiqCF1pGOoEWihA+spcTYeV3Q8HECaf9mqd/WHMGIsjeNTXmylQ0SFbOFWsR+YmF0fC0g7deP+olOhczTF7NaIW6e3iYRAhD75nd/IdwgDWNnJDrl2AHobDqPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735022936; c=relaxed/simple;
	bh=vFa7t0Cpdkb+0JpN15bZYNXQOCK9S2k1TZf16N3Y5GA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FT8Ix6f/bVhAA/lW0IcSE48Ltx7M3biv5sTVz9UTCWFjesz1scAxBWEgkN1viOpDiFJthd/rln1lTewWbvtczt9tk4tGyklEbxtKup1J1voGRu6w+tCsY3JUY94w4dWhZmCjPFeMJZPaSyLCI7dQafP5h2tOtwga6ocYE/7GMR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3E0nAHl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3E0nAHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735022934; x=1766558934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vFa7t0Cpdkb+0JpN15bZYNXQOCK9S2k1TZf16N3Y5GA=;
  b=W3E0nAHlyX2uI929dTOzCUKQohfYR6cdwP/7aOuJiRxjSBuRIo/sjrA4
   jWH+tmfyWiLcwPCs2JBgTDd3NWQwKT4KyBF4Kp2oWxbq6ghVVQ9hvmpPv
   Ub31tSeJtBplPuYFeMOPuoxKFyUG3n0I0VyQsC9mnNkFm77TaL7WTQrVh
   0uEYqYtIwIkhz/Y/BMNo6SdZoWG9t/bTeoyI1EF985EvKU+Xr6y7iqlDl
   Dpdh5stxwxBFdrYkJPrt3sZwHKPGep7lLl310rIVVkmbUjOuBUA4BQASY
   325eSeHk1T/2cEXb94afa45gOlllSDpAVMhvtGWd3Pd9Ns091es8lYmM9
   Q==;
X-CSE-ConnectionGUID: bq/eW6yURv2HPnU3eALr0w==
X-CSE-MsgGUID: e9i3vRG1QIKXaMBFOQLRwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="23080385"
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; 
   d="scan'208";a="23080385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 22:48:54 -0800
X-CSE-ConnectionGUID: Qr8CNB1KTw22DBXlArILpg==
X-CSE-MsgGUID: WxKDZv3BSfKoNK0KmzFvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103499787"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 22:48:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 22:48:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 22:48:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 22:48:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOxiWZpS8+ugGRf21+XOVALffBfdYgdhGv3d5Y20wQgXnSCeMnXW5tVErdv2o2FVii8klTsxlnA/UNDhd1D/U17jaFAaLplh5phRNnPV6Jv+Bf37dMYnwWBwpn6ZnC/+kVsPQAAr3mbyB4XYIZMa4WiNOnbRuwPPBz6+BI8j9JayzC0n/a5TnSsdJHVC54eaYqphmx9DNOrl8UP4+a6awb77aKZ458YZREySnjEdqOdBGPxPgXHkuilc11Zqqc7+1mSgf1xzCVbPfO7bbJLPCMZsEMwB25sClXITm9hPDiyr4JyYGwGRGEJlo7twaC/o/p5jseAuM3t7R3/YeOdtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdqY2sgqe/1bV2qWszjvRRQxYhPDgMZ0sLKcjajD02k=;
 b=Jyjl9L/xhOgkEUzgpMGkVeCTa3JZSsns8cRbOACIzYlhYY1f1MNZjghaFZ4T3CxZbPEO5C7jUz3YajtdRqhoPcUXMYcBynKqNYSW/qlkEsRPotbo5VT92vnW6h1nZWYReC4jQa0UWe39ajTWg0sDNOjh/sDCbBqncWLEPTkpHeVQF/bqse0GtKiCJDGLlhPrsxM31UtwdR9LXMwaqOWtx4Bn8XwsA2Gd/HHLLw3MRJu/40FWzsPQEM38ix0wf4VUrYEW1gD83bPjG+X0dTZ9q76gXw9LiO7fFTsYB4ggqzO5r54lXqWulAe5YAzJNR9lfYwoKf4CMVKTeS5ht/F/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 06:48:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 06:48:35 +0000
Date: Tue, 24 Dec 2024 14:48:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, kernel test robot <oliver.sang@intel.com>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [paulmckrcu:dev.2024.12.11a] [rcutorture] 774c4d7adb:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <202412241458.150d082b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d2e2a5-c5c5-44d2-7767-08dd23e6fd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n17dH7+oMK/zjApX2BAJ4EHBQwaxd/m7xvwyqg4PMrJZOGjZmgD29bIAODx7?=
 =?us-ascii?Q?dtr0oaFYCva30YnRCBB6mr6qs6WJR1BpjPjNXDiRw0zgWnXD0KIfwTO0eO83?=
 =?us-ascii?Q?+/ySLbBnM1nJV7+rmTf3bkWejQcwPIrIidLoe55LK75W336MJ95Tvv3Zmjbx?=
 =?us-ascii?Q?hzPFn8DXf068ma1Be1d6JjfT/nWTaoEw2wFwJ+X0ZG4f8aediZuV1Kb7eNqT?=
 =?us-ascii?Q?nIZlHWucZMM6qj8o8KzUS/97rEqZ3AKi8gGzRpV/4ljTLBx71kvyMWuq9vcp?=
 =?us-ascii?Q?fFaOUU1NlTNaHhM6Lv60w1/MmKFbBwRzmN2I+DN/nVHWBMhvpMpAnK+7DMch?=
 =?us-ascii?Q?SyW67IyGook2USkb/TywPrIELGYZ6mtEzxoqMziyRCFY4guJZiI2nqH5IbCM?=
 =?us-ascii?Q?jigRujEsY/nJFHIo5iZ/h+y9gA39eCreLvssFeftb04c+KQJ/EJLwqpuLf9c?=
 =?us-ascii?Q?Y5C3RVc+j2DQwI7WwxqHicy0Q90qJk1OlEdzFCRe5el1sNBYZmJLHzDOPvEy?=
 =?us-ascii?Q?QAcmuGrwzB9EpfkM0py4uanMvqM7h+gM8Euv8ftzJBv/xLS2jzafSysM2AdU?=
 =?us-ascii?Q?AhklFeIhldtoWbmjgdKts5iV827zUmgjp9RQgu46SQaTzrct8uva4GEF3pjk?=
 =?us-ascii?Q?oNcbMg5yk9AtheHuWfwYKBJ6BCEa9IWlklLSWzcsEkLqj+9rNxu6xixsbruo?=
 =?us-ascii?Q?xomnEOUo1kDlFYeu6DyEOqAIJ3gywhhlIRgoq3omNLnVxnL35NYf632+Fcwx?=
 =?us-ascii?Q?psGnYX3seARdXNF2tEnj/xcrWmxfVSxCkAE4WmgFlUqQbNQyskJ0Z5FZ7nON?=
 =?us-ascii?Q?hIyegFMGobOrzjNQfWqaXzMqecBT/YGFwQ4kU7xUfpvrU4+zNwZSFeZvWiqC?=
 =?us-ascii?Q?Ycv2gP8CTzo/THmvrO9AnSJjvL+5DsVooUjLVeftoGzA8J0rM4zDPLgKNDS+?=
 =?us-ascii?Q?bqWgBdlbQSioMt4s1VN21sRpUndYUlQ6K9vWf67Xj2EG9wmT4SPtc5qAJeQ1?=
 =?us-ascii?Q?8iUo4dcpiQNZcwW4svs0H9YY6OzmgtqGO/0t7AjTl3dmQBrwQuUeKqV2Use7?=
 =?us-ascii?Q?30dk5ETbz0jhcGmt4KpEsX1lEMef1RrRoIf93F5qTtQwuX5i1z4XfGL/VuzK?=
 =?us-ascii?Q?Yh/Xme+EefXnDSZtWQ3OFQWeIdVTGtW8ZiJe1PyNoEvxvDbE8OEs+hn5C7jt?=
 =?us-ascii?Q?yTAD/NgEe11c4Sqt7SQi73DQsH+kQ+4zfMSmv+5x5AWF4BXIayOGTdfkutJP?=
 =?us-ascii?Q?n/X6MEdynrCchbUqaIxGLNmRG0TElTXJFIGeQGxrDZi2cShVK13fsf2RDhjK?=
 =?us-ascii?Q?rxc0uFB5dtap7+0RN7IQKiIT1Z0RJRKTFHKtTQFLN8dLgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YrJO9MRe12hfZPtHcI1MK0O3t0ZLBMdVxnPfk6uxi5htbo6u3eBh6fbE1oni?=
 =?us-ascii?Q?ZKjIkMWM0WSBVE+zm8qMlHgquaHKuIT+23eve6g2Jfy2jRlEaE9xG9ytQIlR?=
 =?us-ascii?Q?3b9f1jj5qm4fYdkMxAi25QODdlLTtukCDgZmzO5AVp4hJ5W3sMT8YSTnGtwf?=
 =?us-ascii?Q?yAhRVOoSbqf6t/MaAQ7LIiiJwaYv8ov3guYwnbbfaJqcA0QMzzIbuXP5lHjf?=
 =?us-ascii?Q?okz7us3Fen1kP0Vd9+ElQYiCR4Eag5REPs/wc3CEyyyUhbM+FlemjSw36V9V?=
 =?us-ascii?Q?3uergcorpZtI+AXB1fcCDziC3gtT4fS/XNAXG0NsBx/YbGuQR3mVzRTqjJ4x?=
 =?us-ascii?Q?qsaIS3zikdmR0jUfU346Mxp3yvJ1MC+0aPkv7qTYFpxNfylVKVRXZGOUimQe?=
 =?us-ascii?Q?lTkwESRu9Y9Xkt9kSJEu3YMjo7ITdSc8eiH7L8khZ9gunlOwkN3aPQNXBEM/?=
 =?us-ascii?Q?rc3Qnj30MKx+CUtJbyuSxXx2DiA/0QKNgTEaOEUhVm5oAwjslfOdiofWNpdW?=
 =?us-ascii?Q?4ROn+lYkBnID8CafZrMePuRX2yG5mOYg8jyVIACaIcARaLk+0ocyNe+hyhc0?=
 =?us-ascii?Q?fbahdOYxzuGfHNaRZwJ1mYvPG/0w79cW/yskJ2TUuw3WD6BUiwP+8GpNIS5A?=
 =?us-ascii?Q?9vOSkE6ZQOYFNkzD14Xq1gq8DwfyeOaVhWguVObCCg5Ob9n6g3EjvyHj2Ogm?=
 =?us-ascii?Q?lSFeEvwVWZ1qGzS6APr8EtI9SObrEqcXeKIP/0juEzo6D64m1R9f5yKhcmPC?=
 =?us-ascii?Q?Z6peqhLQ9RRbfvl0SYp/8riukAC5bvJgGP6IxdJVzbc4lzvWHnlmsitkpuW5?=
 =?us-ascii?Q?JCZ/gWlqiU/pOaFiLxaJ088c4ksXS53rKV8TXE4Zg55mbHHgwvzkweTEmZVI?=
 =?us-ascii?Q?JSLhRmpEUu7EwuQKmCi9jMW3iVK+FjWCCwVlC5BfoQDPO3OU+ZgVIx+xlSOA?=
 =?us-ascii?Q?wGLIaOF2QPxe36zHeE4EZMYOGCR1LWgQiQKW7agEOF6Ksp2ayOT0y4h921KD?=
 =?us-ascii?Q?+xUnmtwAkZxVec2rjBqqjXAZLYt7VWVL55K1UZsDeG18vSafCm1B31eo8qzk?=
 =?us-ascii?Q?6fOXWzGTu8RuVP7UOWYlOBp/Hl/Z5evml+E9Lb5NgzatC1eodvXA6niBbY0G?=
 =?us-ascii?Q?wEvnMAZFSbfo5XvTP+gG8+5V8Vv7L9ED5+MMs87/MZjv+PaAYdkBPFiohpJh?=
 =?us-ascii?Q?wKs+VPhgnx26Jcq+vYodiJ1vQCTPBBK5vUKOFAH+IqY8O9N0/7lV8BUuZM5h?=
 =?us-ascii?Q?m8/ouvPHDE2Pg5Bw+2AqI2z3UurcpzW6wcwcI9G6TKnc37pXaATNdo2ydb/K?=
 =?us-ascii?Q?SzKpdpT7WyIKXfSeAfbaSHhxOHN3eKr0L+amMKtOPrO4uduQIfM2jv+kUYpd?=
 =?us-ascii?Q?z0hxnznS+zntsVpNLQzt0fkCYFVsa1hPra58n8YdMkoxyNbUzAu/QqJeGGjm?=
 =?us-ascii?Q?/zCgemYXLf15NOjrDJbyDpxS8Ri35RE9aD9r8qL3TzVen0O+KiydRBc1sxbT?=
 =?us-ascii?Q?e01Qa9QAvhUcthTdCbei6tkNIa3le5/hAkH9BHY6rrVXVepjJTvvmRB5zr/M?=
 =?us-ascii?Q?+MeTWkL2BhGElfLfWVO4KTmJO6Z6z8KiQ97NuJlLDH81et/FrhZsqxyp+nQb?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d2e2a5-c5c5-44d2-7767-08dd23e6fd18
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:48:35.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8eb3sR0HxcGWWr62SEJAkGnB+78XWwD4R72Ugk/7dk1BtQ0ThCYWPCHAFtnMdSmMdWlPNrchI3s5QB6r/Rs1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com


hi, Paul,

we noticed there is similar commit in newer branches:
  dev.2024.12.11b
  dev.2024.12.12a
  dev.2024.12.13a

if this is out-of-date version, please just ignore.

the new config is enabled in our tests.
==================== PARENT FIRST_BAD KCONFIGS bb02a67f70d8d58c675403f1f716cf5885967918 ====================
--- /pkg/linux/i386-randconfig-001-20241220/clang-19/bb02a67f70d8d58c675403f1f716cf5885967918/.config   2024-12-23 12:46:05.807021581 +0800
+++ /pkg/linux/i386-randconfig-001-20241220/clang-19/774c4d7adb4f9134aa265c5fee4e8b07d98c53cb/.config   2024-12-23 14:26:59.938500419 +0800
@@ -5864,6 +5864,7 @@ CONFIG_PROVE_RCU=y
 CONFIG_TORTURE_TEST=m
 CONFIG_RCU_SCALE_TEST=m
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=m
 # CONFIG_RCU_TORTURE_TEST_LOG_CPU is not set
 CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=21


and since the WARN added in this commit is hit, we just make below report FYI.


Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:

commit: 774c4d7adb4f9134aa265c5fee4e8b07d98c53cb ("rcutorture: Make rcutorture_one_extend() check reader state")
https://github.com/paulmckrcu/linux dev.2024.12.11a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: rcu



config: i386-randconfig-001-20241220
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | bb02a67f70 | 774c4d7adb |
+-----------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 6          |
| EIP:rcutorture_one_extend_check                                             | 0          | 6          |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412241458.150d082b-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241224/202412241458.150d082b-lkp@intel.com


[  216.715283][  T904] ------------[ cut here ]------------
[  216.715807][  T904] rcutorture_one_extend_check during change: Current 0x10  To add 0x10  To remove 0x0
[  216.716750][  T904] WARNING: CPU: 0 PID: 904 at kernel/rcu/rcutorture.c:1907 rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture]
[  216.717867][  T904] Modules linked in: rcutorture(+) torture
[  216.718418][  T904] CPU: 0 UID: 0 PID: 904 Comm: rcu_torture_rea Not tainted 6.13.0-rc1-00040-g774c4d7adb4f #1 af41ae9ed56f032bf259b1a5e19207f049febebf
[  216.719655][  T904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  216.720591][  T904] EIP: rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture]
[  216.721316][  T904] Code: 33 e9 88 f0 01 0f 85 19 ff ff ff c6 05 33 e9 88 f0 01 ff 75 0c 57 53 56 68 f0 70 90 f0 68 f8 7b 90 f0 e8 a9 ac 81 50 83 c4 18 <0f> 0b e9 f3 fe ff ff c6 05 2e e9 88 f0 01 ff 75 0c 57 53 56 68 f0
[  216.723166][  T904] EAX: 00000000 EBX: 00000010 ECX: 00000000 EDX: 00000000
[  216.723887][  T904] ESI: f090673c EDI: 00000010 EBP: bfba7d84 ESP: bfba7d70
[  216.724539][  T904] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
[  216.725236][  T904] CR0: 80050033 CR2: 37270010 CR3: 7a10e000 CR4: 000406d0
[  216.725919][  T904] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  216.726581][  T904] DR6: fffe0ff0 DR7: 00000400
[  216.727015][  T904] Call Trace:
[  216.727325][  T904]  ? show_regs+0x5e/0x70
[  216.727761][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.728747][  T904]  ? __warn+0xbc/0x230
[  216.729128][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.730100][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.731092][  T904]  ? report_bug+0xb8/0x170
[  216.731558][  T904]  ? exc_overflow+0x40/0x40
[  216.732002][  T904]  ? handle_bug+0x49/0x70
[  216.732431][  T904]  ? exc_invalid_op+0x24/0x50
[  216.732855][  T904]  ? handle_exception+0x14d/0x14d
[  216.733294][  T904]  ? __pr_flush+0x4b/0x390
[  216.733842][  T904]  ? exc_overflow+0x40/0x40
[  216.734283][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.735278][  T904]  ? exc_overflow+0x40/0x40
[  216.735710][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.736707][  T904]  rcutorture_one_extend+0x185/0x3d0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.737663][  T904]  rcu_torture_one_read+0xbc/0x7b0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.738651][  T904]  ? __mod_timer+0x27e/0x330
[  216.746584][  T904]  rcu_torture_reader+0xd9/0x1a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.749179][  T904]  ? rcu_torture_boost_failed+0x200/0x200 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.751803][  T904]  ? __kthread_parkme+0x41/0x90
[  216.752973][  T904]  kthread+0xda/0xf0
[  216.753996][  T904]  ? rcu_torture_fakewriter+0x3f0/0x3f0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.756499][  T904]  ? kthreadd+0x120/0x120
[  216.757734][  T904]  ? kthreadd+0x120/0x120
[  216.758682][  T904]  ret_from_fork+0x2c/0x40
[  216.759952][  T904]  ret_from_fork_asm+0x12/0x20
[  216.761040][  T904]  entry_INT80_32+0x10d/0x10d
[  216.762389][  T904] irq event stamp: 515
[  216.763447][  T904] hardirqs last  enabled at (525): [<4111f4ef>] __console_unlock+0x5f/0x90
[  216.767137][  T904] hardirqs last disabled at (542): [<4111f4d6>] __console_unlock+0x46/0x90
[  216.769278][  T904] softirqs last  enabled at (538): [<429843ea>] __do_softirq+0xa/0xe
[  216.771284][  T904] softirqs last disabled at (533): [<429843ea>] __do_softirq+0xa/0xe
[  216.773548][  T904] ---[ end trace 0000000000000000 ]---
[  216.774848][  T904] ------------[ cut here ]------------
[  216.776416][  T904] rcutorture_one_extend_check after change: Current 0x20  To add 0x20  To remove 0x4
[  216.778844][  T904] WARNING: CPU: 0 PID: 904 at kernel/rcu/rcutorture.c:1904 rcutorture_one_extend_check+0x286/0x2a0 [rcutorture]
[  216.781764][  T904] Modules linked in: rcutorture(+) torture
[  216.783330][  T904] CPU: 0 UID: 0 PID: 904 Comm: rcu_torture_rea Tainted: G        W          6.13.0-rc1-00040-g774c4d7adb4f #1 af41ae9ed56f032bf259b1a5e19207f049febebf
[  216.787364][  T904] Tainted: [W]=WARN
[  216.787735][  T904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  216.788655][  T904] EIP: rcutorture_one_extend_check+0x286/0x2a0 [rcutorture]
[  216.789311][  T904] Code: 0f 84 12 ff ff ff e9 29 ff ff ff c6 05 32 e9 88 f0 01 ff 75 0c 57 53 56 68 f0 70 90 f0 68 f8 7b 90 f0 e8 fd ab 81 50 83 c4 18 <0f> 0b a1 14 a4 88 f0 e9 fe fe ff ff 00 00 00 00 00 00 00 00 00 00
[  216.791093][  T904] EAX: 00000000 EBX: 00000020 ECX: 00000000 EDX: 00000000
[  216.791732][  T904] ESI: f0905abc EDI: 00000020 EBP: bfba7d84 ESP: bfba7d70
[  216.792366][  T904] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
[  216.793054][  T904] CR0: 80050033 CR2: 37270010 CR3: 7a10e000 CR4: 000406d0
[  216.793757][  T904] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  216.794425][  T904] DR6: fffe0ff0 DR7: 00000400
[  216.794908][  T904] Call Trace:
[  216.795233][  T904]  ? show_regs+0x5e/0x70
[  216.795648][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.796617][  T904]  ? __warn+0xbc/0x230
[  216.796983][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.797941][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.798994][  T904]  ? report_bug+0xb8/0x170
[  216.799451][  T904]  ? exc_overflow+0x40/0x40
[  216.799891][  T904]  ? handle_bug+0x49/0x70
[  216.800322][  T904]  ? exc_invalid_op+0x24/0x50
[  216.800793][  T904]  ? handle_exception+0x14d/0x14d
[  216.801272][  T904]  ? __pr_flush+0x4b/0x390
[  216.801697][  T904]  ? exc_overflow+0x40/0x40
[  216.802126][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.803118][  T904]  ? exc_overflow+0x40/0x40
[  216.803584][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.804577][  T904]  rcutorture_one_extend+0x382/0x3d0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.805520][  T904]  rcu_torture_one_read+0x30d/0x7b0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.806431][  T904]  rcu_torture_reader+0xd9/0x1a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.807392][  T904]  ? rcu_torture_boost_failed+0x200/0x200 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.808371][  T904]  ? __kthread_parkme+0x41/0x90
[  216.808823][  T904]  kthread+0xda/0xf0
[  216.809198][  T904]  ? rcu_torture_fakewriter+0x3f0/0x3f0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
[  216.810157][  T904]  ? kthreadd+0x120/0x120
[  216.810574][  T904]  ? kthreadd+0x120/0x120
[  216.810983][  T904]  ret_from_fork+0x2c/0x40
[  216.811391][  T904]  ret_from_fork_asm+0x12/0x20
[  216.811834][  T904]  entry_INT80_32+0x10d/0x10d
[  216.812322][  T904] irq event stamp: 1041
[  216.812701][  T904] hardirqs last  enabled at (1051): [<4111f4ef>] __console_unlock+0x5f/0x90
[  216.813568][  T904] hardirqs last disabled at (1072): [<4111f4d6>] __console_unlock+0x46/0x90
[  216.814320][  T904] softirqs last  enabled at (1070): [<429843ea>] __do_softirq+0xa/0xe
[  216.815071][  T904] softirqs last disabled at (1061): [<429843ea>] __do_softirq+0xa/0xe
[  216.815802][  T904] ---[ end trace 0000000000000000 ]---
[  216.817430][  T889] rcu-torture: Creating torture_shuffle task
[  216.818829][  T889] rcu-torture: Creating torture_stutter task


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


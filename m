Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FB62A02;
	Mon, 23 Sep 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080488; cv=fail; b=G5BaXiVciHRc4bgqs9f38roWeHWCPuVtKuLJGmW8WCvAcOa09gyigHYTYIU73tawOAe6xmCO1d7e806bQQEOt/7j4n15DcA+RDJ5NJK6tGwXYEIbrXJNAj78/9Pykt0epWAGneQzTnNw+DfjlAMGML5EMCR8ExdiNUWc8Tm1BkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080488; c=relaxed/simple;
	bh=LfODnIb5539D6OGd7SANtDubrjVQ9XVAWQzN3jHHVH8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QjpVUd6C1JEs3dfnBMzGfdUW986Q0lazE3SbR8DWCHWrFV7+RxdCl5lWIC8tqRT57adeTYIGJ9BrrfPZa68rd2P6Yo12FOqr+f7ljeNXEi2YtFnwaPS8ftSQeCQym8hMF1cAbrkUkW6q1JISAULirUtwsGfwL/7BGdKb3zluKME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUo8LfqM; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUo8LfqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727080486; x=1758616486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LfODnIb5539D6OGd7SANtDubrjVQ9XVAWQzN3jHHVH8=;
  b=mUo8LfqM6oXnBl6fkS5VHCoNVUO5G+IzFV8MNawBASXiEzR/T4JbFiJI
   QMOh4Z7k0ceYNK/eIxr8zEShmzZGlyFy2U99trqK30tW1zYgwLtkKFVcK
   3WHIqWrmv1vqIg7WBH388jTtU3oF+5lWjE+TxePUWjB5A8UBcjf61DZFk
   l5irHZBlJr58tzaiYc3LycPc55rRT49BtX2n4jy6kRsi7WRLH1t4OGNAa
   SqKXvv5sjVpEmyTdZkYNSK+HyvdnG5uMep+B/jfJJ1zd5S6AQ//ZNxoqX
   uUKK5CrZn5j5mgaoCSsZNmPIck/AzTcedq9+JaSw7/00W0ojXAtS8g7po
   A==;
X-CSE-ConnectionGUID: Pvu6CCkXQ9uM64n26Cf4yg==
X-CSE-MsgGUID: meiQmkd8TWuHZoVUu+tIaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29905831"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="29905831"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:34:20 -0700
X-CSE-ConnectionGUID: IFGiuonXQLCD0BcNBTgf3A==
X-CSE-MsgGUID: FxJQfcvlQV+ANjVMw79Bkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70585437"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 01:34:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 01:34:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 01:34:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 01:34:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 01:34:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tlbr43dJhrZDwQDANJIcqqe06BrDSxZTFLVSl2EtvtqP7GzrCe2S3sQqW83PYiPv5jzXdJvo9MlhPIzA5heRiHdT1ryGx/cNOtMi2BLy5cxNOTZzI4wlqRQR7WcZ0g8m6rXufahfzEd76xOu+wfAXNdUImrp65jzdPXdr25xfJ8OhDLE3Drx6YKynNNDJ8nTopkevgLJLDM+Okn8XGo0YOrk/6q9TxoGtObSo0PxDTVSVeVKaKPdCauZrFbpH/wcXIpSPG9g8PB55/isJvPNBwP+EzL0qxBZty+Ry0AsmMpjIMAAMnLY1HM6hfFgYyZMLbF5cLmpNDFkuoK0MNOltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi/MQ6M7Xx5bJl+lW5FL4Wt2q/Y3VEyuRPo036bLXGc=;
 b=EHASwFwXnX4JvIy04Fm/ARcRj11xe6eSxEhmC3LsFE9EcaYrapRGEFZITZcKu/UPZXLt4MOzvYoSMRvfXcOStP7Nx+3PwmpIc1kLkzpuEosjueoxBwzdD23bZUJWwYiNmd8NA6IOlQEGHjdkentgqjnx5IIoyjUY8+j3bSJuzxd51suSBdyJRCi0IhQNv6GO2YCeWzaV6DDWsnGu4icX3RRAdFpRTCzRQJnX5QaQHDtHTZDQirWvVXfqVwkyVvuNMgAxfgxVqIs3U0tZ1dINzjEvTJNt/81dmgcn69PXiVuSxEhOqMaONWtI14qFlmPw8sHkt4DpLO3AjbXivHkT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 08:34:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:34:14 +0000
Date: Mon, 23 Sep 2024 16:34:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Cheng-Jui Wang
 =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [rcu/nocb]  9139f93209:
 WARNING:at_kernel/smp.c:#smp_call_function_single
Message-ID: <202409231644.4c55582d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 466df1d3-ff68-4a67-a3d1-08dcdbaa8180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MW7XlVi2yThvo11Fw+dtysWvo3sVwk1gUDpWH4NiPk5dIS+rxFyTkF7tObZf?=
 =?us-ascii?Q?cC2qbc/UPQ2j+ptEuOBdFZnGts7Ubzxj0qkttnyP2sK+iNVmUpRt/XS2IizV?=
 =?us-ascii?Q?/WdXM6I2kZ30Lqx0TFSzITNdylJIsltC+nS/rvEihk0YI82TbT1i83XRf2Yn?=
 =?us-ascii?Q?A0f/I4UXKbQHroc8AFRhwW9ilAAcljd0M2J65R4hvuvZitYsl3/oT8qTTRZs?=
 =?us-ascii?Q?4K03invAlRH6W29vAzVuvJv7z26Lt+b3anu4aWvU4w46eSPnnLUuNOeqiO7+?=
 =?us-ascii?Q?SernMIhFh4tg3isYt19X89MbbYg0HlcgN9WniuZhFVLIHlO1Iud2RDii9jjF?=
 =?us-ascii?Q?4FYXnmea4ZaxAcJ8GbTOFEUUWpuWdsnnoMM2Qi3ZhJeHsi+UWTwNys+gFgrY?=
 =?us-ascii?Q?XILuG4KoRqSg40m+5BPODzpuVgDZEFBCxl60K+uaOD+9V/PAiviFP3fE96uZ?=
 =?us-ascii?Q?dfp8Wfp/tGkBoawjV770ag5lNGrm3KA9upcNgbxWlJU6k/0Yyc6uwzZ0tYoT?=
 =?us-ascii?Q?52OyDw46E+knF/mYayDEm0/PPlDNZeqcV4ZcR2mbY/c72r9MxI9LZIuJOhah?=
 =?us-ascii?Q?0QTvuLDujYJqWX8NGuqwKGPzmxrIlMY8ybZVEw9knpbQhnTZ2MefVgy9KPHB?=
 =?us-ascii?Q?L9WaVSVT6Wuw7AW6x0+q1+XlM7gDPlYPs8y11BK+ZbMqX2txTMPXWvp9c1y+?=
 =?us-ascii?Q?9JrQDzDstVgjdjanzcomPLyMP37PsYqaTmKXkHuhuCeL1HTuZUZg8/ffpSA3?=
 =?us-ascii?Q?/SPNXTyl0N3U9SKNUT2YIbOdN6yGqe5C3fsNgS4TiSuV1W+eBxlmdFTVNTIr?=
 =?us-ascii?Q?cJZVKZU8ZKD+KtdCgb1S9hTVU+EWMWt4eiWofUzePju0g+QRTDlJ8+qlkHNp?=
 =?us-ascii?Q?GDQ8o30i10IbtlZI4mO9QXqmFzvYmBVlqsFVa9i6iBKb0h2L21v/Q9Zk/uoH?=
 =?us-ascii?Q?0pNy5lF9iLVIIhVZteq5KlmgJY0T4h7EXu17IEHAW5ywyrU+10547Vj5XZDQ?=
 =?us-ascii?Q?pSCx+jzo4HoTb8dytwUbbxpayCGZ2Ki34cTObeJsS5xGG5Lapp/QOY1fVXSU?=
 =?us-ascii?Q?D5UpC4nrnQdcC4ttAY0RsLxWzaMTlKfAK9y2GLQ0k0iMiwqxroU7SvbZjTr8?=
 =?us-ascii?Q?eRQI9Mo4VMYgmnelmeDAPeE/UWmOsVCnz26cF+8jv/TNHcL+PaeaoiGI8kdX?=
 =?us-ascii?Q?vdbhikbUjVd4j7ieX7vOorTfkXF9lLvqCkcZvvYxijePQtYOshizNRh/AH+s?=
 =?us-ascii?Q?H/cToOIEsD5B4wE26cfcHdqg+qb6E3VbfN0A9FFyCr3qfJ6u2duuKtkryLz3?=
 =?us-ascii?Q?yxReSzidASUHqUAfhG5Oyk9Jk520uE8PkCKHEtvMyT4vOmroXZuSZEOyA1Ov?=
 =?us-ascii?Q?vNGdGNU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvZkfycvQ07DZCRAu/hYaT1O0RarrvnwKte5jm/iLoGM3JxKEPVT36PoabA1?=
 =?us-ascii?Q?R5aTz4fIjucrGSDWrzdlaCLm0GRrbi9472midolSk+zZRxs5kEDt5Cgv3xOm?=
 =?us-ascii?Q?tIrkSp3CvDiMbYQAyMRGZ2a4rd3NC5e1Un8JSMeQxTxsC95eMRqk3kFh1Q5Y?=
 =?us-ascii?Q?aEhxrPlBvfiXDIdVpIBhK/VMoTbOJUNylY9QV7z/F+I6N192Lxcgy5Zr0pUv?=
 =?us-ascii?Q?msVOrv7D4EaelxLzgE9BVw1ZxwKzlaAEEfY+XBg7eO3fFprGerQcrbRpaOw2?=
 =?us-ascii?Q?RiFmrkGn3TJ+DqZPmfNPfUKIqUSJV75H9xaRZq72my3U30CfbxWNQ9AbIaPt?=
 =?us-ascii?Q?ePlCRodzcLEbNduj+3qcn9Jb5quiOKxcSPDlDAYD5GFiJgSpbrxl2XUYlXRm?=
 =?us-ascii?Q?lDi0/JwZE9MJef6RaiAoNm69BVCc7UNc0tJDNMvtZV0x4ULVYUDJBLswZC5h?=
 =?us-ascii?Q?cnaI3qZ0ajRTrNAydvE8JQOChcROm3i4PRDDUAoJ7QqK7cFA2M675utAuq0Q?=
 =?us-ascii?Q?Jl44/bBl+TB9EdDkkyM38jphgC9OoSfX9JgvgaNluMD/Ji2is5U8dV5iA58F?=
 =?us-ascii?Q?YuLB74cJpvj2bBgPCvjb6nyLBt/AtBKG5DgT7+Wgm6iefCPzVcbuGT5O111l?=
 =?us-ascii?Q?2+Nj4ngji6e/6L1cEw6oeJmmCcQtpIAv+Z41z+6HOKmF3WysM/+GXNsqfXGd?=
 =?us-ascii?Q?z2ER48JBgwmP3j8rHFxOSxueKHJYZxrnere0LrHUjILFrWH0gE+q5AEM9Xbk?=
 =?us-ascii?Q?Ipp5sYJDLfChyM8iLhKyHOqHKECEfHPjEQd2GtnomVKLKm6q7m6MeJk7u7El?=
 =?us-ascii?Q?qgNGmtjRWe1QD8Y5lRaDVH14h/5R6Ew+Xk9QHYYFkZvHFdvqpUKK7N26CgmW?=
 =?us-ascii?Q?tIimWJQLVYq7OXzaFnnOdCrz+jZlFfGYOKV9TtQfYJw6YT1RWCc9ZXTarPp4?=
 =?us-ascii?Q?2XAq0rqQMboQyN+hFDUJliaMenRlw8WTwwj8Vju17uUZdoIqcb+xfzIry9Hg?=
 =?us-ascii?Q?q5EuLoZ7yW6Rf/CRfKy0lQyNjtexRNBfdaKwrIdtvRA9wjtUsnTOXHTc2KVj?=
 =?us-ascii?Q?/HSEB2u6n3AE4vdBj1Yia+mvS6/6CH48uu7R1Ev6EGuFjZjkKbRbe0mtguHo?=
 =?us-ascii?Q?nJdsG+U9mD1qNpc3Ln2CMD6AXOct6xZH5Eqg6d4vyPik7xnsMvcNOL2Kqe/1?=
 =?us-ascii?Q?6X5ZmqwEcobXdl0UIH4p6IsiJoyDsnI3fTAbg0P3jHMKLq5qT4nZMZt+Ih2M?=
 =?us-ascii?Q?tOjxmtcvGI6N2BIrEobCBlUR28VOx36jNOA2Kpzw1Xhcwicm/DysDQT72BaH?=
 =?us-ascii?Q?IS87kC2lJ8Ik2jkgn7DbvaVdLY36zyCp6jXTgkORkrsFfvpm5ppLYcRwiNRf?=
 =?us-ascii?Q?Pc7QAJ118vlRl7EqyqOAZzha7I0VRJbl/RvhbYx1tXg4oko+xY0ySnWFqBjj?=
 =?us-ascii?Q?luqHABSV1mjcRFcjRPDsVvwpdeM41a3QPrulo1EY8aroB/hG5mp7yaPNI++w?=
 =?us-ascii?Q?blrNL4ixJGJ/JwrDm7oC+4SfsT2CAOVbxiOuUggRecCkkUvlvl3pL1gASWRm?=
 =?us-ascii?Q?IxDQZPkFvJR6CS6fbATG+3/NWJFqEwcZMhtuUI94x0/fsDREjmIDwfr5xZIh?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 466df1d3-ff68-4a67-a3d1-08dcdbaa8180
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:34:14.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s3kVN4DRpwFvttw0go35byPpm6aSK1netcNFq/z0JW6KSsysKzDi1L/luC2J2ITVayFxB+tdByG/kuSmdicdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/smp.c:#smp_call_function_single" on:

commit: 9139f93209d1ffd7f489ab19dee01b7c3a1a43d2 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      1868f9d0260e9afaf7c6436d14923ae12eaea465]
[test failed on linux-next/master 62f92d634458a1e308bb699986b9147a6d670457]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: rcu



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



we noticed the issue doesn't always happen. 70 out of 200 runs as below.
but keeps clean on parent.

1fcb932c8b5ce862 9139f93209d1ffd7f489ab19dee
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         35%          70:200   dmesg.RIP:multi_cpu_stop
           :200         35%          70:200   dmesg.RIP:smp_call_function_single
           :200         35%          70:200   dmesg.WARNING:at_kernel/smp.c:#smp_call_function_single


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com


[  174.242695][    C1] ------------[ cut here ]------------
[ 174.243292][ C1] WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single (kernel/smp.c:633 (discriminator 1)) 
[  174.243960][    C1] Modules linked in: rcutorture torture
[  174.244381][    C1] CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
[  174.245082][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 174.245867][ C1] Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120 
[ 174.246506][ C1] RIP: 0010:smp_call_function_single (kernel/smp.c:633 (discriminator 1)) 
[ 174.246978][ C1] Code: d0 7c 08 84 d2 0f 85 a8 00 00 00 8b 05 74 42 fd 0a 85 c0 0f 85 51 fe ff ff 0f 0b e9 4a fe ff ff 0f 1f 44 00 00 e9 60 ff ff ff <0f> 0b e9 4b fe ff ff 48 89 74 24 28 e8 ca 15 37 00 48 8b 74 24 28
All code
========
   0:	d0 7c 08 84          	sarb   -0x7c(%rax,%rcx,1)
   4:	d2 0f                	rorb   %cl,(%rdi)
   6:	85 a8 00 00 00 8b    	test   %ebp,-0x75000000(%rax)
   c:	05 74 42 fd 0a       	add    $0xafd4274,%eax
  11:	85 c0                	test   %eax,%eax
  13:	0f 85 51 fe ff ff    	jne    0xfffffffffffffe6a
  19:	0f 0b                	ud2
  1b:	e9 4a fe ff ff       	jmp    0xfffffffffffffe6a
  20:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  25:	e9 60 ff ff ff       	jmp    0xffffffffffffff8a
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 4b fe ff ff       	jmp    0xfffffffffffffe7c
  31:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
  36:	e8 ca 15 37 00       	call   0x371605
  3b:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 4b fe ff ff       	jmp    0xfffffffffffffe52
   7:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
   c:	e8 ca 15 37 00       	call   0x3715db
  11:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
[  174.248359][    C1] RSP: 0000:ffff8883ae709a60 EFLAGS: 00010006
[  174.252935][    C1] RAX: 0000000080000103 RBX: 1ffff11075ce1354 RCX: ffffffff814a8d90
[  174.253513][    C1] RDX: fffffbfff14b9c52 RSI: 0000000000000008 RDI: ffffffff8a5ce288
[  174.254094][    C1] RBP: ffff8883ae709b38 R08: 0000000000000000 R09: fffffbfff14b9c51
[  174.254670][    C1] R10: ffffffff8a5ce28f R11: ffff8881000406c8 R12: dffffc0000000000
[  174.255274][    C1] R13: 0000000000000001 R14: ffffffff814048b0 R15: 0000000000000000
[  174.255853][    C1] FS:  0000000000000000(0000) GS:ffff8883ae700000(0000) knlGS:0000000000000000
[  174.256669][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  174.257150][    C1] CR2: 0000000000000000 CR3: 0000000008af1000 CR4: 00000000000406b0
[  174.257727][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  174.258325][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  174.258921][    C1] Call Trace:
[  174.259177][    C1]  <IRQ>
[ 174.259399][ C1] ? __warn (kernel/panic.c:735) 
[ 174.259714][ C1] ? smp_call_function_single (kernel/smp.c:633 (discriminator 1)) 
[ 174.260143][ C1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 174.260504][ C1] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 174.260821][ C1] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 174.261168][ C1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 174.261532][ C1] ? check_slow_task (kernel/rcu/tree.c:1054) 
[ 174.261903][ C1] ? smp_call_function_single (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/cpumask.h:562 include/linux/cpumask.h:1105 kernel/smp.c:624) 
[ 174.262319][ C1] ? smp_call_function_single (kernel/smp.c:633 (discriminator 1)) 
[ 174.262736][ C1] ? reacquire_held_locks (kernel/locking/lockdep.c:5410) 
[ 174.263131][ C1] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:101 kernel/locking/spinlock_debug.c:141) 
[ 174.263508][ C1] ? generic_exec_single (kernel/smp.c:604) 
[ 174.263897][ C1] ? trace_rcu_nocb_wake (arch/x86/include/asm/bitops.h:227 (discriminator 41) arch/x86/include/asm/bitops.h:239 (discriminator 41) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 41) include/linux/cpumask.h:562 (discriminator 41) include/linux/cpumask.h:1105 (discriminator 41) include/trace/events/rcu.h:284 (discriminator 41)) 
[ 174.264285][ C1] swake_up_one_online (arch/x86/include/asm/preempt.h:94 kernel/rcu/tree.c:1078) 
[ 174.264662][ C1] __call_rcu_nocb_wake (kernel/rcu/tree_nocb.h:564) 
[ 174.265048][ C1] ? rcu_advance_cbs_nowake (kernel/rcu/tree_nocb.h:532) 
[ 174.265460][ C1] ? rcu_segcblist_enqueue (arch/x86/include/asm/atomic64_64.h:25 include/linux/atomic/atomic-arch-fallback.h:2672 include/linux/atomic/atomic-long.h:121 include/linux/atomic/atomic-instrumented.h:3261 kernel/rcu/rcu_segcblist.c:214 kernel/rcu/rcu_segcblist.c:231 kernel/rcu/rcu_segcblist.c:332) 
[ 174.265860][ C1] ? rcu_torture_reader_do_mbchk (kernel/rcu/rcutorture.c:1726) rcutorture
[ 174.266394][ C1] __call_rcu_common (kernel/rcu/tree_nocb.h:606 kernel/rcu/tree.c:3094) 
[ 174.266770][ C1] ? dyntick_save_progress_counter (kernel/rcu/tree.c:3051) 
[ 174.267225][ C1] ? kasan_addr_to_slab (arch/x86/include/asm/page_64.h:26 include/linux/mm.h:1283 mm/kasan/../slab.h:206 mm/kasan/common.c:38) 
[ 174.267599][ C1] ? __kasan_kmalloc (mm/kasan/common.c:370 mm/kasan/common.c:387) 
[ 174.267953][ C1] ? rcu_torture_one_read (kernel/rcu/rcutorture.c:2073) rcutorture
[ 174.268444][ C1] call_timer_fn (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:261 include/linux/jump_label.h:273 include/trace/events/timer.h:127 kernel/time/timer.c:1793) 
[ 174.268789][ C1] ? try_to_del_timer_sync (kernel/time/timer.c:1769) 
[ 174.269190][ C1] __run_timers (kernel/time/timer.c:1844 kernel/time/timer.c:2417) 
[ 174.269522][ C1] ? rcu_torture_one_read (kernel/rcu/rcutorture.c:2073) rcutorture
[ 174.270000][ C1] ? call_timer_fn (kernel/time/timer.c:2388) 
[ 174.270347][ C1] ? run_timer_softirq (kernel/time/timer.c:2428 kernel/time/timer.c:2437 kernel/time/timer.c:2445) 
[ 174.270711][ C1] ? lock_sync (kernel/locking/lockdep.c:5727) 
[ 174.271046][ C1] ? spin_bug (kernel/locking/spinlock_debug.c:114) 
[ 174.271366][ C1] run_timer_softirq (kernel/time/timer.c:2429 kernel/time/timer.c:2437 kernel/time/timer.c:2445) 
[ 174.271720][ C1] ? __run_timers (kernel/time/timer.c:2444) 
[ 174.272072][ C1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4291 kernel/locking/lockdep.c:4358) 
[ 174.272515][ C1] handle_softirqs (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:261 include/linux/jump_label.h:273 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 174.272752][ C1] ? _local_bh_enable (kernel/softirq.c:512) 
[ 174.272985][ C1] ? tick_handle_periodic (kernel/time/tick-common.c:132) 
[ 174.273234][ C1] irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:627 kernel/softirq.c:649) 
[ 174.273442][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043) 
[  174.273709][    C1]  </IRQ>
[  174.273847][    C1]  <TASK>
[ 174.273984][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 174.274260][ C1] RIP: 0010:multi_cpu_stop (kernel/stop_machine.c:259) 
[ 174.274513][ C1] Code: 8b 44 24 0c 41 89 47 20 e8 67 a2 f3 ff 83 fb 04 0f 85 0f ff ff ff 48 8b 5c 24 20 80 e7 02 74 06 e8 df 8c 09 00 fb 8b 44 24 14 <48> 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c0 88 e2 5c 8a
All code
========
   0:	8b 44 24 0c          	mov    0xc(%rsp),%eax
   4:	41 89 47 20          	mov    %eax,0x20(%r15)
   8:	e8 67 a2 f3 ff       	call   0xfffffffffff3a274
   d:	83 fb 04             	cmp    $0x4,%ebx
  10:	0f 85 0f ff ff ff    	jne    0xffffffffffffff25
  16:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  1b:	80 e7 02             	and    $0x2,%bh
  1e:	74 06                	je     0x26
  20:	e8 df 8c 09 00       	call   0x98d04
  25:	fb                   	sti
  26:	8b 44 24 14          	mov    0x14(%rsp),%eax
  2a:*	48 83 c4 30          	add    $0x30,%rsp		<-- trapping instruction
  2e:	5b                   	pop    %rbx
  2f:	5d                   	pop    %rbp
  30:	41 5c                	pop    %r12
  32:	41 5d                	pop    %r13
  34:	41 5e                	pop    %r14
  36:	41 5f                	pop    %r15
  38:	c3                   	ret
  39:	48 c7 c0 88 e2 5c 8a 	mov    $0xffffffff8a5ce288,%rax

Code starting with the faulting instruction
===========================================
   0:	48 83 c4 30          	add    $0x30,%rsp
   4:	5b                   	pop    %rbx
   5:	5d                   	pop    %rbp
   6:	41 5c                	pop    %r12
   8:	41 5d                	pop    %r13
   a:	41 5e                	pop    %r14
   c:	41 5f                	pop    %r15
   e:	c3                   	ret
   f:	48 c7 c0 88 e2 5c 8a 	mov    $0xffffffff8a5ce288,%rax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240923/202409231644.4c55582d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


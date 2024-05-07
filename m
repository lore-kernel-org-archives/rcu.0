Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E1152196
	for <rcu@vger.kernel.org>; Tue,  7 May 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092062; cv=fail; b=LXO6HHwLJszDAR179zFjG+iuUvYDR+y7jkLppGxdgDQKO1zFX5GFz29/Omy6wXKoR1Cv6Jr7yLlihXnykfG4rIcDlF/9RwVtog1kbgYHAIAX43g6mPuvedxFHw2R3O0rtpWwuUgwv7WBMxTYkuKph7PwXReOebpw7nBHUJAAGZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092062; c=relaxed/simple;
	bh=mPTQJ8WQ8Vyj8tJZYkXVx+fjW1G7raEn3tbLv05vjNE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=X9rn2lMN8rFIggKdDnEAqNksJKuZbcw8WXMxk5PCfKckV6lrowK2hyfQbjct9Edn0JMNj7e/iX+k5ley4C2GjebMHcQpxober464d38PxnTsC1wyRjBf+YqF7Nmrs6R7EfeACPbFspd77vMq4KuAoxLTMvwNqHYhMWw69SL9bgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc2+tt11; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc2+tt11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715092060; x=1746628060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mPTQJ8WQ8Vyj8tJZYkXVx+fjW1G7raEn3tbLv05vjNE=;
  b=bc2+tt11BZuY5DVcPXTIpVqe19J0Ve7SNJ9FVSrO5qazTwdgUeVSINdz
   2+dUEUMeKfkCam1gnDXhkUaOYqN+wQYJ1uCQ5s0jPpfmJm98EWMl6JGzU
   9WhYvuod5WrtPR/YMjbkwYIz82caMkekEMrDfGQ++p9P+snXvhA1jp7W4
   WRkxI+4PuiMLhnfv6a+W6AT2wUJ39flTnlXKVDMA6N7XV8edFkv1OsvLK
   iz8gyXwmAf8iFz/TO+peGLAx7aFZtPzfbWU6EJwBDEvXfipxrFexmuxGZ
   EfNRdWM73lXC5E6CfcA2qNjExrKowZusqVXHaGNBVhZzPYvWgKmeDODJ0
   w==;
X-CSE-ConnectionGUID: efOBoMFQS2ylxiE+7+RTQg==
X-CSE-MsgGUID: nSEPdeXQTpWUPOyvZD3+mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14697268"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="14697268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:27:36 -0700
X-CSE-ConnectionGUID: zKpCXYkFQh2+frlI3lgWkg==
X-CSE-MsgGUID: LEW6V72cSXOhcNpgeZyM/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28624120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 07:27:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 07:27:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 07:27:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 07:27:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 07:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoZI7i/60kttDOlj66wds0nqNausDv0W7s8dIEH8/iFJrJqZIzPWVCihxEBlbIG5GsGZCBKqnAgqClyzidVIdSUD4TunH33NLxgpHmK38zEc/KDBN1zqBeiTl8biQTrrDxkEChqiGJWdvgBu0LvqgKMtoED/Ze6PAdrOSmcVF4tQfmFGwSZIQKI3RD8Py0Pa9MKLHi6PxcMoXu66Unl0GuwJ3jT+ElHV2bs2W0vNfJFX4ZLXlvMdPhQ/am5NbVQjrKExOSQ/wOuYWsbzmJda/vvcyj3FB8jqchzub8Eg8tHVr0TIjNkUd+OocdjYYMw3kW7dKAUt0YOTLMckP4YB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qyXpGnfzeQGIwkU5X9cBSWlFyrwWhx/kZok1gjuaGg=;
 b=nEFhxB2C0fjjJ2Y4wozTYZfPFSxw3+jJ8+2zWJ6Cb6a67yG6BoIXH/+LI/yxqQQ3Ebelr8E5/pk+0feihoi1cP+jm5xXrbJH75A+V5V2gmx3uuamWfwXxR7gwOpBDy1n21Rx4j6GK2FTesnxOAQKldak+6dV2UDdFetD+AspvbN7lGpssxIEoGHqwJiqWu2gW3Y+nRMGTfxVNo28Rld3yUg7KzNbAkOUXBf6d3sIT9FWRgyvpQyDmbsiaSPoaQlHsUxGJsReVL+46fFWjcXof5Y5ohf8+sn7triu5ad0tU1jBpEEmR0Yke/P8L28ONRSvE7b5G7zwOUW5OlRE+Wl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 14:27:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:27:29 +0000
Date: Tue, 7 May 2024 22:27:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rcu/nocb]  4c66bc7cac:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <202405072252.959dadc4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: OSAPR01CA0267.jpnprd01.prod.outlook.com
 (2603:1096:604:2b::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: e956e732-5255-4cf7-829d-08dc6ea1d31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LcPz4+Eb6+cILXpiST0XPiBcjogrzx5xv7k0mQK5FGduEla/2iaP1pMnLXEC?=
 =?us-ascii?Q?qRwLTPlYFVpSHNNsfhjdBu/7czgJRZWax4wWMhfsTdv2t0WljHGUV1F+lQBG?=
 =?us-ascii?Q?Lm7mK5u9APpmzKkfHz31fpnKB0MF8GUDfJXKggNe8l+RwXEoSTTQGkce0WG1?=
 =?us-ascii?Q?Qn28CvjWyKoRWbo5IejAaYW/9dWTb0pXQ+jfEOJIwktdXzZd0lkSVeu23+NU?=
 =?us-ascii?Q?uXrasSZMgQk48Ln8q0niC73888kRXciQFqVRB/qm6iWzdc49QBa8td7t9WgB?=
 =?us-ascii?Q?be+M6tfFuVxCcvyiDoE31b63RNZ9t66EU30EVMbYEkpcfHQVbglk3/r+WsxA?=
 =?us-ascii?Q?cCbe7ci4VnhI+5VRfTEZyHEhR3qnE6eP+7XP7pK/OWIOKr6lWqYx35vjAf9j?=
 =?us-ascii?Q?GGL06IL9meT8HN4TfFCYeYJVOcs5FpQCUA6QA/PH7b2k9BIbAP7JZKF/ChG0?=
 =?us-ascii?Q?GvDJ5Ynunsl6PcI5Ipi47wvJnc92CCVqCZ49zoqhMN8kKvBJm4zLRHPveG4I?=
 =?us-ascii?Q?ax+SFEFlf59CvfyemPItkrNSSpanrT5XinTDpcLmgN+0q6V/qnw8Y85362J3?=
 =?us-ascii?Q?nGCADsYjAlu8q3IqlU9M8FQJfkIXTljro98xewti6/tIgP6XLywYqrY6iVYF?=
 =?us-ascii?Q?t6mMqq/Q3SQYI0DrQWoZVOhaa3NXpBRyTFf5VzfXfs544j6o9/cu6gDyRzKL?=
 =?us-ascii?Q?qDqXdOOREcd4RJk/D2kjp1+I0/4RnoY4OuN2NcuX9rn54RuzRZ//zoFjdY5G?=
 =?us-ascii?Q?OJy9of6HiUZ0HoHz2hiTv4L4Yvvk81Uo13J2RcPDrgMfD/QtFZNVArG52eJO?=
 =?us-ascii?Q?I7B9oncYbA7bu4Mp/E/iqm6xmGlCo0t3Wp4QRlZLic7MOKzbeb3Woa+KATux?=
 =?us-ascii?Q?YWkaSR0n40Wq+ZbRtT36zrTdtMcpq5251AinOe5yiVeOXe2P73Aiz3oHz55x?=
 =?us-ascii?Q?suHdDdAuWt+hOZ8dwMuiTZl8kWduUYLNluLqboD+MW1jKGkv3cx2F7d12Fig?=
 =?us-ascii?Q?7FgtfgNhmxtXGN1/lswNsEx/v/HkqABeCS6FKsqFLfNzF37JBD4WuKMgh/ip?=
 =?us-ascii?Q?cB9CYzYcWKW2jY3t4nPmxOGVKiU05HLQq8+KqwJAOyiPtBscTwUyJSjay/mS?=
 =?us-ascii?Q?pv9eOoDgWUJ4B4ObkYmNXQ1HqcqMAlrOosZ0QLp4U10JbSncdryNAzyPzOsb?=
 =?us-ascii?Q?y3+n/VV1fBYrON+edG9YCuOw2PAKDg80kGu2PVGSFnX0Ug33fssfBJKQKwg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlM8Kot9v8TbBGQvMj4wOqHo7elJdhEY8QRm7my4yNLnoDsom54GC73pbx1H?=
 =?us-ascii?Q?xVUw2FtFfTRaz6FQ2Wmj87TJq2jLm0a5R/a2R8GyDrEd1lYA8EQSrG4y2qGD?=
 =?us-ascii?Q?8wsOCcVvkNZFE3yk9wWKcAPQC6QzjlwMm5klYjxmLB082a02tFidZIrswQMU?=
 =?us-ascii?Q?Hnwif4bQIYlSFjOq5ImXYuSVQ8wXCS94MgJyVhVXpwxjtuXnAPwq7vMQxf59?=
 =?us-ascii?Q?6tUVX2CNX3tJLXchQZhUvTiJzcELRPKqnFNRscOM5RhzutSEgH21apYu5PdM?=
 =?us-ascii?Q?+g3JOX2cbbA7Rb+Vd3deyT66vwAIWY1Vp9KKpV8EiTDjHOiogsVCwp3elz96?=
 =?us-ascii?Q?hZlNp13uSLHbcF+Rnp9FYRITXQQICSiaLmJdpAJXZCHv5isJbYaCBbwTDJeq?=
 =?us-ascii?Q?QQGqHgdpOfZvN2+Oa1Q5brMTCLNlvYfwkkVGy+AqMwvckpVOP5f/5jwYsaCz?=
 =?us-ascii?Q?iUAYrw4tatV/ZxqJ5oU1MK7Nb/OlH1N6OBW7fJ/uP7MhGiBs5s1nGp8dOe6r?=
 =?us-ascii?Q?XqtsH4cHiBS4C5cXBNtfndXhL5jyEwSLdehNN06jA4rNiqCmiJctRsvGkalR?=
 =?us-ascii?Q?xWVC51zteGmLtDWn2SlInyQDSRr5mePhTvVa7CXeaCZn7DTFdt9NKeg0gkHH?=
 =?us-ascii?Q?ULe0eRAKKddSNkzsvBISMXIC0FdXvUT36GE85tIUpb4ud5U/9dy02j+LHgdB?=
 =?us-ascii?Q?iumgP+IULHmaSVmB7PazccSTYlBvi1JvvMkCsVurgw+ka+/GTxCYolSUt2VG?=
 =?us-ascii?Q?R0ljiUerMqdINPU1i1gPY66jgviGV/2bpw/jvU5uhWlrnhwv9fbthqa9tkzc?=
 =?us-ascii?Q?I6DWQTXJnVTIAR8pxP2eNR4iyj5j9+OPA9mVwNvaEkOg/ULRSPWDOm+JADEd?=
 =?us-ascii?Q?DIJme1V6Ijxpp+YJMktPUdYLNaO0wicaQQUdulQ6iRvoZr0aX5HR6Xx9dC/w?=
 =?us-ascii?Q?qrcj1E6lZUl3a07ADsW13WT2J/KBdP3A8+sWb62DXNAlfFrHw2Ht3+XKplYE?=
 =?us-ascii?Q?lAGu1vJTm62taYk6RaP+nEjV9eYh2ES4V7ikMjaGeMewn8ArxDeWFJaYBrKp?=
 =?us-ascii?Q?kOVz0USPLf5zqWcXdCH22LQKKxH7ckZpVWtiT3+eAT1MjCCHrnKNn0b0YPKQ?=
 =?us-ascii?Q?EvvesVIp+lbAnxGFa7XGqOlOC7+nq+7XYR1KNBfW1tl03jEFLSb6spHghHoG?=
 =?us-ascii?Q?ojK8CpFbG1Y7gCtGpuz5e4yvF7Obr3AWHLk7pm5Pivn8E+DqtnocdchdkV18?=
 =?us-ascii?Q?lRtQYBmsmu874oaImKq8kPkq6f9E/yDibAlNJnBLCwBxHNhVIwasKSp3aD2p?=
 =?us-ascii?Q?E0Uj/YTlOdrpttmIwfL8g9lduv4eicYLlKkaJFC9/Le/LhdSGTPfr+2JPDP9?=
 =?us-ascii?Q?KnD1yDMzGuuACq6Q8KRwlnABAbJt50zFOGhMHu0sYAWDyr4pQimFnIVVPvRu?=
 =?us-ascii?Q?mJOvTZdJYzlIHYMyC1bn+4uLnGkvPJlIqBqazmlikr/9YhCDOKbQ/bCLQR+M?=
 =?us-ascii?Q?vfj+rLgFSbjmTu8gKmqfQzMZ3dynOp6xZtX+EcdfO33q8aG8k7eH4voiehBD?=
 =?us-ascii?Q?H3zV8M5Fev7HNvRe/rO/vpacfudhQlTm61c3O3MZFc+v+rd7EZFN057zVWj7?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e956e732-5255-4cf7-829d-08dc6ea1d31a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:27:29.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhTzXR04O9R/eXmpxF/qrrH4QPiLb689LY1UbeoODGvVI4B87rRENQlFQXs3LfqSEJPoP7AR3lBhkiQtJ7/dqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 4c66bc7cacc08e8abcf5049d2b90bfd800904336 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9221b2819b8a4196eecf5476d66201be60fbcf29]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | 6deb20902f | 4c66bc7cac |
+--------------------------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible                   | 0          | 12         |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405072252.959dadc4-lkp@intel.com


[    4.099901][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.101313][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.102493][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.104098][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.104398][   T18] Call Trace:
[    4.104398][   T18]  <TASK>
[ 4.104398][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.104398][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.104398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.104398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.104398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.104398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.104398][ T18] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 4.104398][ T18] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16)) 
[ 4.104398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.104398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.104398][ T18] kthread (kernel/kthread.c:388) 
[ 4.104398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.104398][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.104398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.104398][   T18]  </TASK>
[    4.106221][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.108547][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.109667][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.111064][   T18] Call Trace:
[    4.111064][   T18]  <TASK>
[ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.111064][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.111064][ T18] kthread (kernel/kthread.c:388) 
[ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.111064][   T18]  </TASK>
[    4.132677][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    4.135331][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.137454][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.137849][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.139414][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.141064][   T18] Call Trace:
[    4.141064][   T18]  <TASK>
[ 4.141064][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.141064][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.141064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.141064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.141064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.141064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.141064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.141064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.141064][ T18] kthread (kernel/kthread.c:388) 
[ 4.141064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.141064][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.141064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.141064][   T18]  </TASK>
[    4.141391][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.143427][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.144497][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.146055][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.147731][   T18] Call Trace:
[    4.147731][   T18]  <TASK>
[ 4.147731][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.147731][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.147731][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.147731][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.147731][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.147731][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.147731][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.147731][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.147731][ T18] kthread (kernel/kthread.c:388) 
[ 4.147731][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.147731][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.147731][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.147731][   T18]  </TASK>
[    4.148538][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.150537][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.151144][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.152635][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.154398][   T18] Call Trace:
[    4.154398][   T18]  <TASK>
[ 4.154398][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.154398][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.154398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.154398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.154398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.154398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.154398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.154398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.154398][ T18] kthread (kernel/kthread.c:388) 
[ 4.154398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.154398][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.154398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.154398][   T18]  </TASK>
[    4.156100][    T1] smp: Bringing up secondary CPUs ...
[    4.159421][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.161134][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.162569][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.164398][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.164398][   T18] Call Trace:
[    4.164398][   T18]  <TASK>
[ 4.164398][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.164398][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.164398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.164398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.164398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.164398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.164398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.164398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.164398][ T18] kthread (kernel/kthread.c:388) 
[ 4.164398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.164398][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.164398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.164398][   T18]  </TASK>
[    4.168016][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.170139][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.171170][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.173242][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.174398][   T18] Call Trace:
[    4.174398][   T18]  <TASK>
[ 4.174398][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.174398][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.174398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.174398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.174398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.174398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.174398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.174398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.174398][ T18] kthread (kernel/kthread.c:388) 
[ 4.174398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.174398][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.174398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.174398][   T18]  </TASK>
[    4.189949][    T1] smpboot: x86: Booting SMP configuration:
[    4.191158][    T1] .... node  #0, CPUs:      #1
[    1.668906][    T0] masked ExtINT on CPU#1
[    4.202955][   T29] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/1/29
[ 4.204471][ T29] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.205845][   T29] CPU: 0 PID: 29 Comm: rcuop/1 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.207731][   T29] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.207731][   T29] Call Trace:
[    4.207731][   T29]  <TASK>
[ 4.207731][ T29] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.207731][ T29] dump_stack (lib/dump_stack.c:124) 
[ 4.207731][ T29] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.207731][ T29] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.207731][ T29] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.207731][ T29] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.207731][ T29] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 4.207731][ T29] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16)) 
[ 4.207731][ T29] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.207731][ T29] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.207731][ T29] kthread (kernel/kthread.c:388) 
[ 4.207731][ T29] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.207731][ T29] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.207731][ T29] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.207731][   T29]  </TASK>
[    4.207989][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.209997][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.211188][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.212898][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.214398][   T18] Call Trace:
[    4.214398][   T18]  <TASK>
[ 4.214398][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.214398][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.214398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.214398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.214398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.214398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.214398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.214398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.214398][ T18] kthread (kernel/kthread.c:388) 
[ 4.214398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.214398][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.214398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.214398][   T18]  </TASK>
[    4.215399][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.217064][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    4.217772][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[    4.219363][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.221064][   T18] Call Trace:
[    4.221064][   T18]  <TASK>
[ 4.221064][ T18] dump_stack_lvl (lib/dump_stack.c:116) 
[ 4.221064][ T18] dump_stack (lib/dump_stack.c:124) 
[ 4.221064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15)) 
[ 4.221064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 4.221064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1)) 
[ 4.221064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2)) 
[ 4.221064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1)) 
[ 4.221064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976) 
[ 4.221064][ T18] kthread (kernel/kthread.c:388) 
[ 4.221064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2)) 
[ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.221064][ T18] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 4.221064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[    4.221064][   T18]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240507/202405072252.959dadc4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


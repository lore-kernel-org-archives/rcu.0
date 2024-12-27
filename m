Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EE35977
	for <rcu@vger.kernel.org>; Fri, 27 Dec 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735280070; cv=fail; b=SLTkL+oSRMhMPxgLxt22cupXyyKBO1Opyn3vrHpHt2ELfR1D0v56Kg+NShBMxoXesc7/QvB/rORNOzh88ozYkLpOaCNqWUxMbQ1iCdQfZ9cv/UZ2Xry16w9ehD279W2sf/tIG8GnRSFm49Wxcc1nTuRTwhvzDGdNsWMnoTY+CqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735280070; c=relaxed/simple;
	bh=e11C+O47Agy3Zw2VjrbdxK8JdX6Q28DfmPS9HNU7pqs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TIOOM9gtLAVszY/s5n6HTmk8EQwS1l4PIC2vT0k/LCeTJ4mfBdNV7cwlxI6VRVDYV+Q6OaG68YOgxPN4+NctrbBNytp0DZlAzDwxfidVG9QPcKbwkKjuIMs290xK11b77nBnCHm/BiMN3pZQYM2DXkQq6THfKdPHSoRGwIEkMr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHexE3mg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHexE3mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735280068; x=1766816068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e11C+O47Agy3Zw2VjrbdxK8JdX6Q28DfmPS9HNU7pqs=;
  b=nHexE3mggVTR2CT0ncCwlEbTUGgqUBl+Xvp315JE4uSG8yVRzXmKiL/j
   OtuPH55msK9z8H3FuurQDkpqTuZAtSZnnRhzy9ubuP9Gv9QFDRIRqjLmh
   3dBTVtz614WtZTQbQ2LmrWmIdQ5MH2Gx3NgouuRZhlw+Zfifc3FZb5WXo
   0ffrfUQI4bK6UtmYYtNVx2g6NViY1R8rKAPiwYBZ8fLy3Fdenv7Ufvm41
   WYHP6T094kcIOQJaZudWhySLx43t5WYN6FLjtLt60UQzhPsUAEw84un6h
   QVpDfYfOkgpU2fZAscG/fcCDhN7bltu63z+MmiGiKPxbLXgMrP1csKY3l
   g==;
X-CSE-ConnectionGUID: XP3h9+aiQPCbA3Zx8IEk3w==
X-CSE-MsgGUID: T/lQ+kpOQrywBicZyAyZdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46684789"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46684789"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 22:14:28 -0800
X-CSE-ConnectionGUID: E6ftTk30Ql+lhW4D8zjyHQ==
X-CSE-MsgGUID: Q96rb0sTS2yXOu1V0hMJ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="100279099"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2024 22:14:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 26 Dec 2024 22:14:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 26 Dec 2024 22:14:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 26 Dec 2024 22:14:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO5dPxZnqy+uXysMyGgP2llp32iKxbC2a3bcf1tmIGhGvwKeqaOuUYmLkEBtv6HQISDHwPrpFUFXZIphKBwzuB2QIH6DaRPWZPCCCUFg/icd7XvnKEZjd9yLH30Anreu3kDv7LTIsD5ZN03h1ejtygN7aB6W0f4/egHvpZiiyMDRcZxRyIzB/QJNowX5Q1A+ZZTSql4X0lXt/LrxcipXAIRFyZ+t4G8SKC2cDmi/IGtGoEkPgJg3duDvNd6xt6ikWMYoy3k+yEvomTrIAOIUmyxzhgYN3SpRactEHQ3mEESqMoVVN1FglxMkfygFRkD0kjN20RvFL0uPLmN/hzpxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H62DZeDPEltHuqpyV+FRAz+61LQOsb5pWND9FcpTdM=;
 b=mtT78H32ULCfQTkDMcbPcs7V+DKLq0s0GQEPRkl9Jd0A/fjuXQisoFKRB4VY8lN8fvPOk4gj9E2fTcOG6Rl7xfIBG3LdtfcwNZPQ0xwrHApTHmLkx+SoexJUaMVIkc9aE4Gq4raVb6ivLIIG61wlwOpz83dPO3/MMTHkzMroFIYjiEp/ftnswkDtEbwE4KZBzXg6iJ6S+qejeOcLejJ+FIDFiIoiyYiZjp0tWNpqdSHiO7t2UB3gwiKd3wRBZHdLkzGEVjw2TVJT3zhX5G6tLGicoq9BbC8MbHkPHM3+DSCcjK8BIICXBcrI0VkX6ffJ6uanZh3UakO6XlpAj5eG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6668.namprd11.prod.outlook.com (2603:10b6:303:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 06:13:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 06:13:44 +0000
Date: Fri, 27 Dec 2024 14:13:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.12.23a] [srcu]  54bd8ce173:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202412271357.91770b27-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f777704-10bb-4208-3286-08dd263d9dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9mNriMoQCr+h6VyJRlsHpE4cq1iHe+39Jzvmzo1qc0Jm0m4kMfcsFc/Cmro7?=
 =?us-ascii?Q?jioSnBllzjz2iXMGVgSzmf9RD/UA5DyZbfFZ2i5+rsWprx8LoOjt7dkzC+EZ?=
 =?us-ascii?Q?EqVS0KE7NO1DVTqKV6oA1dJ8AWoyMQjUyCmZo9sA3/i4ATOyBFCxBt/6Fjri?=
 =?us-ascii?Q?7sOwPu4PTdLIYQXKCZUGExxo4rITbhTYI+Ly3Ep/vU4b8QpQ3OnRO0X35WiF?=
 =?us-ascii?Q?DIbyKqlzTpcyIavZU/h+UAhbAO/e1wVpc6Og+V1q2Vpu2i8onl4EpB8oPl1A?=
 =?us-ascii?Q?MYrMIC4Z+8PlpNldgCjROChyWdhjZtf+GAHK27NF4Mr0/XMkHrPHcNAEVmr2?=
 =?us-ascii?Q?YGHZ6/PBc3OtZ10SLFnkUzS+xE7/gJVckSf4xv3OsNMhYZClGeN/bc9vgs5H?=
 =?us-ascii?Q?h7TSubQxwSVOwbHM1YkaLXAJLEQRekICo8Ro0PEkkIl+EadAXEKy5HXD7lRS?=
 =?us-ascii?Q?UPWuwExLw+RmXdAwgse7FJPe29a03TM6ryGZXXJ+aV1QoCGWmnKwVLguK+Id?=
 =?us-ascii?Q?6pKiJ4dURPy4zWOtsBRselkb5aY0OyrKm6mI9v+P3IrBWW43SrY73n+s4hOw?=
 =?us-ascii?Q?6HQ0IetifcF3ZJUo+DkBxWecnzXSbMSiard7A/9Ymnmmo/GbSIzoqCRkJ8HU?=
 =?us-ascii?Q?AflWckY2ZwnybWpLL5jodnXe8Thw9bmj4psW7sY/94SrmvRILbzZYaylRgaU?=
 =?us-ascii?Q?pDzObBgqE/6Vlogq04BqaZI3MIh0Gf8Et3Jsag+DcVDuBTIJocJyK/sT8Mrx?=
 =?us-ascii?Q?/sZoo52SGROXAw38gJArpFmhFBZN1pqYRGBdIWIe5tl4dGd9U85ssX1cQQ4F?=
 =?us-ascii?Q?5iBn69DjYGZjpJ4rgZOhdFsRBMsSYGQqtnYMBEjH7XojLLjviIQ3PCm2HW0Y?=
 =?us-ascii?Q?Td9kZz4/IrMOfWjhHkizDsqYtvZCLjCPkMPz0BQVxPuukH015Nj5oa1BxNEd?=
 =?us-ascii?Q?csXdpEKuO6rVnD8iW3MnmJUZ/ORNUeMdraQ8LrOQmYFyqKv1rZOXZi2qHWq8?=
 =?us-ascii?Q?81f+IdK+H+ahTJ4y9VCct8l1sYLop6BeKpDxj3J9V7fQWWgKQcQfyGaRQ69b?=
 =?us-ascii?Q?BS+W9o1izcpVoRkmvuq7aq3aLYKTzVDJ26n6fHH++kUhNs6twH+uOO1EpeZk?=
 =?us-ascii?Q?P5o6z26heAM0lfwofAx7oU9Vi5l6fI8RiWPcXMYY3sVIAmlf0koSh8qevCw9?=
 =?us-ascii?Q?uRzQ5LhhqDPKFSyz6n5h7ravIr7PVuemRFyJR2wfsHmZTS9BEJrWp1fKkwxU?=
 =?us-ascii?Q?lefIr3pM4VUAaVJEyHAZoBptzPAusQxqDxEOsECPKPiCHtqQxlMXmjmI2orA?=
 =?us-ascii?Q?JEe7veuIh/QOEhtBjM+ADJvElWdz0+fLGzQZfVMhanYIOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nwd9hFHi0JF9fs7Pknb+3+u1JHA9o0kZMKgFWut5lEkvcG1ZhJDvLWCfLYOl?=
 =?us-ascii?Q?z++4UzOy4lqa2VCgBMLpjuk00dr3hT8W/8l/s+Vw+9lpc3jIQlj2QA+CRrob?=
 =?us-ascii?Q?zYYlLKFWvigxS/nILz2/gEHreOQKwvwVCkMnbLNo560cRvI0dHV39vwtZ8ct?=
 =?us-ascii?Q?qiQhrXMc/rrYJwn1jehfPW3VR0yBVZNi2Nlz82r+6gK5GhFTYWqPSo8gVRfW?=
 =?us-ascii?Q?bTSHVxd36JBMDyUs4tX4S+gSQK2Bk6NGoxQbI4//4FsYFTGhGZNt4jT/P6Ia?=
 =?us-ascii?Q?4MKstdsRTKPcZix8+M7q/7gmOL+2lZENE4ktTkpkTfaEZ5Oj+wNvF7Egrsvy?=
 =?us-ascii?Q?H27Fem+GQK3dVM33ET1qlhQnF6NCqch0n4VYGqSrm2xTJUq9XGVNu6Url9gu?=
 =?us-ascii?Q?NDEWM+Tlv+/05/3Yl8/1R5bFQt6TjeNOA029qC9YWxymWnVaAvz0Von74p6U?=
 =?us-ascii?Q?wzXQJPMI/dgP6tbASWj9YxF1lkL081QlkD7jLSh14be57+ZDpbHCMvrBm5q8?=
 =?us-ascii?Q?BVWzWyRJHUWn1zAObxKVgMkcwZyB279zh2VpPbdw+1GslZZjycqmaQQV73dV?=
 =?us-ascii?Q?Iw4i/XYdBtKdV6cFq4wzTjPuiYvs9Cg8aQvaEyOMAOf6ZL8PnA1qAn93rIMH?=
 =?us-ascii?Q?1vfx8fCcPX9Wg4iNDmpHj7w8fXvhUDpds/8awVQW+bt3iFTDJ8XL0KE5bgtD?=
 =?us-ascii?Q?MfF9frbgbZ2IZnrCnamPMbGNnsqa6wRhiTO5Fh5Up17qZt3o5r2dqgEJlUR5?=
 =?us-ascii?Q?+6yNixZkOBMAkSqGPRD+NtJUX7+lG6wN3+oNnOt+SUCzUQPiLaZgLugC4gB3?=
 =?us-ascii?Q?7fvztZ57XIs577OfjV89Uxyu6GytBgQccJN/U2uIhJzO9CAvOO65zDhOo6BI?=
 =?us-ascii?Q?R21yE0OpmkDbCTXvypgRu3lncTz4Y9RNai9EWm9UQNUXJOV9hYo2kPwObgPW?=
 =?us-ascii?Q?z190p6Iz72LZIprUyenShHBI9ltASPUueapOz7S+QapswFhR+dHz8Mp2R8UU?=
 =?us-ascii?Q?QvtTtc3mFFjzHpyKrq3ZcvBxo5tc1CaZZ1dVQdMZQ4OgirCArK3Iryhnj3Zb?=
 =?us-ascii?Q?v5N5ePMc5bg0Ax/kxFNK7rupxA9PWwYKVii+cnGWorRvKxQv2zxW0DePfK+d?=
 =?us-ascii?Q?LS49OweGagKpSGCz/VEjpBtGy4VCMzBqTlj8G+aH+wzX4MpWgTvKCER2M4ys?=
 =?us-ascii?Q?oZzt/RDKelVy7hlfFM3CjcUeFS4uR4tWXzaRSy4lek0tqIzv4+OPCwjRPNK7?=
 =?us-ascii?Q?efdWQ5wWcWtm6NKvVBT/fWI+HijWvrR7NuMS/1eSMN5cb5x6CuxuVBrBrBFY?=
 =?us-ascii?Q?tSdzepbKVCkgrc5DNhEuTJiLCGEc1x5oHYvxBvOe0Vpr6/9RM3g4fbMzqi4Q?=
 =?us-ascii?Q?edDTlHK4/8hJN5wpL0OUnyZ6eUZSpPSi/LtYJaUOyythrESBeDmFmqL+ExFl?=
 =?us-ascii?Q?O7iWsVAXV6vhIELjI+njOXjHXANLXsdDaqFEZHVyhUDgERILTkiBT8JrDFkl?=
 =?us-ascii?Q?/YJ72kbV1Pp93Jm4RqEWeOzWVZP0T6qyFwBNlrjabZcl/sq6jKetNNTvUH8j?=
 =?us-ascii?Q?h6PobvXkIDowJ2k0jhsZynFCx3Hcz71eG0zAH0FqIVHgS68/iirrifSonGJl?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f777704-10bb-4208-3286-08dd263d9dc4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 06:13:43.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW3Z8H0kVeUMhE/3pA/NbzskyJOOqB+ko0Hva3vsYJ9VegemuI6LC3UB5xKiMWWk4iIV4US92ovSC951tXSfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6668
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 54bd8ce1737414436322ddcda7634ad0a6f499a1 ("srcu: Make SRCU readers use ->srcu_ctrs for counter selection")
https://github.com/paulmckrcu/linux dev.2024.12.23a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcu



config: i386-randconfig-014-20241227
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 75e0a2b0b3 | 54bd8ce173 |
+---------------------------------------------+------------+------------+
| boot_successes                              | 12         | 0          |
| boot_failures                               | 0          | 12         |
| BUG:unable_to_handle_page_fault_for_address | 0          | 12         |
| Oops                                        | 0          | 12         |
| EIP:__srcu_read_lock                        | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 12         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412271357.91770b27-lkp@intel.com


[  155.064720][  T856] BUG: unable to handle page fault for address: 243f1000
[  155.065336][  T856] #PF: supervisor write access in kernel mode
[  155.066547][  T856] #PF: error_code(0x0002) - not-present page
[  155.067393][  T856] *pde = 00000000
[  155.068187][  T856] Oops: Oops: 0002 [#1] PREEMPT SMP
[  155.069080][  T856] CPU: 1 UID: 0 PID: 856 Comm: rcu_torture_rea Not tainted 6.13.0-rc1-00069-g54bd8ce17374 #1
[ 155.071249][ T856] EIP: __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 155.072290][ T856] Code: d7 b1 00 85 f6 74 0c e8 48 5f 00 00 83 3b 00 74 02 0f 0b 58 5b 5e 5d c3 8b 00 f0 83 44 24 fc 00 83 c0 07 83 e0 fc c3 8b 50 04 <64> ff 02 f0 83 44 24 fc 00 2b 50 08 89 d0 c1 f8 03 c3 55 89 e5 56
All code
========
   0:	d7                   	xlat   %ds:(%rbx)
   1:	b1 00                	mov    $0x0,%cl
   3:	85 f6                	test   %esi,%esi
   5:	74 0c                	je     0x13
   7:	e8 48 5f 00 00       	call   0x5f54
   c:	83 3b 00             	cmpl   $0x0,(%rbx)
   f:	74 02                	je     0x13
  11:	0f 0b                	ud2
  13:	58                   	pop    %rax
  14:	5b                   	pop    %rbx
  15:	5e                   	pop    %rsi
  16:	5d                   	pop    %rbp
  17:	c3                   	ret
  18:	8b 00                	mov    (%rax),%eax
  1a:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  20:	83 c0 07             	add    $0x7,%eax
  23:	83 e0 fc             	and    $0xfffffffc,%eax
  26:	c3                   	ret
  27:	8b 50 04             	mov    0x4(%rax),%edx
  2a:*	64 ff 02             	incl   %fs:(%rdx)		<-- trapping instruction
  2d:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  33:	2b 50 08             	sub    0x8(%rax),%edx
  36:	89 d0                	mov    %edx,%eax
  38:	c1 f8 03             	sar    $0x3,%eax
  3b:	c3                   	ret
  3c:	55                   	push   %rbp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	64 ff 02             	incl   %fs:(%rdx)
   3:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
   9:	2b 50 08             	sub    0x8(%rax),%edx
   c:	89 d0                	mov    %edx,%eax
   e:	c1 f8 03             	sar    $0x3,%eax
  11:	c3                   	ret
  12:	55                   	push   %rbp
  13:	89 e5                	mov    %esp,%ebp
  15:	56                   	push   %rsi
[  155.076009][  T856] EAX: eec8a380 EBX: eec8a380 ECX: e707e540 EDX: 00000000
[  155.077234][  T856] ESI: 00000000 EDI: 00000020 EBP: edf09c9c ESP: edf09c90
[  155.078468][  T856] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[  155.079782][  T856] CR0: 80050033 CR2: 243f1000 CR3: 067be000 CR4: 00040690
[  155.080734][  T856] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  155.081570][  T856] DR6: fffe0ff0 DR7: 00000400
[  155.082104][  T856] Call Trace:
[ 155.082536][ T856] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465)
[ 155.083000][ T856] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[ 155.083618][ T856] ? __die (arch/x86/kernel/dumpstack.c:435)
[ 155.084048][ T856] ? page_fault_oops (arch/x86/mm/fault.c:712)
[ 155.084673][ T856] ? kernelmode_fixup_or_oops+0x46/0x4e
[ 155.085443][ T856] ? __bad_area_nosemaphore+0x2b/0x1c9
[ 155.086263][ T856] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
[ 155.086840][ T856] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discriminator 1))
[ 155.087467][ T856] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 57))
[ 155.087967][ T856] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 155.088600][ T856] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 155.089309][ T856] ? handle_exception (arch/x86/entry/entry_32.S:1055)
[ 155.089950][ T856] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 155.090754][ T856] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 155.091358][ T856] ? rcu_torture_writer_state_getname (kernel/rcu/rcutorture.c:287) rcutorture
[ 155.092202][ T856] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 155.092910][ T856] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 155.093526][ T856] ? srcu_read_lock (include/linux/srcu.h:165 include/linux/srcu.h:257) rcutorture
[ 155.094198][ T856] srcu_torture_read_lock (kernel/rcu/rcutorture.c:693) rcutorture
[ 155.103773][ T856] rcutorture_one_extend+0x14c/0x38f rcutorture
[ 155.104728][ T856] rcu_torture_one_read (kernel/rcu/rcutorture.c:2163 (discriminator 3)) rcutorture
[ 155.105530][ T856] ? validate_chain (kernel/locking/lockdep.c:3819 kernel/locking/lockdep.c:3872)
[ 155.106112][ T856] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:269)
[ 155.106743][ T856] rcu_torture_reader (kernel/rcu/rcutorture.c:2286) rcutorture
[ 155.107520][ T856] ? rcu_torture_one_read (kernel/rcu/rcutorture.c:2248) rcutorture
[ 155.108331][ T856] kthread (kernel/kthread.c:391)
[ 155.108818][ T856] ? rcu_torture_read_exit_child (kernel/rcu/rcutorture.c:2269) rcutorture
[ 155.109677][ T856] ? list_del_init (include/linux/posix-timers.h:225)
[ 155.110238][ T856] ret_from_fork (arch/x86/kernel/process.c:153)
[ 155.110778][ T856] ? list_del_init (include/linux/posix-timers.h:225)
[ 155.111328][ T856] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[ 155.111766][ T856] entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[  155.115711][  T856] Modules linked in: rcutorture(+) torture
[  155.117176][  T856] CR2: 00000000243f1000
[  155.118089][  T856] ---[ end trace 0000000000000000 ]---
[ 155.119343][ T856] EIP: __srcu_read_lock (kernel/rcu/srcutree.c:749)
[ 155.120400][ T856] Code: d7 b1 00 85 f6 74 0c e8 48 5f 00 00 83 3b 00 74 02 0f 0b 58 5b 5e 5d c3 8b 00 f0 83 44 24 fc 00 83 c0 07 83 e0 fc c3 8b 50 04 <64> ff 02 f0 83 44 24 fc 00 2b 50 08 89 d0 c1 f8 03 c3 55 89 e5 56
All code
========
   0:	d7                   	xlat   %ds:(%rbx)
   1:	b1 00                	mov    $0x0,%cl
   3:	85 f6                	test   %esi,%esi
   5:	74 0c                	je     0x13
   7:	e8 48 5f 00 00       	call   0x5f54
   c:	83 3b 00             	cmpl   $0x0,(%rbx)
   f:	74 02                	je     0x13
  11:	0f 0b                	ud2
  13:	58                   	pop    %rax
  14:	5b                   	pop    %rbx
  15:	5e                   	pop    %rsi
  16:	5d                   	pop    %rbp
  17:	c3                   	ret
  18:	8b 00                	mov    (%rax),%eax
  1a:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  20:	83 c0 07             	add    $0x7,%eax
  23:	83 e0 fc             	and    $0xfffffffc,%eax
  26:	c3                   	ret
  27:	8b 50 04             	mov    0x4(%rax),%edx
  2a:*	64 ff 02             	incl   %fs:(%rdx)		<-- trapping instruction
  2d:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
  33:	2b 50 08             	sub    0x8(%rax),%edx
  36:	89 d0                	mov    %edx,%eax
  38:	c1 f8 03             	sar    $0x3,%eax
  3b:	c3                   	ret
  3c:	55                   	push   %rbp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	64 ff 02             	incl   %fs:(%rdx)
   3:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
   9:	2b 50 08             	sub    0x8(%rax),%edx
   c:	89 d0                	mov    %edx,%eax
   e:	c1 f8 03             	sar    $0x3,%eax
  11:	c3                   	ret
  12:	55                   	push   %rbp
  13:	89 e5                	mov    %esp,%ebp
  15:	56                   	push   %rsi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241227/202412271357.91770b27-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


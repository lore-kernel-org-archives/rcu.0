Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC82D2488
	for <rcu@vger.kernel.org>; Thu,  6 Aug 2026 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999593; cv=fail; b=n2snTfY4Gmss/vQZ7YIuwKQOupcwUo2xwlUoNv/Q2DGFBPBCARPLRxppSd2HVh6xYVMNYL9r0aMmy1kBzMqkzNu0qudQWEZxa3fo3RLXBjK371PHMfnP1yDPE1leDuXUiobFNcC6TIvp3iQZgvtd2FmH7aLz2N7Z2LXsl/9dqcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999593; c=relaxed/simple;
	bh=e1jgWTRqstwacoNlDLGHFwPns4FYFFfoyVVWbyniTOk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FrScCYfE1u4rbTu8QslOoni0V/NfFkaVHB3nDNhxZ1X1S3DlCwsm1ms61xHf7Uc93kWl+3WXQhs+KMJRTP+H5UA7Ex/yQFz33apLVrQg11EngoWvg/u9SUczS7/bfi2wWvW2SfZ2tWmvhFDRKcgo6OjJjtu+fXp8YPUKu/xerHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV2Vterf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV2Vterf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785999592; x=1817535592;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=e1jgWTRqstwacoNlDLGHFwPns4FYFFfoyVVWbyniTOk=;
  b=TV2Vterf9AtZBBJ/f1CoKdnu9yr+NMjq+4JTJcWAXLuHnvtVlPMIgVqe
   ikuUEpcseVfRZVOtREDZBDuSC7vixhOkbTNFREW5FLcO3WFnmeW3SobNN
   UZgiZbqMeuATejuJZPu/DSwxUyJXpIn/NJhtI0B5IQd+mnNnX3VCdljvH
   +eYnPmQ6KB+XIaNzKpxBueb66bW0BKCa6cfUTWwpvsryiEEKtDRcJKKfG
   QHa1Yf2C8Xy/33NYcYLaayeRzdx+01cXUYBxcs/lx8gIxeLrcqyklwBTk
   Gy2T0VxUD2SliYwx7BaPxcVShq9KxDCbEEDfa8xMgi1rvqKP4DOOAobFV
   g==;
X-CSE-ConnectionGUID: yDLM8QyrRRmFLQn/OSbYcw==
X-CSE-MsgGUID: EolHY5Y9RvmF25bYzhx2PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86660106"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86660106"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:59:51 -0700
X-CSE-ConnectionGUID: 0M8xZxFeQKef47krx8fTuw==
X-CSE-MsgGUID: jgoedGqtSjKMorC4th+eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="262102669"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:59:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 23:59:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 23:59:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 23:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWpWwyXEa7ZGdvFbDA9MgBYgEMWMNvuwfaGUU5SLsf+Rtg4DD30WONKIyFQWRzQO8YH4Zg94hNi8E2V3sxzBTA7JRaISrFHx8U1G5MIx1q06XzvHh1bhLXAo5D1xFfU1cbVQVLWnc2es8NWO/ycHcirHTlcwnjOhzdlUMD2KI4Cvx+PV8gXlcsZdTv7YffXtFSaLs2KBycPkxfT53NNhewVZ3Whd+Ihjdyo3e3F3F7yO0bn1neR24+spEC3WwetFW+bGq6Qjfjvx1eproxrPkTIEVo5iRqaFo8wS3QH6TgSVCsjGxjsezxTidVhtVbSvNgabBhFBIxlsFsGc/fZhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMqHgrwAItDOHVH4Zt5EGwQJhtALOZg8FaSbW6fmn1I=;
 b=tfMgzGTH4vTdA8p2qJMFeE4SHJNr+rvPVi0jkoY3Xpbm366nfkgiiVu2ah3kF4JqGmWkarTpcvA47ofCFSTkK0aXn9+Yjf+kxqYwtbZqcLuD07HbGVa4i5ZZ4PxL3Wm/I4KWsHrptjsI3v5/a4o9Xn83HeRge/XeydebxkaGwo3VubDFpYruNSM/BdHAoTqvJchqRhXTxtRY4xYGyCORPlenJk6xxAFU7VVdzSsCZEdJ72dRzd1w66FeHO4L1PZFJBZAgJWgTN65UMPOSjM1ZFXab85y9bblRQ2mGdoqwUmAUzY1SAINrjQPX98EGsd2mwOvR8FvLSxjctYw9wjybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:59:41 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:59:41 +0000
Date: Thu, 6 Aug 2026 14:59:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [srcu]  05c3e88488: RIP:cleanup_srcu_struct
Message-ID: <202608060833.bce92909-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU2P306CA0052.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7408d2f9-94e2-4d26-50db-08def38849bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: S68x/ruMDEsxLLRZazDLLw7k7liYPccaBhmTJx6RVF+n/p4y8eOp9S/YkQlL1hoNWL3S58NqIp0mAdn02dZeFneCkRdEhOAYFpkM5ae7/gWzpLaHGHJ9W5wKwVlx5l1zAGMUhgSAoMv9C0dt8l7yfUkta5c0mqXFiWOl4N/B3Dy4pOYCkgCj4oZ9grKKoes+sGw+NZAxZMZ3mN/XvaI9Sc0JiJDdZQYT9bh6YhTi0Up6xFY834BHMXxNt/UuhZLAki1VhMjhVR5lnSKbKO3Uw57FgkzoikuUtmlKNQ5u3lhmgvdtBo1l1fAFSbYrCYuIDb1NZqAxM5xiW8NDVE/IfjqXHcy/89koG9RpzQfjeX67uqMWlXnd5C9zYIZzYBN2CgTiSj7V9e/NDCsBiUluXQuk8xFmCZWD3jeUGp7RgcBRGFTZaJNdrCUm0GiqB4ob7Mnignn066LvE2rO++pvORgZgC/HOr4iyXA+Q5dM/lAdm0e47lVuFuA8j9YKdyOzeG3cgxSEuQ9KkpW5H3wDDXBIOoSDVg9lz3tSuX56M23sHC34D3NtXyZLwypMiYHDOBpHTOPPYRjQfGtNQijndB3XF9KVfmggkkGT2DQ6HHjXwueQif9NWn/zqCYBo2NPIdiRCrF3x5ymxArPqaTr6az0vGwQKg04mik5jEB9DAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SStIzofxTQ7sayha3M74Juu0f+UtqtyRfJSTxpKFo1B8BDxYLalnU758Bj9h?=
 =?us-ascii?Q?ci9PLMViEUsmdAg0fuU5U1+WDGxEV1aKSttF+j6dXXlI885x77nCpOCGL1Px?=
 =?us-ascii?Q?y30+C7Dps7PrD0bhpPAWFQWkGRw5oGK8QKYoh5b3UDAk/rO9f7Rj7Odok1es?=
 =?us-ascii?Q?LT0WE/NWpKZLcElCNElulme8kY0iqzekgR27YlhMwmz7sD6CftWecnEf/eoB?=
 =?us-ascii?Q?NDM89+u0iXj8PlsHtvjyRyqD3FtNWW4KxJR8zYJJc6cJWySNETmboy6mL6WP?=
 =?us-ascii?Q?Re9A2maC0ijsGYV5IyA477Z2RzobM4F/q5QvEG78f9PXmo5ER0ai0v3AiFrw?=
 =?us-ascii?Q?bp+MQpuL/qAcaAkqq97AM52blKz+k+GQ5AVNtVirATLT1rVlD+9YcloLhye2?=
 =?us-ascii?Q?X9XjY+xQYDUaklaTDAKxbmdRT6OyEvRnTlPq59XKr49KqYQr8pEHGPpIE/uN?=
 =?us-ascii?Q?90KpfuuL2Bg5OuwbHVubx+Y0wZWdck1rJIPC1oQGqioCPElbchB75TPmZO87?=
 =?us-ascii?Q?9N77tZT0iAfXfAwI87l6PLhWyVCCiqTSDhPwatHF6JhrlIcDO9ns1ZUwBmBt?=
 =?us-ascii?Q?YQGQT0BqYQ1SYrr0nyNsySvIL2oxwK0+zX7GFWaIsrEeXepRhhSlQohUsE5L?=
 =?us-ascii?Q?4diVJmOfA+ZLujORZAwtwgVkZnd8vvX/LRK8y73UIl05v/RPk+A1U1VSj6TM?=
 =?us-ascii?Q?lXL8X7WJXVxbZ7ITmN3vyvnCnOG9b4pibuimnhurPZSdOgW7IE7XqUR81mIW?=
 =?us-ascii?Q?ND2tqhik3xifhnGwSLk0xF3WP6/ZyZ8T9f/scpeTNk7EB++HlvtYzQ6A7ztr?=
 =?us-ascii?Q?QHaUNUQN0eRIqJDBgdT1R6FL0vKVT8Wu7TPimVKXKg0rx7kU0Magl+E5OLcO?=
 =?us-ascii?Q?4yASv0/Mto/QeKtBCOngdQxaMZFt48SZ1+Fyt86lFPuiOH+sjk7abSLDBLYq?=
 =?us-ascii?Q?9TCQfRLqiF6KjVL2nDpMmGkJrXyDYJKk/RE1V833NoPHqTpDYQcMPZLfhVXJ?=
 =?us-ascii?Q?fIANTfVHr4oFnXXUOWFI0XFQSmCd31rDYrL1gBgd3ejg/b04Y2uYc7jdG+vb?=
 =?us-ascii?Q?7PXCuho8vmYaIYSZ10MePT7Ug0P4Hy+PSbatv5ExG8qtbHmN+YcLIUS3cUL9?=
 =?us-ascii?Q?/5LBqHnsKzfxrW4MJKctxiFI15+OyT+DGAbC8RK0q35rOxA3K26WpSveSHSs?=
 =?us-ascii?Q?GWeW5KTK892AeJT5XML55wlsZlcKfPY05cXc6kQVwT7nxLqjpxN+dxmwf70u?=
 =?us-ascii?Q?Q5dttRE1XrdX9eKYwemW03ZivkPAPFWUhVFhkgDvdi71UQ8lr0E7EmdEZ4If?=
 =?us-ascii?Q?Qj8VEE6kW8SZ/0JU9KiSWie5fSvqCptB7UlElK2E5g6LHN4pHo1dvH0ITHJK?=
 =?us-ascii?Q?rMpwHYZAT21mAjP91RrusEHSuE6/uugQaQN6uFf+DGfC6VC4/FqqJAUaBjxo?=
 =?us-ascii?Q?piRCUTI6pZqqAlUEVtOvEVbMAUFUrhS29U/Yn/CwRktKehXSiFu1PTRFVa8V?=
 =?us-ascii?Q?1yBXUsfHXf8tsDXQSVtuO6dDLWOZLeewBFHCUk0v+6s/HXhd7l74Yf++wMCY?=
 =?us-ascii?Q?Q/hcPsWM3G3Wme8kwDgOOrbux28Pv1ia7ocpU6C8rofXmn2dwxV4szDSwFZy?=
 =?us-ascii?Q?FScNER5l8FlChOOT9mOJErbbfoFXDsU+orRH7KXxzpoNYXbLCDKdWgFgvQOz?=
 =?us-ascii?Q?dmLly/NJH1WqLle7vMH+OksmC02MVPdJVtgSUtOMKDsbbCXtrYsVmd9xzRnh?=
 =?us-ascii?Q?8BEKbaRu+A=3D=3D?=
X-Exchange-RoutingPolicyChecked: kKHoI8i7cpgiKcj5urarm5+tL5u1NzxxXivp3XLBBvYTJEz772sL6g/8AZwZBngD+qNRBYPp8JfShDOCkTaiabGLgNNbrYo5CFBlIsj6CzU3NWtpaf3Qa0SLRFpMPem5vY5vOqPSTgvInxxXhIJtnL8yUK2BMsQpEo0mY9n3p215XJFLnDocT2LH3R+3Ra5CCsx1XScfK9jtTSU6TT7ZRWRGZHOl/YjvbGbxAKP15JmPENzFUFYbDIWc6xAMPLlE6frZhh90EIj8inLWeDPdIVzubmGfKfaU6EstwYpL+Q9KlOf3BKcMSgBI1nudwHRPZdVEccu7XzFyJnhUA+ROsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7408d2f9-94e2-4d26-50db-08def38849bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:59:41.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4x/fSCordYygXdrxJDrCk5bbB54irsUeoIUbzet2SFKgW0KnV9GbIuDNzNA4RpbKaTcl/zMpTPRvjKgsFGauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:cleanup_srcu_struct" on:

commit: 05c3e88488ed8c12129ca04db84e4c02a16d7ee9 ("srcu: Queue sdp->work wh=
en the delay timer is successfully deleted")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: blktests
version: blktests-x86_64-6f5a1dc-1_20260728
with following parameters:

	disk: 1SSD
	test: nvme-group-01
	nvme_trtype: rdma
	use_siw: true



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G=
 memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.co=
m



kern  :info  : [   42.171416] [   T3271] nvme nvme1: Removing ctrl: NQN "bl=
ktests-subsystem-1"
kern  :info  : [   42.220396] [   T3271] ------------[ cut here ]----------=
--
kern  :warn  : [   42.221853] [   T3271] WARNING: kernel/rcu/srcutree.c:706=
 at cleanup_srcu_struct+0x373/0xa70, CPU#10: nvme/3271
kern  :warn  : [   42.223306] [   T3271] Modules linked in: siw loop btrfs =
libblake2b raid6_pq zstd_compress xor binfmt_misc snd_hda_codec_intelhdmi s=
nd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_sc=
odec_component snd_hda_codec_generic intel_rapl_msr intel_uncore_frequency =
intel_uncore_frequency_common x86_pkg_temp_thermal snd_hda_intel snd_sof_pc=
i_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic i915 soundwire_=
intel intel_powerclamp snd_sof_intel_hda_sdw_bpt coretemp snd_sof_intel_hda=
_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda soundwir=
e_cadence snd_sof_pci snd_sof_xtensa_dsp snd_soc_sdw_utils snd_sof snd_sof_=
utils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_gen=
eric_allocation snd_soc_acpi crc8 soundwire_bus snd_soc_sdca snd_soc_avs sn=
d_soc_hda_codec snd_hda_ext_core snd_hda_codec kvm_intel snd_hda_core spi_p=
xa2xx_platform dw_dmac spi_pxa2xx_core snd_intel_dspcfg snd_intel_sdw_acpi =
intel_gtt snd_hwdep drm_buddy ttm kvm snd_soc_core iwlwifi drm_display_help=
er
kern  :warn  : [   42.223363] [   T3271]  processor_thermal_device_pci proc=
essor_thermal_device btusb processor_thermal_wt_hint snd_compress platform_=
temperature_control btrtl processor_thermal_soc_slider snd_pcm processor_th=
ermal_rfim spi_nor btintel cec irqbypass processor_thermal_rapl drm_client_=
lib rapl intel_rapl_common btbcm think_lmi btmtk drm_kms_helper mtd snd_tim=
er intel_lpss_pci ahci intel_cstate processor_thermal_wt_req cfg80211 firmw=
are_attributes_class wmi_bmof bluetooth libahci processor_thermal_power_flo=
or video mei_me intel_pmc_core snd intel_uncore i2c_i801 spi_intel_pci inte=
l_lpss processor_thermal_mbox pl2303 pcspkr libata spi_intel i2c_smbus soun=
dcore idma64 mei pmt_telemetry rfkill int340x_thermal_zone pmt_discovery wm=
i pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telemetry intel_vsec i=
nt3400_thermal acpi_pad pinctrl_tigerlake acpi_tad acpi_thermal_rel drm fus=
e [last unloaded: siw]
kern  :warn  : [   42.233209] [   T3271] CPU: 10 UID: 0 PID: 3271 Comm: nvm=
e Tainted: G S      W           7.2.0-rc3+ #1 PREEMPT(lazy)
kern  :warn  : [   42.235107] [   T3271] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W=
]=3DWARN
kern  :warn  : [   42.236721] [   T3271] Hardware name: LENOVO 90XW004HPL/3=
36B, BIOS M5LKT1CA 01/06/2025
kern  :warn  : [   42.238213] [   T3271] RIP: 0010:cleanup_srcu_struct (rcu=
/srcutree.c:706 (discriminator 2))
kern  :warn  : [   42.239837] [   T3271] Code: c1 ea 03 42 80 3c 22 00 0f 8=
5 77 05 00 00 4a 03 1c f5 e0 dd 47 85 48 8d bb d8 00 00 00 e8 15 ca 07 00 8=
5 c0 0f 84 0e ff ff ff <0f> 0b 48 8d 8b 58 01 00 00 48 b8 00 00 00 00 00 fc=
 ff df 48 89 ca
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	42 80 3c 22 00       	cmpb   $0x0,(%rdx,%r12,1)
   8:	0f 85 77 05 00 00    	jne    0x585
   e:	4a 03 1c f5 e0 dd 47 	add    -0x7ab82220(,%r14,8),%rbx
  15:	85=20
  16:	48 8d bb d8 00 00 00 	lea    0xd8(%rbx),%rdi
  1d:	e8 15 ca 07 00       	call   0x7ca37
  22:	85 c0                	test   %eax,%eax
  24:	0f 84 0e ff ff ff    	je     0xffffffffffffff38
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 8d 8b 58 01 00 00 	lea    0x158(%rbx),%rcx
  33:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3a:	fc ff df=20
  3d:	48 89 ca             	mov    %rcx,%rdx

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	48 8d 8b 58 01 00 00 	lea    0x158(%rbx),%rcx
   9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  10:	fc ff df=20
  13:	48 89 ca             	mov    %rcx,%rdx
kern  :warn  : [   42.241383] [   T3271] RSP: 0018:ffffc900049778f0 EFLAGS:=
 00010202
kern  :warn  : [   42.242985] [   T3271] RAX: 0000000000000001 RBX: ffffe8f=
fff622fc0 RCX: ffffffff817d27dd
kern  :warn  : [   42.244560] [   T3271] RDX: 1ffff110ea8e5ce0 RSI: 0000000=
000000246 RDI: ffff88875472e600
kern  :warn  : [   42.246197] [   T3271] RBP: 0000000000000000 R08: 0000000=
000000001 R09: ffffed10ea8e5cc5
kern  :warn  : [   42.247819] [   T3271] R10: ffff88875472e62f R11: 0000000=
000000040 R12: dffffc0000000000
kern  :warn  : [   42.249508] [   T3271] R13: fffffbfff0d0d6ee R14: 0000000=
000000000 R15: ffff88818083c0a8
kern  :warn  : [   42.251005] [   T3271] FS:  00007fd8541ea780(0000) GS:fff=
f8887ccda7000(0000) knlGS:0000000000000000
kern  :warn  : [   42.252678] [   T3271] CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
kern  :warn  : [   42.254204] [   T3271] CR2: 00007f7098b7e2c0 CR3: 0000000=
883d05005 CR4: 0000000000f72ef0
kern  :warn  : [   42.255916] [   T3271] PKRU: 55555554
kern  :warn  : [   42.257486] [   T3271] Call Trace:
kern  :warn  : [   42.259126] [   T3271]  <TASK>
kern  :warn  : [   42.260726] [   T3271]  ? __mutex_unlock_slowpath+0x4b3/0=
x530
kern  :warn  : [   42.262369] [   T3271]  blk_mq_free_tag_set (blk-mq.c:497=
6)
kern  :warn  : [   42.263861] [   T3271]  nvme_rdma_teardown_io_queues+0xee=
/0x130
kern  :warn  : [   42.265514] [   T3271]  nvme_rdma_delete_ctrl (nvme/host/=
rdma.c:947 nvme/host/rdma.c:2157 nvme/host/rdma.c:2165)
kern  :warn  : [   42.267029] [   T3271]  nvme_do_delete_ctrl (nvme/host/co=
re.c:247)
kern  :warn  : [   42.268752] [   T3271]  nvme_delete_ctrl_sync.cold (nvme/=
host/core.c:277)
kern  :warn  : [   42.270328] [   T3271]  nvme_sysfs_delete (nvme/host/sysf=
s.c:498)
kern  :warn  : [   42.271987] [   T3271]  kernfs_fop_write_iter (kernfs/fil=
e.c:345)
kern  :warn  : [   42.273601] [   T3271]  vfs_write (read_write.c:595 read_=
write.c:687)
kern  :warn  : [   42.275278] [   T3271]  ? __pfx_vfs_write (linux/fs.h:273=
3 (discriminator 1))
kern  :warn  : [   42.276750] [   T3271]  ? kmem_cache_free (linux/kasan.h:=
235 slub.c:2705 slub.c:6405 slub.c:6532)
kern  :warn  : [   42.278425] [   T3271]  ? fdget_pos (linux/instrumented.h=
:82 linux/atomic/atomic-instrumented.h:3188 linux/file_ref.h:215 file.c:123=
1 file.c:1257)
kern  :warn  : [   42.279916] [   T3271]  ? do_sys_openat2 (linux/fs.h:2564=
 linux/fs.h:2566 open.c:1367)
kern  :warn  : [   42.281536] [   T3271]  ksys_write (read_write.c:739)
kern  :warn  : [   42.283048] [   T3271]  ? __pfx_ksys_write (read_write.c:=
723)
kern  :warn  : [   42.284669] [   T3271]  do_syscall_64 (x86/entry/syscall_=
64.c:63 x86/entry/syscall_64.c:94)
kern  :warn  : [   42.286196] [   T3271]  ? ksys_read (read_write.c:716)
kern  :warn  : [   42.287822] [   T3271]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [   42.289367] [   T3271]  ? __pfx___do_sys_newfstat (stat.c=
:446)
kern  :warn  : [   42.290855] [   T3271]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [   42.292405] [   T3271]  ? do_syscall_64 (linux/irq-entry-=
common.h:210 linux/irq-entry-common.h:230 linux/entry-common.h:318 x86/entr=
y/syscall_64.c:100)
kern  :warn  : [   42.293886] [   T3271]  ? __x64_sys_close (open.c:1511 op=
en.c:1496 open.c:1496)
kern  :warn  : [   42.295469] [   T3271]  ? do_syscall_64 (linux/randomize_=
kstack.h:57 x86/entry/syscall_64.c:92)
kern  :warn  : [   42.296937] [   T3271]  entry_SYSCALL_64_after_hwframe (x=
86/entry/entry_64.S:121)
kern  :warn  : [   42.298472] [   T3271] RIP: 0033:0x7fd8549a2687
kern  :warn  : [   42.299951] [   T3271] Code: 48 89 fa 4c 89 df e8 58 b3 0=
0 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 0=
0 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de=
 e8 23 ff ff ff
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00=20
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
kern  :warn  : [   42.301560] [   T3271] RSP: 002b:00007ffdc9d84570 EFLAGS:=
 00000202 ORIG_RAX: 0000000000000001
kern  :warn  : [   42.303102] [   T3271] RAX: ffffffffffffffda RBX: 00007fd=
8541ea780 RCX: 00007fd8549a2687
kern  :warn  : [   42.304724] [   T3271] RDX: 0000000000000001 RSI: 00007fd=
854b4da0a RDI: 0000000000000004
kern  :warn  : [   42.306296] [   T3271] RBP: 00007fd854b4da0a R08: 0000000=
000000000 R09: 0000000000000000
kern  :warn  : [   42.307782] [   T3271] R10: 0000000000000000 R11: 0000000=
000000202 R12: 000055a417335e50
kern  :warn  : [   42.309390] [   T3271] R13: 00007ffdc9d86703 R14: 000055a=
417335e50 R15: 000055a417336760
kern  :warn  : [   42.310924] [   T3271]  </TASK>
kern  :warn  : [   42.312525] [   T3271] ---[ end trace 0000000000000000 ]-=
--


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260806/202608060833.bce92909-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


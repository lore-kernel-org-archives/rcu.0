Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194B645;
	Sun, 26 Jan 2025 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737874423; cv=fail; b=FN0hBccK3XZNqYRTEpxPEOVyH4gdidyNphc0A3PEyPNouIJ4aaDr6VBNIHN0abUGnJdxm0BjUYkqsdH6TP1OXhAotVv4wGxC2j52g0GQsOUTJTRcZqOUYDBryIutZUhOlFWEx4IiRAp3OZB9IMcIlrPwGGHk0EAgTXMIS0X1twA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737874423; c=relaxed/simple;
	bh=h0xsYI6QP7vJmfVbkbH0QaMPoLuOBwMkLh9b2IgJj2Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PpeFtCgz83KP7uWAv5bjXZBGQ909fdB9yWjXGNrGwGlWT0xd5zCq8XyNWv13rJStR+2H+GmRdmkBtOBU9Jbo3HRr06sGQs5X5vVH7sukT2M6wSMLsylSt66vle56uXK0FVubKVOqSio9o8ha5cN1GXdLgJLgXpe+hbwdhUaVTv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iunfTWyt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iunfTWyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737874422; x=1769410422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h0xsYI6QP7vJmfVbkbH0QaMPoLuOBwMkLh9b2IgJj2Q=;
  b=iunfTWytmnYuQMq1aGZMp2baxCHYPlxncntbu8WHG9DQ0TVtZPUWZgg9
   iaWdaaDJFI/wB3UOQluG8xta8JGup+QwL9UD1zXxdxZ43hNQb7WyXuBNr
   mo+dFQj93g7e9yHEqbiV5tOkJJ6Hhit2u+ZXfzMQzNBRtKTll54xsXyBD
   /vC6M/rcldz8o/ekNs+JUZwA8DhFTQzHgPwRXP4D7Jo94TFHdc6vn9Loc
   KmAlzrh277aRXywDOoafb4hr+seFHfAldeo10YPJpFoFdoTT+AfGCdr8M
   +NK9tp8WmqzzI2GgPwbv8lNbfYX5sCTqMirGpH8RtNQz1u3kGn4cMhJZp
   g==;
X-CSE-ConnectionGUID: W75HUZyfSiqmbSXd1kVasQ==
X-CSE-MsgGUID: NZIoWkbCR0yiOQoSgW22LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="60827394"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="60827394"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 22:53:41 -0800
X-CSE-ConnectionGUID: QuGh/4riSI2+NA4i5z8pWg==
X-CSE-MsgGUID: PpcuzKIFQYqO6poK7skygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="113148925"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 22:53:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 22:53:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 22:53:40 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 22:53:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyythcnA6iALMhMTHjOqldSHG+vxMUJEtde0Q1KmtSdlW7XLwC4stL96gHRR6+Wgc1Dl7SnSV+IRXVy8KsNnidgCTk3HNe/1gNWCyHwn9y6LWuAJei7I9DGJL3RFURG7cq8SFJw3fCdd5n7lgzxVvEVnm9665P2gfNc++EllFTXU75fx/t4gO8r/mgbLxG6f4oUSenZ/ZNLntbw/BFI7N0gqleiSRk05QDl7CxTS74c7yPyVoDVqdowEPBxTv2pBLwOYRYrFMMtebCLWXc3TJY3Uk7SY40ZgZvL/taH0jECsgITpeY77OxqJqaCJGX7+YGxzyWsyMP4CfC/VXIiBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9+uUZH/lRXMQg9fK1PkrPrQLF9uO79nXp8RLMESJUg=;
 b=A50L32abvOA4K8EZ2b9LBKOJozWI8GBqaBl1N9FPSa8XSZ1zLJMpWYW+fCeYn7p+S8UfBSppq5JGVjRqQVIRuUWgxalUBtSthzxqgPxWgnxzqYGI3pvkC52WDlY6BV+EAjroCz7g3iDA03hNGMD3+kUYzFl8eazNBQERHMTjFs0tHF8oREvO43Io4TxgA/2U2YWena42ha/9LAx7r1H5LtqTm/nqUYqpbOM1OCRE5c4F1EEDvqf+EINnFSzeuD36RbVKNaAfn0O8vO4AQ1CpS6Vtihqvk2UDfco1h+PeCNtJ35XB8a1npa9iWNRp81el23DIsRKI955HZGyaZqzrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sun, 26 Jan
 2025 06:52:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 06:52:57 +0000
Date: Sun, 26 Jan 2025 14:52:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, Frederic Weisbecker
	<frederic@kernel.org>, kernel test robot <oliver.sang@intel.com>,
	<rcu@vger.kernel.org>
Subject: [linus:master]  ec9d6356bf:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <202501261429.c1f117d8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:820::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9f62c8-4fb7-4326-ca15-08dd3dd61140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLo8MthHONabkNM3+UGvNyV08M2nQxvYA5/b/oV6j7tunxK3smGOmHo8Poq7?=
 =?us-ascii?Q?Xxb69sDH/for0X7X9XDbe4H7y8HolC/B8Mh16fmxh7Pfiu5x7DaGTwKWFHOG?=
 =?us-ascii?Q?QLJUbnc3VJ8NK+5p607qlXswBLOw+d3PRU4rNFRCJvGWEOxHpPizFLVtWIoJ?=
 =?us-ascii?Q?jVa70hXZsD30UeYELmIAwJZAF0q9rG/N7C4hvUo6kEuRnGwyLgwE4Av1FE49?=
 =?us-ascii?Q?qi9QUTNZwhRTLOhsvyTePuDm0zsR6IqUlGpF0yw5EfdX0pPwSz6jLk+gU12J?=
 =?us-ascii?Q?aSMCxx+XY3/6Wx9yf8vmF1/i1/uK8yZTrwcNjIR/7r29cJxse6e2wRK6JeTo?=
 =?us-ascii?Q?YduzrWtJ7zB428AEsLOw4TmuAynFikqTfy6lsiM6dM/DJKHse92csHyWwTk2?=
 =?us-ascii?Q?WbRG8BNsLVA0rU83hzqLizFhqVOlKKsBZ3cUvK9/PEuo7fm1UXyQz5cOm+Q1?=
 =?us-ascii?Q?7zEDMt3utBUhi//HZaFt/g5q1zVazpyQOmAA93s8gFOEN68bcnJvyVgzPfrS?=
 =?us-ascii?Q?VPkXCY6KKPPT8M6/8QsbWln1n2tSmxM9e7XF1igT/QPe1ggIlbd8emopnRT7?=
 =?us-ascii?Q?qaO9P7G4oF3sc0/Ee+Rj2iISLacalG+1oZe22uWFGWbGfp9c/OSNkKhUGrxY?=
 =?us-ascii?Q?7bp0NM6VuM/vCKrK/JOnPdCSIOpkO5VUds7wEAUtXnu97szQRGNfqUPbz6O1?=
 =?us-ascii?Q?bL6jmegQqyt0V59s58JOu2bbQj/RnxKjtW01VDvlebduzmuQUOHG5VPK0Xsk?=
 =?us-ascii?Q?ORXDDXvj7DniolSJsTwKWuCrEFQOLW50/98/8g1z6C7MrNceJsI+H2mFmt+M?=
 =?us-ascii?Q?nnVuaUV3EtSLzWfszwL2EfWjyFHOMDJbWU7vJvE/UxtwqOUJX5kkqSs0yDIX?=
 =?us-ascii?Q?gkK6JQ1c1GTYot7xoYqRQIU4LSo4fSJF+LZN39NnGwXqlyyXin5lGClx0oyO?=
 =?us-ascii?Q?AaWtK8RJs6EbzilJrADXE6Wc+hkdtOkasWqOS+/kHgka20RPW6JdXnBmruZ0?=
 =?us-ascii?Q?i/MwvsL/Y/vMNcx3AUMAbZAnIo8Nj34fDK7tpbc/RDjWvjUfyYn8nSRw2Q/p?=
 =?us-ascii?Q?F3LEUAZpJGRnGuomdhVSjGT6fjVVxs4LGOesPuPn16ORHb+vnILSmuKc70Lk?=
 =?us-ascii?Q?aluLk/GBVzWrNKmf1m6vBIMmqFUXi8WHBGABid/6Tu349ZI+Os7SzGNaRPxp?=
 =?us-ascii?Q?BAIkr5q2PDwi8kNrO3FtnXMR0aNSiuppaP+QgyCrAWuuP816Soy1vl7TbcTt?=
 =?us-ascii?Q?G/wfQovnEwQB9psHusAGG1yIAzlYHYKLjcjH0+Etj8mbzFyeCHgXD3rbkjLc?=
 =?us-ascii?Q?BqQBH5fZ9IcCC4LHzNziwb77T18Lz41/YoT/9utIlDslBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kpj7J8qHLjRyjqTxCdvSciiJ0q33Kv5l/oVO2XHX8RoV4UMHAbbAPseDWGYx?=
 =?us-ascii?Q?1IyuV+zvcrdO/7o9cNPKxypHl7HfheOdcAHclVI1GczZQyNyEF7bMfsLSvU+?=
 =?us-ascii?Q?ok13YAUCm9tKN701ZcrdKXcrQxM0k32Vj5ka2LE+dOI7gSEq+fuoJEG9calW?=
 =?us-ascii?Q?JxXzsux9faB/oLuKVCl6iJA6i7UpAhwOaLNUlHh8YSA51GCsSkolAmc7R8Nd?=
 =?us-ascii?Q?eLGPGElrwN6/iHbuD6EIcWzpPMDU+DGaSDlo4Jkz+tFKQtywxVR/L5bACs2m?=
 =?us-ascii?Q?IP7GtjFjyCG4Kqt6hYTEakzZFonhBs8HYCjR2IIVBqPoi+FuE4KlfskSTStj?=
 =?us-ascii?Q?4ZUGMLT2ZVYz0VXQGlxdzOTB/1JI3O7UwM0Km9g5KH/qhwoGj16QfV20gIhr?=
 =?us-ascii?Q?as9oMMYiEfmUx3ZpTc6RSi+YXVFrgQMQdPbRhd3fBKGo22JBLHFtSddo8e5r?=
 =?us-ascii?Q?nahBB2ygR+gi5QzJkOBfsGzZ5DAG7kJ2kXyOx7R/RQOjzzJRWvqZcIX0jrUW?=
 =?us-ascii?Q?VrrUkFDSidqcpBKN8OYXgtnGzl2l4kaEzucSsWhk3kLrG/7Dm8qX1TYRyM8B?=
 =?us-ascii?Q?VCTqwp6D83cMdgdR9vWv63SUOWCue8C4bDUAMkaSaTl8SNKzk3mZqhZWV7Lf?=
 =?us-ascii?Q?qlGl+hC7q1vs/iSPyKIBartj227VRhDZnpN4YXrycdjvy3qUfOxhwLcRz4Wm?=
 =?us-ascii?Q?PmdjZgQ09BeJFQKprZNQjrQFvaSS5Q3UObSvwtCkb2r5VUPlezKS+QXZ+MJm?=
 =?us-ascii?Q?IpyQHYBRV6aaYVbMWOmxfJ79RXu3biAsCP9qb0ksjvyZJlmK5vNrKBl1X1Ko?=
 =?us-ascii?Q?cHj5/4L3B3xpL7cjL+rOrr8ogBPwrxvBPUmZnKs6INjtjHEahjaAQngkJs3/?=
 =?us-ascii?Q?OBSyduccsKHrfHJnLbyGWdKXemaFHGwJVRvciTWp2Qv93j/KrmeIXJVDUFOr?=
 =?us-ascii?Q?Db3Wk5NwCZ7tp6EqYUB4RaKa0J7zKnKS34px36n50ymVa4UtI1ZNyH0JECeq?=
 =?us-ascii?Q?XbW2NkPvLfLxYx11hJTU7nMtnXf+GLXgVTdoKhWJUYujbxUy6BUx3JUU5oD/?=
 =?us-ascii?Q?6rUHlZwjbdl1npznKfWEmfN+IZChoHmeHRMBIHHwrlEiJH+uLJ9qNPJDqMeq?=
 =?us-ascii?Q?Wi3AX4N/Q+v+yz9EXJbHZy5ZAlXZHmTEywB4gSsIYJeD+O07ALMkoOXxu/A0?=
 =?us-ascii?Q?oIG/Q18RFCAVD5i12Vtt7ZU0u1tChxd+jE7VvWLX/fiafvjVGJmmH9xNyO/X?=
 =?us-ascii?Q?RPlzcUEya/rmRWb8L5EuW48bLcvqAZb9bHV6jk57x+NECAP5lNz99XSX2Zkg?=
 =?us-ascii?Q?CUjbBZ2wfWyrOmWdXMVE59HmJvQsUAi/RprsWgCufagWj2UK/roHFXTAjwYY?=
 =?us-ascii?Q?9hYPHbxKmAKV6cZEiWxdko2JmDyV3zkeg++0SbVMoXF1/UugvZ4HOsT/APaI?=
 =?us-ascii?Q?eM7+CF+QHS1GActMUF9DYCK9gGRRAfD2vpe5ILmqvTSac2aKPPLGzxZ9d88i?=
 =?us-ascii?Q?RBzMzT362Uf1d5Jwgloblo8E4BBn6U7RwcMEztpAKZ6x4cKa9Tc7aT8nCDdR?=
 =?us-ascii?Q?e+zmltinjDh1n1Bt+cC4Xow8Nt7pHxHeW1vXIy0ZIv8J0+Ce5bqeud204W3B?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9f62c8-4fb7-4326-ca15-08dd3dd61140
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 06:52:57.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDZuAETHRue7lcEAXO8D29mgcB10Waiyxn23onhun2HX+cbRrXwde3ycNEDRYYkuWKom9GPyInGgcgwhviGJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com


hi, Paul,


when we reported
"[paulmckrcu:dev.2024.12.11a] [rcutorture] 774c4d7adb: WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]"
in
https://lore.kernel.org/all/202412241458.150d082b-lkp@intel.com/

you mentioned the issue was fixed by an upate commit. you also mentioned
you will change the new config to bool rather than tristate.

however, for this mainline commit, we still found same issue, and:

--- /pkg/linux/x86_64-randconfig-008-20250124/gcc-12/16338e7cb7450574ae3a210db6f35280fc44e50e/.config   2025-01-25 16:53:49.253595284 +0800
+++ /pkg/linux/x86_64-randconfig-008-20250124/gcc-12/ec9d6356bfda69abe5f4767dd56c964127913233/.config   2025-01-25 16:13:38.156027983 +0800
@@ -6713,6 +6713,7 @@ CONFIG_PROVE_RCU=y
 CONFIG_TORTURE_TEST=m
 CONFIG_RCU_SCALE_TEST=m
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=m
 CONFIG_RCU_TORTURE_TEST_LOG_CPU=m
 CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_TRACE=y


if the fix is already in some branches, could you let us know? thanks a lot!


Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:

commit: ec9d6356bfda69abe5f4767dd56c964127913233 ("rcutorture: Make rcutorture_one_extend() check reader state")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      b46c89c08f4146e7987fc355941a93b12e2c03ef]
[test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: rcu



config: x86_64-randconfig-101-20250124
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | 16338e7cb7 | ec9d6356bf |
+-----------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 6          |
| RIP:rcutorture_one_extend_check[rcutorture]                                 | 0          | 6          |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501261429.c1f117d8-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250126/202501261429.c1f117d8-lkp@intel.com


[   40.293943][  T446] ------------[ cut here ]------------
[   40.294385][  T446] rcutorture_one_extend_check during change: Current 0x10  To add 0x10  To remove 0x0
[   40.294877][  T446] WARNING: CPU: 1 PID: 446 at kernel/rcu/rcutorture.c:1894 rcutorture_one_extend_check+0x3a7/0x400 [rcutorture]
[   40.295434][  T446] Modules linked in: rcutorture torture ppdev parport_pc psmouse parport qemu_fw_cfg tiny_power_button fuse
[   40.295991][  T446] CPU: 1 UID: 0 PID: 446 Comm: rcu_torture_rea Not tainted 6.13.0-rc2-00011-gec9d6356bfda #1 abb71fe25d0aa7643c018e6d943fff3236ed9aa5
[   40.296634][  T446] RIP: 0010:rcutorture_one_extend_check+0x3a7/0x400 [rcutorture]
[   40.296999][  T446] Code: fd ff ff 44 8b 45 cc 48 8b 55 d0 45 89 f9 89 d9 48 c7 c6 40 39 2a a0 48 c7 c7 00 e8 29 a0 c6 05 8b bf 1e 00 01 e8 99 a9 1b e1 <0f> 0b e9 a1 fd ff ff e8 cd 16 89 e1 e9 29 fd ff ff 48 89 45 c0 e8
[   40.297896][  T446] RSP: 0018:ffff888135f4fa30 EFLAGS: 00210282
[   40.298184][  T446] RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000027
[   40.298555][  T446] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8883aede8608
[   40.298927][  T446] RBP: ffff888135f4fa70 R08: 0000000000000001 R09: ffffed1075dbd0c1
[   40.299298][  T446] R10: ffff8883aede860b R11: 0000000000000001 R12: ffffffffa02765c0
[   40.299669][  T446] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000000
[   40.300038][  T446] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
[   40.300458][  T446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.300768][  T446] CR2: 000000005badf000 CR3: 0000000144a4d000 CR4: 00000000000406b0
[   40.301141][  T446] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   40.301514][  T446] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   40.301885][  T446] Call Trace:
[   40.302045][  T446]  <TASK>
[   40.302188][  T446]  ? show_regs+0x5e/0x80
[   40.302405][  T446]  ? __warn+0xd7/0x1c0
[   40.302602][  T446]  ? find_bug+0x21c/0x340
[   40.302810][  T446]  ? rcutorture_one_extend_check+0x3a7/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.303310][  T446]  ? report_bug+0x283/0x300
[   40.303535][  T446]  ? handle_bug+0x57/0xc0
[   40.303743][  T446]  ? exc_invalid_op+0x25/0x80
[   40.304012][  T446]  ? asm_exc_invalid_op+0x1f/0x40
[   40.304425][  T446]  ? rcutorture_one_extend_check+0x3a7/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.305544][  T446]  rcutorture_one_extend+0x1db/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.306488][  T446]  ? rcutorture_one_extend+0x449/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.307662][  T446]  rcu_torture_one_read+0x115/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.308683][  T446]  ? rcu_torture_writer+0x1ec0/0x1ec0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.309705][  T446]  ? __lock_release+0x3c9/0xa40
[   40.310313][  T446]  ? __kasan_check_read+0x15/0x40
[   40.310824][  T446]  rcu_torture_reader+0x1ee/0x580 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.311540][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.312334][  T446]  ? rcu_torture_one_read+0xdc0/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.315285][  T446]  ? __kthread_parkme+0xd4/0x200
[   40.316172][  T446]  ? schedule+0x103/0x240
[   40.316736][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.318152][  T446]  kthread+0x2e8/0x400
[   40.318839][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
[   40.319716][  T446]  ret_from_fork+0x47/0x80
[   40.320497][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
[   40.321402][  T446]  ret_from_fork_asm+0x11/0x40
[   40.322101][  T446]  </TASK>
[   40.322645][  T446] irq event stamp: 529
[   40.323346][  T446] hardirqs last  enabled at (537): [<ffffffff814218a0>] __up_console_sem+0x60/0xc0
[   40.324776][  T446] hardirqs last disabled at (546): [<ffffffff81421885>] __up_console_sem+0x45/0xc0
[   40.326112][  T446] softirqs last  enabled at (454): [<ffffffff8126e8c2>] handle_softirqs+0x382/0x680
[   40.327504][  T446] softirqs last disabled at (427): [<ffffffff8126ee65>] __irq_exit_rcu+0x225/0x300
[   40.328894][  T446] ---[ end trace 0000000000000000 ]---
[   40.329677][  T446] ------------[ cut here ]------------
[   40.330463][  T446] rcutorture_one_extend_check during change: Current 0x21  To add 0x20  To remove 0x1
[   40.331868][  T446] WARNING: CPU: 1 PID: 446 at kernel/rcu/rcutorture.c:1891 rcutorture_one_extend_check+0x2e5/0x400 [rcutorture]
[   40.333494][  T446] Modules linked in: rcutorture torture ppdev parport_pc psmouse parport qemu_fw_cfg tiny_power_button fuse
[   40.335162][  T446] CPU: 1 UID: 0 PID: 446 Comm: rcu_torture_rea Tainted: G        W          6.13.0-rc2-00011-gec9d6356bfda #1 abb71fe25d0aa7643c018e6d943fff3236ed9aa5
[   40.337033][  T446] Tainted: [W]=WARN
[   40.337379][  T446] RIP: 0010:rcutorture_one_extend_check+0x2e5/0x400 [rcutorture]
[   40.338233][  T446] Code: fe ff ff 44 8b 45 cc 48 8b 55 d0 45 89 f9 89 d9 48 c7 c6 40 39 2a a0 48 c7 c7 00 e8 29 a0 c6 05 4e c0 1e 00 01 e8 5b aa 1b e1 <0f> 0b 4c 8b 25 d2 cd 1e 00 e9 16 fe ff ff 65 8b 0d 0e 20 16 60 80
[   40.340181][  T446] RSP: 0018:ffff888135f4fa30 EFLAGS: 00210202
[   40.340801][  T446] RAX: dffffc0000000000 RBX: 0000000000000021 RCX: 0000000000000027
[   40.341593][  T446] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8883aede8608
[   40.342450][  T446] RBP: ffff888135f4fa70 R08: 0000000000000001 R09: ffffed1075dbd0c1
[   40.343224][  T446] R10: ffff8883aede860b R11: 0000000000000001 R12: ffffffffa02765c0
[   40.344194][  T446] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
[   40.344957][  T446] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
[   40.345882][  T446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.346613][  T446] CR2: 000000005badf000 CR3: 0000000144a4d000 CR4: 00000000000406b0
[   40.347361][  T446] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   40.348310][  T446] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   40.349123][  T446] Call Trace:
[   40.349494][  T446]  <TASK>
[   40.349737][  T446]  ? show_regs+0x5e/0x80
[   40.350219][  T446]  ? __warn+0xd7/0x1c0
[   40.350595][  T446]  ? find_bug+0x21c/0x340
[   40.351102][  T446]  ? rcutorture_one_extend_check+0x2e5/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.352185][  T446]  ? report_bug+0x283/0x300
[   40.352703][  T446]  ? handle_bug+0x57/0xc0
[   40.353146][  T446]  ? exc_invalid_op+0x25/0x80
[   40.353636][  T446]  ? asm_exc_invalid_op+0x1f/0x40
[   40.354206][  T446]  ? rcutorture_one_extend_check+0x2e5/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.355352][  T446]  rcutorture_one_extend+0x1db/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.356304][  T446]  ? rcu_torture_reader_do_mbchk+0xb2/0x700 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.357502][  T446]  rcu_torture_one_read+0x35c/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.358505][  T446]  ? rcu_torture_writer+0x1ec0/0x1ec0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.359614][  T446]  ? __lock_release+0x3c9/0xa40
[   40.360167][  T446]  ? __kasan_check_read+0x15/0x40
[   40.360697][  T446]  rcu_torture_reader+0x1ee/0x580 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.361667][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.362774][  T446]  ? rcu_torture_one_read+0xdc0/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.363814][  T446]  ? __kthread_parkme+0xd4/0x200
[   40.364352][  T446]  ? schedule+0x103/0x240
[   40.364810][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
[   40.365951][  T446]  kthread+0x2e8/0x400
[   40.366377][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
[   40.367037][  T446]  ret_from_fork+0x47/0x80
[   40.367473][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
[   40.368198][  T446]  ret_from_fork_asm+0x11/0x40
[   40.368737][  T446]  </TASK>
[   40.369055][  T446] irq event stamp: 1040
[   40.369505][  T446] hardirqs last  enabled at (1048): [<ffffffff814218a0>] __up_console_sem+0x60/0xc0
[   40.370496][  T446] hardirqs last disabled at (1055): [<ffffffff81421885>] __up_console_sem+0x45/0xc0
[   40.371445][  T446] softirqs last  enabled at (454): [<ffffffff8126e8c2>] handle_softirqs+0x382/0x680
[   40.372543][  T446] softirqs last disabled at (581): [<ffffffffa00a01d5>] rcutorture_one_extend+0x515/0x900 [rcutorture]
[   40.373688][  T446] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


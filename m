Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBC191F60
	for <rcu@vger.kernel.org>; Thu,  2 Jan 2025 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735796524; cv=fail; b=jgRPdIGKLkQY9lDjIKT8Gmpa0IKoT55r/k9mJIRkN1LIIeT+Wa3wCt/MReuxmg9eutDwe05cIxYTzvTOBUaSnTGOWwdKpRluksHKDQnM1PmFJJk7Pf+FPzqucYHNKBBvVz+w/ARHyhxi3fdFHEbUbdGE8ZznwV/zyxNhGtM1o5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735796524; c=relaxed/simple;
	bh=fd5mxu1mlvhS5A6bpswnJWtsnPt0S5qTB0IC6IEuvyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asvIKHYCFy/9Q8xhWt8GKQqglV1Ac1s6CgPZotQ2jO0S/7VDVQ3vSEKUiR8dwTCgMekPpTp32Fyt8WEy3PND6l21R0STbyhmJRsvPSQLGpye/XCZrPsOKInTSYIeZI4naQJ2eHDXnleWPftYsLJPhS6F+KqFCf0F7BtLZDVAUf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChfOMN4J; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChfOMN4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735796521; x=1767332521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fd5mxu1mlvhS5A6bpswnJWtsnPt0S5qTB0IC6IEuvyE=;
  b=ChfOMN4J81CKV9AomJVrhaQuhvrO8NJaEf8KKSGsvu4e/IP946cirukm
   HZjAo6D54iRPm0LdiVe8MuRrEiKLKFf6pQWuxCY73/4Big0eXoSEcnjW5
   OLCJYqMmipT0N3id5dRwLAL6vUR2q3MIHZBkDwsSQ3JIdUFKdtuLuV8rg
   xeHMe2lrqD4GwzY2gi4mGCiE/btmhvi3RM9RzmzT0cppSgm7phYkndo4J
   ap+ek+nn7e4nqxrYCE8288X5iV1JJhyGRqxkI1Mt+olxpw01pA3qsOXEE
   ywH6Z+Me2hzdHrd/f84UJLZCc9IFqXkuiU52FQ1h6UY7BazT45duqJZrU
   w==;
X-CSE-ConnectionGUID: CzFvr19jRUiaEzZffjh8+A==
X-CSE-MsgGUID: c1dPzrbwSfO0bzww6hgHvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36251087"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="36251087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 21:42:00 -0800
X-CSE-ConnectionGUID: ZnzRqZUbQR64ddqE92DSMQ==
X-CSE-MsgGUID: ScO/MVeKSf+DEehw6c8A7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124672837"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2025 21:41:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 1 Jan 2025 21:41:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 1 Jan 2025 21:41:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 1 Jan 2025 21:41:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ6Ke71OLPhOIDb/+yuc1skjCE9S09uK2mGTjfozaUPshRhciZ/EZy4EVcSo/lCl/wkZZvcNniMIz4jr09DHZEOMQkeyxYFEB5Xy9+qHVTK6McUsfljVtNb6BxtO8Iym8DQGApD3tp0QSAqzVe7Jo9wLYAHlY2wU0VniVG1cjgElqox8T9weTxz1IObKCI6JP9q7u2/w9Plw2cfxUZrID7NGqnZDZ5q8ZoI3eFUkggIIRxSabO4eMDS76dAJCofAt82m7P/Uiso7y4fKnD7dQRROft2/Tn0FKPccATPCpTbCOqhSzRTOzrzhFdrTW4GNYbZb8pHgkKenAQIwrXWobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCkzWgB67T9rAuwRkg+nplTktnoE7nbZGeQ+CKAcle8=;
 b=AyLgVFBT4OAY50dn5+VHE3SBEqEpR6wWkFronzaY3K7R9W9TpPz7VNUCusMGPucdOzifTzV6uPLLPWJBNEVK2juhFNUmD1TgGpDrfYTzCiqkZNBdYJPLPFYesZiY7C8Kq4yUVhBmkPJplGEv3uJXq69VPws3QSQvR4XCNDTqoXJxUfg5IhNb3iTY6pKBKDjMKdFWkWbLHUQ7DwdXdErv3bVxkzxxOTxXaO4dWkh5X1r/6Ewd5pS9b+uAvhxRFM2Su65h7DcdBa74bmf/vgxPxXVi0HD/X/mE8turGPylJ/PJdSLaL3EUAd1O7IJH56BKZ4XOHyex0jmqp8jMM3v7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 05:41:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 05:41:25 +0000
Date: Thu, 2 Jan 2025 13:41:16 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Z qiang <qiang.zhang1211@gmail.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <rcu@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
References: <202412311203.ca7bddba-lkp@intel.com>
 <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
 <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0070d605-78fa-4fcd-0c3c-08dd2af018d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kBjaHJiq9keFFA6wBo0rjQD6DPNcRThSL2QP5Mkh2+V1oQg3w+pmvg3uwUah?=
 =?us-ascii?Q?wzSQ09bELGgvPqLXTq+I1jhpGrz1/XCqjDE5HBfLxjm3d5QKCGRDRzdTJwCS?=
 =?us-ascii?Q?ps8qMBK4J5M4hA12lku0IeV36i3A6oSZpMyVbawKeQ9u5HLdj5DMdA04/1Gu?=
 =?us-ascii?Q?A9ajP8uwh9gtloWC8xZkdh8KmVG/AK8AuzmuM9eQOifJNzVQluTITAquc411?=
 =?us-ascii?Q?HPf7weSPPK8gEik+AeIlA2WCOGIvyFMdCwmzGXaISYTDXPueHuNnckH4MqpL?=
 =?us-ascii?Q?lB5gINY0op33amGUtGJ3Eag++yz/YN6KhWO+PkiCyiJAOzfmDQVZXtXys2Gq?=
 =?us-ascii?Q?9je40Y54jv56/ElMzCI9Uvm/3kF4wd3wGoFxDwH7APEbDoUfmPqhQgqfb/60?=
 =?us-ascii?Q?bxh9goe0QfCvpXOBhjuDfZzVPUJdFeRCLBOA5oRk4Fyi3TLZANg+78jzGUf5?=
 =?us-ascii?Q?B2VU8wbSicaf7aufOI7j7Gl8hcW92XUMsQPTwuPPEZ90c4wnebW3Dd9CMWqZ?=
 =?us-ascii?Q?UmZAdHkg3aRUrutK/Ji2oZEsWFakwFOqPeAQ07MkBcXLOI8uB76lR9Eo4F1T?=
 =?us-ascii?Q?VxQc+Iztt16crpW+VC294dBeDv+Me3k6piEleinwS2n9AmbR4JGN3H5I3/rd?=
 =?us-ascii?Q?ZYfYWAxPYbB8QDWUt8UOBtTgOL7bX4aT3VGnFGf02C9dclMPwA2WR5zNetph?=
 =?us-ascii?Q?o5yGYm9lb/36wDDKy+g2j+t4MoQli8o6e+uiBi2+vzSL+TzdP2IamWxHzQKQ?=
 =?us-ascii?Q?3fK58sx+gO0NBjiGphTXw9iSDy3j0NmVlnIEQ5EGhYSIIzmuqWBWZNkSRCdn?=
 =?us-ascii?Q?lFigvUTe0Ru8vr1l16L2nogKKxVH80J3ObSx7xxIpbAmPP4CO8bpdFSLYAWL?=
 =?us-ascii?Q?DybghpZH0J5o0Wo08FWiiKN5Y36tDzQv+Ec3a+Gj0GjiD3ScflpLv+DmTDft?=
 =?us-ascii?Q?UaLCLNbGUBRo/Azog3zS8f+xyTHxnK3Zih0vtsIZhOIFBXiSakyFTSMehMV8?=
 =?us-ascii?Q?w2rY3FPEJq3TVtjEB39XA+8peBdEUHFPXxEHCreS4FwULsaUZFDLrUMbqljN?=
 =?us-ascii?Q?120rDbAMiL/O+hG2hSb3ierFZa8BSPWyOPrzjOO60Oexc618ckhvZ8HiFyyT?=
 =?us-ascii?Q?OGLALwQW6gO5q5zBTBedQaAevwZGN7WS64fslJUwhjM0zv4PKTPk/dwM9bwu?=
 =?us-ascii?Q?SslPNFY/7njwU5tvI45xcCi6jQ3806plVmVCIZVPPZDZupXVteeQCCFJWxVk?=
 =?us-ascii?Q?JC2u9s36a7QaaqTOt5RDeRyHg1klWjggUdw1DSt8FWU6fe89VuERJh5GtH+t?=
 =?us-ascii?Q?b6qjd27f2F635r0aTeaodWGiqzZ/Szw5Y5IG5i4r6fHgzaNh4TYrBR/xi6nF?=
 =?us-ascii?Q?k3bfzuoryCuAde4vqvp16PgJkxGT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iwwJok/LJ74hhjRl58J0ZFJ0W7YhzSP0ir216EMJT+1bk+d4KHmZMwmCwHE?=
 =?us-ascii?Q?//FqPmHdxST8KZb35SgvTD9hzcvJvPbngpabERbj/njUyIZnTSabGsQVpRn/?=
 =?us-ascii?Q?M/nPO+/GcKQturlM24W65YbqxLFjDls/TkA6Jw3Hm0c6zjGRs2+ZHtkfIr5v?=
 =?us-ascii?Q?6ZINmlePx2eV7rjhQtmaVJjI/gQbR/IwwuYKWxTjomWwqVlh6j241P81vWJ5?=
 =?us-ascii?Q?ulhZgjcnUXuPq4gBuVG5ku+6+RKY1ieDkT0GjysoWYAAsiqP1HCd0MGp1t3l?=
 =?us-ascii?Q?uDwrPjRqJhEK3lN68QPRhqgfNQ9vwy1EuFr9TaOo4/K6oXQDNw6AtsWX8fAa?=
 =?us-ascii?Q?fenXYNGzswjNYNmtikW5q4wNHIAUO68FXj+jgq4nOGUbK2TWqbpWNAVzRQjC?=
 =?us-ascii?Q?157sKzuF/pPj36gDTWQ0IqSf4qiPx5uQn/OR6FyQr77CR6sYVR4ScQos+ZON?=
 =?us-ascii?Q?fz4YU8TAtfxqIMIIPpeus/hNLJrN7D/yZJPWN2WXzRyaNkuBPLAMKxgVjtds?=
 =?us-ascii?Q?s4Q1O/tbn3DicoB+wUdXuostewaKTzRPYKELYBuoPHu1eN6qPm/kKzV2aIvx?=
 =?us-ascii?Q?nR94Ak8xKYwSRd4pg3umSAFImvf7KhWzEfvuZOIau4MFZnLSZsRdyzGuud9B?=
 =?us-ascii?Q?jTe8cP2DGnLqQxDWhYYzntgLA7ySRZFm6qa5S4/95422dMsIL95FKyG1da+U?=
 =?us-ascii?Q?AAdf1zFnWyviifl80dcf337VR6U2VfRxN7ii62rDRmNkPm224qL3le2qfjZq?=
 =?us-ascii?Q?bCV90NpluSJgzgmIRCOZdOW5/cqSU72mliUrMlOBeJek2YZTw3cowqEhPNHe?=
 =?us-ascii?Q?6GEUg+zmpMqe6eXIwwgCr4dU/RDTHpDQodHPulORMlF9r7ZhPgOd4p9I/YR1?=
 =?us-ascii?Q?zgOy5CNpmo0FqJXgzubOkVHJNiAt4Ws7mzA06fYmUGmwbabjIPigtcFn+IhO?=
 =?us-ascii?Q?ecI2iEZL4sSWVGECLRzZSaBvNy0yM5GlRdQs20bFXl+PjFg2lfnxm6ZyQV35?=
 =?us-ascii?Q?ShCXuhcF5VphTax1axRWHidDzByEM1ImLYByZ0crWEViCDO/6sX0UR3/rAao?=
 =?us-ascii?Q?PhPD+e7/KjwxrqTEAwqnk+ZQD9KZFNPzQLpf2Shwlv6WDw9rq277FVSV0aiW?=
 =?us-ascii?Q?CJScrsNa5xXY8V0OjbKtaGf983tnRgzDdSar2XkL6Kozb4l5C1C25u3M6QOt?=
 =?us-ascii?Q?yzlZGbB7fWtJonSV2mCnCDblA1Zi0mTSw5iTPaN6J0Oqcj7hwU5wVpPE+Ckl?=
 =?us-ascii?Q?r6myseuBCkMJKPZQGnjHAq1hyGrAsBGb5CuBehf08OHbpB6doNoBErC77qdC?=
 =?us-ascii?Q?z8y53ANWpvvUG43Drduaznr6yBe2QFNqg3Q5SEvK6zYMwWnqWqpLjf214gHs?=
 =?us-ascii?Q?82ngeCdGNKj581dRMvDCRs7QQu+nixEZGsLShbYtKdQl3+KocKR1WA6Xyu48?=
 =?us-ascii?Q?c4Iuro15/52nMU8C6fOPECM053lZcrS+lFhkaiYgc0MIwSYu4xCh0TQgj3o3?=
 =?us-ascii?Q?40ATi2jga0kQgGxJeQ5Yy9Iv/X3AR1mRwi4KVTNFUsEsHQUrCUWWS3yjw+vr?=
 =?us-ascii?Q?HSghLqUEhLzuCrd0j18Qe+WmedJt4uz+nxrY4phO2DqLiV+O0DvSGXECH2D4?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0070d605-78fa-4fcd-0c3c-08dd2af018d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 05:41:25.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5YQ3+32rw5ONGPK0sMVgy31UaPaqySi46BZjPEB6JcIhMlpVxexZuJydXvlHMxfuaiRQoD3U9NavFLU14oeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

hi, Zqiang, hi, Paul,

On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:

[...]

> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > >
> > 
> > Please try the following modifications:

yes, the following modifications fix the issues we found for 9216c28c6a. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index e85db7d5b364..7c7304dee645 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1999,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
> >         for (i = 0; i < mod->num_srcu_structs; i++) {
> >                 ssp = *(sspp++);
> >                 ssp->sda = alloc_percpu(struct srcu_data);
> > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> 
> This does look quite promising, so thank you for digging into this!!!
> 
> Looking forward to seeing if it fixes the problem.  ;-)
> 
> 							Thanx, Paul
> 
> >                 if (WARN_ON_ONCE(!ssp->sda))
> >                         return -ENOMEM;
> >         }
> > 
> > 
> > 
> > Thanks
> > Zqiang

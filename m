Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9030DEA2;
	Mon, 12 Jan 2026 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768197273; cv=fail; b=hbbVSJ52dRtJmGMqJTxVeasdvVqcDHdkJVgMfiegi/qR2r5cbSOAK70LUYIKami0lfIz/DEwhy7cnJVx3CPAPzcBhTzZVjSwevpb3buRfA5G4GASjk7xLRUHDafc4HfzeeO6TDa7rVGSaiZTkLgpb1XoBYatke8K6gIIGSWxUZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768197273; c=relaxed/simple;
	bh=x+G5kDEjqVPUA4sjWsC1VrTA+NoiDLHOVP/mYXdluOc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KWJSqjugoq/5rgjBfuap+4JTS25nWicrxjKOJeNMcSP6XnqpECVh2EPYz98cJ43WsRjXlYco6JGQZW/AdA7lc4mGwx7xreBRIxZf246dACMk+8WneFhHQUb1wcAbtOermGGPDm4enm0ctBXvqv0OI8RZkMx7sW0s585ZhsSwPDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHa+oQp8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHa+oQp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768197269; x=1799733269;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=x+G5kDEjqVPUA4sjWsC1VrTA+NoiDLHOVP/mYXdluOc=;
  b=CHa+oQp8GKtK8wK540wkxItFjt2LX1Qq2IEV7DoOMVd+N9ygnW2FaQwZ
   Q8PqKRoigt6KzypGQM94/wSjHirIDcNWeeXV/5anmH7y8KCGfYqeZgN1N
   UgVcWrJJM8ga82XCgujpXyQ84fXj43ltq3tWFmvdpmB5yCqA4x+hN8rAm
   PFtLmxZIvUcBorSj491kfCTMvpBFykt0SWZ8Zh+9hbDOdHCskgCv6A5Sq
   RmO/j+y3dyzyI2nKfh3ocQPYsWVL3Ta/sLXyOyT4Fqq6Kxy5qulPiVlWk
   /VutTdliuGE2DHMGNPtPUf6r6WDJr0YtpWePvLp++BxFd8RMMB9wyuUv2
   A==;
X-CSE-ConnectionGUID: j/zqG9KgSQanzFoiSjGhzw==
X-CSE-MsgGUID: Aj5/McRTQA69NnbNIvcJQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="92133156"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="92133156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:54:28 -0800
X-CSE-ConnectionGUID: P7tKtjkFRzyAMBbogv68tA==
X-CSE-MsgGUID: 0PQ0F0vmT5u/hoYzuAD+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204704301"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:54:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 21:54:29 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 21:54:29 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 21:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o714m3UxOlbnJqIWcaYz84BtjXOy1FIQbiSJJa19PKsMhMRWW0jiaU5n930IBkd514WtMcUdoEZ+a7jsehluD3eLr9VWXQkwOXl0140K2vkbF7X2yzJFGWU1+jHcvSN+TUi98j1vTi9/NuvUNT25Uez4GDY4V84r9HYpdj/uw65JZ99e8Q6Nmeq7Xm3ZF2I0yh/YJhTuKI4kmZzaoz7QyGrYmOmo0BbWPQjHVTfCC3emPKEA26Hb2/1Ah/pO3dLPKfrOreUvhfrEwcI26ut1zqUln9MlwpX20HnuekDgDCg1EfiBD9ULr7sRCiovIzzEMe9Q940D4i/qg0GkoiHY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofCispQAtoY0B1VaD4FjOn6dmzQ63CUgTkczWYnj5o=;
 b=ZkIYd8gMfnEt8d6/dzzZw7l+6GNIxeFeMPGIObbCRKuYMGwBqKFqF4z/LE26cY7naNLeTwafxeQOIpD/Kg2JiSUbPaVTQXQP9mHPo77XcDXm0hNBp9BO4+BPL+ykZT4EsGFpU/8S4vjsY0iHfPPHCN6ZiYGo7SjkccQ17KK8ChfIMfXITOovhg4fs0KLu3JnVOKygMsPaJyELSEaJ40uPZ2aYtT3kW9FHXclbLBQ2Yb6I15i7t6IpIiFDIwAjChqdWuXX0MW8qHbvTnjcSSb2Y9KgRJkLm+1dpQ5vtLKiq5rCMTjw2/VCdSvr5gSZdU3cHQp208eq0SjzWT6o4yS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 05:54:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 05:54:26 +0000
Date: Mon, 12 Jan 2026 13:54:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Boqun Feng
	<boqun.feng@gmail.com>, kernel test robot <oliver.sang@intel.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	<rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next:master] [rcu]  c27cea4416:
 stress-ng.fd-abuse.ops_per_sec 7.1% regression
Message-ID: <202601121044.6d8b5bac-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU1PR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:802:19::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a919d89-3d2b-40ca-8da0-08de519f0afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+RZaYC/KiQ3j7XcmN3g+Eg0iXB5LArQmotuG9GmJQB/DiKE84o//nbc/RO?=
 =?iso-8859-1?Q?SeE2O8Kt8bYnEhTLjT0or/iVYfkiReNxQVtym5AUQjdeiEyyf8weaifaVi?=
 =?iso-8859-1?Q?bBd3ZinJKJ+rZxbXGAtmKW+mXh5snyeBjLCgda7BpNCovKEUflngWMoBHS?=
 =?iso-8859-1?Q?grmWqA7bchCYFMXWBC7Wp1/ZvbCfDx3dx0+VX3bPOGdfVYvstZmYlK91VI?=
 =?iso-8859-1?Q?9Y2f4cuDTfqJL4eY5aPwn0Sv6mqy3g1surW9AI0DS/dtjqVfLIxGPHIdVr?=
 =?iso-8859-1?Q?0hZBZZdC+wBkCyhtqIiHssNPI5R89FGSUR4hvpKpAChQS88/1lT6BvNaxc?=
 =?iso-8859-1?Q?f8ykJKgQWxTMzxzf5v82gYwFw2c2qcV9DI9Sej4JumgJson0JVWmCM8qyg?=
 =?iso-8859-1?Q?vloCL3FahRHnbv+S4Lr6Z1Xvb+ydP6DXQ/KMOfM948Ma/ov4xQXDkenZs9?=
 =?iso-8859-1?Q?5MyRdiEnYMB3ue+LVaDlFdiyyfq4AGDGebXADa6oiaSclxACfilNKMzIXp?=
 =?iso-8859-1?Q?kUvP7gcwMewAuW3meG2OuoOd62Xe0X/PZ9IDE+zAmvUYzITZGsRNbs4j9v?=
 =?iso-8859-1?Q?iXho1gj4j+veCE89HsZVVUDXhKweIDOkaVICoYv0LoK8wifGzpHYgazvEk?=
 =?iso-8859-1?Q?fFh+gqcMVTNL5p9lk1JLP+f7StW6VVfhOHtiL3XIpeqnpNj83Da45sDER0?=
 =?iso-8859-1?Q?SD83dzfJVwSKT2QJFLQT440ZeA0avVPr/w2zEGdWOXUU875e/TvKZmq6iG?=
 =?iso-8859-1?Q?QZNcwFpaZx75WwleW6xp5EnppM/VDk0GDrcnLUieaei/MoxRbgtBG9+7wp?=
 =?iso-8859-1?Q?2Bw+2ayn/QnY/6bdlk46nz9xwgA5fTA/ZgUM4efjx/OOP3qMprNSfC0zTr?=
 =?iso-8859-1?Q?NnkvCRXk9j6MLHesjoPMID5YWLcZ9l7bpPvJ0r94KxIVY2gXcZ8QTUdKI3?=
 =?iso-8859-1?Q?DUQ2Ft4J6mHCYhMupZH2NDx4EhAQDUFUPdHXKXpZctTmhp4UC/NPmJSukX?=
 =?iso-8859-1?Q?nYKxDShV+pcqVv8lh2xv6UOBJw4jtVrhkSvy8Pvn9CdVoObFnC01VBKe9o?=
 =?iso-8859-1?Q?9AHlJwqcCerW4qdyEapVOBCV3+Qc4sdDfDBpX7hhv/CkTb3NRwcx6/uEYS?=
 =?iso-8859-1?Q?q6EWevpLWanqPLpF/U5kdCkrx3zYDTLx9THLiSdfWNmzEIncynfVFShFKu?=
 =?iso-8859-1?Q?l4T/yzTrfnFAthZOG9Wg04pQvYg9thRdkqfR1KgQ9A5jb/kdQsGeEDIIk6?=
 =?iso-8859-1?Q?Yn2AQpxq8q+GmHQm0/FqBOFdSLMymtJEaVAtHQ+psTmNnxVjQCylYmanQ9?=
 =?iso-8859-1?Q?Ln+oqdFQdzZrahLQZopHnKg99bcaUiXJZ4Da7/BErKad6abZNQ7j27MNLG?=
 =?iso-8859-1?Q?9Ns8EE8v1czzpaPFyAdOtKqUiyvJ8GCdhRn9BOpNRX1B7Y3RgANcYyuOgO?=
 =?iso-8859-1?Q?hKA8zAq0aTeIaKMPq5jHs30FAErx35qA+UGTZJ6NZq6KfzKid/acKAWTxR?=
 =?iso-8859-1?Q?lTo3gT6Vfm6xyXlm0jpc+JfbsdF3OYZ1z2sYwp/tqg8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M66+7gcI1KVZ/J4GG/TnkPQyZqrOcpLBmZFYF/1AkP96KkypPoObD7+Yuv?=
 =?iso-8859-1?Q?EXYdRNDztZsES1ZZPfufGN0J2IHG1IfvM6JKCPmVZHe0DEo+kQHLoZj8dR?=
 =?iso-8859-1?Q?lB/jqGpBL9m6ah2Xf4cJ8A0dQAWbv/eax8791DamukxP+qsR+3IFTaXA4j?=
 =?iso-8859-1?Q?5v1TzBvO/6Sk/vFdzgDaEQfrH12VRafKKZBPzA82Zzn/u5ZEmj+nOKnWUG?=
 =?iso-8859-1?Q?Ju+hPClUxOAdFeiQUENgVdfSomJWoTvQjxw2ENs2P38bqKurk9DZqWSN7m?=
 =?iso-8859-1?Q?lEDqXODVVZcVAkxU2HBRD+xCrJaNJs2p4LuSl26mYe533JBmbGs0w/o/92?=
 =?iso-8859-1?Q?Dm8k5QJhlsoebByFxrS3AiqKyNr73dom76+TsFIvX5CFq6kARYJ371Q+qA?=
 =?iso-8859-1?Q?CFoNyvLmrMbGC8fUIzmA8qi1M1Xi45+WbWJinmMUi/OAGCM4gELc0Ufigb?=
 =?iso-8859-1?Q?oCVqTVMzNukfNi1pyUCvLH//hSSmGaG3v8CLxeuCDSLDnkfx0QHGjp0SGu?=
 =?iso-8859-1?Q?1QaInlQkBYg9B5facw4+XctA6CXwTb4t5JRxZrdFLM+RdjAomrOCFro+/D?=
 =?iso-8859-1?Q?stGdsy8m5JkISkGGRYpLQ+SbfuwhvZBUDCrGonooxuv8CvAKENKuqU7drk?=
 =?iso-8859-1?Q?BLAcPshk5jZ24gtenwgVNQl++Yqz66ZESEm/ZQjKiYe2U41XNzFfX4+jsm?=
 =?iso-8859-1?Q?+ENNNA4IKxzjRmvF5TrWYkgvCToObfVFINkkCtIO0gl8zkdJKtO12JPbaf?=
 =?iso-8859-1?Q?E5ICC8GqPLHikMQnGOMErITUSXahgMw0yivmUdN3BQGfnOSc74gA1Iq3kJ?=
 =?iso-8859-1?Q?DnlRyBpO8inE5/yDLKLlwrmruT4sjNejlPLF7qRtZ0vcGk7CReZwdUEyzx?=
 =?iso-8859-1?Q?mluW3EF8W+7GOX9U+68RQyyNBrwXPYSnClua4AEyGEbYA/MefH4JD5rH+V?=
 =?iso-8859-1?Q?U3jL7HrYaCjqVEUx0E3TDE61kN2rPdgIGB3iSCQ5vehCCkrHETTh25grXm?=
 =?iso-8859-1?Q?sgOKimu1HNfVbfYIf75R/k/dta4s0bFkFYE3u/98eWrwHuijZFy9gpwOPx?=
 =?iso-8859-1?Q?FvDSIzMYlzX2PfmvjMKnVH8kljTDLXI11tr39yhgeIyMeahJuYPbpiR1cv?=
 =?iso-8859-1?Q?0/oRYNWahZU8aHE1sKjqPD8SfIuLzVTd0IxI2k1nsaOcst5wVINehzqRgC?=
 =?iso-8859-1?Q?ybhXXNXf1kwLh+KonRWRgbClz1s1jxN/A1TUm4skWCBT5WqOFq/QU/vjDC?=
 =?iso-8859-1?Q?+M43lkmoNL1GfJBNLh2Mufu0RPrA5yj0VwwnUd6lFmpuuY1IIpjpe+FRv7?=
 =?iso-8859-1?Q?YzAD9QmnBc+VdZnxVOYf+wLFrkzi6UGTyKp383sVXHzBUUK8qW5dM7Mjc5?=
 =?iso-8859-1?Q?OS+1udMh4PbFD5svCdWdqzgo0QRs1Chu43e4/OHr9vYFGZ6qbBV1/PYolO?=
 =?iso-8859-1?Q?Xo25LvGexGM6fU7WUvASUh1Wnh+xlOhWZ1hup418Xat3xDUdg7oCch2wq9?=
 =?iso-8859-1?Q?InsAVsGnrj9v97REuxbtGrkY0jvnA5V732SjYcDmJEqNS56s9wqBgdpm2G?=
 =?iso-8859-1?Q?1GAD3mgJskXyf2nqzCfenboycaFlZmf5xvbZQgaH6K1Tpjd7VBWq5doWGc?=
 =?iso-8859-1?Q?cp7JDAgqOQTu7PfJdYrCPxa0UpZyti1zgLIMfydyRX9+5y268RZB7imXyS?=
 =?iso-8859-1?Q?FhnGW5cBh4bdpgnEZf+L32tBZBnmMCI3gnlK0K2XFveTp4V1MTEZqujEp/?=
 =?iso-8859-1?Q?RSwECOAZuOuT2maiAe4qfUHcJeYNEmFjq3+J0Mgn4GPfdPryRqh1rbf3NR?=
 =?iso-8859-1?Q?9iTNOHJpyg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a919d89-3d2b-40ca-8da0-08de519f0afa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:54:26.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/gDP4ZMsWd4FCXqjoMjdTrGZaDAfhB5pidU5gCanNdALa6jrjwZeiNkfW7XzgrLUUc4axJzbCKe6LKgdeTejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com



Hello,

for this change, we reported
"[paulmckrcu:dev.2025.12.16a] [rcu]  1ac50ec628: stress-ng.memfd.ops_per_sec 3.4% improvement"
in
https://lore.kernel.org/all/202601071316.992a1d32-lkp@intel.com/

now we notice this commit is in linux-next/master.

we still catpure similar improvement as below. at the same time, we notice a
regression in another stress-ng test.

we don't have enough capability to analyze if this change really has performance
impact or just the code footprint change and the corresponding cache line change
impact these stress-ng tests.

since data is stable, we just report out FYI. please educate us if this report
is less meaningful. thanks


kernel test robot noticed a 7.1% regression of stress-ng.fd-abuse.ops_per_sec on:


commit: c27cea4416a396a1c5b6b3529dd925f92a69e7d3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master f417b7ffcbef7d76b0d8860518f50dae0e7e5eda]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: fd-abuse
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.memfd.ops_per_sec 3.5% improvement                                     |
| test machine     | 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=memfd                                                                                  |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601121044.6d8b5bac-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260112/202601121044.6d8b5bac-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/fd-abuse/stress-ng/60s

commit: 
  v6.19-rc1
  c27cea4416 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")

       v6.19-rc1 c27cea4416a396a1c5b6b3529dd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     35053 ± 14%    +133.6%      81881 ±126%  numa-meminfo.node0.Shmem
      8763 ± 14%    +133.8%      20487 ±126%  numa-vmstat.node0.nr_shmem
 2.404e+09            -7.1%  2.234e+09        stress-ng.fd-abuse.ops
  40118365            -7.1%   37281947        stress-ng.fd-abuse.ops_per_sec
    147.78            -6.9%     137.58        stress-ng.time.user_time
     94705 ±  2%      -4.7%      90252        proc-vmstat.nr_slab_reclaimable
    565933            -3.3%     547436        proc-vmstat.nr_slab_unreclaimable
   6030483 ±  2%      -6.0%    5669811        proc-vmstat.numa_hit
   5766412 ±  2%      -6.3%    5405494        proc-vmstat.numa_local
   8618500 ±  2%      -7.1%    8009296        proc-vmstat.pgalloc_normal
   6877608 ±  4%      -8.6%    6283782 ±  2%  proc-vmstat.pgfree
      0.28            -7.8%       0.26        perf-stat.i.MPKI
  2.52e+10            -2.2%  2.464e+10        perf-stat.i.branch-instructions
  27782554           -10.8%   24789456        perf-stat.i.cache-misses
 1.509e+08 ±  5%      -7.8%  1.391e+08        perf-stat.i.cache-references
      8.10            +2.7%       8.31        perf-stat.i.cpi
     34826           +13.6%      39567        perf-stat.i.cycles-between-cache-misses
 1.099e+11            -2.6%  1.071e+11        perf-stat.i.instructions
      0.13            -2.5%       0.12        perf-stat.i.ipc
      0.25            -8.6%       0.23        perf-stat.overall.MPKI
      8.18            +2.7%       8.39        perf-stat.overall.cpi
     32484           +12.3%      36472        perf-stat.overall.cycles-between-cache-misses
      0.12            -2.6%       0.12        perf-stat.overall.ipc
  2.48e+10            -2.2%  2.425e+10        perf-stat.ps.branch-instructions
  27233991           -10.9%   24262443        perf-stat.ps.cache-misses
 1.479e+08 ±  5%      -7.8%  1.363e+08        perf-stat.ps.cache-references
 1.082e+11            -2.6%  1.054e+11        perf-stat.ps.instructions
 6.605e+12            -2.5%  6.443e+12        perf-stat.total.instructions
      1.75            -0.1        1.63        perf-profile.calltrace.cycles-pp.stress_fd_lseek
      0.56 ±  2%      -0.1        0.45 ± 37%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_fd_lseek
      0.58 ±  2%      -0.0        0.54 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_fd_lseek
      2.20            +0.0        2.21        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup.shmem_zero_setup_desc
     49.74            +0.1       49.83        perf-profile.calltrace.cycles-pp.__mmap
     49.71            +0.1       49.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     49.70            +0.1       49.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     47.24            +0.1       47.34        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     47.24            +0.1       47.35        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     47.19            +0.1       47.30        perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.09            +0.1       47.21        perf-profile.calltrace.cycles-pp.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
     46.81            +0.1       46.93        perf-profile.calltrace.cycles-pp.new_inode.__shmem_get_inode.__shmem_file_setup.shmem_zero_setup.__mmap_new_vma
     47.01            +0.1       47.13        perf-profile.calltrace.cycles-pp.shmem_zero_setup.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
     47.01            +0.1       47.13        perf-profile.calltrace.cycles-pp.__shmem_file_setup.shmem_zero_setup.__mmap_new_vma.__mmap_region.do_mmap
     46.89            +0.1       47.01        perf-profile.calltrace.cycles-pp.__shmem_get_inode.__shmem_file_setup.shmem_zero_setup.__mmap_new_vma.__mmap_region
     48.80            +0.1       48.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode
     47.17            +0.1       47.30        perf-profile.calltrace.cycles-pp.__munmap
     47.16            +0.1       47.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     47.16            +0.1       47.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     46.74            +0.1       46.87        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup.shmem_zero_setup
     47.00            +0.1       47.14        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.98            +0.1       47.12        perf-profile.calltrace.cycles-pp.__dentry_kill.finish_dput.__fput.task_work_run.exit_to_user_mode_loop
     48.89            +0.1       49.03        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup
     47.01            +0.1       47.15        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     46.62            +0.1       46.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.finish_dput
     46.98            +0.1       47.13        perf-profile.calltrace.cycles-pp.finish_dput.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64
     47.01            +0.1       47.15        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     46.77            +0.1       46.92        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.finish_dput.__fput
     46.88            +0.1       47.02        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.finish_dput.__fput.task_work_run
      1.76            -0.1        1.63        perf-profile.children.cycles-pp.stress_fd_lseek
      0.44            -0.0        0.41        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.47            -0.0        0.44        perf-profile.children.cycles-pp.llseek
      0.24            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__inet_listen_sk
      0.20            -0.0        0.19        perf-profile.children.cycles-pp.__vm_munmap
      0.20            -0.0        0.19        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.11            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__sys_listen
      0.11            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__x64_sys_listen
      0.20            -0.0        0.19        perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.inet_csk_get_port
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.__get_unmapped_area
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.__x64_sys_pselect6
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.alloc_inode
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.rcu_core
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.run_ksoftirqd
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.smpboot_thread_fn
     98.70            +0.1       98.79        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     49.76            +0.1       49.85        perf-profile.children.cycles-pp.__mmap
     98.63            +0.1       98.73        perf-profile.children.cycles-pp.do_syscall_64
     49.68            +0.1       49.78        perf-profile.children.cycles-pp.vm_mmap_pgoff
     49.66            +0.1       49.76        perf-profile.children.cycles-pp.do_mmap
     49.55            +0.1       49.66        perf-profile.children.cycles-pp.__mmap_region
     47.17            +0.1       47.28        perf-profile.children.cycles-pp.__mmap_new_vma
     47.01            +0.1       47.13        perf-profile.children.cycles-pp.shmem_zero_setup
     47.25            +0.1       47.37        perf-profile.children.cycles-pp.__munmap
     49.22            +0.1       49.35        perf-profile.children.cycles-pp.__shmem_file_setup
     47.07            +0.1       47.20        perf-profile.children.cycles-pp.__fput
     49.10            +0.1       49.23        perf-profile.children.cycles-pp.__shmem_get_inode
     49.02            +0.1       49.15        perf-profile.children.cycles-pp.new_inode
     48.94            +0.1       49.08        perf-profile.children.cycles-pp.inode_sb_list_add
     47.03            +0.1       47.17        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     46.98            +0.1       47.13        perf-profile.children.cycles-pp.__dentry_kill
     46.98            +0.1       47.13        perf-profile.children.cycles-pp.finish_dput
     47.01            +0.1       47.15        perf-profile.children.cycles-pp.task_work_run
     46.88            +0.1       47.02        perf-profile.children.cycles-pp.evict
     95.49            +0.3       95.75        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     95.75            +0.3       96.03        perf-profile.children.cycles-pp._raw_spin_lock
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.do_syscall_64
      0.23            -0.0        0.22        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15            -0.0        0.14        perf-profile.self.cycles-pp.llseek
     95.08            +0.3       95.35        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-srf-2sp2: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/memfd/stress-ng/60s

commit: 
  v6.19-rc1
  c27cea4416 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")

       v6.19-rc1 c27cea4416a396a1c5b6b3529dd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    257709           +47.4%     379897        meminfo.AnonHugePages
    185.79           +48.4%     275.65        boot-time.boot
     35229           +49.0%      52482        boot-time.idle
    279.39           +32.1%     369.06        uptime.boot
     41662           +41.3%      58880        uptime.idle
    107491            -3.7%     103488        stress-ng.memfd.nanosecs_per_memfd_create_call
    193402            +3.5%     200220        stress-ng.memfd.ops
      3224            +3.5%       3338        stress-ng.memfd.ops_per_sec
  99066540            +3.5%  1.026e+08        stress-ng.time.minor_page_faults
    190038            +1.7%     193305        proc-vmstat.nr_anon_pages
    125.88           +47.4%     185.50        proc-vmstat.nr_anon_transparent_hugepages
     39831            -3.0%      38648        proc-vmstat.nr_kernel_stack
 1.525e+08            +3.5%  1.579e+08        proc-vmstat.numa_hit
 1.523e+08            +3.5%  1.577e+08        proc-vmstat.numa_local
 1.629e+08            +3.6%  1.688e+08        proc-vmstat.pgalloc_normal
  99551866            +3.5%   1.03e+08        proc-vmstat.pgfault
 1.622e+08            +3.6%  1.681e+08        proc-vmstat.pgfree
    247638           +36.3%     337493        sched_debug.cpu.clock.avg
    247674           +36.3%     337526        sched_debug.cpu.clock.max
    247599           +36.3%     337457        sched_debug.cpu.clock.min
    247436           +36.3%     337285        sched_debug.cpu.clock_task.avg
    247527           +36.3%     337377        sched_debug.cpu.clock_task.max
    241459           +36.8%     330354        sched_debug.cpu.clock_task.min
    247600           +36.3%     337458        sched_debug.cpu_clk
    247342           +36.3%     337200        sched_debug.ktime
    248152           +36.1%     337703        sched_debug.sched_clk
      2.25            +1.5%       2.29        perf-stat.i.MPKI
 1.644e+10            +1.9%  1.675e+10        perf-stat.i.branch-instructions
      0.24 ±  4%      +0.0        0.25        perf-stat.i.branch-miss-rate%
  38026731 ±  5%      +9.0%   41438665        perf-stat.i.branch-misses
 1.712e+08            +3.6%  1.774e+08        perf-stat.i.cache-misses
 2.891e+08            +3.3%  2.987e+08        perf-stat.i.cache-references
      7.88            -2.0%       7.72        perf-stat.i.cpi
    294.71            +2.6%     302.24        perf-stat.i.cpu-migrations
      3506            -3.5%       3385        perf-stat.i.cycles-between-cache-misses
 7.629e+10            +2.1%  7.785e+10        perf-stat.i.instructions
      0.13            +2.1%       0.13        perf-stat.i.ipc
     17.00            +3.5%      17.60        perf-stat.i.metric.K/sec
   1632141            +3.5%    1689961        perf-stat.i.minor-faults
   1632141            +3.5%    1689961        perf-stat.i.page-faults
      2.25            +1.5%       2.28        perf-stat.overall.MPKI
      0.23 ±  4%      +0.0        0.25        perf-stat.overall.branch-miss-rate%
      7.91            -2.0%       7.75        perf-stat.overall.cpi
      3521            -3.4%       3401        perf-stat.overall.cycles-between-cache-misses
      0.13            +2.0%       0.13        perf-stat.overall.ipc
 1.618e+10            +1.8%  1.648e+10        perf-stat.ps.branch-instructions
  37315073 ±  5%      +9.1%   40712563        perf-stat.ps.branch-misses
 1.686e+08            +3.5%  1.745e+08        perf-stat.ps.cache-misses
 2.849e+08            +3.2%  2.941e+08        perf-stat.ps.cache-references
      6628            +1.1%       6704        perf-stat.ps.context-switches
    288.02            +2.7%     295.69        perf-stat.ps.cpu-migrations
 7.506e+10            +2.0%  7.657e+10        perf-stat.ps.instructions
   1606028            +3.5%    1662399        perf-stat.ps.minor-faults
   1606028            +3.5%    1662399        perf-stat.ps.page-faults
     45.98            -0.3       45.73        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup
     46.05            -0.3       45.80        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create
     45.86            -0.2       45.61        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.__shmem_get_inode
     46.28            -0.2       46.03        perf-profile.calltrace.cycles-pp.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.19            -0.2       45.94        perf-profile.calltrace.cycles-pp.new_inode.__shmem_get_inode.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64
     46.54            -0.2       46.30        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     46.49            -0.2       46.25        perf-profile.calltrace.cycles-pp.__shmem_file_setup.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     46.54            -0.2       46.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.memfd_create
     46.56            -0.2       46.33        perf-profile.calltrace.cycles-pp.memfd_create
     46.53            -0.2       46.30        perf-profile.calltrace.cycles-pp.__x64_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.memfd_create
     45.51            -0.2       45.29        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.finish_dput.__fput
     45.34            -0.2       45.13        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.finish_dput
     46.33            -0.2       46.15        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.finish_dput.__fput.task_work_run
     46.54            -0.2       46.36        perf-profile.calltrace.cycles-pp.finish_dput.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64
     46.67            -0.2       46.48        perf-profile.calltrace.cycles-pp.close_range
     46.54            -0.2       46.36        perf-profile.calltrace.cycles-pp.__dentry_kill.finish_dput.__fput.task_work_run.exit_to_user_mode_loop
     46.62            -0.2       46.44        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.67            -0.2       46.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
     46.67            -0.2       46.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close_range
     46.64            -0.2       46.46        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
     46.64            -0.2       46.46        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
      1.03            +0.0        1.05        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      1.28            +0.0        1.31        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_memfd_child
      1.00            +0.0        1.02        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.12            +0.0        1.15        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      0.78 ±  2%      +0.0        0.82        perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.__dentry_kill.finish_dput.__fput
      0.75 ±  2%      +0.0        0.79        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill.finish_dput
      0.87            +0.0        0.91 ±  3%  perf-profile.calltrace.cycles-pp.__mmap_region.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.88            +0.0        0.92 ±  3%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.09            +0.1        1.15 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.10            +0.1        1.17 ±  2%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.12            +0.1        1.18 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.12            +0.1        1.19 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.07            +0.1        1.14 ±  3%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.30            +0.1        1.37 ±  2%  perf-profile.calltrace.cycles-pp.__mmap
      0.60 ±  4%      +0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      1.16 ±  3%      +0.2        1.35 ±  7%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1.71 ±  2%      +0.2        1.93 ±  5%  perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74 ±  2%      +0.2        1.97 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.26            +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.25            +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.72 ±  2%      +0.2        1.95 ±  5%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.24            -0.5       91.78        perf-profile.children.cycles-pp._raw_spin_lock
     46.05            -0.3       45.80        perf-profile.children.cycles-pp.inode_sb_list_add
     46.28            -0.2       46.03        perf-profile.children.cycles-pp.__shmem_get_inode
     46.19            -0.2       45.94        perf-profile.children.cycles-pp.new_inode
     46.49            -0.2       46.25        perf-profile.children.cycles-pp.__shmem_file_setup
     46.54            -0.2       46.30        perf-profile.children.cycles-pp.__x64_sys_memfd_create
     46.57            -0.2       46.34        perf-profile.children.cycles-pp.memfd_create
     92.33            -0.2       92.11        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.82            -0.2       46.63        perf-profile.children.cycles-pp.evict
     47.03            -0.2       46.84        perf-profile.children.cycles-pp.finish_dput
     47.03            -0.2       46.84        perf-profile.children.cycles-pp.__dentry_kill
     47.11            -0.2       46.92        perf-profile.children.cycles-pp.__fput
     46.65            -0.2       46.46        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     46.65            -0.2       46.46        perf-profile.children.cycles-pp.task_work_run
     46.67            -0.2       46.49        perf-profile.children.cycles-pp.close_range
     97.54            -0.1       97.44        perf-profile.children.cycles-pp.do_syscall_64
     97.56            -0.1       97.46        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.24 ±  2%      -0.0        0.23        perf-profile.children.cycles-pp.xas_store
      0.19 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.truncate_inode_folio
      0.54            -0.0        0.53        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.__filemap_remove_folio
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.mas_walk
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.17            +0.0        0.18        perf-profile.children.cycles-pp.do_ftruncate
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.notify_change
      0.31            +0.0        0.32        perf-profile.children.cycles-pp.llseek
      0.23            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.ftruncate64
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.03            +0.0        1.05        perf-profile.children.cycles-pp.handle_mm_fault
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.unmapped_area_topdown
      0.46            +0.0        0.48        perf-profile.children.cycles-pp.run_ksoftirqd
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      1.00            +0.0        1.02        perf-profile.children.cycles-pp.__handle_mm_fault
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.rcu_core
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.shmem_get_unmapped_area
      0.32            +0.0        0.34        perf-profile.children.cycles-pp.unmap_page_range
      0.30            +0.0        0.32        perf-profile.children.cycles-pp.zap_pmd_range
      0.20 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.zap_page_range_single_batched
      0.28            +0.0        0.31        perf-profile.children.cycles-pp.zap_pte_range
      0.23            +0.0        0.26        perf-profile.children.cycles-pp.unmap_mapping_range
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.15            +0.0        0.18        perf-profile.children.cycles-pp.perf_event_mmap
      0.14            +0.0        0.17        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.21            +0.0        0.24        perf-profile.children.cycles-pp.zap_page_range_single
      1.44            +0.0        1.47        perf-profile.children.cycles-pp.asm_exc_page_fault
      0.78 ±  2%      +0.0        0.82        perf-profile.children.cycles-pp.shmem_evict_inode
      0.87            +0.0        0.91 ±  3%  perf-profile.children.cycles-pp.__mmap_region
      0.88            +0.0        0.92 ±  3%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.shmem_recalc_inode
      1.07            +0.1        1.14 ±  3%  perf-profile.children.cycles-pp.do_mmap
      1.10            +0.1        1.17 ±  2%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.09            +0.1        1.16 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.30            +0.1        1.38 ±  2%  perf-profile.children.cycles-pp.__mmap
      0.41 ±  3%      +0.1        0.51 ± 11%  perf-profile.children.cycles-pp.__folio_batch_release
      0.41 ±  3%      +0.1        0.51 ± 11%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.41 ±  3%      +0.1        0.51 ± 11%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.51 ±  4%      +0.1        0.65 ± 11%  perf-profile.children.cycles-pp.__page_cache_release
      1.11 ±  3%      +0.1        1.24 ±  4%  perf-profile.children.cycles-pp.folios_put_refs
      1.71 ±  2%      +0.2        1.93 ±  5%  perf-profile.children.cycles-pp.shmem_fallocate
      1.74 ±  2%      +0.2        1.97 ±  5%  perf-profile.children.cycles-pp.__x64_sys_fallocate
      1.72 ±  2%      +0.2        1.95 ±  5%  perf-profile.children.cycles-pp.vfs_fallocate
      0.66 ±  4%      +0.2        0.89 ± 14%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.70 ±  4%      +0.2        0.93 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.92 ±  2%      +0.2        2.15 ±  5%  perf-profile.children.cycles-pp.shmem_undo_range
     91.97            -0.2       91.76        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.mas_walk
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.entry_SYSCALL_64





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


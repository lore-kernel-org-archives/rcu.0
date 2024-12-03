Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC405645;
	Tue,  3 Dec 2024 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205817; cv=fail; b=UKqV7Ew7VfAOVGG+C1Hl9u3sq3VOiEjOmdhzvlGf3GwahR9G0uR8XQP93SPjwwIrQRVRg65S3uk4IsU9phbyOnTpmy9xIFl4gC/GH68m78lk5zWxvChzogPjLv3pNjajh9peGKuDGxnyFwphuodD9Y3ABmK5BWnBFyqYCHkgJyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205817; c=relaxed/simple;
	bh=1qZ/pDlW0vqKAjqFiSaHRa+392213hw1cooSciIKIKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LuHsqIdGx/rzqIqV/M05yeIlZ2mVOe/MAnVWtGuL13KTxnaT/O0d7NwTurPiO7PATUn2bNCeZLPCMSOVapW0/abxv7J/JU7di4sAPrd1AxeBMfkrvalCS0CB4PH+t1gf1V2Q/mYll9Bg7/DqPnpXOfyIntCFS+oHlXdgmKVdMtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qcxc/C2m; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qcxc/C2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733205814; x=1764741814;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1qZ/pDlW0vqKAjqFiSaHRa+392213hw1cooSciIKIKY=;
  b=Qcxc/C2mCuqeTrRPVkEoFYAajtEVhQ8C9FLF7CspFNJ4rOBo95VZLBTN
   Y7lffhTTCyriYjijB8ZlVdK+CYCMQICstA77Dh6KGDMj95AGLKaLBTric
   vFCa3BgTvs32Yc5wtgZP7zJvPZqOxlQA7tKE6Au6HLcQxxN13MSNZ/I/L
   7D+vSFtSvTfkdVNE/ZJA5SVI1HhIFITEeg870nvDezUrfKJaNmzpjVMDh
   8FDNu6b/O9lfQMRczbEQbsdRk2/hsYeKyzL/Oqk9eDecgC52bwG6BL04M
   /Y274+mURHi1RgVlRGJgPxO8q1jSUWIjS5syyliJ4NavmRHQ5PCPZuyyN
   g==;
X-CSE-ConnectionGUID: 7/OTZmYwQMGZRkKrrlVk4w==
X-CSE-MsgGUID: ze3pvAIGRRGbJAGbAQU8sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37177035"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="37177035"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:03:33 -0800
X-CSE-ConnectionGUID: s4VRnzdoSXqtD7LRHPVyyA==
X-CSE-MsgGUID: dNOOBnzvTRqM5PnREXyoPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93221860"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 22:03:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 22:03:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 22:03:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 22:03:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWQi5Jxgv8ELFi8uIUgoy4OJ1XYmAFX7yCIMDQYyRbnkaw850hCxbWDg7PYIeJpvEEF7KTA8PWeVD2OQdT5qkKWUJ3osMYqZOOreqeyPwfiVpdcYUUqj5Ao3ICmro9uVGLfDk+R5t2DKPrMdlj2xcbQ0X5fpe5ggKQ44ifIwLykPrqbykajzKhU8ZUEH/oBRkHkuvU5pe7Gi2/YsBfIsEjLkqEBPvojxuZDYeneZci6pXt6y2JZ7AjY+6ufv6M0NqwSpk5K65MxLqnFKspbGHuYeNPpK+a1XipL4HA6NqQpsoH0Ml9nv9jBQ5foXdPBl9MlXCFJPiN812Mi4JMrNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uh8CJJcYukjQJIPhwqN0/clMRlGdWVM+Dzi5j6jRxQ=;
 b=BU8WbfUEAPGZl0n9YzBG8vCSetUfj8rJ3jeRIJisriCduIvHOGXSuQkJnWfmDoJKHNmNA2TsCiljpMNbDSgIDb09mLf/IZE4jpQEwjMczPywQs72gkGRwsN6VnvVhsO8LGRVZjbD1/JfS1dpoRbEZiHegC1ble3YQUiAEDSRR2grnjedotZACwKJbiKDp5DS7mXNcuIy86ojiP3qVX2uC7Y1/eDU7rZiBnKQd1aZ+cXEfGxaIusMVrXfgCSYJonTuhk4TPn84VWoUJKG5gr6qIY7XrO8i+xphvB3r3w726pvfBRJ6X6wECDBWdnHZ7irxHjQ1NEj75IOpPexnGe+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 06:03:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:03:28 +0000
Date: Tue, 3 Dec 2024 14:03:20 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
	lkp <lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [sched, x86]  476e8583ca:
 WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity
Message-ID: <Z06fKEb59TFYWrm1@xsang-OptiPlex-9020>
References: <202411252253.e39d77c6-lkp@intel.com>
 <20241126143024.EKo6QfKL@linutronix.de>
 <9f5409d1-82c5-459c-a9cc-416e7320e044@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f5409d1-82c5-459c-a9cc-416e7320e044@paulmck-laptop>
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df6e19d-359f-4065-44a0-08dd1360351f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjdpZ2M5cnJLelVNS21nQ3RhYWtvYkRNR0wrVWxDalV6bzhXcmdYdVVIN1B0?=
 =?utf-8?B?a2hWazE5eGRQSWVGQ2pLMElDOEhrbVpiQlJIa2RvZGJWRjJjNVcvNjFDaEw2?=
 =?utf-8?B?K0NObVl1SkRnNUdqR2xuV2Iwa1gzVVZwQXM3ZTRMc3BFbEEyLzFCR3hpd3hx?=
 =?utf-8?B?dFAyaDd1akpQT1RQZG5vdzlpQkVycmRJcFBhRWVoOTVJdDQ5M3JtQVcrcWI4?=
 =?utf-8?B?UHY0c05vZEtXc3E0czVqRzBHN1lSTzlYeGRTdGJpaWdGU0hSeTRONFRQQ1BW?=
 =?utf-8?B?eVlvcUZuZHlwZ2xhanpLVExtUXh3UVdMMFpqSHVnQjUyODVVUEZ2RDVUTGp0?=
 =?utf-8?B?Q2U5cjBPYVdHNG1lVGMrcFUzeElzSERCU2xvZTJmVzVTajJxNnkzNEF1Y3U1?=
 =?utf-8?B?TzUwd2NqbkFIOGd5dWxpRGpjNkRiWkZMQitHWm8zNjNJSW8ydm9ITlNSV2NQ?=
 =?utf-8?B?VDNQTXdkRTMxSjN5VUQ5ZDZqVk11SSs3V0JPNUVWNDFTcVNjVnZIOFJzNHRi?=
 =?utf-8?B?NWtOVm9FYi9BOVFkRksvZHQrT1dQbzZESVZGOUZLaDZMV0F4VU9IZ1V3NDYv?=
 =?utf-8?B?bEY2TzZ3V1hmVzl1Q08ydFQ0U3h3dnFzcHJwblRaaTBEWjRKT2JPZEsvRGxh?=
 =?utf-8?B?NGgwV0NGMnp4Nll3blFsZlNGeXJpUG00akdIYXB1cStBSFp2Z1l6TWZuQk5h?=
 =?utf-8?B?dWkvMWNqTEtmWHR5UUJvYmxYajNZOUw3QjB4UGs2dGJxQWlnNUpGL29CMVpo?=
 =?utf-8?B?anBlcmxCNExac0V5dGM5bUNVZ3Jib3ZRRVhSTm04ZGlyTmRPS0FUSjk4WlJt?=
 =?utf-8?B?bDFSa3Ivd2xtaGVmOEExdlZvVnVRZGtYQW1UNXg2MmVVVmhTWlZ6dDQ1Z2Jk?=
 =?utf-8?B?amNVZnp0cFJFVnlTZXk4dk9raFB0ZGpkRXNrWklDa0NNYytpbVVEdUwxakJa?=
 =?utf-8?B?TDB5bFlEMFI2QWRsazFHWElqR2VVL3RGb0ZtTEVTUHBtRjE0MDVMeTZyOEw4?=
 =?utf-8?B?emxFRU9aUzg4Yys3Zk1WYy91MHVKbFM4dWJhSnJ0czZpNWFMTUFveXA1c2xt?=
 =?utf-8?B?eTNtU2J4bFVjckZ0ajQyYnpKUGFRVXZZRC9qS2JXNWVlam1vN3JCdWNFOS9t?=
 =?utf-8?B?dnp5ZXUzZWhWRGdoWWRZVzNVTzZGYjdtbUZFcFZMR2JmeFFxYUc1QzhxOVVV?=
 =?utf-8?B?VVMwVnpTQjJhelpydk5ndVJXVkMyeDI5aGhmcDcwcVZjY0pqcGg3RFdCWVJj?=
 =?utf-8?B?UGU1VkFJYStQTHpiWjl2RHl1aHhKSzQxcFdmdXVYWVZmcThSaFUzbjh6TThz?=
 =?utf-8?B?cmFwbjQ5c0xJYjdtMWVoenJIZXhBL1VSRTU2SzNUWVlMR1NmS2dUOG1OU2Vi?=
 =?utf-8?B?TFJYTURHK0V3UFFSamtPbk52aEU2SjZ2RzFZT0xRaDNKU05sWlpEYjlVOE0y?=
 =?utf-8?B?ekJmM2xwZUswbTFNN0Z3NEcydHNpTllXU281NjNpN1d4WTVvQ3lUUmhWUWFK?=
 =?utf-8?B?MjMvd01TUnFDTDNxWWRvRU1TbkR4K1EwYktCSHh2RlpPV25LdUFGWjc3YXVI?=
 =?utf-8?B?NmJZdFhDemJlTkV2a1NOVFQ3cnN5UTM2OTI4ejJPdlZ2WldpNVZ0NjBTaVNr?=
 =?utf-8?B?NUQySFVGelB4VDRjZTJoRmIrTmtSa2xBMldDYTFORU9aU0hyNEZZRmVZaXlz?=
 =?utf-8?B?U2ZlSkJBR1dyYVlYUXlrbHFMZjRzMU9STVZZdklHZFpLVzdxeU12NGVGNnpz?=
 =?utf-8?B?cWYrelI5SFNpVCtRaDZHblc3Mm5MaENMeGs4OHBxRnBoSG5NQ1lTVVBacEVU?=
 =?utf-8?B?cHdleitybXJpeGJITXIzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNaMVU2U0hjVzZneVIzaUFsNjE2NE1VVHZZelJhaHdOY0JJc0h3MzZ5bVc4?=
 =?utf-8?B?cWMxTGV5ZG93NkJNR0dqbDdhSFRZUmt5YkpONjBZdDlNVXYxbHEveVpqbHZp?=
 =?utf-8?B?YWFZN2tvUFlDYjJOaGlqSkJFOVlsTDIzUXF6dGlGeTRPSSsvODc0bmEvYnNH?=
 =?utf-8?B?ckxidklySllJUUlTQXhCK2tqZ0ljaWxsNGRHeXpUem8xcjJUdU5ybUxMREcv?=
 =?utf-8?B?a2l1MnVsYW5pbDN1M0h2VHp6bTZlRndrSkZEVWVyVUtqcTBFbW9IN1JKNTlm?=
 =?utf-8?B?dlY1RlpEejZoZ29MWFJjRXV1bUYrbWxMWFpTakJYY09BVEJmWk5zZWZBOFhX?=
 =?utf-8?B?Zk55Y2VCdUc4YmwxN0dyQzdhQlUwemYxbWVHVmFHc0p1OGVFY0ZrQlZKb0E0?=
 =?utf-8?B?L1ZFd0ZsK2xWRE53N3IrR3FRS2E0clg4WERuYmJYa3E5VmxOdjMxN1FRb2RQ?=
 =?utf-8?B?QkJyQ29mYldKdWxhWHlnMEF6ODh0b25KenBPRWtLWkNuVUlpWjRCNXI4NHE5?=
 =?utf-8?B?WUppY01GeC9MTXdBdFVkMVRCNkFFZ0pGTVBYbnJUekdiL3lyaUhCbzkrallx?=
 =?utf-8?B?VERwY2VIWVdpWjNEelQxWmpDMjhLcUsyZTNNRjNtejJ1VzBWOWhNVjZORWZh?=
 =?utf-8?B?NGtwR2d0b1RFazFwMlhJS3lVZ0c1R0FZY2hCd2JrSDkrQ2xkWjdEcXcrZVZX?=
 =?utf-8?B?ZWh1UnUxQ3BsUE44dTZQdSt6N2xJQnNaUE5CWnN3TnhWQmhLaExDcVV3RkFO?=
 =?utf-8?B?b1h6ak1XMG11eCsza1U3dGdVNVNRZ1Q1Q2w2azNFNFBNNGkvdTBhNVBYMDRl?=
 =?utf-8?B?MEw2MUs2empqNVdMTUVIeW91dnQzNkRuSGsxdTRmeEl2dnpSWG0zNjlrSWxB?=
 =?utf-8?B?WnV4S0FiL2FxbnU3ZzArdTR6MnJtYktiU1RCZElTYTBuRHluc1VxdkVsb2FI?=
 =?utf-8?B?MWtuTCtiNWk5RzlmU0Z6M05BZkxTbGlRaWFIZnNLck1rVVAzZE41RDlvWXJr?=
 =?utf-8?B?Q1RoOCtXVUVLU3E4SURJZk9seDIvaXEvdkpVV01PdzNWWWJFUkZvdXloekRs?=
 =?utf-8?B?YjhXSW40Vi9mdlJxczQ5YnRHSkVSdnZUbTNabGk4aTZKaFB5OHFFT2xrRkJj?=
 =?utf-8?B?VlI1WWZvZXNoNG1OVm5Nd0o5MjNhRTZoalhDNldHUlRHeTBNZUV3aVBFS01J?=
 =?utf-8?B?M3dYMERYeDFQQVVicXZwVDgrV3pIK1kyNmZpSlY0UmlZT2p6QXJNeDZKVklD?=
 =?utf-8?B?dDBZdGlWNmxkQ2RGQVUrclRrRzliekdwY3FrU1Q2WDZPcjdudXY3RnRudHU2?=
 =?utf-8?B?K3FuS20rb3IwUFlXTWdBb1pCcDRFY1VscWloam5TZGlUTmRJMTlsaklhUlo5?=
 =?utf-8?B?NW5MRUF1dGJ5emI5YzllQTJKMHh3cTc0eUxSV29UMGVnSWw4N0xSWG1WUWhR?=
 =?utf-8?B?aEQwaFE4RXcvenkrVFhSaDlyNm1sazBhYjlEdUV0S1lEODViOVhVRHNHUFEy?=
 =?utf-8?B?Q3lUMTg4NGpPN0UrTFFSQmFJWDVVdDRESTVtQ2J0L3lycElObjVoWDlFYTZn?=
 =?utf-8?B?NkRLUC9aVFVHVnNTU0w0djF0S3FSalAzNXBXdys1RzZQZnp0WUdackk3WVhn?=
 =?utf-8?B?Q2YrenFUZVVaT3d4S2VWTjdaS1NmY2lIMjQ3UEdnSVdYZEFLRmJkZ1VnYnZt?=
 =?utf-8?B?UHRuaGMwQjZ4eGhmNnlkQW5BRVEweC9HNUZvYmtxNG85THBPdCtTSlM4M0Js?=
 =?utf-8?B?RkZKTDVxckZ3N1hrY1ZHUFJRSlE3OWNJZlBUWTl6dmk5Q3ZGdlhjSmZJU2Rr?=
 =?utf-8?B?ZUxKUmF6OGhFc055SlhybUJpTklmMDhReWFMOGFDMmFKaEJjVW1keDdWZGZC?=
 =?utf-8?B?eXhSYlBtczkvQUs3a21MZWI2RHF4Q1JDMTByZjFqZEMrR3RPY2NlcHNPRHFM?=
 =?utf-8?B?ZkFDNnNnMEJ4U3o2WTFRNUV5YnFLeWZKQXBmZGltS25SZlFKL3pOK2JDdlhm?=
 =?utf-8?B?a2ZjdWpaSHBZaVJMeVFGV284blYrRHdTNVQxZ0dFR1BKMGRETUR5Yk5VY2x3?=
 =?utf-8?B?czJIei8vVTNyRmZkcUhrcnAvWjg2R0c4cmNRdlB6UjlkMHpPdXRCVHZiN1Jo?=
 =?utf-8?B?ZzZ6Z2hIMEFPeEM1bGNwQXZIeUpIZTBkOTVJM3hqUkducjBISEZyUVdxR1ZC?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df6e19d-359f-4065-44a0-08dd1360351f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 06:03:28.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UACHGedodIQWjpEY6RF23zxDxJr+zS+vNTiC5fEeNIRztM3+GVZW2DJLaUaISQtmJZtogvg89/CnwYtQqgHn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com

hi, Sebastian Andrzej Siewior, hi, Paul,

On Wed, Nov 27, 2024 at 12:17:49AM +0800, Paul E. McKenney wrote:
> On Tue, Nov 26, 2024 at 03:30:24PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2024-11-25 22:29:09 [+0800], kernel test robot wrote:
> > > Hello,
> > Hi,
> > 
> > > by this commit, we see the config has below diff:
> > > 
> > > --- /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/35772d627b55cc7fb4f33bae57c564a25b3121a9/.config   2024-11-22 17:03:32.458344665 +0800
> > > +++ /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/476e8583ca16eecec0a3a28b6ee7130f4e369389/.config   2024-11-22 17:02:59.440805587 +0800
> > > @@ -121,9 +121,11 @@ CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> > >  # end of BPF subsystem
> > > 
> > >  CONFIG_PREEMPT_BUILD=y
> > > -CONFIG_PREEMPT_NONE=y
> > > +CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> > > +# CONFIG_PREEMPT_NONE is not set
> > >  # CONFIG_PREEMPT_VOLUNTARY is not set
> > >  # CONFIG_PREEMPT is not set
> > > +CONFIG_PREEMPT_LAZY=y
> > >  # CONFIG_PREEMPT_RT is not set
> > >  CONFIG_PREEMPT_COUNT=y
> > >  CONFIG_PREEMPTION=y
> > > 
> > …
> > > commit: 476e8583ca16eecec0a3a28b6ee7130f4e369389 ("sched, x86: Enable Lazy preemption")
> > …
> > > 	runtime: 300s
> > > 	test: cpuhotplug
> > > 	torture_type: trivial
> > …
> > 
> > > [  150.797530][  T445] ------------[ cut here ]------------
> > > [  150.797915][  T445] torture_sched_setaffinity: sched_setaffinity(445) returned -22
> > > [ 150.798353][ T445] WARNING: CPU: 0 PID: 445 at kernel/rcu/update.c:535 torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
> > 
> > I've been staring at this, and this is actually fine. Your config changes
> > from CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_LAZY which implies
> > CONFIG_PREEMPTION. The trivial RCU test there does sched_setaffinity()
> > while preemption is enabled and CPU-hotplug runs in the background. So
> > you get what you expect either by an attempt to move to a CPU which is
> > no longer valid or by getting migrated to another CPU in the middle of
> > your operation.
> > 
> > This is all fine. You need to update your config file or your test.
> 
> Good point, and I suspect that there will be a few rcutorture scenario
> adjustments coming along shortly after -rc1 comes out.

thanks a lot for information!

we will fix our config and to avoid reporting against this commit.

> 
> 							Thanx, Paul

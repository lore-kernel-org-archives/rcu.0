Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B998831
	for <rcu@vger.kernel.org>; Fri,  9 Aug 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165554; cv=fail; b=C1/7PVxDM7FXNLjzJZs6UH/Ttfb8a1jHI0J1WccT/F2hWnENGWVvCAYhmWaPoq+s1hTLbmxB4jNbUN7k23ZNjuMcB00W4WSsbCWbVHB4apun46uaHgyhDmnMhKhKR0WCOwU03lJzNTf5zLYx+PxQ8VoK+xqozf4oxLZPzdpvwyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165554; c=relaxed/simple;
	bh=Dn/EOAtlU2nApv0uZhs1Eo+iYUSbcn7TkxLV0qQpvNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWf67VNjl3gfB6xPvFlo0c9QqXDdGev7/PI2VU4xnn9w9SDCqlEHeWgj1fkKUs13B4M7kralHNN4RpxgpfPS5ejV4D+DL5MkfMTptzU6Sd7HQf9ZsxBv0cJhSnZe01/k7JsggPaQImbjZZerhUOA1hV9yv7wG4sIst5UIg3Hk58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leo0A06D; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leo0A06D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723165553; x=1754701553;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Dn/EOAtlU2nApv0uZhs1Eo+iYUSbcn7TkxLV0qQpvNo=;
  b=leo0A06Dyr0u2fpD26nTwRTZzhJ1hIu7s6oLRDYdZEARmOIPh3KJfXju
   BGcRYn04YXPGTpFnsmwGMoYQ3eFHVfTWfxGcTukYD0knQDIgYW2Tz/frN
   6nxK7QS9J+Dnl6KV3nZ4GqTqwSIZ6/y4DBmUO1bsJVYZAJ+aEN81OorJt
   KPJBBG0AnhdEHqQ0rntsA4x4BYCoV0eRISl+WzT31JaNQChcueNB+Jm1G
   eYzyRXp4R0aKNZz953Dhgpzvte/ZdIPcntYvG6fGE8BNCMtYDK2Juy4Su
   HJbjJ0IxJK1WfU/QyntqseT4IiFiWr9lXe98sC/efu5+HhUxGACvqWlb1
   Q==;
X-CSE-ConnectionGUID: zjouWhk4Qo6a8SsNpbMvsQ==
X-CSE-MsgGUID: cTWtgMmZRpu2VQ+/ZjRizA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31998196"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="31998196"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:05:52 -0700
X-CSE-ConnectionGUID: TCapCIFRTMC64eKIsWjmxQ==
X-CSE-MsgGUID: 7xJWiu3lS+eCcoVTMIvsGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61522939"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 18:05:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:05:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 18:05:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 18:05:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 18:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaL8tKYbWLeUC9zXxrNDD/5fsfAW5TRKoi7EVzmfH2aRY9SNChz/eLhDj5xuCZwytNJxn10mQtq1GidO/WukxptxbLxqz5JJNps/sFhiBPmOYHw5MCJgRxmQQBs+5bL3r3weWQVmRt+gEyvtyVgFY0wutvzdKGL7Eyr5CY+1Y7P43Ip5DYJRRE61XysTRm2Urk+TozfjtcdLan7LM0agMsM9OsFqADqxy/RkDUSc+81UObMf35T2X/zvDYMl++3xnoquXQ3zA9hC4WrJuv0DlaspeU1wYoG+xQAGHjTd1nXe1JhMdSvXqRq6BmJfoqdk45YX/Y1hTzP7iZOotwudJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82KAtJ0P23zGnvZEBdR0y9iOv3rU3rwtStnrWPDo+pg=;
 b=WFAlIA5xORZ5BTozXf4D6nfPM6C0rrrV68gY2wtwWm3rsb+uaDCFLi/U8cLWReiPlXjV/giKNEC4/OTbDNT/taux0ELo+u2IJI8z83IF+mpf0v07kitk4sA1CygnKvBG33nJAYjG0VxMJzv6IkSfpYy+QJbiIgQQHAOQhAKt0P3j/eknGmTSeVvO+0EeiHjBEDY52cWej4TkW/aXEit5gTUgFZuXQxU6ZANL8nNQGOZAmnOIB9FnOoPdg4OlsV3BmmHu1mBDdUEPmzyvDDs5oX7yLl4eaokFDTHNyth471KAyvMxwPhh92fGr8tpJNiI1hmTcXOtZ01iwgrB0L0r3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 01:05:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 01:05:48 +0000
Date: Fri, 9 Aug 2024 09:05:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
CC: JP Kobryn <inwardvessel@gmail.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	<rcu@vger.kernel.org>
Subject: Re: [paulmckrcu:dev.2024.07.18b] [srcu] 8a4c716cfc:
 WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
Message-ID: <ZrVrY1je2fuhom8A@xsang-OptiPlex-9020>
References: <202408081016.9d43eb89-lkp@intel.com>
 <CAFwiDX9QSrn_ETfO0RsEV9zDoQge2mm0kNUZa_DJp=oUBa1kCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX9QSrn_ETfO0RsEV9zDoQge2mm0kNUZa_DJp=oUBa1kCQ@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: c4070aee-30b7-4416-9811-08dcb80f67cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWszbU1KQWV5VTc2Mm1sUmFPckx6NEFlMEo1VXNTZ3FwejZ3cURmYzY0c2d1?=
 =?utf-8?B?YWtKOFBHK1AyM0FjOHVFMVRqaUVmUXpyemowaWRncGcwajY5VnlMbi92WlZh?=
 =?utf-8?B?VG1GamI2MGFXdFhBWm1yek9Tdnhwb0ZlaU1oWEJtTE9XU2lsQ1Z1V2Y5cndZ?=
 =?utf-8?B?UjQxOFNldzAyQlpnNFg3Y0ZtNnVxQkd3UE03VlBLQ3Z1eWdyaEFqS0hlM0Rj?=
 =?utf-8?B?VnNwYXZFcmQvSVl6Y3UyTGxMNXdlK3BNQjl1SlVrYjAxT1NWR282V0p0VW5m?=
 =?utf-8?B?S04xUnBsaEVjNi8reVd5M0VUU2U1bVlVV01SY0lQUWcvMjB2NnZVcHJYQVpQ?=
 =?utf-8?B?Tm42WUg2dmZ3NTQ5cXBVVlUxd3gyVWFWTkphU1JZN3NvMmxPL3VrMUVCTXBh?=
 =?utf-8?B?T1lQSHRsaXNOUDdRUjBRNm8weG9ta2J2Um1ZTkJqOWpVbXc2Z2diQ05JbDVt?=
 =?utf-8?B?RXBzT3Z2UDZLZVViWEdHNGhyNGNOTGxmaXdFa2s2a2pScGdpWXhCakVhY3Nu?=
 =?utf-8?B?MDl6R1pCY1psWGN2bW5Jc1lta3AvS1JCYmRXeUNwQkFWSDlidzB3UTgraTNm?=
 =?utf-8?B?cU5UMldkSGFzVm5zRlJBNnVlTnptc3RrTGgrcnd1NjNybXpYeVpoTkJYOWVC?=
 =?utf-8?B?MzNJdlV5a0N3V0R5clRFMEhuVFB1cmFEQzNXMWJvVVFNaGkzdnlNdWNRVndj?=
 =?utf-8?B?Nm1FMkNCcTBpbm9DSFN4bHJPYTdzUzJSVnBma2pZZCtNaEQ5bldQQXR0Y3Jk?=
 =?utf-8?B?UDhla1haU1ZRZW9RSDIxV3lMaGpjUFBxTmdzNFM5eFBqbmJVUjJGYVM5YXFm?=
 =?utf-8?B?M29WUEQ0QXJzOHprbWFqdWJWQ20vTzIrNWF4bFFLY3BoOFhDaUdLOWJZSUJR?=
 =?utf-8?B?UnBrb2FZb1Z6cEU4TkZtejFrNjZTVi9RR01aSlVYWXRRbTlrR1lGS0FpZHB6?=
 =?utf-8?B?OGt0QUVHOTVHWWJnRDBBVE5lSXNkdWFETTl3T29jOXk5S0QrMWpHeVN5V3R6?=
 =?utf-8?B?cDAxOFBtdDJMdFJyOWdIZHA5SEI5K2lmYkswRW5nMnhmeGs2cVlTa1JaZFZP?=
 =?utf-8?B?ZkE3ekM5T2U4dmtHcUVFVFRUOXIxWlhyczFJSFpLV2lEdHg2UGtSRktiMXBx?=
 =?utf-8?B?Zko3MzNLVkdadEJHbXQrUFByZEE4d0pySmwwVG85ejJQQmNseWpYQWlYNzBM?=
 =?utf-8?B?OEJkZWUzVkFtZzBieDJaYWdHK3RseVVid29qbTZydjcvelBmZitIcHJCTXNB?=
 =?utf-8?B?M216dmt3a3pzb1ZrOWRQcjRic1FQdW9oOVBua2pzM09UWGFBS2ZrVkJtUnhH?=
 =?utf-8?B?NUNZcXhiRUhxZkVOOU5HcS9LZnBGNVBxTjR2OEtwU1pXMkljU3VLV1hJOUlW?=
 =?utf-8?B?L096L1c0UVE2UzJVZVlNMnRTNnlWRzJkSytLcVYyNnZXWmdBdmtwcVJINGc2?=
 =?utf-8?B?RzBEcVNNV0crUzNiQmlxMCtwL0xES1FuVURzMjJBZitZZHc5Z0hHc1U1K2du?=
 =?utf-8?B?Z3UrV282ZThQSk9TUCs2YTJTUitlVHVJNndsSndUMENFUnpDMkpJU3EwSTBl?=
 =?utf-8?B?dnlvK2pSU1BwRVpUQ3I0NTJJOUt6YjB0dXBXT1hTUi9qV2kzYVdQUmkxOTQ1?=
 =?utf-8?B?Z211aTJLL2RDSU8welo4NjJpQmJBWGRNcm1Jc2FjTnFzUjl5dFZEU0M4TmJ0?=
 =?utf-8?B?SHdHWHpqcUFuRjYySXdqTW5TcWxKNG1nK1diV3pFM0x3VnEyL3NSVVIzTFhp?=
 =?utf-8?Q?CXDc5NXuZnmmtdcBPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RPMkN6ZllxQmtDTks5RnM0bytvb3FFVmlmSVBFVGdqbllTVmp1N2Jhajd6?=
 =?utf-8?B?cnM1djFOMkEwUnFzc0RlTWhkcVYxalQ3UGZmQXVjZ1pJaFpoVG0zcDNXbkxX?=
 =?utf-8?B?UzRia3hIRk0vcWFQazBZcmhVeWZyOEh4T2dvbVc0elVXVGV5Q0EwRjhhRDR1?=
 =?utf-8?B?U1cvMGNDekNmZmxydlRKdkdiamZIVmwxUHIvdUVmSnhtR0VUOStXckdxT0hM?=
 =?utf-8?B?dTZGWW9OMU8razgzSXFrZXVGZWN5NzdCbmFxSHJPZ3RVeDlqMkNsM3RwK1lK?=
 =?utf-8?B?TXJCVTZOakZhUnF4Mml1YjFjU2paQTBlVXlaamJ1UXkvMHBpNXpveWY2UWVZ?=
 =?utf-8?B?bUlXMWtsL1RQanBrWTRYOGEzdWk5dW9iWXZPWHhKSVpEeDNZSFMrYTdqeWdP?=
 =?utf-8?B?dDQ2MnVJS1hjRUZBMlhWUzFvSFhobVZ5bFM1SkZTczluVXQ4emZ2YjZUNm5H?=
 =?utf-8?B?aVg0Wm8zdW15ZS9MNktoV05Fai9iR3l6djBPekZoYmtHZko3SXp1RXZSNm02?=
 =?utf-8?B?dmtERHovQ21WYk9HcktObGVJb01KeXFGaENGSk5qQkUySStGWFAwdlVrZ0dx?=
 =?utf-8?B?blV3VEtSTkRjY1NpTmhRbDh0anlTY01tTUxpNXY2ZUVnQTRGRzhjL2hzeC9F?=
 =?utf-8?B?L1FacGFya0QrQzBKUnpGRHIrZ3NnWnNzaWdtckw0cmFzallkZ3ZTbEVQYnVI?=
 =?utf-8?B?VVo3Z1dsMXNyOFNVcVBQTU1zZis0bEcwTSttaGc0TnE4eW1IcVJCNWhjNVd5?=
 =?utf-8?B?LzVjN3BGVnRWRWg1UjBHZlVuUGEvV2VQSkNBcVcrYTNta0lsTEgxaHU0em44?=
 =?utf-8?B?V3BXc3NsbE55ZmxBYk5WaCtiNGFmUzN1eFBMTk92YUpwYlFlbmlyRVhtU0N5?=
 =?utf-8?B?c1RiUXU5ZVh4cUc1RGpMZ2U1RmYzbG9PalZqL2JqWFU2R0tJQnFIRWhWM1lT?=
 =?utf-8?B?YkJQY2FqdHduc29pb0hBREh4a3RTQlNocnFuMmgxWjNOZ3NURUFxQ3drSUdq?=
 =?utf-8?B?ckhZME9KbkVpaDM0MUhBcG1VSk1JTzJTa2tKY3MvQk5QbWtTOTk3T2dVbEVD?=
 =?utf-8?B?cjFxMGtsOVdEb0ZaWG1rTzB3N2djUUlJdUpDL2tuS1VkK1FSUWJLMjhjdnlU?=
 =?utf-8?B?eGtRd2FUU3F6TldjWVROOUdNR0xjRktuaStrUmFSa3MwdCt4clYyUksrOVdj?=
 =?utf-8?B?YjZjc3ExVG1pbXd5d3JZOUFnT1VpR1pYWkRGbWMzQ0VkN3hUbkVRV2tBcHdr?=
 =?utf-8?B?RU0zMHpGTGtra3FJSGgwcCtiTm84VW1jSHk2bHZVaXlKY0VVRVF1OWovNGpN?=
 =?utf-8?B?TFF1d00yNU84ajNCSHc5WkZ4eS92MXcxSEhybE1KWW9uSjRjbzJ6T3MvYmgz?=
 =?utf-8?B?b29qWmNpdFBjMWR5S2hDNHdzK0NaNCt1QjRHRWZZNXJ1ejI1T1VEdDdtVFRo?=
 =?utf-8?B?aURianhBVXozQVBiNFAwQS8yWU5Sa3JVUjNRbnhRR1RBYXNkNVpZQXllQ0s0?=
 =?utf-8?B?aVBZWmVseHg1Y25hTEt3UFdValY2ZVRaV3J6M3VDaENqcm1qL0RId1k1V0Q5?=
 =?utf-8?B?VmRhSSt6azlyNlRNTjdwN0VpNWdFVjU4VzRWOEFjc1hydmpONHJjWTVGNXVv?=
 =?utf-8?B?V3VVeGZCVEZETkwwejd0WTBXV1IrUDNmVGNVVEtZTzFxdzRsTkkrRDFHTng5?=
 =?utf-8?B?bHJxRmpMUkRDcHdSeU1hUjhrMVRCdDRSYmpqaTcrM2grTmprQldPN2FpUEpw?=
 =?utf-8?B?VzVDNzh4WDBzMkVhd0Q1MXlBYnVMWVh4NS83dU9pNkVtaWc3OVEycTlTOHhW?=
 =?utf-8?B?ZjNJZXY3V1k3Q1NEdFllYUlkem42MjI0V1ByVVFrazdDdmlTb1ZITVlLZDJC?=
 =?utf-8?B?NVlxdUxFcG1qd3k4Y3lPeFVoMW8zUGJ6dmI0S0ExMi92TUppa3NIWE1HcGlR?=
 =?utf-8?B?L082a1B5cTZheVUxZkxoV3pDRGpzT21pYlprVzF4a0R0UDloUGttTTQ5ZFVQ?=
 =?utf-8?B?ckMrWkpaMzRCRGtVMldWUzR0Qk5jalhWK2lNSGNrZGpRYnJlQkFMUktKWnc0?=
 =?utf-8?B?WnQ0S2laWDY4dEdldVlDa1QvRUkyMHZtanQ0S3R6bGFnZnA0RXdVc29ZWHBH?=
 =?utf-8?B?cGN1V2FzNWpLWk02QzFYRE9sQjJ4WWdCMktvakxSWng3ZlY4a2pYUElyVWpB?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4070aee-30b7-4416-9811-08dcb80f67cb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 01:05:48.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI976oRQf4mcUkQnbtG6/Pmi8tS3KoN7JRcjor9xUs16zhZjxp+g1532iCrAX/P2kYCtRQqSP3uxWQfSNjEXVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com

hi, Neeraj, Thanks a lot for information!


On Thu, Aug 08, 2024 at 11:22:28AM +0530, Neeraj upadhyay wrote:
> Hi,
> 
> Thanks for the report!
> 
> On Thu, Aug 8, 2024 at 10:49 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> > hi, JP Kobryn and Paul E. McKenney,
> >
> > we don't see commit with same title in later dev.2024.07*** or dev.2024.08***
> > branches in https://github.com/paulmckrcu/linux, so not sure if this report is
> > still useful.
> >
> 
> Similar issue was identified in [1]. The newer version of the patch -
> commit 316a003bd5a4
> ("srcu: faster gp seq wrap-around") in branch dev.2024.08.05a fixes
> this problem.
> 
> 
> [1] https://lore.kernel.org/rcu/191db3ea-f1aa-4e13-b919-0ca4a00dc89e@paulmck-laptop/
> 
> 
> - Neeraj
> 

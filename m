Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659F2D0636;
	Wed, 10 Sep 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496794; cv=fail; b=Umj5PO6w5HJd22ko7Sdn7SxS8vs/HSReX9U4nBMOdpmzDNdg9Dun/UAjGWeriROPZuhDfcTQL0gQWlRAzkSsaMFpNbR3vnhDiCTIcRyPtHDgQ/ddBUqzM1xrQPecxcmFagPg1/rUK1Zt8d6lj+aHwfKWGM0JoC28SexA8/RmXQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496794; c=relaxed/simple;
	bh=VnwBkKCuBz0ecOXBqaS+b9jNQ0SSPnwTHwL8Ex9o8q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2otXpFJYDXzpGhOwn+l/hBAGylKAQCGXnxtb/p6i7bhT9FZ1mYhe1DedeaZz+j2qLQnSVMuEMcLtidRt0Tp5bpQTeZW3aSQnmCerKcOcGWWZI8zrIG29s96BAxO76I8NmhQBJ168lX6T1fF9XHAq40WVtudA4W5NtkZwQiH4XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnjazZCg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnjazZCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757496793; x=1789032793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VnwBkKCuBz0ecOXBqaS+b9jNQ0SSPnwTHwL8Ex9o8q4=;
  b=WnjazZCg4GIvRrGJY5RWGnKnNN+2lOEcyHNHGwdxnVU13o5WA8P5HWQg
   F97YWtfq7765x1emXMmpxRC/svkYG1TYSm+4eE0w5i+haCzkQBrJuVgZj
   PUPqylE6FPFEVKQvT5DfVXqXL1cA+n1N84EX1pxm9E7zTrvmSawJFsPrj
   uNrPqkiyMtcWslJbtE3ReJ4id/n4HLbHL6l3PQwnDA4pLcG/TmSIoX6Es
   NhHukDRbBmfI+7ENQXYzA+7SL/kKCCj2GTKTB/Rq0WOuRXkQvwTL3+z79
   iBMwKuM7DzqbvDTA9xCdk9HaNlUgNIjEMY3NS4ZrYIbiB/d26fnnbdUHF
   g==;
X-CSE-ConnectionGUID: XUvqNsbKTruFOCD9nbkIlw==
X-CSE-MsgGUID: ps2LaZ6CRw6PDavM3+UnNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70901289"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="70901289"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:32:52 -0700
X-CSE-ConnectionGUID: O4rmieyjTOiLkra22nqyMw==
X-CSE-MsgGUID: egkX+sQES/KPYC2OWpUfJA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:32:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 02:32:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 02:32:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 02:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTGAN5uqhxVFQNbHl6Cb0kRLk3NCUwCao2LxHm8UDTzjP70ooGFCQAgnI/8nLkG9oxolTrBUpM21T61kT3pDVFmg+Ets7F24HLxYR4e7b2SimJnjI27QcsUh2iFYsOrVdTwYlQ9JI8UYbI6pbHVhknNEE+S0aja5V9Bhem84kmUPObSAWMHFjJ/4BjaLe9pEzTP7F6OGglND43iF80vAEPgGQ1CE0C8LNlDH0uuDcODScIH4OpfazcJ5sj5gQpnhdwD3FDjY7iz+0MlBvfVTM+CPvFHFj3bgloRV2FcwUFHNeLMXCDPEgAZsLQ2pgdtw+dzt4GpmjY+HQBkk+ULh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnwBkKCuBz0ecOXBqaS+b9jNQ0SSPnwTHwL8Ex9o8q4=;
 b=ZskQsx7Ipf08gxs4kTKQ2djTwTWfEBG6E+ObIqKFaTQqPKgMUU9G+24rc3OFrqSKjXVGDTwSjvIy/ryuwNe5EYhWlrHJqDjtY9cHX/B9uvOmgCicR8krHQTAhxQ8PRavQqUEysZfc2CzvRpkevP31peUtQFmA0gEM4HPG5IVcdqQ+4p8yeou0SEQBVX9gIUJmG85f2zgZWBOg4SwyuwV1hM94MX423OeX9+SQpPPcQ7mzSMRj6h6FULlMbU2YcBY3QKeixchhHYXeaf8crIQfDL6uflm0fNFfKA46ir/xHa0PpnkOskb8+93fwlocDLcnMDjN9JRpEUtW4ZtR85/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA3PR11MB9422.namprd11.prod.outlook.com (2603:10b6:208:57e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 09:32:47 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 09:32:47 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH] rcu/rcutorture: Improve error handling in
 rcu_torture_fwd_prog_init()
Thread-Topic: [PATCH] rcu/rcutorture: Improve error handling in
 rcu_torture_fwd_prog_init()
Thread-Index: AQHcIjJe4mRfxZgbfE+z/jvjsfxw3rSMJpzQ
Date: Wed, 10 Sep 2025 09:32:47 +0000
Message-ID: <LV3PR11MB876880CE64C17CFC5DBC459BF50EA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250910083630.3735022-1-kaushlendra.kumar@intel.com>
 <b062b061-912e-4fee-933c-5feea67b4c62@web.de>
In-Reply-To: <b062b061-912e-4fee-933c-5feea67b4c62@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA3PR11MB9422:EE_
x-ms-office365-filtering-correlation-id: b96696a9-b849-4c50-6eb3-08ddf04d00a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UkVqVDE1SUdXQ3R1TlJuMmYwZlpOa0NOOXFqWU1DUFovRUl4ejdKcGFNOUlG?=
 =?utf-8?B?clVxNHBYUGhTbklDZmRsUWhMWW0vdEtlTXU0Wi9HaVlFaEd4V3hiT0dMQ2Mz?=
 =?utf-8?B?ams0VTlMai9IN1liaENFK0hTQW01T2VDdlJ6ZGhRTDF6ekRTMFo2eWk5TzFa?=
 =?utf-8?B?VXN2bEJ2eUUxSGFRaExTbEREQlZwSGVJSUpLWGFkRXhGbU12TG5XdkRiZzRG?=
 =?utf-8?B?Zi82QkhkYXlJQXNnQTl6ZlZ4bmh0RElEejNlN2NiL2s2VEZYOEtIQmNsQ3Fs?=
 =?utf-8?B?S1liT1YyK2V5dUdLTnhrdGxhQUVkR05xT3ZpVnlPWEl5WFBjWGNZNGJRU0FY?=
 =?utf-8?B?dm16bHVtQkRLQTFUbFpiMWdMeUJaNGFiOGo1LzgydUlVbkYwMUh5VzZBeStM?=
 =?utf-8?B?MGFTRlZSNW1CVjRBalZwRzBYMUl5aFRwYTAwWkZwa0h5UldHZklpc0pOcmY1?=
 =?utf-8?B?WlZObHFUYlljeml6VkorL2M0cFI5YWZ0dlFpNXJTSkxTeUxtUCsrSktOQWJ1?=
 =?utf-8?B?MERMN3ZkbmU3NVVIWDlWSTBaMGxPUTByNFdlRHhIRUg2bnIvaDlhQklYRDM3?=
 =?utf-8?B?ZUJiWW0zVHpPSnQxSjZJZ0pNK3padWhzaW8rZkRlekgrcmlmWlNtd2FVRzBP?=
 =?utf-8?B?VXlhZitsOFlkZ0l5Q1NMSDc2ZXhsR2xPOFNRYWlseWdYWE1POWp6cCt4b0xQ?=
 =?utf-8?B?ZWg4eUhIN0Y3MGJTS3BkY1pTSk52SmJ3T3FRSW92Wk0rMUtYYzZCbGNYdERn?=
 =?utf-8?B?cjZNTnlabmZHRkl0N2ZaZnJWdnFFREk0WTZLYURzR3VKcGl3K2c2c3dmeHBi?=
 =?utf-8?B?SlJXNnNLVk9DMjZHWDZOTE04bzVTMDZvcVcvUlhHWDVyMmJXcHU4VXliV0Rz?=
 =?utf-8?B?aXlMVVdXYktMUFlhREpzWHRNSXZHdno1TVU2NDRzMElpM0V5c3pLUU1TZDNT?=
 =?utf-8?B?QVBtcXcrYVFyb3BsYUw2aGdma2NXT1V6RHMvSmFrdVZvUkwxUWo0VXowWnlp?=
 =?utf-8?B?STNQQjJPTmlqWXFxdXFlWG40czU5YThaSXRUUEhnUHBld2VGa2hWdVZXUnNq?=
 =?utf-8?B?LzhSOG56VzdZQmNZZWdrOVFRM01ybEc4WHBNSU9BSUo4YlpCVEpSU1pSTFQ3?=
 =?utf-8?B?a2pkN21wUXI1TVlpWEtNZDIzdEpDTVUxRTA5dHIxM21sc3prOXZQTUJubUhV?=
 =?utf-8?B?QmUyMml1ZjBtV2FxOGRzbWIwTXE1dEtPUXJvamZvenJqSUcrVmhpdHVJYXhD?=
 =?utf-8?B?RlJ5ZU5YU1ZTeDRRdGtoTCt5TmhMd3NaZGNNUy83ZEowTlJFS0Z6ZjBIYjMy?=
 =?utf-8?B?RnM2bXlXMklWWGFWTnF6d2pLNEJnZjQvL1pwdzVRYngzcHY3Tm9ZRHNIL3ky?=
 =?utf-8?B?TmJOOE9sYm1GbFpTMktNaFpqekVXYUVnWVJuakZvanhoTnd5elg2cUNGNStG?=
 =?utf-8?B?VlFWRitLZFFlT2xDYm95KzRPNDY3a3VKSmJkbmg1OGFIeWdYMkwranRESmow?=
 =?utf-8?B?c2dla1Y0QVNvZWQ0Q0hVbWNJZnBnWUgyNGlCMWIzMk44dERyc2lZRXpmR2Jr?=
 =?utf-8?B?TUp3QXd5QVd0VUpBSm9XejdmWEZwZzgxUGtWNkZ1TFFwdVlnakFJZlRxNGFs?=
 =?utf-8?B?RE4waDJHSUpKa2t3UTdFaTB2WE9PS052K2Y3NWhwTGlvNVRMbFBtaFd5Zjdj?=
 =?utf-8?B?NGY3bmo5NnMyQmJFM0s1ZnVSYWRTL2I5THJPSDExeFl2VSt0eWEvZ3hUQVAy?=
 =?utf-8?B?SndjdE92cU1aN1V5SEFtdmVGV3ZnK3VHT2VyVDdmRXMrZzgwQndOeUh2OHFP?=
 =?utf-8?B?OEZWSVc0cEV2MUlISGgyL2R2M0I2Y1VwWCt6UHZ6eDIrUWVBT1cwS3BodDJP?=
 =?utf-8?B?RTNJVnhMMzM3RTZyNDZqSXRsMnoxRnJLQzFvbGtqaFdMYU4yc1U0UEw3U1Rh?=
 =?utf-8?B?aTlyb3YrekZMVXBhNml2VnZSK1NVdDR1bHNRY0U4ZFM0THkwSWdON2drM2NO?=
 =?utf-8?Q?KBXqAzftZFhmD597fkJ4+YLvPHlk3I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnFxVUY3dm54em04dlRkcFI0Y3NzbzFCbXhzK0lFdU1VY256aGdNUEgvbFJN?=
 =?utf-8?B?TzdPOXpyK2VLcXQySlJvN1I0SDYwTStyTWpqZnZ4Z1JNeHVOUjJoeEx0RTNL?=
 =?utf-8?B?Z2ozVHY1RkhDc2JiR1B1c2hlUUwwd0RGcEdLQ3RuRUwwajZxR2xaNXl4T0h4?=
 =?utf-8?B?ZXI2b0oyOFVqV2tIOW1PbHpGdGQvdUhLQlNVZ1J3c21HZ0x4Q1NHNnRlcm5q?=
 =?utf-8?B?RVNXZXl3b1R4cUM0T2I5TSs0VllMMmpnbk1xZVdVUCtaTm9ia3c2dnBJUW9K?=
 =?utf-8?B?dXFWZEJHZ2JSWmQ3OGptTVU2VFV3YkF1NFYyZlcyK3dlUmR2MmpjeHZ4UWFx?=
 =?utf-8?B?cjhjQUNQL1ZVZkxiZ1BLTDA0T0pQWmowRVVqUDE5SkM3YlVEQ2ZVanhJSkFl?=
 =?utf-8?B?VkpVOHBQbmxQdUhWb1dabjFwRlpuVG84K1Y4TG13aUtWTWhkaVovcWpSMGVZ?=
 =?utf-8?B?VjRJWjM0SGdZblBQUDE0YjR2L01zZWk0VUpIKytqWFR0cENOVHBxMTdCZ3dx?=
 =?utf-8?B?b3NBZVdjY2M3dlRmRWRPOSszMmpybkZDSEMzdzFJNUQwU1BPUkNlcXBTVmFR?=
 =?utf-8?B?WlU4VjNsU2JXdjUyVExnZUxGZVhhZ1lmeU1OVmh0T1VoV3lmV3BQUkxBNnRO?=
 =?utf-8?B?OUNUUXFmbERjWnMyR3dWNHNOTmkwRktyeHl4K0lpRFdibE1UWGcweVRjaGV2?=
 =?utf-8?B?ekVSQUJ5OUlJZXBQTmdZUlViRGkyZ1lPbVRYVzRhQUJWN2VyWTkwZWJIZFh6?=
 =?utf-8?B?TTBsRlVyM0h3RlNEYkR6N0NQUTB5UHE4SkZ3Rk9MelZFczhkeHpWdjFzeEhn?=
 =?utf-8?B?OWoyWmJZeGNQcS9rb0l5NldQamgxenlaQlRBNUc0aERaejZDNWpSNEduVUh4?=
 =?utf-8?B?VW02SWJYT3JaU3V5TzZrYi93cC9zbi9zSmR0N3Vjd3RhYjU0Q1NHQ3VFOERv?=
 =?utf-8?B?dDJ4bmNaU1JJcVFidis1clh6NzRWWTNuM0tTbElabnVKNHV3NU5tN1RIVXBq?=
 =?utf-8?B?K0JyN1hJR1dmRG1jZDd3d0I5OVdCMG9oT3ZYYjN5aHBHclQxWVVESUJRdkJB?=
 =?utf-8?B?SjdVVUNsUjdWM0k0clVRdWQvcTNYRDlzZDRFVFgwMTVhVytMSmxQcEdzeU1L?=
 =?utf-8?B?NUx6VUZaNEJXbWw3eWkzV1pMUlNWcmRyS21pK3FkV2ZYTng0MG9uY0F2ck5j?=
 =?utf-8?B?Q3BmSXZvQUJoU2x2bDFEMEVHM0dMVWE2K3NPWmtCa0RsT3VESGZraUZOM2dp?=
 =?utf-8?B?R2VNTEtweDdJcWhTRmRESHFXZDBRN1B5QStjRTAvRXI4QytKdEdKeTQyQVFE?=
 =?utf-8?B?eHo1cnowODJadnVZN2FMT2xmS1h6TU1telNNNmFEbEZza2laY0U3b1d6bnE1?=
 =?utf-8?B?SitkLzEzR1B4aU56TGtGTTVjWGRaaGlvamdRczJsVFAxVnhSRW85SDlqbk9m?=
 =?utf-8?B?MXA3SjBFSzN1ZFdrdDFPV2RLM0tibWhPK0R4a2VBZEo4SW14YWFDc0crdWNL?=
 =?utf-8?B?blR5OW03SmtlaWxma1BYL2hxYXJmd1JVbmhoK05jeVliYTBMZUpVVVg4SDc5?=
 =?utf-8?B?UFZDQnJLbVlYdUh3Vzh6M2U3elhZb0xPNUJjV3UrR3pqZVlWcmdGU0NCMzFY?=
 =?utf-8?B?SmhZWmNqMmh0Qm5tRys4dDA2N21xYVg3M0wyV1lRZEgrRytxRmw0Z2JEOFhu?=
 =?utf-8?B?K3B5MiswVUcvcFJHdnN4Skd3RjJCVHJWay9OVTJBTXlhQXgrVEI2YmZIeVg2?=
 =?utf-8?B?Qjl3dXQ0VGgyWUg4QlBzTEw5cUsxMm1Qb2pHS25vLzIrQlkxN2ttbjhJOHFp?=
 =?utf-8?B?M3dsQWpPdWVuY0NiVHY4WDZzSy9tVU45c1NVQnZmZUZuVGhJMDd4dmZPRzBp?=
 =?utf-8?B?dGxhYitrSko4UEdBUUsvYU5WV3A4dzZSZDNCbm1EekRXODl1alpBWWluc0hV?=
 =?utf-8?B?WDkrTGRVY3FQVEVsKzlIa3U1NlEzWDYvR0tkTC8zMVN4SzM1bDRCY1ViQ0o2?=
 =?utf-8?B?ZDJ6Qi9XSi8rZ0cybTZlTTJmM3hXejl1SmttRmYvTHUzRlAwdHp1ZHF5ci9s?=
 =?utf-8?B?a0JXUm5pcjF4ZUZoak1iVC9lUkx4YkdVU09nMllCYlJCUWdPOGRZZUxxTUY2?=
 =?utf-8?B?YjFZSHFYUW5TUUpWd0F6OHQvOU9FWm9UY3lJT3VLNEtNSG1kekUxZWNkVmFs?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96696a9-b849-4c50-6eb3-08ddf04d00a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 09:32:47.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1QdU1wxz7AR1QDR+bCJBhNvGGKiR1XctR4ILmUEeLHKmw5ok0m3NRHlID/Ri99ndVrnNqrxJtWZrZPNlL3B58Y/VuZ2HL5mlPCz1LYlpo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9422
X-OriginatorOrg: intel.com

DQoNCkhpIE1hcmt1cywNCg0KT24gW0RhdGVdLCBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJp
bmdAd2ViLmRlPiB3cm90ZToNCj4gPiBSZXN0cnVjdHVyZSBlcnJvciBoYW5kbGluZyBpbiByY3Vf
dG9ydHVyZV9md2RfcHJvZ19pbml0KCkgdG8gcHJvdmlkZSANCj4gPiBjbGVhbmVyIGFsbG9jYXRp
b24gZmFpbHVyZSBwYXRocy4gVGhlIGN1cnJlbnQgY29kZSBjaGVja3MgYm90aCANCj4gPiBhbGxv
Y2F0aW9ucyBpbiBhIHNpbmdsZSBjb25kaXRpb24sIG1ha2luZyBlcnJvciBoYW5kbGluZyBsZXNz
IA0KPiA+IGVmZmljaWVudCBhbmQgY2xlYXIuDQo+IOKApg0KPiANCj4gSSBzdWdnZXN0IHRvIHJl
ZmluZSB0aGUgd29yZCB3cmFwcGluZyBmb3Igc3VjaCBhIGNoYW5nZSBkZXNjcmlwdGlvbi4NCj4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5y
c3Q/aD12Ni4xNy1yYzUjbjY1OA0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjayBvbiB0aGUg
d29yZCB3cmFwcGluZyENCkkgaGF2ZSBzZW50IGEgdjIgcGF0Y2ggd2l0aCBwcm9wZXJseSB3cmFw
cGVkIGxpbmVzIGFzIHN1Z2dlc3RlZA0KDQoNCkJlc3QgcmVnYXJkcywNCkthdXNobGVuZHJhIEt1
bWFyDQo=

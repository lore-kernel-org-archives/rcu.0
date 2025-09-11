Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB5288D0;
	Thu, 11 Sep 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608668; cv=fail; b=EBdfyxmmBrDcmn1mMMJHIOzxN5kqIRvAFQJEImnDgmJGlgV2sJadVeaZXEEg69X2cG80F6EpP1P1umC7YgGk0HktlBOPvMfrIvSf42ezqLe16DafcQH2kF0NQn2dKIl7xh3bjwhaz5SADo3qw0qU23PkCiHlVtGvmC71hSdO/lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608668; c=relaxed/simple;
	bh=fKj65wdz/ipXtC+xCsLTdknWXOAw9q0YiPf+VMUSUU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8Y11xspeawFyEk+c/XDC0kaRLZwyLBL3IRbqtJD1Do7LzDz2Rq+VtxSKXpJNejAOCTcj3Guag6ZeF2fgfQnImF20d/dswFzxwsF7jdmGWV6VtPUdi2nkNDv9zw6e+tTtQTStoYOKVKL891+6aWuzZpjS5f8V1DK+8DHBqtq/po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpAeVEpq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpAeVEpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757608667; x=1789144667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fKj65wdz/ipXtC+xCsLTdknWXOAw9q0YiPf+VMUSUU0=;
  b=LpAeVEpqauuYQrsDj8bPoah7A10BOGkkMartUMkxGPULJb1plSKY+b6D
   VtK0AN4PPcCleIjpaI3daQGgMrdNdPyvaHTJCKyNoKVoUopeAdGPdw7Av
   PgPgqk0tKtPHeLJUfM/6CVV4OtnEl4kz7XowvJ+n5Hu8bE/00cUjdKcqF
   +Qluuy8zlbQ8oLAubAYoFzmaOt7NyaJtF/BtbboSJqLj5cdt4TWZptCbH
   2aUFZBJAXBZRr96rZ9lqv8j/JGhYKPMH0VakSzzq8cEM0xbA74iVOMMNy
   xr8HvNBsWQOtyptdfay3i3zpYcZS6zcpSDVGkmFd+msfKcqbiqhdnA8hN
   A==;
X-CSE-ConnectionGUID: QxFXrf3iQSak8lqKlRcd/A==
X-CSE-MsgGUID: 4XdcIsPER0mbPApWWjudpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70204066"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70204066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:37:46 -0700
X-CSE-ConnectionGUID: 4bRzRgobTySVhlak/Cx0ww==
X-CSE-MsgGUID: KsXCytCHRpaM9ffZHm2Waw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:37:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 09:37:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 09:37:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 09:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZHpVAEvJ5yfNeza/mhWFZVaIJVn1McOKQzC0uGYpMVyPGAh8XgWsbHcPypcMWNsXRXpKsPDmI+kGSFv1ZE4H9pOuakITBwNfoWhO3//KwOAMy1wsEvibaocCYVIHu9Nwy0LLOMU/s5u0gClcT3b1MonTcp7QiScEWokTNPW3eXO+GlgTJkOTSvcvHczAShdi+XQEZToMSD2olP6ERAxqncY7xkDq7wzc3rtSAYP4r7x9vqalB51C9xXGu0JwDdCb7QM/AILbyV14yg+IC4koVpse0DplhV++KdxjDqIkODrUvwDq7KfN7T3g7OPi+XWO/mAeZxXpdyMHMkbytrb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKj65wdz/ipXtC+xCsLTdknWXOAw9q0YiPf+VMUSUU0=;
 b=hGW7rJZ09/EPHpJSouCnPt8EJ1+fUBuvpe1bEVtWag2E5dbRqqp9gzYHdSmIS8OOMJ9wBZ6I3CZGVcyJiqzIZ/LtHJP43DJewSJ113E5St5HB91Z8c/1yOfNfjIGBTemry94xFMNQV3YMpWHYNrRRR2Do8flrU/r2xUDfhH6NmPkIxA5SfxZyts76Py6BRXAX1w1BiUGyDqYytmLSXN4oDqOpwJj3iDPDqkIZX9lI9cLTzILLoDgePmH9znFnJv5VLBbkpTPjAOLvEPyXo/HQcxbxulM2tWTfHBeNDMy/+4bR4kYYDRRKocKFniDyo8FElYFU1dnZJYHmWxiV0tzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:37:41 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:37:41 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Thread-Topic: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Thread-Index: AQHcIzpiDeSbU/6v006ewHhYXXfr6Q==
Date: Thu, 11 Sep 2025 16:37:41 +0000
Message-ID: <LV3PR11MB87689EE977B23F1BB59E1938F509A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
 <d5dc1997-feea-4312-a081-229c7eacac72@web.de>
In-Reply-To: <d5dc1997-feea-4312-a081-229c7eacac72@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CY5PR11MB6534:EE_
x-ms-office365-filtering-correlation-id: 11ab5cc5-dd32-49cf-de6b-08ddf15186c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ui9rWVJSQVlibnBJcE92UytVZ2hyS0ZyNUVKbHFnOE9uVmhaVk0rT3dSenJC?=
 =?utf-8?B?bDg0YW0xbzF0VTB2OStDQk03RTI1K1hUY29tL3VMOFdqS0J3Y0tyaytmL0o4?=
 =?utf-8?B?SzdxSHBwOHFZNHo5bXFvUWxqYkQ5NDNYSHlyZGVYeTZnWHluWndMbmhuRCtR?=
 =?utf-8?B?d2U3VjdLRjhkRDlzQy94dnJJWTZDdXJaZk1ONVhzb0tNVXFIYmVPRUI5VkRx?=
 =?utf-8?B?bTBNTjhTa1N6aXNDWHVYWmMvelZ3c2lpQlJuZU50RW5xRlhWOEZqUStMZnA0?=
 =?utf-8?B?NVpZQjVtSUFxZlVYdVFSaDRUMXhFTUdUQTFDTkFNcWR5aVVJNFNlemRGQU9G?=
 =?utf-8?B?WTZFc2FMS1ZWcG5rVVBFVGNVTm10OSttbmRaY0F4NGM0R3Z1MXloVlNCOHhQ?=
 =?utf-8?B?ZWY1WVoxaU93dWZsdWpGaW5zcjlnQlRKN0xTZXh2R05RSFhsOHJ4RnNJTFQ3?=
 =?utf-8?B?R295WVVlVjd3Y1FkTCt6QTRpenNEdnA1clN0eW0zZDcyUEhsZXZvdERVaFQ5?=
 =?utf-8?B?K1k0dVN1WElVMHdleTIxYTdtS3grUWp1UWRsY2VraExtSG5qbEplbHNzWm03?=
 =?utf-8?B?MXlkVXB2b2NuT0QvTTVKcXlxRVVZWGpCd1o2akZwVzk4VXR2clVpUHpyN1px?=
 =?utf-8?B?eXV1ZDI2RmJjeUh3YXp4RzVyUkdwRmk4cHlsb1RIQ2h4WUt6OGw3NDJYVUlD?=
 =?utf-8?B?eXEzWDFTMUx2aU5DeVBPZkxoMlRsL1U4TTBoSUhKVWtDcVMyZm9PdVd3eXU3?=
 =?utf-8?B?TFdkUVpsRDV1VVE1QXZndUVaeGU4NDhYcU5pNnJCRGdiYlJYMFVwdS9JQmw1?=
 =?utf-8?B?Qmllc3hKdzlmK2ZCWFZLcTMrUFNYKzJRTXBGY0NoQnN4cUhqNEVDU2Y3cjNy?=
 =?utf-8?B?cmdhWVlySUg1dzhueVVVYU9hckppQkNwNlFGbyszTFZTSldkSXNFd080bFFM?=
 =?utf-8?B?bHdPWUwyYXFJanhzbFZEcU1WbDJnVm9rTFpYVithYmxiWm9hTG1ycDAvdmRH?=
 =?utf-8?B?T0krbjcwV2lIRlZQb0hOeTBGd28wb212K2E1NWhCUEhSdVFEOEdqVldlTGlh?=
 =?utf-8?B?aXJCbzFSd0cyS2ViM0p2dURtYVNHRUI4UWtlL0RHTE53SHdGRGVHbzJLMGw4?=
 =?utf-8?B?cVE2ZU9sSFMzRVRtYXBEMjdkVVEya2l2WjdIWUVlc0s0QlJTTTQrSDJFd2Yr?=
 =?utf-8?B?NGpoRVpNanBDMy9FdFJJWHIzR3lYOTRxT2dGR0x1Ykp5N1A0NXl5eWJaRWV3?=
 =?utf-8?B?VDMrRTg5amZ4TlZCVCsvYkdiaXRjZFYvUDE3ZS9FNVc5K04raEFUd0FIYzhu?=
 =?utf-8?B?dXBzaFdwalRJVXI2K2NQTEFzcmlzS0FCZnZMTFFTVWpGZTUveUlXaEFiQ0F2?=
 =?utf-8?B?Z0duNC83SWtIRWNXcE1jZUh5UFZOcGVNYU9QWFZTWmZuZGU4Nm91TU12OERE?=
 =?utf-8?B?N1F5NlpQTDZOSkdEY3gzSkhRMXg4VXcxcUdhWDR2N3QrYUhadUxDZE9BdHNY?=
 =?utf-8?B?MGdDZXBYZFptZldQMWFPNXhWY0RmNEVhdUJmU3F6Y3MxQ0U3QVVPTkswdFBY?=
 =?utf-8?B?UjRBSzN4bzRKQTc4KzRTSUZpYjB0YWVObS9Qdjg2UEYxdU9tS3dNYTdVcXdZ?=
 =?utf-8?B?U3luc080MEJ4WmhJbFB3QWhXamR6MlRTUzFyclhaeU0zWU12ZEtucnh6NHVj?=
 =?utf-8?B?TUpoWUgvV1BvNnplUkFFRUpjTFZlU0tNN2dabTB5Y1NyU2xlbHhWd0NzNzUx?=
 =?utf-8?B?TEt3eWxMZUdUa3B3YWRIY0NMSGlEOXpCaFh4ak5wUGZDMm90bmpQNkE2c001?=
 =?utf-8?B?VzQ2T1g1SWxLTFEwQ05iUXpLejZ0WGFKS1FaTEN0Zzl3Z2JuZmp1WmZNOWtJ?=
 =?utf-8?B?V2d0RDhJdUF0bVUwdXhoVzV6S0RLdW9INk10OU5aNmhnNy9OWUJXUGEyYVU3?=
 =?utf-8?B?RHhlc3owbFZQTDlPRjF0UzJjWndRT2tWZlJtWTRJcUI2YmgwVHlwRVBZdWE0?=
 =?utf-8?Q?FrwVpLRjST29XKmT9enQyXhfJcXtnU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5pVlVZcW9KR3RiN2hOd3BlSmluNktmdGZQMi85VTU5MjY0UjF4ZzZ4K3I0?=
 =?utf-8?B?NHZ3SG9FcWpGaFRPQ1ZoRndCK1o3d2I0TFhzRG80UFBnbDJwbXVQaFFRdkxo?=
 =?utf-8?B?SWYxZk13USsrem0xN1JidURJR1JrSXYxTGdFbUNCcEFWM2dpSHZHZVExSndY?=
 =?utf-8?B?eGFESCt3eFdrZmYzVGIxVm1haE9ZMEZmMkppYzQ4WWkrV2NmOS9hbUo0bnJa?=
 =?utf-8?B?ZlgyRENwQkxNVzdIY050UzRLaitWNWpON2RxQlNPcDBzNUFBU2F5UnB4VlQ2?=
 =?utf-8?B?WEU4OG94R01kWE1vTEhPZGdxYzBNUlg4Y0QxMlJhZ2E5c2lPbXo4bFVYY29H?=
 =?utf-8?B?UGdPVjdHSW5Jc3EvVlBHemVHa2F2akFkVHBHR0xXK2FmcFVrQU05SGs0V1ln?=
 =?utf-8?B?SHpEVkRZNDZNS0QzU0JqOWhJZmQwdFpLWmxwMDh2bGF0SjY3c2lKaVphNk53?=
 =?utf-8?B?LzllZ0FwYWVaN1pnNkxOY09rUS9oZWhOWUZ5N0N0c0FsS0ZoK3U2NXdvSFcv?=
 =?utf-8?B?NFZZOU9jSWZPUkhVYjVydUtRT2I5M1d1VGlIZ2MxL0thWFc5UnJDRzhxMEpJ?=
 =?utf-8?B?MElHdHhmS2VyTUJ4OWxZSnBDY2Q1TStaWFd4NjBJV3JZYnlheVpQeVkxbzcv?=
 =?utf-8?B?eFo2OTVpY3EvVDIra3FNMjFOVW5sTTA1L2IwSkhCS0I2UUlTTjJDT3VTcjdz?=
 =?utf-8?B?SlRjS3lnTkd2RVBtN094ajd5bU85dXNvbjVVbUFBRmdPbXJkNk5MN2xhSkk2?=
 =?utf-8?B?elVlcmR2dHlpUTlPSUhJbjczZ3Jhb24wUUd5OFNURHI1cWRtZktzSjRhWEd5?=
 =?utf-8?B?R0JrcjJ6MGoyWEFrK21JS3VtTnprMnVYYS9mYkw2ZWtNellxMHNkeWo4NUNO?=
 =?utf-8?B?bVp3L1VabzZjbkVRQyt1Q0hVV3VRSSsrMGE3MldIMVhxQkVKUmc0N1hOeExq?=
 =?utf-8?B?ZVBUVjUwZXpFNGwzTVZGdjNKRWZWRlh3QzEzTlg5ZjR3ODRmT1JLclhmUU5E?=
 =?utf-8?B?dWVXcjRWeWRyaHZJUXc4SjljTU9PR0MvTXgyS3JWSzF6VDlEUG83VFNsaFZl?=
 =?utf-8?B?UkY4VGk3TjZoRGc2Z0NmQjF0TzE5dUhKMVpwN0gxSzJqVkE1RFgyampETDB6?=
 =?utf-8?B?R2kvZmZNT0lmenM0V0svWi8rVzl1emY3SXNCempGYnRrWGFRV1dsMHpyQTBJ?=
 =?utf-8?B?MEpydkRhUjFQc1UvZjI1c25KejNkZ3pxdEMzOHoxVDRHSk1LQmpCcTZXNHI2?=
 =?utf-8?B?aDRKaWVTUk1MWUlmUnIxZkhvK1FjTVlaZGlxZnFJLzBFVmNYNDI4MFN2QlZP?=
 =?utf-8?B?VzJ5UEJFRDJUYWx2Rys1emdLZDVwN3dlak9sNEg2ZVo4Mjg1SkRxM25zbWlX?=
 =?utf-8?B?bUZkajhDTGpkazJlUTl3RTJObE1tNFdJZDVlbUxFU2dZRGhhaThxZ0JjelBj?=
 =?utf-8?B?VWRJc2pQL0RpTzE4TFdoREtDTm1zSkdZL0FkNUNXc0xCWHFhWnlMb3pmdDZ1?=
 =?utf-8?B?ZHl1Z3VMTktOZUViOFRiNkdTeUo5elVMZ2xtN2hrNUZjUkFUTXhmSmxqUFhL?=
 =?utf-8?B?WHNWY0U1M2NKR1BOYytzRHY5VmFqczNsNmRzWjd6akZqamxoaFFpRDlhaEF2?=
 =?utf-8?B?ZUdSMXp0SDFISjZXQVNtTG5WSUhidWxNNVc1eHEwYUgxc2grWHdjNW9ndmpn?=
 =?utf-8?B?OE9FcEZ3Ky9MTTdnVTlGUjNDUU94NEVzUTJsdVprSmVRUVBvWUNOSjB4TEpQ?=
 =?utf-8?B?cExueE1IWFZIVy9rbHBzN2NNeVV3aDBZMk9takNtL3lXSDhaUDFqZUdFNnhi?=
 =?utf-8?B?UUZ3ZGJ3cllhWXNDb0J6S3p5TTd6OU9OUTJ0eGY4SncvYURmVlc3TFpHNEQ3?=
 =?utf-8?B?SWVSbVhVWFIwK3UydUg0L09VVk1pQ0pMWDlyU0daRndKNXg3Rk5OQ1E3YTE2?=
 =?utf-8?B?aFJQeVNkU0x5bCtxdHlqMmYrV2kvZTdZSzdWeEJDS09qblBMRng0MGlTS0R5?=
 =?utf-8?B?bU1lNjhDM2hLZGVGNiszcTRwbEJ3OFM3V0xjOWNGSzNad0doV0lqSVhqMzF2?=
 =?utf-8?B?VGxPU0hSeW1nbFFJS2xGd1BlcmlvMTIyYXJ5K2Fvdk51MlRPbHB4MHdacWF4?=
 =?utf-8?B?djVMa1Z3eVNQT3BTMnA0dFZEbGgxU3E1bFR4bjc5aDRJcWlHS1FEaHhhNzlo?=
 =?utf-8?B?NklWMUQzbENybnhNOHMzOUs0WC8vYXYxbDVTS0xXYnFWMGJvNDFlZVJGOC9B?=
 =?utf-8?B?OE1pMWhRK3BWaVhGRXRzaXdNa3F3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ab5cc5-dd32-49cf-de6b-08ddf15186c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 16:37:41.1925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EctNwm0F4uVKgJymOrOm7fOniguprZymgAEowNdkVTLhmRuzdYsfz9J5TCuc4zUxA5VpdaWugOPO4ZMaUPmC9RHpmBVdP8EJ5QAngs4DkZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com

T24gVGh1LCBTZXAgMTEsIDIwMjUsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiDigKYNCj4gPiBU
aGlzIGNoYW5nZSBlbnN1cmVzIHRoYXQg4oCmDQo+IA0KPiBTZWUgYWxzbzoNCj4gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni4x
Ny1yYzUjbjk0DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg0KSGkgTWFya3VzLA0KDQpUaGFu
ayB5b3UgZm9yIHBvaW50aW5nIG91dCB0aGUgZG9jdW1lbnRhdGlvbiBndWlkZWxpbmVzLg0KcmV2
aXNlZCB0aGUgY29tbWl0IG1lc3NhZ2UgYWNjb3JkaW5nbHkgYW5kIHNlbnQgYSBWMiBwYXRjaC4N
CkkgYXBwcmVjaWF0ZSB5b3VyIGF0dGVudGlvbiB0byBwcm9wZXIgZG9jdW1lbnRhdGlvbiBjb21w
bGlhbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpLYXVzaGxlbmRyYQ0K

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E34084C;
	Thu, 17 Oct 2024 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146389; cv=fail; b=ZqP3UOr8654J4molZ4Qrk6jmsk1QCzy9wYbZnFr1gPSo6SRQWVRO+XwmnrCidto2JS1zAxMfGdChkzKNJS/PjEMwAEdS5pt8vUvqLhG5viy1FEQhlne0frN6LrxtvRG7/s0N1WOkySB0F3JIIa5xmNzb0I2JRp0xhAgTTT5bA+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146389; c=relaxed/simple;
	bh=OoFdnRGCxwm9GOMAMT7O93ZLVJ8S4sK+bDa7zNAhso4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GLebWs6z19UNeSdwG9rv4a0KrvVBp8+1M2bc/QbuBaw+vnoafig1N2UdMt5mEiQJxyky8jLrEmogHEjFhSTrp2uI9HK8JpInXE2ruSAzNci9YWaeNvqPdz+SlVOfhCkCvZDGy3Zu/b2RQ9zFS64KcVkICk9y0WLJRl+ng1a5D30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwW5w89q; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwW5w89q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729146383; x=1760682383;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OoFdnRGCxwm9GOMAMT7O93ZLVJ8S4sK+bDa7zNAhso4=;
  b=OwW5w89qZZyM7lZcw0CohyTOYsXmfl4WmhQZCW1fCZLzkbhaD6PNL6ba
   ayTFigyzkhImEQshGediwPppTmJB28dSSggau8G3IzNf5sQA1d94n1Hw9
   4+fngUuFUUokW1roysX0c9OWpJcEDUTjok45C4AIFRLqqNigwMvJhrEkW
   IbmJAp8GSE3bJnYnWq+y8uL/8v4uZ9MmJMmf+g7r0JgZhNDk4JkVaEmkV
   G3pLR4FVSAHmCT3Vu+QZMsS2dfVuVKoeyw/jJoykHuwVPkvyXdLpSpUkb
   BB166ORrzjfGYC44sJ5QT6Hhsld1fO4wAMWUwVfGTzPoDllo0/r0au22Q
   w==;
X-CSE-ConnectionGUID: ExTkGmUhRkyYgeM1oq6yrQ==
X-CSE-MsgGUID: owZ6m4FjRH+kzq9hv0jeMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="39255070"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="xz'341?scan'341,208,341";a="39255070"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:26:20 -0700
X-CSE-ConnectionGUID: H88aflD9QVuiruNRhKBDgg==
X-CSE-MsgGUID: t76sFDSkS72IgM40EiGeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="xz'341?scan'341,208,341";a="115884635"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 23:26:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:26:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:26:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 23:26:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 23:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxmhGf1GRm0ca8ETqy773WRYvtmipUfZjGWkW5bHhQc/VbNiu5AjMkTx18H7wlY207Qp5zKReJ+fNZ63xV7GzMY5h9qcRDCFNbA0cHZM9lAyKsTO9x0rZRnzNEmWbTm6+ziRq8W2RrHMQ7pemFGZkWnqYQhmHJOAxQWM+TUPEU0AichKEtxR1Jq0ndRiBIEuV0Dw5lgL4B1S5gvMQ7lVBv+PKS7ObUVzwfFZ127I5Lh2ozYqTVflC3PxBa3OWxZ80cfbr8bstPu54FU5qXWsd0yQjXffjwrO2ZCRwG4cgwGZJgDfW9ZCX4iIxBg7fF1GOi+hqBTS0qMpNFimXX8hOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEW1pAREjiQ7HQ/O2v1Gw9iuowH77t3pXA2IDC20ugg=;
 b=L/xu30y5qbz6cRw/x+l9s/vSnyNczTuVrWQJsZJ8HU1ZluMVXoILri7IfCFjv3IqROrsAOimIVrSeflu8AIZQMKQIAt+7J0WN+lobBxdW4s7pIBmLqAOnGD1qxeq8PuPHlYZsXp8OOsJXPn8UIzKJAMxUn+FBJ+7L1Q2OPEPd8ofjOkzIcgS0e9R3sbQ5poU9VXhV4nIJkMXojht+Wxwk91cGzr/5xIDP6eWr2QLO1zsShVRrDTlGYaI554NRF5TXRrAM5UKJuWoC3/U1yenWMRZwUynCqD01CRqOs41OKmGsD2fG9CG5zKF9rWGWl88RHB/u8vHVbz75DeAMVFHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 06:26:13 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:26:13 +0000
Date: Thu, 17 Oct 2024 14:26:04 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [peterz-queue:sched/lazy] [sched, x86]  74d850cd4c:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <ZxCt/JQkGZHo0n2o@xsang-OptiPlex-9020>
References: <202410151544.7d2292c6-lkp@intel.com>
 <20241016154048.sdiJ85Zc@linutronix.de>
 <b9d0af7f-0b1f-4f55-87a6-f64124f898b8@paulmck-laptop>
Content-Type: multipart/mixed; boundary="FcckSZQnOghRTLgP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9d0af7f-0b1f-4f55-87a6-f64124f898b8@paulmck-laptop>
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|CY8PR11MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 769b4918-b503-4baf-fe11-08dcee7498b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWVpc29QTXNxMFQzUEJENVczamtJcXQ3SDlOMElBUXdWQUtIZXdwZ2NaL0lP?=
 =?utf-8?B?dDZYenlWWFduelVVMkd3SHl4U0daSHk0SUEyc2J0WFFJalluUDBSNk5nT2Vv?=
 =?utf-8?B?TzBUNDdsc2p6WDV1Z2ZuTUovZUtGRDV1bG5XTmdnYm5vQ2RYbEFGRFI4MFVL?=
 =?utf-8?B?dmVWZ0hPMldZQiswdDA2cWNHT0RmUjR6b0x4bTBobHAwZnlEMlBXZ1VtQkdL?=
 =?utf-8?B?Wm41a29VYWhTRUJ1bENsVW1nNHkrY2tHcW9yZDhyQm1FMFl6ZVR6a2VUYWJn?=
 =?utf-8?B?dHJ5cFRaSkNydVI3UDN2alNlMFp4bUJqNXN2dzJkejlZcWE3SmZqNHg4a3VX?=
 =?utf-8?B?Y3dydzR5R0NQVVBQQ1I3aHVhZThiQXd5R1pqOWorQVg2QmRiMTJiZWNnUFRs?=
 =?utf-8?B?MkxqVTN2Yk83Zk5GcllZbVlkL3BESUcvaWo5MWNGTzQ2Sm5VV215dW5aWWE3?=
 =?utf-8?B?ZHBTbktjdkpUMnNqRm1odmhTU2FDTXQ5TGhvNk9SK2poYzd4U3NwbEJsQVBO?=
 =?utf-8?B?UkVTRms1MFN2clJHWkdveXRKQzRCak5vUGlibG5LdXhRS3AzMlpVVFVlSXFI?=
 =?utf-8?B?cEdpSlAweFNQeXV3V1BFaDMrcTArQnk2S3NwTWY5dmZpODh1WTJHdmtRU1VH?=
 =?utf-8?B?WHdoWTdhcmlsaktKaUpEVk9CdkpPN2xOeExHUHdOQnE3dDVsT1lWbFNSTWhC?=
 =?utf-8?B?RWlhTzlYcWRsa2l1cHBwSHVZOTJiRmhGNnpoRjdmYXdJci93UU4zVVJPbUxR?=
 =?utf-8?B?all0TFUycVJmbUtLWVZpUlFEYU1sWHlSN3MzWkZwc0U1Z3FsSG9OdjRTenV5?=
 =?utf-8?B?L2JLaUdJOTZDZTFKMmRVcGswNWxFWWF0bTZVY2gxQU5RdkRXelhMWXgxL3dZ?=
 =?utf-8?B?c0Z5bW41ZVBiK3ZudlRWckN0VnZzeWU1ODRNOWMwZlJrRDV2OTBuNmxzeUtO?=
 =?utf-8?B?MDhVTU11Yy91cXNEWG1lRWpnWWRjTnRmOVpEcWZEY3BFWUZwTGl3bjlEeGhz?=
 =?utf-8?B?c0RFWks2U0p0d0t1NFRteHliM0g3ZEVscUdXUmtNNkZ0V2FDbmNwZkxTeGla?=
 =?utf-8?B?WHpLWk9qL1hSWW01eTdIZlZWMjdHdmt5SFRic09WRVRaZ2d4NXpsczBrU05O?=
 =?utf-8?B?TW9vQTFGbHpuZlg2ZFNra050WFZuR3h6d2kwUFhCTEErYjcrOFZVaXZPVFdV?=
 =?utf-8?B?T0dyL3lHNUFXVS80YS9SSEYxblRudmM4SEZ6MnVkNkFTRHA1WVBwM2huckpv?=
 =?utf-8?B?Y25LUGZaS2ErUm9VYjNDRXE0cTJ1SUYyOXY5N3dkK1dZcjNKNkUzb1VKRWc1?=
 =?utf-8?B?RkhOOE9oV2VNR2JNd0JCSmVDMmxwUWFXaDVoN2xhdEtxcWFpbCtuY2VicXZV?=
 =?utf-8?B?VFo5djUxY1hXYnJaZU5NZ2dVZXo3eXo0em0xS3RXTHJZNjdCL2VtVHRRNVh5?=
 =?utf-8?B?cjhEWHl1WGFJdWJha2FQTG1kVG1pSnN0U2wrNTJiRkVjRVZybzU2S2ZLVi9a?=
 =?utf-8?B?TUcvbDVDeFl6MkxBR09qRCtzdDV2OC8zcDJaN1pNRjNPYXdsSDNya0ZCYmNE?=
 =?utf-8?B?WXRsTGdWWWFSenFLeHV3U2N1MjZ3ZFdhN2NCNWU2TExuWldXK3dIVW8rdlVQ?=
 =?utf-8?B?cEZIcGkwMERTRmtia3dybVVEREI2QXRNUkdtQnF2aDlnd2xIcnh4dWVkYzNo?=
 =?utf-8?B?NGp1blZDem96b215VFdwL2JGL1NkaHNSWHcyU3dsaVQ1V0xlSnlnTHArWGda?=
 =?utf-8?Q?YN6cYromdk3eEumYqFYFP2samxAcObqgZRNrG+k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFd3cUxFZ3g2eGg3YkZWUytQb0pZQ3hBbFhiVGRTclJTajZyZWRLMzlFSjNw?=
 =?utf-8?B?OURpZmVhUy80bmdGQU0xOWxSYWtFSHpDWkh0b3RrallqQWVLQ0llTElyWlYx?=
 =?utf-8?B?OUVBaUNVVlhrL0t0SStPN1hpSTVOYkp4SkpZcFpOaFpzOGlndFYwNW5IbDBP?=
 =?utf-8?B?cVY4cGthTExUT3BkL2xtTTA0S2djb1dialdXcnVnYnEzTWxlMHhjTHFpd0FS?=
 =?utf-8?B?dDJQQU9Cd1lvbFdwVHhJSit1SzgxV25sbFFCVFo0UE9WcWl2eHNqNjVMSDhF?=
 =?utf-8?B?YUo0bDdaYkpBRDVaM2J0aW5rVlo3S2JCTWtQQlhzazR1THdobVEzZlUwY2JU?=
 =?utf-8?B?T2NYTkVCUGxWc0FoQVRxRkdGaElEL25uVmNFTW1sanZPdHVYeVphYU9HNzVo?=
 =?utf-8?B?ai95TXlXd0hzOVNub3ZjUHB1RTR6dWJEZXg1Zk1XdUdjTEJidzU3QVRTVXZl?=
 =?utf-8?B?dVdOVFZ1UmZsTjRTM0VmS2UwZWpTc0NQamZWOVE4b1lCYXlvbDJLazltOHJh?=
 =?utf-8?B?QjJ1QitnRSttT2RWU1VsNExKUStyaDZod2F5N2hzMERlQnQ1WHMvNlhSUG9l?=
 =?utf-8?B?NHBDRk9kRDUrTGhOM1dvYUY0SVFXSTVMaFJmWDRWTVVrbElMeGhBTUFpQ0FD?=
 =?utf-8?B?NWdiaFFER3B6cWtrY090ZE9pRCtwWmpVN0Qrd1RLQ0JmTEl0Z1BmUXFUa2sy?=
 =?utf-8?B?aHpZVFVndDkvempMK1lKaGVUTGtLcGVKd0h4enNhdkl6TXFGRVJhNldGUHk4?=
 =?utf-8?B?VDkrS0dkdnhyenl6emZHVGs2dHFsZlhnWldacEFFWVVzQ3NaZzY1Ym1wc3p3?=
 =?utf-8?B?R1ZyWjhuV0RVOUFGN3drMjVyQUFwYzlyalpOSkJ5VmhPVW9jMXhlR3lxNGZB?=
 =?utf-8?B?S3c2b01seVhteW1kRE1VcXVLZklONW1zNDlIbExiMjQxMElnK2ptN0JLWnRi?=
 =?utf-8?B?TjNKUHFQanY5UDd1MXFFOVVBOGN2QlgrMkF3dzUxb2lCSlQrSFpiZmZZVm9M?=
 =?utf-8?B?UWRST3dQbUZjYkowODV4L1V2QkU0RWVnQ3k5cmxTNGltWkNOUnI0MHlLbTBv?=
 =?utf-8?B?RDV2U3lJZGtPMXJwYVdLZzBFVjJVTzBTYnZmeVZDLzlLdWc2MnNCTmJXL2ZR?=
 =?utf-8?B?dXdReE16UWN0b2RtQXpsTmUzTkFyLzE5NGVYMk9qeXZHS3ZucUsvVXV1aG9t?=
 =?utf-8?B?Y2FrSUVjM25wNS9aL0hEQXk1UGc0UzloSmMxa2NZczNyOE9jOERGT3BFQ2FL?=
 =?utf-8?B?d1dDRWtyZEhQYVVPSnFVaEJHckd1VkZrSDVKb1N6NEpsdHZFN1Nmdm4rdC9k?=
 =?utf-8?B?L2UyR29PNi81REVlZm9ETG5pVitNMEhYQjBLL3dIc3IvdlZHVGdMUmMvVm91?=
 =?utf-8?B?ZlQ4TVFUM1NEMUpZYWp4U3lHVVhDTnZPRnNvclc2Y1BTRjVySjBpbFAwRE5k?=
 =?utf-8?B?anhMWGZtWWlxcjVGaEs3TnBZZHBuTzdlU0JnUTRrcDJ1UEVaK0tYRzRLSEVu?=
 =?utf-8?B?MFh2K21UVXFWL0ljOUdHT0pRQnJXTXNGWjltLzB6WUR0MEUvTHRmVS9SWXVU?=
 =?utf-8?B?K29JRnBpeEZaK3dNek13WERlVE5obGprZVlNQ0VEU2ZhVkdvdjRwUUJCQXdQ?=
 =?utf-8?B?ZEt2MzhTUWhDUjZXSWpuOVZGV1hmU3ZmQ3Jiakc3Y3doZUNQZTJNblUvVm5W?=
 =?utf-8?B?MXVWWWRQOHlEM3FVZlV6b2QrSUZ5QkNZMThyWG5ldm1RT3FzaGtUMHkzeEF2?=
 =?utf-8?B?YVdpaWsxdlo2S3NleHpEUlV4bGttZGZoNnBldUIvNUlsVmVHK24rTG4zc0Nm?=
 =?utf-8?B?bjNSMWZNTDlTcXl1dWdVTXVtZGZtbWZBTUxOSzlHMDZTMzFMSmFMaXNxVGQv?=
 =?utf-8?B?bHFYVWlwa0o5UzdBeXB1Zmpob0ZrK1B6eW9QR3Nwb0YrSFBSZDB5QkhzSCsy?=
 =?utf-8?B?aTh6b1MvelVtYzlWdWxoNElBb0hrTWRjOGxDVGp0Y2xzbHBJanhyZmlVZ21B?=
 =?utf-8?B?MFBKOFJEY0cxK2VsWGRYeGxhN2Q5RG9nbjJHd09xK1JnYWVrb1pIeTU5dm9m?=
 =?utf-8?B?eUxMVTFPVisvNW5pWlJ2STUxS1ZqcEhoZ1E2dXNNZS90dVpXa3BINFpCRm56?=
 =?utf-8?B?Q0FTalVIYnFKMjY0Ym1jUkZsZ1ZiUVA0VDZNbjV3bVFnQUlaRU9CWTF2RlZE?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 769b4918-b503-4baf-fe11-08dcee7498b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:26:13.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4ow8ie6a1NXereXrwLHkpYtuXdWyLPMbl+X+m7volWdP1UP7VBB9dFJB5xySfM2EgICIwXvscbCBAxgTq8Mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898
X-OriginatorOrg: intel.com

--FcckSZQnOghRTLgP
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Paul,

On Wed, Oct 16, 2024 at 09:12:35AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 16, 2024 at 05:40:48PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-15 15:47:20 [+0800], kernel test robot wrote:
> > > Hello,
> > Hi,
> > 
> > it took me a while to reproduce this because it does not trigger without
> > the ltp userland and this is not downloaded properly so I had to
> > workaround it. However…
> > 
> > > [   98.006999][  T543] busted-torture: rtc: 00000000639e821e ver: 6796 tfle: 0 rta: 6796 rtaf: 0 rtf: 6787 rtmbe: 1 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 89 barrier: 0/0:0 read-exits: 64 nocb-toggles: 0:0
> > > [   98.017386][  T543] busted-torture: !!! 
> > > [   98.017662][  T543] ------------[ cut here ]------------
> > > [   98.019330][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2258 rcu_torture_stats_print+0x24c/0x610 [rcutorture]
> > > [   98.021831][  T543] Modules linked in: rcutorture torture
> > …
> > > [   98.237025][  T543] ------------[ cut here ]------------
> > > [   98.238052][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2263 rcu_torture_stats_print+0x373/0x610 [rcutorture]
> > > [   98.240000][  T543] Modules linked in: rcutorture torture
> > …
> > 
> > It took me a while to figure out that this test is using
> > rcu_busted_torture_deferred_free() which in turn invokes the callback
> > before the grace period. Buh.
> > So it looks like LAZY preempt triggers this more reliably than the
> > normal preempt version…
> 
> Agreed!
> 
> Please don't run any rcutorture scenario whose name contains "BUSTED"
> or "busted" unless you are trying to test rcutorture's ability to find
> broken RCU implementations.

thanks for information!

we will refine our test to avoid rcutorture 'busted' related testing.


BTW, for this commit, our bot finished several bisect. we happened to report
based on this 300s-cpuhotplug-busted test since we found the parent is quite
clean:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-12-x86_64-20240206.cgz/x86_64-randconfig-014-20241011/clang-18/300s/cpuhotplug/busted

693ed5cdf46ac062 74d850cd4c5bc26ce83511b4247
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     rcutorture.cpuhotplug-busted.fail
           :6          100%           6:6     dmesg.RIP:rcu_torture_stats_print[rcutorture]
           :6          100%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]


in fact, we found this commit also causes some new issues in other tests, such
like below 300s-cpuhotplug-trivial test


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/x86_64-randconfig-103-20241011/gcc-12/300s/cpuhotplug/trivial

693ed5cdf46ac062 74d850cd4c5bc26ce83511b4247
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6            0%           6:6     dmesg.RIP:rcu_torture_stats_print[rcutorture]
          6:6            0%           6:6     dmesg.RIP:synchronize_rcu_trivial[rcutorture]
           :6          100%           6:6     dmesg.RIP:torture_sched_setaffinity
          6:6            0%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
          6:6            0%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#synchronize_rcu_trivial[rcutorture]
           :6          100%           6:6     dmesg.WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity    <------ new stat


the config for this 300s-cpuhotplug-trivial test is attached as
config-6.12.0-rc1-00037-g74d850cd4c5b
which is a randconfig, too

it has diff with config from parent as below [1]

also attached a full dmesg, from it:

[   92.540279][  T461] ------------[ cut here ]------------
[   92.540718][  T461] torture_sched_setaffinity: sched_setaffinity(461) returned -22
[   92.541280][  T461] WARNING: CPU: 0 PID: 461 at kernel/rcu/update.c:535 torture_sched_setaffinity+0x3b/0x4f
[   92.541998][  T461] Modules linked in: rcutorture torture crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni sha1_ssse3 rapl bochs drm_vram_helper
 drm_ttm_helper evbug ttm input_leds drm_kms_helper serio_raw qemu_fw_cfg drm ipv6
[   92.543610][  T461] CPU: 0 UID: 0 PID: 461 Comm: rcu_torture_fak Tainted: G        W       T  6.12.0-rc1-00037-g74d850cd4c5b #1
[   92.544421][  T461] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   92.544781][  T461] RIP: 0010:torture_sched_setaffinity+0x3b/0x4f
[   92.545216][  T461] Code: c0 74 29 80 3d cd 7b d5 01 00 75 20 89 c1 c6 05 c2 7b d5 01 01 89 ea 48 c7 c6 c0 92 01 82 48 c7 c7 a6 03 5d 82 e8 2a 26 f7 ff <0
f> 0b 48 63 c3 5b 5d 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc f3 0f
[   92.546555][  T461] RSP: 0018:ffffc90001cf3e70 EFLAGS: 00210246
[   92.546995][  T461] RAX: 0000000000000000 RBX: ffffffffffffffea RCX: 0000000000000000
[   92.547568][  T461] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   92.551112][  T461] RBP: 00000000000001cd R08: 0000000000000000 R09: 0000000000000000
[   92.551698][  T461] R10: 0000000000000000 R11: 5f65727574726f74 R12: 0000000000000002
[   92.552290][  T461] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90001fbbb50
[   92.552867][  T461] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   92.553467][  T461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.553909][  T461] CR2: 00000000f6a3e040 CR3: 000000011fd2f000 CR4: 00000000000406b0
[   92.554446][  T461] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   92.555018][  T461] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   92.555555][  T461] Call Trace:
[   92.555809][  T461]  <TASK>
[   92.556024][  T461]  ? __warn+0xa1/0x16e
[   92.556327][  T461]  ? torture_sched_setaffinity+0x3b/0x4f
[   92.556726][  T461]  ? report_bug+0x13b/0x1d1
[   92.557070][  T461]  ? handle_bug+0x53/0x8c
[   92.557390][  T461]  ? exc_invalid_op+0x17/0x74
[   92.557732][  T461]  ? asm_exc_invalid_op+0x1a/0x20
[   92.558140][  T461]  ? torture_sched_setaffinity+0x3b/0x4f
[   92.558558][  T461]  synchronize_rcu_trivial+0x67/0xaf [rcutorture]
[   92.559068][  T461]  ? rcu_lock_release+0xc/0xc [rcutorture]
[   92.559494][  T461]  rcu_torture_fakewriter+0x264/0x469 [rcutorture]
[   92.559972][  T461]  kthread+0xff/0x107
[   92.560271][  T461]  ? list_del_init+0x2e/0x2e
[   92.560608][  T461]  ret_from_fork+0x23/0x35
[   92.560943][  T461]  ? list_del_init+0x2e/0x2e
[   92.561294][  T461]  ret_from_fork_asm+0x11/0x20
[   92.561665][  T461]  </TASK>
[   92.561899][  T461] irq event stamp: 36775
[   92.562218][  T461] hardirqs last  enabled at (36783): [<ffffffff8111d295>] __up_console_sem+0x4e/0x5a
[   92.562956][  T461] hardirqs last disabled at (36792): [<ffffffff8111d27a>] __up_console_sem+0x33/0x5a
[   92.563663][  T461] softirqs last  enabled at (36554): [<ffffffff810b148d>] handle_softirqs+0x393/0x3e0
[   92.564375][  T461] softirqs last disabled at (36539): [<ffffffff810b1594>] __irq_exit_rcu+0x52/0xac
[   92.565083][  T461] ---[ end trace 0000000000000000 ]---



[1]
--- /pkg/linux/x86_64-randconfig-103-20241011/gcc-12/693ed5cdf46ac062aa7713700c77019c60f0ae41/.config   2024-10-12 20:01:25.345180715 +0800
+++ /pkg/linux/x86_64-randconfig-103-20241011/gcc-12/74d850cd4c5bc26ce83511b4247ea786eb73217c/.config   2024-10-12 16:00:42.428850680 +0800
@@ -121,12 +121,15 @@ CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
 # CONFIG_BPF_PRELOAD is not set
 # end of BPF subsystem

-CONFIG_PREEMPT_NONE_BUILD=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_BUILD=y
+CONFIG_ARCH_HAS_PREEMPT_LAZY=y
+# CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_PREEMPT_LAZY=y
 # CONFIG_PREEMPT_RT is not set
 CONFIG_PREEMPT_COUNT=y
+CONFIG_PREEMPTION=y
 # CONFIG_PREEMPT_DYNAMIC is not set
 CONFIG_SCHED_CORE=y

@@ -148,6 +151,7 @@ CONFIG_HAVE_SCHED_AVG_IRQ=y
 # RCU Subsystem
 #
 CONFIG_TREE_RCU=y
+CONFIG_PREEMPT_RCU=y
 CONFIG_RCU_EXPERT=y
 CONFIG_TREE_SRCU=y
 CONFIG_TASKS_RCU_GENERIC=y
@@ -162,6 +166,9 @@ CONFIG_RCU_STALL_COMMON=y
 CONFIG_RCU_NEED_SEGCBLIST=y
 CONFIG_RCU_FANOUT=64
 CONFIG_RCU_FANOUT_LEAF=16
+CONFIG_RCU_BOOST=y
+CONFIG_RCU_BOOST_DELAY=500
+# CONFIG_RCU_EXP_KTHREAD is not set
 # CONFIG_RCU_NOCB_CPU is not set
 # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
 # CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
@@ -6722,6 +6729,7 @@ CONFIG_SCHEDSTATS=y
 # end of Scheduler Debugging

 # CONFIG_DEBUG_TIMEKEEPING is not set
+CONFIG_DEBUG_PREEMPT=y

 #
 # Lock Debugging (spinlocks, mutexes, etc...)
@@ -6820,6 +6828,7 @@ CONFIG_FTRACE=y
 # CONFIG_FUNCTION_TRACER is not set
 # CONFIG_STACK_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_HWLAT_TRACER is not set
 # CONFIG_OSNOISE_TRACER is not set


> 
> 							Thanx, Paul
> 

--FcckSZQnOghRTLgP
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.12.0-rc1-00037-g74d850cd4c5b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.12.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_RUSTC_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=127
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=m
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_LAZY=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_NEED_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_EXP_KTHREAD is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_GROUP_SCHED_WEIGHT=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_UCLAMP_TASK_GROUP=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_FORCE=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_SMALL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_CACHESTAT_SYSCALL is not set
# CONFIG_PC104 is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_RESERVE=y
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
# CONFIG_CRASH_HOTPLUG is not set
# end of Kexec and crash features
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_FRED=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
CONFIG_MPSC=y
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=7
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_HAVE_PAE=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_GART_IOMMU=y
CONFIG_BOOT_VESA_SUPPORT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_ACPI_MADT_WAKEUP=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_LATE_LOADING=y
# CONFIG_MICROCODE_LATE_FORCE_MINREV is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_CET=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_ARCH_PKEY_BITS=4
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_USER_SHADOW_STACK is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SELECTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_ADDRESS_MASKING=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_NAMED_AS=y
CONFIG_USE_X86_SEG_SUPPORT=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CPU_MITIGATIONS=y
# CONFIG_MITIGATION_PAGE_TABLE_ISOLATION is not set
CONFIG_MITIGATION_RETPOLINE=y
CONFIG_MITIGATION_RETHUNK=y
# CONFIG_MITIGATION_UNRET_ENTRY is not set
# CONFIG_MITIGATION_CALL_DEPTH_TRACKING is not set
CONFIG_MITIGATION_IBPB_ENTRY=y
CONFIG_MITIGATION_IBRS_ENTRY=y
CONFIG_MITIGATION_SRSO=y
CONFIG_MITIGATION_SLS=y
# CONFIG_MITIGATION_GDS is not set
CONFIG_MITIGATION_RFDS=y
CONFIG_MITIGATION_SPECTRE_BHI=y
# CONFIG_MITIGATION_MDS is not set
CONFIG_MITIGATION_TAA=y
CONFIG_MITIGATION_MMIO_STALE_DATA=y
CONFIG_MITIGATION_L1TF=y
CONFIG_MITIGATION_RETBLEED=y
CONFIG_MITIGATION_SPECTRE_V1=y
CONFIG_MITIGATION_SPECTRE_V2=y
CONFIG_MITIGATION_SRBDS=y
CONFIG_MITIGATION_SSB=y
CONFIG_ARCH_HAS_ADD_PAGES=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_THERMAL_LIB=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NHLT=y
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
# CONFIG_DPTF_PCH_FIVR is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_ACPI_PFRUT=m
# CONFIG_ACPI_PCC is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
CONFIG_X86_X32_ABI=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_VAES=y
CONFIG_AS_VPCLMULQDQ=y
CONFIG_AS_WRUSS=y
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y
CONFIG_ARCH_HAS_DMA_OPS=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_SUPPORTS_RT=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_WRITE_MOUNTED is not set
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
CONFIG_ZSWAP_SHRINKER_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="zstd"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD_DEPRECATED=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# Slab allocator options
#
CONFIG_SLUB=y
CONFIG_SLUB_TINY=y
CONFIG_SLAB_MERGE_DEFAULT=y
# end of Slab allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
CONFIG_HAVE_GUP_FAST=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SPLIT_PTE_PTLOCKS=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_SPLIT_PMD_PTLOCKS=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=8
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MEMFD_CREATE=y
# CONFIG_SECRETMEM is not set
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_LRU_GEN_STATS=y
CONFIG_LRU_GEN_WALKS_MMU=y
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y
CONFIG_EXECMEM=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_XGRESS=y
CONFIG_SKB_EXTENSIONS=y
CONFIG_NET_DEVMEM=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
# CONFIG_XDP_SOCKETS is not set
# CONFIG_NET_HANDSHAKE_KUNIT_TEST is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_SIGPOOL=y
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
# CONFIG_IPV6_PIMSM_V2 is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_RPL_LWTUNNEL=y
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

# CONFIG_IP_SCTP is not set
CONFIG_RDS=y
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_GARP=y
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_ATALK=y
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
# CONFIG_6LOWPAN_NHC_UDP is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_MQPRIO_LIB=y
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_SFQ=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="sfq"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=m
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=y
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=y
# CONFIG_NET_IFE_SKBTCINDEX is not set
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=y
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
# CONFIG_QRTR_SMD is not set
# CONFIG_QRTR_TUN is not set
# CONFIG_NET_NCSI is not set
# CONFIG_PCPU_DEV_REFCNT is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_RPS is not set
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
# CONFIG_BQL is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_MTK=m
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIDTL1=m
# CONFIG_BT_HCIBT3C is not set
CONFIG_BT_HCIBLUECARD=m
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
CONFIG_BT_VIRTIO=m
# CONFIG_BT_NXPUART is not set
# CONFIG_BT_INTEL_PCIE is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_VIRTUAL_NCI is not set
CONFIG_NFC_FDP=m
# CONFIG_NFC_FDP_I2C is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_PN532_UART is not set
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
# CONFIG_NETDEV_ADDR_LIST_TEST is not set
CONFIG_NET_TEST=m

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIEAER_CXL is not set
CONFIG_PCIE_ECRC=y
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_NPEM is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCI_MESON=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers

#
# PLDA-based PCIe controllers
#
# end of PLDA-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
# CONFIG_CXL_REGION is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=m
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DM_KUNIT_TEST=m
CONFIG_DRIVER_PE_KUNIT_TEST=m
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_KUNIT=m
CONFIG_REGMAP_BUILD=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_RAM=m
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y
CONFIG_EFI_RCI2_TABLE=y
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
CONFIG_MTD_SWAP=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=m
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_CAFE=m
# CONFIG_MTD_NAND_MXIC is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_NAND_ARASAN=m

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=m
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_SPI_NAND=m

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_UBI_NVMEM=m
CONFIG_MTD_HYPERBUS=m
CONFIG_DTC=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_ZRAM_DEF_COMP="unset-value"
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_DEBUGFS is not set
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=y
CONFIG_RPMB=m
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_SMPRO_ERRMON=y
CONFIG_SMPRO_MISC=y
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=m
CONFIG_TPS6594_ESM=m
CONFIG_TPS6594_PFSM=m
CONFIG_NSM=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_INTEL_MEI_VSC_HW=y
CONFIG_INTEL_MEI_VSC=y
CONFIG_INTEL_MEI_HDCP=m
CONFIG_INTEL_MEI_PXP=m
CONFIG_VMWARE_VMCI=m
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
CONFIG_BCM_VK=m
# CONFIG_BCM_VK_TTY is not set
CONFIG_MISC_ALCOR_PCI=m
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
CONFIG_PVPANIC_PCI=y
CONFIG_GP_PCI1XXXX=y
CONFIG_KEBA_CP500=m
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=m
# CONFIG_SCSI is not set
CONFIG_SCSI_LIB_KUNIT_TEST=m
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=m
CONFIG_ISCSI_TARGET=m
CONFIG_SBP_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_KUNIT_UAPI_TEST is not set
CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=m
CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST=m
CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_KUNIT_OHCI_SERDES_TEST=m
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_PFCP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NETKIT is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_PDS_CORE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_IDPF is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_OCTEON_EP_VF is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_META=y
# CONFIG_FBNIC is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_LAN865X is not set
# CONFIG_VCAP is not set
# CONFIG_FDMA is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
# CONFIG_OA_TC6 is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_RTASE is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
# CONFIG_TEHUTI_TN40 is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_KUNIT_TEST=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
# CONFIG_TOUCHSCREEN_DA9052 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_ILITEK=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=m
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_PCAP is not set
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_IQS7211=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_TOUCHSCREEN_HIMAX_HX83112B=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=m
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_ZHAOXIN is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_CORE is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEBA is not set
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PCI1XXXX=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_DFL is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_CS42L43=m
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_INTEL=y
CONFIG_SPI_INTEL_PCI=y
CONFIG_SPI_INTEL_PLATFORM=y
# CONFIG_SPI_MICROCHIP_CORE is not set
CONFIG_SPI_MICROCHIP_CORE_QSPI=m
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PCI1XXXX is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_MXIC=y
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
CONFIG_SPMI_HISI3670=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_CY8C95X0=m
CONFIG_PINCTRL_DA9062=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_CS42L43=m

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_INTEL_PLATFORM=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_METEORPOINT=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=m
CONFIG_GPIO_SWNODE_UNDEFINED=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRANITERAPIDS=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_FXL6408=m
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TPS68470=m
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

#
# GPIO Debugging utilities
#
CONFIG_GPIO_VIRTUSER=m
# end of GPIO Debugging utilities

CONFIG_W1=m
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_AMD_AXI=m
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# CONFIG_W1_MASTER_UART is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SEQUENCING=m
# CONFIG_POWER_SEQUENCING_QCOM_WCN is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_IP5XXX_POWER=y
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
CONFIG_BATTERY_88PM860X=m
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1720X=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_MT6360=m
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_RT9467=y
CONFIG_CHARGER_RT9471=m
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_FUEL_GAUGE_MM8013=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_SMPRO is not set
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_ASUS_ROG_RYUJIN=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=m
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_CHIPCAP2=m
CONFIG_SENSORS_CORSAIR_CPRO=m
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_HS3001=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LENOVO_EC is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2991 is not set
CONFIG_SENSORS_LTC2992=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_LTC4282=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX127=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
CONFIG_MAX31827=m
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MC34VR500=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT6775_I2C=m
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ACBEL_FSG032=m
CONFIG_SENSORS_ADM1266=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_ADP1050=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
CONFIG_SENSORS_DELTA_AHE50DC_FAN=m
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=m
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_LTC4286=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2856=m
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2891=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP2993 is not set
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_MP5920=m
CONFIG_SENSORS_MP5990=m
CONFIG_SENSORS_MP9941=m
# CONFIG_SENSORS_MPQ7932 is not set
CONFIG_SENSORS_MPQ8785=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TDA38640=m
CONFIG_SENSORS_TDA38640_REGULATOR=y
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDP710=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PT5161L is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SY7636A=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_SPD5118=m
CONFIG_SENSORS_SPD5118_DETECT=y
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m
CONFIG_SENSORS_XGENE=m
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_SENSORS_ASUS_WMI=m
CONFIG_SENSORS_ASUS_EC=m
CONFIG_SENSORS_HP_WMI=m
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_DEBUGFS=y
# CONFIG_THERMAL_CORE_TESTING is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_INTEL_TCC_COOLING is not set
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_MLX_WDT=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=m
CONFIG_ADVANTECH_EC_WDT=y
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_EXAR_WDT=y
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_SMPRO=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CS42L43=m
CONFIG_MFD_CS42L43_I2C=m
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=y
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77541=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_OCELOT=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=m
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS6594=m
CONFIG_MFD_TPS6594_I2C=m
# CONFIG_MFD_TPS6594_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_CS40L50_CORE=y
CONFIG_MFD_CS40L50_I2C=m
CONFIG_MFD_CS40L50_SPI=y
CONFIG_RAVE_SP_CORE=m
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_SPI=y
CONFIG_MFD_INTEL_M10_BMC_PMCI=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_NETLINK_EVENTS=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AW37503=y
CONFIG_REGULATOR_AXP20X=m
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77503 is not set
CONFIG_REGULATOR_MAX77541=m
CONFIG_REGULATOR_MAX77857=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8925=m
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX20086=y
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RAA215300=y
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4803=m
CONFIG_REGULATOR_RT4831=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5120=y
CONFIG_REGULATOR_RT5190A=m
# CONFIG_REGULATOR_RT5739 is not set
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6190=m
CONFIG_REGULATOR_RT6245=m
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_RTQ2208 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_SY7636A=m
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS68470=m
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_DVB_CORE is not set
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
CONFIG_V4L2_CCI=y
CONFIG_V4L2_CCI_I2C=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SI4713=y
CONFIG_RADIO_SI476X=y
CONFIG_RADIO_TEA5764=y
CONFIG_RADIO_TEA5764_XTAL=y
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_WL1273=m
CONFIG_RADIO_SI470X=y
CONFIG_I2C_SI470X=y
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=y
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=m

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
CONFIG_VIDEO_CAFE_CCIC=m

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# Nuvoton media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Raspberry Pi media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#
CONFIG_VIDEO_VIA_CAMERA=m

#
# Xilinx media platform drivers
#
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=m
CONFIG_VIDEO_VICODEC=y
CONFIG_VIDEO_VIMC=y
CONFIG_VIDEO_VIVID=y
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VISL=y
CONFIG_VISL_DEBUGFS=y
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m
# CONFIG_VIDEO_CAMERA_SENSOR is not set

#
# Camera ISPs
#
# CONFIG_VIDEO_THP7312 is not set
# end of Camera ISPs

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9719=y
CONFIG_VIDEO_DW9768=m
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=m
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_SONY_BTF_MPX=y
CONFIG_VIDEO_TDA1997X=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
CONFIG_VIDEO_TC358746=y
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9900=m
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Video serializers and deserializers
#
# end of Video serializers and deserializers

#
# Media SPI Adapters
#
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=m
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_SCREEN_INFO=y
CONFIG_VIDEO=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
# CONFIG_LCD2S is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_LINEDISP=m
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
# CONFIG_MAX6959 is not set
# CONFIG_SEG_LED_GPIO is not set
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_KUNIT_TEST is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_PANIC is not set
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=m
# CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_TTM=m
CONFIG_DRM_EXEC=m
CONFIG_DRM_GPUVM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
# CONFIG_DRM_AMDGPU is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_NOUVEAU_GSP_DEFAULT=y
# CONFIG_DRM_I915 is not set
CONFIG_DRM_XE=m
CONFIG_DRM_XE_DISPLAY=y
CONFIG_DRM_XE_FORCE_PROBE=""

#
# drm/Xe Debugging
#
# CONFIG_DRM_XE_WERROR is not set
# CONFIG_DRM_XE_DEBUG is not set
CONFIG_DRM_XE_DEBUG_VM=y
# CONFIG_DRM_XE_DEBUG_SRIOV is not set
CONFIG_DRM_XE_DEBUG_MEM=y
# CONFIG_DRM_XE_KUNIT_TEST is not set
CONFIG_DRM_XE_LARGE_GUC_BUFFER=y
CONFIG_DRM_XE_USERPTR_INVAL_INJECT=y
# end of drm/Xe Debugging

#
# drm/xe Profile Guided Optimisation
#
CONFIG_DRM_XE_JOB_TIMEOUT_MAX=10000
CONFIG_DRM_XE_JOB_TIMEOUT_MIN=1
CONFIG_DRM_XE_TIMESLICE_MAX=10000000
CONFIG_DRM_XE_TIMESLICE_MIN=1
CONFIG_DRM_XE_PREEMPT_TIMEOUT=640000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MAX=10000000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MIN=1
# CONFIG_DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT is not set
# end of drm/xe Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_AUO_A030JTN01=m
CONFIG_DRM_PANEL_ILITEK_ILI9341=m
CONFIG_DRM_PANEL_ORISETECH_OTA5601A=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_BOCHS=m
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
CONFIG_DRM_SIMPLEDRM=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9163=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_ILI9486=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_SSD130X=m
CONFIG_DRM_SSD130X_I2C=m
CONFIG_DRM_SSD130X_SPI=m
CONFIG_DRM_PRIVACY_SCREEN=y
# CONFIG_DRM_WERROR is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=m
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=m
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DEVICE=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYSMEM_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_FOPS=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_KTD2801=m
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3509 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_MP3309C is not set
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_CORE_TEST=m
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
CONFIG_SND_PCM_XRUN_DEBUG=y
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_CTL_DEBUG is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_UTIMER=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CIRRUS_SCODEC=m
# CONFIG_SND_HDA_CIRRUS_SCODEC_KUNIT_TEST is not set
CONFIG_SND_HDA_SCODEC_CS35L41=m
CONFIG_SND_HDA_CS_DSP_CONTROLS=m
CONFIG_SND_HDA_SCODEC_COMPONENT=m
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=m
CONFIG_SND_HDA_SCODEC_CS35L56=m
# CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set
CONFIG_SND_HDA_SCODEC_CS35L56_SPI=m
CONFIG_SND_HDA_SCODEC_TAS2781_I2C=m
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_SENARYTECH=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_BUILD=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
# CONFIG_SND_SOC_CARD_KUNIT_TEST is not set
# CONFIG_SND_SOC_UTILS_KUNIT_TEST is not set
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_ADI=y
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
CONFIG_SND_SOC_ADI_AXI_SPDIF=y
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_SOC_AMD_ST_ES8336_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
CONFIG_SND_SOC_AMD_ACP6x=m
CONFIG_SND_SOC_AMD_YC_MACH=m
CONFIG_SND_AMD_ACP_CONFIG=y
CONFIG_SND_SOC_AMD_ACP_COMMON=y
CONFIG_SND_SOC_AMD_ACP_PDM=y
CONFIG_SND_SOC_AMD_ACP_LEGACY_COMMON=y
CONFIG_SND_SOC_AMD_ACP_I2S=y
CONFIG_SND_SOC_AMD_ACP_PCM=y
# CONFIG_SND_SOC_AMD_ACP_PCI is not set
CONFIG_SND_AMD_ASOC_RENOIR=m
# CONFIG_SND_AMD_ASOC_REMBRANDT is not set
CONFIG_SND_AMD_ASOC_ACP63=y
CONFIG_SND_AMD_ASOC_ACP70=m
CONFIG_SND_SOC_AMD_MACH_COMMON=y
CONFIG_SND_SOC_AMD_LEGACY_MACH=y
CONFIG_SND_SOC_AMD_SOF_MACH=y
CONFIG_SND_AMD_SOUNDWIRE_ACPI=y
CONFIG_SND_SOC_AMD_RPL_ACP6x=y
CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL=y
CONFIG_SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y
CONFIG_SND_SOC_AMD_PS=y
# CONFIG_SND_SOC_AMD_PS_MACH is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=m
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_SOC_CHV3_I2S=y
# CONFIG_SND_I2S_HI6210_I2S is not set
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219=m
CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_ES8336 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=m
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT274=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5514=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5663=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=m
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ARIZONA=m
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
CONFIG_SND_SOC_ADAU1372_SPI=y
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=m
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4619=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_AW88395_LIB=y
# CONFIG_SND_SOC_AW88395 is not set
CONFIG_SND_SOC_AW88261=y
CONFIG_SND_SOC_AW87390=y
CONFIG_SND_SOC_AW88399=y
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CHV3_CODEC=y
CONFIG_SND_SOC_CS_AMP_LIB=m
CONFIG_SND_SOC_CS_AMP_LIB_TEST=m
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_SPI=m
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_SPI=y
CONFIG_SND_SOC_CS35L45_I2C=y
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
CONFIG_SND_SOC_CS35L56_I2C=m
# CONFIG_SND_SOC_CS35L56_SPI is not set
CONFIG_SND_SOC_CS40L50=y
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L43=m
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS42L83 is not set
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=m
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CS530X=y
CONFIG_SND_SOC_CS530X_I2C=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8311=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8326=y
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_IDT821034=y
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98520=m
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98388=y
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX98396=y
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_PCM6240 is not set
# CONFIG_SND_SOC_PEB2466 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1019=y
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5651=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT5682S=y
CONFIG_SND_SOC_RT9120=m
CONFIG_SND_SOC_RTQ9128=y
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIMPLE_MUX=m
# CONFIG_SND_SOC_SMA1303 is not set
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SRC4XXX_I2C=m
CONFIG_SND_SOC_SRC4XXX=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
# CONFIG_SND_SOC_TAS2780 is not set
CONFIG_SND_SOC_TAS2781_COMLIB=m
CONFIG_SND_SOC_TAS2781_FMWLIB=m
CONFIG_SND_SOC_TAS2781_I2C=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_WCD_CLASSH=m
CONFIG_SND_SOC_WCD9335=m
CONFIG_SND_SOC_WM5102=m
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
# CONFIG_SND_SOC_WM8731_SPI is not set
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8804_SPI=y
CONFIG_SND_SOC_WM8903=y
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_MAX9759=m
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6357=m
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8821=y
CONFIG_SND_SOC_NAU8822=m
# CONFIG_SND_SOC_NAU8824 is not set
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_X86 is not set
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_GOODIX_SPI=m
CONFIG_HID_GOOGLE_STADIA_FF=m
CONFIG_HID_VIVALDI=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_VRC2=m
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=m
# CONFIG_PLAYSTATION_FF is not set
CONFIG_HID_PXRC=m
CONFIG_HID_RAZER=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SEMITEK=m
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_TOPRE=m
CONFIG_HID_THINGM=m
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=m
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_LEDS_EXPRESSWIRE=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_AW200XX is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_PCA995X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=m
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2606MVV=m
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_BLINKM_MULTICOLOR=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_LM36274 is not set
CONFIG_LEDS_TPS6105X=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_RT8515=m
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
CONFIG_LEDS_KTD202X=m
CONFIG_LEDS_PWM_MULTICOLOR=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_TTY is not set
CONFIG_LEDS_TRIGGER_INPUT_EVENTS=m

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_ADMIN_LEGACY=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DEBUG=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_GREYBUS_BEAGLEPLAY is not set
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
CONFIG_COMEDI_ADDI_APCI_1564=m
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
# CONFIG_COMEDI_ADL_PCI9111 is not set
CONFIG_COMEDI_ADL_PCI9118=m
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=m
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
# CONFIG_COMEDI_ADV_PCI_DIO is not set
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
# CONFIG_COMEDI_AMPLC_PCI224 is not set
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
# CONFIG_COMEDI_CB_PCIMDDA is not set
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
# CONFIG_COMEDI_NI_660X is not set
CONFIG_COMEDI_NI_670X=m
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=m
# CONFIG_COMEDI_NI_PCIMIO is not set
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=m
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_GOLDFISH is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_CZNIC_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=m
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
# CONFIG_WMI_BMOF is not set
CONFIG_HUAWEI_WMI=m
CONFIG_MXM_WMI=m
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_GIGABYTE_WMI=m
CONFIG_YOGABOOK=m
CONFIG_YT2_1380=y
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m
CONFIG_AMD_HSMP=m
# CONFIG_AMD_WBRF is not set
CONFIG_ADV_SWBUTTON=m
# CONFIG_APPLE_GMUX is not set
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_TF103C_DOCK=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=m
CONFIG_DCDBAS=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_UART_BACKLIGHT=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_DDV is not set
CONFIG_DELL_WMI_LED=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=y
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
# CONFIG_THINKPAD_ACPI_VIDEO is not set
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
CONFIG_INTEL_SAR_INT1092=m
CONFIG_INTEL_SKL_INT3472=m
CONFIG_INTEL_PMT_CLASS=y
# CONFIG_INTEL_PMT_TELEMETRY is not set
CONFIG_INTEL_PMT_CRASHLOG=y

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TELEMETRY=m
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_ISHTP_ECLITE=m
# CONFIG_INTEL_MRFLD_PWRBTN is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_RST=m
CONFIG_INTEL_SDSI=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_TPMI is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
CONFIG_INTEL_VSEC=y
CONFIG_ACPI_QUICKSTART=m
# CONFIG_MEEGOPAD_ANX7428 is not set
CONFIG_MSI_EC=y
CONFIG_MSI_WMI=m
CONFIG_MSI_WMI_PLATFORM=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=m
# CONFIG_ACPI_CMPC is not set
CONFIG_LG_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SYSTEM76_ACPI=m
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_SERIAL_MULTI_INSTANTIATE=y
CONFIG_MLX_PLATFORM=m
CONFIG_INSPUR_PLATFORM_PROFILE=m
CONFIG_LENOVO_WMI_CAMERA=m
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_SILICOM_PLATFORM is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_SEL3350_PLATFORM=m
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_LMK04832 is not set
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=m
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL=y
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=m
CONFIG_XILINX_VCU=y
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_FIXED_RATE_KUNIT_TEST=m
# CONFIG_CLK_GATE_KUNIT_TEST is not set
CONFIG_CLK_FD_KUNIT_TEST=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMUFD_DRIVER=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_DEBUGFS is not set
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=m
# CONFIG_IRQ_REMAP is not set
CONFIG_VIRTIO_IOMMU=m

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=y

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_PMIC_PDCHARGER_ULOG is not set
CONFIG_QCOM_PBS=m
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

#
# Broadcom PM Domains
#
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains
# end of PM Domains

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_MRFLD=m
CONFIG_EXTCON_LC824206XA=m
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=m
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_MSI=y
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
CONFIG_NTB_INTEL=m
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_MSI_TEST=y
CONFIG_NTB_TRANSPORT=m
CONFIG_PWM=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_CLK is not set
CONFIG_PWM_DWC_CORE=y
CONFIG_PWM_DWC=y
CONFIG_PWM_GPIO=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_LAN966X_OIC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_GPIO is not set
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_DWC_PCIE_PMU is not set
CONFIG_CXL_PMU=m
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_DEBUGFS_MARGINING=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_LAYOUTS is not set
CONFIG_NVMEM_RAVE_SP_EEPROM=m
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_CORE=y
CONFIG_FPGA_MGR_XILINX_SELECTMAP=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=m
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_FPGA_M10_BMC_SEC_UPDATE=y
CONFIG_FPGA_MGR_MICROCHIP_SPI=m
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_INTEL_QEP=y
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_SUPPORT_ASCII_CI is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_LIVE_HOOKS=y
CONFIG_XFS_MEMORY_BUFS=y
CONFIG_XFS_BTREE_IN_MEM=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_SCRUB_STATS=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
CONFIG_F2FS_UNFAIR_RWSEM=y
CONFIG_BCACHEFS_FS=m
# CONFIG_BCACHEFS_QUOTA is not set
# CONFIG_BCACHEFS_ERASURE_CODING is not set
CONFIG_BCACHEFS_POSIX_ACL=y
CONFIG_BCACHEFS_DEBUG=y
# CONFIG_BCACHEFS_TESTS is not set
CONFIG_BCACHEFS_LOCK_TIME_STATS=y
# CONFIG_BCACHEFS_NO_LATENCY_ACCT is not set
CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN=y
CONFIG_BCACHEFS_PATH_TRACEPOINTS=y
# CONFIG_MEAN_AND_VARIANCE_UNIT_TEST is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_NETFS_DEBUG is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_FAT_KUNIT_TEST is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_TMPFS_QUOTA=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
CONFIG_SQUASHFS_DECOMP_MULTI=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS=y
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=m
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
# CONFIG_EROFS_FS_BACKED_BY_FILE is not set
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_ZIP_LZMA=y
CONFIG_EROFS_FS_ZIP_DEFLATE=y
# CONFIG_EROFS_FS_ZIP_ZSTD is not set
# CONFIG_EROFS_FS_ONDEMAND is not set
CONFIG_EROFS_FS_PCPU_KTHREAD=y
# CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_TRUSTED_KEYS_TEE is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_PROC_MEM_ALWAYS_FORCE=y
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
# CONFIG_PROC_MEM_NO_FORCE is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_SECURITY_IPE is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,ipe,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Hardening of kernel data structures

# CONFIG_RANDSTRUCT_NONE is not set
# CONFIG_RANDSTRUCT_FULL is not set
CONFIG_RANDSTRUCT_PERFORMANCE=y
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=m
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
CONFIG_FIPS_SIGNATURE_SELFTEST=m
CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=y
CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_ARM64 is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_RISCV is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_CLOSURES=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS_HELPERS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DMA_NEED_SYNC=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=y
CONFIG_VDSO_GETRANDOM=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# CONFIG_LWQ_TEST is not set
# end of Library routines

CONFIG_FIRMWARE_TABLE=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_ULEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED_NONE is not set
CONFIG_DEBUG_INFO_COMPRESSED_ZLIB=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
CONFIG_VMLINUX_MAP=y
CONFIG_BUILTIN_MODULE_RANGES=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_SIGNED_WRAP=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR_PERF is not set
CONFIG_HARDLOCKUP_DETECTOR_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=16
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=20
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_NMI_CHECK_CPU=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CLOSURES=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_CPU_STALL_CPUTIME=y
# CONFIG_RCU_CPU_STALL_NOTIFIER is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_LATENCYTOP=y
CONFIG_DEBUG_CGROUP_REF=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
CONFIG_SAMPLE_AUXDISPLAY=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
CONFIG_SAMPLE_RPMSG_CLIENT=m
CONFIG_SAMPLE_CONFIGFS=m
CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=y
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_IOMMU_DEBUG=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_FAULT_TEST=y
CONFIG_KUNIT_TEST=m
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_KCOV_SELFTEST=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=y
CONFIG_LKDTM=y
# CONFIG_CPUMASK_KUNIT_TEST is not set
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_MIN_HEAP is not set
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=m
CONFIG_TEST_MULDIV64=y
# CONFIG_TEST_IOV_ITER is not set
CONFIG_KPROBES_SANITY_TEST=m
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_TEST_REF_TRACKER=m
CONFIG_RBTREE_TEST=m
# CONFIG_REED_SOLOMON_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
CONFIG_TEST_HEXDUMP=m
CONFIG_STRING_KUNIT_TEST=m
CONFIG_STRING_HELPERS_KUNIT_TEST=m
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=m
CONFIG_TEST_MAPLE_TREE=m
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_IDA=m
CONFIG_TEST_LKM=m
# CONFIG_TEST_BITOPS is not set
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_CHECKSUM_KUNIT=m
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_HASHTABLE_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
# CONFIG_BITS_TEST is not set
CONFIG_RATIONAL_KUNIT_TEST=m
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_FORTIFY_KUNIT_TEST=m
# CONFIG_SIPHASH_KUNIT_TEST is not set
CONFIG_USERCOPY_KUNIT_TEST=m
CONFIG_TEST_UDELAY=m
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
CONFIG_TEST_MEMCAT_P=m
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
CONFIG_TEST_CLOCKSOURCE_WATCHDOG=m
CONFIG_TEST_OBJPOOL=m
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

# CONFIG_INT_POW_TEST is not set

--FcckSZQnOghRTLgP
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj563UttBdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0b/y0sDoowVXAk6y6fqqnZJkEUqKwb80apN3hbcKdY7l+gdheREhaDsr6X9swkusSeB2D+K5N3Us
OQdbDEna/o04FWQ87w7RukbI2v1L49xoBiY1+tFbUGGxgIJ5F9yvS1LoUxWvr8sZHx6iuMLNIqBN
yD6tYgaY8NHa4zpxZd5eqMVpPEzcMoKUDMHE3lqDLBR++HBK0+8aKsNBjagNhuPRteT1LycfXL7l
+YMXP8QujW7Gv/CSSZquoIeTuM6pC/Hy/01kfbuTvEzp2JAI7UvMWYnTN0/KV+DWfODdRMK1ChFd
s6Sq5U1gmB22FU1YExBy0C8Zz4y+zTKCxedRF7EsDwsUQUmA7Af03axPRtkosXKkwAS2lwONdw8H
UzCJZucHEd2famW6JF1YTZ+4yPlZph5ygxN4gaPAmnzzAdFQbSU39+TriXyyQjMnrCFPs0Cc0Ebu
b4HAPhIONmimyr4GHAD6FSQl2PN/xXyVownsmAJZPzikZ9t8uV65HxxvGe6PgGdNH7bOMBe/SGV3
dyhdLD3wbYLz/DhWIafJFt7nUn2zyeHSgQ0vwntU90G2uGaUERdDcP6+o+iiEWQCe2Ew1MeCYbSO
w7bqdp5riAVwge91kvAVkt13qna3XFvYKluKHQLFdXRapGscqx6yh15Am6U5mhkFP6sbeTmkNc4X
4DNkUBNbdA2Z40C/MaqLkm6uCTkWQOfwquQ9jUON1AiiksX0WvmHSmGRP0Oq3KwvcrZB5EyUgQoC
OTpeuqyTz1joUpTJhHDHMIc1QIuH2Bv7MtFBlFTrqmI90Nq3OolZx6c4Yvj8EyX0dI6x7Q2zWEr3
iHd9erqXXR4vC2fV5SsKU9sWUhoEI2S59J522cuIhm3a8TCTmn9OeXldJJ7wEr2ZmcdK0a0Ppvj4
kNjX2RZcfEXYwn2JT4c726IqGFNzVOf8JU3LRwnt25vp9GD4UwpcrExt7RZwSWhFnez8YJCfrw/M
JHtfyR0iwJVQlEpzbV3imXouxyrarh3svtRtO1BxHZf2PCfunm9nzoiAi7zkA+rkEBeFRS+Dqrzo
ljiIkvpInJs3lhxqe4+pwlxQcyr+PDAOZNFBAqm1KxrChyQS50CABVfqNii7CNQ4lQDXNNybxIdD
r0xVpAxus1g5YgeybjGKjjrr7gnsT0NL9giAQt6QSFmp1PODtTFpQ9KLypy5QACGkTXQmemHFELF
e5ofCek3n0z5FsDOX1hLawqxSyhyo6zcAHhVTT2IOWJqkQ1uMDSB3K22lRPtJ90ZWi1tRJUBQTlT
809iGR8E8nU6TCilTZy3Xl761GUpCWe5z2itc4hSqoVhuC9Mh9or3+IbuNRqIlkUeYssHKM1iQAh
QKXOa2xFWMumku0uApSLuFphNsAZ6Z4KPTFvsoNcdGGRN5Kvj3NAR4SzfC74V+KuYXMZwPrQXOkq
UzuUmhU5l6feTBrAqc8lRbLbI1McCieItF9R5S0pxv8/e3MTNTDrTXxQpIOosHokn+p3UiauTRpc
mhTULefZF98bJMgmq64DYjUim2IU+RFDkpPLz1XaIL4yfp7nPco8yJWecmQuJx7b9Bz5mCTV8La0
C22P7ZJO/Vfc0H+5CvnKf6RQXbuIyPPZxm/EXLX1AB9LCvalbumuR37cJAIV0r0WJHN8P4tGvCNW
hYGu9LDrAk16lRC1N29eNUtBw2yZq+iObOWxN+iSYtLgQS4i2boya7TemijSDRIWWRIPt1ydJsO3
dwy25F6hobKuNYFJMEB3vwZFCZDdJn6/K5U+j+oWNLaoCWDli7hPYBOVwVrM7SgcNDkInJnjVXRT
reK7v0Rx1N31rZawqelOIIBPIhYSWh5E4AoHVu0aAipooOasFMBldY8NfBv20VQef2QDmNuYrdOf
qyxZMkZan5rMw3ztbMY1DUflYxTUUJwuyKwYj+FmF3HmsLr1xfFuik6Pp7ATAdBt1YzotBfhVIBW
VIQDezp3KPx7JAJII87rOfxQdapH1svXeBNImyog3hrCNe6cbegbo0vwy8gBUJ1vop23XjqYgflB
+wFWu70fcxwP4xj9UuJQJRXKIOmTB7DcsMkQ9Bv69ron+jYho3ddMfq1YI8vikJJaftjlzfN4VC8
/i8eqaAfqykAQl2X0K+RsF3mTcJwPqnURma53tmd2TIQHoWWP8DLEg5E2HSbMcvA5vFB9LGozVPM
8Zk22biFR0JG0sesHJ5+yOBTRWCV5O7zZc/u/xm+VJm9fdK4r4NoeOQMF5bc04kbGryJbdTK6sTK
mcoh86O4b7FE+SWTUTAlhgqWdtVR4WdlIVoJjhvrGft4zHMkeDzyZFsJ9IcIHdNmQTEqArgOhifr
sucRZleCnmIBysD0fLKwcyTVFT4mVRC9z3dLCGxbIzKWjFQWVze5IOD5DlfrfQjyZMEAd6R/Tymr
UxnPA2LPgD+81ZK0lI2nKiVQCVRtlWdhHBiT7yh/dDfD70kWIU50aHr5xGdwNqfgNOfzv62X9Nvp
VkIMUSPdZRBeJyrqmd97+N9yCnDPN/FJNJMZg7quNxc25dwYPMDKLSjiLOjvKZvDcan1HzPLbCFf
1dxZzZtO+/2dtdzXSA0kFDpcTPrFxWkaqAufCVZPyVDX+vySm4HY94IUddwfKKzSYqZhwhnPKktW
OR1LLsk//Hx03r+AEjDLtbg6894WWfzU5X0V4cg+aAmPusG/74RdUqgeEBZOaLTLYfnjokjy0rJB
mbrVAKHdQHPfuAT6Ji0Pk2W2NizFq20WaGYcvvOr+rHe+Mr/ExlGPbMmqfbe7UUgxxdhnQRUNlcf
NdHX6A5OAIw6FE6qQieJ0td0gHYH5Oaug6mTBzSoDdfKgmKjS++TJ1/eNiPYETzJuj0RdJac/7TF
CH6ziPZf2R5gXU4RU695DOiQJ6K+CiqVOptLbRjDR1qzoGo4hvs5jTgWa3an9p+0DXhdGB7B7XKu
HAAvech/0wlY3S5MmvrrndEkZ+TiAoRttIw6qSp7Vdms+OWQomWkOfs6tdWZnaSZMSlL0lfGTlDJ
XiY90T5P6FUCYs6jhL9hUiQw8zDiDi2Fvpo+yjo0rWOWRjItRt1W+X8liTDDLuweafV0IxVRTBF2
PhwixPw/Fap7YMlLU0WjHmTKKW9wVudFznfNJS8GxeddLpqwAYrHj6kB5ys7RC81Esj1tOSR+Z7f
LUFgUsJOZg5AcRdNJFAvVn50Sj1p9rUwqZIM0/DRVIQwBg9xB9V6A+w0H2G7/FVsmdgKSjb58Oj5
DZk+NP34vbxOojXN9Jg755zFYULTmO3Fh6wR5PglD/BxaGRxdtbTDPjhwOq1Oq3sAy3JPfU30lv4
W5xWpcSMnx3B8046jjC2+5HgVUbOTCnwasarEYL/iQJ1Y5LynA+6Tzp4d8a49wEDB7fqhvc7KA6A
T0t0ICeqlD+OmUL2sBlTtdckyMtYX37v9vZm2cBcpP2QbcPSoqqHHitSOpAgCeax6Blb2HTnvL3u
QlJq2+Di5uP9ZGwsmNEUIFtpnyBhSZQDs9N3MOvgppziklLKwLiflfHIoVin4//gh/gq7L/a/TaZ
C6O0e24HMCOe/tt6aBkXa0nrMSlsH3Zl+8ytICRi0+p/QRawrYAijU4qOzznqkKdlKOByvuRlSSq
wmBKdQkiCXyfnZ5nmIMIepB9OgHrETneozGmedPsHACZC+EdUg8McQ+d8XxMyjoowZAqWSkXzDTz
yDMt7moNbGxKqGJLxMYkQqxRJ5k9yIixQ2Q+IrEuyxvt7ewHXe1yPaYg9KeRFjOk1J9wGUTfP2Ia
LNv1Jn193SbBcak2PD0haJAhnBZYi2bEyTSMSApUKSzVbVHWhcdfr6czh8FCwHu86l7FzfhiBqfb
hE57c5UUYMauCAxquYdWZGni9caKHw4cccJneLWUu0hwVHucjXf73CccAGUgto5jws1PZtRu6K5U
IsxFXQ9n6RpGo7ImTyX4ObEoQ5Jt1peomxEMW0Rhp3+aY/eeDwN4o33JisklBprO3uwrwxWI14Z2
Yzkopr7oKbeOclO9AF1StpMUYzSEIj5pys6MNS8UCjwsxfm2y49aTV93qlLSPm7wVPS8/5oSvkpy
6Tvf5OggskuEbnd7jjfIviHcxukbY/jtFPzunUmvY/mW7y2jjpngM98tSEsGzHmW+5Jfee2kdk6G
nUBcrmlQ4+opslTDjFgm0zqF8/8eXv2eZZlNXvsIZE2T+HDiGNpjuAt+IJ0+6dASunDr+wTm7Row
CprzVMTPEtsYlXLEbBV/vKV1POBDVZrNKm77gIIevPIZOle7qnDdNbrfO3/IF4H6gTypWdZp7bF8
6+shr36KpDNO5BgUfldLmPuRIWxRnYMq2k50I/eaWDIh3HdR1OYN7cCzdHDmRsXLOV20QGAshw6P
koHlWswiFo0TSktnux3X3h0GyOmMOauSStT9fvmNU+Fefsda4Y6T9j+jxy76eWv2DJtiRhMpcn5K
UuJIfg1cC8YPqIOeOEOtPTj474ij9byDfLTG3vneuC5CwVl3LUit/CTdoDBP5+dYKylU8qaFUefw
VVrnCJphQ5iwQXY7O0PKjyD7LrqEfQ145F49tH/PVpiTBFswIcsFrRJSi3mrDMvik71Sk/6X8O80
mCtjZ0mLXtZp3moU1gkGkL2L2nNMfXPEKOGX5xRh8Fx5rYA8wzSskkiJvcMey3d419vlNogBx5Zs
yS0jjNtXilmvH9x6kFTR7iInTEkBLDujLh74s5aAoaHtEAHlV3B81dwaiiA5BYVjhZedZjv/arS7
iMdZCizlPdgrthSnbIbJynrsHLg2lcz0xVMgw6s6rKJ/nFBXFByihlvI2QwzjDzerMEDl4rSUk0w
pHmV8JnY98XxF0stk2d3F9+LoM9HiqK4+KZVegMTYTA9QInL3p/qPnErCKDHZ5ufRTVODcLuDieO
xyiR6S99moUYqTsgR3pGbjOQ4N8bq2eVSDTg97hx5r0eszE5w/S01ZNB+l8Y8VDPf+rM7F9cOmu9
6wPmauzi5oV9C2j2nQeatrTMx+y3iJqietjyyXAVouUmeeV666/z4bW+qbmLmSGMTdSyoDDcC5J+
N292w68GyM+/0W+YGor6BH4zjCQ8RS/ICUzSI67saLw3OBz8yKTcXFsKV/RmG9gpY5yVuvuSt0Vb
5ocb1oKYQmHCJ7p+mMSwXkm+OKG5g43L4zpMMkOPXjxm2ifUK/00wpqdGzsPARaSU5u0uPsXFpeq
ZaSYOnCYEfQuTQArnfYjjm7xWCzF+tY+hrtYX0SoxjUGie8no6dKU51Adj75x7TnVpY9NJHztrIv
ruNXW7kyp94fN1gUbCM56yeKyJjmVbEiMDpDPpDJUaXI5awPWKtmkCLmS22sjaen2GICnfKip0MR
E4hGpPwEzD4NRvp2Un+QuNXimWRQnDkV5hkXGt4/OIrBgXy/oGK9wjF4pH7ny/SYFhmO6BPmzrGT
ZbSMXV/OBOY6vxaMcg5Ei/hxz0GCmEOs/neoEfgs39DTFzf9tdQDFu1E58L3/0tfy6ZIzGa7D2TE
p7O741DMAR40roPICI85y851RmqOxiksD2bUhFlwNf5nBuurU9DbohPPhbPkn24oYo/XV1QGSeta
XFvel1I+3/QnTof324CohR5kbiHUb39J5bP73yFAM3HUHr77s3dh6NrdTc9tzKn6k1AIe7qfpbl8
wVg1RPHC11gra4i6YXJdnMUUQRe3wEHk8nCAKnLzTdLx419vPWl+RNyhEpjYkZ/ivI7sES0Wbtmp
illfaSW49HMJFU9IBv4rwyiIUFPG6Ttc40lyNss/TpRFCBqsIs7+Rv57gkl/FIx+pCx/p4SGHVsS
uqhpjgkoknJS+v2fy42gk1mg+1PtGy+nTMldTmk6hNHKZJPtbzI7YtJ9DIOum5wiuF42qdHZMmMu
rQ8Me2/3ErStqK9Fj0qFspn4KaDkQSuElM6+21H4f7LvZoCWPDtDIY97vVHW2LlG58lvEfG0T8jY
SudGvHHq9k6ArvCvxNxJlzi+EAQM5dwDNK6xhafACM4WjjjqVkcLHVBCWsWdENhS0LBNzpDpqqQs
ljD0FhXSAirfbl5BhOyAfgTRjuyX9F7g55p5ihFZqFJwycbNESSwLguBq69zEcva3keM1iI4XnN6
Ou17XDmWBiUNzRBDVmttInAYRBshXWaNUJnSkV8D4eOkUHCSZPWc04Ti58qJ7sF8kcdy+Vzpq0iI
9efwMCAGB/a3oTVgwXcGbucELIITQ7lw85JE6lxLwmbj/E64TscKHen/Cv+m0hl/SeVoxicCFzvf
uGCZLfCQINKuzh2dxQRhYi/9eseqvXAbqaXqQu74AY5moHH5A6O+sIY+xMeYMAqJqvgS9CZWFKDi
7f32s4oaUWWS6oiktw7ajVi3+whnURXcOLyZXHTy4EX8x3jDU19wQif1vPGNCs4tj3Y0fu3NUF3f
ZfUZjs27w+m/ncfXCqCkln+HBqrmGJ0pY5q6MuNXBnLdFpadFP0Cwph2mugNk5wpCvRp8X5TLcFl
1ZPSDStmB8Z1kQy7BAfnaqgDKWN1q4bCBwutYWysi9dh5C0FOH+o3Tzh0j9U1Yw+XpnBEjYUi60Z
42mL3r8rVMbWp1quuaf8YKckwK0OQrLPP07FyfHbMI3x1S28DBadDeUrGMZqAz7yIzaeCMNymzQ9
8Fzti+V122Exf85gmE504ADO/3grnIkJbMV9nUzayOlUlXx4W2QBTCMN2Yi6RBrAXgO0voNIVzNN
+AQUxnrQRWy0MrxZzxtbkOr3hNfqsID92wMQu/widatp7cxufG126SbzD7wI7v3yITewd2CzqBhz
OxcSxpuFNcUXO76A+qhxDd9ML7Jjkd4XyGzoBBz8o0LaZAo9sv3ebB3Nz5mM+B6SqgXCb4RgvdXQ
1wFEvB6PC9rbiSkc0DOsyKcRoABnYrED3rAriqnVfFMQN94mZcH5CNS8L6T0hhQYGJfsRHX1PiOe
NO3ET/9ikePLNBBP3j0Bb9GhKaIZXnJqeNBaJIVzjcR+T6btOdo45hq+M6QtTP8BThLutyvL3QxG
I9rahw/lfwMPAksvUQD8ZEUWYqEMmXuaYGiw/t0AyvfjB0J4dnhweitxrJUETkh/i7NHod/80kqX
887CWXkI1J6y3sSIq5pXjmVutPTWbMWJhC2ughB3exlEg1dOGa/v8uP2tyAjtfibWcJYPVgugRKw
AkGNRU83I+NOIIS6se++Y50XGc0+Pa0zt1eyvLVH+vfz/5Nk96GLul0yLp33hQ58E2EoWpquEq6u
J07bvFSYB+M44GtO+lX0OEpdwpOuo8f4ikyOu+k57xE7IN0tZP0muvAUNO/7CTfffWHlBxdL+7Q+
dSQrxq/5X+M5Se2E1Psycz307+Le8mcX3dhrLe1Qf+KeYXNT6MVNYc2kzZ0xKvJpfSMyCCZqfq2y
ahG1n4B/F8ukH8eoPBQFxCa0blGetSb9EfNIbXxu+vZMYxGntU45EuP9K1moclLWKHGNnJ7/CtTP
e7jMO1yFHizyYpaLZVn0BSJFRS048wTDpWkiFy4oqneckTBbnRbpDLjQeJ6DXpPEiSTBKcf6hMCW
uXabCD9QNN7hzNHmXhdwmrvEB2M0eC+zl31BoNwhluVV87U0GhK1aGBikOv1wtRxZRzM5dcCS45M
IHDxphLWxrkiTYyaSHs9aeg9isixzgwXaJf7acgJYK/TOj0I18uaOAE9Sjo1Q3qkGKkOZ7a2A7UI
LcYTMkrMbM1Jg6Bdh/cgexOdQ8iMnZTNR4VifIkwhq34gWj9u0wOtk89Lx6Hix9cALuaW4mV2Cnq
XMFftrv4LqQOyyn38gFbwmf1k/kZ1ZRbGgWFAdF1why1CiXF6fBEj/jUhDd29QgokTfQzAg0R5qH
I25efS1Euk+WUK55hXgcWlFVd4AgvKcqFZsr9nzn9YlY08f003ifkHQ9FT5v4ZzGfpS7xxtuAwNo
56pin4zL+5fmNoONyqGlvzWjxBVy5FbDj0EmSgdC844SVaArLvFMIflo2XGQK2K0ZVuwUo0/Sx3w
OkwSxT19s+pAZeQ/883pt2N22mcCbrZNL9tkPXWi4I+iKOtNdd7HrIvijirKupgl5I6ATDogYZkI
bjd81XtBMbGHBCBICA0oHhen5liy1rh7bkZBjquzbt4exDDy/EeAHNH0AwFtXIbKf7/qWfm5NIzy
UOvYobOQHwLuXPxVUiJAHllAwH68AzGrSQr9nx1NlxLT8X4wtpPBLIJrOh2Of/PGxT95fJvnpUNJ
4SS09iYWeLGtxGeMRINwoCXYfi2Y1oaLS4AIb7AVUyumRQgud/VArxOn8/NwH4vRw5PVnbifSbrO
ay3RHpreFuC/VrhgS9/RO1ZjAlV7Db0NZ3QLtECY1cSx3hhlq+iuZ7ZfRNoeVIhFQhd9cGeXJKEl
8UH0y/IC8snavDuTfo83Q7g+KTX6HMkYcUlG/3pmMB2o1dcA+PWBhK5cVIUQoN3uRoTV35N4oJsR
tV494RJZ6glQJo1km/hzQcEtYYvW1ouqxuX52pJmXe5lyKKk+DnzCb929g9LAlUXHyo6onsYiCuJ
Es/CZOtNswXbfrIZ+hsmnT3gqNSL+M5KgUEpD3l6rnVa/yDbcO9Yfgxy/ACGQS5QObKbZe8H2K3D
rHlbuOHw7krlOF3YduLntceAL1zvhia7BgKLIP+GJNpv8YJKeTqg/uiElw9bV2qO6T04wS9m2nR9
b6MWtepl6ymIziTQkAnIJrKJjRehkKboNrRSwhF8qfhRIiwx+nPshC7kjt0VHWvHKMFCgTzH9AgA
RIrghqjqc0Q6ANleSo6+cjFYNHxBEk72t3PbxJZARjtP48rEsJ/tiXkuOrpJCOxAe/WYW3NhTIFs
N4uHMZe6Pr5De6Qcdz7b0JxBTZc71z0QgZ444KtOuGaxpN0C0qct2f3sQX95mu49VkgYHviLY0IN
MB6IRUifzKHfr9cgj0B0/1y+mkTLQcWk+ux/n8m9ygDpeQh+SLPqHAxjb3KZgS0Nh6YleF81Q8lW
VXE3l9wJf5tZ9ybUvD4ycTLACViAwFsyWZbRalxwTz2MM2bU8uigulq8NZahw26ge35/1PlFG9vr
qEYvAnIwWpKIYH88TOBz5dYiXFI1KaewLuyBWdckdyqKQv77jl6kvjkOO9GN7MAH0gq6kbp8DPV/
Ad9oNGqrdoUH7YwxEzsQVZfnreI5peQSRq8gitk0mDqlzm4VkDm4NanGhfBC74PjJzsF2Ov9/+v0
Znnx9OFWtRv8pnOWnV4xxpUTAII5MnXV1e9MH6ZtkiSw/+u1t43bz8KcWy0xRuHV+UnpRHtYFqEy
SnE7hFRx6rNLHAElfSe2x0M87zTbbIhy2SJiYpxEwXCcT4J7L247PHG/zGslkRSPUbuQUkJeY11b
sK+us8AoWNxZjML6ASseBrG348EluiTMqKYA84CLOtAaq6QybyX3FmqM+7gYchkKMIsyLBl0U7uB
D2bCUl5/dhdXLDpXxrysDMXv0+W/bormvlUalUB8AgggKo9+XKDeLnUo9mA1hmSj5Q00BCZonung
+ZihtOP6K3oXwqeqBB/zc+tIdqor8eX/FJrKq9y6yi/5e/Z2yNhm/MIMyOVi6RZPr4e1YDa+kuNw
i+0K1TZLT5lntEAlPSpP4678trLU0c+xZm2lTEwgfgaJetqv3+cYYvPqkeawyv/va1vpVtmxlyn4
wh5n7yyRwGxC15Z791PtDUSeLAqnvbXjtvgL68gGJo/5aNTng+NyMCUCXAJbLuvoGR+4aG3VFcyI
xdQAOQuz1kTHBSH8c4h2+xxmNB/EiTPkRkob5lEuy16gLDiO4fuoooqbB9UmZa1wB/Sqc1yGgYtQ
qw/sKuhLDFcFRmpYXn3450v0NK26wTzotIRsX2X+ZudQ5yez6AtzxHQhyORZRArG7bgim/CWFWP9
+plN84jf4Wa+PHLFmrwOlSCm5mm8l0/qb0CxB8AniGPwA3XxPuhZ+e1jtt8+u/CbDF3dTKrMls/G
qsxs5D7+Ots2q2y9XJduiqPRus/AwDlaQGTiudBg0NDEiPcfNMrfwIyXFARuTEq1vXBdDJ9bJaxn
KOOVW+82m6iJUl9bWbJnRJvEP4Y1wcKjah14SUW+CLiLOSs6sEWGwSXDhg0HU19ws3Kay2XB2hu5
mP5oPSQXA5h8llUrek8fG90eWe43FaSpNuLxm+/WRrIH95QarZHws9J61o72URTr7bMGM0h+5eTO
HZOYf0dNT9H8o73Xq7TpXBM/Q48380Pl+bGT6TxpKNYzz/idyosT4qJSKe4JgPhluZXrgxgq1jsB
C/c2pWfuuF65ljJYkdYcLyMKGsCurLM+TjF5dJ0zPdyCJ3p4QHthKowQJe6B+YQpqNJ9PWkzIsEy
FQTRh8hcBdZX3JliNrSLShwr146P8xFBldrl/osGUDufXGj0OnWdt9SIJra7lLfx5xI04M9tMTze
zn/mVw7O5VSnXSymHwAXWeP+BEUFRrS0r8gQ33Z1/PBfi8AGYkPm6hOQMLsaR1Qga6T9Jt4cNjfh
YogTznPH5l864yPpaM9AK1ZpB+lpwc6gu7qqn47JZJH0GMDtTXEl/iRIn1w+3sZ81YBWFQw4E2jf
mTg4rFzcVBMVFWb+w1kpDaTJD5s3bydZetuBRAluxkEN9/QNQQwecF8Sx6adFw2AFvua2URBkTKT
GswbAmMtZmWGqm2DFmQKSzHFCIySciOCxSRg+yGw64OQ17N3XZkA++2xwC2Kscay/ubwscMcolpR
ABsQz06wEuX2bP1/vT0LG7ZZjMaDqnGYfKRfaYmjO73ur3NaEjrs8lCGL5by46ASBwqdxQyt5tVb
rOoMMblacDVxxf0Eqqy0RFXxLBzr9R+uYXKIKe60hREBfgQU4XFndG1IJx28E/YFvSwV7ZU/gl5p
Rcz902L4lJcPTkKwx4VQb7zb+S3N26Ay1HTfjBDMQ6bddAderQ8uLG5kqixv5O9KmBaXBEG/z8n6
HH88lcnZM8nIx+wvTcTO64x0PvVKmAvqZroWZwf4IXmQoSuB+5h/c0CR68FtVGVCDyrIqDzVWF1e
4hn51usxW3UaiXr1T6SxCmN5rtDqtENPDDZa6+xzgnGCiQ1ELf0Zjs0l8xPz4m4ENA5bryTbnT2A
3ldPTnkDvSc5zb66L74gcVCLBydccanMnvPb+XykvJGvXQmdwulFfYGJbs4WW5Y/W0uGyBoRc2JO
kiVrN/ZjNFFUrT3lS/o0FoIKrzBMM7xBFF6sE+cJ6NoroFHlVn5xNJshWW0y0Ot/t3lWHWqOXjk+
+TXKWG2ArYrNObgNmLG1mTrITlka+8bu5UyJoHF89yJ08p2zrLjAWD8GGYFCcdTq9VteQ9rHuL7o
KV3/z1g32I/GwyP7yOMpOjWOZd48o9rcsQzVOyYjGHQFjOYJxCpGyHOtX5xaapTGp8o0xKUh9M6a
1t9XCRp7zVc0oRRgpA/ocnsD+3e9Pu5VM04SlKMPwXolKiqV7osYGMtpYuli05IcPVDxBszsxKOQ
cgAqlxNHhslSl9ZOvIV1/OyqxdF/fsWJAU0y8IyFT/RusDR7GCQP8caRJuk/+duvnnlJX/r37hsb
DiOpM7XFIL8CZdRhmZJF8JjijDYZ99AdFG7M7TbPOUZkFRgqtmiytwtjsNWojFnyU3DQnBM6DULU
CF6eh73JL21vTH1vUGq5Jmz8ULKG191dQAOv7kggX8WMr6ok4sBRLebrd6Hoij5r7c8yinXbm42J
xIpmrXbdhO2OAsiDzMEfjArzuMtV42wnmQUAa6ilrmdS3vkpdpkPmSi5aFR7VxnHRIrAyYkdMkDa
uq/9kJvUSZNl/JrhaCBc9Kjb/QHLdwVp34WEj3qzqGL7HOdM+S76LrIjXad1Gv4AkvaKBzzy9kHL
qBIs9C0MInnflnNq7gYtf9FLUuuOXhjS/cRscw27giQ4dIs5o5gczQlWI5reWTMcijJTunuqMGLc
zedgeMN4xINy6MVDk1t7eCmetx4ckZaffP3GsjujAQlutd344+S4LTjxBDy2XhBH1JMQFFlGoKEK
aQz5kdxt6VzazqeCddBITo3hdjRfhy0FlIw8eEUh88batD7h4IQscrgDPoNJiafWJEyZgrfAfCyA
TFW1Wakf3K0DRRn9qpdjaXHDqR1KNPTQytGX+Y4y4WPAHjZoPfvWaD4e2sAY7IVyMP1zzMDSpJRt
fpdkGSVd2NvKEgunKTRNmdeB12fcBbz0Cuq1aJ8ehFzIHqk6wHRVWWbe2TO63R5JUSWpVU9Fqg1K
bza/JPDSDIKlxLoXh6pfnmqV4hF6PsfML2+PQ4qkaV0ElfDZ9dhDJtORmcMWWsHZUcJzZ/YJAn0N
oucPJxR+frMbEDXhGCwp0pmlkPHudQnhS6jCKbzXK0z+vMKRgqKZ0WKkZYtzqENHjQIOD+xrn/hl
zIyNw4tu8U5w8EHoV0BJZwax1AkufL7myRkONYbms2/KX4mcMAzrGCs83x0Vs5TOTZUHjXfkXqYn
oFMDsIfABKwA9nwDp2nUfj/MqrWX/ejEQPNi/FXQ8PttMs8m1aHm2J3gnsf7xHo44dRWHYYpyQNB
/4Kq+DxPmofxJkp+5bbrRFpqjqXZkS/rwtqdDqK2e95KEkdiFPm1rLzW3vhx63XXMgZ4D/C38CdT
fVZwmaYxx61veNvR6k2G33ne89U82JBRdVrE4TRmpFsi07R9BSWfL10c1CPik4zJ5niggYizROoV
XTmojuPahNvDWjBxTJXmKRzqkWjD0xkKcaPekGs0wUYaJy5Jov3PFJxZdLHp+ndkbdJZBsdecCFo
B7SdWyTONxOnhHRyITYmYVIjqMRDh70xjZG34s5IyZzJSatU9SFbAJJaQQ63JICZRp/HsHxBW3xO
vGfnuYBScSWb77D3RHcjxpxDV7W93gBq8par4d9n5DWrdSIzoKJu57lrJqAs9B2z4EowBmVzW2/7
2oFjESDYGH2RU3ubvtb9GGSKDGR9mkyOpe//CpkUyjyz/AG++C32EDAZH7GTN1IKMXuZh8IpH8Po
NJwhkoUl6aWVydjQyc6acq28x1NOaaHJFhH/hO2kqmTv4/pBY6Zb2QF3yQQMj/zNhzuOJ1y3T2gq
mTLyAktoOP8z/Howh123neV8CTu0oKx7j0CEJ+6xskSNZf4trPNHZaan44zOOtoCzTOCM6PUPOoz
k4jqU5gbkQceMVz4sUGK25v7hf5ufMKjaXF7j4bqn34TnYNMT23Cqxplaa46Sl6zCYG0nVhhizwV
YTxn9hTLLoggjJ9RekV+j2b6Cx8auDMj9meqwyNhyyliKW3DgEIoXt6ZVRCaQpx5uyaMIUQN9j1S
29QDr0KUaj66yrtImVUalc1Xysf+xjOEXxpJ8t7pxfkxQGdk2ArtRnmuXPzFicFmAXOc8hbZ2w8M
CKqULXfKEyFyncFQAfQv+vLsjHG7AaTFkjyjBrMlgzt6USrmfDCpKVzc3iWfejNqYKIbCFoQEpKR
kGeL/zFJV8r6A7O15GOlbap33d+Qp9jDoQjjpusmuq5p552PuJHR5zRuNFucWnYDk1RTQhaZ473M
/aPmFeOA6HWckFRd8SrJnVKmoXfuCqO56umOf6hvQgcm7HrOcHeyFw7z9xmbHjMHq0ezjywH0y7m
FD506HYV4wkG1aTOKv1AzLQCu7k9ULE2liyjWsHmq5Lm9umcnE94m4iDQl5NPzwAGFkKRqiEqrH0
bJJHbMVvF9sAlVaZEZ4AO55V9ztWHoFTp134UVFyq1hDviTvJjSR1ghxGGMwFqaKTpNGLPn3HMdv
pDnCXmO2Fl4Ra0jdKXEbA2a6v8GV7vzqR+OPCWeTSdFdzoi42e+UF/dwMqZJ82200F5fYWuuaZm7
Y/o+Vqz9pS1OJAC3K8mXkwxBvzrVO/arZoJgjlPud95urJxIdSaL21ldirxGK7D86YJIMrYTvibv
Omp/iLKkP0C9AS+9BVDaYGUdeOEY/lrQ5lqs0mwPbzXJiuZRJ2CBd7icS/5EF80T3JG/DCBveA90
kKvHn//e7FNqPcb14rvBIk081EpevNhm0cq5ArxEOoSy08eiKteDw3uO2UyozXOihZAHxC2XCkAV
EG6oj2nduOj80QPDtx8G8w7CpN2aiYjq4TddnNvx18oqb4w57PedYXe4ruFPBaizTTw2ncwzTejm
GVgBVEZosX/ee10sSQTHyKds5hUAsUgl++TabuuNJzZKDHgEGOEQryBc5+T1qXITczSOEzBz/cmx
FyxbeDXeYS4i0FbeMAYAJnxpQ1ChRo2oYKcks3spyAgnD1cnhPAZ6wrUlqPcihHWmgVwF9EZsOq7
914n1Mpdinmg1Ugn6D2KxHNi1aKKgM9c6dd1b53w1Ob9E5JJ31ljQySXqcIDwKYERzENlu+miaj9
3CJPzFNfiZ1n5N8vcdcZBjqlKoI36H1jYr3icpUveMGs4O6RFlIdCmq2ow7jCg70jxqqB40Vf9Gj
E8ixg0VYQgxjtsmUn0DUG9gJN8ZNPp8d8WyOmLqlVdMJQC+5guBURGbFIxLYi9e14WUj7N/fEHee
H6dZ4M/D+77yRWj72xRLy6+CzRqJwvfuYVfRVU3kl6bcQn2B0bbLnw0oFodRy2MtDuSptqVSktwt
QV4GwuMFjk1szYuagdwIfQ94kl7ZPwn22KXQ1FaoO6Ee97hthQuPPisd+jYPJrqNlvR6J281Wn8U
90Cew/GJXSmXELDw/pGOU7LbVey8kjW1/Na014jzX6EDcw3zMfbo90LVbLf5dbwcSCawLkXT5gYt
XG0THJ0axoKTiPxTFLo5oEfODV5jX6xbCUXouahINIvy7DKlBCsPTakbUxhlbxD6xxh9khiBIsTA
HH53yMAXcIhTDDiIiJqJOlV1ybEkG39GsbqeHPJ792OmfZmZPzGvHqcADlbu/s451HihicTYJCIE
8Xx2Og16kT97KJE09gZC3PhPn8WCuzr9pkXpjOHPVtsnxQasEknrG5fdczAlY8YoXk76zRMOlUQg
vfYsUt+hCJ5PpCsYEl/vaQQGL7b7xjVibgIHTo4sBcBAdqrpP09AQoMXa5rMjnJuTBJgZofV5xwc
Bkqu6yBXnXIfkhVmu407ByZVCbdQyA+LWKVm+fFbUOC8Qogx6ps7q7U5DuvXpT1xuCGYRcFqoo8g
6npTAu+eWCZkdtlvg+2h/O27oulpxcpqj84/B2uYeq9dsUj1oKA7t292hBnYdkkAySZ9rV6igcUy
m9hLbOK/vxHsyAaQ6SGPrgBYrFIOdYvMOmblcsHugOAFxPcZT+cHqXVMt6UzYpZSqAqpaQitkvwB
7q6IR4neJTzPzXsPHbRfMNW85R1FunH580QNOlMwxD1pVvXPAZJDPbBcqZzmGLGiGSOfgmzYXGmr
tYG9mJiWxclEX9TIvgscsM0I0HhytTTd1Uo9nsqwMdIkkc2o5kza+DT8giCkdx4inZSvhTDwtHRZ
WDGtHODzzvLwG4j0numFuZ25mAVjr+WgqZ5B0H1spBEPIY4VaSdDET+ub93PezAMVMA3bWB3q0hm
X7J4JZlhdWnArTCnQU0p019Sl6f472MUES5kRGJ6bd2WeC54kCjne9Pzmrnnbn8DD+qCKUiT4fBa
Y4vGr+VdV62nLNJsuz2+OF5nxkgzarvclaV//xu2BEi1KjAUxU2mqlyUvY8wts92DjWCr/reu3dB
eQ2q1cZCxrplHchckUCTA9cYJVk3G7gF5IeQXqk6nuegbV/tCk7gIFgpjlLnj3hsqgB6wdc5CHyR
N7Xme+WTt46BltdVqpc5Uyo+Vfq6LM6xaENxtHFUYUBN1Aso9owROFQkak6YMAoYGgy5n+WGslDW
FCq2uW6M86lggo7LEx+KXGd+tzagtApqZPskJiHclcPVqsV/VC+/s7KonNxUN7rCuMq7IqBpkjlO
SM9Byryio+j6gdx5KLqmQniMYY2ql9L+xvODZQKf7cCyAf6T5QlfMrs6/7USr9748/5cuEZVYn3q
5OgGuZ8uxCu/0mHTTeQPRtBQoErU7khXPpidhDxWO4U+fKDgdCGVfSge3P+upC5SIP5Nfc9ns5zf
+XBEVMv1rJElqoGdHsBwwsIL/SM+WGXTtnS4ejC7sl+LP8ZUEFZvjPqKZki16degnyaUsoaHiWQQ
axJ9B4QjaaOPK6bH44eKHzLA6X3Jy2c3xRvTzIFjTfl0Ltibtva12zYWm+q+bJtXiJfBMuOr60h9
WsEWAt6IGo2QG8ip94cG6ygiUpxTMSz7Ls9wNPDeNwWTDp5ohaccghN+zHDMzfa7v1lwdNr1aErn
ElExOSOtrrquyXv+nZraluZF55W8PnRSl7xGrhVGelr+hHyYDcfy8BefOWv9EtGO55oIocLmwG+E
cUu+/ZjeN/jz/Wh3/vVEhK9u6l090j6w1wPq4ZX2Suzg8vlMnP3voE6EGMv3ocLtJep+KeoQj3Lt
KYpSrDVpxmiMsoGV1NutMoLTSSQ2o79uIz08fANVthlt7m4d/id9IAOv9WFImTjK567u9r0YVXg0
RAoILpBbPQuDFuIFQBNo0eu/lFkAy0G56XxpdJjCSm5wBQbdFWFeEFqqLJb4gNOPtxkYtHTSESJf
hUUaM2oU7uwC7pXfQ/0bK0WUWVH0h6FMikbVtBu7/9n4S3yLuj3N0airu6J9HSvyF/r7inCWIrjG
cNaXG3Mtn5pyk08j/dXzUOXC4CH+ztjDRUH6Rua/tHy/6lUuv46IzG6e8ADFQ7J+XD/h/NqFGjOD
zatUszAEeN+1E51K89qVqjc9POQd+GF9F5KvQrkwQKhc99gkPDMvA5rBHhMIRssj8mWV6QT2yy7u
7GuAqq2/lCPSue2hVxvLJTJSmHHjYZAsmnIjMIWPfwYwuQelA5RcXHMxEfw3FR2N5EY09+XwzpXu
/LlSb2uk6qn0i0goYHAZDonKEXXAA17/TEovg4f/vP25Ns3yWlRqs/KTfoJjzdD0ecBWUL8Ce2v0
lkGo6LiigEaKpLeaMBTpnEy1jqG9R/KyJauXoCqlIiLU/OYhUr1acQbFGtgxPdI/AfJ2LuLteQKU
bNVfNkhB4s2TsXb3XC8wGZh76yvZ8x/665MYRz4/g20Aa2UO4DLdYDMS2gK3fNN5uPycHmzGCJ99
aDngeGGZLyHitoQYKL56TmCQcKaXbD3bRhlgPvvz8vtH2JvwH05Wl5C4uvcRcdUq9zj7H+he0JMg
Seiu62UMvsKpcW7UGjVhwGd6y1JxXOn6qsSrmlKJh2t+WVxSKx+m1zpBdUcSADn+0OrhQO7d64J0
2KtkHgKL07kxKo79tcGhChmPB+Ks+YwQ+mVCDvlQhH5acBh/Hpo9iVVhTvK+9EQLB716JzNgrunv
TcQi0GzEUOIZHytzOF3s8m/ORt8bsXgq3puCVgdRxZRb7bCeDjrbo8EkfmCWO0jFq9t0PqBz5VD9
NkbMvX1P6iafpL5FEriUpmLxB72lGcWsrhB+/4KYcMvm1my9EoVPWe1qRxzb3qygUReqjllrhIEE
bgAC9awOiP11bajW+qdhAbTz3Py9zem6hIXXpmReQEorUKn/akcsLUVGo1EDvNJNMehYVCnoeRAJ
Pfb268bfdVluZ6JWmRjO0y2eu1RXTFeII5GCm9lEmCtKoC2zuVM8c/g/1nr2SDXIqEgkONX11ZEk
MZY6Rq0Zl5PLMbudixJbwpOGDleRtCX1okBxB8JqXfnbaYtcqT9/DJeePRw8ewBMmDmtyvbMr0zM
BVys9nteIKRz6PsOX3DshWB6ycsBNMSoTYhp099LUhbqDPW7WP4niILJQMMyrhgj8/SvI8Q5xjJ6
S23R8/KLTb0TmzPwggsjVAHxQdcwFf3LFkN0zGJDqYg5B4e1urE4KsHFTYpJseNH+i7ifVF2GWcm
mx612HOAbWYj+sUjwzA4Z8H+21pFR/8xdAtUUETIVJa8jtbYDdGx5Zx2cEwgsvBtx3W/HuZvvNYu
bqCJjWjb9mXR9pLO4dC3TA4qq22RtPhBkhXGNMahtP1b32mPBe6EEGups5g7BwWgZ4Pa3/lGJ7mx
CD3XsqZFlnzdHH0sQ5pAmCYZic4pzv41F+mQxwj1mnZHeV1WCNKH2rq1iA8tY66PmSVGEkwhjxUp
nzAwXppwCHlMfgqWcNBk1ysg1C25zIkfgj4PTc49zj3WflAK3x9JG217ZDHt85wu04/pxE1N3ZcB
8ZB0zfiKi6GsVz4Ip1dVEK9mxbasaL+PW4vqwwJ7ekK/PlCDbb8erOcmg+F9skwwWedATTfFfLhe
7WbZL/K3+Oh5Ev9/1BK0AaZVAzEi3GNwZGwcirckAd8XQZlFUrSPwwnE93/uzYdOa9Fn7+doGuZ2
9AvySOkmuHbJ/HuD8p1ltBcbIiXB6YZ38T88sf4IGy6v7bPA1GjJBya92u5AHnCMdZzAV06XLuhY
zFEaxYQNt8Th+cesU4hXWWVcJ7E5gLD++CkZxHr+/APNLvx48WIoJix+5guILrXE6ie8ehrHI0D4
ggeiXt5kh+GRsV9KR17/m3Y4pvTvE3PexATYATVrLCd9wsnk+XweVH6YCnjCEyndKqy5B4L6EBjf
yT/poERWATyxS55FrLDj94h3MycwR3D+gRUBkpi9cecMySQMYXg3d9djbdJm16y64PMOmyv6E8Ah
Rfkjn2TV4eqByy3lhfwTvwb2tqAq4pzYxKg/WiR3W2lAEUYDl48C+veUXT6NXFZsNWF+ZyjiYYyg
pAHbVlEdprRe2DCLXZYqypX4VqXrTuWaZVgfpGr2dZjswfDESYdSufB1Go+r+aEOe2Jp9oyWcIvh
LdAuNZgHUsC5+7E0iuvRzbnOpKHwtlVqzPaKI7RyjUQM+t5siZ0IEO3sNSt1gRjuz7NnrlhoYCTH
hkPiyaQwLTCNk42YakKieA/vMuXz9PkTdGcESjTtoyZtANNtaSkmEHkYuGcF0Bhu6SvPQZwJoHjq
u4i1GQBqKKN/9qJpyUfacGEHj45ZJU/bTGVKcf2m2xXp+NkDGezgBytqYaQU2vFLMFSHNN7gjyWo
AWRGBgGLsCXzMx7iB8MbNBMX4+ozp6RJzRMKqV3qEMCWHiDt1QQYLtJxdGWLizWzrA9mBLGeoxmb
a/onscinrTHJs6kJtAJ4vgIUL+/Prv/j0pjGDabzmRxQK9C4fIHn+o0dcL7OnIRst4KaSUiYGzfk
XvAZvnr6lwgaX0d3KKKXiiNZocItYLhk3C1UXKjXhQlyK8IWI468TSB08Af9SZwd0SO0e/hnmpIt
uvNwmFnGafxtoOdF3kQ/nd1gbdyw6Cj7mZSoaaHh0Cg/S1i7CRH5hrHrhaivVab7sJndD8HjdNvv
ef1k2h0A7xhqqJkVS55ZT3jLMTWo/yZBTDLiMdYMUw1RDq5PIsO3G0vtDKGhnGw2EDEap+G+Ii4+
WF0gpoogLBc3SYOZoow4/Z+9jYjWE54nIheRAZ/xJ7cPohGps6+waMCrlqZJxWlVEXIIikczPhwG
jpQDR1oMdpzPPqGB1NRJ2yQPrg4L0fzP9o//t7/aF2lPjWni/fgKsCqJD5OR8PpHCcZGFrkm1M1l
d04RwV7bXdEWOq0Q25LjHd2j2gzo34E00Ktlsa9qMaRCUcRJ5HQE0q30qEnhVrh8MZ5ISvzbh/8t
LDkl9A29pXaDv3LBEKrN9Qyoi0VSORefd1UJkb0OFm7Tgc4DlFoUdoVqkJN6BeoYu/TI3zMlaqQa
Ynv3sLY5VIfXgD3SsrSAn0NZuI6NH9ZiFlrKNRKZKbCHf8GV9nFyD+PnxKb5N6Sa57l0yTdKS1un
uZt+K3pL5lhfqjLUqWT6WdH1FeSvf8TdAG15vRQ/QrNFlzN2LKlTlL6RflkwshENFlNDWolcmXW3
K01Jrs0XPqu3sm93cQCAy5FjFM0QykLRWCKTuvqFf+pKOin/mPX21vqs5w3iSkhF30ybSzd56cbQ
NMwINfoBUoa3KlDQSbdo3WyZsBOWXqx8chAuOrgP2TlcdbMZY09HLY4p+8RzkkT/QMXhvbGKpdnQ
zZDt0upM9M7i5fQ/H4InWKnA03UJqOASv4KsSBzZNFez8PYrbkvNFmYdzzR6aDTGwphNjSA9tTSg
+I8TV8SxhLe2QytY2VCq9BNVKjURklHvcJxLjA7E7vEMeGHxwHZNawFomEx8dnGX4UJws3ahcjm6
ZQBEqDcMlMN+M4D6DTDcqBo+FmZMrRWavN9gcL5Ca57ZS0nMq7DvXiALMpZ6nzrGPl6jOR6Mf2Vm
cR6NBToQc1zj13FTEDvwKavD39yhuSYhrtm/amROD5UWFgqoP1tD56cXPW3ZfUrNWuau+4SBCWe0
ShbAobFNEZPrTDbwGipLTAWqzwipenYaZLi2NkUW08X9bYZ/zQgFFIyYJ3V80R/vzSHRFh58zsR4
tTAXAprzywNZAnDWA/HGoMSyvzQOR/V/DzQUSUJsZvq4YeOA6X80J/+3mwOpRMJ88owpxJlFBx2q
mYKIOOZ5ZNLEdzdaZqmI6lMH0kxLbcxMKPo42yKY+/kZeDtoYpKDL/RofCt6CFSy2Rdrpf4NkKjP
OctZ+vnw0FBnXdxzciNdnI1BmRMTMKOqOx/eDgkQyp/VM5qY7mNcIcz1LfxG68eHsvKchblVutaR
OUlIkjCGybEBB+I4YprW712K3k2lJ9qBObpYA+PoCZXr/GNsJy8vhZ3FDq8IcrCWqN/SSJVU5/Yz
DNvhzhXO9ZHAiriCoQz6Z589tIjcgRTAUQSls5Cc3TQ/IWHRbMwE/gWGkN2AeiZQCj9D57Z3g31X
44F0o2OgmuTU9furclolGO7LZqRL3X11awanz2Y0pICohE1Zy1kViOhCt0tZ+qKAHoDMG6rtbUMF
VyzvtreQTpKV2WMEEh0MBVNakbyC2xKC2N+JZvLA/ENr+S8Gj8Qlfxgr6mU1y4VYyZCVe7NOBWJK
G9fzw2Gr0vZfPdNF+bib9dzHmniBZ+QBy4nGf+a+zzxAvl2zP1HHzrDZBXTi8TzwH8sCKNj9SIF9
8WOf4imy7AYw/U2OfTh5g+i2wjmGiMZPax3jrBmv53fRxap9R7PMQP9plaGhlGY4Xw/BmQACQP13
fYFJX+EtH19nBSGnNSuEKdADOM/HLZESLdGwEjupeyaxVYjx1aIMv0xYitEK597WQY2azcTiEgSR
Cbtfz5JRdkdkQyVkVLh7TvuAmatwZ2gMOS8RzKYaa9lI6ldEU9Nxoms+kNpNJUzcyAFNvQqEHcca
OYmi+xo+7EqeLEXMQM/+NidvajLMb3OWa/1ZVHhB+6gUWc9A5h/bRq+8f1zXtz6L7xt1T83eW+Bb
pi/pL6q9hWcFq9NJctgd1KaFXWrqvM4BWsw3Itb26Igc1ywc3xdmm/EAgd9wkKpMl7msdZ98cPmR
vBUahIZCrSmJaYnfGpm7aJnHs5BRKDL85g7A1tOpSTDIK2s6/srYQ7RsBDwmQJ+0an5RxHp8lieg
iIbLN2zbhmfv4fFreGGZa28Tn6GInvD0qbhgFfFJYl17FI5v8eEBexn+vqu3WNCDjyx+VYSBu3TN
+P3DIwkcS21AOdQrsAQ/6uwM6FtWSa0xqCNuHA42Mj4VuLohhMuyoZjjL9/hzZRBfyzA6dtRHUJX
iPqakEkygmYa5lkuxCNkGRpnmMlwEkZul7+mSVtBv6yJitCgoHV2sRaN/IdoaMw7BYFhnwA+gktN
nSeJO7CEKfcFcxjmWJ0OWSt+OjteAxrZF0JCy03qB9+AyK1jGC+lGRJFHbQKBdUf6CTEy5HWqCMI
Rn0cD2EeruSOiuXy3R7tM8W7HJgdE7QDSRidYNxa5fac/kPkdz5OYJ5On7a2+gVFPMJdf7gEuuuF
bUewywb+jbcCHtQ/PXMFeAbWRgB7a/iAAmM0qF92TZkONr3a5xLnsJbJpOO6QlUaR74JRS3FnumE
f43BzIsMhqpwijdFCiw6W19Uj5tA3QL7KEY3Dw+w7JrvPggNIHTyFoB4zarwddwA4fACFr0a7SEC
zPQnhfykJEzavUjjVf0BpRGrNnrdOaSpOiQp9fTSZOZvsTdjEhkHbeL2YBBnOnIL4D56IU3AFdE9
AUkvWXHg9rU1097ZaYh1OfrbTtXhujafjs/k9KjlQch7Wj/f9GXxLcO87kZksGLY41Zj1U6p4W1Y
kKW5fwbr1A/GGr2RWoJX7F3CJSx4re4x06h7+Cr8GOj0x1UBgqJSG2CHEZo9Bek0ywJF1pEcw6uG
UFBlPCG5tJQ7CLhKAqS9EanVtcXQREVMsa3ZZ7VvvsRl2xrcagf1twLsbdyb0taJ51UFM7vT52tE
iRz2Nn4C9OL9kiEecbb5ENpJbkr1KIQNkNRdoePRAH/OONGwmtwWpuo26hQhlw9+HFozWaVRf6PL
LKIa9Sp/hr28XZxogX33GlT06dIuYMX4WDsCr8YSepR4ST+vpQejLTQk7GJFD4+PR+TEC1WUTgJ9
y+VOOVom7DTpN4i6HI2KIlqUhvqVpACA6Pu77UAF3xQWeOObtepva8y+1ZK2BRuvLUnQZM1X0KHV
KIKInUw4tkvrVDciVSNkh75Ypy7mL9MF5K//E80kpjVW1e8D+CClxeZ0BQ6vdvKLWGylk/GQvCwl
fX1ybU/WBwXky6O8i3jdEAscS/+Y46hS4OkDMbruifcv6o/Ugqv6gVr90rA6ErG7elZp5+TMbfpi
gheR6+BMQOZ1GYxXfK2Wcli1wTydz5Dne/KMo94Lr5PprXco8udzVgS0NcpiAjw95whxZpin17Rd
wx4yKr6jUuBi8Tm5+AFzBSku2gN0j06vce0FM550yLobDSSZ4jOypopW0ZJ6ElIkDrw1hliYoMgH
3t7KnWyAZT7NvchbO7pD3144R57RkNYm2okMza3dZ6KPdfuMpL1oTnnWgA/7GYAcUX8/+RekwSiX
Pt0SO6CvwNqwOZ1tzA0y0layqsp4f6AFJrLjfwZW5Bkvft1TvfKJWCsG7fvtITRA3Vdy3azR4wi0
y7vMHFy++AAcKkIUiYKvMjW70tpCMPtO5l6Dxj0E9LENQUJHqM81KZyt/Plsfg1IUA3WHWdvPSpd
EoVsJgBZZNGATS2lJ45INs/rUq+EOR5Xcdf68aPkbs4w7bRGQUlxQX2Hty9GAsaLsBnNVVuDINah
IZC4MYYYkaCw32iqSBHG3bBEzdVfojXQOqMNwNlE3PAkjntBuwznK4Z2BgL7X3qOidv1B58949TM
wIZkPqneAhtfTiM3Ts92rARj/bxwBHmHi5JSAIidBtNOcpCL+M8Z2wwAnFvxY4q2rm7oDgP38vfN
tyPF/5HkBMIaB0miQiSHOZ8jsCY2nfYuCguJjLQ65R0Hu0VfSLelZ71xNU9UGwWE67pBOaxJap3N
U/ZS12aGH2gUWi/vD6hi3D9HCYwC0SXOy3TKLL25OJw0xOdYuNubJ4l+8RxuAJZtkWks5VB9hVP3
sD3JwHzIPGeePI921toiDWiK1amLgW60D+f1YkFrLrvdp2Z2k5LK/9hKrQSnpn7IKV0TV3Vag8Gp
de9YeJDf/DsGFmEr4kFE8dn5vqOsXGUCyFsAN1PFVrls/m+wBuzMjsuZOb3PWVnFLec3PTkRCa58
5+f2v5ObEpcyDbBtNmV6LaEwu9tsYaNZpPwEbKWbjnXryTRXrtm/fg4HR1W574ZDAbG7DngpI3Ho
k72sEeTx60uJeSapwwr/C5LcipgzrrNyMMQScHHypICoopJikOtDdt0N42ybSMEh45Bdy503DPRb
ZfU+3lErOgNyDTzzrvBWnIwjqWhqOUgcgpayC/bzQChAhnsqN++OmY1pkmJJbDTBmOZmIB5eHuM4
BCe8uTrgJeRPMqAjUGzu5FL2yKrL1x0ZVj/qoUZVEIXSExluPQM+PwIk9zUzZcwb95gZ9JcU5zoH
IQ/fqlHagnwEBPiSp8LdOEe5yLwPPVQfDP4ks1TAYXSCVR94FYH8Ty+5KnGZmgvejq6PXDIvXCWg
FyvzCDK9alknDPp9UEnWIYLYsa+rFCxwx+9y1tea5eTgcl8w0i6yR7Fg54leduTzEJ9zly9tSoY4
yDESM2JPnID19Jge14mAZdCspZlr4NqEEcFYuiSaNm5bm/VXsfjol2Wj2cX2J/9vIV+5FbZbMd4m
nKm1xJ9hz49LGBEJ+X2woXpSGClSeO7sdky5H07rrguiIWq2EUrKOw34DlPsztkkBtggB8dEoRJa
vAXcfz301KeN9HlqUkS0wOeUS0WyYh+sw7SYVlNa5C1tacfX+b6YEhRvWd1g4uWkQLfR9JEGOVVU
aUyNwQjCciyoHw5xduxXVT5s8wtU4dipLRp9UVVuDlu7BVndC3q8Bdd/MyKXxqTJ8PB5U+WYERDj
FYnVAFDoHFlxDvAvZ18eIZvC0OU8JKldHdwxspjnpybOFDPP7UxHwcEhecEYYAiYrHYlGny/vjuN
Y9ULPR7dBMG/dy7EpCf5HVekBC2bNQZleZzXvyCKnfR4uhIsYHxauw23QvdU/Zel/AO1mxAEmNnW
zbpry8uf+Hc+4PZntjLscdKKbngGqGEHihd0llxTBs3sBmwtAEKEO6Z3suDZSy8YaRLjQhlgzCRk
6POoTVZxSHQ2lv6rcFsyDpUh+q6a2Gx0l/cDxEqfy4FT17WzUE1zSLhiOkOcnrpjXFT4nvrYfgV9
SkuSJoTxF8h+YmKEX2dAZeGo/7SxSMguDDSmaRxfV/CrD6CcZxWc6KDyFWrFUvY74cUSsj5kvtR/
t+5eCKyN8uMyPs53x5+WeN9exk9g3AKoEbTeR5LM5RHqALvAGwPP3fTfptoe9JaHLFoMJQuPnqVz
IINYS702Dp2A1Et6x/tbH61yWh6h5vJ1Te8ZfzQrVlZ2/wF2HzgAB8ThxosALz0bXpJCZVNV3swe
PEgT+HNX2zLrfUX+Plg7eYBBtO8lIVURHqdGQtK9t8LY4aeSWhA+Jr+fgMD89chXYPrrbpD2DHi4
X5fex/B+zPPycnH3DRkcEzWSyhiODm+cfiu4iunwdO5J8ywaYDZycuJk+Jlwrez/+kUm7epubalN
NffK0D79wQjJo/P6tgNc3vogBRWK9A+m5exM8PD5nsnM4KKZWoEPhLGCZJs60u6GdBaCwEefVuJB
wNKuATZrZIAqZ9VF4newYeDsCKsqzM2lMhSoBKgLDxKAd9m3YGiEcv3RDx3xB57iCNl6xwsmJ66V
bxzEg3Oq0M3s94MROYMgMwRrKPb38qPU8jlUK9IblcvvU83aGU/xyH9fVOSBD31R7sZrtsGlPz9N
DhaxrwMioA18GZgc31Q1tqG7Udo+qaUvq2MXHatbuPX1Xy70ckOIdyQJv6tSI0OJwPIJ8eXZ2oP3
forVmqIZxt2SOJtqRLPmQq1D5XqoYpIR4Xstp+aXHoKtKB6gNlY5RT5soWryV62/k5rxcDEOVs8I
fQ15yAY+KXmZWsrgoktzWKZdy0zICYO4lY6d7R4P+2c9ywIh8k3ljgoG8r3yj8bCYUPcHmmMvMXW
KIg48xOphlIwQ+T0NE2sN65jKqgEZ+4Ot2bGcjzHrfWlzV3UqLPIfF0L0MlrHeh+AB7tvVD1u/D5
h4avIQy+iIyDnnz506b0uQy/GozRpU5UZCXIo0iqoXFTT2RiYCqBuWfPkkhFOCZ4vWcVuYG9OYw6
EFintgj63KMDULd8hEaF1zY6kdJdC9sqd7GDzl/CPRuUYQ3BVtv6Mr8y/0vaH2fAAFKWIa4MjFG4
/4eOVKGn6dwiwHEoLmKbxcM2QVhqnmX8gFxQXgKYz1o5mzxkviif88XBd+IPT5ocgAQHgFX3IrNV
nX0mwjzDmtLh5hvlMFvcjyBkjIwomgXnl9HFHcNgHTvi3S3N2MNQmjWEC3GKajahqq56hE9FL9sU
FvuvDUrmUDC5SAXOQejYO1Y9aFfsPrvh/2LQFer1iZfUox4ytRvnbkHAYDEHiGfhnn9M3ZX0YiIZ
LjV9yu8+IDMR1uMDXsmkexoC7o/DUoluSX+40fkc2uvIcKyHwLkZedlBhU9mc55KGxf0VdPlBAkn
hLa4N8eRpF7w+ek7jU0sT4fwWOUYtAZE1XypInb7UZHLQbfZn4AH7AM40Nu6BPm2WUpylUqXQswc
xj73vZxWMAurD1zv+PJytAqMzH8WT2g4+prB9OV1WIKxLF1DyPlcFRF+wRwF9pKMtMDlm55S8YQ9
0amtNccM1kZ6Z08xRRmOEGUapTnmItQhde3+TCc+TO9CO4tStHDYnlc1ONiIjI35iltmatzzWxxa
bCFA6HvmcGnjez6RQLKWjifXWFM1VrdF2gUYKIkykKFIJ5AvwLmCRx1ucM34V3uvdXpnLrueJ4Qk
n1z4ZPlm2CXnT92WJFRclTAp7lpVRYi8Ky5/xMFiWzjxwm4rMc2wYpkH8eukKVkxFlxgkupNy3EL
Vd4TytKvEeEnA7iPuvx6t+cpBxRHk2AJLLZsBdFaev2m1S5GgwNNhu16hM6U5BoFKv6DhojX76Sr
O06Tz+ZkrfYFmEgPsOWANi591JaJskCgKmNn/O4QxZl4mPB1WpJD0MLVqLWd/HDxd+dNnQnbxgfo
QvWIlJ8tTXt69J3gxH/zYniIMatJrf43bV5RYczJoGhKCiq1QDkaJuRKDiLvheSLwikOpcJavkjF
ijn6z74m3nw+Z3hY/NZS+FC2ql/nfgQhVMGAk8xcy+Ebq9ktnWLson7E8TKwCKGbZY+VCTqhx+LO
e+W3yw8d7GtmVnrB+m79MlTAPRDVqmbBF3gcvbV3taLtuIj85+F1lOBXOYaGpCTAR3ijkqeTk7RH
GL3p/HbJNnX5wHV2uhx+lu2AfZYY5L14W/FQhzQ+JWq+D/Z6Dch4EsrBnVTea6poKupKcLnSkluq
cWeADg5iiLYu05ud0x+Bdnb/UcuaWGMhMa4vd3CqOHmjZALS165KmOgZgDFcNHMLvLzUBQNhBzlN
1C6oEs/G/LKvyM71Tjs14Z0NuqU+rbZ/rz5FC4iSyEqJAOFcWv3Prppv880UggwNiaLGfA5OT7VJ
s/9DrMaR1c6xtAcgczziPjwGgbcnlASmgOrsjiIndtrMJDWSJ0iCV5rXAROmvHfyPdubpmn2KzS0
Y1J+fg2TGzK+Z/lYVo5f/oNdFmbXHGbPBsI/r2Y3vz0ndOHnYoME6uLZZkMecdZ10TQeh8tBaEBj
oRNLGNA4toOuzt1KRugWWG435oQD1wR73h7aqhQjJIyQA4nQ5YZ0+2thKptNsA4708F5ov9bqUD6
37s4KgLWWv8mhm2Dka1KaE3c4TbEK/0LevJ79r6of3sZ9TFf/jcTPRp4etgBImBxDiKsDJnO10Rb
OiwOO/GFzm5uGdjiEwCdtmUAE4oumvpdRM7QXsGTXUW+hwFQ2CGUwnkFbWB7R1g5T+k+/coDFN6U
xXHkmNH5is1E/bMp5P2cnbmRGOiC2wGA73kQXtlJBi+OVddO7+r7lvtDDjUzaCBYVSc7lOxx7rsC
w4/MJlLM5mz4r/jT93fWfmjqVnh0qinb8q9oAH8i7KrXVgGUKP9WmUK9Ki0wnTk5O0zMFHoOOoQC
tEn8tNUP3qFx2MF4RIW9k1XaoGxMFoRD5A1MJpGcMbP3yBaIko1U10f7e3uzFNakDcW+GytOq+aF
GIywUDp4g7wrOkDGB7JNYwENq6ZzHmYOxrO6RITmeK5pDo3qh9F5SDCn+s+H7yvxulYpCu90J628
ThtiBlB/nv9mMMDLgWSHE54BfktvHQOg52aajUVZlC0AIDfKEkA3LpQiw0ceIe2uRdGSqJXfJd3T
r762wezuCjeqA50ODF0pQXIB1VaGt1ioHNxZyjoOQjDnazYoF448loS7ZhrZ1LfpG6OXetKTZUS5
Z/m+HomLLuoDLfAB/f1VRGJR1ebHfrREaxFQhN2sz86OQKCN5FCpFhCS4NP1C7wfpNzPO1DlE1Az
fDLpGVuReV++8vkPAg/gjP24xrDFBZX1w9tdzz07+OQi6FEnretdQAjKuPWRpYrbtC3oexajo6Fr
5m9ARWdMg/bol6gX+RWjWN639MpSxfw8jQA34o0btd3OJPTPdKRRiwiOIsnhG7CHopOlNt51YEOo
9g81/NOTy0W+U0CMDNuXiRUF0vmYTJpkU9KxnPkkdh550h7GEdU98g8aWokeRMhvs+5/EdRmZ9VN
orCsY8nQt1P1KU9MeFn2apslA46HhTmsP21R1f0mUWMqLZuOcj1MBD0CdfOK+vx/7ZIviIFWpFIw
SYrMqCojx3ucGL+09Uphdy5hFxAxZ90TCAGth2G6EHJrRzkcUDoYZU3FMSy4UySA4N8ZXowIDTSB
e4GWyuHe4MJUcDYOkPZw6OpuqDxRPLHJkVFiUbIOJEPmHuk+Ei+Sqq5lenK//xRXR4EaMaNT+jAr
iAfXO9KSLQ2jOKcbo9orVbRu+qM56WbqHJoJ6DlX8qE3omvzwDULE5WwWOENWcnkRjBe3xRJ92gf
8du1yE7CWTHflWrfchQ0GOiQpB8DRZRaH6vIUeZwtV2ukeHDAqHsWAN1YZ8/F4Qk+sLO3DZc6DRF
hHO1vUl5KV8fcItw300xcU82D9oLb54V4uCdpcUHCSZJ7QFuZ+3zxMS25IjlN8GoxR55SwX17S2q
NMJXjTIodpt3Ij1+9eMVMyWLQTrk0WPuywjDoAiIigVu/IGEqs0ISGTGG45TP+5OAn6gvN2uXPCj
ATGmwdL8D3yJ0HCzF146SLBUW4HNs9XtQjle90tCct4xvn5A814Kjs+y6K4gl5H40ZGpj/SsE44p
bx/iemhrePi7n6PWz/3vf6cdiRUkFmz6/FaE/lRXCRj9foueoMi/mkxfEA5tExXj9LdzDgubLvM0
KpAzvVfUf9E2HlwKOkqn7lG55KEBt+AkKuQQknllzA0kl3pqNt1ETQYTJDc7ThvPqAsZTzfsAbct
szExGua4BbO5hxM/c7wQ4rx66zLC3nw932FeQh+buFUCuLxrmBaMpjz+9JIMlMwnZfwb5ljmlH2K
qchbDWpTNZT12kEWdMqxKJu9IU3NA6K0bW4adimYnIknRShVnaBR0oxDeuFShdskJI1zko9lUrbi
oEkGrdqxYrvYDaWODzvL5aEp1yWRMV/yTdPdrHvB7D9fWBcKgvfS43RvwUMy9KqirwXj02gTEcFB
e4+mk2NzpJBvTIs6UHzTH5AjzUU9fOAju5fcvAopjSih3f8dA+uhCFP2oiODPsjr0jT8DKrgu11X
MO86hO+C4eDcZc1D/psov5kef65FJaOSOwJ4b/GtvAbBiNAcBuWqBCU7aVaSguAZgk4Y7YP1Y5yZ
dpw1sdBxr+smhI3lVwq7mEGzLwZkOFmG2ZBwbVeXxBsyGWnfAOdtqenEn5sxZmrN7Mr9pfEKDmyy
jQ/z/0AWagwqWKGVvM0tQphuKDc7lqvr+0ZACW3Do2Q77FnVt4oV5k4Z947pwpslauWYLSYVKttR
pQ179dy8FRaH1L+vUThsU4d4hOxFgQfDp4LTRIXsOfbKa84u46NNtpoJ+XFNpAxYOP2l97LNCShN
ijH8j/xIWMYfgAFFpceyc3jFgs8AroU58kUlzTLulFX7yR0GcE9SIOb7j89xPSVibZdf503R5b/6
be53rWUsrgcuB9/UW9NeLZQcyj27EXpLjt2cJ5KXwr87oKNlZabVZ+ujdONiQhQp4Ri1jlD2+QCP
yN9kj4hdAWJo+cfvJojotNf1oXPqQs4Rv5ghElzP1ttThiDCnH13bbvD3sFl6DCxGmJz92ywiQut
5WKEKG/twHsTEdqd1tTqkIwE4sPtSZfZcW7mOfuEjDroITyaFM4T0OXIRVw6SCCquNv6ERikf4j9
LAfYFYGm1Nad+ePovgC0SSYweskMbBkZ3VVYrSPzbXGjj0rzfBXy0VXqFUN58PQL2oaR/dXZZ9oW
UyUoBRZ1KZgJHJdKbvmXInLaa5mk/ysH0VF2u39GkC9Hbj3JhPzk/Bwgox7Qwja7v/zgEnJPoCQQ
L5bk6nVnT+WfXSMkTaQQkMxdTtd/zARnwqwWxU9PpJ9C1mWV2fKxkCkBvS6q1G1hXJMshoP/Qyax
tX3sXDDd0JJDeWSrRDBm9XOeQV90ISckL43edyjfzAobr6BB6xBtCnsaW8GxN7CPJwpKPGeUw1ET
KWngo+u/8SccFDjHmBO5MzSZSOTVhX4bNMDhqMfQuz+E2e3TI6nZ/zeQtccUUJ1iGq54AzB//fJg
3fxQwAziaSpi1U7LHpQRS1EBlpXxERkphz9ET0xGx/rU/8hsPkCE4xeYvttaIQLXc6xBEZ0o/uP/
t4Oyv5j7JIuORRWPxnJ8d0ognhV3pWYtwBPlZvWrJsMS+0ighyhF4qk7irNXm7pOYoqJg+ltLHOT
PKgrzssQsx3JDd3KjaqYYY/EjOC6bFT4nSMewWVE2uXahbTv3XkP+lNEP+v2CNmUOhgylPa59y9v
EcapRvUv59xF6eeWxg/opXSxO6mM0DdCEZz7XFaGpHohIAQCP9ltmNpd4ciT4Msz5jJimzHjEX5M
ukGAhOO1bVFt3hsN1hEkGHGAD+aCxyxWygDUQACe2bMcQkouH2oPaERZuo7QP5Ns4KzfImI5Yogc
OlzoUqHKyHTey/5+Aym7zICY1tbD0G5uQ9lR5FN3Xly3iePH+obfvhMiGqjRLFmK3C29J1Aj/5C4
mVb2EVVwa1VKrOP2G/FSlQGPS70ussDhls5mk+238NNxQummk8O4zAacLmsNRG8cVcrjt9WAWPtK
JSDok6YqRDoKkYk3RD+GbD1lFgQbXUWY7JGG0WvZDmWXQvTqnoUo4vxsoc6f/ile2229VT1NPi7s
M8QLtusf0lbcHLJZd0g6qyN9EDwHAI0f2YfXY4eC+r4ys2QY9L31aQo3udGFraZeWbgo/MjibYRA
u68ceST+4s6R3RFCWL7MPad2HnMa/qNf4DN7MYyauxZ739SWcCTyRwrWz2WpOkcIgrbt7hADWMTC
GHSIiq9L0yEfi36lm4vglBwPmINKB++xSaaiGnkmgyMNMLxoJOedsoq7e4zrY8e5AHR05JJZQ8iU
enJI8XlGrAJNpLXtNwc90Lp2PA0pHiBy2X/ELfh4AZ0ebFDUwX9paSMKp9RJyF+XoXPh2+SnLkRF
ZuxKQkgEz4eN6re12Hzjzo8f+Lk433ny0HMLPJIlr25+kX6pZpES14LuCGFa+icrwa9+bGAThvfD
/mNm4KJxgAL4sXX86bglE+Cv7ZWyS4HK2DUfdOZ8zfqhkccvvprx/I+x7G3zLgQPDTrMifcX6lH5
z+y3m9oVYbzZSEqZ/sMQeRbyHMSdo/jRKdXzJsTco5gGCj6+fCmzPChmobgiYilfOjFjfnvvZ6HM
caMGOQjzZBeA/MhRS1Dg7s6hYXc1H7r2J+pPp17HbQtcH6CjzAfx/3rvu58PuF8jsIEtk1tDFTKy
zqP9TypTqlhspEjd6Ztveh4QxxA3JfF+yBhpvfNDlCYoTr8lakMm5THoAMc6h/Wt3SV/uUjmPs2Y
rM4WxVNHQ0y/pZBmLpB80TGES9YuePgnY7xtJPvrflgtMD7PvTG9UIFV8z2DTqQ+sXWlusfqCU0q
BXlzZC7LM07kcamqNYob/SBOrKRd+lMiZ0G1PFVoiYofak//5XJtOY7Ig2XAxGNiF5/GdbhMLfpb
4vZ1a1/a268pWZARHeDAsHuP3TuqRInuGEOr1sxf9KFzx2CkGuKjQPc56OLnVERzdVp1CZ7syo6/
fMwPMMB2BHuAK6Dwxk275/Zcfyi7SvLxTHbOHkUctlVWO2xVQB4vbdgwcBOzn1hIn1Uj+oTtrc7r
zmBiGfwLrXP21Rxh3aZY2TPEgwDjwF79rl9B51q9wy7q/SzS8PJDyNY3Boy8OJ2CB853dJUZq4BK
QwrHcuxyPDsFgWhPkJRLuhc+r7Xkn83RfAowLGkJW0bSd9W8FrsMzwcIOmLVP5/0NTnTGI3Tzgjo
Q8UBcD6mUCWE6cU9GPXUQKBENSd1yzHEpehHs7jmyPEKEO1SmngiYKx4N5uwm7SJvWPuYzbiDwYE
LcHgJ2jxeIMfkzusPnCEI1b1xu9q2OFkv0PAr8HcHG8NbOsBJ5o0ehszPo9dsQ9V6SdKu/17KOnD
b/l2okKlE4H2JybQLRI05tOL2nwIKLfN0ADWZ3Cg/iGiuPb6ugTW2naLERDOfo5bn9e0mNI8lBcc
QbvprjVlBocsxGOHB2cw0HZblnxCCaLI2Qv1TikDfvdVIWjbAkiktgwtLic9osQhNAnwB0XeQGgo
uMGOU2IEWed+Ii+H/YP/Q4U6LajPuY+9XOlxJSkZFYDW2mbd9tqy7QVjklgM2lp06L4lgLLK+7z5
qurPCf7UjpfZp612JXjGWuUXcUhbpIzMG2/7m1odbI5g98iKV/ZoO4MHi20Blwa2bfxqN8keTepI
TYjsJyYHW4MpTKd8tbs9RGXfS0JYL0JJv3rglMA+nKo6HEAzBdi/jDT/2ZIm2yVpD8Kr8cZcYvcU
NbdQzC62zzegtBQrvWQ9pLYmroEJQitCQaIbkgSU6HxhxQCjNPuGAd0YHWVQavQ4ug1k2B0Fb6ZZ
hoYeWUx9BIFBi4QfO8NplX5qJTxwV1S+Ei4i85b4aOpQCoBc5N0f41g/aEVY2/JzxNf5ODcIOlHE
xn2dBBrNrre7MPbvelyhHnZ1GW+F+50OYJbXT8I/8uDrXAdR5v+QdqRx/Xul74G/mMY72xJWJdL+
qYEYBXPVILGf+3YsWuiSUuxthxSPpR1+p7Fkjg2W63F4vVsyCTTvcJDRMNFRM/k3B9+11wLtlcb2
cPMvZf8F81v5EwkLMTCoktdV/UxfYnC3lNZffyx3fxt6XhSLf4uCdTHaviL9gzS2THZedlSlzXe5
/yIIZLu0bOdhYUXBnfkx9duy4NbjaV/NZvWee7k40/xOqaE5FEOy0fXNGOWmKYlGlwFNjSp80GZu
tkAFmjTV/Spje0RM/DgAen/As528nP4azFeBfIN5SQoe5U06JfbVzS+YkSjI4ZY24utTuwpvOGnv
/bmKEvH+tl5Y5m6AEPWd6eNuQXvObE79daVY5HTz87tBvvHBSzjMg2izgnm2VfYI8WWOPpKsaLA+
YtPtqp2M/KTLno1QVqN+73UfPIvtLzAmuVWCH9Y3HGICQ+jwj4IqwSlTLw4nDzrfzIVCV/DMzvMn
daBFrhjzCcFsMF6I+fbo5xv9Ad4ALe+hBphZElHqfF6Pt3Qrlv6wnzzJuxAZ1ZXCmYRGwHLtEdJB
iwd2A4+9CZztWLzNNTpaKRarrvzSynk08oxq4An3vG/N7OqfJ5xDtOrUSx774gZO9CMIx+3TAiUu
5RRXt50tTDd2/kMihVUMcSgcIfr7ZkUZSB9DAnsYxERap0EnFfEMuHLjEb4dUz8co4GUwwdCsXKS
Ff562xCyf90qSVCSYeGrfRW1WdMioSVzIAajQxCwIV5J4x0EVEI8/Fwx84ydS6hfnPdH69kIh4lY
jwDT7AcvE3JhyzTH00aCM3m17gubbKcoQ5zGJ2oDtr3d0LgXG8o6OjsJLVXOcWY38xPBskIJa+1X
iWZAbWX20TVWj6/rtyHGwYijNhGCnzUGMhuaArYxys7QJa1n6r+GC68wYy0wHzk6i0iH7YeUxLKW
bCS0nmfDxMUZVWqOqzcL9f44V6DJdaR5uIVBT8xzIc6jl2CEnKz1CuaOt1o5i3O8YMbtIViXBDNY
HHavwZOWL4J+xPU419mPpaNg9WeEmIUer5nDBHVA/3CRa9C+XWs3jON/2H78W0PEYeU+fPEDNLkz
nnEoF38CYttrAVVSX+OobSE9ubdX6qu/tbBhJhw8aIMvAjvaRMILxBpZb1evKBlOQBizDy7zhKXG
gjOvq/1bsh8+BfDmkhYR47mWFkPKsqyk6Vw70tt4QPzTfavR8+hwLk0wRvXrFDiLEJaqhdN/ebGB
jdn1AFVb3kSBaGYksKrJnVc7phVKU5pHksuQeu8zar2O6Wky9Ba4PI1UsH2843lb5vbbVIsytFyO
j7/Y7VnWWrvCgPxdbTEJaVehnDe6NT3ztOh+AlB+wTi8jLTI7a/yamYELu06LJAyDM9ZSsMFqMwn
ugIYSxvPZALyc9oq+QXf0SnT5/eV5bfknrXWBb4uhmxvayM3t0j0GPGVcVgOj4GqqPqsTHJoRHIs
dtCYrMvXe5AgOSefDUA8NTdc0fn7p7YyW0rZExdoq4bNCZCeIuOzc2TQOzxBb307Q8tN+GxE2St0
e/sWKT7YhfLo3jcIlFjkuSM/I+RxH9YGVwNDxNqTBvj22dS7fYrq2Hu4TkSlXMTaTbLa9BRmgwiD
0MRfyLInnqxzfIjOaSgesa91eFqdqhl8NnNy0bhHNMq7iwLrThAuvA3I+7aUrm2w4t4bIlUJHaeu
1da5wvTvjWVmRLv+oOuFmThTDAkCUY0vmLhodIRORdKJ67TgWTqUgk/YEqZNtsGv6rzW9WBm3Z93
QhVS+2HbEsbhkbtVVAM073LYpw6rin+fxZSyI8xeAxbnAN97/lX154L3bHt1cHYnk2Q9gqP+BuVe
DW84kJdiBBFeC+kt7YGCMKPavjFkAbe/MzK0eeq1Qz4C2yM8w4mISPQQT3S+i/3SfP6XJudw9Pfx
kgEkwhgjQnNITMHuX75EGW+38KuOv43kVFyMh7YbEY7GNOa+mEjZA1EVeJBFeP6hteZcuTuYhPQP
eIbYfm9NgXW99/U1EAOeVfOaF0oGz9cfA56q1dtvZ0oLURJ0tU9QkGXrfFFtUvXV14vtSPHLnNjQ
R+dNdu/5X080xCESzkzt0/820u/yi2fZo48uI6Tp9I3SSZSx2Z0wOcK1+4klPvdMuDWqlwPOvsjI
DgsgGU1R42bNc1zCQD2H7jEGt6ISJw8GsYwMUby7VLJG9zzp5TyXEmntggAmPWbOCIQ6XQDYQBha
WmSVdFC5Xyu5lzTMIQP0X89dUlVzrSI9dczSifokKXmbdccn2EEm+KIzoRAIUrKaJ7uly+CeJ3uQ
HQCJjANQ4ynBghSZ5naIA3RAhN2PDj17DD79v2Xq02lb1XKmC303nKZWc5dpS1Y4x2EawquTB4qf
jKttPMPlj1CbDt0YCAPJX08nA+zBmMrxMEJnO1DfCAe4JVYcvhtIdpsYbgEpOs57BMCc+8/DTtJ1
buqc5XxFlDKbz9uSoX4N+VSjw9F5v+bJ5MR4RglhqnxqmlvY69vdwXyXxVADe1NeEAOYMfY1Zh26
2KQvAYZg4V7jiMh0maR6kqkgfCuEUewfbEIwXLUT6S6DI2/8axkkUnaYpa7ofcHunp11x6owFmp0
IB5x5XFaI2LF4NuIKxzbquJXP4DxNsC+ejgKyyA2mlQlM12fGORaGvMQkpwN91il4SjIn8AAeEyg
o2+cPgJ0A8kiOWq+t+5KP5bBiU+b2jDVIiPqIzP/lWIyYOvLILeT8/jnrgQQIf1XZILWRS4SPW+m
Yyk575ZRFVbHaCPrZSi/nXUWtAS0QgzRQ5pVImaEe5Tgss0QvA/BvM3oUx+Qdw3DSmajO+Iocnxy
AW8KX44pFzq0hQSrvV/zknS4iQQlIjWPesd/cdHknnXTdD0oNcsTRDSFn/Mov5bZ0O4s2JmtMs3U
4WyT/ro2GC3Fsm6iYoggeEETuEl1QXdsOQxUQO1KyJNdumRvZ6o8uQWvTkscc0w3Hh7XJOCh3T9z
b09jze0Iy+YbkK1DZ90nP+sHPjeFtcV2gQyxIdq+y+EK6q9BdwO98Ifekk1owr0U+skmSvueS45N
1Tld31iZd7GsxJtzW+CA+PmD1VtxE/+zDilGzRsEiF1ILJbMhHKQcLN4aZM1QhwRJWdw6SjMX8rF
rnvhuX1I8wsXoQi7lfMxBsTcTabFjs3EaYRscbCi6yYaih5+cPLqi4+Jl/wcOGbbUZfMLz5709cx
MuGQuJJpWH3bst6u+K3iSyoQBJKDSJqULEH3OmTco05wQUcDCg+3giP2EQoRr8c1KzN2bEPynmX6
oixvL3B181tEFqQBRl4O/vXZopA+wTLnBbZXJObaCFke31fs2CTdKovICc0G+tOh0/XVt/lkTlve
RP6lZsjViqhTvjp6EyB3Pk5HiYdq+YwwOuofaYO4FYcvWbz3Y6moHDRwfoJbT1G9l4fQSzoCbd74
UCevsMxEjlUNRZrTMcTQ82/Ul4PQjRk1SA/9oqbpk7YraQ7YSxdlqeHnfZHjtUWI5q4lClIcDnxn
elZlZBhl+L6K5g092IQonJEscImK4c7TXuBKTyAkoDbs/Y3/2TYKf4FD6FjRDQF8NT+pfXUb3XPT
UkLruY4IrJ6F+c7dSemkKgV3+hBnB890xhy9jOnFvZo631B8riUZP4LowMO5Yaxo43o4EzwFaMNQ
qBIeqxvKImQHh8Rnw+eCfOVmHVKpu8tMaiL1HP8T5+s5L9z04f2NqSUwAhwb45ACN1Bj/GkfwV7P
Q5c0x0/NUqGEslq1gqJTS3/WW79n0ZQ7sieaGIJf96hxrKkOqXPeHjsZIeWp1Ha7ZT3neiQKOzhO
i4AhwtJAl5/N9Rb+vvDfS8uOvj1y2AdGaWUP6E7C25+rEorDuBNq6Hmgptr6XBi+BplDpBAYlhCM
UAJNLbpcf+oY/Ni2kR9pC2MggzrOvsQAS4rB3olub2vyknxsuvhvGTt3deec66Aj/klgbB4fSUJw
uTHw/5o2LQaVOu+R1sFYn8qHstbbGH6vgNweVAlTw1OKnpePT38Ee3u50v6kZvliuBq19Kgduzq5
QbtfJ3lxhaI0UAJr3DkN6+110V0pXCMePxggS9Bed0yjIw11OghaNmuQamgPix45LAFVZTM4x3b8
bMThUSfpJnW0L3bYWfpy4GM7iNjzPeLGg9XMc1KUHeTu8MOaoGSzT9iaDuR1c42an3ORGHmy7YjU
52YOTAVU2IYVJlXmWs+CRvLdxLOCl3pKLTMEX1PF+/tSfd7XtAFdHkQir2VaM7BzGQrhHK6mJTtV
YqkkYUPOEZeaZRUqhTppPtDwxP+oVxUGPMengf+FBhGsrnOjRJT7ENvyDHr4j/Gy/w9wc6FQWpg5
5SMWhb8+8dAchFMdL1eX2MRJpcYw+WyiqTwbu1TYxl0nvReF6a4N+n1nl+qiwIM2hCH0xte2EQ/k
KY/iNd4Jybl5Y0jvhJXiN+WEorAHF3bude9czcwrTyI7cpNaFC2RHECl1k71087kyPAuNdwwNoKA
J9+53OmfbzVOxleXZh4A8RebkwVRNPGoURCphgvIe8A6EwO9nfujqBVXK76OqGAGQQee8FDQBTb5
gZ2RUWRbhNYIbZdaSagSpJ1vSRcV4APhhFEDDhSKy1DB3pJIJc5sKkEyo8r2EghsF4sHoJUACHSB
1R+DyWC+BStlxnsCLJDzi9rj7UQy1kpuQJCMeY05xNCAft9+ZGbeCf449aAgx4ETlZjtWh5tVR3F
ogEfnphja2bSb4fz0t3n7/yNPlPSdzOY3yZdX9VnaS8cY3t2QOlfHNAe0Dgww2bMGCkstNKHQgoR
cP+MV5lG1N9uI595bBWSjxNFLYagWJh5bxfCkUhhOi362JkdV8MJZNAhr/9tQvI7kRsqIQfM5wzc
FXR2aqhpkXVc1w+idiYKHRcS6LKE1vz05vWmItVcy20DUsYrhqgE0i0nARvQlrXldLpOnsAkW1ik
myyPPyGarfUpkpPu/4S7eEFwU+cTSRO04EolYEe1+9Ggj0OH/iP/CmTCGwoYCbDublFe7kyfKFy1
D87oJq75URgRunukPrykmPgrriSIgvdLuFQDMzoRIJd2btMs0KeRuL9E9m3+T4//3xbX9abkVCDV
OppUYyd7oHkElrMcf96EztmoElUZgvIAq+w38VKCrd/CTCwuIKaLSXhOwoTbJgFKDDQzchq2Ff+M
Zzgkptc9f4eCefZ0RKVTJ/xAlbR7Gh6nqNWUHTC4e/YESvg9cdknA5dYm3tywlnb0R/xQtGjwZ25
6d9rbdSl3mou9fKe274rHkZrLNdKls7UEBzEmoTJdU4ewEjmr9pICioJ+C43ReFHBvM+PBmcRDba
CKlfaE0Jx5/FHxXaUmPoAEH0S5oJOLwUsjaTOeSzYgNbl2TKWC5trd2r9kXOjyHb7HoFCglUcIJ+
z1xbjthbfISLTMLEBEkmN9AEP+RMkGjSzFY5zu1vOOwmcsf9XyhPvVCc4oZOwWtWO5FVhaCQC4Yg
SCmlzIUK6vVnwyfz4NrLCQcLusBS5kibJpzAycn0EVPf3ONw5WKSrOPvwNyIiE2x3rYzme+iYfxe
DK1rJc17TWMZc8ihYOFRQR1NxXa9YidxtMWgc51Yl4LGHzlJd/MtF38g3D6OXK0iK+PCs8tHfcJn
F5vntRex/IvYRZeWjgQTP6TW2Enes+mGLKx8vE7/CkUMkIvCr21cUx85JtJy+dIOri6fdCiPoaSH
mSC4ZwTyZ+qefvsN5vIkdCIKu3P0zFoR5nQVHDk1O4y6KsJUoSdg90C4fXOreS8PW1PYzaGO46rQ
L8wDE0Rt2AnKTQGb1ghTMmNx/IP3ToP1CK6jd2DQj5ofylcOz3Oxc+4eyTEBCYwL0m2yU+dJKF0Y
VkyM9R0Y2DRD/ejKVsuy6LOJ/51H3jRDEojaUxwH4R80Jk1QfZjef9twc7XROH8oRJFf91wHd1xi
R4B+Dk5KM9ZtVLbIky4Ln9Tzh1C6c8fqGkfV/naR3doSU0YeSViv0FRZAH6/KieeE5cCtwqjto+l
g3B7ZkOf1Hw+E7H6d1qnUSnM0yNBfYBYsXUY0SzndjssCll3voBJi4qBSzgMDvKUOrzMMgBpAce+
uA5R6BMiYE8kG7+gJQlvxg/0SqS+UJ1fUETqw6SVIoKlt3ua9z72saLhDCTNZmdWQFqnw778/BaO
WT73Y4bYPMZa9/skEf1DrQvWJgGWpuInAElJgvFcEa1ApbalS+sfeid+f3zmwHg0010p2g+pCUf4
4NsiDHUJ5cj9/O8fPtMZDUIpxq0p/cLGl168Q3fqCrc+Pp+NZjUzsWIVTlMzryUZJwEzTkT9/3IL
ZyNR2fED3Ca0vGGKk+QPsIkwPGcpaC8U2kpn1ukXOihRJ8WtnzU9B0rx8KqSaNcxgY9SCxkLyXbN
Cfevqe4m41/SV+wTisizv3koGUTto7yxck7LHaAhC9crBuC/Gw+0F+tbZ3eyZk3IK0ATZUFNfLJc
/JzL4wJRzHSh5cY6qkqRaGseyRL0IWF/UtUg4heKDeA/ND74xKyUtkfDw12jrtImkYdyzAJ+jm50
yVsHp9v8S3D2urCU64/ahZjbPTQDlXncBSnl1TT0StW6DQ4nJt5fH5a/sr+q/xzH76LNHt2pJWl4
QtyqV67H1l1oZvXx0NFR0RB6XyeUrWYH0FwIj5t85BtXod+pvRdghPEmUaJ9ZQs/xi1HO/cMb15z
f77dW93NzMV4d/d1/VjBtNy2w+RgonCajenLE3JKExAzsNGBDJUwilGYpMHf4zn7D3rxSljFin6l
/k58MJ+HlB4dc1DyyqMKrGls/606HwSMmRnjWlDhxaf5Ny9Om9IdF2nq7yguD9D6S2L+39l1e9hs
VpzBlUEHBWj2edo14TdoIvzGEFJr7P8GLH73j0suYtrFjA+wu0V5K49jsLt5BYw6ioJBR9Y/RWLw
n7HTqDiPAWGjRy/O4NiiKZ0pfYrXPJ0rVid0pwjToS/JaWQTxZ312ZuBCbgkLdVTNmAECdCiMbAA
dEO9tjPb3cqvVZUK5uRrPRVHv8U5buHEIuA+zhF2fWcitk0RL86w14AYnhnkBug2x17A8BoaReRA
nLOmnxaBFThKumIChl5oV6kjcXAHsZ84xRcA2ejetx0wZvifIU6McBsYeOrkDIbjboi25mn54/3v
/lLM+PmzCwePphGG3vmD2EprTTtCDr7gC+P6zJnYxJYlI1KurlxH5nvHxFcVi4IO7oihvSJ0Mc78
aIY6MpexZwJ7b9EB7fk4xgCV9mPLfCfNlpHs5jtsn8X8HgNV7B22E95yNfKsMw7DPBjO+SWZLev5
P5+q6YllomlbY9cO2Z8kBREZx4m0A9aFBaqXQMZ4SbmBIfsQqcVOmXbltKFFGNXaEI33zid6avGi
vj6RIvWF91iWLr2M05Bb8am4bcfyxjmXHavR5oct+K45TkPvUVQnDwr5m3v6fKcOH9Vc9G/HQ9KN
W/Q/VtKJvtXSkzp/ykkE4Y9x8bQpkxoKzOdrR3kMNi9zyoQU1CwloqhW4MYggKc6qJtk2Y6FAcA5
O/2uaJY775MiBL3xcFwZOcXqE4TVmtt1SVkNHOikWKlz+tLvCvRbmap+qvDKWTsZIhtAAxweoFYF
FJqw4AIc3v/yzOWl/5+805bZ0dk+9B3CR++ga2Hlw+fbXIUaI+aO0FHSy9sF4SkuA423yKpBhqqr
Y8b34uI3AwIZz9ZQpwt6uDF8JKOrUQfrESpuyUso6Gp+UBvT5wkrSDYQj7Gc9fZyfZy3mB/1UueS
xvqWZaib+XRxILwPkhlLxtGdGq9LguTk2FS3+zzfhIviiID4zZaMWKAkclV/jld6OxX9YH5Cs4dd
xJ91SZn1elHVL21AnXzCG/k6WQcXUihH6XB7BUrV/ZkxL3ZyPDmyNuYpvEcJ+xx8Hxp+WzEhJSE2
UFFPw2KXVdSwFuoLgxtgVEmXrjwvtNsJFm/96DXfo9DZGIJ6Z9Qlt2UMBp++WnDJD7YJZFVBcd5p
hHb/nBFybL3FrxTMnqn3gnqvj55mj/DPUnBb6jcjIM8SQuq8Eb8hxSTGv/oblQlAmbTBjcUpOdpD
v62uQVgEWoY7QukGRRxG3Qf2rzGpT7xW0uQDTaDvnYmdjtS+5w9/82l621F9LETjbzck5sbJsDdB
7loYZmG1LIYv+dofohEprd6FvWIbJoLBe3YYDzVgHAvud1KaDfMNEWhmFOQrUI4OuiFJvhC0Y4NQ
2AIGjvj8Vs4WlKxXFCE0at7p14MqRNVxIrmyQMGbmlkA7sCyvez0Iu5zApRtVSMd1Zb6yErbhzQ8
VisxEL1PkrR7G7aME7FwoWCV493DQySa3/yEU+RuwTuzqpAh9eFKeFSfIi2vM6Jce5VGLc28WXkf
NeKIHsFS8ZxlT12TpKFO4O2Pjq1viRus48XBB5PNaHf+1z8giMRM9Q5aWQt35K8jWRiJLLc7ySLw
UNN66DNPcbscbtPxrD6Bmr3NZxvpSHkFudhfKcStntwz4MRQej4yViepgmEMd55BZH0+jNU6dpNp
r6WPITHFUYxwXvRmO3n0Jc5SpEa2/uWTQiOacOPGgEHHQl3CT5j0B7dRHNiZpRGzwii/ssugNqt4
HWDKRyaOCMLInFRyP5Qr9QclgFhQb+sk7W143ACgKJq1kmjMeIlozLa68uq3TrU1PI3MvJITG6Lg
WAer0Vt3MLzxQ5XixaPj0JRGMEM+x2QKO5QNK/ROrgskjOtPNkTpN7qlrxt+R0P17+VesTpl8V3j
ToHwbcGg8+g5eve9uE+Zo8rH0wd/NLOVHeFcge6C4/5as22zeKdWq2XrTe2uU3vcM52ZTDzhJUv5
IW8+ZmslDEjdftMD/+KGIjOCt6lTnsmheYenoDJ9iu/MsWuvUT6oOV88UBbZUg6/HcUy8YbOwTRx
U9cEURVwVIpReTEH4oArOR9h9vd5Hy+g2h2j96TofDYkdr4fvqsaKMGi/goNLcDoVQwALyQKecUR
UB+x2K9IFTDy4xdzOOvoG4NEJRclgsJ7xekgSdPp+KqVlOHsxWi9QnG00vT7od7N2vsPmJkEorU8
WDrvx4zDv3bzyHwTllHi7F1iU6C0HKY/VYPwAawWm4UteS11Gh5aZh0qr53c/ESGRzpOF2MUM/ma
TQpc1GFY2upBRy7YJouIQbP97QiKWoTRJog4NJQzOL22ZDe6p9/leJhBB2K/QVrqfdQshgwBjvv9
oouaxjXuKm+AYLWA2LdNPGCCJBB2Bb4MEgDZ7eZcDEaWnkRpVvzuyw0R9mIGf0UpiDqrc77wjsrA
PtRx45K8kebWijplboSFfdDgY8Xl3u+Gg/a4H3GoCfRoqajpoxW75QKdWadY05kLHw+IGXnlJa5l
k439uqYF7CFyF/b8rExDhPq0IH37gQuuHwWmLWZB9Wpim2Y2gpWuO8HPHbJlmRicdTf5z7SZonTV
27kYLFvEV75f1AN5XGRaist/NGefMYP+C1Apjg6Oq8+KTMwNlWS+T0Orp4pHFamBwPviKF0pX1Uf
bTULW9Qc4tn++uaAQzwYbJC9B3XwsMnF6+12T2sjKk09R0LBm/drlu/w4OPm9Ha2tanQZCHUrAzu
jF8vhOBFO7C1v88W8hAwWhbV1wx4vBejx+EzCgcOoHTMBVdhFtvKa14pS8P5tSLXoQYwabGp4Bm1
iia6hqrWdixPRuvqPo8OqXNdr1UkghZW4q7XKKYDf1l0iohidCfaVM4X9pBhprPGSvh4J1T5ZQxh
aHKK6gCNCeL7FLKftNAyEMzHLRI9Ph2p3lE0I10jhR8mG/GtVXqrFfSZLPdwERVs2lz7sXtfOpW/
BgZcprmQD5gKBMxvik5gMWwqSRVOlopfBRumJuDaOJkZWy3GTJ6YW/76BI/+wv/BMUKCCZDTTAMJ
nwGOJNOJQG2XyogeRQO/WHOZYGPiqCXHIu0A30x/qB5LBa7mDmqY3UI2YeDvQrooj3XqNvAnhhlc
sh+JVEQpNfVxwf/HXFJr2x487Dno3obcA2pgePaGHDHoklmHQ66kjR/vdsgCoJ5CJYN7ppznuPxR
ctt86sOyPkfqUJZZQo85owleiuX+AIrDnaqA2dkfEBOeAGDUJLzBO2l8V0DaAI1EmY7X7clZIQSL
mYA5zKyF3v08PPNVCxEY5paA3bwJf2Rp56sGjRUc9jxGXQs2QRxvKmgKOzfsLrpQL0g091tB2R9M
oY2KUIhChkpIBu1CKfzA/Y92lJPkO7ml3ufysDdGNV26mzio2JJej7ypBhLQVui74mWUrb+3MzCj
iOGgLD3m03KAtTljzR0eCIxOAei6hqxq3Ld3bNDBb5x3sDQLGAuHSmTLGwT1214EVxga6AgtHM2e
q2MdtFSXdnV4Du95oylJSM2UyrRxZFOwQEDeL+JNygWWZUa3fl4SBeUvhqx9eGDBKBkMQ8XtbIJQ
dzDmRyHfqRVWIws9CCFMZr3JmAPDsVszwvSy3xqDRhdrDeSFB1kl3MJ/9E++niHgbOiivng1g5jj
YnBmekMNdxy0pcUjnywC1gHG6yC3ecagIRVVtuinMyZiXwdpD92VBY8iSc1B9/QAh7+3QJ7dBgP6
rAcHhPxqQPrNzeQYdvrbEbjm0f8I3Ss4gQdbqlvJ9GAk1sGqz9uOP8m/Z4WqQoR/Jvt3FNHbTG8X
o4sDT/TWBtCS9WEtOJOeJ628XTmI3P8xyWq4IpUXpSxIgnGctYNxSa3a4U6TyJOzlcIK7NSa1vgM
8FpqgBDRg1DoAWm0LYQN94ErWfnFXgERCCGi1J4GFEeCIUHEgm5fMjTeMcLCebIZzZVSn6vofQue
uh6t/whh8nj/kkdLBJ5Ms2LAcc83vkes1ytuOv7Ms01E303ON4XnjfT7JIkGv/Hg1MmdQOx0XQe/
4kHLGtCOrFLgmRwxgnSss4GtIHzvu23ka5FZpkq9QIvzClBaYLZQK7KWf77kA1P6GmK1mMBWdc6b
UJIAD61yxYk6Xk9JS3y1ci0ENgJZydlFccqJh5lsFmCTnjka4EV36krDdWLz7724IGIvAFO9cjn5
fekPnTfcu4fWz1xSu3wWNtctvKxCNDKQv6Ld9YbCDLbH7KjwAwiAnq5mfFIfkz274I35blAIJJ9I
OoqOr9HlkIuHzrB8VcZ7nssSb9dKXII5NVLFTWXMHVrn3sx43JJhxGEk77fOW+4lvy7tMNXxUVgC
pB9vB3lYTITbIhPM+mokxvPlzurVDZKCVRZ3w0q06Ev9rgW1+cmNLnbIa40bfSM6yEBmAVWjS7Kt
+o6YM4D0TWCI5eocl5yS1yK0MQ1YCMfG8taEEMmUqNWb3VfZ11YH0ZPP++5nYvy1HAOrSnat/NCJ
ZC0kWmqTla8WeQ8oxwKlbJXRtN7XE6cKRSdt3oaeue/jGGYxOLufFDFcS51z3DRNJh3AnyPmnGJC
HHvTRWoubhVGaZhcgS77b3jdXRS+QGoWWOEcCwsaP1buxmfvp79TbFp0TstN+GGF3d8MZ9rnQevg
pKYkqWXrU5VU4WZ+hqQA+NdR8dYr7P5WKbo1qP/jBjXNuAp1KqO0j4Vbsv5ci2vj0rqVFgwp9SUa
YgiLi1cBubsWUL3YmnUDyq9gM1fX4mLyOo+ANdue1UYLTBfXIHZqNhkFk3b1/dCI9w4UCdpKuun9
l2SEZtIHxlfcP97CRAgQAk+UKmnPqF0V8H9E2ByHb0IucYoP5PPwlHxZiyQj9t+1YaZt3sgnRNPh
6sjC1MKfZgELrNcfFSFvK7GQv0e8Raa389axIWKaX1sUBScPtRbFAhaqWBx/4IK+N9gkXjsJoZER
KkXsaw6KjJxFxn186oNPR+0Pi57Pxe+5F15J06nFcK7obXQwgiMJ7UA3tjd+mg7XrWkhqoqiCx5F
mPsJGw2Lx5wTH9qt27ZimittgSpAjR0Hr+A/HhIt5L5176fUL+M1DqNYUcLImmz5I9fu1+DvavEV
zCWWweLM2IhpoI6Q9Q70GhIFTHOPPRi9I70ITrRjiJNY7+kvUlAwW9F9LuGj1360v92oHa6kmGKj
ExBG70iL/zmOV93D8OCXQaYwLkRLbbeaT/NcgR7AZyenhRS0VX1DK9mjAzobn1R5mjTND/gslL/t
CRuJswqyQtWGP3qMjZBYaC/OTHqfJM/RAyR1uKjJ0rztfszYLX2Gyg5kGfMfZc90R3Xv3mnFklzL
Gc15pC8kHs0ewAn5eJFv7J/oYvKvXvpkGflevcKah8p4yUNOqQmRzFgSzCmBfwPTmmVjohiEdASJ
aLy6IPAH/1uLZtg237spFbZdEou46oQ3v12QAlYQEn1UhojBWMFnvTag8QXAk2SvhOewP7auD0Us
nIiOj9I/wwTGpq9MKD9nZ79Co1XBPqpY4w7GaBfkYlXwbLDKR0+crrHdLk1iWJfX8faJSjQQbcfz
KwJfM6GXzwT+eDnvips+TXOtUOJ9kZb+ewJ2RKJ0+YO+xvPaDzjW+FNg48K2AH5delDQEd88YZM/
IDnn7wLhwYEUHhaiaMW2KSM9QRgTTEhOpdWE49p8fp6LrSk1Zd8eZk922jCrVKBZExKtlJjvJlDN
n0lV9x5Qeq/UieV1e8nVOvdVrk18BGOmQcu5px4BuUHODJxsqUOAzdM5b4sdEP+iwCKNxZIVF9QT
yBqCMdYCNl/lh6lhJ7QvTQ5SqRKXOCIAcBl9/hVghmpDrkqxzwIn9LviO0TSUuoq2JjRWcH8xdkD
80xy28nUJlyE1DRrQ3hOfgwiPFc5Wu07PgjOf1d/E8Qg1w6rg1SEkpDpvmnOqd9crWbSm3Y/Ko9b
WIVQh+sV2o3iT9/qfwWjMSo8dpJ+SKHw0/478JuQpzJM9PKNRFTYr92Kr83POMVEua5oYSl4galM
tqgz4mKj+azox84pqn1GEw6CzDcWKqxBcCZ75vdOSbH6ll/omi6PydOy20esMInGgDMnfd6UUHmv
icUGN69hD8ouydILuwKtfgCRFEhpSX9oU3agVn3xpzEAyCeie7rjt+dkhVWzT0ahvrxDKQh7HqCD
maqh2opAsnjrdz0KpsxnoBpWG0e/zM3kPGQ87D6OX0WLImnm9exJTnDzrGEBarHmaWIETHjTSORJ
kBK1QCr/UpQug2Soy8wByE9hWE2uJRx2wEWVviWVyrqzqv1piLo1efC15/r2ZQCE2VRQqRMyj21m
ZPY+oBPVonmRpJR/gnYM3LUaoVSE9bzQpT6SgVycxscJJN+4HHUX2/Ic/dG9IKKiTArA3fdkKf4K
bl8QWFEQX+WtO3laz4dajTBPN/tsuam0A5WQ2qTrUGQPG4O8hsZmw9UxHmbiPw4vSxWpanfvbH5s
t8Zo7FF79BgaUfVW9I+ZTmFlJ7ItybMELeYuUsXACGLG1o2b9ilXvCE+/g7WJOR7J0F4aIJi6WtH
Xioo3p33vIKUzmgZOibI1RTZ2t0GEcG9I6Wlg/dg7YBrP0JWIoS9bLqdv9tRK0GizWhNuvNVx+9X
wZ/W5LxXt7StKIhS+tsjNUZ0WYGlbK9kKsyNL8uqwhf08LgmrcZkB9gJdO0kBr4IhiXny3fQdQ5x
00PjpOZXTIjI/Igxr25a7fQWf56vs9ffUy+SShzWLVTANOLCZCTvgAQEAT2wNBuYV1KOi4ubgwc1
w5cDFFgt4lklGajVkzlItfU774CJdsf1g2I30lLQF+pI17EuQTSQNacGuppXb5u2SJSNFG9GaKw7
j65YNi/ioCSGdFMRNeNxHizah8sLoB6D/LloQ9iZpEywjdd4p0uVk3ue8f47T2Mu6PsfgCXbHRCu
C0w59/wJMZ3jfIe2eyTDoi3jtvFK6CyoBDdvNaNN+FfWpK+KXNxc9oA+UJmboJ2U/jpcKgLEn8+F
1yNXD7jzYondtyqtXvwehnMxWmEVqMF5daC/mdy1v8LpoEhb3BnpNTxu0vxVARqIm7yFTlSapEZB
FTNl3su9H0Lm9ouvMDSJ0hz0+uPF25Zsq6Qp2aAEXSAjHHf2HU7TcQBJjsu2/QJjKeGeXFs0nhye
x2bjExmbPp43sH9GowX26KYDpViPZ7wbPzI913IF3vi98Hac6fmyP9KMnmQmkMRRWC1ZcuABZpOp
CGYXE028IflFEWLLisnPIcSD+uY1MqVTVHjp6tiL6CtcaFcaLxOgZD1hVA1/qVKYFSVz0h7FiTlK
rbM9RZR8F51Nu6fZc16vCbvsvo9T/4IIRWx88I8WxDV2RKKQe+c7x8QBk4vTiPUjqwDLCNAob+fQ
d9SXCHcmKDtanmrz68x7UnGLl1nA7XCkqA6S2Rabswj7GgClQFFTbuShl7gj86MH8bKi9tCHv0Bx
EeuhV1GEmSR3gQliSNEuD3jDwQh80CXw8n8j/WfKBr10U4ca5tesEYn8hA92GaQQ+iDqd6RUIjlQ
LXfNPEZnYvJn3+4qfRplEcOcpt9eQkInSzj2fwzncaXnogWcdFkrmi/8hN0PMJR8zxpnVn63QYca
fZa8SEy3dNwJbPN1frH0qizjkN0cCe7yX0u5YSLwDvs5OliXdUXjVjEvlW9MF8tFsw0uRdu4DoYk
+C3G1MYAV2e65KNY5FqgxSXLaWRPT/POGy3gky+xxsACKiqeyipq+K4mRIhS7uUbhs9qiSY/INNO
TljYqjm3rOsai6ek8B/hMXbcKLmvuwNI7hPlSyQDGb2MmTWwkbXV7A3do9l73wbxPaugdFVfcg3C
EkUe1NMgs1FV2K3f0st1HH44gHqyVtPwjcNBDkmoOiV5OOib2HVSzenZxJVMm1ucytaSRkyfCmbP
uDlKrI5Y6vcbi8R7Iz7y98a/35Mm2XGEWcAYCZprdDXwa7LLwb8o1Pfxggc4IBIPSZrCY8u6TIIx
efYleAu37/YxWISSv+OIoBIpqeWd5JKZUMf5SV/+mg5fumMNBYRmGLtNNaXJN62679GYsban70GF
o+JG7CrfjqNue2RP8cFRsnYDuZPDJ8eU7foTHfF9Q7Brdw4Gvv4fis+CRAPx3MVcgKEynckiYrvL
7aj63eicDPI5utAywji/HaxFdff1W90g8SYwZsDFZ8lriaVaKIKOA5+jvIp1RV8AiYklyMqHZXSo
UoZItIn2EB/1WoZ0pylTdMWx1Cukhivd4GcF2hgPgPb/z4AK0aytkfgNx87vSOT3zQE/L964gC/3
1nZQcxqPCx7tKN3neMsEd89DasEJuRpiVg8WMW+09DTyYvFAjZOQYj++13PkwueVL5Vnn1nulkka
LC8ddQE9ktajFmQ7YUG+hRiW+KbIzYVYnLMkHV20uFU2p71nm4Ox2Rlk+Avla9KDO+ATdfT7h2aX
zqmcDBqcYSleCuWr3DIgv70vngoOnZhDJiYp7tlY4YUZchyKv6fkb9i4Qt+kWej4a1U2eAPZc75v
ESm22FUyH4SYmcWHh0+dn4mTSjcoAj0o41cci6Pb0TTzZmCnbqea/mW4Ykt4lkemqzXuo27VOY91
DB/OCHlddK9ScCIdFBJEYgyUaDT5ufQOJ5LQaMixgLYJtfqqiUIRyr6YKNn3L2DfgG1gJYKAEBaD
ZWaW+os86frpAWIYMea/qJbWfxe/rc+Pg2ctgE87B6zSa9dYqAoovwvJha9jGtR+VnZsCkAfJuFx
vHBg4W80SLfC/mpx/MQ56yyLwL3lSLEEacF0RpF+4ZJ/Yke6jqaehSYxTaXYCdtHnsjXJkXh+hXs
RliTXZtSNYmGm0VGZZ8thJ71DorI87H71rcCcMGfatF9MilTrO99DVa1E+zLOd3+v/Gq5Wy3bsg/
EPL6tv6UMO4YiJItP0PuR99bQJI1ib2O/S6wklIwpw12u47jtxw4aSujFuXlwbW/nV/1dvhkuae6
jgAo/mDy5FJHLDwn5OXCz1P1Eb7TuaT6GkBAbi+/vv9HrA3I3pYkvVdIFCqYJlcVjWhphw44zCT2
JZ32Y/5RkTtwcpL8VfOwk90KobuTDjFp/Kb9mYkIaf7gSA65WhApcTc6ytUSm0b3+uTquaitQdlj
OEg2On98aRev56MeVDDJO7mwl5OPa+pU0L5xAkEB/2fonOoI/4Sf7S8GaxwBvhwgo2eJBIfYWjbE
BADje05N2JDHmhrkZmfLGoehu0UPCJcrwkWI2yDE1L49E1db0twaSxBmxUfHrWtthR194CKj743y
62t3UYKHizyTL9CX69mMzoQup7UO1Yu/qc+08hKDqtDQAeV1DP38yFucpzwE4usXLe7krZ0GC5tv
63XlAWt5oicNuyGYN6OuYIxErdpEHN7Vm0tykIIb/L+LDj0wKBFNYzawCoimXumIN/LYZGj8CEon
zXefgfq+2Odt4OT+6tQwzi2Rlpirydzv6bCYVEkBI63JOrTKHzP8qu+7xb+PaNqh5xHNx5vceiKM
ZF7YtCqBsNb/LVnU31Y0vRVwS8H9JMF7dSfqgOd9m+SRGQQfcmV7fdQq3m0UzMLVX8DKxsGutEHw
UmEhNKcY13p6l7MRtjLuWF6SXd7mOxxQ1Erv2/HaMaxhT6GDiafuT3D86O7j633w5MuqqHzrgv9j
u7qXy8GAtUfWfzjINnccwf5jzn30dDSuX3Uqf43wzn6kcqyB/UPP2fxRP870LQyZoDj39WFeiuf5
mHHRlvZM9IdAyC3WbQBa1y8rM29Zws4hqJQXs7B3A4kmf9M9+0q/XqWeUwXp521hj/bmW8bD6Ssn
1520FCS4ux67PrtS5aiDy/orFjtetMeWYVMS68bhG57YshcD6qDhnPtmDEwDiY8BgNlSaxDcfOuV
aUhgnL0aCDcKFldauMDx+9E1RcltbT/jLaaSySX0Vg50Guoq+zbAMJe9GiEDG2epQ2KlJblbi/2g
krnFjqNklW2HPscwcptqNF/vinjyuuQdCZ5Q7QIBDi5wMcO5Wnq8uLYQzsYbw4uc/z2xZ779tKCi
kowwk5VH8aK6CnKFSd2svP/Dk8WEcSGoQClUz7i68f2hfS0FQhhHramIp+j/DdmlSjyr71fwzFM6
MHhOMsqTfVJFJF3vv4SzHOiUDQ3l9/9Q0UG3IMQn5ywOgz+Ih8LPUrGz8RkzhhwFKk86pU8Hg31Q
KVflAiAjtBkiDTAn9lKNCmPzHYplqankL3L1bfmDTgWNyh+jBHwBeW756SbebE63SyIa0Yh3DKGH
FaSRlqs0/qFbVV4tWeZtXli6OuBPHBbPZjDluC4Gz0S9DrVBUhaqFQINBVu0zhr4AQTuphbeLC+r
Qq5Cbg2i2CTwJQ4ADx3WYf3r0RhcMaXFPZZ4SLGS0tjHmgQjxTwwHJeqIwMc7QsMhgIAY24TVpEp
1wnLueGSc05eBYLFHB2wIv9AwLLVAEYvaNwp/fcWHezfT+rVQNniLAXReIYFAng9LNPPflyF30Jc
5kc0MbA7X+ZLGihtPy3Cc7SsfxUUTox7BUNYwlZgZ2rr08e1sBJEBkxX7mxNZ8sY40XibufKtInT
hEzNK65p6dDLEKcKLVV1GsuU5FZAltxO83bVYKSPRgBUn23YnmbO3oQoX0w66VbpsRfIqAJQM/hV
YeNfHOyM7Ie3TeLDsVvNfjhABxZLsoP5Uu0kY2fHk7sDP17al3V1JXJv8s+iFDjZC+2OadkLnT5m
llEWhnQWSuSNXZghYET+6gKWgpmPjPhkQ1IlMgXRDIkeLQ7Ks8urIua8AWslRT89wySx8GzaNfeq
UC/Y7aFxkqJwvrwDTCLsSV0/4a1uEm/ZLSWcmBYR0BMmgnJkHZVbFFUSRbUB6v3PQt+k6+him2k7
oGXB0AH2walUyIqU+BzaLRYz0HVYGbxVO6z7Pbs8zdTYAJ6O4J3I+Os4xiudz0r7u0MEq0hDeTM5
mwcVDKt66eksTxdT5ashi6sM6n8C1XAMluXm1J+fwVGZsBVGlOuGcxj5EwcmUic4VQ6hHJFW7VNS
hEu0prdZwx9BbnNb4+4iQlRoyTTzO0VA45DaD+lfio9DTlRPfPSPIG6nck3L0NfiEq617gprDuVE
Fypx0dHz8/E6AVW97nym/fw7RO3JVidlo8666QnsWSJ6VTFfiFMvL0aYL0gBJ9pWTC7Xq0FC5cdy
TqhrISMoKdIfzOzTdvdDqBc/gU021MtGgu5vkrj0vBdz9+z3BUIVvE7gKR8hdcNkXWjg5NrOWlo1
8wbiACfjRvUv4vzZc/Rg+pfHEcIVWKyOLvefK2TvxM4YUGpTcpl//lKZpet5gOJjUUfuIC9NPGC+
0YttnqSXSRtMlwvuyk+015y1tFCsaGZj/9dE9dxqc5qsrY2O0Y7fnhKQ7TAHDq/bplR/WRjtzdV0
cIQV1llL/B0+PQ1zlsTcu5OuXok0PdSMLWTNv8W0VFM/wnJcaC8arm6dSXer3GDSrfx7ebQuEHFX
N9y9PMYq2anV4p4Ed9Bho/ezivSSjbK4pn9Aj0ype5lsnenP3hadH/AvRL71+88lIwiZ5ydDX/Ld
JBlY4gk277xBtFwG9MsSOV41UxN4bnPwBY01IEk4YoWbC9I/7ozGBpG4v4Djrg+SCo4w5PaOure8
wpWxwlKdmsmi7rOoF4yK+i+WLOl3vRSVWfioFqXPvkhtpE4sgrUygunUdGINYsTo8C68E3+nWYuN
CI7m8Zkm6byBF88QsFmGK0r/XwHGCfMs+hcDExg0/GNN9m9KwXLdR/z+yzWO7vtHxpfFS4u4mD5f
Atf6UrzMs11hszWREaKBNbJGtzSVD56Jj3HZLO5lvXeFkW+0OidNUmXf9SNxbJEIHuh4NK6TjJ4g
+GpscGGUyUR4UIXA5lNcP/8ir1JbQ9Lm0BLcCyrrrOZJ/M7c5A/ODFkl8fb/HLr3fja06IAkI+qe
jZLe/RKQoUW8M3ruhFp9DumHiNsfdW+uP/rTkKxH8PztAHDV+V26+s6b0+ypeWQicxPQ9uLWTX37
35YyeUHEzb7v2/+lJWKvTPUPtdBUMjmsb8iOWOvcEYd/lrcVFfIm7vBjwDzZK3DcJAZ7KMusj3sC
mvA7ZGqnQNhmFEjq703+0A5hT6AoqOQzAhA+0+l1z0AHxRW4L4c9uO/c9CGlkQhD5pAd4z4QioQP
2Utgi+jxOQeTRwtovvekAV44gUhHpvdZVQZWlKxXqR2fENgYJj+qA85b0KOz+BM72hnO1dOr0RdT
PsqQDG1drl3sARs4petPzrbOApLQkPzigMNDdp7DqSYA3yWWlc4gc25Hd2NhDVYTKyNyuvfxM30a
5arOpOtuzEN05GFJJgmLIDEC0+92btCbvatsowZ7/U8SmOsXUXz2nLKaqdg+Vt6U/ZWAbYgU1OEW
CWVh0kaaczGFQb2nZEYdXq7Hopu/gTX51A/8E8Oj9HItTVyuNwsiViMPImvEG8g819DZ36/6SH23
UvXFnZNHo8UsqN3CuQLPBhUGdanLwtqkQ4J0j7NW05/VU+7Oscf/H1HfcUN+UT2JD0Xw01fbRH7a
j5m/AuTYK0dposqEyE+mec4LnmKtIhBxjvi6ISD4b8ZaMDM15aimUzWM0u0JKr3IG//qYAz9SqPP
dc/zF8/EVWY7bgCRGeuqvv82qTLTyGHbKejjTCDzpcP9vzlhSnAfZHCAxGPYlCz/qF+39a0OuL3j
e9M1CrgveTInvXvvUxOBSISUrywzA0daU2YWLczMdK4/BB1k15pZ+ppIAoK0XqQ3Uhro1m6eV3/C
jV/C0akXR55fR61GTmC+punyWrTg9JfAfAcKpmQBjvMa9U6V41hFyp2GnQPVoyNbbokWm5J6RKn/
O2BXaTfZKV6LYMN6gurklmXxUHx6WGfGX6Db+DcSJAgxj5xTFq1bLsY1o2RL0Oaz9cCEBxyb6a5b
SPZbqkYArC25MoIOlt4PVVYac8GpAUitpWdIN1bWfRvIOkj277J1rO4NC7HkKPWHZefvaXzPB4s0
MistHMs9KB4YozIGqZmOtxHNcniq80+1M1Bjv3LBJWrrJ+vNnAOPF7YpCFQy0D71jhQxFMMaKF5j
8iCKMznOgZcAOquHZdDtLhHufCWkXk99mnz0Bva92exSb0mFr17oJISNwTWkivpxJNjrTYtPBez/
ikV/qQXSLF0TMLyN0tx2vmQ2PykBRDKczArW/OpZZmUR3ntMw5bAZnEs8wIVMTurTIMuZIgN4cIr
Zjb3cNL1S+fbNYPkWbTkzO5piRPF4uwpeti25JcT5agWipKt15zPfXhRqmQn6+MzRNniGo7k/7Nr
S/Cp6RDZHHEx2GjgqtBMyZZ9v/QjSDHOBeJEkySrq712NowqwR+CYazTDGUgs6AFqZkLWVoCVdGl
79lnnj5ejgCL+MsmBtXPxDfyARFp6lyQ2LLQA+96WDbOaiQcqE2prXOUVRHKpgteXQuS0+opG33r
1vDuy+XW79iitlGNInpMeA4bZ2WiHw4bwkwX6XF0ieh52pwxGSVzw7WSrI+PelwoN5DFpidblus/
fqxbv/N+/qj1NszX8KnMKLex1SK8I+pH98d1gSu0mAw9kLqQfBus/xcnCmQhoTS6DhxBSGrcGw0l
6Ez+Tzpgi1L58Gg58iQdM9kPGpNKkQH1U6gq6kjcKlep93Rr7z7sbIh0tYh5Q3nrxEtqGoS/+z9i
4cQJhbPNbo49X2rfZlo54TBhZs1Y6IcEdHA53mtODN8vW2VmfdZs1x9Kcmdc3TcEhYKgnM1ISBWq
qaWevaEVGWw60V68kEwTkO7j37tRDQfjbMrJugyK734BCKnsO9M1dflUc2dpS9NVeCQQxKLmZ2ZE
/PkHhyYYjN0IxKbgX4zHZ1ijPClIWDLH+AF/lwiXgnke7fpgdI1htb4iVsB3s6ZaVtjXgHNjE99x
SOuqfXTmks5XrQkF+gKdoSxJfN9VuuF97PNP4FAcRQVG1RZ9380CB+w5WwPfF+RWQutT03EefAHZ
+hUGxzaA25qBJqTLL7VP4kE9bzj554a/gw9HInlC90KXhrHt8vDtCtoygd6lGCEN38OsHzm+znze
HN/2I8igGONzeN7PV0q3W+6rs9PC5sYHEM3VCjORBwDNAoCOeHv/+2vUad8gx2Vw968IEt5sF6iq
vACAa57C87xdLcTL2CtvB3GwiPYiXR9s4TS221jqrhCbOa5QQAHV6XIJyF2ElMWxJrlvhEHbwJV+
XxcPKsnWMwprH9fWASn3Epjno752ACH9QVgVbTUHXqWeUgUpyz5/pkiqhQF/FQkGa/Q/2J9RSfw8
msQEXmVQ9tEvCJErfrhgvImQXu9q4oWDicmfuaZE8uS66yxj0Gp3OsC1c97ENk+LOyE0fMuxZSfv
fCXbxSFQzBYRLDZfv+tUHCaeaL5oP3EXDz2GyqEmuK3x5+piv4eDR8ORZyqABVwAF52ifuR2MsIg
Jg45jzB2dJGFxbQYJoqQAGS1Keifh0LHTOQRkB74qp8bGGi+wQQQk+AgMbzcxUiWtF4t7T2qScQk
LfFw+rZjQ3Ira7xz8lwX83sygFfYtGCmYmcPUVTMfu58UDkK5RBxEp0XpgNYK8UnqUqpg97CzSwG
ASeY3omSi2TN9E0Oj4GEnvhgLm/vGGpolmmSQYo8cdB2Y/1sQajPuSn4aedHxCnmeDtynghpz54t
WFbiuufseXf8jEr82NrVUlQsXw2IMas16RxGdyia2pWBeylXv5xnJPud8NuxVFK0DrHiNIlDhYnr
1bEdQZU7ZuT5ZHt7Ws9DnSJX948caMJ4pmHw5TbejiAoziVR1jPbXHl4VqHJ+O1PtF4fTPO9JXOV
Y31qo+eUcLtTS9MpudfvJLZscfTu17Tc5p4POGWWStCyq6Vs/S5r4DkGAGqsQW7CxZ/xh3T+q2Zz
hzews4+cSTPKoNtBOm9p38BZNBHLKhTue/p/R8lmF2rhRMjODaVDeASoHj86iPmtNLFP1q26xFJq
k6aUCz6wtCLd0JDD1RVHdrljH5U9AHvcZjq+ZybiDJpPl9BQQ4mboeM7Yt8mRUuwxFxQlfIsqAjZ
TgUAlfgX+NoNrP1JfzaWXx7N/mJdl+p6mSwC4RUWY3LUJT5i7oB510buJZfruWUVs1KvZ83ObZeh
c+E7s2SC8y8PUwCYN3bX4FodSB1drJ1krBCGOOz8GeUunHJRWJ6WuVlOuIwTanfmT/V4GHsQflA/
IyBWcOZapMmH0AS4r5CPvD1GRA9bn6qmCCsj8WBaq74v4LCy/vH2w+6OfwS+cXjVG8TmVEV1NqLh
DtO5kphtQPJvd8a5kihYeSCwZEbPh7nX9wylgDqIfKD5szrShIDPdNYdIa3Hf16qKJ6LkQ52wypo
+dmCuKysRNVFctJ/ng9IY9JaQQfTqU0EeEG+T+AhFTKZU4HQUPwGP0mD87c4i1a/tt+0d+/Y7kdQ
n6oA/xjWFWGrc35yUCtQiMipzX6QwkCrYe6lKfOsjfNCyaoxksyshBm9ArRvtAXbrOxlB2dMQTCh
So5rWQcQMmnqpGqOOdQLWpkwGwMOBW1CembV/CGGS6gW7tCa1TopCeSO6SZMK7g6LRoTbBiLZNPl
IVyo/9RZI7I5lsrbdkP7xMwK/Nnh0Wr4JZ1ikRpYXkIyyiR9uAYzhLJbhDw2xjwrtoFQjXt7xOSH
rwnWmB0hS9s9GuSv3g7M/kMMBu/eyNZJk93LQ0ObeiLh/PUZwFZUT0zQ7eqwwWn1pCCr7kcwuUW8
Cc9lNkq5TPVELtHT6KpDszRVazOsUtRg12ybahtxNx0Yo/swbVvanN4tEHy0ndQ8lYw8XYjp35TT
ixTb0WgU30VIkMVQT0QRydQ/wEeuOPLEq/u/FNqhgAdSllSP/mXWQ73Kjk26qUmJYUMm0Vx5dC6T
9o/RdmsjJ/zXvv4ftA7SXf8VmvVQiNBzag/5YdF/Ep6wCtvVGyPU5XjlY0S7uunE3RwC0R5MtzpW
TuMpVvw5hrkrWNm3RVffY3fazZys13AERlkRy2NsqW5hsWVOa6HFR6ThNfHgqssTA80jHwFSDrpy
lOviZFIwV6vyXEVZYe5ug700eKhOcJnrQG0v2/6TlJGRUici9+DwEIZjFxYGBp+3nKokF53XmjHO
vEAkVUcuWV4uDjNDr8FhZ6n8/cGu/4rGGGLcwkTXAqjiTnQTU8XBoxyWc+5WB/3E6PLDmzMSNwSU
Cn0ZMO9mvQ12sPAgjT8wv8RXKEejD0m5mD1MYB/Em4tdTf/TGkB11x9suya+WULiPRl4MXMIx7Jr
TP2IFhAuQVUDNhagFUKZLB9G4MzV+Aq4JRqDs9cm8sFXcd4dwFyzej9by6c2gIg7e+Z8qAe3ka9T
t6n46lYXtjyWU5/stgfiGxrULZ/DXwKCS31I1ZtRvOeF8++7vQ7DQX7VP94+25UjLn5nXG/NuWj/
uVutLd+fCMePGP4AIp0TpqxRczXHsiU/vXja0a4ohVX/FXR0MOIgmCeG8qOVZF5FgmDqeAA5RXik
eYSnMdiQgZoFJBxwcrrRsMTXPjJtZ5oQCO+Tu4n7rJKrxhkZp1f+lMFz7AJ7S67F5GrOBlRKWQnh
jUsCxF45kwIPn8MBgTVuhh08rRaFpuwdK9UWg7BVoWGaPaGO1byCZ57S/cK+V+5kBwyO7jeHV8+v
/p0xHuLPwcim8e8dehFEHaKIsKtGbp0CFulHXL2ooU0rRXkqqHyQEt1LpQM8CJ+LNnylssnkCasM
r3SY1efCgN7B1Xozmsvd4oSpC72NXZfzic5EOzFtrjoC7BUjODBTt5MJMc+X3MHymGsdjMn95wpA
O7izv4WD61KiNtm6Cr78N2MsQb4od88nyDI+eQiGaPltiogZLvpjMthAUlC7TUqorg8340d0GNxH
XM9mQphG4WQ7I+8lWsw0nXcp4m3a1ZmwkpsNfUjujtYYVax78yBFig7Q0IQXvVpMn95DiKBASU6O
zmO3KpHGayW7O5PzJc8MQdE1uYSbBQcjRvu2XJSqBrXJzs3aMNxdj3AhOOBR4V9xwvI90vXlde00
fPM3h2JazEMiCF6o9Dy6DiXB7dfkmdzMTf8J1B4CSE96rwjkKolP3bq34sJcQGYVKvYmx9TIwPn8
6dU9J9tbSjLqJ7WAs39fbu03wR27qvjoDwvqaJuOyTiUVOm/WKqOlhgS1jXrbbq+wG1UJ21mWP5z
zYg6RyJdtf9KNeZsoG0gCgw3rGS8+X2Y/Ppm1r/l5GrrURQvlyKq0aoksMS9P10J5qiQLnXqtAh3
WVXyU8/vuPGzxYHlXCBmk3PXXmewOGAbSP07e99/7KkBia2qnWeR3gNyfPaodUtnXr8eYNh5wnJQ
3ZgdkbbXNUnJ2bVf8Bn16ZO0EOD0OfIP16pmad7P71v8LmskANjBqqvaDNdYLkdN54NMAyGgybpl
TKOZJBkeAt0VHuQ+G7kVmlHc1aAw3HXlPkldTxwPoFiV15r7qkqeSh7lD3HjrEceu+0YO9If0Ira
GfhzZRdKPhkl486Ij/qQTwkdBvCgWqEl8kb+9/cAL3gtQ/yBCc+CikgafFu5Pkx76cwW7x7ApE0U
jjlz0WT85C0wif64jQN9sZTz/69VVuyNA9hD8tUE3ZeBIalLF16ZlSL5ybh00UuuFI6b5aoy92qA
QiEsT2AEgCA6fnPcFsDIY43pqFTBI/NjyvKjFGBsYUERhsOQH/iARAips8l2nT8kiLlGeweSbNWv
o8kTcdmGVFfZWoa3HVRkW/4MroMMn6wxHTXhomM51YisoFhLrrU66Nr6OvBYjqhqS9eHAgCtp39W
Cortdo6EAgonYXApWh4dSIZ7ENHvNyx0lwNtKWyiE9XToLWxzZRSgm5KgmnClPcJk+VviUcBdI6Y
wKPrEsEdDROUmNNfWhEsHJIJfvyaqpVpIVZZd3ShoU+GB+AdLvGrc2T7M1/837uShBrg31U2N58o
cHz4SOREYO1AqKz0yAYjw0PRpGCzqZasRJ6ELDqQ/Zdo7TmaZ0R2Op/NDuYj/XUm+yD4wo6zJWSa
Qk/w2cU7coS2W+cR1k2LEYDcR5vt5rqnkkAKGgru1M9ibL4CMaSYHFX4dqaj4kuAmzf75JX4X7Or
+Z1Blla3kak5B7wmlr0kZivFPpHDZx1H/QKF5ODJ+PKmLxZhDj90QnY9XDewF1AB7A5b/WbnzSIB
8bKZlP2Alyd6yhP7LAF2QyV2pcxHzHP+7HwV3RvY56ZlYcVqkMiZDmz8jQbT6pwS5RKa/C+SZVBS
Xec9crcYdT73F1Dz1u/nP4wOiqXTybGIWGRff3gbzS43tM1+00LfPos3aGhGpBvRQAxTOykPF1Of
KbHJntq31GePs5uYc82opgJp5UpSpJVBDLef07yvNwYBBoTYqSyo6WzmsC8aNJQKXph48aINV1Op
thz57YJPqhUofm7RQWz6J211NUsU3Mb5iWKTbU6uBrzHgTtv2Gg7/eZDNBeFjy85iwFCpDZch6Mr
yq25QEkygSZ884IKpRpuL3C9+ewjcNkj5mLfDnp1zCEn+BRjMvoHrZfJiZ2LyXoNtffTo88AYheO
NkLdvqHB4Xg8mSHyQ+wpGFutJD68yBuUHI9hp08Rhe4syycq5zdkCZ8yNP0L6Yogk6uMr4mn9u4E
0xj6JOw/II8UMBZ1v4R6eeymEkDe7r2K/nWsXew/OHSBYpeyFrVoLYEtG309bEV/hRDJLsCk4vPh
8LPwpHSt3oAE6KssTlo4wFUjDe6UONxXvNX0sF2IHF3i7Bvsp/5HSVysYpuKMBbTkIdUO6wnqARQ
E4q6X/NJYypw1fybShcpUI8H+JjYrFEjyhM4YE6o5Xpy0olM2VXRvc0EzX2F0hZ/YYO+6Bu7Kzkg
JfdA5Gga2p73FL9guMBQJTTQzroDLejotg9GfktaNrseMbMYgwMoNrpsbOu0RHAy8VxezaG3gmso
RfQeqOB++b2Sa3hBMnXFRxG0pYtGVdtLRfBesabY3RYYckSZWjbcFyKr2I3k+OgPlTRiNIgTF2uh
eVZUMfRGge4kutsF3+X28pmxGoUvgZr6G3iDWv/r2VnuNpXFbc9E16r7pZ72c3Zb8Q2ZQpQO6Phu
MdZqTujSGxwG/wA4YuO7M2jxEF/yUk4iJ1kcfeJFTSwnjvtaWcKDEhfDN4CzbLs+6jQ/0JoaKXxx
Xq4TrGHDxM6kiiQxovxTKYAN9v+ROD0DmODaTG7TT5b7mrpVkUQnIyYJId0xw+hpnUUWzsBaPA0b
+DyCxbaABuIMgtRskfEO06hJhTSJJBoZslhceEBTcIrs+csxiD17KNcL38YEzQ31TRL82aQbBvFI
8I/vMAD9XKspiFMBAiVeeLPuMDhXySamlS7nPZP2DaW7aGJmI59FJxqNtcXA1DIAb5e5czSc9Voc
GsALE9C2Jyq3VLzocdiSPVSUxXBYq9LyoGcGlqVO8yF1iAQf1Vk5ULZZB6Qi+RsULtNIXSCTbK7u
a8q/FGanS+76JvP9ts+0l1I6gTMxJiZMzkzvlWZFwpXTNzdA+PS3RKMBNvsuamvioBA1ycgNlk9L
SqRSTRq5il3CQuK2BrNu9MtYBhUDutNV9y60pCnwob23vGsvCRMxi1CbkBR1Vi/fqcGyLAsKBX+/
60Dn5BwetMFPNvSgnDchNz2ISjHSABix5XzGDFoqKbX/B0dXLWk7P7FBITvfvdsh9lhHN7nJUAJv
uU69zM5CHjCruflxSlHi+dPGi7vPPsUTpwUUxLjdSLAYduKOjkKz7mDOiI4+EZtvmkC+k5gE67IT
ckfF/Mg6D3aExBImHUXyVwepr/qtuwFkIGHdSCIG5HR2H+ktwqjTgjWF7FP5zyLGuvSKyWaX7Ndg
sw8LfYiRfO3Zbbs3CuOIjNLbXR0Z46tREYpE65kZA57cZrWF6MvVaR0iHh5wIqifZvPD37G7+ckF
zdccL+JT5Qte3tAhWfZ29hwdAoOOGEaKdvwhKpR4E/oY29p9J8njhQBtvOfdU8EiAwfRB3+wOmn8
zdfLKB2LjQ+I+gAFuH3LHW6wDmTXWH1V0sFWN0DB1oXmPYW84yI0xXKL24ZaJ62IxlPUZZ5/0GUl
zNkiPXHUvKDYOJ+BdtoB+8sr6tKA8ST04MItxzz2mnHtw14qt0pEMhqCXRYf40acHLs4IUHODHyt
NQPyBWJe62xBCYAuFpSn9dT7RtEcGXX1sO2LuENqygXeLwQBRUyfEh6zSYjP6IlCOjplilZByajU
SMzioo6nbHuNV+TBV4l3nmTvwFuYPI3URpmnX6zrNbng3Br6Y/+HYTNiIfGj30208M5gtPFEy1/F
JFjAc++mdbrgpLlZrcMbN7/Gt1tkRMG/H2/CvBJMEWqRBRrpgjCGMymRREqeuGr2aE+3s1YGiZtK
erh9xR974Wxo+gKItbr2ostbg9ATVmJJvOQT7YWV5rBRNJ+mBD5mYQEtRSXExRPBdV/xLfuQZocK
fHF26TTh9kFEQ4V3BaM3Zidon3gePJM/QGdKxamd3LWgem4Q1irTttS3X8GkxXJsZJ3WiNxow998
bS8RiPA3UOK710HvINyXCk/A+QLfZYO662Jrcwd0PecRn1Au9Lfy1tD/6weuO3cJYEU08DPMUFpU
hEHzvYb/TzZvWGF0SNNXA+13gs43Vg2B+fRestupTrNzIcTTglXDwqTd8GnrC0kA3RVhbL9MGnbO
q5pslAo8oY0New5+Ho7AR+eJvjUYO7fQqFC2CK+se4/ezUHgzMS6NEsGAIU9WCqzV9re/nMn1bTv
+QZ9Ypylq5BsbtOn+4PykOGBWxQ1K9rLWHHt9Zay6Le7ISfu2pJ/PHaz92CdJmjfl1qT/Os2KDME
fJiFENiTffaatGCnAYZt4O4fkoTEEVzibwGib3aG8wDPCgkECA5/mJzWEd7IBsHvb3PrtzmbpuC/
dJJYBMmFD7OY4PaMYW9g6WaH1W+rxfeUgnHqidaXDLX/KV3NAqiyo+FAqWyevBkgoV6Cpw+gPiRX
fABp/189oKH+sW4k49P0rKNU6lUGk/mwyvsFlaxq14/uDHqaMijFIkfhbX1d6+wMJxPor7YH2oso
v4ljmZ6EnX+7XcU5vV6BJ45+TDCR51HM+tkWFZw9Zp8TbMGcyltfXyHbXHrqFpOndqfwEJ5EG8qb
n63hzR4LbTO1b5b2/UsnhAPYZ2krEB8wUSbU8BgmIqkZCn0/gXBxWWkVGblmQ6jIcbDR+gDyRQJO
wPKp5z1dSPTX++cSypyoQNc/r42HNnOM4ytq3Q7QzHDbRqtn8tj3pzDTeJHs2qyTnyTo+nJyKRVr
kzNa6g+dAIXazpI5galRTM4gDsws+F62PUjGqPTsuMDjaDRadgAh4mSPe6fhktYwHEGR5LidGnJU
8SutP7RFuqPM/LohFGyKAejZTON2FHMJNVH8UsoGjDzmMkDGiFS5QSuS2yFYb8sy/I7/KbvAXaVn
VKTWDPGED58w4+EOPuHmjkj/JsdxoGHbpHFPpX4OHHGBIG7hJqd+Il2wWBMzCaaCeU3y96TeVbnb
v/lI2ZZkwVmxSqVDUX0FUPElM2m8oWOAHdNZ5frkytXvvfW8reyCWTWrB/CVIU4kFjZxyKfDK+Dg
ICA2Jy9Rd9CfXYV1o/0P+xw9rz1IaT5cN347RwWC37c+jpFfTiAZjdKlIX3tjcEJVm8khpwMc5KI
EJQDsMxCbBBRv32LZIRz+LX03NB/lrH9x6VnFkpWLliUf2ZWpyQi+o4cXwdeiKZXPkxPHd28JiAJ
WEQeEMduF6HeIlqHI+e1yGmwANOr+A30B2C0Gtf6K7kR64pEH706t8gstb2VDlhHMXMM0htl0KSi
s7ixXPjiRreMgE39ry0FuHlAV+8IDex/sAASWhCpxDckN/iqIswV6kLZCeR7JWTWbyvCo5P+xFpF
arwNLBmpNwayVA74DFAF/f35q0xc1ECyYnuesId4X0bVYivSqDVcgkkJn2Bl9tCuPQGRFSJ+DCx7
Z+c/DDxnbX4pjrc2t4yeiyFJ8+37jHZxHBGi02IOo/29J0qRaed8T1L5FFnf/f+aQqom1URXrDRZ
j0xI8Boy/EERJp/AhgQ1b65XLsV1FHrpU0jhPgGuuqGVVlJqioG3MzCn27ODPdFI63UwisoAA+1H
WZnFXS2H6DGr/yZv/1m5fCOlum2n2Ky5smKwKyv35l+KZ/26rJVcUQ0O4ci2Tfw+0oZV3QjJ4NQR
i6HK8Ad74H3hy+jw/BKIp8et0U5xOJg8+fpDjQAckQ7MUF1cFarrK1uOqGSmc/H4WWo5+UW5i7Tu
03N2U+Tboy2lMEWFuf1y1KASz4aHuAkaLKUNUSDh2IZmEYycaPVK+79DDg1YOfbbn2ixBATHjW/V
0YIbwheBzlgyNPw6rSXOU/Dt7V5lre5NqDNjb8Bx4ALmjH3qYfy3lPrGADfKqixrrMXAEC7lR/cQ
a+8BM4NGcxx5SN7JkCyXBzUf39TFK/dNoR6GQ7qoRKwoeX6rTFnGDTC9YavlRH4olBrsZkiI4QFM
aFchQdcxvrgDztNHwWmIooE9xUVia+sIFw3jzqPboXx3Se+XlJwho2pRl/MaRLyh8NO9SVw8Zs/0
Yh8YRJRNIq3hU1GN3EsH1gjtyxHiLK9ztDKGX0CT4F28icDgg27zSvmZkvqs1k+DKL/i64+cnF8r
+BdUD4TXZFp/ishhnlX64eByGgnbXrkZ3X6FY0WoxIZmBtmWIqmctL2FRvMsfGXVRp5GojQKljG6
Vc8Dl6Ucq0USNCrvWOlD/hY5M1DbL0Ptx+Cnwu4Yag24NgD9GnciN3gg9AAB7O0C1dserRIfy7HE
Z/sCAAAAAARZWg==

--FcckSZQnOghRTLgP--

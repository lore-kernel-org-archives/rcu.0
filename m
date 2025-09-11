Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A715E5D4;
	Thu, 11 Sep 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605574; cv=fail; b=EUJwjfwSNz/h5TEs4RCL+LtPjsCKfgMrdo+lGAvU+AJOZXZDxWWtYqeTV4d+5JkZgRkvZSmNYIjdyRHCqNRoF7lkQe5JfpCqqCc7+T8YMWYlFyaiDySY+4Se4ggKlS7wOKVdxsxmFswwnIIe3UFnJzb4yw1Dvqg9zUL7r9SxEYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605574; c=relaxed/simple;
	bh=tDj35eqA3MjdvThztMFLVZFTLevh7wFlauYUesFNCxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfn/OIxk+UciBSjAsPKF0pVwjlKjKBO5ywqqtwrINiSotyFQPjz4zLBg686uFIHHgccJ0JuctcnPsPx6cFSUV4P9HCV/xpY8dmOiCMyvk0fyIOnCfdiYJvdq4CtpJJrri15TEPm3PAELk0YfL+ed0lVxPaGHxM7IgPfrpv9ByO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkQ6RU3r; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkQ6RU3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757605573; x=1789141573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tDj35eqA3MjdvThztMFLVZFTLevh7wFlauYUesFNCxs=;
  b=gkQ6RU3raBqX53Ez2cukc27Dv1Oo4Mdqyi42ghl7cYcDaxcpuxDc328Y
   vxhLjeh0KVXFUhSXPXb3UQl31SHN5eyKh3KNc1E/NyRv1/UPewGyUcbYl
   VzUZnBcZoR0F689YZdyjiOJYySNHthK/mlfu8zF3JB4Jz96UwVe6FYa7X
   TfAuXwADBj8vb7cExRHwe1HEB+3Fygu+Jif0PpLB8Ng4LAG2kV2lteGJt
   OOihi+b6ldHb83R6ZP/4qrfP9f352UrcPpIUPZ2KIbLcgQvSFOyOV12i2
   lv6YqcZFIg143TMLCwT1rWdiMP7D+sajkXFQVp37nbxgjrcKEu5FpqX1I
   g==;
X-CSE-ConnectionGUID: dYi5GXpDTCGgQeCTWcDTfA==
X-CSE-MsgGUID: pqCufoRSSO6SmhnLgDCRLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59640160"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="59640160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 08:46:12 -0700
X-CSE-ConnectionGUID: /CLO/4mNRVWm80yzTSWJ2w==
X-CSE-MsgGUID: JL9trEGqTf+RIl+pf+5Bfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="204488803"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 08:46:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 08:46:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 08:46:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 08:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHZzuLsXffem1dCm/qaRxiheL6MUSoR2DRZRdEri3ch/ws9F5hGQEKZYgFu0Hid+cMBJKIe0EkQ23XhPVR7fJqfaSTzjnpM4A+R8gixeCf9wLAqUJEsFlKwhHcIl9zpLXRLt1xw/v9p5pB1CIbPXGGsB+OWEbabr3YH9u5TtqWFzY0b7CLmpxOp10awdwD0hp3k+HEv7gAbO+6YzFBCgEfoFNrlZdH02i6txBguBaR6OdeDTZTtkI6uvr0PWFVGxBZi7yivfCL1/xRsdlalvrgQqQd0nl9GGmKDgsyhVxjgbQ2K7hJXUIVg4WVhmIsoKvm/nJIy1PfG9NmYRGJVFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbnB6ihGNQKGY9dsb5XqumqHhdAYKfTxXFoEFU4iGdE=;
 b=gLuqFToWu2xAMHTJZC2OW9WnVZO5yuibOvKFQD05xR9E7PNmsLZ4tT0HsMu8p7ROO2UGTppTzUcSP7ko2rbbTHa3VGbpHNnos3jirEXghEq39aZ901TGJ2FWES8SdOJuh5jaPb8gb1DBuZDAaBz+OGnEOaEErHRqgJKlnYMena/EvrRAu9zUdl+LXfHtR7zI7iEyj8g9UKO+hewEJhU3BoX5uqrjBjT5yuiFrk5qw6bO/1Jzxh7uFWOCEX73EnqNlhVQzHdUYFgsfaOPmBqFead0J8CuMixs4TmAU1Kz24U5Ks8i/rHMOe9iB8iS/VP7QHFLE5u5r5ez2RkRPz9Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:46:08 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:46:08 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Thread-Topic: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Thread-Index: AQHcIx6DDeSbU/6v006ewHhYXXfr6bSOH6nw
Date: Thu, 11 Sep 2025 15:46:08 +0000
Message-ID: <LV3PR11MB8768B531BD88260D26996285F509A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
 <d1cee525-84c4-41f8-8594-0643d532e3ff@paulmck-laptop>
In-Reply-To: <d1cee525-84c4-41f8-8594-0643d532e3ff@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SJ2PR11MB7501:EE_
x-ms-office365-filtering-correlation-id: 2f6eeff8-0a20-4437-6f26-08ddf14a533a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?iDztGbnWt7ZjmATKxMd1R+257CXnKMQYSRIQv9ont2aN0NBekTC0dtbJ3XCV?=
 =?us-ascii?Q?Qy8C2IiDcYkAqRILQS8WQZDGq2uXM4aRSzTGnoiznk95uQ3A2yrwQLVml0Pa?=
 =?us-ascii?Q?uW3HuzkynI1Vvye9uDmqT6fdPSDeaheeCfYSt47s14EM3vURJCj6sSpjC3WZ?=
 =?us-ascii?Q?CIUD55405uxXInHuNS44rcPMAatlpcJ3vjfbArEx+hFeU1D9cBiT8aX97fSr?=
 =?us-ascii?Q?6txczpnUwL7qzIUITGEalwT4jBsJLo2KoTsiiT8XcNqryBlg6N14IixiTbAY?=
 =?us-ascii?Q?EWwX5zsAU25zndw4SCCr1lawFCwTNen3qQE7/yLkvHcwA1oENPsdPpsk18Ta?=
 =?us-ascii?Q?agVJwHm7V5lLg4h+/haW3fATghEnMooAgz6jS+JJ9LGqbrepxCKAXgqn2GRD?=
 =?us-ascii?Q?EbToEeIR0d0ijDgIYEmXwd8V67PyyDEl/7hes6aVvoIB+/2Pmn4f3pNi9tEi?=
 =?us-ascii?Q?1GKSeMgg3O446q69QkpDcXaGgrvEKTUexMX9ld6fbnXIK1h1IaLyDldpYlsr?=
 =?us-ascii?Q?YdXXgIGjQIfYQaaePbc0iGArgacXH0+B1kjOPcQzJwulqOqjiHRNPDKfNUL7?=
 =?us-ascii?Q?iAGsY5qQH99eHv25P0NFgPDRaSufvWs1X+feuVlSdYA1v0aLNMuhFvh+2IqY?=
 =?us-ascii?Q?jbswyyp7BrbEU2JAnaDSJCehK53AUE2jsmGanS56DyRiLesMhsK9H4qcOsIT?=
 =?us-ascii?Q?ILuq2bpxfyYewgOKu3tlaRf9i/d88ArI5QfTXTcSzqfmelaej/tV4+dms8lc?=
 =?us-ascii?Q?HxRKcqOaWAeMa+RuX92uBNAIkQmYeFHTxIeAWm3yIDxT43+RSijyQ41ne4KZ?=
 =?us-ascii?Q?P+NkFilu/4zssjqkP8SGsG3GBQZMtkmlfSdHJwk0O2rMwaaRS6A+zHjK8uRK?=
 =?us-ascii?Q?JRCOZpzNFGd14/omxW6S1N66n0/FtFEXczQDto1xK1PH5zWRdFEcSeGqBCml?=
 =?us-ascii?Q?Bc4pfTQMgnbsRfXErjuCeFlPHJkldJLLmeR78yFNXUXp5cgZqBpL8lHpGX1H?=
 =?us-ascii?Q?e8ManfMhZrPPoartbAjUuDiUaG61MM4Z4zrJml7cnTR5ItED7+Z92Mhf5fZZ?=
 =?us-ascii?Q?2t34T7kFuvXHIWmXXI4gJVfCpzMT7RSwX2gSEXGBTGHKDEyyDp6wn33a0vgL?=
 =?us-ascii?Q?GFvnAL0ssqHJmb9Jcu8kYCEIB9uEQct1DCcFf2LbrTdm/qdPr87WXuRuIVr9?=
 =?us-ascii?Q?Qdj5wlT7a4cdYC9azdDrq8X+lrFQqNvuvkstpHmQhh87ytM2l5ZGEXif34Fz?=
 =?us-ascii?Q?pbfYegf9i4cLuyhuoU8wcXHGEgvXcduAH4zNw/lefm5UV5KeSa3jfAZN3FPg?=
 =?us-ascii?Q?6rSkR0o679S8G6hp8ftoHRvH/L2TeC/9zzk2DmMHfDy9y7eMzuPZ8PyMw92S?=
 =?us-ascii?Q?oNu5O28Zgy3lPf3jaMeMcHCy+2RMDsLtSj1v7EFsuJOk+HjUerl3K2MHjAkl?=
 =?us-ascii?Q?yZkPdHs7khE4iCwDiUxhHpFcgKcE+iMCxfZ3UmEiH7lyP6gfxVH4JZ4R6XfX?=
 =?us-ascii?Q?bak0LxwByDXdyoA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xFyXSajz8bnG0NEBA+JdQ20hgjNq+znK5mnM/wtBWjYTW/VPIst89hMMrJO3?=
 =?us-ascii?Q?sHz/xePDUsIyQ4K8W8TlIyJZFl0yKt1AhAev4gKkHdXAHZzFaVxPSPaBkupu?=
 =?us-ascii?Q?05QyGmSPQzFhSUo/8Svd5iEBOo9cQcH9OkuMVZxHXJf5v45Y0l8LTATXdcHT?=
 =?us-ascii?Q?L1KevVWdKDz0uAso11OR7/y/LzanETR9Vdjr4o+nropvzPdMgnrml0uCVoGv?=
 =?us-ascii?Q?TVgeKHFAmeSsMhYFd3OEsrq6HMEZAouVv+ykijwjpHF49BnjDLUbhMcgSAq9?=
 =?us-ascii?Q?QTeBnZ0mUe0aEY6juLbY00t2R1ygZzwDuRzSDI4JAf3fcj7zOZ4hkSNLWI9T?=
 =?us-ascii?Q?Vmkbkf1/PU+LGk3aoUBKgvC59JfELTrVJVLR5P06F5dpXcuEnVcbZw5zEBtO?=
 =?us-ascii?Q?agSUlwVG1djBbaNx3vU0IQssXLVEOAQ/I6TrV8rHB9aw94Ed17GXuBadlZEg?=
 =?us-ascii?Q?zIqrsnxRimqnOePC2ohcrJERCIgdaQFKfMDW6Mce4eR2bBFh9FOYX/wdWIfc?=
 =?us-ascii?Q?4iM7KH0iJLkFtRreHqwHlOPRgWPg0OLq33JE/czpc7L4ykO6bAGyUAhgCspf?=
 =?us-ascii?Q?uvsTDtikNaKAuPonsCj5ucrnJLk5E0PiXNN0hhwkP+iRSZMeTP3FLUVKnFXq?=
 =?us-ascii?Q?WRoVaMp4XpzEeen0aFqkbXIGNEk4mScMn5owNCUZZnM7GM5RGb/lY6j0ML1t?=
 =?us-ascii?Q?0OgNBwSN2InSviEFYP5lSh0qNFlDftxn/05TU9nOptBLUxr2+opceozCekjr?=
 =?us-ascii?Q?NkFTv2vAL+WjaboBlgfaav+Cd3Ters+TZC0cwP9VE31/LHXPuZn03iOdr/Nr?=
 =?us-ascii?Q?Nv2Zf2CtAvpVS3DchWEXTKLodhWZMlxeEYWgo4Rt+IumHOhKvQql5P8UOHGL?=
 =?us-ascii?Q?BYiAloZTlfUF/dl5T+Hhyq9pCt5AHBY5pLPbrotibBccCWWMVlLma7vlvH0I?=
 =?us-ascii?Q?soP24XxzM2uchGCHzKfY80U1u+Iund1qi5eqwaGe0wdPlR2QAMDeJihnjMbL?=
 =?us-ascii?Q?eTl2xk+aKRn57F0lxMYes1BqeWSZE4C7bE87Fa56aSLFFNjBLOMRsF0794xs?=
 =?us-ascii?Q?yh1yzYNFbsCy+p2es99wZ7c6jzpmm1laOw/7JzwoiFZy/CvzX3xnsKw02/xP?=
 =?us-ascii?Q?iwsGXUzzEJMZEhvPDDtS9KffSJic4ZVHeLPnk6Os+42U0SESApDviljYFOoH?=
 =?us-ascii?Q?iL8tWe0iNJJv3wWm+BK1FgR3xeyTCn9QKwoiJW3k28BkKGMVy8svfbXtOTOn?=
 =?us-ascii?Q?GDMONIZXYwNM1NIId3oMu+g+vEEeZ/lUBSEG075qX4pm7xDzrymukg/24eZN?=
 =?us-ascii?Q?ptMMf9yCQmJtSbX5A8lTGI/dc+XxOOzYQF5xAlqidQiY1gxbcTDXfIK061Jg?=
 =?us-ascii?Q?ztqQmVcHflI2i737rbR/E4xuhROWV3blbLbwySd9rRUrDdyWM4zRJLB1w4t+?=
 =?us-ascii?Q?r2WVF9xFnmR8RaNA7tMJpZAe7nua/x85zvTP5/Rxc4a3+NGS8DeMFbkUyRbO?=
 =?us-ascii?Q?OaXJmi+It9gleLmQCGGF45sdY7z5sytKywLJdRxZ6KjLdjTK5P4DY+Phikss?=
 =?us-ascii?Q?iubkpIsbUhrRVaGJJdR5EV5xkC8y4KyzQHayJKxWMHPFbxfRP/mD8S4L6YCH?=
 =?us-ascii?Q?4ZoRcJDymAJJg1JELTaXeoTvescuPUU/3YhMD0L9fSLO3OfcV5OnatZrIZrL?=
 =?us-ascii?Q?ebBTbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6eeff8-0a20-4437-6f26-08ddf14a533a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 15:46:08.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLx622TChH2vUhMI8PuFtZajdRNuH3SgSaReaK1D3q60q+P8wGoT6cRWqEa0ZC/6zk1OklKZJTd0ind6mD4NT/0874sGgnMmumOHs+vFcVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

On Thu, Sep 11, 2025 at 10:40:09AM +0530, Paul E. McKenney wrote:
> On Thu, Sep 11, 2025 at 10:40:09AM +0530, Kaushlendra Kumar wrote:
> > The rclp->len field is accessed concurrently by multiple contexts in=20
> > RCU operations. Using WRITE_ONCE() provides the necessary memory=20
> > ordering guarantees.
>=20
> Could you please be specific here?  What calls to rcu_cblist_dequeue() ar=
e such that hte ->qlen field can be concurrently accessed?
>=20
> (Full disclosure: I don't see any, and KCSAN hasn't found any.  Of course=
, that does not necessarily mean that there is no concurrent access.
> But we need such concurrent access called out explicitly here, because it=
 might well be that the concurrent access is itself the bug.)
>=20
> 							Thanx, Paul

Hi Paul,

Thank you for the clarification. You are absolutely correct. After reviewin=
g the=20
code more carefully, I cannot identify specific concurrent access patterns =
for=20
the rclp->len field during rcu_cblist_dequeue() operations.

The primary motivation for this patch was to maintain consistency with=20
rcu_cblist_enqueue(), which uses WRITE_ONCE() for the rclp->len increment.=
=20

I will modify the message accordingly and send a patch.

Best regards,
Kaushlendra

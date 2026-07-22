Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753884334A5;
	Wed, 22 Jul 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742313; cv=fail; b=c2xc7L+Lm45BB1pPANYrtBhKnEzoE408uQ43QjRbCXOnQsvGcrI0F04G6felAfPoZZIOmgHJt0EKrcvQEZ73jNlQrTkuwIzCPhLLvs66p9KcuMS8nPsqDNk5y2jMpYsSzDuqCTNjcQG3jiCsqgxiiHMudOpJGsgzzInDDEJ7z30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742313; c=relaxed/simple;
	bh=DssxrErPzt6CC4Xg6Xb1/eCBG9HdEACBsSyg0/7xYq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jDTXqV84Nl5sRPECg6KAPibAq0J+5ctWkrJZek49eKyJlZ4l4HH5mtRgAKlfvUuKx/8MaJRj6/ApabMyR9ctrsGP08+2Y3Zk6JgFoPn9KNtabOQcqbp9tKUUJrxelfjJjEVhmTpyrlamXUmOWyJIS2NlyJ8F+UG2TXc+BgeDxIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J9CpkWRI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sBsfzpUa; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9CpkWRI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sBsfzpUa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784742314; x=1816278314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DssxrErPzt6CC4Xg6Xb1/eCBG9HdEACBsSyg0/7xYq4=;
  b=J9CpkWRIm9k0pHer5jEf5tSgGdG9IgCqmnVCni3lTBfSUR5BIZfvbaWo
   jxIN2vUOshzFxqhKpzkKTGqfdRKhGiXOQwReVjFl7Scrr/jHeIJbcg1Mt
   o7yb6NfmY7R6MFADQpVT7jfqPajKCJVwYHPRKtlAYf26o5mgO65e2L3uG
   r3cq97UKKV0kZTxg85N89Uesx8y5/gTwrm4CdD84Nc55Ljo1Mgw1TQ3dO
   ywXNFsTh6NfcE9VaepH2zANIVHmD85sLSiroR73uayg7/6eZWNqb2KaGP
   2ds+hQ0Eg2As+1va9XayvXzUL1Gh8AtOudyN14GKmazT1P2QDx9NyEUGq
   A==;
X-CSE-ConnectionGUID: 1fmzOXn5Sk+5rhvNSlIzyg==
X-CSE-MsgGUID: u/Eb9IyHQUiFEPb1+Xy6MA==
X-IronPort-AV: E=Sophos;i="6.25,178,1779120000"; 
   d="scan'208";a="150619808"
Received: from mail-centralusazon11011050.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2026 01:45:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO12UHLlc5SAZKNmt5Bq/+Nx39HJdeeZIeKk1OskrETWbxRxo5VCxXl/L0Fxb5r5SZpcwPqJf3DJtHUYUWTIMu90QQVyu/kfh3IUmRq+qzpUURWQnO5X4Q7UuxRl4NXor9qUnLVJYBx75/Clf1VUudhYcH6pJ7ah++iIW+WcCGCq10bAbjGl0RBOsURc3UrQJR1oXCdR+wvyabZ9+0Mbf/zPiPYtqlyVNuSvpuRQssFVp4vEjakAKcEiZiGvDbBxSJJFL6yB+vwh+2DaUshga9zxLtWF+nHDti1kkeevJ4I55iaS5VZAKr5rdas1XMHYxYZcXaOk0GnmNR/a58rRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DssxrErPzt6CC4Xg6Xb1/eCBG9HdEACBsSyg0/7xYq4=;
 b=OoKoxADgTPJ44YucG/fhaRE5Kqp8580W3JYyWGgciAgMUXFOXWQf7hLogsqsmmiQdcDIDOFFbUomLtPKeS91sk5iHP9voyFSlKegcCsXQieiZ2Bl+BmsbmMI+If9MZ3voAGZfztTYZTnPbO51354DPobu4dXy9MCuqetctHloq+DaP2GFZ32uVStozbJw2w92dcNTZhnUhx03nFwNXT/fY0YoS3vM2SaBe3+RZtBRFY5PsAFhNfpooWL9BDH6OHiqVv4EA8CWfZyW/+rEVBDmGEowhSlnyOfvSD1mwg88yqgLR/L/Fw4zXf2A+19TqHmq0nvklFTOlqoeoau6OeCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DssxrErPzt6CC4Xg6Xb1/eCBG9HdEACBsSyg0/7xYq4=;
 b=sBsfzpUaaV7x3CI/jfcEqS73++xa2h0TSJIY6T7Ca0qkZKRptlIUtDJ8sjiVX2dhENJt3YDgP7WqKREjhJJ9oBPt263p+tkrOxwhy3WPmQt4ZNcEkDTdewY9NAS0/wQz50oC0rskqgQJ7UOLrnom/6M46TxYOeXILalDrGLRJHY=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:44:58 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:44:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "joelagnelf@nvidia.com" <joelagnelf@nvidia.com>,
	"delcastillodelarosadaniel@gmail.com" <delcastillodelarosadaniel@gmail.com>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "acourbot@nvidia.com"
	<acourbot@nvidia.com>, "ecourtney@nvidia.com" <ecourtney@nvidia.com>,
	"adzicmirko97@gmail.com" <adzicmirko97@gmail.com>, "ojeda@kernel.org"
	<ojeda@kernel.org>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"frederic@kernel.org" <frederic@kernel.org>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "daniel.almeida@collabora.com"
	<daniel.almeida@collabora.com>, "boqun@kernel.org" <boqun@kernel.org>,
	"lossin@kernel.org" <lossin@kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"phasta@kernel.org" <phasta@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"tamird@kernel.org" <tamird@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lyude@redhat.com" <lyude@redhat.com>,
	"lina+kernel@asahilina.net" <lina+kernel@asahilina.net>, "ljs@kernel.org"
	<ljs@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "work@onurozkan.dev" <work@onurozkan.dev>,
	"urezki@gmail.com" <urezki@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"fujita.tomonori@gmail.com" <fujita.tomonori@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
Thread-Topic: [PATCH v6 2/6] rust: error: Add ECANCELED error code
Thread-Index: AQHdGel2DgmUr8xysU+MNcxsLCvMvLZ5z8yA
Date: Wed, 22 Jul 2026 17:44:58 +0000
Message-ID: <1358719cf89f8c8b14e3973d43e9b91a471595ad.camel@wdc.com>
References: <20260722144931.1070312-2-phasta@kernel.org>
	 <20260722144931.1070312-4-phasta@kernel.org>
In-Reply-To: <20260722144931.1070312-4-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MN2PR04MB6479:EE_
x-ms-office365-filtering-correlation-id: 0e954951-e478-40b5-4f0a-08dee818f2e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|7416014|23010399003|1800799024|921020|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 USOoBKKfhBK8PPhNLd8QCzND4mQJUs9/TBMMMszq5pa/E9aBuI8t6XH0jZc5s1UCzbsAAJJy9QK/U0MVEaXzOlbPgYdnL2EP0PPr9f6MAhQol/L3r6/PsxsB9aqv3rjfv3IiFUbDgQwEBLGNA3XkbOiUpKquT9GNWeQLuMuAL4Drm990vlW9Z4e0rUGoKPMEWUyBTA+ZVpW6K8PQFPuw1/sWai7GYY8CfFWjBMw7gzHdJgqXO+Ohm/N5chHtR62I45FFbFoiXNR+FF86WdopbHJPGI8SiyQSFf5/z+NZc7UyhCoy9AjAC4RJ+qdo6TlpFbuqSNeJo73v3TMCLWIA+gJPsMn4PnpOXRe6jE7GxYs8PrxZQMQ6bmC5tEx2qxDNmpw3dNpUwfnagEXQ9nCPF1cLsRMCJkGhfFFAl1wIR8ITKEVgKy2IZLOCYW+nHApHrUkoyYdXT04dJozh5MIcJFaHhyEwBxSfQsE4vH/GxMF+mfB/5f1cgivaSiKQO/LI+ubja5/CMFrM3nE8UBOQH5VGYlF4rbcNRUZ6NQVjWimZUAvl2sLgnm0qKeU/aEWTugyFu02vBoFiIWpJxhruMJbj9+XSx7fSFcGrjksN7FD7rHQIOZfB5veqg0AnC7aHr7S87rFwMJJ1TKgWFCRWeSoSDDBNfXBjlrmQPDb3vusO39S5XEM8pLSjSKmKgx/ytkRHUDWn06epFpIrtNR4+nHoe9RzDabLvTn7pKQZM7vGQwJTV18WbTVpBz8+EL42
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR04MB9561.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWk5bG16aEJ3TnpIWXcxWlMyN2xMdGhZbWVZdjViSFRVZE1mWUsrenJlcGdI?=
 =?utf-8?B?dHpkbWNEMXlQaVFPZXNzWFdDUUZIK2NwL083eHBLaC9FU2R0WnZVU1ZIZjZa?=
 =?utf-8?B?R1ZMTGpjSG55V2NXWG9qdjB5cDl3L0poMElwOHk1OTJldHlBMnZ3eEdkbTY1?=
 =?utf-8?B?dVBmbGJUZkZFT0NwbUc5RmhRc2FCei84Q1lVVTEwRGJuODZmekVuSlErQ3BX?=
 =?utf-8?B?aCtlYVc5aE43ZUNOSENaNWV5Q3Y0TUQ3QlhuSzNZTE52M1NkYWxBYkhkV01j?=
 =?utf-8?B?WjBrY2pmZVh0WE5JSU5vN3ZNWlR3TWxrTlpwNklMNGlOQjREK25veVNHRDd3?=
 =?utf-8?B?YnVOM2RDSkVIRW10blMxVmR2U2xZZ0FGdVl5Q3VraVNQT21nZzcxY1hVYVIw?=
 =?utf-8?B?d05aVDlVRTJYRFNabHVxVlhNaXo4RVNpOWFqdDJQZCtFOEtNU1lYdi8rc2Fn?=
 =?utf-8?B?bElGV0swc0E0WTJhY3FDOEQwbW14RnhzMG9xNDRmVlMrNWUwOVloZ1kveSs4?=
 =?utf-8?B?TW0yUkJhc0wrZGdUdkVtYVRlMHhqbENuT2EzdUVyS0UrbHY2QVgvRlNnM0k1?=
 =?utf-8?B?d0RXd0dIRmpwMElDckFBcld5VnJqaTBFdS95d3JwNGRyN1ZJQ3prYlVJQlZB?=
 =?utf-8?B?czFQMWI2U1Z0MnJOKy80M0ZZODJZSXpXR1lDc0tXN2hhUDYxKzRHVDJrNVJx?=
 =?utf-8?B?ZFBPQzBZMWt5MFYzOHVVT05saUN2OEQyRkJ0RHdaN01xendGMFNhVWgvZFFY?=
 =?utf-8?B?Z0JiVDZac0duZ1doNnJoZmVpS1RneDlocjdtdnpLWkpqVzE5VFFKcW5HMEZN?=
 =?utf-8?B?YngxMERzNkpReHNKK1puRGlvQmlreXh0S0VLM3dpZS9MV3dNanBQWDMxbDFK?=
 =?utf-8?B?L2lqaTU3bytpMEw2bkRKNUVhTFVWTER1eC9RcXBQR1pKU2Y2MjRidjB0RFlM?=
 =?utf-8?B?akF5bklqQmNXc3lWdmx5RFhFTDIwaG5SQnJLUmxENFIvZndablFVWDhWSGhz?=
 =?utf-8?B?U0J6TEpSeHJZSCtCUTduTTZySFpDdWpHZy84Vnowc2djREhibEdidEZJRnJF?=
 =?utf-8?B?cm55d3BNTmd1NHhnUnd1VnVvUEhzejhmWWhjTWRzV0RZclVoQndyOTlMejVF?=
 =?utf-8?B?ekxLU3N5U2dqYUNTbnFoOUFocmc1VGdVM3ZvcnJtMmdPUkVncXB6NkdYSEc5?=
 =?utf-8?B?L1NUbFMySXp6dDdpeVhPK1IzNGZuMXBzYmFieDJvTFlwNHZoSkt4WEhRTUY2?=
 =?utf-8?B?VFBNUGZsKzhZMmdEbTIwdVBYUFU3YUlxRDBNVkNobnlTakNmN2VqczNPYytM?=
 =?utf-8?B?QWQxUlpqNVdWOWdWZnc0T2pBYkZKbmFvMms4Y0VhSmxCdU9vbzdVWk1tSk5k?=
 =?utf-8?B?TG0zMEpoTjVhMlUzTGdIeXFXRzduOU1UQmJJdW1aYVRqcldOcUNqaWxwQnRi?=
 =?utf-8?B?UnlpNFFvNUt5WkpncU9Yc001SmZyNkdLMHhTcHRWd2tRcUNMMWJVWGJENGt6?=
 =?utf-8?B?SEhMcURjQlNyVms2V3hVRGtyMGhwTzFjQkVRUkcvdmRlRnhrdm1lMko0bHlp?=
 =?utf-8?B?ZVhsSnFyeTJEczFQdzNjdGZTVVFwakMwMWNBamlNUDkyTDZ5VWRRV0hUUFJX?=
 =?utf-8?B?V1l5Z3FkSHJFTms0S2drVUROek9WNnAyalRoVFo2aFdUWWtMWTBrU2VYR3ZT?=
 =?utf-8?B?eXh2NnE0WVdYSi9oWWg1dFovMjFEbERCRzArUUtiR3JUR1FNMXVsNHNZTWdw?=
 =?utf-8?B?UzMrK1haVHlWdldyck9zYTgyUjhGaGlnOHBMMTJXaklId2tIL0ErekhYSmhW?=
 =?utf-8?B?Nzd5cjlLRGFaV29McDVDQ1gzVExRSDlXYlovdWM3dGlIa3RrSExWQnEwN2w5?=
 =?utf-8?B?dDJkV0lDSnhrcnBQbFdGOHJlb3NSd242dXZxbmZkOE1ldTY5Qis1NUZIOGpD?=
 =?utf-8?B?N2NnSHVmZ3E2NHd6a2YrRDNYakhPR0hPdDJpWEtWVW1CQ1gwdVRzTThXZ2ho?=
 =?utf-8?B?cjlZb1I3ZVQ4OUplcVMrTWhyYXBlMVIrMnp3b2xwUVA1enpjaDhJampVVVVH?=
 =?utf-8?B?R3lWdk8xTVVaWDltdElmZmFaWjBDd2FvK2d5TUg3T1hZS2VsSmh3RzR2bDNX?=
 =?utf-8?B?MFg5TnhRUndoa3hQd0xEMU5yUnhuUFlXNEdLUjhkazM2ZnE1THZUcFo2MHZX?=
 =?utf-8?B?cVkxUmlIMGRncHU4cldrUWs4SDg0cE96SnF2R2VPdTR6aGs5OVJYK0Q5YTRz?=
 =?utf-8?B?WjB1amltYzdheTYvWTdPWDA3TGZySFBwMjNmeE53UGdyM2dtVXhMRUJCSldp?=
 =?utf-8?B?WEtBbnNSelRTdjFOS2ZJZ0UzZGZJUWQ5dGNPK2NWclg1M2tQWUc3b0ZXQXdI?=
 =?utf-8?Q?1HWlZoQFch6WOY+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B66985EAF0FC64D88D0C3A87C0D078A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iHwpMZouwBnSw0eMuUNK4Q2xdQClqdIY0UazngL9rlOCOfd9424WZaNGqCuS5oANbdIDDd6M8N8jRvVHHNs6idiJWcTCPpQVIW6iL+CQWDrza2Umd+wfEZ95tQzjmqLALnbUnmE+mwDtEYKObI+tFTWExi2byfLEhCnFNtLuP623NiiGt+bz3MNQHakNUNE4WFpee2P4e7CRlznAod7Ts9lCU7pLFpuklR2HcrCuaZR55uiVPkDP4tfFlNYIMHivudAn0+SjN+7iCp6kLNnbA56WnJocGpzvhwmyKupBRyBLvOlpgosSc622qUKJAxgR5oxazy5bC6gsdPl3B/yhDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q08lzbgGhXiKfOcYJ36fO4g8BIttcYWVTXSQ9TWJrOra/ueb+Z/iNeeJsXYxaeE/v8sZTVmwcQTIz2vLNENxidQuooEDWzThkWrvaLi+dTqUtT+WR9tN07ZEI+qWjL2jgUx3iYBrMc8Hjn12U0yLNGIOSfBpN+1mwFntp/TOM7Euauo1otlinVREKxl9KGw6oSb2y+mTfMEP0MhX/gFJ/6P8wFhREEWl68Q9b6Kfscb6sKI/wOcVrPlHmvFwQQmOhfgbxeD8tV82Q+25zX/nTuPMuuWYmUDHCv45OWmxmrsd4XAYJYlN40c2zLy4lZlJDZUD4n4kHdAUXXjuB5PT52ue+S7w8wokzWyY1AhEG1peWt9NEroUpkz4uYcBqRb9JrRl1ITsBa2XrnMyTgYomYwKr1iRU3d0iN5+ezuOnFyHtDltUFYQsvDsP3egPIrMC2QlxUt9Yd+cH9CN55ulG+WRfCjvLq4+juEDPvRZB0+lTI+Ob0zTmHoj03WXC9rDCJUt2v8JXUJHB1R/UnaE8c3PIdGoUBpkdsdWNHW7oid4rn0CbFifEaEQmtujAEFjaRJyLozn4OtuT8KyIsU/kHs775joq90BT6DowUqedO2KVnRqL8qKVC8+k6BtjQiY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e954951-e478-40b5-4f0a-08dee818f2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:44:58.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IjP3bl6gbxmw2CXJww0ArSo0FOMGgWHGa+FKiaUzwZkyGl/hBh1pwcbII5r8Hk6hyGKNbDUddvICKOjKqD16S9xrxX3aZXCUyPhoHPkYEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDE2OjQ5ICswMjAwLCBQaGlsaXBwIFN0YW5uZXIgd3JvdGU6
DQo+IFRoZSBSdXN0IGRtYV9mZW5jZSBhYnN0cmFjdGlvbnMgbmVlZCB0aGUgRUNBTkNFTEVEIGVy
cm9yIGNvZGUuDQo+IA0KPiBBZGQgRUNBTkNFTEVEIGVycm9yIGNvZGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwIFN0YW5uZXIgPHBoYXN0YUBrZXJuZWwub3JnPg0KPiBUZXN0ZWQtYnk6
IERhbmllbCBBbG1laWRhIDxkYW5pZWwuYWxtZWlkYUBjb2xsYWJvcmEuY29tPg0KDQpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlz
dGFpcg0KDQo+IC0tLQ0KPiDCoHJ1c3Qva2VybmVsL2Vycm9yLnJzIHwgMSArDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcnVzdC9rZXJuZWwv
ZXJyb3IucnMgYi9ydXN0L2tlcm5lbC9lcnJvci5ycw0KPiBpbmRleCBhNTZiYTYzMDk1OTQuLmNi
NjY2ZjBkNDJlZSAxMDA2NDQNCj4gLS0tIGEvcnVzdC9rZXJuZWwvZXJyb3IucnMNCj4gKysrIGIv
cnVzdC9rZXJuZWwvZXJyb3IucnMNCj4gQEAgLTY3LDYgKzY3LDcgQEAgbWFjcm9fcnVsZXMhIGRl
Y2xhcmVfZXJyIHsNCj4gwqDCoMKgwqAgZGVjbGFyZV9lcnIhKEVPVkVSRkxPVywgIlZhbHVlIHRv
byBsYXJnZSBmb3IgZGVmaW5lZCBkYXRhDQo+IHR5cGUuIik7DQo+IMKgwqDCoMKgIGRlY2xhcmVf
ZXJyIShFTVNHU0laRSwgIk1lc3NhZ2UgdG9vIGxvbmcuIik7DQo+IMKgwqDCoMKgIGRlY2xhcmVf
ZXJyIShFVElNRURPVVQsICJDb25uZWN0aW9uIHRpbWVkIG91dC4iKTsNCj4gK8KgwqDCoCBkZWNs
YXJlX2VyciEoRUNBTkNFTEVELCAiUmVxdWVzdCBoYXMgYmVlbiBjYW5jZWxlZC4iKTsNCj4gwqDC
oMKgwqAgZGVjbGFyZV9lcnIhKEVSRVNUQVJUU1lTLCAiUmVzdGFydCB0aGUgc3lzdGVtIGNhbGwu
Iik7DQo+IMKgwqDCoMKgIGRlY2xhcmVfZXJyIShFUkVTVEFSVE5PSU5UUiwgIlN5c3RlbSBjYWxs
IHdhcyBpbnRlcnJ1cHRlZCBieSBhDQo+IHNpZ25hbCBhbmQgd2lsbCBiZSByZXN0YXJ0ZWQuIik7
DQo+IMKgwqDCoMKgIGRlY2xhcmVfZXJyIShFUkVTVEFSVE5PSEFORCwgIlJlc3RhcnQgaWYgbm8g
aGFuZGxlci4iKTsNCg==

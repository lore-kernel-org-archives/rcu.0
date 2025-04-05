Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C270838;
	Sat,  5 Apr 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743875800; cv=fail; b=mFxI29XGKLJn70Gv+1g+kKwW8F5R5fb9SaY2xTuNGORO+sT4tAvX9cLTLFiL+UISQiOtnEEQkFaWkyv9p0WUfx1Cil+evTGLORTWqPobZTULDQf/8392Zzt9qERX0GsMzJOIhD+he5IjjsW84vi9c6nf1XiOwJi8MT/VmbhVjR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743875800; c=relaxed/simple;
	bh=ATsL2yjLK0UZuOPQ/hraCn6evtAVCFhbRMBrGJ2Y1Lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sgxKtJhHDO3uTFOQB2XwfTWEFw4hTvfgMQjnRbxCg5oE68cWqg9gl+nhRbx2XdTKC3wN7S6dXlRqcP10wtoYrPDweutjYBjcPGS40Cp0wMlZsKORncHbchrQXF52EpOa8Wyu5zbQobrWvNcNZ1o66Y0QaCiBm2N42XbFq/EU4GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GLBDXfn7; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GLBDXfn7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osaCkEyUV0yuU5hiTRBEj7qgbzqBbXK6oBmD0Uqms1fqTgK/2Gtd+KCpE3YARlW4OtyLSLYrES/o656B8LyTa4+ygZRufjG+1kTjJ2faTAiyoo+s4QtP7eKfYcG+b/ap1AGIt/RbXzBL7e1gBmZJsO7YZsnJuAYA4BBG3otFCSilCZqrLgo9GjI9sXo5lCDH61IDYRE6gf5iuHmxVCJwh0MV0GYAyqLkd7DVTM/fVHU096B+pYEZp3OHndjqq0ppyPGI1cQqXb1KneGuLkGuz73R4exmics8FSUzLKSbxaDsgDfWZP0SsACgEmlhX0gDBOFSMpjxTIcYUQnB648FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATsL2yjLK0UZuOPQ/hraCn6evtAVCFhbRMBrGJ2Y1Lw=;
 b=W+XI74zHc63Yqsn5MAKsQRAJXwG9uH8Si17GtQrgmTtTpBoD4kEcrWtf2ZQS99UOsUil+SIvjXuHhOsjFRnb76m9CMFw8scmmjD3OJf9U7bo9fJDPiD/eNTUPWZSjHXcwOPsOCP0ioUouRIW5/PCCncGjk8mwxFHCLidXgBAEb4DMtFBVTRD3KLrH0b86+SGnlWD3fkYY99zdpj+rJjvsarIhas7aYnRTucCYwcg9d1XW46/+o7/siZhNzYsV5N32cFwX4lOYUFQRVtt8t9LjPI2pp2mIAI50+SoI5FULLqX4RT34Bthyb1f8c2gdjYplBJTxoHfjUniv/crqX7Mww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATsL2yjLK0UZuOPQ/hraCn6evtAVCFhbRMBrGJ2Y1Lw=;
 b=GLBDXfn7yRNTjTBCtxPKXsXcXMLp9Xz/by77EGapgiTi3moMxX1x4u19MKL842qvn80NAla/Tpk24BUkgk6f9bDgC6LL9+06TbCqzkn+ERcO21hILZwx+zEc9VnFesvcOK5vBxCuDzeQVq93RBHOvL2Ym3ojMRiobPrZ1frdYOVYFeDHKdGcGZ/z3IXA6I7tUJOvjTOARcqlo/z8D/nyFTL/Bvx400EQCztaBIdjHOL3+F8MaQyjobDycDwd1AsrfV0gdwHKZPfwj371fXnAikvburL6c37FtZ3vsNCEHXRc+oYBj7XhwYhixEEj6+qk9OOoMFe+KylMH0mE4rku8g==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.44; Sat, 5 Apr
 2025 17:56:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Sat, 5 Apr 2025
 17:56:35 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu
	<rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Thread-Topic: [v2,04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Thread-Index: AQHbo+r5Ab6wNBzOp0SQ05obQZv0mLOQv/AAgAQsUYCAAGcoAIAADOUQ
Date: Sat, 5 Apr 2025 17:56:35 +0000
Message-ID: <82466C54-67A8-4D78-B56F-47496407DD95@nvidia.com>
References: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>
 <72693320-1863-4e47-941f-0e887f87a855@paulmck-laptop>
 <0dc1bec4-ed35-4852-a15b-781041d26df9@nvidia.com>
 <7cf5ad76-7624-4714-a6d1-3e1dbb9ab7b3@paulmck-laptop>
In-Reply-To: <7cf5ad76-7624-4714-a6d1-3e1dbb9ab7b3@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|LV2PR12MB5989:EE_
x-ms-office365-filtering-correlation-id: 315836fd-ac79-4f53-f177-08dd746b34e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkNkTllNZkpSUXV0aHpNYWFjWnNnN2REQUJtNkUyZDVTeldKRE1EdG0wK2FD?=
 =?utf-8?B?b1RtUlAxakdzSDJvaU5uZWFPUyt4ckdTYXp3RVZXUGFSeVNIcVZJTlY0bXd1?=
 =?utf-8?B?Yk4zekVQUFk0U00xNzY0djh1aW5HbkRmTFF0TG4wR0gyQ00vVDVNeUFvb2J1?=
 =?utf-8?B?NlRlV3o2SGdnSFluN1IzWHRFTVZKVTkwK1B4RFpUMGtRYnJlOVkwTnliNFUz?=
 =?utf-8?B?aDNsMkt2N25kNExoRUFrZ1dBcEU0T1IrcmZ3cVppMnoyMDdWMUdJUS9Fdkl5?=
 =?utf-8?B?SzM4bWYraEFFS1lHWnVveG9jYXBqb0V0Z0dFSWczU1VPcksxN2R2ME9vYTBG?=
 =?utf-8?B?Wk80RWFmUFFtaGdsN0RYbUsxM3VoM1FHV2JnYnYwanluZStPRHhETWNXV3h3?=
 =?utf-8?B?c3VYT0ZEbGNqQnlTN0Znc280S0RxWkNSWERPNS9xUzFTektsUUFkWFNZTS9K?=
 =?utf-8?B?eWR0aFJjOVRudyttYzlJM1FvaWhGclBrZFFEM014NmNQa09UZWZ5WmlUcTdw?=
 =?utf-8?B?ZDlmN0NwZlIrSnc1MDdZcFRxenFES3NKZWFMQndjZUpqQjZHaVhUQzhQbFNB?=
 =?utf-8?B?MjgzbWxLbUdsdWJYRG91ZTl2blN0SDRyZktuNEgwN3BvbWJva1BrNlB4WDdu?=
 =?utf-8?B?NmFXS1dRVS90U255aUZWUGU1c3R4cUdJVVdBNzMvU0owb01EMHhUV3liUG9H?=
 =?utf-8?B?M1Jldk15K0lSeFRvUGtZQ1hicEpZZlhUbjJ0WUhWT0U3L09oMGpRRHl4NXB0?=
 =?utf-8?B?dENnNWVZa3ZudVZJYk4wemM3VHRwL1l6K24rMG0xYjFyRk16dExqSWlZZHFu?=
 =?utf-8?B?SWQyRjFQNXB5NFlKSS8xRHhFN0dzemUydHErVnVqZUlXalJ5UGc2emJFVWUx?=
 =?utf-8?B?TlBYOFg3UzgrcVMyZUhqbWFabDU5YmxKanZaZmc0cStqOGwxN29yQWJ5dzNu?=
 =?utf-8?B?U0xEMmpGd2pmUXdwUTIvYmFLSEdvcStZa3d4WndtSmxZcjdIeHhPaEtJWGFG?=
 =?utf-8?B?ZlVZc3dZYXdXU3B3aHhWYXBDODFFeTRMUnRtcnhBU1N4Tm1ZSmRNZ1JidExE?=
 =?utf-8?B?NkxIQStPQkIvUWI4OGpUZ200NUoyckJlOVZSVE5HK09lOWdLVDNOcmJXRGtj?=
 =?utf-8?B?cmVoZFdWelNkSjdiY0l2WGhQcEswR3daTWJSbG51OEoveTBnUnhhOGlUaUI5?=
 =?utf-8?B?akdkNStDNFArdGdoc3A3aTdkRmlqU1dIK25zSThlTGErMGRpV2hzWWlnNmty?=
 =?utf-8?B?dTV5clZFK0owaWdRR2xvWHRsTGlYd242amgxcmNsU3pIK2dmRkxPZkdBeTl4?=
 =?utf-8?B?c2lHY05tdDRPMTNwdW50S1dDZkRsUjBCTjhmQ3ZnQ1BQMklRcXVDdDJjY2pE?=
 =?utf-8?B?a25zZXoxR0Q3UkhFVDhKSGZmbHRLbTZMWG93aUZsaCtSWWFRTWo0SUpXZTZq?=
 =?utf-8?B?NmVLanlYcnByd2ZDeTFLTDcxM2hKOFBaZnp2UG94VHpwcEw0dkpQbDZQalpC?=
 =?utf-8?B?K3pkeWwyZ2txaFZQeDhGNGZBcGphcm5XNU9TcmhtSDZKU3RLOHFOSE1rVUk0?=
 =?utf-8?B?cTUxR1dRWXVQK2YwZGNLWnNlZzJZT0owRnA0SzlIZVdBSVRJNXF5S29xcklo?=
 =?utf-8?B?Tm1oR3JSUnI1TzU3ZnJHZWVWYVYxdER3RUF4a3d6dGFHV2tZSDVOM3RJaU8r?=
 =?utf-8?B?S2x0MDdBT09sMlQ4bWtNVnI3NExJMXN5TDR2RGpjVS9GcFJyb2UrbnNwYkhE?=
 =?utf-8?B?Y2FKTjliNEk0c2FZNStKaDluWTl6TGtMNVN4c1QrNXlCSlJTL2l3aURiUHcz?=
 =?utf-8?B?NFNyazdrVHR4R092WGc4R3pBKzhHSHorSlhzaTAwT1h3cUVnL25ydmthakNk?=
 =?utf-8?B?NWV5QmdjWkdMUG5FNWdjWXlra2QrYVh5STdUNUhjMzg0RkVjUVA3ZkpFQTVv?=
 =?utf-8?Q?nAC5RX3HGKpgl7CtMQcToDdfh0swjWn7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG1Qam1zMVlZMUE5dnZFb1B6RURsQ3JQc3ZNYWdVa1gveTVEZTFBQTNVWUtU?=
 =?utf-8?B?SWo4N0IrRUhxTDlYdFFSNkU5S3FiWHV3dmhFRFpVRVpMZHU5eWpKc0ZhWTEr?=
 =?utf-8?B?TzVUTTRTa0ZqSnd6WU9BbS9KTmpHTStNMkRpT2JsK2NWRWVHajBKVldncXpZ?=
 =?utf-8?B?Q2xNTEh3dDF1dERtZlFpUTF6TXkwbDlJeGQ1aEpoKzQxVU5uTG92UDZ6bHBl?=
 =?utf-8?B?eDVvelNNTWRMYW5HSmdPL09VS2NDMEdIVmFjMUN0R0pNbUdRbndGSlFBVTF0?=
 =?utf-8?B?SnFHcTZQNWxQVTlNYmcrK01xaVN3WndOaTRkbHdiUFk1US90Mld5WmFVcHMy?=
 =?utf-8?B?emRwL1lpdWp4ZnlqczU0bERraU5ybHhvNzlORi9paWRCQm9PUmJUV2Z2d25r?=
 =?utf-8?B?dlNTakp1Z1dRMk1WM3RTc2FJVlFNazNyblJybytlMTJIQ0UwVHQzRm1vczRz?=
 =?utf-8?B?dU9TYnRJelVzdHhJekdLQVVvSXRPUEZXUk9lTE5rdGVpY2tXclpBZkJsTFhS?=
 =?utf-8?B?YWVRREZkRXdENzRZVWFLRkFGSHBkVktSSk5mMzdGK2Q1c2ZoMUNONmZLcHpl?=
 =?utf-8?B?UkpOWlY5b0toMHRnN2p6ZU9JUnJBU0p1S21jOVVpZEhyNk1DWnNCOFhRKzNL?=
 =?utf-8?B?YVRTKzRvVGJhV1dMM1V2aFdOMTA5SEt1aDZORFdMcWYxK3pOSHkxTlprbE1N?=
 =?utf-8?B?MlA3M251bEhoNStWUGFKeWRLYU1rMzFSUFllck9vLzBRVVZQRkFqUXRDd3Fq?=
 =?utf-8?B?dlNGUDExQkI4NWg4US9WcVBIMHJUN1FuMnpXOE5kaGVGN3Y1bmxYRmV2ME1M?=
 =?utf-8?B?U04veHNubDVyYnYra2lEN3c3WlpUZkQ5U2ZpOTdqejYrTjJ4Zmk2UU02UEI0?=
 =?utf-8?B?QjFjL1dzVkpzUzE1VUozcWNHT25qWmlvRFJPUUNOclhrTmJOT1hjVVVjSzdK?=
 =?utf-8?B?RHVyNzFZaHBUcjRDV1doWGEweHYxYkMyQTEvZ3VZNVNjVGVaRUZtdS9HQ2NL?=
 =?utf-8?B?bDdBMnNsUldUUlEyMHlkZGwyOVFCc1lVVzJFeDBDSkp1dnhOc0c4WVRUNHAr?=
 =?utf-8?B?ampnQUR6MEt3ZitGZzErLzh5cUhmeW5xM2kwS25YdE1ySkI0SEdxek9SVVdB?=
 =?utf-8?B?QUZrRU1yZ1pycXFEZjVzWVBCanA1dVdhK1dtc0UrMTZSS0ZaODZucUF5dGk3?=
 =?utf-8?B?Z1ZjVEQ4WitkblU2WVl2NWwvVms4enl4aWJuYUsrQWhaVjVYWG1DY1JPbVhu?=
 =?utf-8?B?R2YzVFFJN3luV1ZjdVp3YWoybVVUUU1lOUtrVTFoQ3Vwdmdhd3ZvcnNRaThS?=
 =?utf-8?B?dlc5cTdQYm8rSmp0ZUJyWEZaR0hmT2RUcUpsMWpDLzlrQmJpSHVoaXpnNGo5?=
 =?utf-8?B?MytGdytVeG9CUHdLaXdZSHRtVEE1SEp4dXNmd2ZTQ1c1ZldkNWlMRWdmZ1Fx?=
 =?utf-8?B?bTFxYmVSTkRmcEtGRllFRkxBd1h2MWlKVUl4ZlNPRkhQT0w3TzYwS3J5Q3ZS?=
 =?utf-8?B?dzZ5VWxiMFh0UlJsekpiSFVNYWJZSG5LN09SMkxBQTZ6V1VqcmdwMHM3NHQv?=
 =?utf-8?B?ZjlPSW5ndlFDcW1sRy9mS1pZMnEyZUk4NG1zWHY3d3cxUEgzKzBOMGJOU0F6?=
 =?utf-8?B?QzhVa0IzUEk1aitpeTZCdU5qL0lreWtEQTZLbGdOazFUQ3ZOdHpnTFVqbGpE?=
 =?utf-8?B?M0Y4RmV0emFDUjFVYXI1c1I4VU9yOUVBT2prQ2F1RHJwWlZiOXI1OFVITXVE?=
 =?utf-8?B?WTVuM1owbktSR05ZaFFUYXZ5UkJYeUF2MmxjdXhITkMyV0ZEbDFidVRBM2Vq?=
 =?utf-8?B?MkNnLzVJL0Y0bDJiUHM3RUEwSjR4UXk4U2JpQ2YzSi9xMFpPbWR0cUdqZGxE?=
 =?utf-8?B?QUZ5anBWWFZJU2E3c2xSNlIycjZTY3d1Um5QYTBDaHpXS0RCbTRJQnUwS1F2?=
 =?utf-8?B?SmFpekhoY0d1Y1dqTDRHbE5EcFc2aUZ0OU5IR3hHb05kTzlMcFZnQlBaMUFl?=
 =?utf-8?B?clZybmZNMTVxd1lrc1Vwc0xCWFZ3UDQvNklzQ3ovRm1oWW5rYmk4ZGVCTnlL?=
 =?utf-8?B?WU1pb1h0Ry94RTFhRUdiN1FqSjM4TlZuWjBzS0YreU4yRGVySmlyWDNESUdY?=
 =?utf-8?Q?B8AYEqWV+WpPowbH5GktAt/P3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315836fd-ac79-4f53-f177-08dd746b34e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2025 17:56:35.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF30GhXc0Q5uuaDsuG4+6dGzYTsjGa+nfNnqIe6IJTnJSoQF+XWBCh7/2EKau7GEQr/O40Q9TxqjK2HG0gy3wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

DQoNCj4gT24gQXByIDUsIDIwMjUsIGF0IDE6MTDigK9QTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1
bG1ja0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFNhdCwgQXByIDA1LCAyMDI1IGF0
IDA3OjAxOjEzQU0gLTA0MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBP
biA0LzIvMjAyNSAzOjE3IFBNLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPj4+IE9uIFdlZCwg
QXByIDAyLCAyMDI1IGF0IDEyOjE5OjEzUE0gLTA0MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0K
Pj4+PiBIZWxsbywNCj4+Pj4gDQo+Pj4+IE9uIFdlZCwgMiBBcHIgMjAyNSAxNjoxNzowNiBHTVQs
IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+Pj4+PiBPbiAyMDI1LTAzLTMxIDE0
OjAzOjA2IFstMDcwMF0sIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+Pj4+Pj4gVGhlIHRvcnR1
cmUuc2ggLS1kby1ydCBjb21tYW5kLWxpbmUgcGFyYW1ldGVyIGlzIGludGVuZGVkIHRvIG1pbWlj
IC1ydA0KPj4+Pj4+IGtlcm5lbHMuICBOb3cgdGhhdCBDT05GSUdfUFJFRU1QVF9SVCBpcyB1cHN0
cmVhbSwgdGhpcyBjb21taXQgbWFrZXMgdGhpcw0KPj4+Pj4+IG1pbWlja2luZyBtb3JlIHByZWNp
c2UuDQo+Pj4+Pj4gDQo+Pj4+Pj4gTm90ZSB0aGF0IHRlc3Rpbmcgb2YgUkNVIHByaW9yaXR5IGJv
b3N0aW5nIGlzIGRpc2FibGVkIGluIGZhdm9yDQo+Pj4+Pj4gb2YgZm9yd2FyZC1wcm9ncmVzcyB0
ZXN0aW5nIG9mIFJDVSBjYWxsYmFja3MuICBJZiBpdCB0dXJucyBvdXQgdG8gYmUNCj4+Pj4+PiBw
b3NzaWJsZSB0byBtYWtlIGtlcm5lbHMgYnVpbHQgd2l0aCBDT05GSUdfUFJFRU1QVF9SVD15IHRv
IHRvbGVyYXRlDQo+Pj4+Pj4gdGVzdGluZyBvZiBib3RoLCBib3RoIHdpbGwgYmUgZW5hYmxlZC4N
Cj4+Pj4+IA0KPj4+Pj4gTm90IHN1cmUgd2hhdCB5b3UgcG9pbnQgYXQgaGVyZTogWW91IGNhbiBi
dWlsZCBhIFBSRUVNUFRfUlQga2VybmVsIGFuZA0KPj4+Pj4gUkNVIGJvb3N0aW5nIGlzIGVuYWJs
ZWQgYnkgZGVmYXVsdC4gWW91IGNvdWxkIGRpc2FibGUgaXQgaWYgbmVlZGVkLg0KPj4+PiANCj4+
Pj4gWWVhaCwgUkNVX0JPT1NUIGhhcyBkZWZhdWx0IHkgaWYgUFJFRU1QVF9SVC4NCj4+Pj4gDQo+
Pj4+IFBhdWwsIHNob3VsZCB3ZSBiZSBkaXNhYmxpbmcgaXQgaW4gdGhlIC0tZG8tcnQgc2NyaXB0
Pw0KPj4+IA0KPj4+IFlvdSBzaG91bGQgaGF2ZSBhICJyY3V0b3J0dXJlLnRlc3RfYm9vc3Q9MCIg
ZnJvbSBmMmFjNTU5NjhkZjINCj4+PiAoInJjdXRvcnR1cmU6IE1ha2UgdG9ydHVyZS5zaCAtLWRv
LXJ0IHVzZSBDT05GSUdfUFJFRU1QVF9SVCIpLg0KPj4+IA0KPj4+IFBsdXMgSSBqdXN0IG5vdyBt
YWRlIGFkZGl0aW9uYWwgYWRqdXN0bWVudHMgYmFzZWQgb24gU2ViYXN0aWFuIFNpZXdpb3Incw0K
Pj4+IGZlZWRiYWNrLiAgSGUgaXMgbGlrZWx5IHRvIGhhdmUgYWRkaXRpb25hbCBmZWVkYmFjaywg
c28gdGhpcyBpcyBjdXJyZW50bHkNCj4+PiBhICJzcXVhc2ghIiBjb21taXQgaW4gbXkgdHJlZS4N
Cj4+IE9rLCB0aGFua3MuIElmIHlvdSBjb3VsZCByZXBvc3Qgd2hlbmV2ZXIgaXQgaXMgcmVhZHkg
dG8gdGhlIGxpc3QsIEknbGwgcHVsbCBpdC4NCj4gDQo+IElmIHRoZXJlIGFyZSBubyBjb21wbGFp
bnRzIGJ5IE1vbmRheSwgUGFjaWZpYyBUaW1lLCBJIHdpbGwgcmVzZW5kIGl0Lg0KPiANCj4+IEFs
c28gSSdtIGd1ZXNzaW5nIHRoYXQgY2hlY2twYXRjaCBvbmUgZG9lcyBub3QgbmVlZCBhbnkgY2hh
bmdlcywgYnV0IHdlJ3ZlIHRvDQo+PiBhZGQgYSByZW1pbmRlciB0byByZXZlcnQgaXQgaW4gdGhl
IGZ1dHVyZS4NCj4gDQo+IEkgaGF2ZSBhZGRlZCBhIHJlbWluZGVyIGluIG15IHVzdWFsIHRvZG8u
dHh0IGZpbGUuICBJIGhhdmUgbm8gb2JqZWN0aW9uDQo+IHRvIGl0IGJlaW5nIGFkZGVkIHRvIGEg
bW9yZSB2aXNpYmxlIGxvY2F0aW9uLiAgT24gcG9zc2libGUgcGxhY2Ugd291bGQNCj4gYmUgdGhl
IFJDVSBEZXNpZ24gRG9jdW1lbnRzIGdkb2MsIGJ1dCBJIHdpbGwgbGV0IHlvdSBndXlzIGNob29z
ZS4NCg0KTWFrZXMgc2Vuc2UsIEkgdGhpbmsgd2Ugc2hvdWxkIGFkZCB0aGlzIGFuZCBvdGhlciB0
b2RvIGl0ZW1zIHNvbWV3aGVyZSAtIHRoZSBsb2NhdGlvbiB5b3Ugc3VnZ2VzdCBzb3VuZHMgcmVh
c29uYWJsZSB0byBtZSwgSSd2ZSBub3RlZCBpdC4gSSBhbSBhbHNvIHdvbmRlcmluZyBCb3F1biAt
IGFyZSB5b3Ugd29ya2luZyBvbiB0aGF0IFBSIGhhbmRib29rIGRvYyBwYXRjaD8gSWYgc28sIHBs
ZWFzZSBzZW5kIGZvciByZXZpZXcgYW5kIGluY2x1c2lvbiBpbiA2LjE2IDopDQoNClRoYW5rcywN
Cg0KIC0gSm9lbCANCg0KDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwg
UGF1bA0K

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794421347;
	b=4ItJGTiunq7frSUp9azMbLohZGe6yFFatAb174+YlToIupW8O1ii0wAHn5Uche9R59ET
	 etj9uOhGs/iVHkpMqKuftyFIWeJzmaBZk94FdjJByENZSgwUMfpUr+vcWWNZTcUpkmCIG
	 aC08Uey9l4C9o/UfNT8+pMMovddOA8/sd715yUyFJW5B1rxUOrSxsO7LlJbL7u0QsAVRO
	 hvRZ0f/CSKNkN8rqR/6rYpI2JJJJP/Jpe0InWB0KJCvtUwgZugFhoZJltr+sJd4ExR9LL
	 8Tn7PlfnV3amQC/0eKUDYDJ8LcbFNYwrD+1p0Qdf2OvoZrYZffMu8z4ODNP3TQGzi5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421347;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4vcy+xc7SOxzvsJvwnGKiYkMhkqX7BTyQRq3TDMbgZ4=;
	b=QUV2v71mh18moq9naH9GnmYNYqKEkxYFWIboAmudBGfLG90NmTPiKuUw7+eQ2Ie2G1oP
	 O3GtyWz8JGHqVcMk6GHLxE94vT1P2FJWXakyobHxrfJuLfLmZRBQtVPPw/fCHrsHbXPqV
	 EFQCmnIlFjFmwXbOzsbU2aSU15EXbElBraWuikE2CZTeUFRSmt7bWrWLgcoLrjHuCMQee
	 6x5HB6JEW3IFJksLrCSMubNgf0okXYM2I4ft8SBQ8p35ZA9K1OOoySo9pYbHZmAtJh1M6
	 saqEJ0CwkhRa5gtpEHxkOsfh/XTE0MF27wEjAvq2LGK/v6nEYmshXmy/z9DprLufjiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iqTcN4dN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.44
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C49606A326;
	Wed, 11 Nov 2026 18:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C49606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iqTcN4dN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA5JTJ3H04RpWRc9VLgmv/NLhG2AxAVeWP7C0hEuy7A6RJs4wpxjvh12HIbSw7HG+cR0R5Qz4s4qZJ57CZ7vPtnpqpeFGuG/NiobRRIWTvizJrI0UrWY23MpfoyDw23T5hbJZdzTLPfRF9HrrFO7KnngkkQZ3NdxCw3kWEbBXvxbqHYgFQZsvZ9CAf+/ZFpbdylUQoeMmm5ykaFTkUuTQW3r6O/8xGIdNm+vvCd3lzc47fZlGWvCSgKXN2hlCTmi1ZvhdCDJUdNzV/SL7wuIrjQ7x+AR5Q4bvvYI5OzRXY2eoNa1HTcwNssuoOxpXeozSw6DWHZBD8n/w08p/7yxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vcy+xc7SOxzvsJvwnGKiYkMhkqX7BTyQRq3TDMbgZ4=;
 b=ZrVR+WLx7amK4JHAgDUKN3HhXGUgrrsn/IwO0AF+Oj3haGwi09YETyaMlBNYPAJvwjYBhJBiAL0lVotGDSdLlzetiyltOR4/CouhraueLLTs72NxWqq7Q1ItNz9PG1ak4M+oMhbwF9go+CCcgtXPNLdoFJM1QmQp84KlRgUx0XXOp6I9ErwWL4zLJyEsyL2Rhm4YrfeetmFj4aMEsp1DSxWoRTNejc48+2AH5/0LnjWcI0A0nT7pTZHBLkYpM6rNLNZZTJaEG2VxWPao1KfbabAGtTyisn8TUHgfipp8sr+zBEAaSJBrB3p0Yh0lSdBZD7MvguFUVWZifAuppK0FMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vcy+xc7SOxzvsJvwnGKiYkMhkqX7BTyQRq3TDMbgZ4=;
 b=iqTcN4dNJWpOH1PHEiueAUvgWGJyw2i7KSlKqGP7Zl7N6PqB5B9KwZ1wrBRa9xw165rSqf8oGQeaL/zcnHNyhDFftrCXA03Codn2TyhE/vAifpyUFl/CtYylXi1R2uFn/njF85CFIoTY3HfML6WP6z7HsCYKnxS4rvuhVwqX/S2D6wJWRJX41c5SoQ7DQF/5Z8+ZwEFcuCUnw7dyaOwzEB4Gv9q+oBcgnmAaF2KlpQQ7PPZht1Yb8kaCDKnSWg4K2K1WfMctgEx6goJc0Hb0VO/2YhRuyiLj8C7tXzt2DfsQrxQ/yX7fyD7z+GRyD/p4+gA5bUiBbbHJfIsIBcACuQ==
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 18:22:21 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 18:22:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Song Liu <song@kernel.org>
CC: "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"leitao@debian.org" <leitao@debian.org>, "david.dai@linux.dev"
	<david.dai@linux.dev>
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Thread-Topic: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Thread-Index: AQHdcapIlIFqGreevkyHenfWyPZhELcpBpiAgAAbR4CAAA37Kg==
Date: Wed, 11 Nov 2026 18:22:21 +0000
Message-ID: <A0F1CA65-00B4-4E42-8CB8-12C11BE7A7A2@nvidia.com>
References: <20261111053551.3367903-1-song@kernel.org>
 <20261111155441.GA1829883@joelbox>
 <CAPhsuW6_WsuabPQ6unancwouSPZStQQZa8WoDG82-n6Bi5gPhg@mail.gmail.com>
In-Reply-To:
 <CAPhsuW6_WsuabPQ6unancwouSPZStQQZa8WoDG82-n6Bi5gPhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7742:EE_|CY5PR12MB6129:EE_
x-ms-office365-filtering-correlation-id: 03970c51-a5ed-4f02-2fb4-08df4020ba36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|38070700021|11063799006|56012099006|261022075727099003|261021123027099003|261026121527099003|10067099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fgF0pWnOgr8vfN3soL89DsrZD/3axFN752nQmeOVNupPpCh+wj1OBKdKROjbmmWwMll+xkOOiDV/4aHjRlBStmkRxzqnP9921HUxMM0/N/rAe85n0gEDf9GbzctJaXbjLJE2fof1ZKydxwyt6PsM7bcAaNNMFkzbzY2OU7mlTATOg8conWuCf2iUbAHAAypLzXSXR7hpuTjn/hZDhVhGPyRS4y5V6VTmZSfc+zGMiTA9ucwVw+bMM+/ZTmVzn3Jn04asl4csJEqH3mlVzt25V3rlnFYSkJrm5vMUDR3saE3eVK8etQXP85Et6PeinDPABOIskdBz/JBLYnDc34CU5DPBYwrM1aGhvkTQmifcxmjcCUPSykE+BtGsaXqpdDHRpFEUhJGCKrB0kRLyC6FQFLmnWwjMDieb5zDVUV69T+oRkgcZ1DEgRb6TwRjDvare1xltes7SosjAkrCteCSh0/XVKoLUhrm0a8d7PWAC2VB4eq1pUfl0m5ZI2fzUEQQBuZuSp9XXAnSARUlxmmLkwjW7kH2mqawFnaCEVegRRfV2qynR5zjj9T8xQDX8eL72hnJegxDT65qw5YhWTXNXGEF86nbXfY3Bg8x/MY4M8Mwi1ArOSZztiJJCCUt5iKb2p3LxitZJUg+3XP1/sDTJSbjG27+Z6jCqZQdD6ytW6u+Xx1tuSS8CRiycUzb4FSIlgJyW5bLPWwh0Gij2XuVCnhR2SJtqLQfWUriowlrl/6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(38070700021)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261026121527099003)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEp4aGFIaktaOVVUOXpFejNDNThOSjFDNFpjMURta0hHOEVLMlZqclJjdmZr?=
 =?utf-8?B?cHdMdjRXZnlIYVNMcjlDK1ROakx2c3BZbGJjTHNSekZLSjE1b2llNkl1bnpz?=
 =?utf-8?B?Nml1UG5ZNzMycGhzdDFXRlh3eEtmZlErRExwMWcwSld1ZUlKZjZMUXZUNW1v?=
 =?utf-8?B?QU1LTzdNUWV0d29NZEFKcVVqZGJ4NTNCbHpEeHFMR0V5bE5rMm5zRnRxWVAz?=
 =?utf-8?B?T21wNFlObGI0d3dhaEJ4N1UvVjl3MWZEZlZqUmpteG1ramxxNGRWY2tveWhr?=
 =?utf-8?B?VVJyYXl4WFZNTm0vYlkwNXpsNDZJNGxxVlRzdFdFM0F2M0Y4VnhFYVZlK1FU?=
 =?utf-8?B?VXRLTkFkRjNRbnVZMlJrcmpkMzRqTHFyaXorYlF4MTV5QXhzeDFUVFlBcHNo?=
 =?utf-8?B?RWtiQnNRRXFSZWpPRGdUUWtSTmRQVG8rc0xLaitrdmF3L1lKSmpXTjR0STJJ?=
 =?utf-8?B?amVMVGtIV2xCUWp1dDN6MkFqMHFZVk5BK211UW1jdkRudUlhMHJxQ0QwTEJC?=
 =?utf-8?B?TWNqUmVsTHNDVDQvd0tHYWlsR0Z5Z2orbTdnNncvM3p5NDdsQmhiZmRBSXBa?=
 =?utf-8?B?MTRyUkh2ZGpUSXpmeVNtWHpRZ3hmdm0va1ZFRmQyUkdjcUN6c2FhOW50VGZ5?=
 =?utf-8?B?aWZGVDhhdFQxcDBFK2kyYjZNWWx1aTNheWlMWDFXSGdpUjhNeU4zdXF3ZmdL?=
 =?utf-8?B?MEtxNE1ORGVBbDRBTGF6NFhHdU5ycVVSbm91blpEK3BLekVuSmRPYnYyWlV4?=
 =?utf-8?B?Wlo5RnNKYzJ3VVRUY3liQ1pTS1U1UXBEUzg0eXBwMXB3K1BkNTRHRlVMTXU2?=
 =?utf-8?B?ekFPVStvKzNiK0dnUm1ZN1RxSHpYaHBua0dqUjAwSVRkWEJSaSt4dFovR2JK?=
 =?utf-8?B?UWRHRmtOTnBHQWRxeUwvcFJUcnV4ZHlLRFBFSGhieEZJRnN0d0dNak1EUUt3?=
 =?utf-8?B?TUt3QWZJSU8wbVNZTDNBMnFzOHdGWDR5dWFLZGVyS2Z6cU1oUVJmNkxOWTZo?=
 =?utf-8?B?UVV3U3ZYWDJTTXY5VU96MFpoK20yajRUbDhZclNBcEdidEsyRXdwOEEwWnlz?=
 =?utf-8?B?b2N0dENSQURYMmdRUm9ULzVyalhRdEZ0aVpjSGxzbkpwWkJxWmIwMDZJQm4x?=
 =?utf-8?B?elBJUmZJYXhSVnB1TnVHUklhTUdiMHFTRmxZMFJ4dzZCWGgyOTVnU1EwUXc2?=
 =?utf-8?B?VHppT3JrZG9IOVprQTc0MWlqd2FGTWczSGFWblp4SHJUS05KVGhGeVQ0Rm9x?=
 =?utf-8?B?aWJ3RUd4OWw1bU03a1c5aVZzVzZad0UvbU1RSnpjWjBBWUhCUHRJOHAyWHM3?=
 =?utf-8?B?U2JTOHZ1QmJjc1Rva0xadHp1b0dxNGxsaU1GNG54RlpFaytUSG1mOTVqeHdB?=
 =?utf-8?B?RTNNYWMrc2FnaUl5bmhrazVZM1U4RUxOaCtraFk5YXF1cWVXL25rdG0vRjl5?=
 =?utf-8?B?TmxKWFpqZGZEQmx5aDZzRncySnZkNCtIUTFRdTFTUVJlK0cyMVBvQWhRZ2J1?=
 =?utf-8?B?RWQyVG81b3Z0WGtQbG1pOW5TeFNuZGJJckNlc0Z2OVk0eG9NMXkxT0U4UWlo?=
 =?utf-8?B?RXBzNjdoVUtseGk1VHIyYVlnLzRFcGxaU01nRTUyc2N3R3daVldNRkdWcXhQ?=
 =?utf-8?B?MUZxM01LZGx1cGxiWEZYSExNbTA1TEl3TEhOVU5paUt2bC9aUjlyV0Vxc2M3?=
 =?utf-8?B?eXozdis1d1hMU1MreTduYkh0WFdPWUJWdEVGUXJ2N0xhakNQTVJBQjFDajVv?=
 =?utf-8?B?eEphbG40L05wNytQWmlpODBVV2VsUm1aazh0a3lQYTlYdkRrc3gyUUF6UXdG?=
 =?utf-8?B?SXBJMnZHa1IrRTE1UGw3aXhIL25QejJzOWZ0d2hiZXd3Mk1uL0IyVmJrN3lh?=
 =?utf-8?B?T1ZVeTQwWkhSbGRBV2hrRzloK2xCVnM0NmVmNzFOdGZnVnQ2UlpnNUIwOGwr?=
 =?utf-8?B?K3J2MXRoSDhQUmlyc040aHhweFRKT2d1VEIxRXVNaU03c2tNNHdGSGQxaVpa?=
 =?utf-8?B?azdjdHdDejNsNTM4ZDFjelRKOHlWUUZnQ1NuWWZTbXQwMmlaenFENW9uOEdr?=
 =?utf-8?B?NDNCRTk1Wk01MFFPbkhSa3ZMSVRDeVM4SFhBT0xvQVJxODZvV0kxNnROcUdl?=
 =?utf-8?B?UE4vVFAxVmNxQ0p0WnJmR09PUkR4blBsaXVsSWQyTG1QLzFhMWc2MkN4QWJk?=
 =?utf-8?B?TTJGWEkwOXRNM2VJdVVvajZqL0lzT1Buc1VwamJNTWxmTWdGbEZ1MmFXSW5K?=
 =?utf-8?B?ZWJ2STU2MzlreWhhZkwyYlh2ZnVQOUpQN21DZHZtbzAyUFNSMDlQMTFBa0hj?=
 =?utf-8?B?U2FCVFdWOU9zcndEQk0zWWVLS3puQXVUTFlEc2tIbVNYRGdlcG1VQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03970c51-a5ed-4f02-2fb4-08df4020ba36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 18:22:21.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUtSy/+5o8ujpSDGc3Az26zIiviVPDv9bvIctzOPQomYd8rNQUws8l3LsVeEjzk8L0T+eHHNmoAZgCl3rHnahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

DQoNCj4gT24gTm92IDExLCAyMDI2LCBhdCAxMjozMuKAr1BNLCBTb25nIExpdSA8c29uZ0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgTm92IDExLCAyMDI2IGF0IDc6NTTigK9B
TSBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEuY29tPiB3cm90ZToNCj4+IA0KPj4+
IE9uIFR1ZSwgTm92IDEwLCAyMDI2IGF0IDA5OjM1OjUxUE0gLTA4MDAsIFNvbmcgTGl1IHdyb3Rl
Og0KPj4+IENvbW1pdCA1ZGU5MDdkMjQ5MTkgKCJyY3UtdGFza3M6IERpc2FibGUgY2FsbGJhY2sg
Y29udGVuZC9jb2xsYXBzZQ0KPj4+IG1lc3NhZ2VzIGJ5IGRlZmF1bHQiKSBhZGRlZCB0aGUgcmN1
cGRhdGUucmN1X3Rhc2tfY29sbGFwc2VfZGVidWcgbW9kdWxlDQo+Pj4gcGFyYW1ldGVyIHRvIGdh
dGUgdGhlIHRocmVlIHByX2luZm8oKSBtZXNzYWdlcyB0aGF0IHJlcG9ydCBSQ1UgVGFza3MNCj4+
PiBzd2l0Y2hpbmcgYmV0d2VlbiBDUFUtMCBhbmQgcGVyLUNQVSBjYWxsYmFjayBxdWV1aW5nLg0K
Pj4+IA0KPj4+IFRoZSBrZXJuZWwgYWxyZWFkeSBoYXMgYSBtZWNoYW5pc20gZm9yIGRlYnVnLW9u
bHkgbWVzc2FnZXMgdGhhdCBhcmUgb2ZmDQo+Pj4gYnkgZGVmYXVsdDogcHJfZGVidWcoKS4gIFVz
ZSBwcl9kZWJ1ZygpIGZvciB0aGVzZSBtZXNzYWdlcywgYW5kIHJlbW92ZQ0KPj4+IHRoZSByY3Vf
dGFza19jb2xsYXBzZV9kZWJ1ZyBtb2R1bGUgcGFyYW1ldGVyLCBpdHMgZG9jdW1lbnRhdGlvbiwg
YW5kDQo+Pj4gaXRzIGJvb3QtdGltZSBhbm5vdW5jZW1lbnQuDQo+Pj4gDQo+Pj4gVGhlIG1lc3Nh
Z2VzIHN0YXkgb2ZmIGJ5IGRlZmF1bHQuICBPbiBDT05GSUdfRFlOQU1JQ19ERUJVRz15IGtlcm5l
bHMsDQo+Pj4gdGhleSBjYW4gYmUgZW5hYmxlZCBhdCBib290IHdpdGg6DQo+Pj4gDQo+Pj4gIGR5
bmRiZz0iZmlsZSBrZXJuZWwvcmN1L3Rhc2tzLmggK3AiDQo+Pj4gDQo+Pj4gb3IgYXQgcnVudGlt
ZSB3aXRoOg0KPj4+IA0KPj4+ICBlY2hvICdmaWxlIGtlcm5lbC9yY3UvdGFza3MuaCArcCcgPiAv
cHJvYy9keW5hbWljX2RlYnVnL2NvbnRyb2wNCj4+PiANCj4+PiBBc3Npc3RlZC1ieTogQ2xhdWRl
OmNsYXVkZS1vcHVzLTUNCj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPg0KPj4gDQo+PiBNYWtlcyBzZW5zZSB0byBtZSwNCj4+IA0KPj4gUmV2aWV3ZWQtYnk6IEpv
ZWwgRmVybmFuZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQo+PiANCj4+IFdpbGwgYXBwbHkg
Zm9yIDcuNS4NCj4gDQo+IEhvdyBhYm91dCB3ZSBxdWV1ZSB0aGlzIGZvciA3LjQsIHNheSByYzMg
b3IgcmM0Lg0KPiANCj4gSWYgd2UgZGVsYXkgdW50aWwgNy41LCA3LjQga2VybmVsIHdpbGwgYmUg
dGhlIG9ubHkgb25lIHRoYXQgaGFzDQo+IHJjdXBkYXRlLnJjdV90YXNrX2NvbGxhcHNlX2RlYnVn
LiBJT1csIGlmIHdlIG1lcmdlIGl0IHRvIDcuNCwNCj4gbm8gb2ZmaWNpYWwga2VybmVsIHdpbGwg
aGF2ZSByY3VwZGF0ZS5yY3VfdGFza19jb2xsYXBzZV9kZWJ1Zw0KPiBhdCBhbGwuDQo+IA0KPiBX
RFlUPw0KDQpUaGF0IHdvcmtzIGZvciBtZSwgUGF1bCBzaGFsbCBJIHNlbmQgdGhpcyBvbmUgc2Vw
YXJhdGVseSBmb3IgdGhlIC1yYz8gQWxzbyBhcHByZWNpYXRlIGFuIFJldmlld2VkIGJ5IHRhZyBm
cm9tIHlvdXIgc2lkZS4NCg0KdGhhbmtzLA0KDQpKb2VsIEZlcm5hbmRlcw0KDQo+IA0KPiBUaGFu
a3MsDQo+IFNvbmcNCg==

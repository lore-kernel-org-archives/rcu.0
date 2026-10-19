Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17061357D11;
	Mon, 19 Oct 2026 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389688; cv=fail; b=KUn2G0r3kLVK9Nfqh9KVWH3gJNeLLifX1/MQHstW8KIJ5CY0MI5Tlye6eyHqSxjy4Ri963F/LsNSZWFXQnxl0W67LYNO2HHT0WT0T2Sy7CctPDVaJtWp8J/KsqVi9s4o6/9jHRIfUXVNGAZhoUvgHBz8ySc0vv4z/5xX8yR/uq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389688; c=relaxed/simple;
	bh=T7JsSGH3SuaSWmJyHVKYe+mb/Aiios1uXsUsp7qgonQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYezHxZDfNser7ZoOC29lBCtci62dw5LDUf1UcFn1oWu5U7mIgh+0SVTEp0DjUZUcMz44ElSjornieVOPi8NGk39CM2kJMpn4CPtbT8YVJ0NI9t+19S13sGYWTnzrXf9CdCJX4o1BeskX1mu9CSgUXBpCCPY84+i4jl5dl1ndmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Czo6ZwSK; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Czo6ZwSK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZGMZVliP/E2cE9Oq6zszDsQ+DgQBbGGgT3X/amIrcBka5ldfhvK8fJw4Nlim4ldcKHYPXAn5E2Y1nc5ppGZm5z9gsxjfFh3h3z+svZ3mNifgmWyMRPv1TUm6DpG5puQn4DtesgtVfUm9McziclqSNTuB/gxITRfssKxrrKn01hHi1i3kzebwRtTkp4pYT60yIqdMhFYYXvx2NNHyOcNYvL1dZ2buo1UFkUGU5+NzbW67XY6tB7BOBhf3G+K+KHzW98ouccFLNJ8+lNCOGsWnI9lAdXeYIAf8UfZwoDCurTNyXbR8hBX57orZOvuIJ6rT0PlhS+SKXStSZhIZJrkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7JsSGH3SuaSWmJyHVKYe+mb/Aiios1uXsUsp7qgonQ=;
 b=hlUGyVWfREOHvxyjfMk9TLUPZghcJy+BrRLFJ8JzvVd5rQEAEpBUKGPU3nRWOANuTiYQYGHUriy7TIgdxGxIQFJJK0a+L82Xr/QFkeiBef3n+4XZX/uEWGw5ooCsMlzXop/Eemub1fv6y2ptWbsxHrbku9PduTRgo0KL8brtsUroHGJyGfe+KeOD8jJHTGwGVnvN9IZIoOwWBrKY8CT8TWSXDAuGc2/P14csjnzKA+gK6DAxRpphK6KVO3zsFvrOEoyHD0WHHVdVy1plwgzSmCAmCGJoYfJWVDWHrYi41pOreYeMJnsWs73FzFSA1ApeKLj1OZx0lLXQdC4vlHUiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7JsSGH3SuaSWmJyHVKYe+mb/Aiios1uXsUsp7qgonQ=;
 b=Czo6ZwSK0VUVozEQEQeV1TgnHXWoKKfoFdf4tzLqdse9LmbAtGxSQszUC0tz6mp38wizxH+GLOKTNPI0pighdmCuI054jx0aKzaLvX6NGMzkNPdPwi4NPGOWt7DzWjKKP4WqM/+LenUyVhHE9tOF9V2e2E+jARHDhxA/80gIqi+/gQQ9gmhP8zfrkTQivgTDzdJubZLrUScaLQnASOtfeY8x6Z4cwSLSrjeeUlT8tad5TiaGOGbsOGOyYsZzWAUiXCs6/7mwshjfSPzRR+J+9GpwFiLxhUEVhfbTtUwP/EkTii7aQC1CXMZjy6sw1AleuqaOfT1ZTujx65oo9Ea67A==
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 06:01:21 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:01:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "fuwenxin@linux.alibaba.com" <fuwenxin@linux.alibaba.com>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "boqun@kernel.org" <boqun@kernel.org>,
	"urezki@gmail.com" <urezki@gmail.com>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, "qiang.zhang@linux.dev"
	<qiang.zhang@linux.dev>, "oliver.yang@linux.alibaba.com"
	<oliver.yang@linux.alibaba.com>, "xlpang@linux.alibaba.com"
	<xlpang@linux.alibaba.com>
Subject: Re: [PATCH] rcutorture: Fix busted_srcud crash on module unload
Thread-Topic: [PATCH] rcutorture: Fix busted_srcud crash on module unload
Thread-Index: AQHdX3Kz6KQ4V+BszUSpe+IMCszH6bcEX6Gk
Date: Mon, 19 Oct 2026 06:01:21 +0000
Message-ID: <C84B6EDC-B669-4E37-B9D4-ADA6B76DC9F9@nvidia.com>
References: <20261019023644.2750352-1-fuwenxin@linux.alibaba.com>
In-Reply-To: <20261019023644.2750352-1-fuwenxin@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7742:EE_|SN7PR12MB6958:EE_
x-ms-office365-filtering-correlation-id: 32aa842a-2121-404b-4d5c-08df2da6663c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 9kRV5IMlJiluD0/GLB53Asg+PquGDVgWuAzxS6i9zpeFa8YznO7TOJIrGeYz7z09fQSrco9CH7kzEHWOwwtaRDFpHmaRur6MKsTY+SYeX9IuKnxfcqKXywzpj1YWKaVLWV1nTxGx7nBHio3HOyIHZHH5Yin68sReA+5CYrsvoc3OI+vBLS7hQWV/mGiR9Tbz30e3JqGyIk2mCwrt9sUOXJtUJxGQ+BNlknsMAuMZXWix4bhghJ3C0fOz1qBiKSF6lozx+TubFxxrtIaSmwg/M7vbora6bty6cDopFtcZESSCqLyLW8/dys9LMO4OLQywhgJOU2pa4CudOctZlVjhP37iZrWAdJXTaAvihyoETRRVL6DTLNTj6GIwc0RZ9oyIlJ28ObYu9q5e7y8Bm1Q/VRWQrtZRhM09eCfkSiU244KZ4/nG7rhCAd/uCZciNy7JnrRlrWEsZEohqzc60cvKtmMGhmXGXIsY9e3MXXEHFOyx2qJFg0PVX6WRSuCbU7YAGlZocK9iYhPWCklSYfgwGW6x2qJdOKsDZquD8F13JSPAB7wavxalabQIEipVPdQaOIAFu+6yT71Rc2CzlvVWQMQz6KBAkWLNegZE4nSZXGpO9RIbfu1oW6JapIiHIerUFf4i5UTnjw73q0r2DD3YTr2QUjxGKCS2bBNOfZ2XPPfQqiJ6vIkKY/ae2f32VNF3KVSsG3wauF0Gbboakbv7/bIbjfsjkb2JG7d4ZoUDIAQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmhnWlZaYjloZU1DT0V6anFHcE1CRHl5eWFXVFdmQWRRMk5CT1RDUWVnL09m?=
 =?utf-8?B?ZXVWd0paR3p0R21iODdXT2RRdlZEbi9xR3JrT1VxVFlVWW1Va1NvNFg5RUJq?=
 =?utf-8?B?S2FmQUxleWcvdEdBTjZMY1l5cnBuZjQ5b1RZaTB3ZVNUMDE3NnRMazh0R096?=
 =?utf-8?B?UnV0U1J1ZzF1WmdOY1VhTTFuMnNrM0N3Q3ZPWDM4WUk5bjU1SnorQWpBQnAw?=
 =?utf-8?B?QWlQRng4RjZaS3B2VUlETy8zeUwzNEQ4ZU1VZXRvRlhvL3o2RnpoM1BXU25t?=
 =?utf-8?B?ZWlCVWJnZ0tLMEdueTFGZWhyQUV4UlhTTHNFbnV1dFNyS1g0U3VoQ05wRXB1?=
 =?utf-8?B?bnRLcWFtQkVFNkZSRzQzTXhNQWJvS1RuU1pPTDVhY3NnUGU4ZkZxTmR2MDN1?=
 =?utf-8?B?MXZjbG01K2ZNQ3VQR0E3S1BOQS92clFqVGFEcWQ4TUpxR3hPVUVsckVtNTVv?=
 =?utf-8?B?L213citENjBiYTF0aXErUEVVS0pPZmJIeWxaTXNkV0JiUFNpTGh5RTY2YkJu?=
 =?utf-8?B?cnAvazRZK0pPWXpJbEV5bHR1R2puR096MzFkaUlTd1FyenV5bWVWZ3Q4ZUw1?=
 =?utf-8?B?MHZOMXlvK2d2dmN6OTlZSTJWODZDcnk3MU9DMDhpeFNRbEpHWkVSVFRyOEZz?=
 =?utf-8?B?MVlGRVYzREFNYk83UHlrNSt4RE9oci9HZlB6eTJXU1UwdzZ0akZ6R0EwbWNG?=
 =?utf-8?B?SU5MOU1rWk84MDBUZ2NKd1lKYkpsdG9JR09ESFZoV1hTNmRXTm5lZ1lZS2Vj?=
 =?utf-8?B?VWhsVWE4S1RKNy8ySk1TQzRyc0JrVWxueWpEcXBpU29yUWl5aStOa3d6S2p1?=
 =?utf-8?B?TkgvRTBVS3lLY0RkZ3VWNENZRGlXWk1ybnp2YS9TdUZrMkNzRkFmQlVscUNT?=
 =?utf-8?B?YWFiNG9pY21oUUVjY0tFWHNYZURzOHpCalNlbXI0K0NkaGFHcThxZ1laUWd3?=
 =?utf-8?B?bmJGOFV2aGlsMkRCWnNTMmNZRjRvUkxwZXR3SEdCMEgrR1BoWVJKLzBPVnZu?=
 =?utf-8?B?RGMxNllqNWsrMWk3K3dTMzNVN0xVU1VucG9oTGFndEI4ODRMVTZiaFBXV0pi?=
 =?utf-8?B?bWZhbjRjNk1lVTR5Y1lWUzVvajVoVU9MR1oycWhGTmowWlVQMGhkcjZMYjJv?=
 =?utf-8?B?R1daVHE3NXFxUUk1ejlLaDJsSzUrRjRVcytIcU1hU0RoSzJXSVRyTnJBQ29a?=
 =?utf-8?B?dFoxQnFyZlN4VTdnRHdwT0JaRjZMcGdEUkxOTis3SjRFRFZCK3hvOWdoSnhD?=
 =?utf-8?B?WXdFMmxMWkE2a1FNQUpFOXU2cGVZS3dha3Z0a3dqclh2QnBia1VVSUljbGZK?=
 =?utf-8?B?cGh3WHRKMERPaVdVN2ZDL29VNDh3SSsvNHBzRDdDNnBwZ3NzTXRabldMSGJD?=
 =?utf-8?B?c011VWJmb1RmMDM3YjErS2NZaE1qdG90enpDeXo4VVE0cnhKb0Q0TGJlOTRW?=
 =?utf-8?B?K2JUeWNaL3BOcUZPN3J4Ly9zY21vNkE1ak9wSE1KTStPQm1qbkpkVEhtTGp2?=
 =?utf-8?B?UVRFKzJTaTh1dHNBL1lJMk5ucUxvdnRiZTZtZnRNcGZNcjFuQktrRkdxbUtr?=
 =?utf-8?B?MHJqR2pMWFNuRUpWeTMvNEtzQWFpSWQ0VFhlVm94TWJzNStrRnI2UzUrcWtR?=
 =?utf-8?B?eHBMVXBoendYZkN1cGRTUU9qNVhKbXVpYmMxVHNVWk80REYzMFNMM1hRSHNx?=
 =?utf-8?B?Ylp0RnJNaGh6cFpVa2Zxc0NQS3JMWW1CVUplM3B6RTV1bFhvMG84NG51VVBj?=
 =?utf-8?B?UXFMSXRzSDg4MlVGMmJUcHZYM09FWUtuUXpYMmI5VHU3WWZWVVhaZWpqUUZQ?=
 =?utf-8?B?VW50dXl3cURucUxWRStBVUg1bnNyTXlOUlJkQkZjUHF6M0F2dmVqK28va0pz?=
 =?utf-8?B?MXFSNk01Y0QyUGQwNE9wVDl3eVNpbzJUeDZBOUhYTERzWElZQ3lMdXpKODZm?=
 =?utf-8?B?SVZ3UXZ1QVhodHhOU3RtL1VtNlM4eGE2OEc4OTNxdEJ5ZHNTenZRa1NvZTZD?=
 =?utf-8?B?RC9PdzZDblJMN3VCRDUrdkRacHc4ek9seXE4c2hNQjMvT1NJVUdpei8xSXov?=
 =?utf-8?B?ak93OGpWSGsyeS9ZcVluV2RjL0xod0FuUDZuV2dPV2w0SGpuTjQ4MlNodzdE?=
 =?utf-8?B?ZCt6d1RnNlBwMVhzMWRXZTJFbnlXR1I0MTJtRXBvcTE3dk5zOVozRFllVWRW?=
 =?utf-8?B?SnJPbWp3Y056THlMQVBSL1V5Mlo4d0VUZGFTTlJyNTBGaXl6cjg1OTRpUDli?=
 =?utf-8?B?NjR3ODYveC9hekZxMHBNZDREclZ0bjU3M2tsT25EdDdvYUdkeWVGSTZDdkxi?=
 =?utf-8?B?MUxLdzBKKzk4VFRldTJRcU9vZTd2VGFzdWN5a2FtNUdPZzQyekI4QT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aa842a-2121-404b-4d5c-08df2da6663c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 06:01:21.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpNL8b6sgXq7S4oZ78kv7RY+OTyna1ZvGmYnuMofwrG8fX1EfNkki2/DVW4dG58V6w+o0AAHJefBWVdLBQdzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

DQoNCj4gT24gT2N0IDE4LCAyMDI2LCBhdCAxMDozNuKAr1BNLCBmdXdlbnhpbkBsaW51eC5hbGli
YWJhLmNvbSB3cm90ZToNCj4gDQo+IO+7v0Zyb206IEZ1IFdlbnhpbiA8ZnV3ZW54aW5AbGludXgu
YWxpYmFiYS5jb20+DQo+IA0KPiBDb21taXQgZTRlZDIwYzE2MDNjICgicmN1dG9ydHVyZTogRXhl
cmNpc2UgREVGSU5FX1NUQVRJQ19TUkNVX0ZBU1QoKSBhbmQNCj4gaW5pdF9zcmN1X3N0cnVjdF9m
YXN0KCkiKSBzcGxpdCBTUkNVIHRvcnR1cmUgaW5pdGlhbGl6YXRpb24gaW50byB0d28NCj4gaGVs
cGVyczogc3JjdV90b3J0dXJlX2luaXQoKSwgd2hpY2ggbm93IG9ubHkgcG9pbnRzIHNyY3VfY3Rs
cCBhdCB0aGUNCj4gc3RhdGljIHNyY3VfY3RsL3NyY3VfY3RsZi9zcmN1X2N0bGZ1ZCBzdHJ1Y3R1
cmVzLCBhbmQgdGhlIG5ldw0KPiBzcmN1ZF90b3J0dXJlX2luaXQoKSwgd2hpY2ggY2FsbHMgaW5p
dF9zcmN1X3N0cnVjdCgmc3JjdV9jdGxkKSBmb3IgdGhlDQo+IGR5bmFtaWNhbGx5IGFsbG9jYXRl
ZCBzcmN1X2N0bGQuDQo+IA0KPiBUaGF0IGNvbW1pdCB1cGRhdGVkIHNyY3VkX29wcyB0byB1c2Ug
c3JjdWRfdG9ydHVyZV9pbml0KCksIGJ1dCBsZWZ0DQo+IGJ1c3RlZF9zcmN1ZF9vcHMgcGFpcmlu
ZyAuaW5pdCA9IHNyY3VfdG9ydHVyZV9pbml0IChzdGF0aWMgc3JjdV9jdGwpIHdpdGgNCj4gLmNs
ZWFudXAgPSBzcmN1X3RvcnR1cmVfY2xlYW51cCAod2hpY2ggdW5jb25kaXRpb25hbGx5IGNhbGxz
DQo+IGNsZWFudXBfc3JjdV9zdHJ1Y3QoJnNyY3VfY3RsZCkpLiBBcyBhIHJlc3VsdCBzcmN1X2N0
bGQgaXMgbmV2ZXINCj4gaW5pdGlhbGl6ZWQgd2hlbiBydW5uaW5nIHRvcnR1cmVfdHlwZT1idXN0
ZWRfc3JjdWQsIHlldCBpdCBpcyB0b3JuIGRvd24NCj4gYXQgbW9kdWxlIHVubG9hZC4NCj4gDQo+
IGNsZWFudXBfc3JjdV9zdHJ1Y3QoKSB0aGVuIGRlcmVmZXJlbmNlcyBzc3AtPnNyY3Vfc3VwLCB3
aGljaCBpcyBzdGlsbA0KPiBOVUxMIGZvciB0aGUgemVyby1pbml0aWFsaXplZCBzcmN1X2N0bGQs
IGFuZCBmYXVsdHMgb24gdGhlIC0+bG9jayBmaWVsZA0KPiBhY2Nlc3NlZCBieSByYXdfc3Bpbl9s
b2NrX2lycV9yY3Vfbm9kZSgpOg0KPiANCj4gIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2lu
ZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBkZmZmODAwMDAwMDAwMDFiDQo+ICAuLi4NCj4g
IGVsMV9hYm9ydCAtPiBkb190cmFuc2xhdGlvbl9mYXVsdCAtPiBkb19iYWRfYXJlYSAtPiBkaWVf
a2VybmVsX2ZhdWx0DQo+IA0KPiAoVGhlIGZhdWx0IGFkZHJlc3MgaXMgdGhlIEtBU0FOIHNoYWRv
dyBvZiBOVUxMICsgb2Zmc2V0b2Yoc3JjdV91c2FnZSwNCj4gbG9jaykgPT0gMHhkOC4pDQo+IA0K
PiBUaGlzIGlzIHRyaXZpYWxseSByZXByb2R1Y2libGU6DQo+IA0KPiAgbW9kcHJvYmUgcmN1dG9y
dHVyZSB0b3J0dXJlX3R5cGU9YnVzdGVkX3NyY3VkDQo+ICBzbGVlcCA0NQ0KPiAgcm1tb2QgcmN1
dG9ydHVyZSAgICAjIHBhbmljIGhlcmUNCj4gDQo+IEZpeCBpdCBieSBtYWtpbmcgYnVzdGVkX3Ny
Y3VkX29wcyBpbml0aWFsaXplIHRoZSBzYW1lIHNyY3VfY3RsZCB0aGF0IGl0cw0KPiBjbGVhbnVw
IGhhbmRsZXIgdGVhcnMgZG93biwgbWF0Y2hpbmcgc3JjdWRfb3BzLg0KPiANCj4gRml4ZXM6IGU0
ZWQyMGMxNjAzYyAoInJjdXRvcnR1cmU6IEV4ZXJjaXNlIERFRklORV9TVEFUSUNfU1JDVV9GQVNU
KCkgYW5kIGluaXRfc3JjdV9zdHJ1Y3RfZmFzdCgpIikNCj4gU2lnbmVkLW9mZi1ieTogRnUgV2Vu
eGluIDxmdXdlbnhpbkBsaW51eC5hbGliYWJhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEpvZWwgRmVy
bmFuZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQoNCkFwcGx5aW5nIGZvciA3LjUsIHRoYW5r
cy4NCg0KDQoNCj4gLS0tDQo+IGtlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIHwgMiArLQ0KPiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYyBiL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+
IGluZGV4IDhhOTI4MmEwMjQ1Y2MuLjdjYzc4ZGExMzU2ZjkgMTAwNjQ0DQo+IC0tLSBhL2tlcm5l
bC9yY3UvcmN1dG9ydHVyZS5jDQo+ICsrKyBiL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+IEBA
IC05OTEsNyArOTkxLDcgQEAgc3RhdGljIHN0cnVjdCByY3VfdG9ydHVyZV9vcHMgc3JjdWRfb3Bz
ID0gew0KPiAvKiBBcyBhYm92ZSwgYnV0IGJyb2tlbiBkdWUgdG8gaW5hcHByb3ByaWF0ZSByZWFk
ZXIgZXh0ZW5zaW9uLiAqLw0KPiBzdGF0aWMgc3RydWN0IHJjdV90b3J0dXJlX29wcyBidXN0ZWRf
c3JjdWRfb3BzID0gew0KPiAgICAudHR5cGUgICAgICAgID0gU1JDVV9GTEFWT1IsDQo+IC0gICAg
LmluaXQgICAgICAgID0gc3JjdV90b3J0dXJlX2luaXQsDQo+ICsgICAgLmluaXQgICAgICAgID0g
c3JjdWRfdG9ydHVyZV9pbml0LA0KPiAgICAuY2xlYW51cCAgICA9IHNyY3VfdG9ydHVyZV9jbGVh
bnVwLA0KPiAgICAucmVhZGxvY2sgICAgPSBzcmN1X3RvcnR1cmVfcmVhZF9sb2NrLA0KPiAgICAu
cmVhZF9kZWxheSAgICA9IHJjdV9yZWFkX2RlbGF5LA0KPiAtLQ0KPiAyLjQzLjcNCj4gDQo=

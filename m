Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9928F7;
	Wed, 30 Oct 2024 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730260578; cv=fail; b=mbwZ27J9XLmyvR6ZXpoVPb0JyCj69lKyMGDb0qorCN7mDZEbNG/TQ7K0rLVcw+WFTWCLTcLieId3utFYaKTtf3+VpxFZIVgxPcIQ9bhqgFXisAeQmdqzh1MgYur8bwxep+mTabzOpFBGq8vdgNmunj/aRqFfkWspfno/Jq3PV8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730260578; c=relaxed/simple;
	bh=5VlKU9A5fpjxz5oIGhuRK8mE82ADmhyI0dartDZorp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLGysy6M5nqlU6MSM6zpLsS0HJcMp1wwzaThen+c8WFi7YZxIoifFe+DTX5FhmzHEDEJTyIBtvZPtmsMCqRqWZt+cqbEd+HrerIDQ2BMXQeyqSfQRbACq4o96h3NNEiS2B/VT+/zx7dMKJdYvoOAUrBWQacrlr+lau7rU9nOsNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uEjQUoYA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sU1T7sXw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uEjQUoYA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sU1T7sXw"
X-UUID: e12aa298967211efb88477ffae1fc7a5-20241030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5VlKU9A5fpjxz5oIGhuRK8mE82ADmhyI0dartDZorp8=;
	b=uEjQUoYAUCLPjJ3QeSLc9ot6NZ4Bc35OJm6zKNDmY5E6hDb5jGWgHffJooKO/b2rO0/97grIj7eEcficVx/JS4QkUS480hsoeGzcOuPe0lalYCOVvKW6sXcVQyrFlzQOr/WH0zTUqAdeRVFAdzOQEXgeRTRqEvKmh+mmEMS7r0w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:63436e63-fc54-4f39-b430-843d04e83483,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:8de044e7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e12aa298967211efb88477ffae1fc7a5-20241030
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1458661996; Wed, 30 Oct 2024 11:56:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Oct 2024 11:56:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Oct 2024 11:56:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxdkM/teJXMC/ohq+dTCDT4mmvffKZR/dMfLOt+pduSR5SUWtBBUc/r7rumawDOpIwwE/KS2K0fsEE7jg+Epf2Whr3++dSeJ2Uq/vY6Dso8QVp0P0JtenwE78mtjhFoy0G3XlpLotm+Wq8UornDloGq3EpOG3O6A/lSqlZNoElixMJh9KPvVhdMM4rMncsivKUFyJZkOT/DbpXXbnKhxSLIzs7OKUk40g6MILGI9ekTj2VBXimfZpwneTzTdmyo9TeoFaQo5UpRs8TpAtm20UknMqd0/YQxrjLdWRJhtqFV3QAA+LhBIeNxhctbYkO9h2183nKoKkDUekoj05vXl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VlKU9A5fpjxz5oIGhuRK8mE82ADmhyI0dartDZorp8=;
 b=vbQE1OqbRXADguC2S9/D7gfIQbdKlQa7sggfCjic/jai16rALkDULdTcldqIY3WU/4eOWdeGJnJEzouB1L9h0yJbalx1cuOagggDGxzRCpCtwzUUCcxlfb2NJVP/Jn0yk6UxIdY5XeqBdunHM7p3YSRY4qT3DcQbYZjtBbcETfK5ho1G9+kHWltBYDDEoX0VaCa6DwyX8ZiPtdXExZmqtKTl0zVscLrnembQ0RiDOW12XCk3jH7Y47fkxXf80pgmTimFyuhj1U1wlXldty9PDr3dr/lynDU+nm8vzUMpZQQW279n2koCE5cY5LmstoL6uEoAnqgAPdux1ZZ+8GetIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VlKU9A5fpjxz5oIGhuRK8mE82ADmhyI0dartDZorp8=;
 b=sU1T7sXwfcYdITR+ki4ixuQY+TTPANv/I4dO+q9c9XfMdsv/eWiUocfMbjpIOAKihVEu38hLWqew4v8EgpR7AVwasr1kCv7EdYlnmpICW7NCWY80dtDRQhRzJhZ8EDI5SCxdjLiprXcV5rwUGCrtbGz93whhNmuWaSNLP16ZNNM=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 TY0PR03MB6680.apcprd03.prod.outlook.com (2603:1096:400:215::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 03:55:57 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 03:55:56 +0000
From: =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dianders@chromium.org" <dianders@chromium.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "frederic@kernel.org" <frederic@kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Topic: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Index: AQHbKZuQD0a1bmt83kGqJ5+0CTWhuLKc/yAAgADtCYCAAL/dgA==
Date: Wed, 30 Oct 2024 03:55:56 +0000
Message-ID: <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
	 <20241016161931.478592-3-paulmck@kernel.org>
	 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
	 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
	 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
In-Reply-To: <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|TY0PR03MB6680:EE_
x-ms-office365-filtering-correlation-id: bf641cfc-29d8-4847-b06e-08dcf896c243
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlBSY09GZ0FUb25qNUJDTzNCRjJRaHYxWlBCMGJSdU9zWTV4cU0rSEVOMDk5?=
 =?utf-8?B?cVFlQU1Yd2xMOXRPSVZDeFFNVWllUWxmemNyUEdUcm9vcWVKcUN4NzZGR1RM?=
 =?utf-8?B?dllVdS80cFp1VDNKSjE5VE00bmV4ZTNQWjVJb2dtOWI0R2dQTW1PNzNidlU4?=
 =?utf-8?B?bi9jUzJHOUtRQ0dmMjF2alZ4K3BqWXFBSG5iamRvUE96cEpSUnVZSVpWdS9s?=
 =?utf-8?B?cXI2dU5aVE9EaVQwKzFJVXB3cmo2UGdWVDRqbGpUTjZNMWlIOUFKR0ZsdTVG?=
 =?utf-8?B?VGZJOGQ1cHlDcW8yeGthYS9KY1UxWXhRMWRqUWEwRlV2LzhCN2s5blduaGk2?=
 =?utf-8?B?a1ZSYW5zTm1hYXlSSHNIdWQ2Sy9menIzY05wTEd4QXJwbzBQSXBtR3B3MVc1?=
 =?utf-8?B?VURvN0dxQkd5VE04RWoyMFhvOS9rTVJPNHFCb2dJaVBIVzl3eHpqTkNkRUZk?=
 =?utf-8?B?YmNsVWNxMjVCbDF3OSt3bGJDRVhVNVlDWUJnemwvb2ZXOVBHRnpzYW1JTUFw?=
 =?utf-8?B?b0JoSTJleElydGR0TnRpZjRSSlhUNEw2T0x6YTRMUnUxSzZRd3R0Z0RxK1li?=
 =?utf-8?B?NmROc2MxcVhQMzQ2a1VMOEk4QnN4QWJIVXRZcUJEeVhQQU9YUnJ2dmxUSk1P?=
 =?utf-8?B?cEIrZW9FRUVOcFM3c3h1KzEzdDZkNklBc0JYR2FubGE3ZWJLaE91bm4wVnNP?=
 =?utf-8?B?eU5FSnNNKzYzRnJVYUNheC9WOWlyTlVteDNVZzdmMWJ6aXViNXMrUlBGeDFt?=
 =?utf-8?B?TVFXVkVnWVRHV21oNVUwZ3ZrMXJrS2p0bVZaS2krK0xETDQwMzVEYVpSdHc4?=
 =?utf-8?B?Y2I4OWhUcVY4cHVqTlVTbFd3UGxlUDI0ZjVSblhucnhzdExkQmxmTXZoVFVp?=
 =?utf-8?B?WVphSVI3eGE1T0JlZWtFL2F3NGM0aGk5OVBoNTZTRkN5S28wcysxUExvYkYw?=
 =?utf-8?B?K0JXK1gxVXhmbnQ5V2dkL0pwM0s4cm5WaHhyNS9VOG45aWltempENStjOUVr?=
 =?utf-8?B?WmtRbWM4Vk5RMDVxM0tWRnBCWUlVM1ZBRysxOTJlZmgwSFZjVjUvajFoTmtK?=
 =?utf-8?B?aGZ3OE9sNzNab2JJbzM3QnZ5S0JjUDgzNVpCOFA0Y0xKcm9IYm5aQ1pBazdE?=
 =?utf-8?B?OVgwVUwyMVRNUnFES1A0MjZZd0tDcnVTaGZJRGxOVWhMenJweWozQmpOb25Z?=
 =?utf-8?B?TW9nSDg0SFB3Ykl6alR3cng4RFFjMnNQcW5NVmJmNjYxWE1RQjBKeGV3OFVV?=
 =?utf-8?B?eWVsSDVLNGtZY1BaeUl5TC91QmErT3RSVGdDZEk4RGZIdXp6R0EzY0g2NlYx?=
 =?utf-8?B?SE0vVGhmSzIxdkF5UVRzay9VZ1BBL0g5aFhLU29QZk9FR1JFOXFRbjYyaFpD?=
 =?utf-8?B?aEJqcW8zd0NHOTJUb2NFZnFHRG0wSTlBaUpXZXFkc3IxUEZvZUZycG5GajYr?=
 =?utf-8?B?M0s4SjlxN21FSU9HZzJMLzRVeVFNRmRQWktwR2NhL0N0emJWOVZoSExEU3Zr?=
 =?utf-8?B?V3FlWUJJUXYrd1hOemRqd3FhSWFpOWdNeGVKQ0lVSWx6V0dwVlZmaVlKbENx?=
 =?utf-8?B?NUxnanE5ZGQ5Q0M4TXkxK2lnSVFiZGlzRGNYMDNWeGJDZHlsQ2dFdVIwSG5a?=
 =?utf-8?B?SS93MXFBeEpDREVmNXZrSUx0aVpxeGVBYVkyY1ZhZCt6YlNZNjZrd0s4Y3Ux?=
 =?utf-8?B?aE1hZEpIZFNzMWtYUlF5R09zazVGK09UVWJhZEs5ZG4xRExmTG83ejIwUkRQ?=
 =?utf-8?B?U29EUjBhSFM3cUJEQ0hjZ0pjR0hhenA5V1VyTUs0V21Bd09EenpTMVRnK3Rz?=
 =?utf-8?B?OVZtMEZJbk9xaWgwNFFxMGdLdWd0ZmxJRUt6MDByaHBjTGRRdnljSTJvMCtB?=
 =?utf-8?Q?vQSgzF5hWtVLX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1cxY2J1RmE5MFo2RW5ndFpEcDVXL3VOeDZNMHBnUXVXTHl5ZHVZZG1xTTJ5?=
 =?utf-8?B?M0pBUWtqYjhSbS9wMTNIV2ZYem1oVnN0UFhzUGlDb2NaV3pTMnVrVE5ZV2s1?=
 =?utf-8?B?Y2RqU1dJSnFsVUZ0a3NiN1BoUSt3T2tobGtmZ2RWZ0dxK1hqdVlOTjlONlB6?=
 =?utf-8?B?ZXJ5WFVIOVBZNEtZejUwUjVVNHpENTNQNCtVMzdmdDRMRUhCc3MvcXpiRVc0?=
 =?utf-8?B?bmcyTW9hdWUyclEvdGZmanMzb004V0pYc1VvRE40WFJYL2grSVR4WjRMa29v?=
 =?utf-8?B?NHowVVFmaWZwOXVVUjR3ZktDNCt4NGttSGFTbU16NWxvdytEaTFCQVkycjls?=
 =?utf-8?B?SE9MUGdvOWZieHEzNWlpUVRjVjNGUEV0NDMwaEQxd0I0SmszaThZbkhPNU9D?=
 =?utf-8?B?VUFMNmxPR3M0cTZyS0kyRmdTclVJUG1nS3daKy9yZkYwQXBySWpoWXhKdHVm?=
 =?utf-8?B?VGVucmlrYjFLTzNCNXNHZW9lVlZMRU9nZWxpU3FVUnNmdDRreEdMUi9kdThz?=
 =?utf-8?B?K1VIWWIzb0tSa3RPamQ0bHhLcXBCbWx2SEtFOWNHNlZpT1ZNbW1iUUtoSS8w?=
 =?utf-8?B?UWZ1dzloK0R6WHZKWkhKLzVac1V5RHRtNjFxcy9uOWVxNXoxbFNieTQyLzFx?=
 =?utf-8?B?cURDK1RuVlMvNGhoTlBqb05JZWZVNDg1VktCSno4ZXl2OEtWT1hiLzMxVTI5?=
 =?utf-8?B?ekQ1bFdxeWZITHF5eG1rWkpITHZwTmJhYzVIQzB2WTJNZDk2Tjc4bUwySjRS?=
 =?utf-8?B?cDg4Rm0zVXUzenpYZWJaTTlMU3RtaTB4bVBNalNFZGpTU2xXSUl0MXJyWlBT?=
 =?utf-8?B?RzhiUFgrL3NVdm1USTF4VnhOYm9ialRYeU9KK0tJcGNScHkraUt3OHJLNHlK?=
 =?utf-8?B?QXJYRVJHUkdtejlEbTV2eWZ5TTJXWm1Hby8ra3hzTE02TTkrOTlndUc3NHBo?=
 =?utf-8?B?M3QvdkNncUpOS2N3c3FVTGwrcW5uME9NaEN4NThKRGlTdHN4S2piaU1CYVpD?=
 =?utf-8?B?Vm5xMG8xWGlGcDNScWpZdVlZSGdIUldEam5JYVBrbTliUTNDSlB0OW5YZDQ1?=
 =?utf-8?B?ekNxY1hpU09qQ0hQY0xHYWwrZGhlcDlKOVcvdHJtYUw3eVB1WW01MGlLcjZz?=
 =?utf-8?B?WnBiV1FDYzg3Mkpody9SYUdjK3IvckhVQW1CbjFHWExabFI2cGlCK2FZTkNL?=
 =?utf-8?B?Si80QkxNd052WGYzUzYwVFh4eDBFN0tYYmVOck1wZ0l0NWhQYmpTbTl5ZHd2?=
 =?utf-8?B?cWFCb1VlOVRRdi9uVnE1MFpENm4xODZVaTMwSjcyazZsMTRXZzM4ZVBmakJH?=
 =?utf-8?B?VVp0eUo0bTVJMms2TFd5RHFIaDZxMWpySFZSSjhXeUNxekVkQ1B5Z3FmNEk1?=
 =?utf-8?B?Tmp5V3dZclRoZmJndENjVHFGN21HN3FsOHZXeHdmMVVBaVpmaDBIcVBRN2Rq?=
 =?utf-8?B?cm9wem45cE4zMlNBL2NtdjdrWXAzL01hZTNYL1NQbkpONGMyZ3NBMjZzVTd3?=
 =?utf-8?B?THJyY0ljMDhaMWU5QUF3SE5NeitnMnVrM0orcFErUVk5eHVDa2R3cGNJejgv?=
 =?utf-8?B?OWx0MEdzZDd1NDRIWWsxZlBQRmcvWXk0MUgzRjBMeHQ1emlLNjhxOVg1MEp4?=
 =?utf-8?B?Z1JVWEt3WGdhR3JRRDVJQTA3TlF0MW1JTWc4MWhLcHQ1TlZzVW01WGxWeXhV?=
 =?utf-8?B?dE5FeFkrSHQ1ejZWK2dJWDV0S2pjdms2Umozd0F4MjhTeVA2cGVaQW1YNGIy?=
 =?utf-8?B?SDNUNndVNVpZbDdCZ1dVd3JVYU9ibXdYNUJmMm1qbXJ1KzJSeGVPUjYxcnIw?=
 =?utf-8?B?Vitlb0poWkgySkpFdU9mZ0kvVm1RanhEaHdhRnEwU3Q5LzlmWTIrd0E1RzAw?=
 =?utf-8?B?OHJIcWxBeEFYV3RDUUhWSXErQ0FPS1EvSUE4OUprTGpHd0V4c1lsaG1RSi9G?=
 =?utf-8?B?dG9wNC85N041MG9TQ0pQVGxsajJxQzRRK0RPQmRCejJnVzc1dWtqUWd5T1JZ?=
 =?utf-8?B?VXlhT21ST0dpUFlYYnV2aVJZTHNUQ2U2VGc3RTd6VENDT3doZGJOakJDU1pD?=
 =?utf-8?B?UDlyb2dFNW5rMTBrVjcwNnh1cDV0TjEvZ2FnZHVXb2xPL21RcG9Md0xDeEx6?=
 =?utf-8?B?cCtscm1pUHN1N1JYOEoxZkhTQm5NWFBUSk14ZmhoZll3eDNMWEt2Vy9KSWJX?=
 =?utf-8?Q?sr05MB+r0F1JfZRyNgNSoXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6373EC8261A39F4F9F02B47BA902FB67@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf641cfc-29d8-4847-b06e-08dcf896c243
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 03:55:56.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0N6U9v9elYSKAtJw0tbulFZZ96gyi6puB1OI859sJXI0kfOQosbfeyEEXy7/qkGk19CI74RJSKcctMtuaJ+rztQ9v01FhnBdzfWq1S0RpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6680
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--33.750600-8.000000
X-TMASE-MatchedRID: 8HTFlOrbAtEOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rfEt9Ay9zO7r3TxH65UxSGGfRQPgZTkip+Mk6ACsw4JlXWVD8efRM6EsX
	bUlJ1fny92jiyweKy5O0nTJ26L90i0ZSGMfUN9TYVglQa/gMvfChRWQHuJ8meBivPDXFZl7hSUt
	G/M//UwagIi/g/QfgahC3170onw8f66huHBXP2APSG/+sPtZVkmoKXVHfiMM/i7ECA5q90ue9dH
	lmU4FeJ7yhTGm6KWsJS97U9M3Mvw6BW2ZrFVYNRypeMiaCPnxugD0t7xcmlut+r/5y+DU0IxGu+
	O8UpNrFbjlNchhVCsQTnGf5FZrbg+ZxA4VDjVMw01fwdVLvlwiQ+SLVh+H0igSQ4PtUR2USv+kt
	mbF8yMJ3urZY/NdCrfFYx8Xl78j/H4JN4GsPAjtF8NCC76P7lUAjrAJWsTe8zFWOYrWw6A4N2pM
	n0FcvGHnSogjqvw8osj+zQdd2ee6nu9amnAZVjtT4jIeGRd/WSeMExjuIoEglbhF7ZTanLSG+gm
	vFXK/AaGRe58h1G3QFd21k9Z8naoLWVTedAnK8QDf0hTLXhcbghEq8e8JZygrAXgr/AjP1HZGkG
	AQcl898BRtILNkRUNkz7jSHm0hWip6xhGipIWfAjkTMkRNNUgdhI7ndNtOCAIO0KLsn/zZFsZWM
	DHAh7NOKm4bqXZsj9MHJVK6TSrgJRed7MoLu/VtZNMIeE5PEjo8c0NkYYIltJ3QKUPkXASZfAls
	uoOE05uw/H3CVB2FtO7xxxvxHqRCjggdsoySueAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZxEAl
	FPo846HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--33.750600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DA009A6248D879E8688D98A28CA4305DAF2F770B94C21DB64F5F9CDABCC725C12000:8

T24gVHVlLCAyMDI0LTEwLTI5IGF0IDA5OjI5IC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIFR1ZSwgT2N0IDI5LCAyMDI0IGF0IDAyOjIwOjUxQU0gKzAwMDAs
IENoZW5nLUp1aSBXYW5nICjnjovmraPnnb8pIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0xMC0y
OCBhdCAxNzoyMiAtMDcwMCwgUGF1bCBFLiBNY0tlbm5leSB3cm90ZToNCj4gPiA+IFRoZSByZXN1
bHQgaXMgdGhhdCB0aGUgY3VycmVudCBsZWFmIHJjdV9ub2RlIHN0cnVjdHVyZSdzIC0+bG9jayBp
cw0KPiA+ID4gYWNxdWlyZWQgb25seSBpZiBhIHN0YWNrIGJhY2t0cmFjZSBtaWdodCBiZSBuZWVk
ZWQgZnJvbSB0aGUgY3VycmVudCBDUFUsDQo+ID4gPiBhbmQgaXMgaGVsZCBhY3Jvc3Mgb25seSB0
aGF0IENQVSdzIGJhY2t0cmFjZS4gQXMgYSByZXN1bHQsIGlmIHRoZXJlIGFyZQ0KPiA+IA0KPiA+
IEFmdGVyIHVwZ3JhZGluZyBvdXIgZGV2aWNlIHRvIGtlcm5lbC02LjExLCB3ZSBlbmNvdW50ZXJl
ZCBhIGxvY2t1cA0KPiA+IHNjZW5hcmlvIHVuZGVyIHN0YWxsIHdhcm5pbmcuDQo+ID4gSSBoYWQg
cHJlcGFyZWQgYSBwYXRjaCB0byBzdWJtaXQsIGJ1dCBJIG5vdGljZWQgdGhhdCB0aGlzIHNlcmll
cyBoYXMNCj4gPiBhbHJlYWR5IGFkZHJlc3NlZCBzb21lIGlzc3VlcywgdGhvdWdoIGl0IGhhc24n
dCBiZWVuIG1lcmdlZCBpbnRvIHRoZQ0KPiA+IG1haW5saW5lIHlldC4gU28sIEkgZGVjaWRlZCB0
byByZXBseSB0byB0aGlzIHNlcmllcyBmb3IgZGlzY3Vzc2lvbiBvbg0KPiA+IGhvdyB0byBmaXgg
aXQgYmVmb3JlIHB1c2hpbmcuIEhlcmUgaXMgdGhlIGxvY2t1cCBzY2VuYXJpbyBXZQ0KPiA+IGVu
Y291bnRlcmVkOg0KPiA+IA0KPiA+IERldmljZXM6IGFybTY0IHdpdGggb25seSA4IGNvcmVzDQo+
ID4gT25lIENQVSBob2xkcyBybnAtPmxvY2sgaW4gcmN1X2R1bXBfY3B1X3N0YWNrKCkgd2hpbGUg
dHJ5aW5nIHRvIGR1bXANCj4gPiBvdGhlciBDUFVzLCBidXQgaXQgd2FpdHMgZm9yIHRoZSBjb3Jy
ZXNwb25kaW5nIENQVSB0byBkdW1wIGJhY2t0cmFjZSwNCj4gPiB3aXRoIGEgMTAtc2Vjb25kIHRp
bWVvdXQuDQo+ID4gDQo+ID4gICAgX19kZWxheSgpDQo+ID4gICAgX19jb25zdF91ZGVsYXkoKQ0K
PiA+ICAgIG5taV90cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNlKCkNCj4gPiAgICBhcmNoX3RyaWdn
ZXJfY3B1bWFza19iYWNrdHJhY2UoKQ0KPiA+ICAgIHRyaWdnZXJfc2luZ2xlX2NwdV9iYWNrdHJh
Y2UoKQ0KPiA+ICAgIGR1bXBfY3B1X3Rhc2soKQ0KPiA+ICAgIHJjdV9kdW1wX2NwdV9zdGFja3Mo
KSAgPC0gaG9sZGluZyBybnAtPmxvY2sNCj4gPiAgICBwcmludF9vdGhlcl9jcHVfc3RhbGwoKQ0K
PiA+ICAgIGNoZWNrX2NwdV9zdGFsbCgpDQo+ID4gICAgcmN1X3BlbmRpbmcoKQ0KPiA+ICAgIHJj
dV9zY2hlZF9jbG9ja19pcnEoKQ0KPiA+ICAgIHVwZGF0ZV9wcm9jZXNzX3RpbWVzKCkNCj4gPiAN
Cj4gPiBIb3dldmVyLCB0aGUgb3RoZXIgNyBDUFVzIGFyZSB3YWl0aW5nIGZvciBybnAtPmxvY2sg
b24gdGhlIHBhdGggdG8NCj4gPiByZXBvcnQgcXMuDQo+ID4gDQo+ID4gICAgcXVldWVkX3NwaW5f
bG9ja19zbG93cGF0aCgpDQo+ID4gICAgcXVldWVkX3NwaW5fbG9jaygpDQo+ID4gICAgZG9fcmF3
X3NwaW5fbG9jaygpDQo+ID4gICAgX19yYXdfc3Bpbl9sb2NrX2lycXNhdmUoKQ0KPiA+ICAgIF9y
YXdfc3Bpbl9sb2NrX2lycXNhdmUoKQ0KPiA+ICAgIHJjdV9yZXBvcnRfcXNfcmRwKCkNCj4gPiAg
ICByY3VfY2hlY2tfcXVpZXNjZW50X3N0YXRlKCkNCj4gPiAgICByY3VfY29yZSgpDQo+ID4gICAg
cmN1X2NvcmVfc2koKQ0KPiA+ICAgIGhhbmRsZV9zb2Z0aXJxcygpDQo+ID4gICAgX19kb19zb2Z0
aXJxKCkNCj4gPiAgICBfX19fZG9fc29mdGlycSgpDQo+ID4gICAgY2FsbF9vbl9pcnFfc3RhY2so
KQ0KPiA+IA0KPiA+IFNpbmNlIHRoZSBhcm02NCBhcmNoaXRlY3R1cmUgdXNlcyBJUEkgaW5zdGVh
ZCBvZiB0cnVlIE5NSSB0byBpbXBsZW1lbnQNCj4gPiBhcmNoX3RyaWdnZXJfY3B1bWFza19iYWNr
dHJhY2UoKSwgc3Bpbl9sb2NrX2lycXNhdmUgZGlzYWJsZXMNCj4gPiBpbnRlcnJ1cHRzLCB3aGlj
aCBpcyBlbm91Z2ggdG8gYmxvY2sgdGhpcyBJUEkgcmVxdWVzdC4NCj4gPiBUaGVyZWZvcmUsIGlm
IG90aGVyIENQVXMgc3RhcnQgd2FpdGluZyBmb3IgdGhlIGxvY2sgYmVmb3JlIHJlY2VpdmluZw0K
PiA+IHRoZSBJUEksIGEgc2VtaS1kZWFkbG9jayBzY2VuYXJpbyBsaWtlIHRoZSBmb2xsb3dpbmcg
b2NjdXJzOg0KPiA+IA0KPiA+IENQVTAgICAgICAgICAgICAgICAgICAgIENQVTEgICAgICAgICAg
ICAgICAgICAgIENQVTINCj4gPiAtLS0tLSAgICAgICAgICAgICAgICAgICAtLS0tLSAgICAgICAg
ICAgICAgICAgICAtLS0tLQ0KPiA+IGxvY2tfaXJxc2F2ZShybnAtPmxvY2spDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgbG9ja19pcnFzYXZlKHJucC0+bG9jaykNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICA8Y2FuJ3QgcmVjZWl2ZSBJUEk+DQo+ID4gPHNlbmQgaXBpIHRvIENQVSAx
Pg0KPiA+IDx3YWl0IENQVSAxIGZvciAxMHM+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbG9ja19pcnFzYXZlKHJucC0+bG9jaykNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FuJ3QgcmVjZWl2
ZSBJUEk+DQo+ID4gPHNlbmQgaXBpIHRvIENQVSAyPg0KPiA+IDx3YWl0IENQVSAyIGZvciAxMHM+
DQo+ID4gLi4uDQo+ID4gDQo+ID4gDQo+ID4gSW4gb3VyIHNjZW5hcmlvLCB3aXRoIDcgQ1BVcyB0
byBkdW1wLCB0aGUgbG9ja3VwIHRha2VzIG5lYXJseSA3MA0KPiA+IHNlY29uZHMsIGNhdXNpbmcg
c3Vic2VxdWVudCB1c2VmdWwgbG9ncyB0byBiZSB1bmFibGUgdG8gcHJpbnQsIGxlYWRpbmcNCj4g
PiB0byBhIHdhdGNoZG9nIHRpbWVvdXQgYW5kIHN5c3RlbSByZWJvb3QuDQo+ID4gDQo+ID4gVGhp
cyBzZXJpZXMgb2YgY2hhbmdlcyByZS1hY3F1aXJlcyB0aGUgbG9jayBhZnRlciBlYWNoIGR1bXAs
DQo+ID4gc2lnbmlmaWNhbnRseSByZWR1Y2luZyBsb2NrLWhvbGRpbmcgdGltZS4gSG93ZXZlciwg
c2luY2UgaXQgc3RpbGwgaG9sZHMNCj4gPiB0aGUgbG9jayB3aGlsZSBkdW1waW5nIENQVSBiYWNr
dHJhY2UsIHRoZXJlJ3Mgc3RpbGwgYSBjaGFuY2UgZm9yIHR3bw0KPiA+IENQVXMgdG8gd2FpdCBm
b3IgZWFjaCBvdGhlciBmb3IgMTAgc2Vjb25kcywgd2hpY2ggaXMgc3RpbGwgdG9vIGxvbmcuDQo+
ID4gU28sIEkgd291bGQgbGlrZSB0byBhc2sgaWYgaXQncyBuZWNlc3NhcnkgdG8gZHVtcCBiYWNr
dHJhY2Ugd2l0aGluIHRoZQ0KPiA+IHNwaW5sb2NrIHNlY3Rpb24/DQo+ID4gSWYgbm90LCBlc3Bl
Y2lhbGx5IG5vdyB0aGF0IGxvY2tsZXNzIGNoZWNrcyBhcmUgcG9zc2libGUsIG1heWJlIGl0IGNh
bg0KPiA+IGJlIGNoYW5nZWQgYXMgZm9sbG93cz8NCj4gPiANCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgaWYgKCEoZGF0YV9yYWNlKHJucC0+cXNtYXNrKSAmIGxlYWZfbm9kZV9jcHVfYml0KHJu
cCwgY3B1KSkpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZV9yY3Vfbm9kZShy
bnAsIGZsYWdzKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgaWYgKHJucC0+cXNtYXNrICYg
bGVhZl9ub2RlX2NwdV9iaXQocm5wLCBjcHUpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGlmIChkYXRhX3JhY2Uocm5wLT5xc21hc2spICYgbGVhZl9ub2RlX2NwdV9iaXQocm5wLCBjcHUp
KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNwdV9pc19vZmZsaW5l
KGNwdSkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIo
Ik9mZmxpbmUgQ1BVICVkIGJsb2NraW5nIGN1cnJlbnQgR1AuXG4iLCBjcHUpOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGR1bXBfY3B1X3Rhc2soY3B1KTsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmVfcmN1X25vZGUocm5wLA0K
PiA+IGZsYWdzKTsNCj4gPiANCj4gPiBPciBzaG91bGQgdGhpcyBiZSBjb25zaWRlcmVkIGFuIGFy
bTY0IGlzc3VlLCBhbmQgdGhleSBzaG91bGQgc3dpdGNoIHRvDQo+ID4gdHJ1ZSBOTUksIG90aGVy
d2lzZSwgdGhleSBzaG91bGRuJ3QgdXNlDQo+ID4gbm1pX3RyaWdnZXJfY3B1bWFza19iYWNrdHJh
Y2UoKT8NCj4gDQo+IFRoYW5rIHlvdSBmb3IgbG9va2luZyBpbnRvIHRoaXMhDQo+IA0KPiBXZSBk
byBhc3N1bWUgdGhhdCBubWlfdHJpZ2dlcl9jcHVtYXNrX2JhY2t0cmFjZSgpIHVzZXMgdHJ1ZSBO
TUlzLCBzbywNCj4geWVzLCBubWlfdHJpZ2dlcl9jcHVtYXNrX2JhY2t0cmFjZSgpIHNob3VsZCB1
c2UgdHJ1ZSBOTUlzLCBqdXN0IGxpa2UNCj4gdGhlIG5hbWUgc2F5cy4gIDstKQ0KSW4gdGhlIGNv
bW1lbnRzIG9mIGZvbGxvd2luZyBwYXRjaCwgdGhlIGFybTY0IG1haW50YWluZXJzIGhhdmUNCmRp
ZmZlcmluZyB2aWV3cyBvbiB0aGUgdXNlIG9mIG5taV90cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNl
KCkuIEknbSBhDQpiaXQgY29uZnVzZWQgYW5kIHVuc3VyZSB3aGljaCBwZXJzcGVjdGl2ZSBpcyBt
b3JlIHJlYXNvbmFibGUuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDkwNjA5
MDI0Ni52MTMuNC5JZTZjMTMyYjk2ZWJiYmNkZGJmNjk1NGI5NDY5ZWQ0MGE2OTYwMzQzY0BjaGFu
Z2VpZC8NCg0KPiAvKg0KPiAgKiBOT1RFOiB0aG91Z2ggbm1pX3RyaWdnZXJfY3B1bWFza19iYWNr
dHJhY2UoKSBoYXMgIm5taV8iIGluIHRoZQ0KbmFtZSwNCj4gICogbm90aGluZyBhYm91dCBpdCB0
cnVseSBuZWVkcyB0byBiZSBpbXBsZW1lbnRlZCB1c2luZyBhbiBOTUksIGl0J3MNCj4gICoganVz
dCB0aGF0IGl0J3MgX2FsbG93ZWRfIHRvIHdvcmsgd2l0aCBOTUlzLiBJZiBpcGlfc2hvdWxkX2Jl
X25taSgpDQo+ICAqIHJldHVybmVkIGZhbHNlIG91ciBiYWNrdHJhY2UgYXR0ZW1wdCB3aWxsIGp1
c3QgdXNlIGEgcmVndWxhciBJUEkuDQo+ICAqLw0KDQo+IEFsdGVybmF0aXZlbHksIGFybTY0IGNv
dWxkIGNvbnRpbnVlIHVzaW5nIG5taV90cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNlKCkNCj4gd2l0
aCBub3JtYWwgaW50ZXJydXB0cyAoZm9yIGV4YW1wbGUsIG9uIFNvQ3Mgbm90IGltcGxlbWVudGlu
ZyB0cnVlIE5NSXMpLA0KPiBidXQgaGF2ZSBhIHNob3J0IHRpbWVvdXQgKG1heWJlIGEgZmV3IGpp
ZmZpZXM/KSBhZnRlciB3aGljaCBpdHMgcmV0dXJucw0KPiBmYWxzZSAoYW5kIHByZXN1bWFibHkg
YWxzbyBjYW5jZWxzIHRoZSBiYWNrdHJhY2UgcmVxdWVzdCBzbyB0aGF0IHdoZW4NCj4gdGhlIG5v
bi1OTUkgaW50ZXJydXB0IGV2ZW50dWFsbHkgZG9lcyBoYXBwZW4sIGl0cyBoYW5kbGVyIHNpbXBs
eSByZXR1cm5zDQo+IHdpdGhvdXQgYmFja3RyYWNpbmcpLiAgVGhpcyBzaG91bGQgYmUgaW1wbGVt
ZW50ZWQgdXNpbmcgYXRvbWljcyB0byBhdm9pZA0KPiBkZWFkbG9jayBpc3N1ZXMuICBUaGlzIGFs
dGVybmF0aXZlIGFwcHJvYWNoIHdvdWxkIHByb3ZpZGUgYWNjdXJhdGUgYXJtNjQNCj4gYmFja3Ry
YWNlcyBpbiB0aGUgY29tbW9uIGNhc2Ugd2hlcmUgaW50ZXJydXB0cyBhcmUgZW5hYmxlZCwgYnV0
IGFsbG93DQo+IGEgZ3JhY2VmdWwgZmFsbGJhY2sgdG8gcmVtb3RlIHRyYWNpbmcgb3RoZXJ3aXNl
Lg0KPiANCj4gV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gd29ya2luZyB0aGlzIGlzc3VlLCB3
aGF0ZXZlciBzb2x1dGlvbiB0aGUNCj4gYXJtNjQgbWFpbnRhaW5lcnMgZW5kIHVwIHByZWZlcnJp
bmc/DQo+IA0KDQpUaGUgMTAtc2Vjb25kIHRpbWVvdXQgaXMgaGFyZC1jb2RlZCBpbiBubWlfdHJp
Z2dlcl9jcHVtYXNrX2JhY2t0cmFjZSgpLg0KSXQgaXMgc2hhcmVkIGNvZGUgYW5kIG5vdCBhcmNo
aXRlY3R1cmUtc3BlY2lmaWMuIEN1cnJlbnRseSwgSSBoYXZlbid0DQp0aG91Z2h0IG9mIGEgZmVh
c2libGUgc29sdXRpb24uIEkgaGF2ZSBhbHNvIENDJ2QgdGhlIGF1dGhvcnMgb2YgdGhlDQphZm9y
ZW1lbnRpb25lZCBwYXRjaCB0byBzZWUgaWYgdGhleSBoYXZlIGFueSBvdGhlciBpZGVhcy4NCg0K
UmVnYXJkaW5nIHRoZSByY3Ugc3RhbGwgd2FybmluZywgSSB0aGluayB0aGUgcHVycG9zZSBvZiBh
Y3F1aXJpbmcgYHJucC0NCj5sb2NrYCBpcyB0byBwcm90ZWN0IHRoZSBybnAtPnFzbWFzayB2YXJp
YWJsZSByYXRoZXIgdGhhbiB0byBwcm90ZWN0DQp0aGUgYGR1bXBfY3B1X3Rhc2soKWAgb3BlcmF0
aW9uLCByaWdodD8NClRoZXJlZm9yZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBjYWxsIGR1bXBfY3B1
X3Rhc2soKSB3aGlsZSBob2xkaW5nIHRoZQ0KbG9jay4NCldoZW4gaG9sZGluZyB0aGUgc3Bpbmxv
Y2ssIHdlIGNhbiBzdG9yZSB0aGUgQ1BVcyB0aGF0IG5lZWQgdG8gYmUgZHVtcGVkDQppbnRvIGEg
Y3B1bWFzaywgYW5kIHRoZW4gZHVtcCB0aGVtIGFsbCBhdCBvbmNlIGFmdGVyIHJlbGVhc2luZyB0
aGUNCmxvY2suDQpIZXJlIGlzIG15IHRlbXBvcmFyeSBzb2x1dGlvbiB1c2VkIGxvY2FsbHkgYmFz
ZWQgb24ga2VybmVsLTYuMTEuDQoNCisJY3B1bWFza192YXJfdCBtYXNrOw0KKwlib29sIG1hc2tf
b2s7DQoNCisJbWFza19vayA9IHphbGxvY19jcHVtYXNrX3ZhcigmbWFzaywgR0ZQX0FUT01JQyk7
DQoJcmN1X2Zvcl9lYWNoX2xlYWZfbm9kZShybnApIHsNCgkJcmF3X3NwaW5fbG9ja19pcnFzYXZl
X3JjdV9ub2RlKHJucCwgZmxhZ3MpOw0KCQlmb3JfZWFjaF9sZWFmX25vZGVfcG9zc2libGVfY3B1
KHJucCwgY3B1KQ0KCQkJaWYgKHJucC0+cXNtYXNrICYgbGVhZl9ub2RlX2NwdV9iaXQocm5wLCBj
cHUpKQ0Kew0KCQkJCWlmIChjcHVfaXNfb2ZmbGluZShjcHUpKQ0KCQkJCQlwcl9lcnIoIk9mZmxp
bmUgQ1BVICVkIGJsb2NraW5nDQpjdXJyZW50IEdQLlxuIiwgY3B1KTsNCisJCQkJZWxzZSBpZiAo
bWFza19vaykNCisJCQkJCWNwdW1hc2tfc2V0X2NwdShjcHUsIG1hc2spOw0KCQkJCWVsc2UNCgkJ
CQkJZHVtcF9jcHVfdGFzayhjcHUpOw0KCQkJfQ0KCQlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCgl9DQorCWlmIChtYXNrX29rKSB7DQorCQlpZiAoIXRy
aWdnZXJfY3B1bWFza19iYWNrdHJhY2UobWFzaykpIHsNCisJCQlmb3JfZWFjaF9jcHUoY3B1LCBt
YXNrKQ0KKwkJCQlkdW1wX2NwdV90YXNrKGNwdSk7DQorCQl9DQorCQlmcmVlX2NwdW1hc2tfdmFy
KG1hc2spOw0KKwl9DQoNCkFmdGVyIGFwcGx5aW5nIHRoaXMsIEkgaGF2ZW4ndCBlbmNvdW50ZXJl
ZCB0aGUgbG9ja3VwIGlzc3VlIGZvciBmaXZlDQpkYXlzLCB3aGVyZWFzIGl0IHVzZWQgdG8gb2Nj
dXIgYWJvdXQgb25jZSBhIGRheS4NCg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQo=

Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14114153BF8;
	Fri,  1 Nov 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446899; cv=fail; b=XdwFwwBz2R/tUFJtzUf5EWIa4AVY4d5Gps7RdMvwmE1PrqDBO7IbeeD2zixTvqrHnajMmKGjT2t1MZbEZTareOCIJXDGDj318/A0gwRh8WXHk3qXjWF02ydTcaY5GnQJD63giKLS+ZtlSXX/R1SOfLgaXP9RWd4+dh0abSBgfY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446899; c=relaxed/simple;
	bh=Dz2hMsnJ6n18fl8fkCWeZDsSmWdwwhOGWynJhOTiL58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhvgPvseAerpXtV0uCZnIeBh05lWSLpSpR3wYkQUo0ndj+CbxCFTMmy71+VKbK7dtDuCPw7N0cIzWmeh+Eoy7HYdCvC8c0bbbO+XL6gRIgVXB8g0/DWVh/HOLLccXo4SSP8T2hrkOHB3U1oMIEgU3GzIfumO1qhNMhFgwuM9iC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cP9oZooD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JxNqhVEX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cP9oZooD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JxNqhVEX"
X-UUID: b5d048ce982411efb88477ffae1fc7a5-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Dz2hMsnJ6n18fl8fkCWeZDsSmWdwwhOGWynJhOTiL58=;
	b=cP9oZooDUK6+sK48656saOTTE0NAFAFhc0SZtCM+R/UmTZCyFlPAooPdlesfC2n5pm2pvaW9waAs1kxeuBGaA3ABReUtKM4lDxzJJxI7iRS6gnzUyewGYN3LA1glMRhR8tFR2MeeViRV2X7W7LaxN+0yqAsMuZ//fJLOUBWrHGA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:c951d232-c6b5-4aef-aee8-14deec6994ad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:48126107-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5d048ce982411efb88477ffae1fc7a5-20241101
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 957602810; Fri, 01 Nov 2024 15:41:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 15:41:29 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 15:41:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6nhOfIy/oshdo+ZiQ2Xfzp4GPVa0hu0frWi8zab+uQu5GR0E3gyFwN7YkdD23MSF1coINP4gweM+MYPR7ZpQ7DI314Df8/2r0wh5MKInTTl627kR42osmEwF6hBLyJK+GTmyjiXQeIWh4uGG2ZAYgaUjsxs7YHB4M/KnuV9HkPXdyVAs7MsN0yKP01HeKeHsIW2Va58TXvHSUi+LH0HwNRjEF4gww5wYbFd6tTg/qbNPZih76eHYs1LL8Im8e9f0aJWXx5/PCTQOd3dco8eDZ0paaqAmKmWKeGBgbqD6c/6P4Ccq4DysZ13Ge3H0+IK82dRgJhp+cBNDoapIRhDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz2hMsnJ6n18fl8fkCWeZDsSmWdwwhOGWynJhOTiL58=;
 b=i3/6yZT0dz1H4c8WAkfLII0A3m9xG2c0KPbGWMovJ54acAX1MFbJ2NJFUj50Mw2kcBM6z+Su+GXRY5uNM8/Cyu/qbc71N0h9hNySFRwqzusC6LIZveGzOUqVgq7oMwO6P5h5YhKn+c7dDKu/R4T4MY3nRcub+Ka4N2AStBrvV/H7qPz6brrPXGT3CEftkyEjx9ke/MdYoPOKlNIDpfSodR2Wed3mSXx0cm69pVVay2PVIvWqOXcuvx+9uk1r9rdOnV1qoeJB+27mbmBl4834iOIWTLw5uDJaHheclpNEhGxvQGGpqjT3jobmHAwOrvpjzaUDe/WCbJcchat4grEukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz2hMsnJ6n18fl8fkCWeZDsSmWdwwhOGWynJhOTiL58=;
 b=JxNqhVEXlvsXN+xZsDhtjeXRnje42A3PSBFqYY1pwe9jMLI7m7DCi2goU22GOrkTJIL3nTtG5PBMqlICDGX3EpnYp46x6DfjoWyU05PQa/y123l4YUxP+5EKL9phItdLMCt9TStv8RHooCpqH8VjoxId4OEnRUdX8ywwhR+7mR8=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 SEYPR03MB8499.apcprd03.prod.outlook.com (2603:1096:101:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 07:41:27 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40%5]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 07:41:27 +0000
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
Thread-Index: AQHbKZuQD0a1bmt83kGqJ5+0CTWhuLKc/yAAgADtCYCAAWdPIoACvDoA
Date: Fri, 1 Nov 2024 07:41:27 +0000
Message-ID: <00ace254f9085aad12684185b77504bd911aed63.camel@mediatek.com>
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
	 <20241016161931.478592-3-paulmck@kernel.org>
	 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
	 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
	 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
	 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
	 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
In-Reply-To: <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|SEYPR03MB8499:EE_
x-ms-office365-filtering-correlation-id: 1748b2c2-bb7b-419a-ba4c-08dcfa4897d2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eTgxVEc3VmxnMmxHbHBsT1Y4U0lleEdQSzhvZExOY1FFcVk4clliWWEremE0?=
 =?utf-8?B?Y2VBb1pCQnc5VzJHMkZHMW5OL3h5cHFOQ3VDRzUySDdkdFR0N2xwRnF6VzVu?=
 =?utf-8?B?SDhZTHJzcnV6RGxvemF4elhxZDZYOS9YMjBvLzZHSkllQjIvK0pyZ2VwSXJi?=
 =?utf-8?B?WFZMYVAvVGIzd0RIcUdZTmJsaUJ1RXB2K1ZvdXJzcXBaRFora0FkdG5TNTU5?=
 =?utf-8?B?K1NNZEszTTlXZ3JVU3E5bHN5OHNWOTdTdlk1UmR1SVhIaEphaTNyOWV2aFFM?=
 =?utf-8?B?SjBzSTVvSHdRRVlwMW1JTzcyOXdYY3J4cytMbXVUWmNEUkRhVTFxcG8yQ2Fi?=
 =?utf-8?B?YlRHTUQ4SzNyOUdpcERlcCs1U0tBd0F6RTZqclhKK0hqZVcyR2hJekRwUlBU?=
 =?utf-8?B?NUFqWlFwczBvdjF1eVJ4T214VVBJaEV6ZTNpTVFKcExsWEwzRDZhNzFZN0NE?=
 =?utf-8?B?OUlEVkhBR0pnNlM5UUkxc3hwSktyMHlKR0hSMi9BclU5QUFmbEZyVGFoTkRT?=
 =?utf-8?B?M0ZFcG0rV2FXUDlzdlNWNzdUYXJ0RUNWOWU2NHhjWENDU3cvbUxzUmRFZ2RO?=
 =?utf-8?B?ZlJYbFhTMkVwMVBhNzZVV1V4MGw5VEtNR1RlcHlkOExqQitoVUF6N3VFUVdv?=
 =?utf-8?B?VWYxNDd6dGZ4V0JMNFlYRzliMFdiNkltL1NMSGtCbnNNb1VvZ2RnWkppTE5N?=
 =?utf-8?B?WkIvVjdESkJyYVVURXFnZ0RFbGZ1NW5vcDFYWUs3TTNQN21zc29qd0Z3VGlt?=
 =?utf-8?B?aU9PL0dxM0ZlQ3VBcC8xRVR4VDNHMTMzbGFaRVpPekZwL08ySVhZbWl1MDdv?=
 =?utf-8?B?MFp4S1M3VHQrcVc0Tndxa0hmVE83cEJTQ0ZtNVcvbFhTc2pDaXpqa2hhMVBN?=
 =?utf-8?B?N2xubmhRY2x2eENUTy9xMmJIQVludk9pOWV4bDR5ckRsVFJPdmVucE1sa1dB?=
 =?utf-8?B?d3YxTDNzaWhNampGR25iU0gzNFFZRXMrQTEySW1uYUNkMnZMOWs2TW5yMWVa?=
 =?utf-8?B?Mk8zTGtUOW1nbkYwc1JnNkNpKzhTSGhvczA1MXZVMWQxU2dyL1pYcDA0VnN1?=
 =?utf-8?B?cUFaWlhUYmREbEJsQndlZG5uNjVmcGNTK0N4RHJnL2oyZzhJbER1OGcrOTNY?=
 =?utf-8?B?UklmMDRucmtOMkp1TkJhdEVNY3ZYU0lDRVN1L0JGU2g5LzNvL2FXcVIvbDhu?=
 =?utf-8?B?YkxFQlFLN25OYnVtRUNzekROOFA2MDYvcXRCNDFybTgvV0d6dGNON2ZGKzBw?=
 =?utf-8?B?YVVyaUU1SkE1cmp5M3VFZFEwTUx5djR5K0Z3VEwydTVrdkVtME14clRsSzh0?=
 =?utf-8?B?WlBkbVRFblE2NHcyVjZkUGg0bzRCaUJ0K1hheFd2US94dTBvNEZ0RlhIN25v?=
 =?utf-8?B?bUtzVUE2bUNseEZyL1lTVkducGNQTmFmNnN4MEhkK01YVjNLQlE0dDJLVHNW?=
 =?utf-8?B?ODRrQUQvRk55dnRjbG92YjhHeElib0xEaSs2M2hIQk93Z2RoR2pjemc1N0Ra?=
 =?utf-8?B?cmlUYTVsbFh6UE5xalBUelJmZ01LMUc1TnlCSXdzK1ViZWE1QjRvZWo3SFd0?=
 =?utf-8?B?VmNXZVhxVDBFWGxmeVBlNWVSblJUNFZrRjJzQXZEN0xxSHF0blpvNUpVV3Rw?=
 =?utf-8?B?em1YeE96SE5VaEtMUVZsK3QzczkwcFhYS3dCamtpclpiMzFrc2hQbDhJbzVV?=
 =?utf-8?B?NVdISkdZVDU5ZEhPWjlMdjBlMXZqUXNWVnZrY2ZCT2c5SVQ1R0pZNzJSYVlz?=
 =?utf-8?B?clBreTAycEN0UGpLbllyaW5adHMxMkxlL2MvSnZUUU5kRG5hdVduVDIxRkhz?=
 =?utf-8?Q?oP0fLshKTeI8MR8vtCo9Kq7qXs6TWuVtOOaKw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG1PWk5zZHpIMWhveVF4WWR0cGQyWUo3YWYyLzBqcVloWmpDWU9xQ1RRRWMr?=
 =?utf-8?B?Qi9Wd3J4NmVOeGxyZzVZbFA2ZTlvcDlKSVBzVWQ0Ny9Ub2NEOE5uUUhzd0R0?=
 =?utf-8?B?alRBb2RhMENVdUxRK1Q1bUE3cEJCVW5BK1hLajQxYTRmMWZIVlAzNDJ3TUxy?=
 =?utf-8?B?dkw2K1M0K0YyakxtbGJ6M1dWeThLUE5oYnVkZ0NqUzA3OCtjNTJheEhDZWt1?=
 =?utf-8?B?dWRrMkdqclA4WFl0MlFwS2R5bzhSeGkyazdwMFEraUdsd1hOTFdIQWlXUEFn?=
 =?utf-8?B?N1EzV0Ryb0hCeEthQWYrK1hJQXJMTUJvYjF2N0xFLzJDTmd2ZlFqU1E3QXZR?=
 =?utf-8?B?eVZPbm5xbXRnRFlPRXRIUFlnSjBVSDUrVVRRVkRKQktyQzhaZ1lnOG5tUkVK?=
 =?utf-8?B?MDYxbUQ4TDg5NWxpOUh2ZjJadldPQXdMdWtCRXpka0k5VjRMUzhHT0hjaHVm?=
 =?utf-8?B?ODI2Y2xJN2FIL3NiT3JZQXFzaU5IcXJaaEpNbW1aMCszNUlYbkRXem5TclJq?=
 =?utf-8?B?cHRoMlprTmZtbE9makNaa014TUlxZzhCajgwTVJyY0tUNGgrRmdGc2oyUVlP?=
 =?utf-8?B?ckVqMmxtdlFJMHJ4Qkg5R24yeHRGVEJpUWU0VGtyenQ1VmJ0a1FmNkVKK2dZ?=
 =?utf-8?B?WVVXbGkzWUw3VUl1Uml3RWZ5OGNBMDBIaTJqVE0wTzY0eVl2NityWDRkdVYz?=
 =?utf-8?B?elFyVXpCOEhiZ0JmWUJXZWx2QWZxbXlQM2MxZUxBNC9MMXBmSzVGK2N6R1ox?=
 =?utf-8?B?NFZRL2FsOFRpU1RvMm1tV2orNVlFa2RnRXZ4UFJUK1V4dHA2RTA1UVRQbUk4?=
 =?utf-8?B?Slpxc1dWV1ZiQ0JQdEVoc0t3MXBtelZNRG9VVzFhVU8yYmRLWjIxd0xkWWVM?=
 =?utf-8?B?elpwcE56Rit6V3k1MmhaT1ZiUjFYWGdWd2FVVXJyRVpVNkJORjRkbHlGZHRN?=
 =?utf-8?B?WnF3cldUNXZZTU4wRENHaW5XcTNBWm5pZ1ZiTkRVeDVBQlhaSDlhYWhZdXVG?=
 =?utf-8?B?MlFDZnRzV1FDVW9RREdPa1ZROHRlclN1V2pqdVcwN29GTEQvVXNLTnl6L0xo?=
 =?utf-8?B?a29VMUhscUxyYUxEK0FXbjN0bFpaYS9mWFByNHM1SzhkS0puZmNKVlhXb0hQ?=
 =?utf-8?B?R3YvRElKYXZJL2N4dXNMMEswT2F2b3NDak1rS3hIYU51UHpLU0sxMDJEelFn?=
 =?utf-8?B?YThVelcrbk1QcUpxNTRuWjJ0RjQyL1VCYlpIQ3hnT1RoRlJzQ3cycXNRdTNp?=
 =?utf-8?B?OW5ZVzBEcXJuN1ZEbHpkVUpVcmRzUk9PajhJL1lEanRnQWFTM1lsbVdycU92?=
 =?utf-8?B?ZzlpY2JZakFxWWZOSDZ3MXhmcHIrQmpDNFpxMXY4Sk9RanF2eUFyYmFyQWNP?=
 =?utf-8?B?a2NaMnc0dTA1cUMwMVBlVkdrSVgrdFN0ZUhqVTlFb29aZmtzWWpPNzYxbXBp?=
 =?utf-8?B?emlmdDJiSUpVOGhjL2JldW1EckhrdHRFVjNodnY0dDZPdloySVFMTWg0K1Ar?=
 =?utf-8?B?UFRPMTdzMmJDeW5rMG9hcTJaYUQ0WWhjV0MyazNhZStEclA0cGhyWGNvbDhW?=
 =?utf-8?B?ejVDS3JwbVBPcEwvL2o1RDVHU0YwMzBDcGdmL0h5M0NQVDA2UW05V0VpeE42?=
 =?utf-8?B?UzM0MUN4Qm01MWNNZFk2US9Cd1NZUUlJMGpXa2xTZjZnZ0l5OG1TVzd2YzNt?=
 =?utf-8?B?ekZJODJHdG1jZmpPak45K3M4UGd1cmFsbVN6Yyt0ekpyMXMxNklpTzhCMGxk?=
 =?utf-8?B?NmlhZ2lZZ0pTSWRKTXpEdUtOalRCOWFjUE9penVZRDNTWDc2TU1BT29ZaU9T?=
 =?utf-8?B?YkVvdXQxK2ZLZEpyN1YwS0dpcDhRdnh1cjNiYWNQeWVIQVZPVlUwVUtsVE5H?=
 =?utf-8?B?Z1RqQVI0MzZiUkRkUVg0eFFKdHpJVUpvK2NremNoVStpcmVneVhKcVFnZEI4?=
 =?utf-8?B?amdhVGNtM29oZndUSlZmblFRbnFaRjlud0JjRDRTSXdHYW1lMzNQMTRNWURz?=
 =?utf-8?B?UjlEa09WemxLb1FSQmcwbUVqMVgxTEhEejZtbi9rdVQ5SDl4VEdlSW9Hd0VH?=
 =?utf-8?B?ZTg3aE1EKzRaNm82NDlsQ09mbWZWQzhhd0NGYlBJTFpwNFlKZnpJc0xwVkJG?=
 =?utf-8?B?TlVXbk1OY2dUdVhmSjNzL0xOdjBNYmxtT2dtemY3ZWcvZmxjUjhhOXdqb1Bq?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E831BF90733244AE1C5F6C860E3751@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748b2c2-bb7b-419a-ba4c-08dcfa4897d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:41:27.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipVk2Chpfvwf+H4zO7KnA8LlhFLu0ouIWooaiozxQz8INrYc1Awp7hCea+6PlUzZhxeX3u+VUPmfy6ak3VGu/el7ArOXVO51B0i8UK9/CeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8499

T24gV2VkLCAyMDI0LTEwLTMwIGF0IDA2OjU0IC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiA+ID4gQWx0ZXJuYXRpdmVseSwgYXJtNjQgY291bGQgY29udGludWUgdXNpbmcgbm1pX3Ry
aWdnZXJfY3B1bWFza19iYWNrdHJhY2UoKQ0KPiA+ID4gd2l0aCBub3JtYWwgaW50ZXJydXB0cyAo
Zm9yIGV4YW1wbGUsIG9uIFNvQ3Mgbm90IGltcGxlbWVudGluZyB0cnVlIE5NSXMpLA0KPiA+ID4g
YnV0IGhhdmUgYSBzaG9ydCB0aW1lb3V0IChtYXliZSBhIGZldyBqaWZmaWVzPykgYWZ0ZXIgd2hp
Y2ggaXRzIHJldHVybnMNCj4gPiA+IGZhbHNlIChhbmQgcHJlc3VtYWJseSBhbHNvIGNhbmNlbHMg
dGhlIGJhY2t0cmFjZSByZXF1ZXN0IHNvIHRoYXQgd2hlbg0KPiA+ID4gdGhlIG5vbi1OTUkgaW50
ZXJydXB0IGV2ZW50dWFsbHkgZG9lcyBoYXBwZW4sIGl0cyBoYW5kbGVyIHNpbXBseSByZXR1cm5z
DQo+ID4gPiB3aXRob3V0IGJhY2t0cmFjaW5nKS4gIFRoaXMgc2hvdWxkIGJlIGltcGxlbWVudGVk
IHVzaW5nIGF0b21pY3MgdG8gYXZvaWQNCj4gPiA+IGRlYWRsb2NrIGlzc3Vlcy4gIFRoaXMgYWx0
ZXJuYXRpdmUgYXBwcm9hY2ggd291bGQgcHJvdmlkZSBhY2N1cmF0ZSBhcm02NA0KPiA+ID4gYmFj
a3RyYWNlcyBpbiB0aGUgY29tbW9uIGNhc2Ugd2hlcmUgaW50ZXJydXB0cyBhcmUgZW5hYmxlZCwg
YnV0IGFsbG93DQo+ID4gPiBhIGdyYWNlZnVsIGZhbGxiYWNrIHRvIHJlbW90ZSB0cmFjaW5nIG90
aGVyd2lzZS4NCj4gPiA+IA0KPiA+ID4gV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gd29ya2lu
ZyB0aGlzIGlzc3VlLCB3aGF0ZXZlciBzb2x1dGlvbiB0aGUNCj4gPiA+IGFybTY0IG1haW50YWlu
ZXJzIGVuZCB1cCBwcmVmZXJyaW5nPw0KPiA+IA0KPiA+IFRoZSAxMC1zZWNvbmQgdGltZW91dCBp
cyBoYXJkLWNvZGVkIGluIG5taV90cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNlKCkuDQo+ID4gSXQg
aXMgc2hhcmVkIGNvZGUgYW5kIG5vdCBhcmNoaXRlY3R1cmUtc3BlY2lmaWMuIEN1cnJlbnRseSwg
SSBoYXZlbid0DQo+ID4gdGhvdWdodCBvZiBhIGZlYXNpYmxlIHNvbHV0aW9uLiBJIGhhdmUgYWxz
byBDQydkIHRoZSBhdXRob3JzIG9mIHRoZQ0KPiA+IGFmb3JlbWVudGlvbmVkIHBhdGNoIHRvIHNl
ZSBpZiB0aGV5IGhhdmUgYW55IG90aGVyIGlkZWFzLg0KPiANCj4gSXQgc2hvdWxkIGJlIHBvc3Np
YmxlIGZvciBhcm02NCB0byBoYXZlIGFuIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBob29rDQo+IHRo
YXQgZW5hYmxlcyB0aGVtIHRvIHVzZSBhIG11Y2ggc2hvcnRlciB0aW1lb3V0LiAgT3IsIHRvIGV2
ZW50dWFsbHkNCj4gc3dpdGNoIHRvIHJlYWwgTk1Jcy4NCg0KVGhlcmUgaXMgYWxyZWFkeSBhbm90
aGVyIHRocmVhZCBkaXNjdXNzaW5nIHRoZSB0aW1lb3V0IGlzc3VlLCBidXQgSQ0Kc3RpbGwgaGF2
ZSBzb21lIHF1ZXN0aW9ucyBhYm91dCBSQ1UuIFRvIGF2b2lkIG1peGluZyB0aGUgZGlzY3Vzc2lv
bnMsIEkNCnN0YXJ0IHRoaXMgc2VwYXJhdGUgdGhyZWFkIHRvIGRpc2N1c3MgUkNVLg0KDQo+ID4g
UmVnYXJkaW5nIHRoZSByY3Ugc3RhbGwgd2FybmluZywgSSB0aGluayB0aGUgcHVycG9zZSBvZiBh
Y3F1aXJpbmcgYHJucC0NCj4gPiA+IGxvY2tgIGlzIHRvIHByb3RlY3QgdGhlIHJucC0+cXNtYXNr
IHZhcmlhYmxlIHJhdGhlciB0aGFuIHRvIHByb3RlY3QNCj4gPiANCj4gPiB0aGUgYGR1bXBfY3B1
X3Rhc2soKWAgb3BlcmF0aW9uLCByaWdodD8NCj4gDQo+IEFzIG5vdGVkIGJlbG93LCBpdCBpcyBh
bHNvIHRvIHByZXZlbnQgZmFsc2UtcG9zaXRpdmUgc3RhY2sgZHVtcHMuDQo+IA0KPiA+IFRoZXJl
Zm9yZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBjYWxsIGR1bXBfY3B1X3Rhc2soKSB3aGlsZSBob2xk
aW5nIHRoZQ0KPiA+IGxvY2suDQo+ID4gV2hlbiBob2xkaW5nIHRoZSBzcGlubG9jaywgd2UgY2Fu
IHN0b3JlIHRoZSBDUFVzIHRoYXQgbmVlZCB0byBiZSBkdW1wZWQNCj4gPiBpbnRvIGEgY3B1bWFz
aywgYW5kIHRoZW4gZHVtcCB0aGVtIGFsbCBhdCBvbmNlIGFmdGVyIHJlbGVhc2luZyB0aGUNCj4g
PiBsb2NrLg0KPiA+IEhlcmUgaXMgbXkgdGVtcG9yYXJ5IHNvbHV0aW9uIHVzZWQgbG9jYWxseSBi
YXNlZCBvbiBrZXJuZWwtNi4xMS4NCj4gPiANCj4gPiArICAgICBjcHVtYXNrX3Zhcl90IG1hc2s7
DQo+ID4gKyAgICAgYm9vbCBtYXNrX29rOw0KPiA+IA0KPiA+ICsgICAgIG1hc2tfb2sgPSB6YWxs
b2NfY3B1bWFza192YXIoJm1hc2ssIEdGUF9BVE9NSUMpOw0KPiA+ICAgICAgIHJjdV9mb3JfZWFj
aF9sZWFmX25vZGUocm5wKSB7DQo+ID4gICAgICAgICAgICAgICByYXdfc3Bpbl9sb2NrX2lycXNh
dmVfcmN1X25vZGUocm5wLCBmbGFncyk7DQo+ID4gICAgICAgICAgICAgICBmb3JfZWFjaF9sZWFm
X25vZGVfcG9zc2libGVfY3B1KHJucCwgY3B1KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBp
ZiAocm5wLT5xc21hc2sgJiBsZWFmX25vZGVfY3B1X2JpdChybnAsIGNwdSkpDQo+ID4gew0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChjcHVfaXNfb2ZmbGluZShjcHUpKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJPZmZsaW5l
IENQVSAlZCBibG9ja2luZw0KPiA+IGN1cnJlbnQgR1AuXG4iLCBjcHUpOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKG1hc2tfb2spDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVtYXNrX3NldF9jcHUoY3B1LCBtYXNrKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkdW1wX2NwdV90YXNrKGNwdSk7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgIHJhd19zcGluX3VubG9ja19pcnFyZXN0
b3JlX3JjdV9ub2RlKHJucCwgZmxhZ3MpOw0KPiA+ICAgICAgIH0NCj4gPiArICAgICBpZiAobWFz
a19vaykgew0KPiA+ICsgICAgICAgICAgICAgaWYgKCF0cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNl
KG1hc2spKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGZvcl9lYWNoX2NwdShjcHUsIG1h
c2spDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHVtcF9jcHVfdGFzayhjcHUp
Ow0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgZnJlZV9jcHVtYXNrX3Zh
cihtYXNrKTsNCj4gPiArICAgICB9DQo+ID4gDQo+ID4gQWZ0ZXIgYXBwbHlpbmcgdGhpcywgSSBo
YXZlbid0IGVuY291bnRlcmVkIHRoZSBsb2NrdXAgaXNzdWUgZm9yIGZpdmUNCj4gPiBkYXlzLCB3
aGVyZWFzIGl0IHVzZWQgdG8gb2NjdXIgYWJvdXQgb25jZSBhIGRheS4NCj4gDQo+IFdlIHVzZWQg
dG8gZG8gaXQgdGhpcyB3YXksIGFuZCB0aGUgcmVhc29uIHRoYXQgd2UgY2hhbmdlZCB3YXMgdG8g
YXZvaWQNCj4gZmFsc2UtcG9zaXRpdmUgKGFuZCB2ZXJ5IGNvbmZ1c2luZykgc3RhY2sgZHVtcHMg
aW4gdGhlIHN1cnByaXNpbmdseQ0KPiBjb21tb24gY2FzZSB3aGVyZSB0aGUgYWN0IG9mIGR1bXBp
bmcgdGhlIGZpcnN0IHN0YWNrIGNhdXNlZCB0aGUgc3RhbGxlZA0KPiBncmFjZSBwZXJpb2QgdG8g
ZW5kLg0KPiANCj4gU28gc29ycnksIGJ1dCB3ZSByZWFsbHkgY2Fubm90IGdvIGJhY2sgdG8gZG9p
bmcgaXQgdGhhdCB3YXkuDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQoNCkxldCBtZSBjbGFyaWZ5LCB0aGUg
cmVhc29uIGZvciB0aGUgaXNzdWUgbWVudGlvbmVkIGFib3ZlIGlzIHRoYXQgaXQNCnByZS1kZXRl
cm1pbmVzIGFsbCB0aGUgQ1BVcyB0byBiZSBkdW1wZWQgYmVmb3JlIHN0YXJ0aW5nIHRoZSBkdW1w
DQpwcm9jZXNzLiBUaGVuLCBkdW1waW5nIHRoZSBmaXJzdCBzdGFjayBjYXVzZWQgdGhlIHN0YWxs
ZWQgZ3JhY2UgcGVyaW9kDQp0byBlbmQuIFN1YnNlcXVlbnRseSwgbWFueSBDUFVzIHRoYXQgZG8g
bm90IG5lZWQgdG8gYmUgZHVtcGVkIChmYWxzZQ0KcG9zaXRpdmVzKSBhcmUgZHVtcGVkLg0KDQpT
byx0byBwcmV2ZW50IGZhbHNlIHBvc2l0aXZlcywgaXQgc2hvdWxkIGJlIGFib3V0IGV4Y2x1ZGlu
ZyB0aG9zZSBDUFVzDQp0aGF0IGRvIG5vdCB0byBiZSBkdW1wZWQsIHJpZ2h0PyBUaGVyZWZvcmUs
IHRoZSBhY3Rpb24gdGhhdCB0cnVsbHkgaGVscA0KaXMgYWN0dWFsbHkgInJlbGVhc2luZyB0aGUg
bG9jayBhZnRlciBlYWNoIGR1bXAgKGFsbG93aW5nIG90aGVyIENQVXMgdG8NCnVwZGF0ZSBxc21h
c2spIGFuZCByZWNoZWNraW5nIChncF9zZXEgYW5kIHFzbWFzaykgdG8gY29uZmlybSB3aGV0aGVy
IHRvDQpjb250aW51ZSBkdW1waW5nIi4NCg0KSSB0aGluayBob2xkaW5nIHRoZSBsb2NrIHdoaWxl
IGR1bXBpbmcgQ1BVcyBkb2VzIG5vdCBoZWxwIHByZXZlbnQgZmFsc2UNCnBvc2l0aXZlczsgaXQg
b25seSBibG9ja3MgdGhvc2UgQ1BVcyB3YWl0aW5nIGZvciB0aGUgbG9jayAoZS5nLiwgQ1BVcw0K
YWJvdWx0IHRvIHJlcG9ydCBxcykuIEZvciBDUFVzIHRoYXQgZG8gbm90IGludGVyYWN0IHdpdGgg
dGhpcyBsb2NrLA0KaG9sZGluZyBpdCBzaG91bGQgbm90IGhhdmUgYW55IGltcGFjdC4gRGlkIEkg
bWlzcyBhbnl0aGluZz8NCg0KLUNoZW5nLUp1aQ0K

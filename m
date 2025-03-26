Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570564A05;
	Wed, 26 Mar 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968013; cv=fail; b=kDgSFTLx7Kvff63TKKqtxaIDEryCpyZAO2y+OqmKAPZiK1KVmjKc5jlC8wxyaPdfYQIplzFoswwcKeIpKlhxYLGA1OcnQykIw3VEZQfynmRBBvjzSSMp52hJ3aorRMvccuwinnPQRA3svJ4gj3gts/qx+GPRjhFl75ep0MkDzw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968013; c=relaxed/simple;
	bh=YfX+vyUPAc0xa5spI2P64jErZ9iuvD1cT0clMYDwUI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hi1rW2LZJ/YesSkt9Ir00Ygb4skchKmqQ9YZOUmXdZaKWv6GEKHKUC3b5SKNQyZQ4gV2NWUeYBDQj4nlnCcB7S5OqWdesiwkiQry1/WJkRE93rUsM5ChGteVLhX2fisgibr9H8Kfr96NH5mCoq4Vy1RF354kFgE4O+QtSwJzpvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MjkPD2u2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=du4lTyqz; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MjkPD2u2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="du4lTyqz"
X-UUID: b1e1297e0a0511f08eb9c36241bbb6fb-20250326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YfX+vyUPAc0xa5spI2P64jErZ9iuvD1cT0clMYDwUI0=;
	b=MjkPD2u28oH32unBo7LqY3q6P0nPKabe+Q7T1Wd2e+vqAAuIhBQLiiPTNJ4EYYegSOE0pkah8l9tsgnl0aIoJnaxC0v/jrA8vIfKsMrJZecSY5rumR+WYePX4A1cxUM9R8PXiDUgXUtoTVSzkQiR8aZeJP1DY1WjNmt8byDuKXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:da9b69ea-7b80-4877-8fcc-bdc362acdefe,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:1d66934a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1e1297e0a0511f08eb9c36241bbb6fb-20250326
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <walter.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 98040075; Wed, 26 Mar 2025 13:46:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 26 Mar 2025 13:46:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 26 Mar 2025 13:46:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPiXkgjqBP6uErNS5BP2LV/7ezXYzI2vyV/LuLx6d52V/EqgLfemNTsL9kHGZL5ZmBuQsWAMuZFDeEACbEd1YpKGMehoceu8Z203RCD8vd0+blTeLuV4W2GrhH03oh7XcZaN0C9FO2OOWDZ7pvJ1vxqCVElJPZD8G0OQPoThjfzRPP2cfJiSO0PHdym8BafNQSllZkBWfjWPMFIV0eJqJhpfWikeOpjg97u05DUYnbriED6pAGb4WzwBqPOTgFpNQ9s+mPr9eLaUokDoSnJ66M72XIye0THDyWloP4hQASMdyiAUt1E43OK7k0CBsqjz3n03fjULW4H5skeATcA61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfX+vyUPAc0xa5spI2P64jErZ9iuvD1cT0clMYDwUI0=;
 b=sB/yESX3MyfhNFIU5bEMqKSiJ1MvroTKmZcvKqULIqYlEbMGZWW9dPrqo2/y233V1uykvRKjTzK+Ww0XKi2MmOfZYMhEf9ZYiW3Jg/E48H0iVTlBCnAksC2gL/4vMWARxT4jGGUbu8c+9n/0NVGEgv17QDdxGUlixRatZy5uUSFZpMkpPnh9G7qPj7ah3edTxGluQDLV+OhZnoGvDp0uLxCLWirxScHp9XxqA1m8KNX+ESsyVM8uTBB3l3JhKnz5IXFNuFds7h8ij27gL9+514tetaWzpYRHB1TO85IBQmCH4wnPEkAhKF11isnoNv+u46UzAV27RZNkhPUt+6d4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfX+vyUPAc0xa5spI2P64jErZ9iuvD1cT0clMYDwUI0=;
 b=du4lTyqz21JQU6UO55HEbTa0PtNUJi0Ge4spkYKfAsOj/QdFKW95HcuSreq2vLZ72y3cVqVM12wwwaGxDUBEsIdy+3l01QEujh8oiF4N67DTMCL56TacdLVy7cAYZUk8Pqd8PVbui/9bum8zqhhdDpuyRmT+brRC7uOvNzcVXFQ=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by KL1PR03MB7174.apcprd03.prod.outlook.com (2603:1096:820:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 05:46:38 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::fefa:d109:856a:6715]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::fefa:d109:856a:6715%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 05:46:38 +0000
From: =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= <Walter.Chang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>
CC: "joel@joelfernandes.org" <joel@joelfernandes.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "vlad.wing@gmail.com" <vlad.wing@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	=?utf-8?B?QWxleCBIb2ggKOizgOaMr+WdpCk=?= <Alex.Hoh@mediatek.com>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "neeraj.upadhyay@amd.com"
	<neeraj.upadhyay@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"leitao@debian.org" <leitao@debian.org>, "urezki@gmail.com"
	<urezki@gmail.com>, =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?=
	<Freddy.Hsin@mediatek.com>, "qiang.zhang1211@gmail.com"
	<qiang.zhang1211@gmail.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?WGluZ2h1YSBZYW5nICjmnajlhbTljY4p?= <Xinghua.Yang@mediatek.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Topic: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Index: AQHbngICuuWmYWEDFUWN1ec8w5afx7OE6NyA
Date: Wed, 26 Mar 2025 05:46:38 +0000
Message-ID: <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>
References: <20250117232433.24027-1-frederic@kernel.org>
	 <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
In-Reply-To: <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|KL1PR03MB7174:EE_
x-ms-office365-filtering-correlation-id: edefcb60-7427-43d6-66a4-08dd6c2993b0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a3hmTTFvR3RYNEJIckR6VG9oT0xkYWJKZmhhZTBJZHc0ZkNrWXlyNW5uTXUr?=
 =?utf-8?B?NzlPSEZTTUJJWjNhMlR4YStVenRmV1BjYTg5dVZYZ2tTTFppKzcxZk54WWFX?=
 =?utf-8?B?SUxqM255RE85Z1ZEeGFjZFJCRysrRDV3K3JSb1FjMlF5NGswZzVNQWQ3Tytr?=
 =?utf-8?B?QTdHa1JXbldmNnplNVFLNUxlQ3JRWmlyUUVDWVcxcG11SnloMS9FNFN5akJF?=
 =?utf-8?B?ejltWFJGVTRUcno2bkVQOXFoOVBxUC85WWZDSXBzRHR0ZjI4YURQVjdHWncv?=
 =?utf-8?B?TTFqVjA5emcwSHkyb2dCWkFzUWpyNDZLakIvTXJRb081Qy80bFFweHRxZjZK?=
 =?utf-8?B?Mm1uVkRpaEs2N0lEQkRqMjcwUi96UjFpdXo0V3BjSWxuWkI5dkdOcktzcENJ?=
 =?utf-8?B?QWh0bk90UmZXVjI2c0d2QmJHd3JiZU1BbmM1eG8wT0VpUVFuL2J0aW8xdzZO?=
 =?utf-8?B?VHFhczE1SnRmVHBIcmJ5Ti8vSXRCckF2RkFIbXpOc3BsS2lkekk0YjhzcGhu?=
 =?utf-8?B?dEE2TytiQzJidTlISXRGMmpDZG51bjJNN3I1ZUxQaXBGcnpQckFzOGYwQzF1?=
 =?utf-8?B?R1N1ajdTV0NtWElEM0JyRjFpaUo5TXR6TG1hYkU3cUVyRzMzS3ZJWk02bFNi?=
 =?utf-8?B?NXZJUVRDK1JyV1lnd3N2ZXFpUGVOZUVjVW5CZzYyS3hCbjZwNndzUTExVGMr?=
 =?utf-8?B?Q0NrcFJFMXVpY214SFpuYzNtVUpGK09IbWtWdGx0VmlwYmFZRUJiSjNFMWw5?=
 =?utf-8?B?QWFObitPU1ZHSFNYbUg1TjQ3b3ZnTmsydWdUMU9oL3Z2dGlzNDBSM2hvcHNz?=
 =?utf-8?B?VjBFRVFYTG1DckdyalFnT2dLMmZ3b3Y3TU5DK2dBcUFpM0hKck5lc3Y1cDZT?=
 =?utf-8?B?SGFvakVhQzNHYjZWejZFOFliMnRhSTVacVRscmZuUmhwbDlxcVZjbXc1WTFm?=
 =?utf-8?B?RDhiM0oxV0MwS1l1cXZwdjBVMWQzMjQrL3Fzd1JOSWgwbXRseHphSTNaNTg5?=
 =?utf-8?B?bWF6NGQyTVhYRjk3NXpka1lBVFpHY3R0TlpyRVIwWnlvY2xyRjVNNjdkOTZP?=
 =?utf-8?B?NEFuQWxHd0FXQmZOS2pib3A1Y2xUSDBzSmRnaUx4a0MzdEFQajZ0QjJPVVBh?=
 =?utf-8?B?TkJKMWFKVU9QSDdha00yZ2R1azRUcHkzTVBqbGpWdHdqTU5NckMyWTJhTXhZ?=
 =?utf-8?B?YTNsV1p4WTEwck1vOGNTczhjdjQwN2RxeUVoQkhMUTZJa3pkVjRpdzhCS0RB?=
 =?utf-8?B?ejRFWEQ1aVN6UTN6ZzVucncrQlZSZjJTS0J0Z0xxSmhBVkQwMms3UVY0a2tx?=
 =?utf-8?B?ZENYNzF4cXFOa0d6RUZxRXlGbmJjclRWZ00zY3JZa0pRNXVEcWcwaFdFbTNW?=
 =?utf-8?B?ajhxWDNnM1RvNXhObktsNjJDdWlzNTZXQjlrazBkQXBYckRjSm1ydC9rdElR?=
 =?utf-8?B?aHVlNFBlT0dVRngyQkgwU3p0UlMrNlhCZytlS0NEczYvSDFnSkNiWDFSZ0ky?=
 =?utf-8?B?bStZRGMrN2FDT3drVG1BVE9yT0F3NmFCek5YMHB1NHpYWkVYS2lVM212Qis1?=
 =?utf-8?B?eVlBeHpnU3JpcHlRMWJaY3B3aE9PRTcxd2RjQnZxZ0hpU2ZzQmQxUitpVE9j?=
 =?utf-8?B?ek5RbWxIc0pFRzVaYjZmeW84WVJFQjlaTG9XWGg2aS82SFYvbXkwcFhKbkZl?=
 =?utf-8?B?aHpQbkdpQ2JpUkZHUUtWUFhzZVRPOFRIeDROMDV0WkVwRVhSZFU5YzAvMjdK?=
 =?utf-8?B?a2w5RGJWS2ZEOWNRZlNOV0lTK0tSK0plSFZVMHF2M0FsL1BOdC9UVk5qbzdk?=
 =?utf-8?B?cE1TYjI4eGVTS2o1NE5jUDdpRlY2RjhZa1U4ZDh1clozVG5ESGt6NGpES1BC?=
 =?utf-8?B?TWZyZFV4NWRPSVhsN1pmd2VNVmxkQXBPN0JHb2VmY2VYODRVVFZtZkdSWDg2?=
 =?utf-8?B?NURaSnBlRjJaam5ycDNhSzI5R2ZHWFVXN1JxRk1RRGh6VmRLVWJ5UVhtYm9P?=
 =?utf-8?B?ZkxPN1ZSQm9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFh2OFlyaTlMT2d6YmQ4Nk43dW9DMG83RWp1YW92eVlFNzgxb2I4VUk0Skwr?=
 =?utf-8?B?RkVKU2twSUU5c1Q2RXJhcGYzZ1pXeEFWQW9BU1FkWkpBYml4UXZqa1YzZURn?=
 =?utf-8?B?WEpTL3Bhd3ExNFFTb2U5ajhYY1VyV01lUHB0VmM3ZFFKQmUyYTE1Z2lRaXIx?=
 =?utf-8?B?TjR0SUNuM2oxQmxTWHkvbS9MSmNYMVhEMjErQnkvUFpwUkZVdHgyQlJ1M0VI?=
 =?utf-8?B?cG1oT1cwZ0ZleG1USURjbEU1VVFJNithQjlONE5DV21SWkdzVGZzTmd4bmIv?=
 =?utf-8?B?OXBmSE1IQytibXg4R3RjanBaZ1BIWGdUOG1uMGVQTEhpT0RpcitOTlQwclhl?=
 =?utf-8?B?aUh1NWRHWkZ5R3hRbm9ibTREMG00QUR0WG1wQzA5dWt2aTJhaEtYaGVNdzg4?=
 =?utf-8?B?czVpbTJZMVB2UzRMK0RLNmdCelZlWHRVc3BHN1FoVE5sam9WU0xOOXhhS2k2?=
 =?utf-8?B?MDdYY2NXTkt2RmJZVGZmZ1F6YjJwVWRSMVNFMjdpY080UVQrTkVPNVg2RWFU?=
 =?utf-8?B?RjNUSExMaGk3VnJOUUd6bTZvRkxpSUloRXRRKzdoR25Zbm9DRXRjR2k1TnYv?=
 =?utf-8?B?SW11U2xRczJNcjBSZnpsdmdpNXN1aHMvL0VHb0VIS3hyOXlLa2lKaHJCMVg2?=
 =?utf-8?B?aWdnVWVLZnVwSTdlL1pra1hYcHF5UURrYVFCSnEvUmhmcEpaeFFqK0E0SHN3?=
 =?utf-8?B?eHNwRzl6VTNZa1M3cm5Da05mMk9xaGNRN3NiTmNQcnFhNDV6SGdKeVdCU0oy?=
 =?utf-8?B?Zy96WWJWNTZTQUJZMkdXS25pQ0dITkdwcDVTN3F3QllCUGl3WFdNRGNObE1q?=
 =?utf-8?B?UDBJY3VWdDZlTFZpOEZyVzhLM3pIMHc4akVnOGVOWEE3VDJ0MVN4bjByemNC?=
 =?utf-8?B?UlFBZHJUcCtheFo5Zit0U09zNDU5U1RlK01YRzBxTnJicnI2TElxcmlmS3Ar?=
 =?utf-8?B?SXJDbGFvTGI1RllBK3Z2ZmxVQ05yVlphZVRzb05PQWlPbW0xUEpuck9yNXQx?=
 =?utf-8?B?WlYrYlFEODFqdlFvdktYOHhQSHdXdFdHbHlKbk82S0ZMMmFUcmJvSzBVUnAr?=
 =?utf-8?B?T1ZSNkFaQVpjTnA4RGFUTXBWSWVTQUY1OC8yK3M1SjNsZjJTeVNiT1N3VHpS?=
 =?utf-8?B?cmY4UEZSNXNGVmZEaWpmRU16Vko1QytFczR3bnlKTmw0NThvSHViS0RaY2tT?=
 =?utf-8?B?MXh3UlpHUm42aVkzUll0dnlTY3FWTXQvUEQ0WHlJWGxqZUd0ckQrczhQaUJP?=
 =?utf-8?B?SHdwbVdjbm5zUFBaaEIyWnAwcmRHQ0Y5WG1lakxiU2k3c0Q1eHd6UER6OW1z?=
 =?utf-8?B?Tys2N2ZTRTVEVnd1c1ZKK3lIVktGck1rYVhLVHJwZy90SFdndlhraUFVb3g0?=
 =?utf-8?B?S2ZaM2kxZGM1T0dzQ0thQXVySTRUcW5rSHBTU29aTGZQZWZPMDdNV2E5NGZo?=
 =?utf-8?B?Z2svMlVKK05ldHo1NHkrbUNCZ2plN21TRkkyNVE5aGRvYnlxREVFd1l3cFVs?=
 =?utf-8?B?K0RCOUtOMTd6YjN2YnVqRzliQ25XM09sNmk3alVmWWVMdXFiWEV1bzd6NUla?=
 =?utf-8?B?dXBYTTRXcEI1M2tPdE82V2lOL3hRZndOWmZTRkRFTyt5NUhqZk1TdHA1RzRv?=
 =?utf-8?B?THRrTUVnelkrWU9uWklPeEF1TWZSRmhWM1haNjNSajg3YmY2S0FUUWY4M1J4?=
 =?utf-8?B?UUVvaFI1NjgvTUVWM1lYWXJsRERTeVJjbG1QVS9BQnlXQVdXbjc3d3Q5S0ky?=
 =?utf-8?B?T2lNTlBPd1FsQk5UZm1rYzZkMU5rdEYwelpvZE93NC9LK2s4SE5TTGxBK3Bw?=
 =?utf-8?B?U3VPdEs4L0ZHVnA2clVFSGl0aVkyN21LQVYxWDNXZTFWamZsdUZuUDdGOWdV?=
 =?utf-8?B?Z3Nib2R5TmtJak1SZ245bGplTzZyL0NDelN1ZjNzaWt5T0pMdEcxb1E5ZHI0?=
 =?utf-8?B?Qk5PNjh6SlpXK09adGZNWUx1M0N5QzNYVmhsWnFHVUI2azVkRlhVVXBmWEhY?=
 =?utf-8?B?aGw2UGtWc1RqZ2dLVVpMNHRXVW1HcDJSUnJGQ0FjNXhxbUwvT2RjU1hCbVJR?=
 =?utf-8?B?amhLd1JxdUZTa0RjQjFZc2gwdmxUWi8zeHdLKzh0c2Q4bUFCaEJqVWVhb0VX?=
 =?utf-8?B?SG9LR2hBQ0NqbGIzQXlsaWNWZWlqVHNEOFVKWXU3dXpPcEI2bWR1Q1Y3Y3pN?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4B222539078054BB5415CC8407355CD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edefcb60-7427-43d6-66a4-08dd6c2993b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 05:46:38.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdHQ/mPAIGF3vb66y9akFfMqB7pwQ2ThRMJXz2Ewv7zYpO2tnSCjYHpEk6hHjK5deoMIckeWLssZ3UDpOuzCB76/mzeLURSifo7lOnbOy3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7174

T24gVHVlLCAyMDI1LTAxLTIxIGF0IDA5OjA4IC0wODAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBPbiBTYXQsIEphbiAxOCwgMjAyNSBhdCAxMjoyNDozM0FNICswMTAwLCBGcmVkZXJpYyBX
ZWlzYmVja2VyIHdyb3RlOg0KPiA+IGhydGltZXJzIGFyZSBtaWdyYXRlZCBhd2F5IGZyb20gdGhl
IGR5aW5nIENQVSB0byBhbnkgb25saW5lIHRhcmdldA0KPiA+IGF0DQo+ID4gdGhlIENQVUhQX0FQ
X0hSVElNRVJTX0RZSU5HIHN0YWdlIGluIG9yZGVyIG5vdCB0byBkZWxheSBiYW5kd2lkdGgNCj4g
PiB0aW1lcnMNCj4gPiBoYW5kbGluZyB0YXNrcyBpbnZvbHZlZCBpbiB0aGUgQ1BVIGhvdHBsdWcg
Zm9yd2FyZCBwcm9ncmVzcy4NCj4gPiANCj4gPiBIb3dldmVyIHdha2UgdXBzIGNhbiBzdGlsbCBi
ZSBwZXJmb3JtZWQgYnkgdGhlIG91dGdvaW5nIENQVSBhZnRlcg0KPiA+IENQVUhQX0FQX0hSVElN
RVJTX0RZSU5HLiBUaG9zZSBjYW4gcmVzdWx0IGFnYWluIGluIGJhbmR3aWR0aCB0aW1lcnMNCj4g
PiBiZWluZyBhcm1lZC4gRGVwZW5kaW5nIG9uIHNldmVyYWwgY29uc2lkZXJhdGlvbnMgKGNyeXN0
YWwgYmFsbA0KPiA+IHBvd2VyIG1hbmFnZW1lbnQgYmFzZWQgZWxlY3Rpb24sIGVhcmxpZXN0IHRp
bWVyIGFscmVhZHkgZW5xdWV1ZWQsDQo+ID4gdGltZXINCj4gPiBtaWdyYXRpb24gZW5hYmxlZCBv
ciBub3QpLCB0aGUgdGFyZ2V0IG1heSBldmVudHVhbGx5IGJlIHRoZSBjdXJyZW50DQo+ID4gQ1BV
IGV2ZW4gaWYgb2ZmbGluZS4gSWYgdGhhdCBoYXBwZW5zLCB0aGUgdGltZXIgaXMgZXZlbnR1YWxs
eQ0KPiA+IGlnbm9yZWQuDQo+ID4gDQo+ID4gVGhlIG1vc3Qgbm90YWJsZSBleGFtcGxlIGlzIFJD
VSB3aGljaCBoYWQgdG8gZGVhbCB3aXRoIGVhY2ggYW5kDQo+ID4gZXZlcnkgb2YNCj4gPiB0aG9z
ZSB3YWtlLXVwcyBieSBkZWZlcnJpbmcgdGhlbSB0byBhbiBvbmxpbmUgQ1BVLCBhbG9uZyB3aXRo
DQo+ID4gcmVsYXRlZA0KPiA+IHdvcmthcm91bmRzOg0KPiA+IA0KPiA+IF8gZTc4NzY0NGNhZjc2
IChyY3U6IERlZmVyIFJDVSBrdGhyZWFkcyB3YWtldXAgd2hlbiBDUFUgaXMgZHlpbmcpDQo+ID4g
XyA5MTM5ZjkzMjA5ZDEgKHJjdS9ub2NiOiBGaXggUlQgdGhyb3R0bGluZyBocnRpbWVyIGFybWVk
IGZyb20NCj4gPiBvZmZsaW5lIENQVSkNCj4gPiBfIGY3MzQ1Y2NjNjJhNCAocmN1L25vY2I6IEZp
eCByY3VvZyB3YWtlLXVwIGZyb20gb2ZmbGluZSBzb2Z0aXJxKQ0KPiA+IA0KPiA+IFRoZSBwcm9i
bGVtIGlzbid0IGNvbmZpbmVkIHRvIFJDVSB0aG91Z2ggYXMgdGhlIHN0b3AgbWFjaGluZQ0KPiA+
IGt0aHJlYWQNCj4gPiAod2hpY2ggcnVucyBDUFVIUF9BUF9IUlRJTUVSU19EWUlORykgcmVwb3J0
cyBpdHMgY29tcGxldGlvbiBhdCB0aGUNCj4gPiBlbmQNCj4gPiBvZiBpdHMgd29yayB0aHJvdWdo
IGNwdV9zdG9wX3NpZ25hbF9kb25lKCkgYW5kIHBlcmZvcm1zIGEgd2FrZSB1cA0KPiA+IHRoYXQN
Cj4gPiBldmVudHVhbGx5IGFybXMgdGhlIGRlYWRsaW5lIHNlcnZlciB0aW1lcjoNCj4gPiANCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXQVJOSU5HOiBDUFU6IDk0IFBJRDogNTg4IGF0IGtlcm5l
bC90aW1lL2hydGltZXIuYzoxMDg2DQo+ID4gaHJ0aW1lcl9zdGFydF9yYW5nZV9ucysweDI4OS8w
eDJkMA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVTogOTQgVUlEOiAwIFBJRDogNTg4IENv
bW06IG1pZ3JhdGlvbi85NCBOb3QgdGFpbnRlZA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN0
b3BwZXI6IG11bHRpX2NwdV9zdG9wKzB4MC8weDEyMCA8LQ0KPiA+IHN0b3BfbWFjaGluZV9jcHVz
bG9ja2VkKzB4NjYvMHhjMA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJJUDogMDAxMDpocnRp
bWVyX3N0YXJ0X3JhbmdlX25zKzB4Mjg5LzB4MmQwDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Q2FsbCBUcmFjZToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxUQVNLPg0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgPyBocnRpbWVyX3N0YXJ0X3JhbmdlX25zDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdGFydF9kbF90aW1lcg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZW5xdWV1ZV9kbF9lbnRpdHkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRsX3NlcnZlcl9z
dGFydA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5xdWV1ZV90YXNrX2ZhaXINCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVucXVldWVfdGFzaw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdHR3dV9kb19hY3RpdmF0ZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5X3Rv
X3dha2VfdXANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBsZXRlDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjcHVfc3RvcHBlcl90aHJlYWQNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNtcGJvb3RfdGhyZWFkX2ZuDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdGhy
ZWFkDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXRfZnJvbV9mb3JrDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXRfZnJvbV9mb3JrX2FzbQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPC9UQVNLPg0KPiA+IA0KPiA+IEluc3RlYWQgb2YgcHJvdmlkaW5nIHlldCBhbm90aGVy
IGJhbmRhaWQgdG8gd29yayBhcm91bmQgdGhlDQo+ID4gc2l0dWF0aW9uLA0KPiA+IGZpeCBpdCBm
cm9tIGhydGltZXJzIGluZnJhc3RydWN0dXJlIGluc3RlYWQ6IGFsd2F5cyBtaWdyYXRlIGF3YXkg
YQ0KPiA+IHRpbWVyIHRvIGFuIG9ubGluZSB0YXJnZXQgd2hlbmV2ZXIgaXQgaXMgZW5xdWV1ZWQg
ZnJvbSBhbiBvZmZsaW5lDQo+ID4gQ1BVLg0KPiA+IA0KPiA+IFRoaXMgd2lsbCBhbHNvIGFsbG93
IHRvIHJldmVydCBhbGwgdGhlIGFib3ZlIFJDVSBkaXNncmFjZWZ1bCBoYWNrcy4NCj4gPiANCj4g
PiBSZXBvcnRlZC1ieTogVmxhZCBQb2VuYXJ1IDx2bGFkLndpbmdAZ21haWwuY29tPg0KPiA+IFJl
cG9ydGVkLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPg0KPiA+IEZpeGVz
OiA1YzA5MzBjY2FhZDUgKCJocnRpbWVyczogUHVzaCBwZW5kaW5nIGhydGltZXJzIGF3YXkgZnJv
bQ0KPiA+IG91dGdvaW5nIENQVSBlYXJsaWVyIikNCj4gPiBDbG9zZXM6IDIwMjQxMjEzMjAzNzM5
LjE1MTk4MDEtMS11c2FtYWFyaWY2NDJAZ21haWwuY29tDQo+ID4gU2lnbmVkLW9mZi1ieTogRnJl
ZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IA0KPiBUaGlzIHBhc3Nl
cyBvdmVyLWhvbGlkYXkgdGVzdGluZyByY3V0b3J0dXJlLCBzbywgcGVyaGFwcyByZWR1bmRhbnRs
eToNCj4gDQo+IFRlc3RlZC1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3Jn
Pg0KDQpIaSwNCg0KSSBlbmNvdW50ZXJlZCB0aGUgc2FtZSBpc3N1ZSBldmVuIGFmdGVyIGFwcGx5
aW5nIHRoaXMgcGF0Y2guDQpCZWxvdyBhcmUgdGhlIGRldGFpbHMgb2YgdGhlIHdhcm5pbmcgYW5k
IGNhbGwgdHJhY2UuDQoNCg0KbWlncmF0aW9uLzM6IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0t
LS0tLS0tLS0tLQ0KbWlncmF0aW9uLzM6IFdBUk5JTkc6IENQVTogMyBQSUQ6IDQyIGF0IGtlcm5l
bC90aW1lL2hydGltZXIuYzoxMTI1DQplbnF1ZXVlX2hydGltZXIrMHg3Yy8weGVjDQptaWdyYXRp
b24vMzogQ1BVOiAzIFVJRDogMCBQSUQ6IDQyIENvbW06IG1pZ3JhdGlvbi8zIFRhaW50ZWQ6IEcg
ICAgICAgDQpPRSAgICAgIDYuMTIuMTgtYW5kcm9pZDE2LTAtZzU5Y2I1YTg0OWJlYi00ayAjMQ0K
MGI0NDBlNDNmYTdiMjRhYWEzYjdlNmU1ZDJiOTM4OTQ4ZTBjYWNkYg0KbWlncmF0aW9uLzM6IFN0
b3BwZXI6IG11bHRpX2NwdV9zdG9wKzB4MC8weDE4NCA8LQ0Kc3RvcF9tYWNoaW5lX2NwdXNsb2Nr
ZWQrMHhjMC8weDE1Yw0KDQptaWdyYXRpb24vMzogQ2FsbCB0cmFjZToNCm1pZ3JhdGlvbi8zOiAg
ZW5xdWV1ZV9ocnRpbWVyKzB4N2MvMHhlYw0KbWlncmF0aW9uLzM6ICBocnRpbWVyX3N0YXJ0X3Jh
bmdlX25zKzB4NTRjLzB4N2I0DQptaWdyYXRpb24vMzogIHN0YXJ0X2RsX3RpbWVyKzB4MTEwLzB4
MTg4DQptaWdyYXRpb24vMzogIGVucXVldWVfZGxfZW50aXR5KzB4NDc4LzB4ODBjDQptaWdyYXRp
b24vMzogIGRsX3NlcnZlcl9zdGFydCsweGY4LzB4MTk0DQptaWdyYXRpb24vMzogIGVucXVldWVf
dGFza19mYWlyKzB4NmM0LzB4OTI0DQptaWdyYXRpb24vMzogIGVucXVldWVfdGFzaysweDcwLzB4
M2E0DQptaWdyYXRpb24vMzogIGRvX2FjdGl2YXRlX3Rhc2srMHhjYy8weDE3OA0KbWlncmF0aW9u
LzM6ICB0dHd1X2RvX2FjdGl2YXRlKzB4YWMvMHgyZTANCm1pZ3JhdGlvbi8zOiAgdHJ5X3RvX3dh
a2VfdXArMHg3M2MvMHhhZjQNCm1pZ3JhdGlvbi8zOiAgd2FrZV91cF9wcm9jZXNzKzB4MTgvMHgy
OA0KbWlncmF0aW9uLzM6ICBraWNrX3Bvb2wrMHhjNC8weDE3MA0KbWlncmF0aW9uLzM6ICBfX3F1
ZXVlX3dvcmsrMHg0NGMvMHg2OTgNCm1pZ3JhdGlvbi8zOiAgZGVsYXllZF93b3JrX3RpbWVyX2Zu
KzB4MjAvMHgzMA0KbWlncmF0aW9uLzM6ICBjYWxsX3RpbWVyX2ZuKzB4NGMvMHgxZDANCm1pZ3Jh
dGlvbi8zOiAgX19ydW5fdGltZXJfYmFzZSsweDI3OC8weDM1MA0KbWlncmF0aW9uLzM6ICBydW5f
dGltZXJfc29mdGlycSsweDc4LzB4OWMNCm1pZ3JhdGlvbi8zOiAgaGFuZGxlX3NvZnRpcnFzKzB4
MTU0LzB4NDJjDQptaWdyYXRpb24vMzogIF9fZG9fc29mdGlycSsweDE0LzB4MjANCm1pZ3JhdGlv
bi8zOiAgX19fX2RvX3NvZnRpcnErMHgxMC8weDIwDQptaWdyYXRpb24vMzogIGNhbGxfb25faXJx
X3N0YWNrKzB4M2MvMHg3NA0KbWlncmF0aW9uLzM6ICBkb19zb2Z0aXJxX293bl9zdGFjaysweDFj
LzB4MmMNCm1pZ3JhdGlvbi8zOiAgX19pcnFfZXhpdF9yY3UrMHg1Yy8weGQ0DQptaWdyYXRpb24v
MzogIGlycV9leGl0X3JjdSsweDEwLzB4MWMNCm1pZ3JhdGlvbi8zOiAgZWwxX2ludGVycnVwdCsw
eDM4LzB4NTgNCm1pZ3JhdGlvbi8zOiAgZWwxaF82NF9pcnFfaGFuZGxlcisweDE4LzB4MjQNCm1p
Z3JhdGlvbi8zOiAgZWwxaF82NF9pcnErMHg2OC8weDZjDQptaWdyYXRpb24vMzogIG11bHRpX2Nw
dV9zdG9wKzB4MTVjLzB4MTg0DQptaWdyYXRpb24vMzogIGNwdV9zdG9wcGVyX3RocmVhZCsweGY4
LzB4MWIwDQptaWdyYXRpb24vMzogIHNtcGJvb3RfdGhyZWFkX2ZuKzB4MjA0LzB4MzA0DQptaWdy
YXRpb24vMzogIGt0aHJlYWQrMHgxMTAvMHgxYTQNCm1pZ3JhdGlvbi8zOiAgcmV0X2Zyb21fZm9y
aysweDEwLzB4MjANCm1pZ3JhdGlvbi8zOiAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAw
IF0tLS0NCmt3b3JrZXIvMToxOiBwc2NpOiBDUFUwIGtpbGxlZCAocG9sbGVkIDAgbXMpDQoNCg0K

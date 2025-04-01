Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA164685;
	Tue,  1 Apr 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485279; cv=fail; b=sgAJ5hsmmNeCGLCNIawOnO13dKqGjdCyQRgPX5YAak6iJzwih7NWN4ByJN5iNqhjFrKeEqIskhVGSBy6kR/Ji4URMTtT90c/UlECdgvnXfeikiw3NzAoVZO+nQB/D5pYZE1FLiYKn6qwBuK3k53fLb9b6f9ni35JDKG+vsTkaLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485279; c=relaxed/simple;
	bh=Hzo+g0W2N48E1Svm/hQHCCLtIEuo6nnQHz8JPy9y+C8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mSvAcI2IMGaiikR9UmiUsGIcs68FU1p7docmhWQX9d0mCv7hwZLlXPClK/IeSR7Z1J1qzbbTom3K8huQq3IgAeVMaEMLCelzre0g4wr5gKhse5dk4ZKlg7uYRqPqLIEKhKT+6/oJ0TuS+pfDTaCDQCelfY3VUtECVeKoQPF/ElE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tir88zhN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FijfDLOv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tir88zhN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FijfDLOv"
X-UUID: 0d44f29c0eba11f08eb9c36241bbb6fb-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Hzo+g0W2N48E1Svm/hQHCCLtIEuo6nnQHz8JPy9y+C8=;
	b=Tir88zhNCS8Oi46bPC4Uec7YzayMOgyR9G1yYlo5fEg9UjiY3tzXGmA+ZRr3eWKwojmaIaPjlxzAZJazpklMEYqBRdhx3bWz2rR2XIGiBoqH6fyl6sAZts+vecHhWV/vm9cy7FhSVvShjKnx1D8ZRs4n06314sTaFrRmFwf05e4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:fde7a3da-ad30-4b58-bae9-5d7acd6cbaf6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:6a21cf4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0d44f29c0eba11f08eb9c36241bbb6fb-20250401
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <walter.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1050361459; Tue, 01 Apr 2025 13:27:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 13:27:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 1 Apr 2025 13:27:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg1604g/P0mhBFmNjMRucxk5W5dAafEa9rG4ifLT+JK7kVKna7gC9MzFdvBncT/dTVzLrY+BiIxARPxjA5nS3vz0b59foWQBVexi1Fjmdoj7RBX5z1lgRXzmAqA2uqWzvXFWZ0XzUssAheEhbF4M6hcDa9k8DC1lYKUK60ltvHa85CdVs5nGbqx5h4zddRddB3NNz3rRpBYYjDAomDHS4U9S9hQJsKD7MUjWF1CvYtkSmDN+1fjlamgRZ+a7YjB6X2jPoD7AGLKhvr6WpdGyITOX0wMgkXBZ8WQziLTiUvgp6oiK5LmXQ3+RNYpKfky2OTrQsg9VnvkJrTNBdW0l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzo+g0W2N48E1Svm/hQHCCLtIEuo6nnQHz8JPy9y+C8=;
 b=MiyuQqlBXgbu3P8oyHNzEe5qLCwVGyPDnfQjwt4e+hEbOTINHPtaOZGxeCqbl2DY1fTNWbV9tixD+WLlpzbMucMVhhU9ga7FBAPTLuRNZplF+Ub4mLzgb5a+HhzggxENJp1wYurrIEOSTzwISCEzEKfCpqD6dp0f4Tli23GEjszNSGVm4KB7RX0VUeF+PEgvKC2fpovduFTAqiHyE1oplhBfOOtU2xMXNt7lH/Rhabb97WmQ4P3eGw+VBSgCoBwdzEC/rvcXbzRIoLdKJ0JHvR+zV9aA5XjrY3exdYh+I5qU1Np4bsyKVm67JSBC0pKS4Z4L5Rpnv+HKh98jbks+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzo+g0W2N48E1Svm/hQHCCLtIEuo6nnQHz8JPy9y+C8=;
 b=FijfDLOvF+K0zdZMCnJhbyVCzanKCG7WWhneDNHkhVbNDul3fLpA5Mwd6zIrX3XQS8NK5mc4Mq03c2SPM9fGucEi4uQt9/GmwLXLYV8byXICa9XAQa+uwxt6v8TeWbnOWmcuTmMjofknuqx+Ov8BnDNjSAWHeT+TvnNLOK7ZWmU=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TYSPR03MB8160.apcprd03.prod.outlook.com (2603:1096:400:47e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Tue, 1 Apr
 2025 05:27:46 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::fefa:d109:856a:6715]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::fefa:d109:856a:6715%6]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 05:27:45 +0000
From: =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= <Walter.Chang@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>
CC: wsd_upstream <wsd_upstream@mediatek.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "vlad.wing@gmail.com" <vlad.wing@gmail.com>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "kernel-team@meta.com" <kernel-team@meta.com>,
	=?utf-8?B?QWxleCBIb2ggKOizgOaMr+WdpCk=?= <Alex.Hoh@mediatek.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "neeraj.upadhyay@amd.com"
	<neeraj.upadhyay@amd.com>, "leitao@debian.org" <leitao@debian.org>,
	=?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "qiang.zhang1211@gmail.com"
	<qiang.zhang1211@gmail.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	=?utf-8?B?WGluZ2h1YSBZYW5nICjmnajlhbTljY4p?= <Xinghua.Yang@mediatek.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Topic: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Thread-Index: AQHbngICuuWmYWEDFUWN1ec8w5afx7OE6NyAgAC3rgCACLEJAA==
Date: Tue, 1 Apr 2025 05:27:45 +0000
Message-ID: <75585b6fe937a23e380b5d61df4932e8e87f3485.camel@mediatek.com>
References: <20250117232433.24027-1-frederic@kernel.org>
	 <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
	 <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>
	 <Z-Qu0stgvwHF9n3q@localhost.localdomain>
In-Reply-To: <Z-Qu0stgvwHF9n3q@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TYSPR03MB8160:EE_
x-ms-office365-filtering-correlation-id: 1849df62-ba7d-4f22-bdd2-08dd70ddeefc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YXBObmc5Z3QyVXFzK1FwWGJpZzJxWjV4SExocnVCRGNBbkxoN3lPZGdpcXYz?=
 =?utf-8?B?OU9lRFVjd3dpOGllZ0ROUkxteFI3ZEh0QkVLSVllVktXdHlFSHRTaWFVQmZk?=
 =?utf-8?B?RGRsOUJINmRMQytaRjZKTThTSWdYdWVZMjZqemdzMTEzclBDRW9qeHRybDNR?=
 =?utf-8?B?RkpMREN0bGp3TFpvNHNWa0hjYnN5T1M3RGhMZ2tkSTh5V0JsT2dyd1lIVHpn?=
 =?utf-8?B?OFRoa0pnUS9ycXRtSFRYMjhTWm03QWtmNEMxcnJUckQzbFNsQjd0RHlYbWIv?=
 =?utf-8?B?QnFqcVBrTi82ZkdKcUJQb0NPUFREemF2WDkwdUFvYlU5dlJiTzlvKzJJTWpp?=
 =?utf-8?B?SnNMRS9EVVBHRWV6eFA0Mm1sYmh2b3g3UW81eDJWYlNoVHFIVzJ5aGsvbkRF?=
 =?utf-8?B?ZExHMFJGK3NpTVZuN1RjZTI2RlBqZ0FaNVFwUktFcDgvREpLU25yb0NoczFU?=
 =?utf-8?B?VUFEdytlb1JwcVBNVjNCclprV2dyU3dLTXduaHM4OWhuenFIWTY3YnoyZ1ZT?=
 =?utf-8?B?MXJEMXhkSUMzSmo4RnJZZkhlQy9LQnE1V1hyZERVYld0SUp4RGdsbzFwQ0VC?=
 =?utf-8?B?S0lIeElGM1hGd2ltWi9CVENVUEo4Y3p6R0RnQXYvZ1F2MW9RaDNPbkVnUVJO?=
 =?utf-8?B?YWd0S1dZUG9IRkI3VDBSVGh2eTZBdGpsK0xqUTQzUGREZFV2VzY0bTdvREFz?=
 =?utf-8?B?Q0lHR3ZickhSM2E2TVhjTjhxaFd6dGpGMFJuRVhsYjdOSFh0WmV0UTEvQzV3?=
 =?utf-8?B?SkNDaWxFQjNlL3ZzWDJCWVBzWjBtaGhnTWdwc3JaQnhFRFgrdHZnVTNEVHhM?=
 =?utf-8?B?NVh1SFAzT3FhZDdPdk9GNURYVzZoN05oVkpSTG44NWpjclVPZ2MveUg2cW1P?=
 =?utf-8?B?d3VzejFieERJTTZBUDd6c1FhV0VSbnZwQWtVVXNoK3F6Uzc2WXBCek8rWXNB?=
 =?utf-8?B?U3BsTlVLZEJaY3BZQ1FLS1hLU2VraGd1N0ZzZE1ObjNDZXVadWpEZGtMZ29x?=
 =?utf-8?B?VTNNMDBSYk1hZWZwcXpKcUI1L082dEJNMmxoUVpZYVpJc1RXeFNnQWVObklN?=
 =?utf-8?B?WWsyeG1zdjhkMVhDTFAyOTZ2Wk03SkZqOTV1MkZ2Y2t0dlVNd0RaVWZ4MXJF?=
 =?utf-8?B?T3NIYmVvVTh2ZTFuQlJaMnhuUjBCdUNUZkNUZ3lhZUhOZTdzTjdyQXpkS0hl?=
 =?utf-8?B?K1hGUndxQ1ZybUJGVmFBUVBUT1RPU3JkOHBQMFVrYUpiU1d6WitQVkQ2WUxx?=
 =?utf-8?B?RVRSZUtQaS9ZMnEyaCsySkJYZzhSZEMxeHQ4bmh2dUVwbExaOUxqUVBOMmFD?=
 =?utf-8?B?cjBoTUhETnZ3QTJWblhyRHJweTR1UmtXdlo4bG9aOEg5UjFVVjMxaVJ3NkVG?=
 =?utf-8?B?dlBMSW9yOG91SEVNa0JQZjdlOTZDRUcyVksvNXpGa3hsWWVJOW10VWJqMnl5?=
 =?utf-8?B?b3hQcDJQK2dzQTZQSU1ERnh6NmZsUmI4bE5nSUJUcCtLUE9vYjUrdnZ1aHZK?=
 =?utf-8?B?QW5HZE4veU5ldXQzS0RibzM4S2UwbThSZ0NtS2E4OGk2Skprem00QkpNQ29z?=
 =?utf-8?B?eE0vc2FwVVo2NWRYWHI5Rjl4RTFacjV0Szg0WFVqc2xGa0dGdzJFdE9OcnRP?=
 =?utf-8?B?dE96WDJpdHFMK1JUSTBhdElJc1dsVFVLTndXUnJVWUI4SUJoYXVwMUJtQm9G?=
 =?utf-8?B?Rkd1eUFKdnhZQnRWUDV3ZERwcUhkdnRqU1FsSnlLTnVRdzR4VytVRktSdnBa?=
 =?utf-8?B?UTQyeFhJMis0TnRLVmRKZEVzQzNvaDREdzFFdGhpR2d3R0hadzZ3YWFpQldD?=
 =?utf-8?B?Z2xRY0pVR2ZRV2dPVGRPd25wdFhwTDRhTlVqWmdsSCs0TEtMOE1aa0tpUThp?=
 =?utf-8?B?VUdDd3d2Q1JHWWdldFNvbUxIbkswWXRlRDdHeGtWdTBtNyt2aXN0dWt2Ly83?=
 =?utf-8?B?WUdsei9OK0p3K25pODBHZFJGVG9yZ2VMM0hPVUZVZmJzWm9ETllkN2tTdExN?=
 =?utf-8?B?UVVzeTZLUTR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkhWenR4VlZvQnBJUXYzK0NhcHZETWlvdUtkMmJKZS9uM3lqdndyZ3VvRzJU?=
 =?utf-8?B?eWJhNkR2SkY1MjNtcUdVT0ljM1dmdEpoVzQ5YncrdmJ5VWhoQlcxZ0VEQjlr?=
 =?utf-8?B?WmpqUHc0NjdlSHZIS1F0MkVqYzh5dDhlYUlaUHdQSUUxVEdjY1F5SnZyZWJV?=
 =?utf-8?B?VTZnbFJKaWIzNmkyWmtBbjVZWkpWWUhLRzlMUnFIMVVMamJoOUU3WGhOeG5p?=
 =?utf-8?B?L2pmZG84dlFLeVZGTWptNWJvV01ITkFERlhnbGpyZWRUUThTOTFRV0NmbGxo?=
 =?utf-8?B?UitsNUJMdXk5OTQ0Sjl3TTRNWXpqMVFsTlRCTUxjNGc1SU9ia1VaT3Z4Z2Jt?=
 =?utf-8?B?N2ljY3VPcHhJU2dPQ3BFcTNEQit0WHJtcHRtdmdDR0Ewc3R2U1RabENoOHJq?=
 =?utf-8?B?U0Q2ZEszc2ZVR21zZVJ5VzdIbEhBR2NmR2JQWDdSNFFiTHNsczZvZ1RMVGRr?=
 =?utf-8?B?M1JyN3NUN1ExWktkQktQRW5rTjJPMUpCL1pEc1hpU0l3MUZneFRyK1N1cWZy?=
 =?utf-8?B?eWhpbEFFU2wrdjB0ckxtcjR4ZlltWHlIRkR0N0duSlR6djNCbmdiQno2V0V4?=
 =?utf-8?B?emtwai9sdzZwT0VSS2hyUzVERWh5ckJxRGVqWStXOVJRQzRXQVdFNFE4YTV6?=
 =?utf-8?B?dWYwVlVtMVFlbkFwYU1sU0ZsZFB1L3NWeGlTMmI1T3g4Z1J5QkIrRSs2TFQ2?=
 =?utf-8?B?Z1R1Y0thWms1QnJJODZHNlNoaDZRL0tOZEliQkFvSWpUaWJlNjc5SGUxUjJy?=
 =?utf-8?B?aEtmLzFianNsSXhrT2NxMlRjRERzNFBnMXViT1B0bldSVG54cHFjYzVLcVVh?=
 =?utf-8?B?UTlrczdkVVdGZmRIV24xcjU5N2dUWU9yS0g2cDhDYnNvNG1veUZRNk0vSklQ?=
 =?utf-8?B?VUdSbHQ4K1ZwbVZ2TEoyUTJFNDlYR0VCTVpMdjBRRDREczhEYWcxaHR5MTVU?=
 =?utf-8?B?OWZRSFZFMWVLNG9LT2dzbFZET2tyWEJXQzNCMWRZMnZyODVmWGNlckREdm9w?=
 =?utf-8?B?cWRUUzdPSXBXSTBNOEJ1VGV3SE4xK1NUcFRnSy9CS2ZWcUd3VnZTS09CZ1Av?=
 =?utf-8?B?UHpRM0VNeHkwVjdCUTkxeXF6eFpIamxtTnpQYVNoL0hla2k0eVhsRmk3aUxB?=
 =?utf-8?B?L0M5d2hTbFkyZU81TWYxSmZmREdTNFNOWTkzUERBL1dhSzhGcWhiOUh6YThp?=
 =?utf-8?B?Z1B2ZUV3VHp4cTdETkZ3ckpuWUlBb1dwSkV4aHdTazJZWkVnd1BMMUJSeS9p?=
 =?utf-8?B?OVp1empOd3UxbnlwNC8vMm1hWVFiODZ0dlV2VVcvMzdQc0d4aWZNZEJ6MlVO?=
 =?utf-8?B?aEFVSjdpRHpxM0ZIR3FvV3BySzd5MDZqMVg3dnA0VUk4YnQwQWl2K1Q5Wit6?=
 =?utf-8?B?U3lPZFQvMGpnWWtPNC9ZSXNIdU1yOVJlelJHTnJWTEVoR1dFTW1pRmtlMHlz?=
 =?utf-8?B?Yk5yMmQ2cmdybmd4RnpEaWl0VWN1MjIzaFlpTjUvMlZvQ3NuWFlBK3A3bVQw?=
 =?utf-8?B?UzNFTzVFekx4MXBiVzRJVEEyY0toV3hISWRxZ05QeGh3dEdqRXFTa2ZYTUdH?=
 =?utf-8?B?ZUtkY291clp5YlVuLzAzSVg1YitkR3N3Y3hMMmptOVRUa0UwUWtRY28ydVpP?=
 =?utf-8?B?TTB6QWtFRU9COEpCcHFBNm5MWEtwaUhzeGhES1ZxbHBkTjZXR1JiZHJIOXBm?=
 =?utf-8?B?ZTFkWUZjcExDSXVteUhRV2xRWUNkeUkvVjJUSnlwdzNMOGFrSnZHMU5tM3pM?=
 =?utf-8?B?VjZ1amFFMlNBMUdSTUNpUVpvTmNYckh5V2dxeVlKUDVTYlZ5NDFmbk9ZOXRF?=
 =?utf-8?B?M1pEYWVOWktIaGZoSi8vOXFHUUk1cnA5RnROTDc4bFN3VHBERXpGcXdWSDFJ?=
 =?utf-8?B?cUtvUUxWZnhVeW5KMDVMb1NNT2prTWt0WDVIOXd6MUZ1Y3FBVll5cTVWa0tX?=
 =?utf-8?B?c3VXL2R1VXhCdFJBWTJtbWRRY2svRjlFMGl4N3BnQjV6QVpFWlN2WCtNUnBG?=
 =?utf-8?B?eEZER0NwUDVSM01PMERueWU4bStGb1IzSG8wWU1aekYzWVhmeTRUWEVaRHZk?=
 =?utf-8?B?cEVpUjVMd0QzTkxnNkhweXIyTmVnZTgvMktjNkk0c05yQ2gyM1Y0M3VRM1hL?=
 =?utf-8?B?blVTMVhEOXhmQUtocnhMSkdkNjRWMnJ1MnVuSXE1RGNJanduSFprcGwrNVFK?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA92BC0E5EFDF468DEB70F817340C09@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1849df62-ba7d-4f22-bdd2-08dd70ddeefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 05:27:45.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92pDNDAQcx94ZnrHL+pNLoCG3BAP6rM2NkaJ4Xn6husdRc/h5GFGdymkPDUzvZDdwa667FiiBPf1wyRYqLvePL99mZvBKI1q5MtTl59I244=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8160

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDE3OjQ0ICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiANCj4gSXQncyBub3QgdGhlIGZpcnN0IHRpbWUgSSBnZXQgc3VjaCBhIHJlcG9ydCBv
biBhbiBvdXQgb2YgdHJlZQ0KPiBrZXJuZWwuIFRoZSBwcm9ibGVtIGlzIEkgZG9uJ3Qga25vdyBp
ZiB0aGUgdGFpbnRlZCBtb2R1bGVzIGFyZQ0KPiBpbnZvbHZlZC4gQnV0IHNvbWV0aGluZyBpcyBw
cm9iYWJseSBtYWtpbmcgYW4gb2ZmbGluZSBDUFUgdmlzaWJsZQ0KPiB3aXRoaW4NCj4gdGhlIGhp
ZXJhcmNoeSBvbiBnZXRfbm9oel90aW1lcl90YXJnZXQoKS4gQW5kIHRoYXQgbmV3IHdhcm5pbmcg
bWFkZQ0KPiB0aGF0IHZpc2libGUuDQo+IA0KPiBDYW4geW91IHRyeSB0aGlzIGFuZCB0ZWxsIHVz
IGlmIHRoZSB3YXJuaW5nIGZpcmVzPw0KPiANCj4gVGhhbmtzLg0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc2NoZWQvbm9oei5oIGIvaW5jbHVkZS9saW51eC9zY2hlZC9ub2h6LmgN
Cj4gaW5kZXggNmQ2N2U5YTVhZjZiLi5mNDk1MTI2MjgyNjkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvc2NoZWQvbm9oei5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQvbm9oei5o
DQo+IEBAIC05LDYgKzksNyBAQA0KPiDCoCNpZiBkZWZpbmVkKENPTkZJR19TTVApICYmIGRlZmlu
ZWQoQ09ORklHX05PX0haX0NPTU1PTikNCj4gwqBleHRlcm4gdm9pZCBub2h6X2JhbGFuY2VfZW50
ZXJfaWRsZShpbnQgY3B1KTsNCj4gwqBleHRlcm4gaW50IGdldF9ub2h6X3RpbWVyX3RhcmdldCh2
b2lkKTsNCj4gK2V4dGVybiB2b2lkIGFzc2VydF9kb21haW5fb25saW5lKHZvaWQpOw0KPiDCoCNl
bHNlDQo+IMKgc3RhdGljIGlubGluZSB2b2lkIG5vaHpfYmFsYW5jZV9lbnRlcl9pZGxlKGludCBj
cHUpIHsgfQ0KPiDCoCNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2NwdS5jIGIva2VybmVs
L2NwdS5jDQo+IGluZGV4IDA3NDU1ZDI1MzI5Yy4uOThjOGY4NDA4NDAzIDEwMDY0NA0KPiAtLS0g
YS9rZXJuZWwvY3B1LmMNCj4gKysrIGIva2VybmVsL2NwdS5jDQo+IEBAIC0xMyw2ICsxMyw3IEBA
DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlvbi5oPg0KPiDCoCNpbmNsdWRlIDxs
aW51eC9zY2hlZC90YXNrLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3NtdC5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L3NjaGVkL25vaHouaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvdW5pc3Rk
Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9vb20u
aD4NCj4gQEAgLTEyNzcsNiArMTI3OCw3IEBAIHN0YXRpYyBpbnQgdGFrZV9jcHVfZG93bih2b2lk
ICpfcGFyYW0pDQo+IMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCj4gDQo+ICvCoMKgwqDCoMKgwqAgYXNzZXJ0
X2RvbWFpbl9vbmxpbmUoKTsNCj4gwqDCoMKgwqDCoMKgwqAgLyoNCj4gwqDCoMKgwqDCoMKgwqDC
oCAqIE11c3QgYmUgY2FsbGVkIGZyb20gQ1BVSFBfVEVBUkRPV05fQ1BVLCB3aGljaCBtZWFucywg
YXMgd2UNCj4gYXJlIGdvaW5nDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBkb3duLCB0aGF0IHRoZSBj
dXJyZW50IHN0YXRlIGlzIENQVUhQX1RFQVJET1dOX0NQVSAtIDEuDQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvc2NoZWQvY29yZS5jIGIva2VybmVsL3NjaGVkL2NvcmUuYw0KPiBpbmRleCAxNzVhNWE3
YWMxMDcuLjg4MTU3YjE2NDVjYyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL2NvcmUuYw0K
PiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IEBAIC0xMTYzLDYgKzExNjMsMjAgQEAgdm9p
ZCByZXNjaGVkX2NwdShpbnQgY3B1KQ0KPiANCj4gwqAjaWZkZWYgQ09ORklHX1NNUA0KPiDCoCNp
ZmRlZiBDT05GSUdfTk9fSFpfQ09NTU9ODQo+ICt2b2lkIGFzc2VydF9kb21haW5fb25saW5lKHZv
aWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqAgaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsN
Cj4gK8KgwqDCoMKgwqDCoCBpbnQgaTsNCj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2NoZWRfZG9t
YWluICpzZDsNCj4gKw0KPiArwqDCoMKgwqDCoMKgIGd1YXJkKHJjdSkoKTsNCj4gKw0KPiArwqDC
oMKgwqDCoMKgIGZvcl9lYWNoX2RvbWFpbihjcHUsIHNkKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZvcl9lYWNoX2NwdShpLCBzY2hlZF9kb21haW5fc3BhbihzZCkpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdBUk5fT05fT05D
RShjcHVfaXNfb2ZmbGluZShpKSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0N
Cj4gK8KgwqDCoMKgwqDCoCB9DQo+ICt9DQo+IMKgLyoNCj4gwqAgKiBJbiB0aGUgc2VtaSBpZGxl
IGNhc2UsIHVzZSB0aGUgbmVhcmVzdCBidXN5IENQVSBmb3IgbWlncmF0aW5nDQo+IHRpbWVycw0K
PiDCoCAqIGZyb20gYW4gaWRsZSBDUFUuwqAgVGhpcyBpcyBnb29kIGZvciBwb3dlci1zYXZpbmdz
Lg0KDQpIaSBGcmVkZXJpYywNCg0KVGhhbmsgeW91IGZvciBwcm92aWRpbmcgdGhlIHBhdGNoIHRv
IGRlYnVnIHRoZSBocnRpbWVyIHdhcm5pbmcgaXNzdWUuDQoNCkkgaGF2ZSBhcHBsaWVkIHRoZSBw
YXRjaCBhbmQgY29uZHVjdGVkIHN0cmVzcyB0ZXN0aW5nIG92ZXIgdGhlIHdlZWtlbmQuDQpBbmQg
dGhlIHdhcm5pbmcgcHJvdmlkZWQgaW4gdGhlIHBhdGNoIGRpZCBub3Qgb2NjdXIgZHVyaW5nIHRo
aXMgcGVyaW9kLg0KDQpBZGRpdGlvbmFsbHksIGFmdGVyIGEgdGhvcm91Z2ggcmV2aWV3IG9mIG91
ciBpbnRlcm5hbCB0YWludGVkIG1vZHVsZXMsDQpJIGNhbiBjb25maXJtIHRoYXQgeW91IGFyZSBj
b3JyZWN0IGluIHlvdXIgYXNzZXNzbWVudC4gVGhlDQpnZXRfbm9oel90aW1lcl90YXJnZXQoKSB3
aXRoIG91ciB0YWludGVkIG1vZHVsZXMgbWF5IGluZGVlZCByZXR1cm4gYQ0KQ1BVIHRoYXQgaXMg
b2ZmbGluZSwgbGVhZGluZyB0byB0aGUgaHJ0aW1lciB3YXJuaW5nIGlzc3VlLiBXZSBhcmUNCndv
cmtpbmcgb24gZml4aW5nIHRoaXMgd2l0aGluIG91ciB0YWludGVkIG1vZHVsZXMuDQoNClRoYW5r
cyBhZ2FpbiBmb3IgeW91ciBoZWxwIGluIGRlYnVnZ2luZyB0aGlzIGlzc3VlLg0KDQpCZXN0IHJl
Z2FyZHMsDQpXYWx0ZXIgQ2hhbmcNCg0K

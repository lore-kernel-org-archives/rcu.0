Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8E34D3A1;
	Tue, 23 Dec 2025 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453068; cv=fail; b=QOJwufgsDNGByALUxb/3qj9g2lg6x3/1nqlyEcGbU1/xY8/GY6DC3lKdr+C9vY/vRwCI0OF0C+tYwHDw8Ss+66eCdvZqM3Mt62aKYsFVhdu5+GsujKaOW1ON1njEdED7FJrgph58Xz0sefWz2pn4PT5tRvksp7FGQ24piPZntmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453068; c=relaxed/simple;
	bh=omnJoCMDbq5/E0qkOJ1Vxz6fUbh5nAXy26d3vwg8aaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OfZOjOO6hzcFXHe69971eFHY7ePVFBU34QFpQw82hckAZDvalYVtEpevrn1uRl7iY9pgABBjhEtKSgJ0WSnks/wa6zN8sGc9yN6gfHLYEpVSDw9MG3ocwqHTTs4JRTvabAP7g9tNPy8M0WsrXMZ6etAqw22LNWAV9nW55Fh7qjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WmabHwo8; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WmabHwo8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYv4u85ZbAMehAydqTN5nYKFvKknKsYmEnLnUpSzCBlogJ4j78OR+j7JKlXE6bRtH9nY42lc2t25tlu07ZSo4TWrJPbjW6utiIvwVrCNi3MQkW5um5tJIgbUeJdKbguClJNyGzHFEMa5kBdSsVV1Pj1dNzUjjdji83pwduh5TWjvy2Qsqf5J4bn6RVqTQEgONri5HhAAHGbfZ/fXkp4jYRpOLt/c92WPtamxjIWuMQN4gAeRtiFOTgFHA9gLmADD5+Av3pgmEX48oHZCr62u1GXD461PflegV5AhM/yxDiUy57KLUQiK4xi8Uno2oMyMl/XKx25NxMElzP+iPPb8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omnJoCMDbq5/E0qkOJ1Vxz6fUbh5nAXy26d3vwg8aaQ=;
 b=uRC0EY1h/ubQW5c3W2rt7SPCd9kgGWlmdIouMPLG3qKDQAby/8xNdRXgK1/6+xllBBshxdtuHg+bEUAweb/PqRSLFNj4CM3wKikwazUyj8Tx9hIL/jUCz8AHfeQM45ZSLqPOeNhOsaffgIKH5n65dKaO9Zo62Jd6TNEumnUT2wheZDQCNS1jqOxLBCPcEWZ3lP6YyJc+YfZcASBPRV1mivzZdZnnzY7H0FHX+Nry+IOarO6W8jJrJBZT2TsrHq1yOdJyHecVD8+RkpwmYgrKAuIecEswmwpCXb2zbbqaxN3QPEvqM6OhnTO4c4PUAEJINrRFKZRt0qA2VbIPuLapuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omnJoCMDbq5/E0qkOJ1Vxz6fUbh5nAXy26d3vwg8aaQ=;
 b=WmabHwo8xRHSWo1TseGciv0eY9bud414bf3Es3rQk86pWcw3efpEuwA86EzZazH4Qtjg7rwLHHVA+57wG8vo0KJxHZ8/uz9EeTvBhhR/F8hRuJ8mSbW+8p8i1p54lglj5PRwP7GaNvQ1MomMEQ+xSn5zdcnb/Z4508RSdxZy3/B8zLE20k1mGsCJ5UfvHUbst+nNynv3nIILY2B8gy0MSaZJl0kBdPru8eB0AoJLHpi9v1oqXPQTYMbvm8cAPBihuGbGZrmeSj0N+NnSjjXMLi1iA6dj1T9fva75Tk/OB2y/jjLK0kgoVfTLg5kuR+eLrvmr9qc05HbGBxBHQaNSHw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 01:24:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 01:24:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Thread-Topic: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Thread-Index: AQHcc6VDCj+fqclEJkivrGTbUqkeo7UuaxIAgAADXvE=
Date: Tue, 23 Dec 2025 01:24:21 +0000
Message-ID: <A7C75238-E17D-4288-8A2B-5BC62CBB5FD8@nvidia.com>
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
In-Reply-To: <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|BL1PR12MB5849:EE_
x-ms-office365-filtering-correlation-id: 7f113342-ff04-455b-e529-08de41c2003d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2FDNFNiSHFVd0MrVHQ0WUFXMmhqdFZvQVBaT0ZSeTdwZUVGbytodDJTYTFQ?=
 =?utf-8?B?Q0RlRUtJOU9TcTgwZTF5czM5YTdsSkc0VkxGd01OdmJNak1NZE9GQkNaZkhi?=
 =?utf-8?B?UG1TdjVHZFZZMHFWZ1pZWFU2VG92YmZlMXd4eGhqR2lIckhzQjNSTFB4STBW?=
 =?utf-8?B?Tk5vTVFyNDNsUGozaVdtTEhTV2NlNVZaMFpSSXBucE9SeXFlNTF5S2ZBZlV1?=
 =?utf-8?B?b2JMTFN5S29xQUN2YStqL29XZHZpalZ3ek1BUGlmMTZzRU9UenFMUHdDTm1C?=
 =?utf-8?B?TncxS1RwNVJHeW01SFZKc3RCTkUraGRnM2pFV0d0cWpETTlHc3lpc1UrckZB?=
 =?utf-8?B?RVZyTXV2N0ZhT1JuYVRvaDE3TGE4eHgxS1ZJU09VVGJDeWZRdlpFcmZtUU1E?=
 =?utf-8?B?L2xYTFlXeDZucm5jdENqcVRMVXdPZE9ZdTNpTGRsVXNyNDhZVS9ZR0ZCSEpK?=
 =?utf-8?B?aHdMa2EwR2YrL0dZSFZGMnlkL2FZaUVkdDVtdkJQZ0F4dlRxOTl4L0JBMENK?=
 =?utf-8?B?RDBuMEI4NDE5bHdOY1dWaGlhcHFEQjRSV1NSc3JjMlNnL281eSs5K0ZmQ25w?=
 =?utf-8?B?cXMwTUVwREpFTU9RWjNUN0xJYkYzWi9JSFNXSGVDeVJ4YnMybk5KUGpEQzZv?=
 =?utf-8?B?SXpZT21HL0JqZkg0L0VHeDE0aDY0ZTNDR2FFOUxnaWhlZVFzdDMyYnJIeFZ6?=
 =?utf-8?B?eklUaEtVOXB5Rng2cncyWWFTZWhmL2FNUG1OSWlpaUNJK0J3cEo4Wm4ycC9X?=
 =?utf-8?B?ZkgvM0F5YWtVR1Z6TkVjRXVJcm54UGsyRVdTblBoUFdsNnNrM1YrUjllSTNx?=
 =?utf-8?B?eDFzUTk4Q1RQNS9jZnhnQnVOaCtqQ2F3ek0vaFUzVzRPTFRwOGs2OXkrbDlY?=
 =?utf-8?B?TTRsSjJqT2M0czJLeC8xTDNWVlp5Smd2OEZGeEo0dFNueUU1TXhENkczcUNn?=
 =?utf-8?B?N0VwR1BVU1I1RHpCQythYWdkeDlYUXM5TE1ndFcwSmpGMXQ4Vjk0T01YUFV6?=
 =?utf-8?B?OVlpYldJajF5YzNFV0hwMUliQURpd24wWkNCTks0Ym5FL0RMek5KMEFRZzUz?=
 =?utf-8?B?aWV4SU5KZFJFU0NyQTdUOEw3M1d6VWdlVmdmSWo3N1BZS2kvakNEL1c1ZVVO?=
 =?utf-8?B?UGt0M29DS0xCeHBlaGFDYVMyRithR0hhaG9MU3FiNXc3cTNQWmdqc3RBVnpt?=
 =?utf-8?B?U3dGUnFpZVdlRHBBMGtSNGpIVWxJZTdPN2NodU9zZTRwUGZSUUdzaUNrQ1hQ?=
 =?utf-8?B?bEdBRFZPWllmb3FPK1Y1VDBLWVJ3TXdPZVdURllKSkVZbWNlb2FNaC9WTDQx?=
 =?utf-8?B?QzFTR3lCaXVrZTFrK1A0NzUxV1hPeHhITXFFRHdJUWFiR09WUXFUSWtPOHZQ?=
 =?utf-8?B?RUNKd1NHRGlTUmlxUUJQckxhSXJvM3p5T0IzbHo0L2FNVGR5bHJSRlpvWlBz?=
 =?utf-8?B?cWlldkE4ZlZUYXJ4SEozWWpWZkttaVd0b0VZRTlTelQwSElOZjd5SFMwamh6?=
 =?utf-8?B?Mzc4bFBXbmpUV0psRGY5UVJIVno1T2lMS3hIbGVvWnNOR3kvMm9VMHFRaGRX?=
 =?utf-8?B?cUdCQ2o5S0dZOTJiZUZWa1RmZmNCZmRhN1djU1ZkaW5tK2JLRzBRMUJaUy93?=
 =?utf-8?B?eThpOVVWcVA2UDFka0lWRkp2OEhIQnIxTVY4czNkdzJzakY3RHYzaDNGbWt2?=
 =?utf-8?B?Q3hVR0dFRjY5bmhnSkhqRko4bkVFSDFHOUFucndEZ21nbjBwSURMZnQ3cjBQ?=
 =?utf-8?B?dThmWXIwOFFEVmxLT1k5RnNlUUhGT3FUZWw5U1pYZDZ2L3ErR1M4Slk5aHRS?=
 =?utf-8?B?K05scjk0UnRpanVZeExBOGRvWGczTkllczNESVhkNTQwR0MzdXdBeEpnNmVP?=
 =?utf-8?B?N1BsS0JNKy9Ud3U1OVlaVzFYL0VBWjBCSkxPbW1iKzJTeGgzbk80eEFlajNP?=
 =?utf-8?B?R0pyQW9ZZUxuYW1HcTIyU01BMjd2c2R2SGxGU25NN1RFR2JDenZPUmQ0UkZr?=
 =?utf-8?B?ODE1aks4ZCthTHR5RWdOWERaWXRnTnZUckVDTUUyQlJReWxzbHpmQjFDVkZZ?=
 =?utf-8?Q?kr03M1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzJ5WnN0UGJKWktuNUZzWjZXdmZ5TDZ1MDJQdjludEZabFk5bE5JR0c3eTdU?=
 =?utf-8?B?VjFzeTlYNVVjbmFVc2hqZDZQbDdPV21RWktoSXY5T0dZd2FwTzg5bTNrTDNR?=
 =?utf-8?B?TTY4LzI4U3Q1amV0dG1TZTAya0dmR0JNeThXeFowZjQyVnZSQTNsYzh1VFVC?=
 =?utf-8?B?RHZFQjN5ck1sdVVidkR3ZjY0eUlocHJtTitkVEw4TG9mNUpFTDMrUnZtMXZv?=
 =?utf-8?B?TUJYUDRNZmF3SEU5UUdaM0JLYVh0ODJiV201YlFQNGg2UGlFMmtyWWFGVGp6?=
 =?utf-8?B?K2hFcUw3TVhqYmp5eGN3cXQ4TWU2SklYOWpoS3NPUkdjcFg3WXRBaDEvK0V5?=
 =?utf-8?B?YXU0TEpRTnJGU3RFa0NTUmhTRjBGSjd0R2dqWmlTMEVVaDRJMSsrekNhb280?=
 =?utf-8?B?ZmcwQ3Z1RGxpWEpXL3gwcVQ5UllKWTU4WTJIR1lqRzQ5TEZmYmYrdkNiMFdZ?=
 =?utf-8?B?MG9QRXo5U2lyUm5XdVZmNFR2UDljVEQ0ZWEvZ0FYZU9nUE9DWmU5UENrUTJw?=
 =?utf-8?B?aFFkQ2ltSXUwcFp6bC80dlUzNERKL0NwbEhrY1V1c0NzVzhEWDhPeGlDZyta?=
 =?utf-8?B?S1ZwMndiaGRaS1RTancvYk9iRktvY1dQRFRvZ3hJM3VHT0dCSnAvU2VrTXI2?=
 =?utf-8?B?YkVLc3o3elpMcjJRaW5FbUJDVkhaYXY4SUZSTHJRWHdnNWgvZUhSdFVsUzc1?=
 =?utf-8?B?azVYUTNqd2JlUWI3dGFOaS80Y2tmS2VTNmFuZ3FmY2tGYXJPelgwME84elNQ?=
 =?utf-8?B?dGRJbkpXV3ZRTTZiTkZEdTd0RTA0NDB0VTZNTHhsR0tPQ3RNUENDQ2FYRUZa?=
 =?utf-8?B?dXhvdG5nSEc5Um0vV1Nua3Y2cnhpaDhJQld1TEszaXFKYVRCVWtaZmNMem1v?=
 =?utf-8?B?K0drNHE5elhaaHl2WkpEWjB2eC9GUnZxSUZuZER0a1d1VHBoTk4xelZKQnZl?=
 =?utf-8?B?WWU3NmRpc3Exc0dBZnpMQU85bjZyRlFrT0pXcHBKV2FUYS9QYkc2ZUg4bHFC?=
 =?utf-8?B?R3VQcG9VbzhnZUdyL0JGaEY2RW0vcnZFcm43YThCb0ZUZXVIT0h4Ui9hZlo0?=
 =?utf-8?B?b2R2RXBqMTFZQTRVVEdmK3dYZHpzOGVNZjU4TlBFTDFhYVo2RnlPV3NKa0t6?=
 =?utf-8?B?elI2UWpnRE5OTGxCdTBVSHREdGxCV09MZWlta1RURmhBT3FYZVE5N3lBcTN1?=
 =?utf-8?B?L3c5c0JadWk3bFlJZFF3cGV5MmhPNHZNT1o0M3hzUnJwMFl0RndjNlQ1UDFY?=
 =?utf-8?B?bDNzQ0hKMFlBa3c5UnJSMk5mQXpxbnBFNEthRDhHYzh0d3VJK2dubnh2ZjlN?=
 =?utf-8?B?NU5sdFduTXV3WTFFVDhETU5veFZHbERPeFBXbUs4TFpwWW5qT0U1RXd2ZUJk?=
 =?utf-8?B?ZVRCNnNOcUkzcnJFNWNWOUlRNnRvZVZsT1paYjBTay9tQXV6elFscU9jcVIv?=
 =?utf-8?B?ZXVrbnJ4ZXhZcjVSdkttT3NuM3FLaTRTVWRZSnFGMjFEUU9QVGgzK3ZPSHlo?=
 =?utf-8?B?M1BPVm9VVWdHNkpEUXMvZUE1dkI4eFpBUmIwK2huaXljUUlNSm9ZdHIrUlR6?=
 =?utf-8?B?UkdDQ0Y2cHo4OHBNazhZYnBZSGF1YlNlOEx4cVJzU2R6ckxoMVlCSnpnMDNa?=
 =?utf-8?B?SlNpTmdxZlJwSzdwUXRNY1NzaWo2VjVYVEdWSGpaemloVXhobWFLNDBPOUR2?=
 =?utf-8?B?aHpBanBwNWU4cDZKcWhwcWxZdEw0NWhJUmRIOHk2MGo3WGZxZG45ejBPM3Bl?=
 =?utf-8?B?UHE5MGV4dHRqbk5ub2QvOXlKS1BPakdMMjE4cFJwaFFYRXlOaTlqc25hRW05?=
 =?utf-8?B?OCtybnFYZ2s0S0hFM1N5c0o2dWdVUUlBZWpCeXhvdUJtZ29kLzlCUGRyamJO?=
 =?utf-8?B?dkNCaXZSTTEwZzJ6YnpFSExhZDFjMHNmQWRMb0I2NEo5NGVOakN6ZzYyRzR3?=
 =?utf-8?B?ZEZsWUZMQTFtcnlPSSswUFpHVzRuU3ZIN0xwbnU5Ym5DdGVkTUZJS2R2b040?=
 =?utf-8?B?eGlCbC9pSFdhZ1hTTG9PTS9CRHZYVFRrMjZXSlNzUFNJR0NQVGRyUFl5YzJ4?=
 =?utf-8?B?TmlMVUpidXV2VmZXeU9TRkd4citqek9haGJJSjNGSzg1V2tyMlUrQk1LTkQ5?=
 =?utf-8?B?Y21xSmxYYUUvM3ZNVmlncTBReUhtOVI2YVJqcmVCVmpPSWY3QWhoTGl0aERR?=
 =?utf-8?B?UWdLNXR3Y3BFSUFpY3dqNkhMM3NjOWhMZHFjRXFpVmZOU056OHNYRXV3Z1lu?=
 =?utf-8?B?dkplVTc5Y3JDdVI1SUZ3L0VyYXdmbDZ2T0VSZjQwdmNSSXE1U2RMUWU4VkRK?=
 =?utf-8?B?a043dGJNeGVIVlVONTVSZEhQQi85WXoza0VUMDIzN0VUS2hFdFEwQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f113342-ff04-455b-e529-08de41c2003d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 01:24:21.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZIhuUjovUXiMwo0qQWcIMb+ssUkBxMzNTwpuxiBT81JwCotmK0ryMo8SYn4LpQszrphzEl12fVbkLhljE+XEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

DQoNCj4gT24gRGVjIDIyLCAyMDI1LCBhdCA4OjEy4oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIERlYyAyMiwgMjAyNSBh
dCAwNzo0NDowN1BNIC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IEZpeCBpbmNvcnJl
Y3Qgb3BlcmF0b3IgcHJlY2VkZW5jZSBpbiB0aGUgY29uZGl0aW9uYWwgdGhhdCBkZXRlcm1pbmVz
DQo+PiB3aGVuIHRvIGNhbGwgZXhwX2N1cnJlbnQoKSBkdXJpbmcgdG9ydHVyZSB0ZXN0aW5nLiBU
aGUgbW9kdWxvDQo+PiBieSAweGZmIGFwcGVhcnMgdG8gZG8gbm90aGluZy4NCj4+IA0KPj4gRml4
IGJ5IGFkZGluZyBwYXJlbnRoZXNlczoNCj4+IA0KPj4gICAgISh0b3J0dXJlX3JhbmRvbSgmcmFu
ZCkgJSAweGZmKQ0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2VsIEZlcm5hbmRlcyA8am9lbGFn
bmVsZkBudmlkaWEuY29tPg0KPiANCj4gR29vZCBleWVzLCB0aGFuayB5b3UhDQo+IA0KPiBVbmZv
cnR1bmF0ZWx5LCBDaHJpcyBNYXNvbiBiZWF0IHlvdSB0byBpdDoNCj4gDQo+IDUwZDhhNWQyYTk0
YyAoInJjdXRvcnR1cmU6IENvcnJlY3RseSBjb21wdXRlIHByb2JhYmlsaXR5IHRvIGludm9rZSAt
PmV4cF9jdXJyZW50KCkiKQ0KPiANCj4gSSB3aWxsIGFkZCB5b3VyIFJlcG9ydGVkLWJ5IHRvIHRo
YXQgY29tbWl0IG9uIG15IG5leHQgcmViYXNlLg0KDQpBaCwgbmljZSB0aGFua3MuDQoNCiAtIEpv
ZWwNCg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBhdWwNCj4gDQo+
PiAtLS0NCj4+IGtlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIHwgNCArKy0tDQo+PiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0
IGEva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMgYi9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYw0KPj4g
aW5kZXggODI1ODhjZWVkOWRhLi45ODczYTFkNTRjNDYgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwv
cmN1L3JjdXRvcnR1cmUuYw0KPj4gKysrIGIva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMNCj4+IEBA
IC0xNzQ5LDcgKzE3NDksNyBAQCByY3VfdG9ydHVyZV93cml0ZXIodm9pZCAqYXJnKQ0KPj4gICAg
ICAgICAgICAgICAgICAgIHVsb1tpXSA9IGN1cl9vcHMtPmdldF9jb21wX3N0YXRlKCk7DQo+PiAg
ICAgICAgICAgICAgICBncF9zbmFwID0gY3VyX29wcy0+c3RhcnRfZ3BfcG9sbCgpOw0KPj4gICAg
ICAgICAgICAgICAgcmN1X3RvcnR1cmVfd3JpdGVyX3N0YXRlID0gUlRXU19QT0xMX1dBSVQ7DQo+
PiAtICAgICAgICAgICAgICAgIGlmIChjdXJfb3BzLT5leHBfY3VycmVudCAmJiAhdG9ydHVyZV9y
YW5kb20oJnJhbmQpICUgMHhmZikNCj4+ICsgICAgICAgICAgICAgICAgaWYgKGN1cl9vcHMtPmV4
cF9jdXJyZW50ICYmICEodG9ydHVyZV9yYW5kb20oJnJhbmQpICUgMHhmZikpDQo+PiAgICAgICAg
ICAgICAgICAgICAgY3VyX29wcy0+ZXhwX2N1cnJlbnQoKTsNCj4+ICAgICAgICAgICAgICAgIHdo
aWxlICghY3VyX29wcy0+cG9sbF9ncF9zdGF0ZShncF9zbmFwKSkgew0KPj4gICAgICAgICAgICAg
ICAgICAgIGdwX3NuYXAxID0gY3VyX29wcy0+Z2V0X2dwX3N0YXRlKCk7DQo+PiBAQCAtMTc3MSw3
ICsxNzcxLDcgQEAgcmN1X3RvcnR1cmVfd3JpdGVyKHZvaWQgKmFyZykNCj4+ICAgICAgICAgICAg
ICAgICAgICBjdXJfb3BzLT5nZXRfY29tcF9zdGF0ZV9mdWxsKCZyZ29baV0pOw0KPj4gICAgICAg
ICAgICAgICAgY3VyX29wcy0+c3RhcnRfZ3BfcG9sbF9mdWxsKCZncF9zbmFwX2Z1bGwpOw0KPj4g
ICAgICAgICAgICAgICAgcmN1X3RvcnR1cmVfd3JpdGVyX3N0YXRlID0gUlRXU19QT0xMX1dBSVRf
RlVMTDsNCj4+IC0gICAgICAgICAgICAgICAgaWYgKGN1cl9vcHMtPmV4cF9jdXJyZW50ICYmICF0
b3J0dXJlX3JhbmRvbSgmcmFuZCkgJSAweGZmKQ0KPj4gKyAgICAgICAgICAgICAgICBpZiAoY3Vy
X29wcy0+ZXhwX2N1cnJlbnQgJiYgISh0b3J0dXJlX3JhbmRvbSgmcmFuZCkgJSAweGZmKSkNCj4+
ICAgICAgICAgICAgICAgICAgICBjdXJfb3BzLT5leHBfY3VycmVudCgpOw0KPj4gICAgICAgICAg
ICAgICAgd2hpbGUgKCFjdXJfb3BzLT5wb2xsX2dwX3N0YXRlX2Z1bGwoJmdwX3NuYXBfZnVsbCkp
IHsNCj4+ICAgICAgICAgICAgICAgICAgICBjdXJfb3BzLT5nZXRfZ3Bfc3RhdGVfZnVsbCgmZ3Bf
c25hcDFfZnVsbCk7DQo+PiAtLQ0KPj4gMi4zNC4xDQo+PiANCg==

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794475251;
	b=F8w7qbk7oPl7VSnEk+JYmRmeQxaYfmDPVyQAZewtRy4lUljx3jCdl68Qxz3dYSngVF7v
	 y9/9FoXdTIFkNyZyqjU64BDmsAGTjRLNksq1Niwt5o5hiKxiBxNPt/j2fT/9tfQ8z2FDR
	 QCAKvC696WoDIZht7bbsvTSX0M6l4VQxfIEbutpeOsLOGXj6QLlMKtBBJ/+gaMZ+CLnUb
	 VdcHvYVGc9Baiv6HPCJ1XLiOaU3cRANnSJCqwLccqy3K0jo/5NMPAVFDH2upPvfglI050
	 43e5cm7bKDfQ7zHV1gU7paCDllW6694e4pzk8CiTLU3VBSBMzqUqeRtVINhrIm1RpnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475251;
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
	bh=CUOIzYYTP+/mto2sxzrukeC9qNwPh8nH5L/LSoVEqXU=;
	b=3eGk7JYanhgqCsXAJ3soBg2lGojNwo8Jb6fmOaCBDvomwusu0raviO3Zruc3p13P66SO
	 CDXXhQIE6oQqfyFd3BZ/18g0GWtTTkuQ0RTU8RfRd5Ivv0V+gFfnfBG1sk3stq2WYqWlI
	 IcTCI0nfUTHvNyHZ768pKiV+ePXSfTsMYCmzwp1JWlCF8Of7MZlmsu+wfNi1wTrDA/vP9
	 AApLPATAsXuueF2mn6tVpwLLYtLaDgeyWHGJhqEQrpD7VpYW8ePTMg/yCACUO1F3CMDvq
	 aA5uHWgqN6/lXRgH3FTiQfrRhGxPT/bPR9u/+RfAKff9Q0cheE2gqgyrDhRCE8Zl3Hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T6rUhg+k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.27
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FB606A31C;
	Thu, 12 Nov 2026 09:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD8FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T6rUhg+k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDC3iu2LIqotRnaqAVFzp7c+iiXuqFXL4Lo7RwFPxxFnENUUNlEHXoeTjZ3KJ4wEVxJJF87iDp0BjTPT0T8QRd92y4ySFL3r6BVUt9iWT9XmYekedGbMyTrvRPn4obagTq+XHFA20BxA8MlQlzWHhQdJUFGMMNV9BBp4AdwLH1YlD1nwZrrVIwASnBVwNsuxPNRLIpv5eRqLqa4y3pYwgXjRJWP2cFq5gavFDIK+1+AAv6Xb14JmlXFqEsHJZmJrLBwiX6ZKVO9O5xRGSiG9MVpkP/lE2S6ZgnOojmGiDNfD742PteijaadBkfDxgNINe1ql+4/lDWSZ6rblFwERaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUOIzYYTP+/mto2sxzrukeC9qNwPh8nH5L/LSoVEqXU=;
 b=j18CX4exlLUP4rUl24oZzIU9uA1xFNub5BPeC7Oy+1u5XDJQ4qjCxZMmV2r070o0MBHS4tzRgEIgRv/Y8ayMEEyMfA3UQPzsir+wflsL1XTfbVHaulpuy0B7cqbR2nJqlso/F/Fv2NaPkJgPgE3dTsMXWOgj2Et74qU394Wq6MSFsjR5V+CIvVfdLuAeO8B9RxzT1cFTgCQiPqp1ogYiO3wxzdVaBtkqawxGoSU/AjuE/def7cMqFlvscGqvQPtgZfcDPINFAkStGHPP9g/603U3n6Eh9v7Y4+LM0hxfIU+yxwrkG1X8WkEgALeDYIQWZuN7QY6iVIq+aNqrvUvLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUOIzYYTP+/mto2sxzrukeC9qNwPh8nH5L/LSoVEqXU=;
 b=T6rUhg+kh9JWL6bUmi3PS/yIJMhB7I+Mgx7RIGik+50TUWJXIWY26NRxnJg0/hiwQxETgSD8SSt/638LysfB1E9i5kBAiXa5InG98j9jMbtoOM29JPI7VvSEXdGjKbTizoYusZvwispTwictzwZ7/fOAWWkemlG0K0hd9fIHB3Va7EXtU8C4/hKiElQ2EIjmz6zj3AyUjLP/32/SEkVbpYiiGvfmwmjB/rS7gwUAsMxjea6zBsDvXcuCeQi8ChaE/HW6sRkLkXL/uPByIDTkiqJC2OYWWs0Ngr+/NGqBav6oC0CTe3XvCWiefPD9tEFv2gm0cjJPI/csv+aiAy0Mow==
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 09:20:48 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 09:20:48 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Vishal Chourasia <vishalc@linux.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"aboorvad@linux.ibm.com" <aboorvad@linux.ibm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"frederic@kernel.org" <frederic@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>, "sshegde@linux.ibm.com"
	<sshegde@linux.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "samir@linux.ibm.com"
	<samir@linux.ibm.com>
Subject: Re: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
Thread-Topic: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
Thread-Index: AQHc/H8hECvLTp81AECi76WnZl80CLY/t+iAgOtdTlg=
Date: Thu, 12 Nov 2026 09:20:47 +0000
Message-ID: <B6B9F4A3-954F-4FB5-B7E2-534CD785B18C@nvidia.com>
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
 <20260615042514.694993-4-vishalc@linux.ibm.com>
 <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
In-Reply-To: <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7742:EE_|LV0PR12MB999091:EE_
x-ms-office365-filtering-correlation-id: 37cbc0e1-293a-47fa-4c0c-08df409e3cde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|6133799003|10067099003|56012099006|4143699003|11063799006|261028144727099003|261021121427099003|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261021123027099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info:
 zSa8SBmDGmSGQZQq5AtjlfGvgh8V1SQgVxWtdfdITIR1ET9hjTY+wJF7STSs08v3H4Qz8j5DgvkOmlluchcG1VOiGrg8gcqkdNhV59HwhcVg9fw4vSvSx8BDic6p6/1p31M1E2cxe12NwS3r2I3sOqd+jQdiSlptj91eymo1eA0zYUVANgrQ0kfjehE08lA+DdKMZ5Q4QbngGxkDU0Dz4Hqp9kacRFo+02S7ZzJsaU6o6jJ+vgbU4Cz9Ab6oKe8Hm7s/kWvPDxVvfghCjQ/+BA4hqb/xGRy7/b8bBQdqdkxj2hTK4bH9BGlGvsapp/0Pkip2GSfY+rJCyYT14JX6Jk9Iex5sVshNTAPtgfggQFnYaFVGSJsCRTbM0AOVrGSeZpw7jBWzko95UQT5aW9x/BKE5QXVKLgkegAJhQQ/5EfxCesj2lxFtV8o7xKhDLt8j2ak9Z2hEl56VW4WfOd3SZBLhiZsd3jrNbc6yUHYu5w4YHJ0LMAUK95g7WgMgXgJuC1ghrKDENr/YrfwRoX2sapvKjvnnCxLy5NmjjT/My/rdSr3OmN7mk9AKdElZr1ErJxlYkt3lAnMsls0Lo9kAg5Xw/rK96Dg3Y4lUY2y9K5HDy9BYmuhrd0a67OprEu3uwQiXcwxkTMlIBFjwyJcEgQwZ02YqxIGYNKcijg+GvP1bNyxSlAEPtJnhlJLgQW3ZBsmiRa9nfVi7bI6o6gFwHe08sb6jjFs5c/mpkDzj5Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261021121427099003)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021123027099003)(261022075727099003)(261009223027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmo4VXJzWjdNd29ZNHU2UTNFS3pSMkc1dU1KVEc1QkpOczZPVFFsdGhydmlV?=
 =?utf-8?B?NVhLc1U2MVE1OXNiY1NsMEQ1dWRIYjVJRyswbTV6cGZSQjU2cE9sVllHaDIy?=
 =?utf-8?B?VHEvTUVhd0gxZzVFNFlPWCs0UC9IOU1GY0tzWnk3cXg1R1hqSVBibEdKT0hW?=
 =?utf-8?B?U01hWE43TER4bjJuY0JpTnphdm52RUU2dytFWGd1bkt2YVJXTml5cUdaMW5l?=
 =?utf-8?B?Yy9WY2l6U1UxRTdaclFOUys1RFFvN010ZW1HWGw2Ylc0Q2FsOUFJWVhPR2gx?=
 =?utf-8?B?OVloVkpJWkZYaERwZWRkQTNtZ2puditQa0xwd2psVFhJRWEyWHl2Y2RaZUtk?=
 =?utf-8?B?cFlkSWFGb1c3NjNVNmE4c2JNT3RSd21kUUE5R0pEeEwxcU85N3NweHhwMUdC?=
 =?utf-8?B?ZmpwbUZleXNMVUlWMlhnZmJOaXB2UlNMZHk5UUI4ZW5nR2dKbnVMbzJxOTJK?=
 =?utf-8?B?WUxQY040VXdXMHNGZVpaelQ2ayt4UUpJUXE4TXZkYmpRZ1laNEpSV3NmNzdz?=
 =?utf-8?B?NnBzTnJVandtdjdVeDYrdWFVQWJGaDYwc0RpeXNQaUZjYjdBSytCNm9USDBq?=
 =?utf-8?B?K3ZaVDlnb0g1V2JuNmRwWFB2T1FTUGUwVXpxREZNNytvMVphTm1JdlkyajFQ?=
 =?utf-8?B?T1hTdzMzTzMyWVROSldQbk9EcXBYaXdGRTZCUmoycE9jby91aEcxeHpYaHJG?=
 =?utf-8?B?K0JWb1o3ZDhwaWtGcXN6bG5OMjBJeXNkeXdKLzBZcE1YWlZBdXpFcU53V3Bt?=
 =?utf-8?B?emRINVVwWWtYOG9maHlUVjRsMGtNRVpmalhRNTZ3djBWcUYrcVpQT0M3bTR5?=
 =?utf-8?B?ZVNsQ0FadnVpZ05GT3BKZ3lEWSt5V2dCVXI5WmhSZ1ZTeXIxa1IycXZLeHRQ?=
 =?utf-8?B?SnBiSjRnMkFJUTgzM1MzVnB6S2MwTUZPUmM2bndhTlR2ajFTdEcrRGx5ZWNB?=
 =?utf-8?B?WG9NQXNHK1dzYlRhTEFOKzRZb2xUN1ZQY0gxNXFYblN2RXJwak1kS3d0WVpj?=
 =?utf-8?B?NGFDQWM4REJYZmk5bTdqYVRQR2l2TXFsL2cvTG01WnUvcU9YaDFhdU5xWUpa?=
 =?utf-8?B?QnRmN1RCMTJaSTlyMGM4SUg2QVdTelQ5YXZubldnVHFrRUhHam5landNNWlK?=
 =?utf-8?B?aHRSc2JaQ0VmMldWQWkweDBDSVFFMUxQcTcvKzBWMENDM1BEMWp0Y0gxbDdh?=
 =?utf-8?B?RXZUM2ZkZEZDdEl6UFgwZGtzNFZ3UUI3cFQ4UG43cHZ0d29kaThjNW5wNTBT?=
 =?utf-8?B?WTdaVHU3WkFuRmdYMUNhaUZRT0ZKUEdmQ3lFZDZTVFRHSFh2Vmh0NTJuellZ?=
 =?utf-8?B?QWZjVlJleXdLcGdsSW9EcG9SUXB3Z1FrM0JzSndXUmtJa0w1M3E4ZW83MktS?=
 =?utf-8?B?TGUyRUlrcHZ3STNqV21oWllZU2dqb2NYUW9EMVNTVEtVSlh1ZDloU3RqQk4w?=
 =?utf-8?B?NisvSUZUR2J3TDZTWDQ1ZmIwNms0eUtRRGdJbU9jQVVndFo2RDhUc2x5YW8y?=
 =?utf-8?B?NkF5Z1FMYUx5R1BSbGVPOGJoVXpnSnRyUytWZ2t3L2Z6MkJXMGI0SUZSbGVD?=
 =?utf-8?B?YkxaUlpCRkpRSkdoZldFdmV6aWQwaU1lZk9abFhUWHlSL0l2a0hDeGE0emFn?=
 =?utf-8?B?cXBvQnVIRDFHZzVTK015ZU1pV3BrUm92SmkwQmZQbmozaDJodndvbGdLZnc5?=
 =?utf-8?B?QlJlNTVJVTF6eW92bS9Dd1kzdG14QmtHTktEdUIvY0IrRkNtVDdqT2RyMjkz?=
 =?utf-8?B?eDRCUFBOS0ZvbG9wdW5WMFNJZm1MY0hjQ3hmZzJKdHNFOVB5L0h2SnozZ2Fi?=
 =?utf-8?B?WDdLR3o3ZTdCci9WOVNiZGtkeTgxK2ZNMjh5RS9iZnVHSy90U29DaTlFd1Bx?=
 =?utf-8?B?clJDb1ptN0lvVGpPUjdmamRYOTVPa1A5Z0krOHJoNllvVVJjVjdtSGV0UnJs?=
 =?utf-8?B?VTJKclZsZ2MxSFFzSWxIUURST0xGZm5KZllrWXJTWmpUSEhzazRsM0VKNXBn?=
 =?utf-8?B?UVhHM3BXVHRSY1RQMnVWSE54OU1wSTMvdXQ2bUFJM2Uxd0Y2M2w5MUE3OW9O?=
 =?utf-8?B?TGNUVmN5Z1hzMEp3ZzVwd21ERjY5SEdYZ1VRa0pVQksyMDZNQmRCQU9qR0hx?=
 =?utf-8?B?dkRSVFF6bDAzaTE5akhDM3RTQSt2aVZNaWM5aG1YUEhzY2k1MDg3dWpPU3Av?=
 =?utf-8?B?OGhtVnU2K3A4SmxxN1FjaVdzV3VRRytqMXpSaG1uUG9qbm1NVFpLZkx4R1c2?=
 =?utf-8?B?WCt2SnNLaHB0U3FEaGRwR1huM2EzT1lKQ0FEVHhDMG81dWxERk4vNmFPZWtp?=
 =?utf-8?B?WFhsOW9kT2xQSlN6cGRJV3o0cGV2SGhSSGRXUUFCY3FMQWhYaEZRZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cbc0e1-293a-47fa-4c0c-08df409e3cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 09:20:47.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggC5cZ1//kQs34KFj435pIwDPUmAsedWXyysAF1wsbpJPXr7xczfwX9fqcUdK0HAkZxLdPTa6Ro3bN7bobnP5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091

DQoNCj4gT24gTm92IDEyLCAyMDI2LCBhdCAzOjMw4oCvQU0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIEp1biAxNSwgMjAyNiBh
dCAwOTo1NToxNkFNICswNTMwLCBWaXNoYWwgQ2hvdXJhc2lhIHdyb3RlOg0KPj4gT24gbGFyZ2Ug
aWRsZSBzeXN0ZW1zLCBjaGFuZ2luZyBzeXN0ZW0td2lkZSBTTVQgbGV2ZWwgdXNpbmcgdGhlIHN5
c2ZzDQo+PiBjb250cm9sIGludGVyZmFjZSBzdGlsbCB0YWtlcyBhcHByb3hpbWF0ZWx5IDQwLTU1
IG1pbnV0ZXMuIENoYW5naW5nIFNNVA0KPj4gbGV2ZWxzIGlzIGFuIHVzZXIgdHJpZ2dlcmVkIG9w
ZXJhdGlvbiBnZW5lcmFsbHkgZG9uZSB3aGVuIHN5c3RlbXMgYXJlDQo+PiBmYWlybHkgaWRsZS4g
VGhpcyBjYXVzZXMgdXNlcnMgdG8gYmUgYmxvY2tlZCBmcm9tIGRvaW5nIG90aGVyIHN1YnNlcXVl
bnQNCj4+IHdvcmsuDQo+PiANCj4+IEFuYWx5emluZyB0aGUgY29sbGVjdGVkIHByb2ZpbGUgZGF0
YSBkdXJpbmcgU01UIGxldmVsIHN3aXRjaCwgc2hvd2VkDQo+PiB0aGF0IENQVSBob3RwbHVnIG1h
Y2hpbmVyeSB3YXMgYmxvY2tlZCBvbiBzeW5jaHJvbml6ZV9yY3UoKSBjYWxscy4NCj4+IA0KPj4g
RXhwZWRpdGUgUkNVIGdyYWNlIHBlcmlvZHMgZm9yIHRoZSBlbnRpcmUgZHVyYXRpb24gb2YgdHJp
Z2dlcmVkIFNNVA0KPj4gc3dpdGNoIG9wZXJhdGlvbiB2aWEgdGhlIHN5c2ZzIGNvbnRyb2wgaW50
ZXJmYWNlLiBJbmRpdmlkdWFsIENQVSBob3RwbHVnDQo+PiBvcGVyYXRpb25zIHZpYSB0aGUgb25s
aW5lL29mZmxpbmUgaW50ZXJmYWNlIGFyZSBub3QgYWZmZWN0ZWQuDQo+PiANCj4+IE9uIGEgUFBD
NjQgc3lzdGVtIHdpdGggNDAwIENQVXM6DQo+PiANCj4+ICBTTVQ4IHRvIFNNVDE6DQo+PiAgICBi
ZWZvcmU6ICAxbTE0cw0KPj4gICAgYWZ0ZXI6ICAgMy4ycyAgICh+MjN4IGZhc3RlcikNCj4+IA0K
Pj4gIFNNVDEgdG8gU01UODoNCj4+ICAgIGJlZm9yZTogIDJtMjdzDQo+PiAgICBhZnRlcjogICAy
LjVzICAgKH41OHggZmFzdGVyKQ0KPj4gDQo+PiBPbiBhIGxhcmdlIGNvbmZpZyBzeXN0ZW0gd2l0
aCAxOTIwIENQVXMsIGNvbXBsZXRpb24gdGltZSBpbXByb3ZlcyBmcm9tDQo+PiB+MSBob3VyIHRv
IDUtNiBtaW51dGVzLg0KPj4gDQo+PiBUZXN0ZWQtYnk6IFNhbWlyIDxzYW1pckBsaW51eC5pYm0u
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IFNocmlrYW50aCBIZWdkZSA8c3NoZWdkZUBsaW51eC5pYm0u
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIENob3VyYXNpYSA8dmlzaGFsY0BsaW51eC5p
Ym0uY29tPg0KPiANCj4gRnJvbSBhbiBSQ1Ugdmlld3BvaW50Og0KPiANCj4gUmV2aWV3ZWQtYnk6
IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gDQo+IEkgYW0gZ3Vlc3Np
bmcgdGhhdCB5b3Ugd2lsbCBiZSB0YWtpbmcgdGhpcyB1cCBzb21lIG90aGVyIHBhdGgsIGJ1dCBp
Zg0KPiB5b3Ugd291bGQgbGlrZSBpdCB0byB0byB2aWEgUkNVLCBwbGVhc2UgbGV0IG1lIGtub3cu
DQoNCkkgZG8gZmVlbCB0aGVyZSBpcyBhIHN0cm9uZyBjYXNlLCBhcyB0aGUgY2hhbmdlIGlzIHNp
bXBsZSBhbmQgdGhlIHBlcmZvcm1hbmNlIGlzc3VlIGlzIGtpbmQgb2YgcmlkaWN1bG91cywgYW5k
IHRoZSBhdXRob3JzIGhhdmUgZG9uZSBkdWUgZGlsaWdlbmNlLiANCg0KU2luY2UgUGF1bCBoYXMg
cHJvdmlkZWQgaGlzIHRhZyBhbmQgSSBhbSBoZWxwaW5nIHdpdGggNy41IG1lcmdlIHdpbmRvdyBm
b3IgUkNVLCBJIHdpbGwgcnVuIHNvbWUgdGVzdHMgb24gdGhpcyAobm8gcHJvbWlzZXMpIGJ1dCBp
ZiBzb21lb25lIGRvZXMgbm90IHdhbnQgbWUgdG8gYXBwbHkgaXQgLSBtYXliZSBub3cgd291bGQg
YmUgYSBncmVhdCB0aW1lIHRvIHllbGwgYXQgbWUuDQoNCnRoYW5rcywNCg0KSm9lbCBGZXJuYW5k
ZXMNCg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBhdWwNCj4gDQo+
PiAtLS0NCj4+IGluY2x1ZGUvbGludXgvcmN1cGRhdGUuaCB8IDggKysrKysrKysNCj4+IGtlcm5l
bC9jcHUuYyAgICAgICAgICAgICB8IDQgKysrKw0KPj4ga2VybmVsL3JjdS9yY3UuaCAgICAgICAg
IHwgNCAtLS0tDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmggYi9p
bmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgNCj4+IGluZGV4IGJmYTc2NTEzMmRlOC4uYjZiY2NmMTMx
ZjFjIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oDQo+PiArKysgYi9p
bmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgNCj4+IEBAIC0xMTc4LDYgKzExNzgsMTQgQEAgcmN1X2hl
YWRfYWZ0ZXJfY2FsbF9yY3Uoc3RydWN0IHJjdV9oZWFkICpyaHAsIHJjdV9jYWxsYmFja190IGYp
DQo+PiBleHRlcm4gaW50IHJjdV9leHBlZGl0ZWQ7DQo+PiBleHRlcm4gaW50IHJjdV9ub3JtYWw7
DQo+PiANCj4+ICsjaWZkZWYgQ09ORklHX1RJTllfUkNVDQo+PiArc3RhdGljIGlubGluZSB2b2lk
IHJjdV9leHBlZGl0ZV9ncCh2b2lkKSB7IH0NCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcmN1X3Vu
ZXhwZWRpdGVfZ3Aodm9pZCkgeyB9DQo+PiArI2Vsc2UNCj4+ICt2b2lkIHJjdV9leHBlZGl0ZV9n
cCh2b2lkKTsNCj4+ICt2b2lkIHJjdV91bmV4cGVkaXRlX2dwKHZvaWQpOw0KPj4gKyNlbmRpZg0K
Pj4gKw0KPj4gREVGSU5FX0xPQ0tfR1VBUkRfMChyY3UsIHJjdV9yZWFkX2xvY2soKSwgcmN1X3Jl
YWRfdW5sb2NrKCkpDQo+PiBERUNMQVJFX0xPQ0tfR1VBUkRfMF9BVFRSUyhyY3UsIF9fYWNxdWly
ZXNfc2hhcmVkKFJDVSksIF9fcmVsZWFzZXNfc2hhcmVkKFJDVSkpDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvY3B1LmMgYi9rZXJuZWwvY3B1LmMNCj4+IGluZGV4IGJjNGY3YTliYTY0ZS4u
NjM1MWRhOWRmZmRjIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL2NwdS5jDQo+PiArKysgYi9rZXJu
ZWwvY3B1LmMNCj4+IEBAIC0yNjU4LDYgKzI2NTgsNyBAQCBpbnQgY3B1aHBfc210X2Rpc2FibGUo
ZW51bSBjcHVocF9zbXRfY29udHJvbCBjdHJsdmFsKQ0KPj4gICAgaW50IGNwdSwgcmV0ID0gMDsN
Cj4+IA0KPj4gICAgY3B1X21hcHNfdXBkYXRlX2JlZ2luKCk7DQo+PiArICAgIHJjdV9leHBlZGl0
ZV9ncCgpOw0KPj4gICAgZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4+ICAgICAgICBpZiAo
dG9wb2xvZ3lfaXNfcHJpbWFyeV90aHJlYWQoY3B1KSkNCj4+ICAgICAgICAgICAgY29udGludWU7
DQo+PiBAQCAtMjY4Nyw2ICsyNjg4LDcgQEAgaW50IGNwdWhwX3NtdF9kaXNhYmxlKGVudW0gY3B1
aHBfc210X2NvbnRyb2wgY3RybHZhbCkNCj4+ICAgIH0NCj4+ICAgIGlmICghcmV0KQ0KPj4gICAg
ICAgIGNwdV9zbXRfY29udHJvbCA9IGN0cmx2YWw7DQo+PiArICAgIHJjdV91bmV4cGVkaXRlX2dw
KCk7DQo+PiAgICBjcHVfbWFwc191cGRhdGVfZG9uZSgpOw0KPj4gICAgcmV0dXJuIHJldDsNCj4+
IH0NCj4+IEBAIC0yNzA0LDYgKzI3MDYsNyBAQCBpbnQgY3B1aHBfc210X2VuYWJsZSh2b2lkKQ0K
Pj4gICAgaW50IGNwdSwgcmV0ID0gMDsNCj4+IA0KPj4gICAgY3B1X21hcHNfdXBkYXRlX2JlZ2lu
KCk7DQo+PiArICAgIHJjdV9leHBlZGl0ZV9ncCgpOw0KPj4gICAgY3B1X3NtdF9jb250cm9sID0g
Q1BVX1NNVF9FTkFCTEVEOw0KPj4gICAgZm9yX2VhY2hfcHJlc2VudF9jcHUoY3B1KSB7DQo+PiAg
ICAgICAgLyogU2tpcCBvbmxpbmUgQ1BVcyBhbmQgQ1BVcyBvbiBvZmZsaW5lIG5vZGVzICovDQo+
PiBAQCAtMjcxNyw2ICsyNzIwLDcgQEAgaW50IGNwdWhwX3NtdF9lbmFibGUodm9pZCkNCj4+ICAg
ICAgICAvKiBTZWUgY29tbWVudCBpbiBjcHVocF9zbXRfZGlzYWJsZSgpICovDQo+PiAgICAgICAg
Y3B1aHBfb25saW5lX2NwdV9kZXZpY2UoY3B1KTsNCj4+ICAgIH0NCj4+ICsgICAgcmN1X3VuZXhw
ZWRpdGVfZ3AoKTsNCj4+ICAgIGNwdV9tYXBzX3VwZGF0ZV9kb25lKCk7DQo+PiAgICByZXR1cm4g
cmV0Ow0KPj4gfQ0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmN1LmggYi9rZXJuZWwvcmN1
L3JjdS5oDQo+PiBpbmRleCBmYTZkMzBjZTczZDEuLmQ2YTYzZWU2MGJjMCAxMDA2NDQNCj4+IC0t
LSBhL2tlcm5lbC9yY3UvcmN1LmgNCj4+ICsrKyBiL2tlcm5lbC9yY3UvcmN1LmgNCj4+IEBAIC01
MjEsOCArNTIxLDYgQEAgZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4+IHN0YXRpYyBpbmxpbmUgYm9vbCByY3VfZ3BfaXNfbm9ybWFsKHZvaWQpIHsgcmV0dXJuIHRy
dWU7IH0NCj4+IHN0YXRpYyBpbmxpbmUgYm9vbCByY3VfZ3BfaXNfZXhwZWRpdGVkKHZvaWQpIHsg
cmV0dXJuIGZhbHNlOyB9DQo+PiBzdGF0aWMgaW5saW5lIGJvb2wgcmN1X2FzeW5jX3Nob3VsZF9o
dXJyeSh2b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCByY3Vf
ZXhwZWRpdGVfZ3Aodm9pZCkgeyB9DQo+PiAtc3RhdGljIGlubGluZSB2b2lkIHJjdV91bmV4cGVk
aXRlX2dwKHZvaWQpIHsgfQ0KPj4gc3RhdGljIGlubGluZSB2b2lkIHJjdV9hc3luY19odXJyeSh2
b2lkKSB7IH0NCj4+IHN0YXRpYyBpbmxpbmUgdm9pZCByY3VfYXN5bmNfcmVsYXgodm9pZCkgeyB9
DQo+PiBzdGF0aWMgaW5saW5lIGJvb2wgcmN1X2NwdV9vbmxpbmUoaW50IGNwdSkgeyByZXR1cm4g
dHJ1ZTsgfQ0KPj4gQEAgLTUzMCw4ICs1MjgsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcmN1X2Nw
dV9vbmxpbmUoaW50IGNwdSkgeyByZXR1cm4gdHJ1ZTsgfQ0KPj4gYm9vbCByY3VfZ3BfaXNfbm9y
bWFsKHZvaWQpOyAgICAgLyogSW50ZXJuYWwgUkNVIHVzZS4gKi8NCj4+IGJvb2wgcmN1X2dwX2lz
X2V4cGVkaXRlZCh2b2lkKTsgIC8qIEludGVybmFsIFJDVSB1c2UuICovDQo+PiBib29sIHJjdV9h
c3luY19zaG91bGRfaHVycnkodm9pZCk7ICAvKiBJbnRlcm5hbCBSQ1UgdXNlLiAqLw0KPj4gLXZv
aWQgcmN1X2V4cGVkaXRlX2dwKHZvaWQpOw0KPj4gLXZvaWQgcmN1X3VuZXhwZWRpdGVfZ3Aodm9p
ZCk7DQo+PiB2b2lkIHJjdV9hc3luY19odXJyeSh2b2lkKTsNCj4+IHZvaWQgcmN1X2FzeW5jX3Jl
bGF4KHZvaWQpOw0KPj4gdm9pZCByY3VwZGF0ZV9hbm5vdW5jZV9ib290dXBfb2RkbmVzcyh2b2lk
KTsNCj4+IC0tDQo+PiAyLjU0LjANCj4+IA0K

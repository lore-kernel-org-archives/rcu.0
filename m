Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594736;
	b=1oDybbf6tYvgbMRvU5HrHfbgBZRBO2/kg9fSn0wqDt18Jj6SmSBSwfOqn06VkN/Fmzar
	 2yKB87/8M5RiV95P+mNfgUKvhdEUdaqGZCtjQ0bflGtBf5MFHWiP9db+QihGeXhlGGd8G
	 qZBMKOOvUa+hMYLATu8t/UVPCCKkvxHbWfeW+BWyJhLIRBm7qreiSKqhJ11O67zG2IBu3
	 HH4hnaxrgV1HOJG2MmO2jZKlAN0PFwK0Egn9CGNjjYRTVh3LqQ0TiP72NLoJY84Qoxgkc
	 B+9waWrc5+THqaMp5ggJ+cc5UW6ekeJ5PZ5SaRBj/OW9mPgLI+v732OJbK+1/aXFphw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594736;
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
	bh=VF08BjdspcNGlTCZiVYWKM76dBdzKIRpHaN2wTpOzdo=;
	b=MM3LUPcgQCYNnPJQkdbU6dL78qkkRFHGIfcp0leFTLJd60K+2W5oKOgd8GxwTVuPwkDI
	 K7xbqJCb2ASy6deuWyMD3PkHmVFM22jR0q62DChF4Un+K2q3pZcqbIqV8kTSOUspbD5HW
	 stIxwZ3DVDsOk14Eg5I9f1l1/67XZofDOP8b4AGLrYcfM9zX80mPLRJaQTfzAE5PdouM7
	 0oOopLc7ZtwFObU70JLEgPOS9lgmybEuFfSbOJwEsev7LlkoVXZ2viDP8klgazgNioRe5
	 AGb4XZ4pKHsOVuBeUlC0qbFf/YcA1TaypQpBFXZuMhdUvwc9RXL86mijm+s3E5Us1kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RHqWOIew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E62606A31E;
	Wed, 25 Nov 2026 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E62606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RHqWOIew
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE9CW9cC7RyBZcNa2v0M1cxTCkpnj180MwVH5qkrwbQYTS3AjrTUA8EXYEndYlerm8xh8j/wqRWw2iGrJX7EfrqTgKXZz1OoUbwL4EqyRYSaAchJrCL8e2rkBd82iiAWYh0la9mbw2dS4k1zABNONOouJ1sBoukF1TALlLcoAx9bcQeNhgNxsFGMLjSGrFTWhGHCTFWLtSuVoetL2nsy9bWc3EN6siDOzLlY1zVnaknQGATOAsCE7Y0gFQQ5+C5bDITgs8xppbmQPoQZaBnqr6uin6bDlh1Me4SPLN0qeTA88yZ8Gxw3lxNJd7JML4AafhUJb5RN2Q1q6nWGqIGWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF08BjdspcNGlTCZiVYWKM76dBdzKIRpHaN2wTpOzdo=;
 b=dxGw2m7b06YYV/ARXw3gy11EMtTF/WtLQbO86IYicksOId4k7l9vncWz9qEwyNMbStqRpUs5hXdKhDrWLxV4pu+kwDB+ixjHH2f+fAvMrPWMlXKjfinVBT+lrSA/RuRItoWAwCOrRIJWFaIDo8So3bWlpM44/N7JISbt/ccp/M9QucWztJG9nLBMaP8SaGmZ/mhMLtg67ohyxZ7CYfxTOiwO3jPENoDiNb5ToJRrt9ZC49fApgB6Ben+JjZf0UnPrDrko6xCM/JD4tc408//Sq7TuouhYMew3TMyZbl9XENDXSPm0eTnnzg21xqf1feEY0yNai+h1ZV1g40M0T9Wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF08BjdspcNGlTCZiVYWKM76dBdzKIRpHaN2wTpOzdo=;
 b=RHqWOIewrNOSt+95+XLLbdOjrBPlD5tHSIUQK+e9MN7aNqP2taABaeRUcRkjbl0HjwrA1ZLh6ecP3t+2zGZ7jbjga5yfoEg9ikdsqLp0M0nSyci6KnGHVTDBIO09/zflzx7fgDusViVLbrBp2/W7wem71X3KjsvQc38Z123id5wAi7Xcd/N3X1PgSm68NWnSEdGS4XTt+DiOmbjP7lHlK78xQMD7sYw1Uj350xzUJZAJpRDwATMVN8qjM0BAF2Z5+ZUeBngsgvbTreW/ue012K5chrrZyhxVMQQ37EZTHsF/zVDoijmBDG4tlgA/WsaIThoseuxmf5LZDJ/4eUEPpA==
Received: from LV0PR12MB008041.namprd12.prod.outlook.com
 (2603:10b6:408:3f0::14) by MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 25 Nov
 2026 08:18:52 +0000
Received: from LV0PR12MB008041.namprd12.prod.outlook.com
 ([fe80::b914:d7e5:4df9:89cb]) by LV0PR12MB008041.namprd12.prod.outlook.com
 ([fe80::b914:d7e5:4df9:89cb%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 08:18:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kartikeya Dwivedi Kumar <memxor@gmail.com>, John
 Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Bradley
 Morgan <bradley.morgan@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf
 id deny list
Thread-Topic: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf
 id deny list
Thread-Index: AQHdfKFpk4NwkI4GyUyUlxKYr4EDv7c+cfJ5
Date: Wed, 25 Nov 2026 08:18:51 +0000
Message-ID: <E03F487E-3E0D-4FE8-9BD4-F2ABAC7213B4@nvidia.com>
References: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR12MB008041:EE_|MN2PR12MB4128:EE_
x-ms-office365-filtering-correlation-id: aeaa421a-6640-4f23-cc35-08df4accbd4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|260925022911599003|56012099006|11063799006|261026140227099003|260925021311599003|261102123227099003|260925021911599003|261028144727099003|261021121427099003|261022105027099003|10067099003|38070700021|261021123027099003|261022075727099003;
x-microsoft-antispam-message-info:
 BCFnx8Fa4iZXkgLg357EM4rd9eCGx69UWmvlj0t2ZU9B43+De9KYU3AC39jak5NlKl1rvj8yA9JRXKV9+MZqKs2KyHzejwUahRqqttm7iCzYy/soUwBfKKTOpg2R4LAtqDg3ERhqUKkbAkjVP8Kf7HfcTXMzRax+ut4S6f1+hmdVLJ/if57AsrnNxMJYbQmH9ezgl2W/2qR/5Qr6Vw4cEmjYus4M5JT0BAfGKHfQaYkQpkCmX3TnVvn28uReI4rA9TWC9uiAuLMKlVZu19fISdd1lgsB/wpNBGpCtIYhmjyEeTxOqfxTU7jTx1l2hMnBKhIhIuIh1VFM1xYKF7kbp6nKHJs3FosLTAjVDkQ0LOH1w4m7Mtg9hmMWHYnxxWEUrqUOYAARVTyi15xetnDg5KKQ3vQOvUOI9fojU1ktwENQEBaQYNxYBhTnRQQyKv+jEQkpCaJqQYq4jAEHQ7GTHgHqFHPX+JrqB7Z77dRejwu6Qb+6QBHQzfkxpRkbTHmy/3KgFI9wxTKmUk6SDty75CIUKrfwzh/Ws0B25mxKmGBobzYxdB9ls8KJA6KKJR9V15yPlqkxyVXxdJWJnPkrml9pnLo10zDvZ/DNdlnqowQTNQ6vL9jbMR++pEcZga5VeWq+iqRXHs98RqK9veam2o7t+N743Wy6OCsD3jxii3pOH1AwgA/4woi66S/MulCZQn9vP+5NEcq9ng/ewFnU2Ww8JpwxX/5+xiTfpBS9wlA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB008041.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(260925022911599003)(56012099006)(11063799006)(261026140227099003)(260925021311599003)(261102123227099003)(260925021911599003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(38070700021)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhocml1T0g5UEJlVy9UdDFONkk1enEzeUgyQmVvM2FhV2VScmdnSTIzMm1v?=
 =?utf-8?B?NmZBMnpDbXlzeEpHL0dNUW1JeHE1RERwTVo2Nzhsb2tMWFF2ZWlHbC9XSjBw?=
 =?utf-8?B?TzJ2ajlWM2xTSVNUeGNvVENjamlOUUI2TUNvS3g4ZlJoMEFTSnRjOHR3WnpD?=
 =?utf-8?B?Y2prbExiODRyczh2d0dhQ3lOd0FUWHB1eHRMK0FUVGc0Z3JRN3dkdFBqL0xU?=
 =?utf-8?B?VE9oL20zdGQvZFBqa01tSzdRalQreHZjeTQwdjJ3UWlmU0c3dnlFckNlMEFk?=
 =?utf-8?B?WHNleTFTcXdDbzRPSHd2RHE3TnRTdzZ0ZTBESW15TDF3MDZMTjMrZDhHaXpu?=
 =?utf-8?B?dXNGbTBYV2dRWEdPa0NaL0YwWjRkQi9uUEFHQ3IvZm0vU0NkQ3JXWkFlMFlH?=
 =?utf-8?B?WEpsU2dqMkZOZTk4OSt4QzhKdkJjL3BrQlJyck9ZY2VlbVNlWFFNcGx5QXVH?=
 =?utf-8?B?NVYwY2owZEw0bStyOUQ2TWVObm9TZDhoZGVrMGRxTWNIaDJ6YldoNzV2dW85?=
 =?utf-8?B?SzlEKzZyZkhpSUZISWthY3l2M0I4SGhhcC93SDYvMGFYMjcybjRRQ2tJRE1p?=
 =?utf-8?B?OTllTTNPWXhRVExtREdvYzk3dUVkNktXUWxWejlJQkZpcFJwdUxtZlRWc3B6?=
 =?utf-8?B?SFB2WDRoWWtzalVIdHNkSEMrRDU1bmJEeDJ1ZU51ZmtCclhnREVCUUJ2Qjgw?=
 =?utf-8?B?Mnp2ZU1ZWUxkWU5TNE9wNlRYUytWTUhOa0xWbHE3eXRwZXZWVGxFNFJXNldo?=
 =?utf-8?B?ZFg3RjVRMzVoZjVqVStJWUsxNlNNWlBHbzNMWlVSbVdYbm90VFgvaTV6L0Ry?=
 =?utf-8?B?MVdvcjUyMDJiSDB1dWRyVEpua2x0a2tqVlVQbEhUOFBPSTEzWjd5aHZod1Na?=
 =?utf-8?B?S0hlNllGTUx2azhaam9OVE9UeFEvQzNMSkdnMW5CSkREaTM5RGRNUHJjZEJZ?=
 =?utf-8?B?SU9ndTY1akJBOHJ6V0p2dGlRU0hWUUdXNkVKNzFnV00vbFg0OHdTTlpQMDNv?=
 =?utf-8?B?RDV4TzU5NXp0eitid3RZR1gzZkpmU2Fhc2lKdTRveUVDeU9LQ0gzYkdkMnd2?=
 =?utf-8?B?S1ZrYlZaZ3FpdnBwTCtNTXh0Nk1rb21GdHJvdTVuRllPcUUxNFArS2FrTFRX?=
 =?utf-8?B?WE5IRisrS1FvNHdPRVA5OE9OVGJ6MHYvTnJKUWloWDlHbStxd3dRTkRBMnhE?=
 =?utf-8?B?SmVZTXE3RVc4YTdLbjkzS25tQmlEbVowS3FXT2Z5cDN1U2xZU2lrV21uOGpM?=
 =?utf-8?B?TytnVkMwdUNvZWtVelN2QlJSSDIzZXRsbVlwV0VNRzBVWXhFTXZzVjN5VktK?=
 =?utf-8?B?TERxRmVXekJVYVhHa2Rkd2I5dndHeEt3M1oxRmt3dzZPTWZYaGZTSTUxR3Vz?=
 =?utf-8?B?b1AwRitMK0d0aHNCMWw5eWdTRkpON0Q0WENsdXFaR1M5dmFDMW1LV21yK1Zy?=
 =?utf-8?B?OEdSUG5IT3M1QVJaMXo4R1RlV01mbzRWcTRYUi9IVmRJUjlxbHhmRm1DZ3Fl?=
 =?utf-8?B?RU1mUGRqaTRmNk5FNTVFRHlrWThZMFNBMWphbzRnN2NRVHBadmU2d1ZlVTg1?=
 =?utf-8?B?RUdPU0gyemU2TkVINGdjZDZhcm40SVdyWEo0ekF5a3RzRDdYQ1NIZzZISkhz?=
 =?utf-8?B?b1plYnd0Um53T1psZ2xmb0NPRTRMK0hvNXV0OE1HRUh3YW1nbFBSQWF6UUox?=
 =?utf-8?B?emtUMmNCTkJwQ3p2WUJ1WHAxRVFpWk85d242QjhUZkN0dnYrUzdMcVJ5czNH?=
 =?utf-8?B?emJnUVFpVC93cDBDcFFzbjJvZkZpOUY2cG9xZnQwblFVckFia3BvTzNGOUJk?=
 =?utf-8?B?OFJHNitkOGp5SC85WUVyK0NOWVlIa3N5L3l6ajZhcXV6NkkvbXZRTmhab0NU?=
 =?utf-8?B?OWZoKzBBSTg3cUJBYzZkaDFud0p4b3IzRE16dnczNndWT0xJMHlncnpYcmlO?=
 =?utf-8?B?TGNSRllrZ2NMcWNIWkJ4aTNHd2R0YllzMW4zR0tjZm5JVW1CVVNEZWJDZFhq?=
 =?utf-8?B?ZWxBckNFaTRCQUh5eTZmQnZUUUwvaW5kKy9tQjVUNmFDNjZjdlYvZktTbmlj?=
 =?utf-8?B?U2RwT3c0dHNCVFpSMlN6bS9jTnVCdEZvckVPMmh6NTEyZWl6UDV2T2lGZEdM?=
 =?utf-8?B?NUx5cFQ5Q1YvU21BdXBreGFvV3czMGxxSGRobVU0QllQSjdyY2xwKzYyTkNn?=
 =?utf-8?B?UUgzTUlta1RFUnBDWmdFbERVV1k5T05QblZVazZTZnRGSGtpaDJDa0dtZjRo?=
 =?utf-8?B?ZWFLdFlWRzByN1NHNGFhNGxBaHNad2ZreWc1dmNJM3BQTzU5OW96QTVUVklK?=
 =?utf-8?B?NzJxZnBCNVkyZmJGMElrNXJQNjNJNDJycWp4WXBOYW4rdmNOa1F1UT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB008041.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa421a-6640-4f23-cc35-08df4accbd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 08:18:51.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luRiTI66quIbgavPpncPfAdXNwI2Uunf98CQKedMVqbMnBIUx/XxrH60Jr3Eox2tyKXmDx43iI9btaVE79PzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

DQoNCj4gT24gTm92IDI1LCAyMDI2LCBhdCAxMjo1NOKAr0FNLCBTZWNoYW5nIExpbSA8cmhrcnFu
d2s5OEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/VGhlIEJQRiB0cmFtcG9saW5lIHRha2Vz
IGFuZCBkcm9wcyB0aGUgUkNVIHJlYWQgbG9jayBpdHNlbGYuIFdoZW4gdGhlDQo+IG91dGVybW9z
dCByY3VfcmVhZF91bmxvY2soKSBmaW5kcyAtPnJjdV9yZWFkX3VubG9ja19zcGVjaWFsLnMgc2V0
LCBpdA0KPiBjYWxscyByY3VfcmVhZF91bmxvY2tfc3BlY2lhbCgpLiBJZiBhIGZlbnRyeSBwcm9n
cmFtIGlzIGF0dGFjaGVkIHRvDQo+IHJjdV9yZWFkX3VubG9ja19zcGVjaWFsKCksIHRoZSB1bmxv
Y2sgb24gdGhlIHRyYW1wb2xpbmUgZXhpdCBwYXRoIHN0aWxsDQo+IHNlZXMgLnMgc2V0IGFuZCBj
YWxscyByY3VfcmVhZF91bmxvY2tfc3BlY2lhbCgpIGFnYWluLCB3aGljaCByZWN1cnNlcw0KPiB1
bnRpbCB0aGUgc3RhY2sgb3ZlcmZsb3dzOg0KPiANCj4gIEJVRzogVEFTSyBzdGFjayBndWFyZCBw
YWdlIHdhcyBoaXQgYXQgZmZmZmM5MDAwMTY1N2ZmOA0KPiAgLi4uDQo+ICAgYnBmX3RyYW1wb2xp
bmVfNjQ0MjU3NTYyMisweDVlLzB4YWMNCj4gICByY3VfcmVhZF91bmxvY2tfc3BlY2lhbCsweDUv
MHg0OTANCj4gICBfX3JjdV9yZWFkX3VubG9jaysweDljLzB4MTIwDQo+ICAgcmN1X3JlYWRfdW5s
b2NrX21pZ3JhdGUrMHg5My8weDIyMA0KPiAgIGJwZl90cmFtcG9saW5lXzY0NDI1NzU2MjIrMHg1
ZS8weGFjDQo+ICAgcmN1X3JlYWRfdW5sb2NrX3NwZWNpYWwrMHg1LzB4NDkwDQo+ICAgLi4uDQoN
CkNhbiB0aGlzIHByb2JsZW0gbm90IGhhcHBlbiBhbHNvIGlmIHlvdSBoYXZlIGFuIFJDVSByZWFk
LXNpZGUgY3JpdGljYWwgc2VjdGlvbiB3aXRoaW4gYW4gZnRyYWNlIHByb2JlIG9uIHNlbnNpdGl2
ZSBSQ1UgZnVuY3Rpb25zPyANCg0KSWYgeWVzLCBJIHdvbmRlciBpZiB3ZSBuZWVkIGEgbW9yZSBn
ZW5lcmFsIGZpeCB0aGFuIEJQRi1zcGVjaWZpYywgc3VjaCBhcyB1c2luZyBub3RyYWNlIG9uIHRo
ZSBzZW5zaXRpdmUgZnVuY3Rpb24uDQoNCj4gV2l0aCBmZXhpdCBpdCByZWN1cnNlcyBldmVuIGVh
cmxpZXIsIGZyb20gcGVyY3B1X3JlZl9nZXQoKSBpbg0KPiBfX2JwZl90cmFtcF9lbnRlcigpLCB3
aGljaCB0YWtlcyBhbmQgZHJvcHMgdGhlIFJDVSByZWFkIGxvY2sgYmVmb3JlIHRoZQ0KPiBwcm9n
cmFtIHJ1bnMuDQo+IA0KPiBfX3JjdV9yZWFkX3VubG9jaygpIGlzIGluIHRoZSBkZW55IGxpc3Qg
Zm9yIHRoZSBzYW1lIHJlYXNvbi4gQWRkDQo+IHJjdV9yZWFkX3VubG9ja19zcGVjaWFsKCkgdG9v
LiBJdCBpcyBzdGF0aWMgd2l0aCBvbmUgY2FsbGVyIGFuZCBnY2MNCj4gaW5saW5lcyBpdCwgd2hp
Y2ggbGVhdmVzIHRoZSBlbnRyeSB1bnJlc29sdmVkIGFuZCBicmVha3MgdGhlIGJ1aWxkIHdpdGgN
Cj4gQ09ORklHX1dFUlJPUj15LCBzbyBtYXJrIGl0IG5vaW5saW5lLg0KPiANCj4gcmN1X3VubG9j
a19uZWVkc19leHBfaGFuZGxpbmcoKSBhbHNvIHJ1bnMgd2l0aCAucyBzZXQuIEl0IGlzIG5vcm1h
bGx5DQo+IGlubGluZWQsIGJ1dCBhbiBvdXQtb2YtbGluZSBjb3B5IHdvdWxkIHJlY3Vyc2UgdGhl
IHNhbWUgd2F5LCBzbyBtYXJrIGl0DQo+IF9fYWx3YXlzX2lubGluZS4NCj4gDQo+IFN1Z2dlc3Rl
ZC1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogU2VjaGFuZyBMaW0gPHJoa3JxbndrOThAZ21haWwuY29tPg0KPiAtLS0NCj4gdjM6DQo+IC0g
TWFyayByY3VfcmVhZF91bmxvY2tfc3BlY2lhbCgpIG5vaW5saW5lIGZvciBnY2MgKEFsZXhlaSkN
Cj4gLSBNYXJrIHJjdV91bmxvY2tfbmVlZHNfZXhwX2hhbmRsaW5nKCkgX19hbHdheXNfaW5saW5l
IChBbGV4ZWkpDQo+IC0gRHJvcCBCcmFkbGV5J3MgUmV2aWV3ZWQtYnksIHNpbmNlIHRoZSBwYXRj
aCBub3cgY2hhbmdlcyBSQ1UNCj4gDQo+IHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYv
MjAyNjExMjUwNDAxMDYuMjIwMDYyOC0xLXJoa3JxbndrOThAZ21haWwuY29tLw0KPiB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcmN1LzIwMjYxMTI0MTg1NjU5LjEzNzA2NDQtMS1yaGtycW53
azk4QGdtYWlsLmNvbS8NCj4gDQo+IGtlcm5lbC9icGYvdmVyaWZpZXIuYyAgICB8ICAxICsNCj4g
a2VybmVsL3JjdS90cmVlX3BsdWdpbi5oIHwgMTIgKysrKysrKy0tLS0tDQo+IDIgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYw0KPiBpbmRleCBl
NzAxM2VkOGNhZGQuLjBlOGFmYzAyNTBiNSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2JwZi92ZXJp
Zmllci5jDQo+ICsrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYw0KPiBAQCAtMjQ3MzUsNiArMjQ3
MzUsNyBAQCBCVEZfSUQoZnVuYywgcHJlZW1wdF9jb3VudF9zdWIpDQo+ICNpZmRlZiBDT05GSUdf
UFJFRU1QVF9SQ1UNCj4gQlRGX0lEKGZ1bmMsIF9fcmN1X3JlYWRfbG9jaykNCj4gQlRGX0lEKGZ1
bmMsIF9fcmN1X3JlYWRfdW5sb2NrKQ0KPiArQlRGX0lEKGZ1bmMsIHJjdV9yZWFkX3VubG9ja19z
cGVjaWFsKQ0KPiAjZW5kaWYNCj4gQlRGX1NFVF9FTkQoYnRmX2lkX2RlbnkpDQo+IA0KPiBkaWZm
IC0tZ2l0IGEva2VybmVsL3JjdS90cmVlX3BsdWdpbi5oIGIva2VybmVsL3JjdS90cmVlX3BsdWdp
bi5oDQo+IGluZGV4IGFlNWQyMWJhZTdiYy4uNDA5OTZkYzI5YjI4IDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gKysrIGIva2VybmVsL3JjdS90cmVlX3BsdWdpbi5o
DQo+IEBAIC02ODksMTAgKzY4OSwxMCBAQCBzdGF0aWMgdm9pZCByY3VfcHJlZW1wdF9kZWZlcnJl
ZF9xc19oYW5kbGVyKHN0cnVjdCBpcnFfd29yayAqaXdwKQ0KPiAgKg0KPiAgKiBSZXR1cm5zIHRy
dWUgaWYgZXhwZWRpdGVkIHByb2Nlc3Npbmcgb2YgdGhlIHJjdV9yZWFkX3VubG9jaygpIGlzIG5l
ZWRlZC4NCj4gICovDQo+IC1zdGF0aWMgYm9vbCByY3VfdW5sb2NrX25lZWRzX2V4cF9oYW5kbGlu
ZyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHJjdV9kYXRhICpyZHAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJjdV9ub2Rl
ICpybnAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgYm9vbCBpcnFzX3dlcmVfZGlzYWJsZWQp
DQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgcmN1X3VubG9ja19uZWVkc19leHBfaGFu
ZGxpbmcoc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHJjdV9kYXRhICpyZHAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgcmN1X25vZGUgKnJucCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgaXJxc193ZXJlX2Rpc2FibGVkKQ0KPiB7DQo+ICAgIC8qDQo+ICAgICAqIENoZWNr
IGlmIHRoaXMgdGFzayBpcyBibG9ja2luZyBhbiBleHBlZGl0ZWQgZ3JhY2UgcGVyaW9kLiBJZiB0
aGUNCj4gQEAgLTc0NSw4ICs3NDUsMTAgQEAgc3RhdGljIGJvb2wgcmN1X3VubG9ja19uZWVkc19l
eHBfaGFuZGxpbmcoc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiAgKiBIYW5kbGUgc3BlY2lhbCBj
YXNlcyBkdXJpbmcgcmN1X3JlYWRfdW5sb2NrKCksIHN1Y2ggYXMgbmVlZGluZyB0bw0KPiAgKiBu
b3RpZnkgUkNVIGNvcmUgcHJvY2Vzc2luZyBvciB0YXNrIGhhdmluZyBibG9ja2VkIGR1cmluZyB0
aGUgUkNVDQo+ICAqIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uLg0KPiArICoNCj4gKyAqIG5v
aW5saW5lOiBidGZfaWRfZGVueSBpbiBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgbmVlZHMgaXQgaW4g
QlRGLg0KPiAgKi8NCg0KUGxlYXNlIGRyb3AgdGhpcyBjb21tZW50Lg0KDQpUaGFua3MuDQoNCg0K
PiAtc3RhdGljIHZvaWQgcmN1X3JlYWRfdW5sb2NrX3NwZWNpYWwoc3RydWN0IHRhc2tfc3RydWN0
ICp0KQ0KPiArc3RhdGljIG5vaW5saW5lIHZvaWQgcmN1X3JlYWRfdW5sb2NrX3NwZWNpYWwoc3Ry
dWN0IHRhc2tfc3RydWN0ICp0KQ0KPiB7DQo+ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAg
IGJvb2wgaXJxc193ZXJlX2Rpc2FibGVkOw0KPiAtLQ0KPiAyLjU2LjENCj4gDQo=

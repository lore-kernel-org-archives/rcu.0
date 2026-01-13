Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116637FF5F;
	Tue, 13 Jan 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294644; cv=fail; b=Sy6DmHXq1dvZ+Gu5OXSNq9lvLUFQitFKaqyw5yVOXb1o0EQqpTmgVPUMvlCN+uMuq4jz/YSoWBeFy4eB7KZN+UvJXRyFAu0JdaH6L2GxWXdP3zvye5KrB7AvqU20p2CjDmrmgYDO68/4BlBA61FL6N3DbFKcdMf/95EBoJKFDiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294644; c=relaxed/simple;
	bh=Pqw6IdLJlHcdswJ9k0r+WygMcRQeoWYqvCIkMG9AvTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ezm9otH4skatxfZ7MHo4Q4QsH98BZ5ZPk02dFb/W/WDbpwZdIJtRF0XtGr2jWPNqgT7nVS8d0pKlLfoc/ZlZaYoj3TlQNhzX9Luk0S8WYt7CWu64xN6UGbdmJ2a4Zxx7zoKrvy9soaYUnHVkMbogrLgYrxt8j9K2KduPj6ig+Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JV6t125a; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JV6t125a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqTCMTLwri0A4ZDfOKFgnEZ6jQlVdseYlyHs50OSpCTi2EFeIJvtXJISRgDSFhlgePxIsYlfBrEYHHSYcJDsmHr6i12sRhrP690l3zyD1CfY01db7VMgFCzJebFC7YZlN++1bgQpRpH5XIbjP7omhtx5a1/qOwRRItiw7vzRM3f59NR1JzeB7HwWpiAs1V3vDwEtATL75CPc9sBArwVbLLDVfr66Q/Qh8vj7TbB+jTxhugYwryl+4N/cPZoG8JFQQjVfmchnj6hMQx4LXhUvblmXCgomdMuykjJZPysNFZgUH6GomW0236jQbo7c2d5emP6VD6C2duLjv6HZQ8TS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqw6IdLJlHcdswJ9k0r+WygMcRQeoWYqvCIkMG9AvTo=;
 b=dq+G0N+KdNSr6r4aYUIYnSK5dbI554Ah21zQ2vrFkdzNLlGm2oNUQJ0gSCgY3qPp40f3lG6ENuTd2TqQ6fr2i352JP554dQ4KBtqeVaKaey7pQAAZllnTNuPkqZ2hHDOMGOXYlTxW8RN0lNN0ALM8XtsiJll0nM+a6P2EBo3Vu3h0cn5dMZIBmurvBJrRPSr9zu4FQT4freg7MZOcErVxWK0LSw+AjRpnz5pJ1Jt8ve1JZfPskhjKr624DEr+61KA6dDeXhDE7qPiMNws0iJn8J7vZanpm+fOSC/SPnZfab7EElcnpNhqz/iCk5ZQvHzrKiSP/0S2RsC3wkGvgw3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqw6IdLJlHcdswJ9k0r+WygMcRQeoWYqvCIkMG9AvTo=;
 b=JV6t125aXA4D5aKScB97nrvgq/8TAr7l6rg7uChNm+0/MeCKWqGO+f/jarXPYyO7vhxG++3FMjayie/XxdKXUVUOn4KNhcWfQL176s0xLNWkgdiyjcYBPByU4f0rQwzhnBvGc9w3W500HCZeyQVnzP80zsistbEWip/dEbXX5hl7dLE82UT2jWJJiN+l6ZMVNLY8LoiqHlWMYU09ZNgSgNITWiE4FowZJtZera3LypctCP2aTkisIvb8u0vbXi1uL+i0PQrq7scX9rpQ5dGL0CKx+bdr6NtWen71cbhkSktJONvM5P2H/xF2Ic1t9K954n4V6NrTp+Fsij180OZRzw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 08:57:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:57:20 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Uladzislau Rezki <urezki@gmail.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index:
 AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOT2cAgAAgEQCAAA83gIAANcGIgAAK3QCAAF3fAIAAGxUAgAAuMq2AACN3gIAARAUx
Date: Tue, 13 Jan 2026 08:57:20 +0000
Message-ID: <37372899-9CA4-455D-83EB-79A07294D34A@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
 <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
In-Reply-To: <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: b592ea3f-8006-4177-1299-08de5281c296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VElPMXhrWHJBblB4U3UyclBmUlJLQ0ZXeDFCcWM3S21EVGJQUEdiNm5hTTVI?=
 =?utf-8?B?enF1ZXF0cjQzYVhPRElLTjRKbUdQTVkrY1QzaFcvbnE0UmdkbGZ4TkVFOWl0?=
 =?utf-8?B?eUVrVGF3Wmc5RVo4QURoRkc3RnU1L3lKTEVQMUFOWlFRbXQ5U0s3bjcvS216?=
 =?utf-8?B?ZEdUWkM4OEcybE14K0RuZFFydmVNSXh5M09hL2RsSlNYa253OWsrYW9PT2tm?=
 =?utf-8?B?cGZieTF1R2Q0amtzajMwT1ZvZk50VFV1YVBYczJQR3lFamRFaDB6ZS9Vb3JL?=
 =?utf-8?B?WWdpaU9ySEt3RjRKVEpGNnZFZ2t1Wkp0Q2NBOHhRWmRMMS9UejF2YkFBbVhK?=
 =?utf-8?B?eCtsR1VrdVNmekN3UGh2eTA3TDRmYU5xQ29qMGZOUFhpSmh3L0pqSU82RDV1?=
 =?utf-8?B?c2ttL2JlaTNwN0dkYTk5NU14T2kyT0ZhYXl1MlpOYmczUHgwQmtsYWg4UGpw?=
 =?utf-8?B?bk93aEJZaWJqeWhKUmFpZHZSQ1ZmNUZhOVlWRFp3UGhpMDBNWlp6T2VLeFg0?=
 =?utf-8?B?MGlJT0YyVFduaXVJTWZqUHNGSkZWazdCZWkybGRGeUlDRk1LUmR0dkQ4OUVt?=
 =?utf-8?B?SFJQRzNWZnNhMW9UdlJ0OE81VTdKbVBnWUpnZDFSNlNJRnhuSDM3K24ydTJZ?=
 =?utf-8?B?b0tUZHQrMVlxRklpaitXNDB4b3VWaWs0U3phVVo4bFc1bW1YUkloV2EvcWVB?=
 =?utf-8?B?KysvQm41NmtPcURTbS9BOEN0RnJ2OGlERVRGdi8vaDdYRTVpSnZsbC9lczdM?=
 =?utf-8?B?ZlNZekZxenI0UU5WWE4zU0Vxdi8ycGh5aXJVaE1zZnpybFhCZXV1VHJjOXdo?=
 =?utf-8?B?T1hUK0RKVTlCTmJRNjNyaEVabUowMjlJZTNCZ2VRdEs2ZUQ1MjNQQXFUckEv?=
 =?utf-8?B?dG9PTXBONFJZc0REa29HYW1WTm8rcUx5TUo2aVV1SFlKRDFvakd6ZWU0dzJW?=
 =?utf-8?B?WTF0WS8yditvUlY4NzJ6dEJLeFVYbE1ISWtZQVhVRWxLRGZhTEJBQzRmSkFZ?=
 =?utf-8?B?d1NVMWl6VGpFSWlFbXJqWHNvSkc3YTBPa25rcmFXTjRhekxvMVowa0hLSDNp?=
 =?utf-8?B?QUFMbUJ5VWFRNnY5Y1FmS1Y4ejRaUmEwU2c0Yk5OZzZmR0w0Qk1VSHhBUHNS?=
 =?utf-8?B?dWFxMklKQmdsKzMrMVNJbVB3Yml5cTE4TkNMQmlQSXVNeHpOVkkzR2crd2VQ?=
 =?utf-8?B?dmRSV0g2QXk4djYrVzllQ1U1QXd4U0FJMUlmZVBJVHN4c2s5RU5tenpOZWlJ?=
 =?utf-8?B?c3dQMU9YWjlTRjd1bmNXVEo4V3ZWam5yNjlPajJuOEVPZjhjZFVsZkdIWkpZ?=
 =?utf-8?B?djIzQXBRSXZqZGc0NzNPYi9ieGppejRCeDVPUXE3SmhEM21nb05iK3phUGJt?=
 =?utf-8?B?UWJ2TU5abU1BR2xpVVV3Q1V1dUhRNlM1aXNkbkdqdDlHOXBVVDNIVlZCNWdQ?=
 =?utf-8?B?aEVkODBDSW1oM0R5M3E2UUgrK2VnVm5tdkM3eXlWakFtbmc2b012YnhmWGRT?=
 =?utf-8?B?RjduYjVBYU9FWGpoQ09NbThsY1BTYi81T0g1ZTMzNGJXbTFzb0ZYNVVzYTBI?=
 =?utf-8?B?YytVYll5T0dtZnM3YWRVdlZZbUZ2UjVSQWlzbW9NT2ZDN0cxUFlmQTQweENW?=
 =?utf-8?B?UHlMTmJ2dWJxNDMwZlNva1hXM0xIMG9Qbm5BM3JxemtRS1hydTg4cEg2N1hn?=
 =?utf-8?B?RUJBcDZzM3ZSMWdWc0R0QU1KT0toNVRWRFV5RVAzeFg5clFuQUVEK0JFV1Ji?=
 =?utf-8?B?M3JyMmFmTzlLcWVXWmQwYzBzQ1laV0xRNXVLZ0RHbllkR2NNUTJ0NUNGUkZo?=
 =?utf-8?B?ZkExVUJ4dTRBSW1STkRlY2pUN1NvMGgvZWNLbGZKNDNPUzZSdnRlV0phSzZs?=
 =?utf-8?B?QnlrQXRlQkJ4ZEcvNy9TUHQ5aThUYk1kK3pxTnhNbUFydGh2UzZCUTN1Z1M0?=
 =?utf-8?B?QVdZWmVGNzIwZmZwTnBiUFZVWE5BL25zak1MS0QrMUVGRWdaTGk1V3ltMG9h?=
 =?utf-8?B?aVJyZnM3SXVmNE92RGl2d0tzc3kyYWl5blIwSmY4Q1pUVUpTeVk1WWFZS1pM?=
 =?utf-8?Q?IAyyv6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUNKdzN4NitpODVnVXBSb09hZ3lMemNBdFI3SDZIcEQ3NzN2NG1EaFcyMStJ?=
 =?utf-8?B?bzNhclpTTFlmNnZoZEtadWtmRndxa0ZXejFlc3Y3c1RoeDl5TGhFMzNaZGRp?=
 =?utf-8?B?VFFGQ1diOFdoVU5HL3JzSDZlUGE1U3dDRzVnSitxWWdhOGtOUjJ6Zy9adEtE?=
 =?utf-8?B?L2V4QjVOTW1idTd2aSsycVBKY2lsOFo3MXErRng3K3FpSTJicDB5eWdlTytk?=
 =?utf-8?B?UWlpbVUrZXEyMUgvcU15NEV4bG9qUWJHRk8yc0RSNFJpODJaVVlmbHZRUWtH?=
 =?utf-8?B?bURxRDBwSlV0SHhEY2tSRFkwbVBzSHpaN0xjeFduc3dBa1dlbi8xb0hQMVR3?=
 =?utf-8?B?eFgwL3p4V241OFFSUEpQS01jRGtkVHB6cU5RekZMcFNYUVhlbzVyOFlIQUpr?=
 =?utf-8?B?dEl6QW45ZnV4bThZem5mK1hZSExmWlV6eHc5a3RrajQ5RFBtRW5EYU5qVDVh?=
 =?utf-8?B?MWNWY2pnLytEcVpQcmhkQkI5QXlIdE5QVktZOHFzVDZSWHFHUEFyZXNuWFVR?=
 =?utf-8?B?d1NTc00xQWltK3A2WHBTbEE4WkN5b2cxVUZpdDNwNVFTdWhJbWc0dnBiN1B2?=
 =?utf-8?B?cEdVVmFhVHhxSU9OQmV6bXJvcXZXL1Z1SU5VMG42VFB1MzgrTzU5ZktmQWNh?=
 =?utf-8?B?bm5jUkE1c09pSnZJMzR0d2dTWGQreTYxS2dYNWhILzYxcnMzQnRranlua2tq?=
 =?utf-8?B?UHJLTE5FQm9FVXQ3UDRFRFVxMXNoZHFNaExkTTFNRUFVUzN6L1V5Y0wzK01i?=
 =?utf-8?B?bWVzKzZjem56ekFTRFNmRFlTZGtNNC82bTZOQWhsZmUrdzVLVjUxNCt5UU8y?=
 =?utf-8?B?eGFFa003SUprZkk5UjhQL1JHdjVmOGlDNm9WQmZ4elJyZGV6ekNXRktEY1lk?=
 =?utf-8?B?eHY4ODdEUWNuWXg1ZVErYUg4bmlHUm9xV09yZ2QwVWRsS3ZJaW1WS01hZnd3?=
 =?utf-8?B?NWtGa21EY3p3d2dhQnM5dk96dWtFMEcrQ2JOd0tFUDQyL1RhV2ZEdU9QYWcv?=
 =?utf-8?B?UGt3cUlyOExlYk5POXBvVUR5d0JzVWg0WEpUbzFZYnQ2WTkwanBhSUV0cndP?=
 =?utf-8?B?LzhpMW0xQUszeHJ2bDArcURDVGdDcFMvR040S0VrWjhDL2p3SWttT2hjYVNH?=
 =?utf-8?B?SDJ1c1NFdnBwSU1IbjFqa1U2VFNOdm9kMlZrOEkvMG41alFIZGwyZFhPMVFp?=
 =?utf-8?B?UTFOdHdDNXJGb1R6QmxwQnNrRHVPRHljMTI2YUdJYlR3NkthZVFWOE01cGtz?=
 =?utf-8?B?TlhvVUx6RllBcXU2SGxPQWl2OVBqWnU0TkpVRjJSQmoyY2oyR2NBODdzano2?=
 =?utf-8?B?MWdaQ2lSVUlraDVadXlIWXZublBQenpUcmxuaHk4c283V2Z5aEgwNDUvNHcr?=
 =?utf-8?B?ZTkxbDU3S012MHVmWVJ1WVFRR280RXhrRTY3MkgwV3Bnd1VzQ1dMcU5IcTBF?=
 =?utf-8?B?d0xKR0VuYmVHS1M3UWdxcklMYk1Sd1ZsaG5UK0NKQ0V1WDhCeUpLM1hTb2Z4?=
 =?utf-8?B?M1c4eG9UZWlpWVBRQzFxNzlIbmlKZmRTQlU3VzRoTlVTdEorMlBZc2d6MEFO?=
 =?utf-8?B?Qk45Ukx2TGRsTVpLc0xtNE1CY0JGck00K1Z3WSt6bHJTOVVRS29TWlVzVW5l?=
 =?utf-8?B?K0ZPVmxpNXpQYzJDRmNUUThLa0creWxCVTNEd2luRks1SmJOVFljQ0EyQlpI?=
 =?utf-8?B?disrQXJFQjRaMlYzUmRMbnQ5OWVnVzhnYkdTeXIvaUxiOGZoMVY3S1E1dDFu?=
 =?utf-8?B?Q0Q0a01iWXFmZHZBcE50KzgraHNYNHNCcmExcFgxUmRFT3Z4OFJsY2JiNWU0?=
 =?utf-8?B?VUVyNnUzRmR0NHhYeUprMERtSExveFU2M1p5MHNBYWt1K1dKM3djZ3VXRVJC?=
 =?utf-8?B?UmdrODNSYWZzMHlQZmM5Y1ZJY3gxbnRxZVNsL05NUGdjVU9PMDFLekxTS0dC?=
 =?utf-8?B?aktyMVEzVGF4VkwwZm1nQUc5RCtoemYraElKVTJjVnVpdnFkMm94eFlEQ3I1?=
 =?utf-8?B?bEtuR0VaVTlma3hwMlMyMUdDMkVINkR0Z2lOSU9qWU8zTUZoRzJsZVRIQ2dl?=
 =?utf-8?B?RjdMbFBjQjRIOWxiQWYvdDhYdVphV0hjMk5LZzJwVWo0ZW50V1JwK2RVS3Y3?=
 =?utf-8?B?S3EyRVdQZld1a0ErMEpHYkZCMmZXUE9LdVBnUEhaSG5XaTUzb05LNDg0SFor?=
 =?utf-8?B?VnRuSzJoTTBPOXRRbDFrSkdmM0NpOGRIWGcrZEN6UGtMbm16aW9ySWlwODVo?=
 =?utf-8?B?bVBibHlkcFZXWk83ZmtuVEFyN1hqZDBzL1RTeTlDSEhKUzhuZ3hsMjZTWjlw?=
 =?utf-8?B?OXNQY0ZTeXhuSVNiZUpPR3NhbTN6U0hzakJTalBGejVVYXU1WWUxUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b592ea3f-8006-4177-1299-08de5281c296
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 08:57:20.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkbYMnIYWn+WTziakHEhgJRvxBOU/faT2mchH7aRM3R/a6wYA8IyJ+q+Ks6eMsaMYbqQ7hOGPvImfAGxxiz6PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCAxMTo1NeKAr1BNLCBTaHJpa2FudGggSGVnZGUgPHNz
aGVnZGVAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IaS4NCj4gDQo+IE9uIDEvMTMv
MjYgODoxNiBBTSwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+IA0KPiANCj4+Pj4+PiBBbm90aGVy
IHdheSB0byBtYWtlIGl0IGluLWtlcm5lbCB3b3VsZCBiZSB0byBtYWtlIHRoZSBSQ1Ugbm9ybWFs
IHdha2UNCj4+Pj4+PiBmcm9tIEdQIG9wdGltaXphdGlvbiBlbmFibGVkIGZvciA+IDE2IENQVXMg
YnkgZGVmYXVsdC4+Pg0KPj4+Pj4+IEkgd2FzIGNvbnNpZGVyaW5nIHRoaXMsIGJ1dCBJIGRpZCBu
b3QgYnJpbmcgaXQgdXAgYmVjYXVzZSBJIGRpZCBub3QNCj4+Pj4+PiBrbm93IHRoYXQgdGhlcmUg
YXJlIGxhcmdlIHN5c3RlbXMgdGhhdCBtaWdodCBiZW5lZml0IGZyb20gaXQgdW50aWwgbm93Lj4N
Cj4+Pj4+IFRoaXMgd291bGQgcmVxdWlyZSBpbmNyZWFzaW5nIHRoZSBzY2FsYWJpbGl0eSBvZiB0
aGlzIG9wdGltaXphdGlvbiwNCj4+Pj4+IHJpZ2h0PyAgT3IgYW0gSSB0aGlua2luZyBvZiB0aGUg
d3Jvbmcgb3B0aW1pemF0aW9uPyAgOy0pDQo+Pj4+PiANCj4+Pj4gWWVzIEkgdGhpbmsgeW91IGFy
ZSBjb25zaWRlcmluZyB0aGUgY29ycmVjdCBvbmUsIHRoZSBjb25jZXJuIHlvdSBoYXZlIGlzDQo+
Pj4+IHJlZ2FyZGluZyBsYXJnZSBudW1iZXIgb2Ygd2FrZSB1cHMgaW5pdGlhdGVkIGZyb20gdGhl
IEdQIHRocmVhZCwgY29ycmVjdD8NCj4+Pj4gDQo+Pj4+IEkgd2FzIHN1Z2dlc3Rpbmcgb24gdGhl
IHRocmVhZCwgYSBtb3JlIGR5bmFtaWMgYXBwcm9hY2ggd2hlcmUgdXNpbmcNCj4+Pj4gc3luY2hy
b25pemVfcmN1X25vcm1hbCgpIHVudGlsIGl0IGdldHMgb3ZlcmxvYWRlZCB3aXRoIHJlcXVlc3Rz
LiBPbmUgYXBwcm9hY2gNCj4+Pj4gbWlnaHQgYmUgdG8gbWVhc3VyZSB0aGUgbGVuZ3RoIG9mIHRo
ZSByY3Vfc3RhdGUuc3JzX25leHQgdG8gZGV0ZWN0IGFuIG92ZXJsb2FkDQo+Pj4+IGNvbmRpdGlv
biwgc2ltaWxhciB0byBxaGltYXJrPyBPciBwZXJoYXBzIHFoaW1hcmsgaXRzZWxmIGNhbiBiZSB1
c2VkLiBBbmQgdW5kZXINCj4+Pj4gbGlnaHRseSBsb2FkZWQgY29uZGl0aW9ucywgZGVmYXVsdCB0
byBzeW5jaHJvbml6ZV9yY3Vfbm9ybWFsKCkgd2l0aG91dCBjaGVja2luZw0KPj4+PiBmb3IgdGhl
IDE2IENQVSBjb3VudC4NCj4+Pj4gDQo+Pj4+IFRob3VnaHRzPw0KPj4+IA0KPj4+IE9yIG1haW50
YWluIG11bHRpcGxlIGxpc3RzLiAgU3lzdGVtcyB3aXRoIDEwMDArIENQVXMgY2FuIGJlIGEgYml0
DQo+Pj4gdW5mb3JnaXZpbmcgb2YgcHJldHR5IG11Y2ggYW55IGZvcm0gb2YgY29udGVudGlvbi4N
Cj4+IE1ha2VzIHNlbnNlLiBXZSBjb3VsZCBhbHNvIGp1c3QgaGF2ZSBhIHNpbmdsZSBsaXN0IGJ1
dCBhIG11Y2ggc21hbGxlciB0aHJlc2hvbGQgZm9yIHN3aXRjaGluZyBzeW5jaHJvbml6ZV9yY3Vf
bm9ybWFsIG9mZi4NCj4+IFRoYXQgd291bGQgYWRkcmVzcyB0aGUgY29udmV5b3IgYmVsdCBwYXR0
ZXJuIFZpc2hhbCBleHByZXNzZWQuDQo+PiB0aGFua3MsDQo+PiAgLSBKb2VsDQo+IA0KPiBXb3Vs
ZG4ndCB0aGF0IG1ha2UgbW9zdCBvZiB0aGUgc3luY19yY3UgY2FsbHMgb24gbGFyZ2Ugc3lzdGVt
DQo+IHdpdGggc3luY2hyb25pemVfcmN1X25vcm1hbCBvZmY/DQoNCkl0IHdvdWxkIGFuZCB0aGF0
IGlzIGV4cGVjdGVkLg0KDQo+IA0KPiBXaGF0cyB0aGUgY29zdCBvZiBkb2luZyB0aGlzPw0KDQpU
aGVyZSBpcyBubyBjb3N0LCB0aGF0IGlzIHRoZSBwb2ludCByaWdodC4gVGhlIHNjYWxhYmlsaXR5
IGlzc3VlIFBhdWwgaXMgcmVmZXJyaW5nIHRvIGlzIHRoZQ0KbGFyZ2UgbnVtYmVyIG9mIHdha2Ug
dXBzLiBZb3Ugd29udCBoYXZlIHRoYXQgaWYgdGhlIG51bWJlciBvZiBzeW5jaHJvbm91cyBjYWxs
ZXJzIGlzIHNtYWxsLg0KDQogLSBKb2VsDQoNCg0KDQo+IA0KPiAoTWUgbm90IGtub3dpbmcgbXVj
aCBhYm91dCByY3UgaW50ZXJuYWxzKQ0K

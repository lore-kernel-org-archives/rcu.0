Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA82BE644;
	Tue, 13 Jan 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308255; cv=fail; b=m0CgD4rAvF6MepUslaNlPK/hAFPsPWLq6A3DZnzMYcUsBajipN/BHbb02gN7NZEBxuzqui8GNi2DXkIdODeHrhmq12SAKeyyoZtkXG7AS/gzenPoYIIT5JycJQHDxZW2+wPU1RU/nr17XFZpFXz/319YTjzsRPzQIT0svE1kcpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308255; c=relaxed/simple;
	bh=IIMNzRsSn+mPPWJwGm2ZEHwVBDh/hm+W6kf06glqge8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tzYAdZFu7+wyPsXOkRS4ZphTvGr6sHkpWfYU2dFgwHrEZ/9/l5d0Wp1avHOjLrNQVFQPLdE+sy+hQrEJglUhMLJWGMNI/tmZnAwaZU08VgWwab8yyKvsYAa6zW4NCLNnQ8sb0LEhK+y76BnrRTPMNHqXfc0/bFwIVaWJX/5ACYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baoQDXE4; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baoQDXE4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9qyMA4un1WE89PSa6YrAdTBaj1tDrr9HCESQpluKXhYmfZFtFlaY/kkJCgc933Lv9V6DcAYzJU4vnJKIRLpo90UVQlQBWxCiYSVocOAcuWAaN0b/+bU88u7PmQ1iymDd4WEiY1zRTBl5PVGbrCdeVOLAWh8pqgHA0GJpLOAdAyTYux7rwhS6TiF4SQ1TnE0sZQBBdnPOYq4Z9hMwqzwOFfU2F/FKTXovxzhMMi6UzTOG1JT45ziqGJ3vPu9PonPWqDhcxnfGKh1Skagl7/TR5LjLmWwriUv9X2PlACepZd00//TMVwKMCTiYz1E1boc68Agd5DZcKHGc0VZOtnfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIMNzRsSn+mPPWJwGm2ZEHwVBDh/hm+W6kf06glqge8=;
 b=XPzu7yZiL0gzaZScB4PvUx7HSEne8CTdyCR1G/JFv+uj1iHENUERCKL/RSa9wqLf8ARu9IK61f+rVIOx18ii14Y+jMCxK2m0yQ0DBKl5Sod0jQruL8uUmFFVreAvHrzyRy6hznFdOSQs/QychureKaywlA3lGGFu5EFRtgJHQwiVCBJ1+bGYtLth1QmjO+MOdbeupwybg4xQf/qL3ZqyzfTP2nwHYSECaphcE5mjRFR7XoJoYlwLecImBk4Dg02mRwK4GTtaoGcVa+/+wVoRHyEKInxqhZHrXEbJu/PSTyfFdNCjxBLuLCAp2cLOS15fM2TP/O7FITk1vu4XC0ignA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIMNzRsSn+mPPWJwGm2ZEHwVBDh/hm+W6kf06glqge8=;
 b=baoQDXE44+zSI0OJ3ZX+xhGNFDsj/3/OcCit0HV6NrrboYFqaeIk2VhxzBnlicQEGX4WHGy98a4sh0Y/EPL8E5y/qkgThXPQQF4WSPAXueEqmOG/BTdiawa6/l/M91V/FqBXBPcous4cmVwLiOa2vVYdi+r/w9KHywbu4qRxFrnEzcJyEPWFs72yUkFemaLy8wl0D5xPqzIyONM+Nwh9mYdER/kE9CQR7GPkWyBeNSZg4K6Q1osXfj7RVX+0YaMo5bzXdXnay192EGjgYf/AUB0iUVVHov/MY+iWUNSIH3Vi/ipLx9do6R3dXoiOtIJU60JWVJamlTBDHM6R+Bglwg==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:44:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:44:10 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Shrikanth Hegde <sshegde@linux.ibm.com>, Vishal Chourasia
	<vishalc@linux.ibm.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>, Uladzislau Rezki
	<urezki@gmail.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index:
 AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOT2cAgAAgEQCAAA83gIAANcGIgAAQlICAAAedXYABOZ6AgAAHEd4=
Date: Tue, 13 Jan 2026 12:44:10 +0000
Message-ID: <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan> <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636>
In-Reply-To: <aWY4LQZrudJ4SB8G@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH7PR12MB8594:EE_
x-ms-office365-filtering-correlation-id: 0a1e6eff-582e-4dd4-0b1e-08de52a172c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEUwRm9Tb3Y5U0Y0NTFpTFpDd3FXQ2xYdEFRVUVQR1lkUGpYcWoydVZaYjRp?=
 =?utf-8?B?Sit1UFdHNHZGcGxDMjJVcTNxMHY4em5neG5jVWxrTFBwMm4rRGRoZlJObDdF?=
 =?utf-8?B?aDVOWlovWjltZDNHOVE5cGFqR2dYaEtuelBvRFhCMFhoa1JsUFRYdnFlL2RC?=
 =?utf-8?B?U2VxL0ZEa0IzMUhqSWtpaUdOVnBUMEhuKzhEaVYvS2k2UU5JQWF2Q21RSTF0?=
 =?utf-8?B?RlF4VjlVWnBiQ0EzQlVjVlA0UER5K3VmR0pOV1pVTGpHNE1Qc0NZY0hReUpz?=
 =?utf-8?B?Sk4zVzlYS0JoemNaazVwU01oNjVNenJtRXh5TTlLaFdNUzFjVVZPMjQwWnJP?=
 =?utf-8?B?RFdVN3RtVGdydi9JUTZBUm11WjlJNmtBTUVSVzJab1NSMXhiV2t1WGtVR1Bm?=
 =?utf-8?B?TFIrazhNVzN6Wi9iRjhUUEVFa0VXLzFMWDgxVkdZeVM4TXgwMGdsUU9aeHpI?=
 =?utf-8?B?ZzgyTkFtaExtVTErTUFZQnIybFF1MGdvejRIOFQzdU5Zb3FIZkJ2aVdLUFNC?=
 =?utf-8?B?M2dKU0dtakZDb0gwcEVSSXlRZVVoai9YeEQvYjF3bWZsUjFJZUZ6M0pZMmVq?=
 =?utf-8?B?WGdUNWZ3VWlWMEtqQTlWd3NCNVp1NVMvMzRja2VSZ283THVDVVJ6a3lHQkNO?=
 =?utf-8?B?UVp6b3d2ZWpUeE9rTnBmc2JVZXdiSzRnTE9lMUwxVUsxVG1WWHlxSmRpT0xz?=
 =?utf-8?B?Z1hORTBzSVhXanZjRHJNUzZzS1ZrQXRTMjlJYWJIYlRzMEREbXNtMjcvLzcy?=
 =?utf-8?B?ejhKTGhFSDdhK0h6cU1EWnZueHM4UWpYS24yTGQwTk9OTnNDdy9SWmNBaFE5?=
 =?utf-8?B?d2FtSExpSEVVN1ZJSGR1RXFPVUlpeXFLYWEzWW4wNmtQNFpGVlVyMW8xS01E?=
 =?utf-8?B?SXFIcDdUc3YyakZMbkFiZUVnR3hqelZLQWV1K2dOaHdKSG1vVmMza0svdFZt?=
 =?utf-8?B?Z2o2alRjSlNTSWJkTXpxRUk5cjJ1amYyQ1laY0tsZDlQa2pUY2ZWdUNwVDAy?=
 =?utf-8?B?cnFpNC9FWkdnd1dqb0Flek8rdFF6cXJhSENYdm5OM0lJTThLanZONmF2bUJV?=
 =?utf-8?B?Y0U4Ukd0ZnJUWUlRWGxCM1NFSE94M283YUl4TXB2OGZjM3pKclhvSWU0aU0v?=
 =?utf-8?B?UjJHd1pzZVhNNi9WQ2RBYkIxYURFUzdvNXFuRDRMSTV3TXhNOFRpVW15YStD?=
 =?utf-8?B?ZGVGdFdhSkZpUVhSSGphOTEreGxoU2VLMlhlZEVPTDJUV2ZNWENxOG44T2VI?=
 =?utf-8?B?NWt0cDk3Qk96ZXd3TFpac0pMZzFnQzNTK1JxRTk5WHdxOUpEYzVrMG42QURP?=
 =?utf-8?B?SlBLQllNb0w1MHNhVHBvYmFPc3ppR1lsdXgrRTNJNG5BRCtzekwzeXdldG5U?=
 =?utf-8?B?QXlLZHFsRVhveFY5RW1rczRVUTZXcW1wR2xqUkJFbEtRYXR2S0c0Ynk4Tm9o?=
 =?utf-8?B?T1NGK0E5eGtCaWZDR0xCaEsxbVRUeE5iTC9TUit2WWsrczFRdlhVY0tubmFV?=
 =?utf-8?B?V0IzdTg2VUFSTGJuNzVHVXNZQ3htK2xPRHhzOWJSdEN0MUF5bThON2dJMDBM?=
 =?utf-8?B?SXpzcXYySi9zdlYvRjlnREVUZGZkZWJ6Z21RTHVmTjhHZU14cUZqVE5pSFJW?=
 =?utf-8?B?TWpBOVRjcjVJOFRaVzI1cU9RN0tYaVQrQ3hmTHErOHJ1eTFncXR4bFAxM0x3?=
 =?utf-8?B?Tk43NisxNDhLaFJqWkltUE04MTJBOU5EVVdKb0pOZGcydEVKWm1mVVFOWVhF?=
 =?utf-8?B?ODhjRkxWZ1BzMnlTYlJMeEdlbE1udnVCWHo4YWdXaWNTNzV1VUtJcUFCUjFP?=
 =?utf-8?B?T0ZQbUNkaFhGeGRRYUpnVnpqbklKbm9aV29DSUJaZHFKYklOaWFYcXc1dWNZ?=
 =?utf-8?B?cHhaY3NBNjgvWHJIdXZqaWtFbFJBaDZRYnVGaTA4dFZySDhnWHBMY29TaDhN?=
 =?utf-8?B?b3l4K1VoVVI2c0JsUG91L0xvVzU0cEQ5Z1QwM0tBT3Y5aTJHUUMxZFJlVE1p?=
 =?utf-8?B?MUFYaDlwbTlXYjVWUmlVODhBTFBRazQvSWZYRUJPOW83SFpFZ09UUzlPeGxQ?=
 =?utf-8?Q?1/YqwM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEwyQlZRUHNnKzhJT3VoNFJGUlFFN05DWkEvWkUzbjQvdzhDOXdTSEp5MzBW?=
 =?utf-8?B?QXptMFpSa250TStPeklKcG9KeXpPU2pVVC9vUG5NZWw5bnB5YklvT2N3Wkl5?=
 =?utf-8?B?ZENFaUlKMnJqQmtwdHpIR3ZTU0t4RzRCNU9FWS9FSkkrT2xTQVRicXlvaUp1?=
 =?utf-8?B?d1FvSUhVL1hsaG9rc09nOUxXNUZ3eUsxck9QNjA2WUViQlVBNG90UEIrT042?=
 =?utf-8?B?cHJJbVJLRFBNa1ZaMlNnK1NSd1lSZFM5cGVOa0VUWlZ0TXFRNGdoWVYyb3o5?=
 =?utf-8?B?elhIZStxRzY0bTdMRGlyUUlpWjBTd29MUmhLM0I5WW1rVmwrdFRyc2tpcStG?=
 =?utf-8?B?bVNMSkVVYXFXeXZTSUx0cnF3R3A3ZGNHWGdZOXQyeFEvOXlvYlE0NnU5VU1S?=
 =?utf-8?B?OHd1WUZwM0NXc2NFWXpZYUNHNjNCRis2UkNDaTAreWF4RzdNY2xTcW5Bb3FD?=
 =?utf-8?B?TTArSmFVdWFnT0c5a3dnZHpZcW5WWjgwbUkyY1dONm9Zc1lDQ21nbkZVQkhi?=
 =?utf-8?B?MkhzMzdzcS9MNmNPdXdraEV6dzNIdkpaTnl2Vk1zcEZYaEJyQ0xHQjQ4dTdn?=
 =?utf-8?B?bzhaeS9qU1pUOFNJdm0rZUxMS2xqQ0pDTWFNczBETXRzNVRFT3VWanNEaTBG?=
 =?utf-8?B?L3hucFlDdVZoYmR6V1R0OEVucm9oanJmRHIrS3lwUDNjUnFqSWMyT2E4RU8y?=
 =?utf-8?B?cjJENThMdTZrSFIrc0d2S3FmcnFoVmFhb2RtVS9VaHphbkZHdXpGaldDcTJS?=
 =?utf-8?B?djU2aTBYUGsrOVRBRk0zYk9vTlRZZTFBRGJFbWpvN3RoT1hRYzliN0NZUURF?=
 =?utf-8?B?UUtEQmRxWGEwYVVabHJUT0J1S3VtVmtwTERjMjR3V0ZiZTc2Um5VWGlGd2Vo?=
 =?utf-8?B?Q284UXhnWWxrWDFIbW81VlFZdnh0ZVpSdGdocllMZWJUQ1FwclZEcHBVNGRy?=
 =?utf-8?B?VzZIYjBmNXFVSStqVmpxQ3lWbks1ZWdzV0FkTDRoOHc0WEVLMTNKRkNMNmx0?=
 =?utf-8?B?cnpyYncxNG9GY2d6WFVydGZ2VUFPcWhQd0ZMbGxlSVdaNWdnczFFUjRCMjVH?=
 =?utf-8?B?TndPa2tsOWdCSis4dWdDUFJMV3VYTXlvdWVXRFJlRG1ra2F2M2dSZysxUFdr?=
 =?utf-8?B?NlNvZC90TDBRWnRyZDZIRjQ2Y1owdUZMbW1kNlBQTmZkeURLTFJFbDlqVHNx?=
 =?utf-8?B?bkZtRFlMSDAwZFBPMkdnancrbUx3Vit1QkRFQWI5SW1PVnhseXk2bmxsek1G?=
 =?utf-8?B?QTJYYW5hbFpKVW55b1BIUS9xVnBzNVJIZ3lsalBQMTJCQVNKMjdGNVBPQmxX?=
 =?utf-8?B?UGZBNlVlQVhCTW5CUmJVKzBHZjN5YWR2UFRXNkhJTTZpc3dabUo5Q1htK3Zk?=
 =?utf-8?B?T09iWFVNeXJsOGNKUSs1STdQSTVvdkt0MHFKVWZTVmdudFQ1N0RlQkwzamJa?=
 =?utf-8?B?dWZRbkNTR0NqQ2E3LzhMdnRaVTNRYnVteTkvbmtUcGtpYkhqSThSelVaUEFU?=
 =?utf-8?B?RitsRG50YkUzMlVnZUtNaWI3UHJpSDJ3aW1idVNMUTJxYi82MTFjQjc2UU1D?=
 =?utf-8?B?c0ZTM0FqS1d1czd3K1ZoNHdpUlBWZDVwa0xPczRwWlRGTFpvNXc1MnNWcEFj?=
 =?utf-8?B?RkFTUlZ4Sk9iMnVMWERMejFBYS9UbzQxVW1Zc01OeTF2UmJlQk05Sk5XVVRN?=
 =?utf-8?B?UnJhdDV4bnZzK3VJWERVNi81ajNKd0c2Y3ZBSmpJV1ZTU3JRR09oOGtnWVg3?=
 =?utf-8?B?dGNEUUlCaHNvMjV4K1hEV3N0SjlXTUhFdTZQa1lsRHNUTjRmT21wL2FDaVE1?=
 =?utf-8?B?d0VOdGdFb3VGSXZxVzIxNWZ3VzB5NjBIQ1dYMWx2T0NrSE8wMXRKT3dxSWNk?=
 =?utf-8?B?NkFmcWM3a0JhMFE2NFl4Q1llaDNEWmV6NklWdm9ZbXU4SS83ZDF6NkxyQmZa?=
 =?utf-8?B?akRveXNFZGlYL3Uwd2phRGx6c3VoeW94a2FzbzlzY3JkbDN2TkJnQkFNdEh5?=
 =?utf-8?B?OWZaUitXZzJyRUN2WGxoNkRRWE01Yko3RGs5YnFSZndZTUQxZEVVZXQ4TWJS?=
 =?utf-8?B?RUdGNlF2aXRLNVJGcXNjc2lrVnY2NGZ6QmR1UTFqcnBob2MvN21oWjMrSVpJ?=
 =?utf-8?B?S0dMNHZhMEQ5QnFZT09KdHBrZ0RlRHJWTUNhQWJ0T3FSZ3JJUHVRZG93WFlk?=
 =?utf-8?B?SCtwTUFRaGJQaVQ0V25VczNXNkV5V2JzVWZiV205TXhvMEdnOWx6cVRYK0p2?=
 =?utf-8?B?KzhGUXNRSG83bXgwczY4VEJISk5xNUh2bEpSTzhtc3dka1dBQmEwMTNMdzlV?=
 =?utf-8?B?NjlSakx3VmdWL2JIVGhYaCswN1o2Qm42UE1yWEErUVNmektiWGZxZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1e6eff-582e-4dd4-0b1e-08de52a172c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 12:44:10.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wlj7YNu2BAOx0B3cw9DF8Ng8BzGrRtwQ17yXrtBBek102INc1Pnq+JqdmpdFie1SlUPwT1rOXB4YU4QmE/pUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

DQoNCj4gT24gSmFuIDEzLCAyMDI2LCBhdCA3OjE54oCvQU0sIFVsYWR6aXNsYXUgUmV6a2kgPHVy
ZXpraUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBKYW4gMTIsIDIwMjYgYXQg
MDU6MzY6MjRQTSArMDAwMCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+PiANCj4+IA0KPj4+PiBP
biBKYW4gMTIsIDIwMjYsIGF0IDEyOjA54oCvUE0sIFVsYWR6aXNsYXUgUmV6a2kgPHVyZXpraUBn
bWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v09uIE1vbiwgSmFuIDEyLCAyMDI2IGF0IDA0
OjA5OjQ5UE0gKzAwMDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+
Pj4gT24gSmFuIDEyLCAyMDI2LCBhdCA3OjU34oCvQU0sIFVsYWR6aXNsYXUgUmV6a2kgPHVyZXpr
aUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiDvu79IZWxsbywgU2hyaWthbnRoIQ0K
Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDEvMTIvMjYgMzozOCBQTSwgVWxhZHppc2xhdSBS
ZXpraSB3cm90ZToNCj4+Pj4+Pj4gT24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgMDM6MTM6MzNQTSAr
MDUzMCwgVmlzaGFsIENob3VyYXNpYSB3cm90ZToNCj4+Pj4+Pj4+IEJ1bGsgQ1BVIGhvdHBsdWcg
b3BlcmF0aW9uc+KAlHN1Y2ggYXMgc3dpdGNoaW5nIFNNVCBtb2RlcyBhY3Jvc3MgYWxsDQo+Pj4+
Pj4+PiBjb3Jlc+KAlHJlcXVpcmUgaG90cGx1Z2dpbmcgbXVsdGlwbGUgQ1BVcyBpbiByYXBpZCBz
dWNjZXNzaW9uLiBPbiBsYXJnZQ0KPj4+Pj4+Pj4gc3lzdGVtcywgdGhpcyBwcm9jZXNzIHRha2Vz
IHNpZ25pZmljYW50IHRpbWUsIGluY3JlYXNpbmcgYXMgdGhlIG51bWJlcg0KPj4+Pj4+Pj4gb2Yg
Q1BVcyBncm93cywgbGVhZGluZyB0byBzdWJzdGFudGlhbCBkZWxheXMgb24gaGlnaC1jb3JlLWNv
dW50DQo+Pj4+Pj4+PiBtYWNoaW5lcy4gQW5hbHlzaXMgWzFdIHJldmVhbHMgdGhhdCB0aGUgbWFq
b3JpdHkgb2YgdGhpcyB0aW1lIGlzIHNwZW50DQo+Pj4+Pj4+PiB3YWl0aW5nIGZvciBzeW5jaHJv
bml6ZV9yY3UoKS4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gRXhwZWRpdGUgc3luY2hyb25pemVfcmN1
KCkgZHVyaW5nIHRoZSBob3RwbHVnIHBhdGggdG8gYWNjZWxlcmF0ZSB0aGUNCj4+Pj4+Pj4+IG9w
ZXJhdGlvbi4gU2luY2UgQ1BVIGhvdHBsdWcgaXMgYSB1c2VyLWluaXRpYXRlZCBhZG1pbmlzdHJh
dGl2ZSB0YXNrLA0KPj4+Pj4+Pj4gaXQgc2hvdWxkIGNvbXBsZXRlIGFzIHF1aWNrbHkgYXMgcG9z
c2libGUuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFBlcmZvcm1hbmNlIGRhdGEgb24gYSBQUEM2NCBz
eXN0ZW0gd2l0aCA0MDAgQ1BVczoNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gKyBwcGM2NF9jcHUgLS1z
bXQ9MSAoU01UOCB0byBTTVQxKQ0KPj4+Pj4+Pj4gQmVmb3JlOiByZWFsIDFtMTQuNzkycw0KPj4+
Pj4+Pj4gQWZ0ZXI6ICByZWFsIDBtMDMuMjA1cyAgIyB+MjN4IGltcHJvdmVtZW50DQo+Pj4+Pj4+
PiANCj4+Pj4+Pj4+ICsgcHBjNjRfY3B1IC0tc210PTggKFNNVDEgdG8gU01UOCkNCj4+Pj4+Pj4+
IEJlZm9yZTogcmVhbCAybTI3LjY5NXMNCj4+Pj4+Pj4+IEFmdGVyOiAgcmVhbCAwbTAyLjUxMHMg
ICMgfjU4eCBpbXByb3ZlbWVudA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBBYm92ZSBudW1iZXJzIHdl
cmUgY29sbGVjdGVkIG9uIExpbnV4IDYuMTkuMC1yYzQtMDAzMTAtZzc1NWJjMTMzNWUzYg0KPj4+
Pj4+Pj4gDQo+Pj4+Pj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVmMmFiOGE0
NGQ2ODU3MDFmZTM2Y2RhYTgwNDJhMWFlZjIxNWQxMGQuY2FtZWxAbGludXgudm5ldC5pYm0uY29t
DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4gQWxzbyB5b3UgY2FuIHRyeTogZWNobyAxID4gL3N5cy9tb2R1
bGUvcmN1dHJlZS9wYXJhbWV0ZXJzL3JjdV9ub3JtYWxfd2FrZV9mcm9tX2dwDQo+Pj4+Pj4+IHRv
IHNwZWVkdXAgcmVndWxhciBzeW5jaHJvbml6ZV9yY3UoKSBjYWxsLiBCdXQgaSBhbSBub3Qgc2F5
aW5nIHRoYXQgaXQgd291bGQgYmVhdA0KPj4+Pj4+PiB5b3VyICJleHBlZGl0ZWQgc3dpdGNoIiBp
bXByb3ZlbWVudC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gSGkgVWxhZHppc2xhdS4NCj4+
Pj4+PiANCj4+Pj4+PiBIYWQgYSBkaXNjdXNzaW9uIG9uIHRoaXMgYXQgTFBDLCBoYXZpbmcgaW4g
a2VybmVsIHNvbHV0aW9uIGlzIGxpa2VseQ0KPj4+Pj4+IGJldHRlciB0aGFuIGhhdmluZyBpdCBp
biB1c2Vyc3BhY2UuDQo+Pj4+Pj4gDQo+Pj4+Pj4gLSBIYXZpbmcgaXQgaW4ga2VybmVsIHdvdWxk
IG1ha2UgaXQgd29yayBhY3Jvc3MgYWxsIGFyY2hzLiBXaHkgc2hvdWxkDQo+Pj4+Pj4gYW55IHVz
ZXIgd2FpdCB3aGVuIG9uZSBpbml0aWF0ZXMgdGhlIGhvdHBsdWcuDQo+Pj4+Pj4gDQo+Pj4+Pj4g
LSB1c2Vyc3BhY2UgdG9vbHMgYXJlIHNwcmVhZCBhY3Jvc3Mgc3VjaCBhcyBjaGNwdSwgcHBjNjRf
Y3B1IGV0Yy4NCj4+Pj4+PiB0aG91Z2ggaW50ZXJuYWxseSBtb3N0IGRvICIwLzEgPiAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHVOL29ubGluZSIuDQo+Pj4+Pj4gV2Ugd2lsbCBoYXZlIHRvIHJl
cGVhdCB0aGUgc2FtZSBpbiBlYWNoIHRvb2wuDQo+Pj4+Pj4gDQo+Pj4+Pj4gLSBUaGVyZSBpcyBh
bHJlYWR5IC9zeXMva2VybmVsL3JjdV9leHBlZGl0ZWQgd2hpY2ggaXMgYmV0dGVyIGlmIGF0IGFs
bA0KPj4+Pj4+IHdlIG5lZWQgdG8gZmFsbGJhY2sgdG8gdXNlcnNwYWNlLg0KPj4+Pj4+IA0KPj4+
Pj4gU291bmRzIGdvb2QgdG8gbWUuIEkgYWdyZWUgaXQgaXMgYmV0dGVyIHRvIGJ5cGFzcyBwYXJh
bWV0ZXJzLg0KPj4+PiANCj4+Pj4gQW5vdGhlciB3YXkgdG8gbWFrZSBpdCBpbi1rZXJuZWwgd291
bGQgYmUgdG8gbWFrZSB0aGUgUkNVIG5vcm1hbCB3YWtlIGZyb20gR1Agb3B0aW1pemF0aW9uIGVu
YWJsZWQgZm9yID4gMTYgQ1BVcyBieSBkZWZhdWx0Lg0KPj4+PiANCj4+Pj4gSSB3YXMgY29uc2lk
ZXJpbmcgdGhpcywgYnV0IEkgZGlkIG5vdCBicmluZyBpdCB1cCBiZWNhdXNlIEkgZGlkIG5vdCBr
bm93IHRoYXQgdGhlcmUgYXJlIGxhcmdlIHN5c3RlbXMgdGhhdCBtaWdodCBiZW5lZml0IGZyb20g
aXQgdW50aWwgbm93Lg0KPj4+PiANCj4+PiBJTU8sIHdlIGNhbiBpbmNyZWFzZSB0aGF0IHRocmVz
aG9sZC4gNTEyLzEwMjQgaXMgbm90IGEgcHJvYmxlbSBhdCBhbGwuDQo+Pj4gQnV0IGFzIFBhdWwg
bWVudGlvbmVkLCB3ZSBzaG91bGQgY29uc2lkZXIgc2NhbGFiaWxpdHkgZW5oYW5jZW1lbnQuIEZy
b20NCj4+PiB0aGUgb3RoZXIgaGFuZCBpdCBpcyBhbHNvIHByb2JhYmx5IHdvcnRoIHRvIGdldCBp
bnRvIHRoZSBzdGF0ZSB3aGVuIHdlDQo+Pj4gcmVhbGx5IHNlZSB0aGVtIDopDQo+PiANCj4+IElu
c3RlYWQgb2YgcGVnZ2luZyB0byBudW1iZXIgb2YgQ1BVcywgcGVyaGFwcyB0aGUgb3B0aW1pemF0
aW9uIHNob3VsZCBiZSBkeW5hbWljPyBUaGF0IGlzLCBkZWZhdWx0IHRvIGl0IHVubGVzcyBzeW5j
aHJvbml6ZV9yY3UgbG9hZCBpcyBoaWdoLCBkZWZhdWx0IHRvIHRoZSBzcl9ub3JtYWwgd2FrZS11
cCBvcHRpbWl6YXRpb24uIE9mIGNvdXJzZSBjYXJlZnVsbHkgY29uc2lkZXJpbmcgYWxsIGNvcm5l
ciBjYXNlcywgYWRlcXVhdGUgdGVzdGluZyBhbmQgYWxsIHRoYXQgOy0pDQo+PiANCj4gSG9uZXN0
bHkgaSBkbyBub3Qgc2VlIHVzZSBjYXNlcyB3aGVuIHdlIGFyZSBub3QgdXAgdG8gc3BlZWQgdG8g
cHJvY2Vzcw0KPiBhbGwgY2FsbGJhY2tzIGluIHRpbWUga2VlcGluZyBpbiBtaW5kIHRoYXQgaXQg
aXMgYmxvY2tpbmcgY29udGV4dCBjYWxsLg0KPiANCj4gSG93IG1hbnkgb2YgdGhlbSBzaG91bGQg
YmUgaW4gZmxpZ2h0KGJsb2NrZWQgY29udGV4dHMpIHRvIG1ha2UgaXQgc3RhcnZlLi4uIDopDQo+
IEFjY29yZGluZyB0byBteSBsYXN0IGV2YWx1YXRpb24gaXQgd2FzIH42NEsuDQo+IA0KPiBOb3Rl
IGkgZG8gbm90IHNheSB0aGF0IGl0IHNob3VsZCBub3QgYmUgc2NhbGVkLg0KDQpCdXQgeW91IGRp
ZCBub3QgdGVzdCB0aGF0IG9uIGxhcmdlIHN5c3RlbSB3aXRoIDEwMDBzIG9mIENQVXMgcmlnaHQ/
IA0KDQpTbyB0aGUgb3B0aW9ucyBJIHNlZSBhcmU6IGVpdGhlciBkZWZhdWx0IHRvIGFsd2F5cyB1
c2luZyB0aGUgb3B0aW1pemF0aW9uLA0Kbm90IGp1c3QgZm9yIGxlc3MgdGhhbiAxNyBDUFVzICh3
aGF0IHlvdSBhcmUgc2F5aW5nIGFib3ZlKS4gT3IsIGRvIHdoYXQgSSBzYWlkDQphYm92ZSAoc2Fm
ZXIgZm9yIHN5c3RlbSB3aXRoIDEwMDBzIG9mIENQVXMgYW5kIGxlc3Mgcmlza3kpLg0KDQpMZXQg
bWUga25vdyBpZiBJIG1pc3NlZCBzb21ldGhpbmcuICBUaGFua3MuDQoNCg0KPiANCj4gLS0NCj4g
VWxhZHppc2xhdSBSZXpraQ0K

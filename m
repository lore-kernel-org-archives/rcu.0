Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D851494C3;
	Tue, 13 Jan 2026 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272421; cv=fail; b=sjwVTSZhzLBdCyUU3MGVuWNaIHGjulv7GAUagYgCTLWWpskeLg+FukPrnJiG3FdTS+0s/hl6fxesVFGe8T1nMreLNKzMWliTMQWnzRezo99ASuMI2K+MQrvnv/yS/Rv1V1Mw5aUQ2vr3Y8PN/ajePIjYQkpOcVsX/iwb4DaJFzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272421; c=relaxed/simple;
	bh=0J8xg8wd7FQU29IbrM6myTcZbfPw91IcpT/hrYeqlOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdBdzfGyuKdm87afAA5kvwjfYPtBCqAe7XBmYt1hJ19Jf2tuawyG5jBHiQcAB9RpAyo0TAcgNOVwnCidOAcIKg/2YkA1e+rwY7uHpBfZUsoDGFfugMN3uPP/dyIQRDG+2HWLZrlahnrH3uEHY8Irqgf1SErztq0TjeJN4aT4yzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwNI8mAB; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwNI8mAB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS32RCgqxRWjbNuticSEaC5XDeUvPviWvXSKTBiqycfO1tvESQ5w1hVydDyJwkKiU0rZJbBsL52/7onHo3nW4+mOlfed35R7GV4z1OSo7TEvemaKdjjcseJPGqGyg2anoqbgoxUddilGhQksi+YnyqJmpWjUoX8T3YK5UtLqMXubggvN2eWdotvM8jWpH4lexE80GGO1pcpUAdbqaL5/cHBbBvibTr81HRjiTYD+2eHYAP2zOqRffD03YD9Oe/TtsjL/ZwJ6f5c3i54zrOL0GiYDZm4TdyuS0RD8kQNC3nL7IwC1kJ+VidOKWcxtovm1/KmfoHJzXvfy2Cr7HtfmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J8xg8wd7FQU29IbrM6myTcZbfPw91IcpT/hrYeqlOk=;
 b=OAROeTAQGCQsM7uHRbnauLVOlb0vQ74jYQuvU3kAk5CLUECwzQD7EhydPWlPWwSWXdzKkDpFQsq6GfN+8RXJNe8Cw/nh9tnPGZ+T/wdYOedpv0/pgSdAe7M6cCHri3IoECErHMQa+ofRc0u/xae9NoN/KWlQD/aAIN0bDuABpQdGE752tZ9la7kbvrPC16J1YHjO6D590SVyKSoyyLC41/S1eGwj8dF2a2YO18DvW64eM8JxhTEKCzbg2oVzqIhCOPlehVySn7W9Ydju4SRqtGJmXUghUKAViLq6OQ2WC+J9WRoH4y1zj2jqFwxYiGyoQ2VwrfLvh2YKsnzNGYN1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J8xg8wd7FQU29IbrM6myTcZbfPw91IcpT/hrYeqlOk=;
 b=AwNI8mABYhxTZ5IERau3ohEd6CcInYu98zQeUnmtxKd3zpBb9JBKNw980CQiwbu5jLfRlckuXJ1SRNaoix1wPYQ2QrdpEAocTgETcObEagOp6KPaPfWFyIgYmHfXtzPdnDWSl33HgHZtqdyAQMH2TpdUde9Swm82sbsnyWe0ExXSnmIjieY6EgwhaC6+3WJq+woyewOd98ZYDiUkEwEWXwYaTUEq7sockUL8DdFSqfFE2Pv8hXHgIn+E7xVeIuiJD2qj9DpSGUmErW4bBw3bt9c18X5+mlsiGUqSVJcpnmEJuQe2ZuKXw70owpOC6/XVp3ujLH2++ETIZzJfQMhACQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:46:56 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:46:56 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: Uladzislau Rezki <urezki@gmail.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Vishal Chourasia <vishalc@linux.ibm.com>,
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
 AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOT2cAgAAgEQCAAA83gIAANcGIgAAK3QCAAF3fAIAAGxUAgAAuMq0=
Date: Tue, 13 Jan 2026 02:46:56 +0000
Message-ID: <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
In-Reply-To: <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SJ1PR12MB6217:EE_
x-ms-office365-filtering-correlation-id: a7e52a2c-6ccf-42bb-8d23-08de524e0434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzBrbXBhWGx1YjFtaWJzeUp0TzlVOFdRcjNtYjJRbjhrRjQwNjNQV0JCY0Z3?=
 =?utf-8?B?NWh6TndWQVdJTmhpZVZzRGVyNzFNcElXdWUyU3VVNTFoRUdSRUZ2WWdJRTBx?=
 =?utf-8?B?bE9Lc0IzVVRaQXN1Vy9vN3QwUmJqUkhlMG54YXp0RkVITmYrcXl0eDUyY3h4?=
 =?utf-8?B?L2RWdW5wbWxsR0phL3JSM1RiWkM5MlFHM3dDVWg3OEdvaU9TUlJGc0ViUmtv?=
 =?utf-8?B?WEEza29ZUEx5M21Ickk4YmRtMkFnWVVDcU9HRzlVbUd1YVY5QlI4Ly9CMjYr?=
 =?utf-8?B?eDdXcmVNdFAyTU93VjB1TjFjS2d2cTJaZnZLZWRzd0V2cStlTC9UYUZDQ1dV?=
 =?utf-8?B?MjdlTjl3YW1ydjlJNXNoWC9FazBiMStnMVp3RmZzbVJXRlpteGZEU2VUMlJF?=
 =?utf-8?B?K2lobEowWlAyV2x4cTN6TnNXNjlDc1k4R0pWa2ZGNlN1dWVjMWE5SjlBUEl2?=
 =?utf-8?B?OVEwakVLTjZaUUE3TFdVOU4vVUVrc1BLOFIyS3JOZ0NnaUhDSk15dVhKL3JP?=
 =?utf-8?B?WnIwWlNKbVhvczZGc09pT2lLd2Y3RHE0UmUvQVNPMHdwUzhOdk5scTZnVWgy?=
 =?utf-8?B?RUlaTHpIcElPQ2FhYSswWHpENk5JSE1iVmRJdUd1N2laVCtqV3FOUUZ0S01h?=
 =?utf-8?B?ejZid21VMURhUTBZblJ4RHhmcjRlS0g2bG1JRndOOUpReXZTeFpTK25WdFpw?=
 =?utf-8?B?dVpQc0s1ZmMzY2lCYlp6RE9BN0luZXYwOSswNndZU3E2b0hlcjBkL0ZBbTB4?=
 =?utf-8?B?NkpSUDdnNGFoTitINnRBOFppQWNvdjZ1ZER0RGFZSTVFOGxsa2NScGd1ZDJh?=
 =?utf-8?B?YVVoTUw5S2VRZUlGSzVXRmtGMzkxV2lsSEJvRkVERUJBK0RURE9PUkhYRHNp?=
 =?utf-8?B?TUNhZ3d0R01yMkdnclkzMFY1VnhGNGpFb3ErWWNxMDZFckx2VGFOWkxDSEl6?=
 =?utf-8?B?UTY4Qjc0cXVxVlVqaFoyUHdxekxMZXlBc3F0dm5HcmFWZTl4eE1tVG1qMjNU?=
 =?utf-8?B?KzNab28wTVNOZzNqYkh4QWhhZldVQlZWVm9ySVpNRWR6THNwbTJ6NW1rMEdx?=
 =?utf-8?B?OGtkb1J0dzRUcE5SdmI0dnBmZGFxODF6cXdCWkl6WkdYK2p0dms3OEw2T1NV?=
 =?utf-8?B?NGtORVJuQVlpYi9raGJoTllkZmtPRC9sSzVjdEY4ZmJ1UUpEL3NSK25nbG9m?=
 =?utf-8?B?WjhRaHBDbkE4NjIzbm5TT2l6SjV4N3VabEdoc3pObWJvYncwVDhGaFNzUWVS?=
 =?utf-8?B?RmpKczE3OTFyWUtPdEl1RnpoZ1dnLzVpYTBuNUx6S3ZWa1FuWkczNWkrRjhp?=
 =?utf-8?B?NGFSa0haVHdrcHIrK0NpNElSNkQ2SmRBcE9oVVZKVXhlUzhOU0tFdXB4bC81?=
 =?utf-8?B?ZkVDVkxvSXhIUUpwaFJMTjQ0SHc1VEZQYXBhcFp4ZndlUU9XRkJacm5TdUh0?=
 =?utf-8?B?aVkrR2M0bFdwMGxNMUhveTRLN3RFd0poanpWdmx0OUFxZDVhdGpsUDdwZzJC?=
 =?utf-8?B?VmtmODI3Z0pDTHBSYzQvZ3ZiNzFlL1FFeUpXbCthTHk2NFk3VTVBQnAvUkFP?=
 =?utf-8?B?YzlOVEVuUVoyRFVyTk1LdWI4cjNTTXpkWjZwczJWQzRqOTExZS9hS0M4akFU?=
 =?utf-8?B?NGdLRlpMUHhzUWUzUm42NFhWSVgrQ29RL0VQY2lsMW9DOWtIQ2xSSEZlR0U5?=
 =?utf-8?B?dTZRWEhjdzRmV1RKaEhOR0ZHd1oxY2hBNTVXZmdjYUhLTnV0UG5KSHRNakUv?=
 =?utf-8?B?dEhIZEt0SURaODlya2xzZkRpV2lYSnFGQy9wbGhVK21KVDd1ancrZWpHZDdG?=
 =?utf-8?B?UnFKTk5yU3Z6ODkwRFRNVEZMREh5VkRVK0VEbHROaWpvSWs4dFRLQ2RIZk1O?=
 =?utf-8?B?WmNwZlVUcVJHUDZOWnhYUW1KMDVUZHlIZnpsRS83eWc4aVpOa053YlZHcDFj?=
 =?utf-8?B?VzE3cGVpTUIxZ0RlaFlBaHh6ZFhJblZGWDlnSk14SllkWjByWElDSDlBMXBE?=
 =?utf-8?B?ME9xYVdYUHl3YTFSNlVWY1I5dmw0TGM4MlBRc0sxSys0NGVjT3JLSjEwWCtW?=
 =?utf-8?Q?TnFVMN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdOODFWeHFmcmUyamNVSlJNRVc0NVhGampzaGpXdjZmQWNvbmh6d2FmUWRH?=
 =?utf-8?B?TWxveTQxTG12b21hUEthbXpKcVpWRmZMbjM3YTFVNFRhWVg2QzJwSEdMTVRm?=
 =?utf-8?B?Z2UzLzV0SFJvaEY3T282d09IUlcxMForc0ljRUpMQzByYzdTV1hOSm5KeW5N?=
 =?utf-8?B?NGlPbUJxRlJIYXVRMUFIaThIZmcyQXZRc0l5Z3dBaVdlTi8wQ1Y2d3ZqeWVy?=
 =?utf-8?B?clI3eXZURGIzQWtPbE4rWlVSZ0l4dVlrcFJKS1MxTFYzME5qYk5sY1ZzUndN?=
 =?utf-8?B?RFVsd1B3Yis1UjY0Tm4za05xMkpXdW1ONWRwYnBZNkFFOThaakUzMWwyc29y?=
 =?utf-8?B?bDJpYS9NZEpQSk5Pays2TUo1YUpxdzkrUXZiWW5NbWJYdlFmRTRYVUNNSm9E?=
 =?utf-8?B?cnRCL3pMbVFDc0hCK3VENkNOVFU5MFlvME4xMmg5eTN6Q1l1M3g5Wkc0RXQ5?=
 =?utf-8?B?Snh5OVRSN1ZWZEhFOVd3dnBjT3JNQUNVOHRiclIyRDFtWHhYTUtqdlZSMWxB?=
 =?utf-8?B?bXFlS09ZVmxXaDNHcW9SQzUvbmNCSHEwM2V3dC9FbGdwYnpTb0tCWXdFUzZq?=
 =?utf-8?B?bTdmMW1xVFpWaklTQTZzTGIrcHUrTFBFS1JHMXMyUVhpRmRRRGYvRnZlL3BY?=
 =?utf-8?B?dkJRR0hkU1EyMUFOVlg1Ym1VN3JEWG9CK2tpNjNxYzJOVmVBd2tySThIY25N?=
 =?utf-8?B?ZE80QUNUTlQ4WTFucThKL3docVJ4ZFdpRHZXZ1NHdWpSUTRZOWlqdys0YkE1?=
 =?utf-8?B?V1FkNjNCaFpEdWErVDA0eExpak1DSkFGb2VCSlZBTHJNZWZLL3dIZ1NJYzdJ?=
 =?utf-8?B?KzRiSlIzY3dTTWhYU2Z2YzB0VSswNHhxN1BDN3hVMm1kWlBITGRESFZzZ3k4?=
 =?utf-8?B?ZERxZms3MVh4aEhlTStvZUVTK29wZnV2VlNqNExrM01Pc012Qm8zSHFmT1F6?=
 =?utf-8?B?MXVIRnZQRHhtejB6V1VjQk9BeWVPMGdsa3FmM2NpWFFIUWI5ZVpyUXFLbzAw?=
 =?utf-8?B?N3ZUMWljWks3ZzNCM3QzZ1AvY1JOejJLUkgvRTUzdkJNNUNKODBoR2lla1cv?=
 =?utf-8?B?L05TMzJtL2E5dkdhSTBXc0VPVzl3TVVIa3p2Y1owRy84SFQ3QzUyazdOYzVo?=
 =?utf-8?B?dWFSa0lmZzlHYkt2V0pkQjJXY0VJMVNhblRkY2M0aFZmMDBiTnRyN255N0Fh?=
 =?utf-8?B?T1RSUzVnbU8vSWZTK200SCtnL2Z3Z21ndSs1U201NzRBUm96WHczeXNVK3M3?=
 =?utf-8?B?TU1JYWhZdTlWSkZXN3VkaCt3Z1JGN2lHaXJUU1J5amtLTnVnZUFWb1V0cFNT?=
 =?utf-8?B?ZTd5M3BvMnZDdjQ5V0ZQWFpIY2MrY1BTczI4UFlFMVlxdm5BV2EzQ0x1R3R3?=
 =?utf-8?B?YmRvWm00Uk5xa1lYazF6SHBtQVJtNFVrZy9tazE5TmhBSjdhTXZrVTdRZzRx?=
 =?utf-8?B?NjBJMm0vVzhWVmFsSmNoUWREZnZzOXVSNzZDalAyVElabzNiNGp6d1duTXZD?=
 =?utf-8?B?bit5eE0wWjRkNkVETmVyelgrUVhLNzZsYnhqWm1DaXFqSUIvcFo1UGFNbFBD?=
 =?utf-8?B?TEFIR1B5dDNrL0N2T2l0bkFhNGFEKzFjNTA2dHNLSSt1aGtIOUtIUHZTRG1L?=
 =?utf-8?B?T3VNZVh6Tk02WnlGNDdVOEowQ2VMWVFIZW5aMG40UzB0U0dWQndJV3RuQVJG?=
 =?utf-8?B?QmVvUVpOazNNMFIzaVgxUFlZSnE0Y015OFRIQTFsL0Z0b0U1c29RNjFkaXJ5?=
 =?utf-8?B?NEZINWsxMHo5RnQwT1JrMnFFMUJic2Zkd3I2VXBhY25aUTRsQk5Fa0EybE41?=
 =?utf-8?B?dkNzTHJHekhZYi9iZVdCbmZhNUlsSlRoTTRZTkNoNDFXOXZXcFNUcnREdm5x?=
 =?utf-8?B?bm04dW5HQkhZUG5hZmNCOWJaNXpSbDVnTzc5d29ZbXJGcVF5akxsQys1VHR0?=
 =?utf-8?B?T1pZSmtsemV2ajlSd1dnZEpIdUFDM2ZZTkpYMkF0b2JRK2kxOXpzV2lpK0lH?=
 =?utf-8?B?bGRDdE9wbGZ0QzhacWQ0eXVkRk4ySUJ2dkltZDZOUlRwa0tWZVJ6THlOQytE?=
 =?utf-8?B?Z0R1MnhNcHViME9rb1U3ZGZsc3F5VUZkS0ZiTTJlY1luWlFLODJVSzdyeTdH?=
 =?utf-8?B?Q0NYbWpEUGdoekZ5UnVNa2laemFQdXFtbnNlRWJhelFkMlViMUFSMzh1cDFq?=
 =?utf-8?B?NzJUK2NCV2tZWkpqd3ZHdUdmU01WTEQ1K1FHSlNacGdJQm9QUERWZHNBWEFr?=
 =?utf-8?B?aHoyWkYydEhNdlROdklSNlhHUHFtekJDdWF0QUdiZk5yU205Sy9tZXZOQ2dI?=
 =?utf-8?B?Wlp4ZkVTSW9WL2JMVWlOV3dTSXFrNGlXQUxJRWQrRjFVUkZMVUpQZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e52a2c-6ccf-42bb-8d23-08de524e0434
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 02:46:56.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSKmt1pIVRdbt5o8PPD/ZhYKTByAdodZj9IxOHiWgnzVk5GCb3xp6ObTWj5LnNuZSpCGJzRD6GeC9LQeH+vz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCA3OjAx4oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIEphbiAxMiwgMjAyNiBh
dCAwNToyNDo0MFBNIC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4g
T24gMS8xMi8yMDI2IDExOjQ4IEFNLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPj4+IE9uIE1v
biwgSmFuIDEyLCAyMDI2IGF0IDA0OjA5OjQ5UE0gKzAwMDAsIEpvZWwgRmVybmFuZGVzIHdyb3Rl
Og0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBKYW4gMTIsIDIwMjYsIGF0IDc6NTfigK9BTSwgVWxh
ZHppc2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7
v0hlbGxvLCBTaHJpa2FudGghDQo+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+Pj4gT24gMS8xMi8yNiAz
OjM4IFBNLCBVbGFkemlzbGF1IFJlemtpIHdyb3RlOg0KPj4+Pj4+PiBPbiBNb24sIEphbiAxMiwg
MjAyNiBhdCAwMzoxMzozM1BNICswNTMwLCBWaXNoYWwgQ2hvdXJhc2lhIHdyb3RlOg0KPj4+Pj4+
Pj4gQnVsayBDUFUgaG90cGx1ZyBvcGVyYXRpb25z4oCUc3VjaCBhcyBzd2l0Y2hpbmcgU01UIG1v
ZGVzIGFjcm9zcyBhbGwNCj4+Pj4+Pj4+IGNvcmVz4oCUcmVxdWlyZSBob3RwbHVnZ2luZyBtdWx0
aXBsZSBDUFVzIGluIHJhcGlkIHN1Y2Nlc3Npb24uIE9uIGxhcmdlDQo+Pj4+Pj4+PiBzeXN0ZW1z
LCB0aGlzIHByb2Nlc3MgdGFrZXMgc2lnbmlmaWNhbnQgdGltZSwgaW5jcmVhc2luZyBhcyB0aGUg
bnVtYmVyDQo+Pj4+Pj4+PiBvZiBDUFVzIGdyb3dzLCBsZWFkaW5nIHRvIHN1YnN0YW50aWFsIGRl
bGF5cyBvbiBoaWdoLWNvcmUtY291bnQNCj4+Pj4+Pj4+IG1hY2hpbmVzLiBBbmFseXNpcyBbMV0g
cmV2ZWFscyB0aGF0IHRoZSBtYWpvcml0eSBvZiB0aGlzIHRpbWUgaXMgc3BlbnQNCj4+Pj4+Pj4+
IHdhaXRpbmcgZm9yIHN5bmNocm9uaXplX3JjdSgpLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBFeHBl
ZGl0ZSBzeW5jaHJvbml6ZV9yY3UoKSBkdXJpbmcgdGhlIGhvdHBsdWcgcGF0aCB0byBhY2NlbGVy
YXRlIHRoZQ0KPj4+Pj4+Pj4gb3BlcmF0aW9uLiBTaW5jZSBDUFUgaG90cGx1ZyBpcyBhIHVzZXIt
aW5pdGlhdGVkIGFkbWluaXN0cmF0aXZlIHRhc2ssDQo+Pj4+Pj4+PiBpdCBzaG91bGQgY29tcGxl
dGUgYXMgcXVpY2tseSBhcyBwb3NzaWJsZS4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gUGVyZm9ybWFu
Y2UgZGF0YSBvbiBhIFBQQzY0IHN5c3RlbSB3aXRoIDQwMCBDUFVzOg0KPj4+Pj4+Pj4gDQo+Pj4+
Pj4+PiArIHBwYzY0X2NwdSAtLXNtdD0xIChTTVQ4IHRvIFNNVDEpDQo+Pj4+Pj4+PiBCZWZvcmU6
IHJlYWwgMW0xNC43OTJzDQo+Pj4+Pj4+PiBBZnRlcjogIHJlYWwgMG0wMy4yMDVzICAjIH4yM3gg
aW1wcm92ZW1lbnQNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gKyBwcGM2NF9jcHUgLS1zbXQ9OCAoU01U
MSB0byBTTVQ4KQ0KPj4+Pj4+Pj4gQmVmb3JlOiByZWFsIDJtMjcuNjk1cw0KPj4+Pj4+Pj4gQWZ0
ZXI6ICByZWFsIDBtMDIuNTEwcyAgIyB+NTh4IGltcHJvdmVtZW50DQo+Pj4+Pj4+PiANCj4+Pj4+
Pj4+IEFib3ZlIG51bWJlcnMgd2VyZSBjb2xsZWN0ZWQgb24gTGludXggNi4xOS4wLXJjNC0wMDMx
MC1nNzU1YmMxMzM1ZTNiDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvNWYyYWI4YTQ0ZDY4NTcwMWZlMzZjZGFhODA0MmExYWVmMjE1ZDEwZC5jYW1l
bEBsaW51eC52bmV0LmlibS5jb20NCj4+Pj4+Pj4+IA0KPj4+Pj4+PiBBbHNvIHlvdSBjYW4gdHJ5
OiBlY2hvIDEgPiAvc3lzL21vZHVsZS9yY3V0cmVlL3BhcmFtZXRlcnMvcmN1X25vcm1hbF93YWtl
X2Zyb21fZ3ANCj4+Pj4+Pj4gdG8gc3BlZWR1cCByZWd1bGFyIHN5bmNocm9uaXplX3JjdSgpIGNh
bGwuIEJ1dCBpIGFtIG5vdCBzYXlpbmcgdGhhdCBpdCB3b3VsZCBiZWF0DQo+Pj4+Pj4+IHlvdXIg
ImV4cGVkaXRlZCBzd2l0Y2giIGltcHJvdmVtZW50Lg0KPj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+
PiBIaSBVbGFkemlzbGF1Lg0KPj4+Pj4+IA0KPj4+Pj4+IEhhZCBhIGRpc2N1c3Npb24gb24gdGhp
cyBhdCBMUEMsIGhhdmluZyBpbiBrZXJuZWwgc29sdXRpb24gaXMgbGlrZWx5DQo+Pj4+Pj4gYmV0
dGVyIHRoYW4gaGF2aW5nIGl0IGluIHVzZXJzcGFjZS4NCj4+Pj4+PiANCj4+Pj4+PiAtIEhhdmlu
ZyBpdCBpbiBrZXJuZWwgd291bGQgbWFrZSBpdCB3b3JrIGFjcm9zcyBhbGwgYXJjaHMuIFdoeSBz
aG91bGQNCj4+Pj4+PiBhbnkgdXNlciB3YWl0IHdoZW4gb25lIGluaXRpYXRlcyB0aGUgaG90cGx1
Zy4NCj4+Pj4+PiANCj4+Pj4+PiAtIHVzZXJzcGFjZSB0b29scyBhcmUgc3ByZWFkIGFjcm9zcyBz
dWNoIGFzIGNoY3B1LCBwcGM2NF9jcHUgZXRjLg0KPj4+Pj4+IHRob3VnaCBpbnRlcm5hbGx5IG1v
c3QgZG8gIjAvMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdU4vb25saW5lIi4NCj4+Pj4+
PiBXZSB3aWxsIGhhdmUgdG8gcmVwZWF0IHRoZSBzYW1lIGluIGVhY2ggdG9vbC4NCj4+Pj4+PiAN
Cj4+Pj4+PiAtIFRoZXJlIGlzIGFscmVhZHkgL3N5cy9rZXJuZWwvcmN1X2V4cGVkaXRlZCB3aGlj
aCBpcyBiZXR0ZXIgaWYgYXQgYWxsDQo+Pj4+Pj4gd2UgbmVlZCB0byBmYWxsYmFjayB0byB1c2Vy
c3BhY2UuDQo+Pj4+Pj4gDQo+Pj4+PiBTb3VuZHMgZ29vZCB0byBtZS4gSSBhZ3JlZSBpdCBpcyBi
ZXR0ZXIgdG8gYnlwYXNzIHBhcmFtZXRlcnMuDQo+Pj4+IA0KPj4+PiBBbm90aGVyIHdheSB0byBt
YWtlIGl0IGluLWtlcm5lbCB3b3VsZCBiZSB0byBtYWtlIHRoZSBSQ1Ugbm9ybWFsIHdha2UNCj4+
Pj4gZnJvbSBHUCBvcHRpbWl6YXRpb24gZW5hYmxlZCBmb3IgPiAxNiBDUFVzIGJ5IGRlZmF1bHQu
Pj4NCj4+Pj4gSSB3YXMgY29uc2lkZXJpbmcgdGhpcywgYnV0IEkgZGlkIG5vdCBicmluZyBpdCB1
cCBiZWNhdXNlIEkgZGlkIG5vdA0KPj4+PiBrbm93IHRoYXQgdGhlcmUgYXJlIGxhcmdlIHN5c3Rl
bXMgdGhhdCBtaWdodCBiZW5lZml0IGZyb20gaXQgdW50aWwgbm93Lj4NCj4+PiBUaGlzIHdvdWxk
IHJlcXVpcmUgaW5jcmVhc2luZyB0aGUgc2NhbGFiaWxpdHkgb2YgdGhpcyBvcHRpbWl6YXRpb24s
DQo+Pj4gcmlnaHQ/ICBPciBhbSBJIHRoaW5raW5nIG9mIHRoZSB3cm9uZyBvcHRpbWl6YXRpb24/
ICA7LSkNCj4+PiANCj4+IFllcyBJIHRoaW5rIHlvdSBhcmUgY29uc2lkZXJpbmcgdGhlIGNvcnJl
Y3Qgb25lLCB0aGUgY29uY2VybiB5b3UgaGF2ZSBpcw0KPj4gcmVnYXJkaW5nIGxhcmdlIG51bWJl
ciBvZiB3YWtlIHVwcyBpbml0aWF0ZWQgZnJvbSB0aGUgR1AgdGhyZWFkLCBjb3JyZWN0Pw0KPj4g
DQo+PiBJIHdhcyBzdWdnZXN0aW5nIG9uIHRoZSB0aHJlYWQsIGEgbW9yZSBkeW5hbWljIGFwcHJv
YWNoIHdoZXJlIHVzaW5nDQo+PiBzeW5jaHJvbml6ZV9yY3Vfbm9ybWFsKCkgdW50aWwgaXQgZ2V0
cyBvdmVybG9hZGVkIHdpdGggcmVxdWVzdHMuIE9uZSBhcHByb2FjaA0KPj4gbWlnaHQgYmUgdG8g
bWVhc3VyZSB0aGUgbGVuZ3RoIG9mIHRoZSByY3Vfc3RhdGUuc3JzX25leHQgdG8gZGV0ZWN0IGFu
IG92ZXJsb2FkDQo+PiBjb25kaXRpb24sIHNpbWlsYXIgdG8gcWhpbWFyaz8gT3IgcGVyaGFwcyBx
aGltYXJrIGl0c2VsZiBjYW4gYmUgdXNlZC4gQW5kIHVuZGVyDQo+PiBsaWdodGx5IGxvYWRlZCBj
b25kaXRpb25zLCBkZWZhdWx0IHRvIHN5bmNocm9uaXplX3JjdV9ub3JtYWwoKSB3aXRob3V0IGNo
ZWNraW5nDQo+PiBmb3IgdGhlIDE2IENQVSBjb3VudC4NCj4+IA0KPj4gVGhvdWdodHM/DQo+IA0K
PiBPciBtYWludGFpbiBtdWx0aXBsZSBsaXN0cy4gIFN5c3RlbXMgd2l0aCAxMDAwKyBDUFVzIGNh
biBiZSBhIGJpdA0KPiB1bmZvcmdpdmluZyBvZiBwcmV0dHkgbXVjaCBhbnkgZm9ybSBvZiBjb250
ZW50aW9uLg0KDQpNYWtlcyBzZW5zZS4gV2UgY291bGQgYWxzbyBqdXN0IGhhdmUgYSBzaW5nbGUg
bGlzdCBidXQgYSBtdWNoIHNtYWxsZXIgdGhyZXNob2xkIGZvciBzd2l0Y2hpbmcgc3luY2hyb25p
emVfcmN1X25vcm1hbCBvZmYuDQoNClRoYXQgd291bGQgYWRkcmVzcyB0aGUgY29udmV5b3IgYmVs
dCBwYXR0ZXJuIFZpc2hhbCBleHByZXNzZWQuDQoNCnRoYW5rcywNCg0KIC0gSm9lbCANCg0KDQoN
Cj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQo=

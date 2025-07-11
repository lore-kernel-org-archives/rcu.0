Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2099.outbound.protection.outlook.com [40.107.115.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F91A2632;
	Fri, 11 Jul 2025 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241595; cv=fail; b=IW24aJi8oO+xUt3+gxP9vhgpaIbFE/DDqBKgP4PKrmsRb1KkWYrL8R4SSk8n5BW+gD1VBldaFCOZ9KGFwtUsX6SbNQMEjSH+7l7t6Tz2v5252aN7EUWajRxiMN2TFPVnlAa5B+9FgC7wI/zK6CWBfQ0O5UY5CJpAF7wBonva83o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241595; c=relaxed/simple;
	bh=9XmaaT9NLFZXAiLMQ+w+L/qwS576EgRWhRtbhTI6rYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XugBaGO2GnxWkKrYJkwwAd44NRX8eoUBtvTJpgkn2nCT9OGR8pqZMlwV2QELkBV/TM7oHbEdToFv/30l1Gf1eXiEhAS3CPxm2TJSMr1c6FkPrGsriVUgtfpt3KaBAbDVA8f9l82eOcDFfxWAMzSrQ/X3t82nmpveDppV9i3aeA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Lrb/8g8s; arc=fail smtp.client-ip=40.107.115.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lrb/8g8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4kns9iZmwsrgHDwG/6sOvwcCvEn9ANhF5MTJB97M6SFslSW4zZT/qNi4xAq9LWhg1BdoS0VDOBwTUsyF/Ds+Irt1mPrZ3OtQ8KXGYuUfWiPWBp5/kb9NbG/XhRP4c/VxLeKi+79GJ0Br5mklN5G10mr954QKIm22biBRJCMEdnWULEUYbQohPXPUuPr/sUF+FVdFVf0j7RXbxuNEDMwXqfEIW5dWROizqn68A0FvXxKw/SL4H/V3pEOEd9AupaSpXYJgXz5191a9MRLJ77yonf+3+KXonxEd9CldqGWzgJo6OOxz4LzOROw9DyBXfXBrh30VXroTcea0UyuQDletw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2Odo05zAXD78Z9elqmQvd0zkn8wbJudkLtjmi5Xrik=;
 b=wnLiyfSBbX5AMf/G1BUyWNtk78UEbVFwZPAyPjmGQTTAWHXVeWE/Memo3mabPUeFCEVuzmWV4NYzHFEgzw5iGPOPg2yaka7jNq8RJbOv8Qsud7nFElWAcAM8/UK48YxVgAefTs6x5CUb7lkmeyV+c810E3XjPQn/6Z9O5B4g/A1w0C5Uy1/rZNmE0cL/3Y6CTzK9/eGX8Nt8eHivWNG3RSnyP2TK18BPM4eFp6E3rBrULSjFraxBmhfpMxrRm9cWG3lK26Yb9a3TGkju3H6H/WJvPi68w1iRcWHpuQIt/eYSZeyMcuvAOegS5f5GEJtqzUn3j2/gFHZW6/r16pX3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Odo05zAXD78Z9elqmQvd0zkn8wbJudkLtjmi5Xrik=;
 b=Lrb/8g8svQFmSBlcDXE6QJVBPt/iafcRWOrtkfIAKFvhIX0GNs8NHopGcX98HGsY9qtuIzFI79D7ycXEXwMW59pTIRZ+rTd58Y1A5QLupfPtqfR3IY+62KMioWmXIr+rV7LUl4YlBurHAx/LyhDabNIWiM3+61zM3eRHzV9mBxmz75+YLTWbCAkQGcIp+C47yJKdN5b+seURm0Lwt+VXRtJ1NHQ/H+VyVWw0Dp89G1wG8hx1S3rH16hJ96mbb1dS6M62XHu0+vkhI5VTiXLEQkYT7ZNU4acyT6u4M74Douh14CmQ+ehCTtdw8AOTAvHWJrkDyiujPHzizbeTQbOcuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6667.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 13:46:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.025; Fri, 11 Jul 2025
 13:46:26 +0000
Message-ID: <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
Date: Fri, 11 Jul 2025 09:46:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local> <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dc60d1-05cf-44c9-e56e-08ddc0815508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU91Rk11UVZsQmhaVFRPZlEvT0VqTTlUUGNuQ0t5eFpDZE1iQlZkMklpVWVF?=
 =?utf-8?B?YkhRMFFMVWhrck5LcTVtbVVvN2d1MWo0SStYVDFSU3lSaDl3TGFVYVhjSkl2?=
 =?utf-8?B?NWFuWVUyTm5iRUdackVNOHpJMlJKeVhEVXBUZ050djRVYUU3KzUzZ2lXUWI3?=
 =?utf-8?B?VXVuRlpJWnJ6Zm1zWmk2ejZ2ZGcxNnhlVjBzNHd6MFFHcSttRDNwSmUycVlR?=
 =?utf-8?B?M290aUF4VnI3WlNwVzFWS3dqTzNCamFvVm5hOXBqQTcyR2Q5MDdjbmlwbkFU?=
 =?utf-8?B?Q2NBd0dCL0dtZGNla25BVEJzMnllaFlVVkYyZHcrMlVvbVpRdHVibHo3SWpw?=
 =?utf-8?B?S3JOUzdBZkdPZk44QWE5WTF4ZjZZY29vc3o3WXR1cjNYM3pCbTRzTHhPOVpQ?=
 =?utf-8?B?NkMvdjRwNGlLVzNTRWdtamZ4NjdXVVZQK25RZHA0S0dZT0x5b201dVZySEpU?=
 =?utf-8?B?U0R4OTlhTnJqdFhlTGRJSHorbGl5dElNNUIzV2pVK1dON1ZtQ0szN24xc3Ar?=
 =?utf-8?B?bFVXdE4rVDlTSzJIM25CSHFlT00ybTNka25TUE01aXpmWmFldlA2S3ZsYW1u?=
 =?utf-8?B?bk9IZWpZWmJxREYraFRFaEdGTzVtRkMwdmtwazY5WThZeC9NT05LNGpRYkZ1?=
 =?utf-8?B?QTBUb0JuL1crNm5BVlFWSWNMZGpZanVNWUtrQTZ0QkhqSUVScWk1OHdIM0dW?=
 =?utf-8?B?WlAzYUlGcE5ySlJoY1ZTRTI2ZEpnMmN1U3gvZEZIUDFRUHBQWlM5UkZzcnJm?=
 =?utf-8?B?UUZsTGxHaWFuWWdsaDVpb0UvOUZsZjNKYzI5NFBkWU56M0N2ejRiVUVCeFAy?=
 =?utf-8?B?enBhUlRXUjdySWgzZjNYNWNkNmFMak9wa1I5UitYcDVFaytXcHhYamtKeEhE?=
 =?utf-8?B?UnhGT3pHZ2VVRnNtVjFocFpNeVloT3NFczNKWTJrcWRCQUkyd3BPS0hjM3Nl?=
 =?utf-8?B?UkxMajhmWFJBTnJGd1Mzd2NkaGxYQ1FmVzdJa0lHb2lxUVNwRDI2TDMySTZ0?=
 =?utf-8?B?RC9sREQ5V09MQURPYXNnYy94aG5qYWliRm52M3o2dDJSbjZsWUo3aUQyRU5w?=
 =?utf-8?B?U2VqWFU2aXhETCthTGxra3U1S2s5dnN2ekdIVWFXdUdMSHRjNFlsU043L3V6?=
 =?utf-8?B?aWJkdEZsT0kxZXlKbDBoODdabDcrNkNZNmNId2hzKy94SG1Ybi9rWm0vWXV0?=
 =?utf-8?B?K3VBNHNVYXRYV2NobnBneW04TGczTUpzUmVNNU9xTWo4L0VPV1V0cmxmbnF4?=
 =?utf-8?B?ZXZlaTRxZUIySS9HZm5MUnIzRzVXaHByR3NRd1A0VWdSd3FpdURFUXE5bURT?=
 =?utf-8?B?SVp6ckVBWnlvWFR1WUJYWDE2YlduUXBIT2l6eGxvUytWSzdvbGhZVDlkUmZK?=
 =?utf-8?B?TXBIWlROenBZSzQ0OXEvbUJxaWVKVE95Rk5IYk9aZnVQTmtSaDRzQWNSU2ZO?=
 =?utf-8?B?MDZoMk1GTmswN1BERWwvZGlQaVk1QVNIQUkyQWd6bWY4Z1Z5aXF4WFZPdFdY?=
 =?utf-8?B?UHdaWWt5aGhQbkNqTm4xODhZVG1KWk94L040T0M5TEZZekNmZVNoeTBwei9z?=
 =?utf-8?B?TXNvdDJjQW5PTHRNTmtkSDlsQnErL0xnTE5QblBoNzlPRTRWVDhmVW5pcmdN?=
 =?utf-8?B?Z0NpZ0piWEtIcEpheEliOC9JUDM1bDlMcU9QcURoUk9EbUxpU2ZVOFNMaXJE?=
 =?utf-8?B?T2pYTEwrcWRkTy9WaFVpSE1YQTdIWnBOcWdlSXBxcDQvYTFNNm1tNXYyb2VT?=
 =?utf-8?B?QWZ3SHlrQisvaWZlSk9seU1zZWJpS0ZiT1JOVGR4WEVMWUR2NkJvallqZVhC?=
 =?utf-8?Q?d6BSzdlkdWRsDlL+wUaBNs28KDdUpkX7LL9z0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGFRWmZaek5yZmZoa3NVSHBzVXlPWnhEaUxmUExsVVZDWFo5UXJqd3d4blBn?=
 =?utf-8?B?VnNqa1hHcmxxYXFxRCszZ0xzNmlyaEMrV3IwZEh3Y2VibFpRMFlVR1AvZGNU?=
 =?utf-8?B?TGNGd1kxK1pQb1lwdDd2YVF0NnRzQ0NpR3h1WmNyZXFENkRZbWtvcWladElr?=
 =?utf-8?B?VFNXN2REcHo4L241NURtRUVCOWZ6VW82RTBrRlpxejZtby9SSnZlR3RwazBv?=
 =?utf-8?B?aDc0SXMyS0cvMU1JN3N1T3pKZDZiQzZ6REFRcFlaV0YwaFVJYk1od2I1UWRJ?=
 =?utf-8?B?d3BxZEpXWlhGWnQ2N2RDUEk5c1dMMWZMMm9GcS82SVZ2TjZRMDZsZ2JZRW52?=
 =?utf-8?B?MnAvQUhmSk1TYmRTL3REVTRJK0crZUpYNmpycGcxaVVpdXgrSExHb1FvaVRj?=
 =?utf-8?B?RHh4eUNGMmRNTzMvcXAyKzBMSWVwR25COWFDS3NYOVgyUEk4dVhCTkVsRVBa?=
 =?utf-8?B?MTVHdmpXY09qSkNrK05qbVpKaUNuMnlUOW1hY2xTS1h0a1dOUVZiVzRQOUZ1?=
 =?utf-8?B?cUo5R2VvODNoTHl0bnFTemxobnk4dTkxVWhYdEtZUmVSdlVaeGVPTld5bm9I?=
 =?utf-8?B?OGEwSGRUMllMbmpLNndxdWZhMVJkVmRaZVpFRy9HOUx5SHZPNGw1UkIvTlBH?=
 =?utf-8?B?d2NLS1BwZUFKV3dHeVJQK2FUMEx4UXhrM1V5ZnVTeWxLQmQ0Kzh3TkVxUmFl?=
 =?utf-8?B?OVRoQnhXa2hYUGQxMUZoZFdBNmdGTE5OVjh6V01BQWlFUEZnb1pvTGtTbFBw?=
 =?utf-8?B?QTRWTGZ1WUJDdGtWR21yN0hicCtWdXM0Z1ZBTGg3aTZGZk53MEFBMGdEcE1j?=
 =?utf-8?B?K1JFQjV2Y3VRZSt4d2s2NVhaT1FzbG5UUXYwckVxNmg2a2VaT3R6N3I5bmYw?=
 =?utf-8?B?cXNGQjA1NG5FN2pPclZmVGFZWU5nQjFLK2lROUJXZ2dDT2hpTTBGL2QrVmlu?=
 =?utf-8?B?Nzk0YW9QWlVNSlRBMmpNUklRbXdpRGdrWFFkbHlZWHU2bXhOOFR5cjYyUjhT?=
 =?utf-8?B?UjFmbzBlSFdFeVN2dFJZaHpacTljL0xyWE02MWozblJJTTd3SXdLTXV2S3h6?=
 =?utf-8?B?N0VMTlJ6ald1cEhqNzhrQjYxRklGMitMZUM5dHk5TFlMUEY2bUpadE5KamZz?=
 =?utf-8?B?RXI5NDA4TVI2clU0NDg4a1NUZk5aanpzWWtkTjdMbXRESDYyYlBTMnA4bkFu?=
 =?utf-8?B?U2xYZ3o3eTI0eDBVUmorVEdNZmFsTHdZcGx3ZXdGU2xjVzRKcy9lQWRYUFdn?=
 =?utf-8?B?S3g4S2k3YnZuVGMzOXhZNzRFZitaSmk3MDYyclpmb1Q0NFRDenVlWFlheHJQ?=
 =?utf-8?B?Zjc5M3EyZ2J2Rk5YS3pwVWR6anFDS1RMaktMWmMzK2hXKzhmTCtSZS9tM2ly?=
 =?utf-8?B?ZmlkRU13WWNYam9pTWFobGRuYUlxOGVKY0VoSFR2QlJYTVBXakxrc0o0azVS?=
 =?utf-8?B?L3J2S21hWTNxN0NjZkltVXI3MGlheStZazZMd085eUllZkZqRVcrUnl5akF0?=
 =?utf-8?B?a3pTdGZxNEtlRmZlb2lBcUIzWDI2MGtVUjMyWGEyY0ZSREhMUkVRaWVBeGRX?=
 =?utf-8?B?NVNBbDh2WWtFNFJPZzdFZTBoVFRISmg5Uzh5czNTcFFjMFZaVDluL2pwNy9N?=
 =?utf-8?B?dHJHZzE5TTZRMm9xeXZWRU93dVVZcGErcVM2ekJDRWFPbGVSUUI1VE9lcG5n?=
 =?utf-8?B?RkdKekd2QlF3VSs4Y2RsV1lDNmt1R1loeFl4L0ZXM0g2SlRoRGV5SzE5bzJv?=
 =?utf-8?B?ZTJzQW1hbEx5UC8rbkpZeDR1ejFPVm1JNnllZXVuUUUrTlkvL21zdzd3eXFX?=
 =?utf-8?B?ZWtEb2UzWWRDdHpheDJKdzJGcEJnOG9tc2lMYWdCSE1wY2tHSmh3NnlBckVN?=
 =?utf-8?B?K3dtMHV0S3Z0aitVT0ZwOHVvZ1FDVWZ6aDhFUzVuZFNVWTNldXdNT0IwcGFU?=
 =?utf-8?B?WDZxaitaSS91bUt0M2V5ekZlRTJpUXhHN25qNGNwL2Q1OVRrZzJTNlJkYnFh?=
 =?utf-8?B?UDdoL2ptYkNhRTdDbDdmK09DQTJVcm55dGZpK0QramdSMU1lR3VHVmdpUkwz?=
 =?utf-8?B?YlhvaVByN0Rya0ZkVDVxeWY1cHRQcGlMRTlGKzNvVGRSTGhJVFdBMXNVRmZF?=
 =?utf-8?B?ejB3anVINDNQd0NJS3dZV3BFRVpWYzcyYWhvUm9uN1hwNWRIKzZkSU5yT29S?=
 =?utf-8?Q?etIyulYTQHRgaiJzWEHMSW0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dc60d1-05cf-44c9-e56e-08ddc0815508
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 13:46:26.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECPd4mxTbBGP9U72o7kFL9c75MRGFyOOeurlZIZtBm4OFtSLEzMtSkCm1cU1ogfn0AkZyTlcSxjJv/03p7TSI829U7H3xkHpAQYDQ0SZbC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6667

On 2025-07-09 14:33, Paul E. McKenney wrote:
> On Wed, Jul 09, 2025 at 10:31:14AM -0400, Mathieu Desnoyers wrote:
>> On 2025-07-08 16:49, Paul E. McKenney wrote:
>>> On Tue, Jul 08, 2025 at 03:40:05PM -0400, Mathieu Desnoyers wrote:
>>>> On 2025-07-07 17:56, Paul E. McKenney wrote:
>>>>> On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
>>>>>> On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
>>>>>>> On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
[...]
> 
>> I have nothing against an immediate IRQ-work, but I'm worried about
>> _nested_ immediate IRQ-work, where we end up triggering a endless
>> recursion of IRQ-work through instrumentation.
>>
>> Ideally we would want to figure out a way to prevent endless recursion,
>> while keeping the immediate IRQ-work within rcu_read_unlock_notrace()
>> to keep RT latency within bounded ranges, but without adding unwanted
>> overhead by adding too many conditional branches to the fast-paths.
>>
>> Is there a way to issue a given IRQ-work only when not nested in that
>> IRQ-work handler ? Any way we can detect and prevent that recursion
>> should work fine.
> 
> You are looking for this commit from Joel Fernandes:
> 
> 3284e4adca9b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> 
> This is in the shiny-ish new-ish shared RCU tree at:
> 
> 	git@gitolite.kernel.org:pub/scm/linux/kernel/git/rcu/linux
> 
> Or Message-Id <20250709104118.15532-6-neeraj.upadhyay@kernel.org>.

Whatever means of tracking whether we are already in an irq work
context and prevent emitting a recursive irq work should do.

Do I understand correctly that this commit takes care of preventing
recursive irq_work_queue_on() calls, but does not solve the issue of
recursive raise_softirq_irqoff() caused by tracepoint instrumentation ?

[...]

>>
>> As a side-note, I think the "_notrace" suffix I've described comes from
>> the "notrace" function attribute background, which is indeed also used
>> to prevent function tracing of the annotated functions, for similar
>> purposes.
>>
>> Kprobes also has annotation mechanisms to prevent inserting breakpoints
>> in specific functions, and in other cases we rely on compiler flags to
>> prevent instrumentation of entire objects.
>>
>> But mostly the goal of all of those mechanisms is the same: allow some
>> kernel code to be used from instrumentation and tracer callbacks without
>> triggering endless recursion.
> 
> OK, so is there some tracing anti-recursion flag in effect?
> Or is there something else that I must do before invoking either
> raise_softirq_irqoff() or irq_work_queue_on()?

Note that we have two scenarios:

- A nested scenario with a causality relationship, IOW circular
   dependency, which leads to endless recursion and a crash, and

- A nested scenario which is just the result of softirq, irq, nmi
   nesting,

In all of those scenarios, what we really care about here is to make
sure the outermost execution context emits the irq work to prevent
long latency, but we don't care if the nested contexts skip it.

> 
> Plus RCU does need *some* hint that it is not supposed to invoke
> rcu_preempt_deferred_qs_irqrestore() in this case.  Which might be
> why you are suggesting an rcu_read_unlock_notrace().

The rcu_read_unlock_notrace() approach removes RCU instrumentation, even
for the outermost nesting level. We'd be losing some RCU instrumentation
coverage there, but on the upside we would prevent emitting an RCU read
unlock tracepoint for every other tracepoint hit, which I think is good.

If instead we take an approach where we track in which instrumentation
nesting level we are within the task_struct, then we can skip calls to
rcu_preempt_deferred_qs_irqrestore() in all nested contexts, but keep
calling it in the outermost context.

But I would tend to favor the notrace approach so we don't emit
semi-useless RCU read lock/unlock events for every other tracepoint
hit. It would clutter the trace.

> 
>>>>> One possible path forward is to ensure that rcu_read_unlock_special()
>>>>> calls only functions that are compatible with the notrace/trace
>>>>> requirements.  The ones that look like they might need some help are
>>>>> raise_softirq_irqoff() and irq_work_queue_on().  Note that although
>>>>> rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
>>>>> avoid its being invoked, for example, by disabing interrupts across the
>>>>> call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
>>>>> do the disabling.
>>>>>
>>>>> However, I could easily be missing something, especially given my being
>>>>> confused by the juxtaposition of "notrace" and "usable to trace the
>>>>> RCU implementation".  These appear to me to be contradicting each other.
>>>>>
>>>>> Help?
>>>>
>>>> You indeed need to ensure that everything that is called from
>>>> rcu_{lock,unlock]_notrace don't end up executing instrumentation
>>>> to prevent a circular dependency. You hinted at a few ways to achieve
>>>> this. Other possible approaches:
>>>>
>>>> - Add a "trace" bool parameter to rcu_read_unlock_special(),
>>>> - Duplicate rcu_read_unlock_special() and introduce a notrace symbol.
>>>
>>> OK, both of these are reasonable alternatives for the API, but it will
>>> still be necessary to figure out how to make the notrace-incompatible
>>> work happen.
>>
>> One downside of those two approaches is that they require to somewhat
>> duplicate the code (trace vs notrace). This makes it tricky in the
>> case of irq work, because the irq work is just some interrupt, so we're
>> limited in how we can pass around parameters that would use the
>> notrace code.
> 
> Joel's patch, which is currently slated for the upcoming merge window,
> should take care of the endless-IRQ-work recursion problem.  So the
> main remaining issue is how rcu_read_unlock_special() should go about
> safely invoking raise_softirq_irqoff() and irq_work_queue_on() when in
> notrace mode.

Are those two functions only needed from the outermost rcu_read_unlock
within a thread ? If yes, then keeping track of nesting level and
preventing those calls in nested contexts (per thread) should work.

> 
>>>> - Keep some nesting count in the task struct to prevent calling the
>>>>     instrumentation when nested in notrace,
>>>
>>> OK, for this one, is the idea to invoke some TBD RCU API the tracing
>>> exits the notrace region?  I could see that working.  But there would
>>> need to be a guarantee that if the notrace API was invoked, a call to
>>> this TBD RCU API would follow in short order.  And I suspect that
>>> preemption (and probably also interrupts) would need to be disabled
>>> across this region.
>>
>> No quite.
>>
>> What I have in mind is to try to find the most elegant way to prevent
>> endless recursion of the irq work issued immediately on
>> rcu_read_unlock_notrace without slowing down most fast paths, and
>> ideally without too much code duplication.
>>
>> I'm not entirely sure what would be the best approach though.
> 
> Joel's patch adjusts use of the rcu_data structure's ->defer_qs_iw_pending
> flag, so that it is cleared not in the IRQ-work handler, but
> instead in rcu_preempt_deferred_qs_irqrestore().  That prevents
> rcu_read_unlock_special() from requeueing the IRQ-work handler until
> after the previous request for a quiescent state has been satisfied.
> 
> So my main concern is again safely invoking raise_softirq_irqoff()
> and irq_work_queue_on() when in notrace mode.

Would the nesting counter (per thread) approach suffice for your use
case ?

> 
>>>> There are probably other possible approaches I am missing, each with
>>>> their respective trade offs.
>>>
>>> I am pretty sure that we also have some ways to go before we have the
>>> requirements fully laid out, for that matter.  ;-)
>>>
>>> Could you please tell me where in the current tracing code these
>>> rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?
>>
>> AFAIU here:
>>
>> include/linux/tracepoint.h:
>>
>> #define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]
>>
>>          static inline void __do_trace_##name(proto)                     \
>>          {                                                               \
>>                  if (cond) {                                             \
>>                          guard(preempt_notrace)();                       \
>>                          __DO_TRACE_CALL(name, TP_ARGS(args));           \
>>                  }                                                       \
>>          }                                                               \
>>          static inline void trace_##name(proto)                          \
>>          {                                                               \
>>                  if (static_branch_unlikely(&__tracepoint_##name.key))   \
>>                          __do_trace_##name(args);                        \
>>                  if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>>                          WARN_ONCE(!rcu_is_watching(),                   \
>>                                    "RCU not watching for tracepoint");   \
>>                  }                                                       \
>>          }
>>
>> and
>>
>> #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]
>>
>>          static inline void __do_trace_##name(proto)                     \
>>          {                                                               \
>>                  guard(rcu_tasks_trace)();                               \
>>                  __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>>          }                                                               \
>>          static inline void trace_##name(proto)                          \
>>          {                                                               \
>>                  might_fault();                                          \
>>                  if (static_branch_unlikely(&__tracepoint_##name.key))   \
>>                          __do_trace_##name(args);                        \
>>                  if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
>>                          WARN_ONCE(!rcu_is_watching(),                   \
>>                                    "RCU not watching for tracepoint");   \
>>                  }                                                       \
>>          }
> 
> I am not seeing a guard(rcu)() in here, only guard(preempt_notrace)()
> and guard(rcu_tasks_trace)().  Or is the idea to move the first to
> guard(rcu_notrace)() in order to improve PREEMPT_RT latency?

AFAIU the goal here is to turn the guard(preempt_notrace)() into a
guard(rcu_notrace)() because the preempt-off critical sections don't
agree with BPF.

Thanks,

Mathieu

> 
> 							Thanx, Paul


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

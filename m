Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AD1E522;
	Fri, 20 Sep 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726808452; cv=fail; b=EYJc3sWvp/Z6F7fP6fFFINJF3zmBT9rVmbC8XGtvpGJ74c3GbuQk1Q4mzqm+n4zC1JrnHd+wiQBI4UUCIIjsAJrlz5ax67V3c5/Odh02VeZsLFlXHXd9yuCv4K5RRuXmwyMxaB84zBSlALLs/NQzlOjuDuibARGyOI4vZ5FaNEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726808452; c=relaxed/simple;
	bh=OvEw5qpd5ID6zhieSstH9eW/1cqtyzKdiG0cdQRAl3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlSOgje1FopAkyT/s6MBMuLnLXUpDz76mHm4V7M2djrsidQdPdJpRrta3xaEdzWJEOsQcQhyYa+oOONH9JqJjRzrBskx2lvjta8rNxNqImkwGlZylE+UPM5EDI2gZk0WO8DJ0ahaGKctWXF5KKmU9fGb3AJj0MmpGcQ7CD1fL48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8X01HrQ; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8X01HrQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar8MnayJoA9shhknIg+HL6RQ0YXcqoJE4gacNglf3qz6WS4V5fYMsTAczCFoNHSvQ3AwlAnJeVQyG4cPTRU6cfFn5SY5K6D+l89XmVV9oBvk2NV2r/cQjb4gzzkrwJksVPhpWkTd9pZF6na/9gL0wsLy1szSlU8YA2Q+9MlDBcVCcSsXHuqeEOzD5xhRexsp9vxj7NJdyA/9YBUqVhFXcOAzc54FRzw6gOdan90ZDPmNhggbnv3FmagOaDJC+xFNMcoyyzVCvxCjEJiypilCTVWUbYHTIMkaEMcLrvH78HqN/XxtdrzLXjpRwr4pZdJZ5ETqNIHBC0QUqKxPzmZYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijvY8E55JCW8X56RjtBVBa36BLBU7Pi5AQai36MlAKw=;
 b=rOkt/6jfSoXm1tMMUZOEdEcxFkTDG2K7IO+wEGt00/deu+6uh68vV7LGwSbr3OWMxuphgFpTZNKBrRnwJkh01gjjx4kr97LVGWP/JUWYwreM6ti5eQbZINuJPgKk8k8g8F5Y/bMumeHZBdRHGCNUrZAkfvNZxih+Oqv3E9n5UKnj3jjEiDqrrDWLzzp3mc5poOlDeEf3JrgcG1KT1IiQoG3wFJhAIhE21FOafljEuj58fQ/uKizg78xzVpjo+KVde34BWgU5Fn2RElgUpU+4JW2smsm8UbKp8gbOUo6Qs1a4aedw+d/0P0nQXGeLcdTiDkJ7uJAxpE1w2Oy9Ob7ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijvY8E55JCW8X56RjtBVBa36BLBU7Pi5AQai36MlAKw=;
 b=W8X01HrQrkyuY3nlxxtF+tJhcftP3btiIOJLL/CNfg6AV0rCAjHRYngR+R9+yG9lM/ovrZHflMzm8Pq9anEwefgExz3KsxvGx5majnbHW+YPrep115NGpVqRx+7qqsld04Z2xGjl2dqGsp0P3Mx+KjLRq3KD7HOb8vR9RyZl3OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.23; Fri, 20 Sep 2024 05:00:46 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.7962.022; Fri, 20 Sep 2024
 05:00:46 +0000
Message-ID: <68e712df-49f7-474f-8761-6f34e992babd@amd.com>
Date: Fri, 20 Sep 2024 10:30:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
 <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: e42cca58-e029-43b0-31c4-08dcd9312fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFByRmJUUzVKamtYZlBWUDl0T0VOYTJYN2s0RUY0dGhvYnUxQUtaVHVBeklt?=
 =?utf-8?B?bEpaU2FmME0wZG1SL3RzclM0bXc1M2JGY3lmVHU5VDltRi9wWnpvcGhVOUU0?=
 =?utf-8?B?eUoxckh1ZVgzdXRKOXZoa3dRcWduQ2lrOTJXMGozeUk4Um1yOGE5aG5xQ3BK?=
 =?utf-8?B?OCtQRGo0MVNzSTJGbzBHOEdqRGpnc0pGRUdlRXZhOG9MNzAwbStqMWVxREVX?=
 =?utf-8?B?RDVSZkZsa1NjV2thVGdkd0dzT1F0NmhMdDg2eGdoRDZQczlvR3I5MWwwV240?=
 =?utf-8?B?a0plYjhOdElxVkNDV0IxR0lBTUJ4ZlFNZkJ3MGIxem55MmlyeUdkSG80ZmhH?=
 =?utf-8?B?T0lBS0VwUEJlVTJyT1pkaHM2QXBMMjVuWUVObWF1SG03YXpCRFdFQmpWTXJq?=
 =?utf-8?B?dTliUk96aXhGM25vUHptZnBvSVBpbEQ1WGdYa0dZUWEyL0EyTUFRU3BiMTBr?=
 =?utf-8?B?OXhJaVRiWDVBOVo5bENSL2ZzUWs0L3pBdUNqcFVwSVFoRzF3SW1hcE1UZHhl?=
 =?utf-8?B?Z21uUk13TWVCNzkzZXFtMldnUTd0QnlPT3hnQkFpdndCeUZWUTJlbVVmQ0Nq?=
 =?utf-8?B?bUxqTDFjZGV6WFpCdUpLWVczdzdwb2p6aVEyMWJKMzZVdUE1M0Eyb1BLdExG?=
 =?utf-8?B?RkpCQkZlY2tCV0V0R1hRS09lK3d6Y0NFazN1c3JzRkhVS3lLbkJTZW9VQS9J?=
 =?utf-8?B?WGk2SjR2eFNsY2JlR3ozMWQybEJvN3p3R0JQWWJUTGtEY2ZOVHhreVFsL0xn?=
 =?utf-8?B?c2I3cUlkVkJkWU9oYktXTUd1b1FBTkN2QnJsTlpQU2FqUm1rRWM3aDkzSWRM?=
 =?utf-8?B?b21ETTJodjRLNS9ZSllmUVZubG1yUFBDckJEQ1pIdlRzQWpObUx2ckZDWU8y?=
 =?utf-8?B?a3BVeThlUlhmTDV6MGkwQWJNRmFMUlJuZTdaYlhpQmtmT2dvb0RTQ1RDSlMr?=
 =?utf-8?B?WUhXaThXdnA5SWYvOHBsR0x5L3lSWGlmNHNpWjU2YUNLaVJYOGFiMzVhTXl4?=
 =?utf-8?B?cmJxY1E0UUhjVGFRTnByL3dMMkN0UWQ0UFFNMDJvS3V0bC96Qm94SE5GRDds?=
 =?utf-8?B?aGVwOVB1YVk3N1JxRGlLd09sUXlvdHNmU2VtVzFqMENXNC9qdVNRRk1obWxl?=
 =?utf-8?B?VSthZFY4dk05K0xKR1VqaHZRSWYvMGVOWjlRaGJEakhKWWgxSnZBLzd5dkJE?=
 =?utf-8?B?c3V1eWJLZ0tvNlFYSS9xU0JLOVZpOUtiMXhycnFIYnVWc1ZUMnZKTFpINTBr?=
 =?utf-8?B?SmdIWVV6SnNtT3YzcWIwUUNPOGtoR3BUTnhUTWRQZjRRMmY1a2x6NUk1NDF4?=
 =?utf-8?B?VlBPdXVUZkRHY2R4VUtyS0xNamVvMENrYWlLOGdGck10cWRlTE9hOTlvakdq?=
 =?utf-8?B?dnJuS3pMTGt6MWJvVjFPSlB6clJTWkp1WFN2cVVkQmVweVRBWDNlWnJMYlFX?=
 =?utf-8?B?ajlNRDJFS0cvWHlwZ2VGb01xOVM3ME9Ub3laNnZ0NkpTL0M3enBibTBUSUdi?=
 =?utf-8?B?cHVnVkUwaWZoYk43Q0ROdnFiUStoVFA3Q0d6OFNiZ2IxY0l6bnJQSzhWeENm?=
 =?utf-8?B?UWJnOGZCM1VPN1pHRm5oZHpXb1gxdDlZNEdwemo4YkRkRFBzT3phMFU3ejdX?=
 =?utf-8?B?OWNrQUVCc0pJMGRGOVRwZkMwQlphQWNBQmpFSGxXd1R2ZHBON001T01Td3hu?=
 =?utf-8?B?Sm1SNWZMeGRwczRiaHRoU0NsUlNhK1hXQWZzOWVQMlZjckFKeFBmY2ZDcUgv?=
 =?utf-8?B?enVBK3RUT0pkVDVSTlIwY2J0cGVObnRiODRxWVhLQlUxNW1sejNDMXl0dEYw?=
 =?utf-8?B?WEN2c2JFbW1YekVOUFhtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SndlRXhJdUsvbE1UdzdPZFA4TVV1WitGcVBDV1B5UEh2SWFyTFlDT3piTnds?=
 =?utf-8?B?MFV6MHJXRFVYL0ZqdkhGOGZPUUMyL2xzYzZ3d3BUTThLY08rSVA2UkVkM0p4?=
 =?utf-8?B?UUsxcEoweU5hSDZvZlo2NlgvZWFyTWk1RUQxM3I2R2Z3Z0JNeElOTWVMeWM3?=
 =?utf-8?B?T2h0ZjF0VGo4U0poM1ZKdGZVZHkxK0haV1V3WUJQNjFqVkIrWERtWDRoK0or?=
 =?utf-8?B?c21tRUlSNDNDMnRON0NGc1NZOEcwbEVsQURiblhwNmpkWFFUVVdVSHdPMFhR?=
 =?utf-8?B?eGU1WTRzQW5Bamo0dnhtbndMT0VKT1p0KzduRjZQbm15S0FVengrSmJSY3da?=
 =?utf-8?B?N3BCOUZzMThBWEJwelNHZTZycG5NWWk4a0p6dllUNUVFWk5oTFFEYVBkeU5F?=
 =?utf-8?B?RE9welNWcXJrK09mclFlMktMWmdpWVE4S3EyNUNSeHoweGVnSFdDSGVMQ081?=
 =?utf-8?B?N3ZvVUQyVkd6L2QxRFpzOGVmWlhSOHI5YWs4ZWpuYWFIMVdUajY0SkttTXg0?=
 =?utf-8?B?TXFPTnppZm5PMVM2MkNBWExHVjUzd281SXdKM2w4TGdmZ1RFMzRab1RZZVFP?=
 =?utf-8?B?elVUQ2pURFo2NVJFYVlBdVlVNHk3TU1CRFFxVUpCS3diR3AyWGJaQnZvRzdp?=
 =?utf-8?B?cThXbkNQOXRiN09jdmNOSHZ4NnFldlQyUU8ycTV5VHVOc2tDSHZHd09qM2xn?=
 =?utf-8?B?VitMTVI2Q3pMeUZSRURxelpPOVBVWmVBcGg1dXBCYXZLdVFlWnYxTVEyNmpK?=
 =?utf-8?B?V05TRTF3azd0dXFtMlZCTmVDcG92VVpPYjBrNFlpZ2tscUd1Ulhidi9ERWlF?=
 =?utf-8?B?YVVsaFhZdytrVndEcU9JVUorcDFFb1BJYnRINDZUejg5alVpZm15dm0wOWgy?=
 =?utf-8?B?MmRqcWdmQ2VFMVI4SVNxeElaczVONGlEZ0tUamE0ZXJ1RjhrUVg4QjlpOEh1?=
 =?utf-8?B?U3FKSXkrWGw4Y2c0SWEwVW9zeXVTUG9BUzZwZFBSV3BkYU01eWZQbnFMNHlt?=
 =?utf-8?B?U1hoK2pSamF6ZytPZVpDTG5JRUl0SXFJOHdYemVmSnFGUVZSdFRDT3E1WVhl?=
 =?utf-8?B?SGxKQ1ZmYldBTGVoN0ZDejJSUlgwUm5GS3ZUdW90TUIrTk9YRmlPYmRSai8v?=
 =?utf-8?B?cFhzN0dFK3NJWHBhUGl5dXlQSmh4cXF1K3p1OS9lWEczdm1Gazd0cXg2RlZv?=
 =?utf-8?B?eURvMC9YdEpVR1liZUVSR2pPZ3BhUEdGb3NnMzh4VzNWMXphbHFad1BPdHFL?=
 =?utf-8?B?ZmZlZUZObGVCNnE0ZUo3WFZxTmJydlhucThOYmJQT1B5NG01dGJaVnZSb2Rj?=
 =?utf-8?B?Ym9BcC9LQ2dweDRRM2tRaFVQY05WNU9KNFJoS3dqTEJSd1BkZ2JBZ2R4V1c5?=
 =?utf-8?B?K01xNFMzMndPeWNMbFlZMG9vQmJ6cVgvbHVOY3ZrTVROcGdpZG9ieEd6QVlR?=
 =?utf-8?B?LzgwekJYd2MwbGdYVVBVUlNtSmhJZmxQK3NBNUZOY0g2Z05GSkhIdndtbmhn?=
 =?utf-8?B?dzFDTmQxeXVrSkoxWStZeGlCbFc2bmcwVUtlczRJaVJ3aXVaa3BXanRDREp2?=
 =?utf-8?B?WjBDc3hZeU16bzkzQWlwcWRTUHY5T0lyTkRzcEhWNlY4NmNUWDFQcnlvOWpF?=
 =?utf-8?B?OEJGWmNlRHJlTHA5SHlEZE15MFhBdmhYbHo3Q2IyWlBrYjhCMDh2ZXdGNWor?=
 =?utf-8?B?Y1E5TDloQnNFaTlGb2tPcUVpTTFBdFNCTGpMUytOV3hBZFNtS01CYVJicHdj?=
 =?utf-8?B?N3lMNUUwOVdFTy9Ta2p1NDh0aWdFZXdqVmVDYlpqTzZxU1NxM1ptN29FWTZ6?=
 =?utf-8?B?OVBoWTEzbGR1K3NNWUdLY1dKc3ZETlRJMEltelA5bmU5c1BlZk5DYkpyOWxP?=
 =?utf-8?B?Mi9LWVNDYlpLcDkxa296YzFqbHdpbVRSUDM3MDR2WXJwdzludS94MmxxQWov?=
 =?utf-8?B?QWJxc29LcUtiU01MVHpvNGZVekJzK1NJZytKc0tXZklQZmJua1BWOXB3YktT?=
 =?utf-8?B?YTRXcG01dkc3WHYxK2Z3SVJVRENsV3Q4SkNKUlNzSFRqTSs0d1YvRlRIb1dT?=
 =?utf-8?B?c2ZqYWpoRERCQ0JWQmRpTmMvR3lydEtRZjJMV0ZxaXVjSVNoUVc3R2lXWCts?=
 =?utf-8?Q?Q1gilLQa1sLwccn2ac2ijgjpN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42cca58-e029-43b0-31c4-08dcd9312fde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 05:00:46.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TEW3o3gXaAPdVEZz6RrhLltWxIiTWketoAlzayzVMbnNccRSBYyhqMW8rNy7K1ZVVSQtCm0Q6U+svXf26Dbrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339



On 9/19/2024 12:16 PM, Linus Torvalds wrote:
> On Thu, 19 Sept 2024 at 00:44, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com> wrote:
>>
>> While we were working on this problem, this refcount scalability issue got
>> resolved  recently with conditional ref acquisition [3] (however, there are new
>> developments in apparmor code which might bring back the refcount problem [4]).
> 
> Honestly, the various security layers should be a whole lot more
> careful about their horrid performance issues, and I think that [4]
> you point at needs to just be headed off at the pass.
> 
> No  more "the security layer is so bad at performance that we have to
> introduce new ref mechanisms", please. Let's push back on bad security
> layer code instead.
> 

Ok got it. Thanks for your feedback! I had tried using percpu refcount first
(in place of kref) in AppArmor. However, that required managing the last
reference drop (implemented in [1] and [2]). Mateusz has shared some ideas
in his reply to this thread. Maybe that is a workable solution. Will defer
to John on this as I have limited understanding of the cred management code.


- Neeraj

>                 Linus

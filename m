Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB1C9EC9;
	Wed, 18 Sep 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726699460; cv=fail; b=gl5xWEs9kRQgJC6ZY7leb8wLwP/N7+fv4mXhO9LJ9PIcS+sBqh+mAW+Na9s9u99eWFBsZYobK5FwwOpSi6PI0CpyWfnqwSf2iw0M1iwCdWjwAbzwSGPy/uOe8euK+LCQDzCvbZ9TSPunY9182OHQUvhbCVuNbbJICBRL/8g7uLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726699460; c=relaxed/simple;
	bh=FLrnTnUnj74SQOurkat6zW2EcbF3au8Ps2nW67In3xI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t87MTkD0bV5DJKvMZRy+Fy1nmRAsGVQ5xL7KHfSxFHZpJ9I7xrEuI8Iia787ZQZZCX78SF8Xy2G0g2ckWk6HNqAg6ldqnTcwiqJOFrd3/BUvPRvHvYwVU4Eq0Lr6/VaDoeiZm19PtQ94DlrJ8luFN8U8+/vOppLtug/Wq0g+52c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEqLa4w7; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEqLa4w7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrpK4Kuez/5Kk5xjzCxel1kSSL7m/qrJmfEAAjcVEpD65z26gyGf0BrDN6GW0T/BtE0ueIwxHnOd33DWk149F9VJQrcy9xlP9hZ/0OI6KxNX39roIfW7HEyiSVCN3ejOIDPhXU4pDo/xusPx7lG51FciqB5B8XUUU+cVd8Q90eUNMTun1pJbCmu8f+8uwSnD4TFX+nSOqMSwNG6LFkfaZQHDTMl5dL9czUMIoYTsXZ9wsufy6ANV6R/qYcEJ3NdWZHaPwcmAeh/7r+xtX3ElVlMn2iJKIu4KVTrHUt7pc6dCtpltIAJ6JSRDdnNFoZ8KvpyUwzVFvklGBfdfoMfUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ldgzy4FlH6EhCvmeTvUjBDHEQC1whh8g6dcWMsTt40=;
 b=XXusA3lKkRXtbYVSRKLJPgDREQ0q4rLWOMl+FvUVOKd8KzYYp03kmusHnIInVKMqH2HiJ8QeNvz8Rdvch/d5Pohn7ETD1dg3glGe9GT24ms07Ig7YEWd3LELWG+9HquTo5uF1Oku2H9sgjfUyvwKQECqFpPjgXYt+TdyvC6aODwzdI/WyI1J/LJ9niA/wHV7GciRcwCKOcNFL/aBVHh28Wvkih/jFAY5QAgJecEwp47L+KD/uWafLHKjqf5kffH6kG6ifXLamvJTL1T7dku7Vkh2JJE+2a/B2Z/9JUOz1OJCS8mT2uH3uGnjV5PtzHwVh90e3UCG+jTpfHwCjfcZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ldgzy4FlH6EhCvmeTvUjBDHEQC1whh8g6dcWMsTt40=;
 b=PEqLa4w7U4DUoQfDBM3IGv/rCw99Os3UhSPuYjKOFUHfuSUZqihb6LmQr5nKvxasqcz1pQ6osUzgSzwRhxxEuqau2SpCa403PVgss1YIAvo+KO5FYgYwj5PzRNang5OMZmgDDk+LF+IhtgJeo1bV7Bnz1QHKQ8o5ugIs3v212uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Wed, 18 Sep 2024 22:44:14 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 22:44:14 +0000
Message-ID: <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
Date: Thu, 19 Sep 2024 04:14:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 538e42e9-f29d-4753-2c0d-08dcd8336b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1F2dWhEZk52WTBUUzR5dDY1T002Q2M3ZWhxdE5tZ01nZG9XR1BpMURpRnA1?=
 =?utf-8?B?VlhaVXdyd0YwcCtTbnltSWdzbXNTWE5UQnYzWllYQzNYZDlaKzYveG5IVUti?=
 =?utf-8?B?ZDhLR2U4b0p1Qm1YUDQrT2NKdDJTZ0tMNzhNK3NuREpuNkZob2pVU1ZkdUNN?=
 =?utf-8?B?K0w5N28rZTFOdDFaVytiMm5MNnVNT3VjdzZBWklSV0V2anFDVGFOUytjT1lx?=
 =?utf-8?B?QXNybzJuWjJSdTNyaUU2SG14R25ydExMZFMvTFpiN2ZxbHVnbkZqWGoyTU54?=
 =?utf-8?B?Wk1iaHBCSU5yVUhsd3JQem9lUVJVcm55SU9RSTkwcHJ3ZkNrYkhRSnJUNFpk?=
 =?utf-8?B?TlFYUW1MMjhQa2w4eWlaYjg0dW1yRG9TajIxdEUrUjNZZWh6QjhuYkwzWU9I?=
 =?utf-8?B?c1Z3eDNzNHVtOVdMZzJRWHZnaXI1dHUxNit1Tjk0QzBpbmcvSUF0U2NrRmZZ?=
 =?utf-8?B?VjQvUXVLVEdnR1pVU3FvZDNrc29qM05DL2FQZlhGdXVrQlU4Z05yWHgrS3Iw?=
 =?utf-8?B?Qjk2VzVYb1pLRDVNSHA1UHFEVU5aSmdNc21veXpWbi9NTWNLam9VcjFhZ2lh?=
 =?utf-8?B?OXgxVGN5REJDV1ZNU0YxMHFVMG15Rjc3OGlDZFlvYnV2Mjk5WndxWVVCRWNO?=
 =?utf-8?B?SEJMRklJdHJOMHd6L1RWQms4dytXdEVTb0JQTmQzMEhpZU1QTjhvemJDSDZZ?=
 =?utf-8?B?MHQ3ekt2WVltUkFyZDV5OEdxa25TKzZRbGRGS25sak80bGszTFZxR05jazc2?=
 =?utf-8?B?NE84RmplZ0pGd2dsSXI5bDZPQVVLNGw4VWNwY1JiZnlIQjZsQ2U1SWpOeXJU?=
 =?utf-8?B?SllqNkMxOUo0V2g0WDdVUnBRL0xOaHhPd3FpSXc3UnNFcFdIT0J2anppU2xI?=
 =?utf-8?B?L3NvblVaUGNJU0xUdkltbUQ4aWphRy81eW1kR3I3RXJVelQ3d1dMc2VKeEpu?=
 =?utf-8?B?d3F2cDRuUDA1dVNWNXlkRktjTlVYMTdpR3J0QzJhdFljVzM0VXhIbVFnZmRk?=
 =?utf-8?B?S1Rad05GeEx2aWl0eEZKVzlwOUg0U3hOSFN4Z2h0SFFVV0xIZ0xMbE45TUtR?=
 =?utf-8?B?aWNna2RQZURGMUdUclNIZ2gvMG1CSWFqYWtGNXUrc2w2amE2NzY3bTRJZkM3?=
 =?utf-8?B?QktFZFNCeXBDVDBiNXNWWlRocGt3MXVYWXA3dmlrUGtDckc2ZXZ0S2JSTGJi?=
 =?utf-8?B?SEtZcTJuNk9oQXZEVFU5TkVPK3VZU0Q5RmdjMmtKV3pxbktyNUkrY0UrOGUr?=
 =?utf-8?B?TnZFYXJIWHp5L3BxYmpjck9Udi94b1F5M3FYdGkwMHMwZDJvaUpVN3dSN0NR?=
 =?utf-8?B?dTQzbnJrVkovYzRFTDRQZTVEa216Z3lyTXhmbFNtekF3TWVDSzNRM1RudUdQ?=
 =?utf-8?B?Y2pPcnl2TzJSLzlRc0ZXVUtnR0tHZlY5Qk9Na3p1cGMzeVRLbElXQlpLWUpF?=
 =?utf-8?B?c3JRNnl5anNxWE1qcy9nQitSQ2lmeS9LOTUvY1owa20xNkc4UkZ1UERtRFBM?=
 =?utf-8?B?K2V2T3RvNGR2endWbSsyZnltdER5NjRTU0YwWlhyNi9BUUNoTlIzekJJUVMx?=
 =?utf-8?B?b3dWUFQ4alNGenhYY1c3VVZZdFBXU1JzeDZ2TmtUZEp4ZWFzZnZjTWZIenVW?=
 =?utf-8?B?M0liTTJWa0NUeExSN0FHOE9RZ2t5SXdlNXBrNkc1TEpUQW9iaDlOZjdHQy9C?=
 =?utf-8?B?Wlh5OER4NWtpWktiZVNkNXJOWHlZcFI2bU9TZ05wb3JkRVNrd3ZTbG9rZ0Vh?=
 =?utf-8?Q?M7SC83D8VG+t186ooEX/KV2Ci+MksoB7BPJ0Ra0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTN5cFp4RkJYQ2F0ajFRRmx4M3h6QTl1bHliZ3RlanpObnFCZG5qV1JublFU?=
 =?utf-8?B?bkxNVU9HS2F4VzA1TEdvcVY2MEVUM1lGQ3lwWVZqc3kzdVk1aUFqOHE3dUNZ?=
 =?utf-8?B?T0pNY2hMaTJoNEQySEhsNDFSQnpVaTA2M2t5aGNlSytaUTNObkM1emM2bW94?=
 =?utf-8?B?OXVZMkdOUnBmMEZmSUEyWXBPNW5LRzZiY2pPTE5rWEI3MVhHYk5xd1FlVWQ2?=
 =?utf-8?B?VlRKQmxiU3VFR2lGZ0UzOU9xdmdLRFlSMlJBbmtDRFpDMG1vekVmNWpkUkRx?=
 =?utf-8?B?Z3ArclNPYlkrTFUyTHpSOXZ4OW1TVW55Rm1NRU9uaVpSWmdVTFFOakEvbm4y?=
 =?utf-8?B?QjIxSk9IUGJZaDFEWmNGdWlub2E4NXhLUXI4U01tL2tLSWdDbWxITjQvSk9J?=
 =?utf-8?B?TnJiTkh3aHNIYUVzak45TThaRXRlenBPOWE0SlFnQ0ZEcVpnR29RLzRtSGFi?=
 =?utf-8?B?QThBMXVTNGZIcTdhRnYvNUt2Z2dFRDVNZVJFSTJzWnl3aUxSeHZVMzJEcG12?=
 =?utf-8?B?Y0tHdVFaZUJwU2g3NVVvSUtha01EMkJpR3ZOeDRkaUpMV2dmWWpUZk9MZ2sw?=
 =?utf-8?B?TXVGSHJCMnNmRkxqTVlnMnhaL2hJRzNuUTJDdi94RW1oelRjZUpOQWp1MmYy?=
 =?utf-8?B?OFU1QjEvSzdhclNnMmtXampCc0t5RFRpdDZwVDd1THRBamphYjVabHRLTlJE?=
 =?utf-8?B?THp3S2laRFE3bGduM1Nrek45Mmt2MFVXSzVRNFlGL010NFkvYUxVQ1ROM05J?=
 =?utf-8?B?YllzWWwyckk2T0pBaHhmZUlib0UvSWd6Vk1CMjYyNWlZamJWQ2FyZjJ4clYw?=
 =?utf-8?B?ZDBNV2hYMVRGcis1bGRORGRkVTEvNHdOeWlPcEtSVHBORFRiTi9rTjhCeTNn?=
 =?utf-8?B?TmFTL3loZmxsczFTL2FDZC93b016Zk1zT1NrTlFqelZFT0MwcmpZUXRxR1pY?=
 =?utf-8?B?Yk5oWkR2OGh3VCtQQ0VxSHN0U3dkZ3ZIMjlZRCt5QnVIdlRjT2k2MC9tLzNT?=
 =?utf-8?B?WVltaGxOZTREK3UzSElSTk8xMUlwWWJoMFVlRTJCSm12LzFkQlBmNXAwWFRR?=
 =?utf-8?B?a3FyQkNGVEQ2dVFJTXVkQ20rN2szN2VYVDNJcStZUmpmd3RhOVFuNm5PN1Bu?=
 =?utf-8?B?ZW9LVi93eDNYWU1jMVRxWVFtT1Jrckt2WjcyV3oySFltM2JFYk1JdHFiQ2xn?=
 =?utf-8?B?eXpqV1FOeXpjN25FOUFtWENnK1FkMmVzaEtqeDA1NGxtU0tJdmVXOVFybjlU?=
 =?utf-8?B?Q2hYMVZzblRqekZyRkRWNUh3VlcyRXBLUmNZbWJQaW9pTXRLMTdLZlJlUFRB?=
 =?utf-8?B?Uk1JaEg0eXZtYXk1OTlYOG1aSFJlaXJ3ZWZoTk96emM4TE9HNEtUODE2WUJw?=
 =?utf-8?B?a1QzS1NDZEE2OWhCZmpBb2RpbEJTK0oyUWI3UlFGb3U0RUEvbHhXcW5TWW9K?=
 =?utf-8?B?a3ZWQlZVbkhlT1E0dDdhV2QwNTE5WWtyUThoOUFxc0RnTFlhcjBONlZVbzlW?=
 =?utf-8?B?WlQ2d1l5L3FhWlJNTWI1ZnFYQ1BnU3lUTDk5S3d3N1I3WHpUY3FIcllyUkg2?=
 =?utf-8?B?Z3pYck9xdCt6Q2xpQmY1YVNSVUNmcEpKM0tBNzZIOXNlck0vN1pkK0F0eUJB?=
 =?utf-8?B?cnJSek91VFo0eEdSKzhuU3poWkxNOC9rTkowMXBlWmNNQTZsYWdrUUxUQzBG?=
 =?utf-8?B?Q2lWd2N4SGE2azVBRFpQeHRFSGhaVDZDVCtSTVp1Tk92ZHlPMzhINmFCSmVx?=
 =?utf-8?B?aE1qTmZKaDBOYTFDRFNHbGgrNVgrNHZlQWxCMmtsT1IyNTF0QmpxYkt1Zkpk?=
 =?utf-8?B?a2pQYm1SUTNaWG5wdWMzNklEMWhhMHF3QjVnUURaL3R0bitSUnlLamNEU1Jp?=
 =?utf-8?B?WlZQTUh5ZlNHSTlrdlBxWWNER0poL1dVWUUzdDBPMENqWXl6WFljbVNkOElp?=
 =?utf-8?B?QWE1UGw2TnBNcVYvYWE1QUFxdzBKNVFOMXVXeFRIdjJIK1JENjdKbWcwUXpo?=
 =?utf-8?B?M1hjM0tvZSsySnVtWi9tWk41MExNem5jYkFnQnlaNWpXUzk3N00rcVFVa0Zz?=
 =?utf-8?B?UVV5RGNheWQ2ZDJJWWJWYlNxeWpkSGt4VDUzemVzTmJ2Um41Yk1DM0xpbmZG?=
 =?utf-8?Q?M4HGE4gqX9JU+YerhBy5cfnIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538e42e9-f29d-4753-2c0d-08dcd8336b68
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 22:44:13.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhVnGWJK2gffOCYOVAllqfIP2JXoonEzMD2qlA2NWz7OPr0DFJJZrodAxPzR6AoQNNNZq12/cioDsCf+pJCmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On 9/18/2024 12:48 PM, Linus Torvalds wrote:
> On Tue, 17 Sept 2024 at 16:34, Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> This series introduces hazard pointers [1] to kernel space. A TL;DR
>> description of hazard pointers is "a scalable refcounting mechanim
>> with RCU-like API". More information can be found at [2].
> 
> Please give actual "this is useful for X, and here is an actual real
> load with numbers showing why it matters".
> 

One of the use case where we had seen improvement is - Nginx
web server throughput scalability with AppArmor enabled. For this use
case we see refcount scalability problem when kref operations
are done for AppArmor label object in Nginx worker's context. More
details about this are captured @ [1] [2].

When we switch from kref to hazard pointer in apparmor_file_open(),
we see ~7% improvement in Nginx throughput for this use case.

While we were working on this problem, this refcount scalability issue got
resolved  recently with conditional ref acquisition [3] (however, there are new
developments in apparmor code which might bring back the refcount problem [4]).




[1] https://lore.kernel.org/lkml/20240110111856.87370-7-Neeraj.Upadhyay@amd.com/T/
[2] https://lore.kernel.org/lkml/20240916050811.473556-1-Neeraj.Upadhyay@amd.com/
[3] https://lore.kernel.org/lkml/20240620131524.156312-1-mjguzik@gmail.com/
[4] https://lore.kernel.org/lkml/71c0ea18-8b8b-402b-b03c-029aeedc2747@canonical.com/


- Neeraj

> We don't just merge random infrastructure without a use-case and an
> argument for it.
> 
>                  Linus


Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A8238C1B;
	Tue, 10 Jun 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580457; cv=fail; b=Fz8OqSaqMoqIkMEvkLQA/Aj98H0mVHB8ZBAvbY6/u4CZTqq0oFEcL7FJY5FI5Ent++Jpk3j2j1QN8eLUTFpTLFaJzx4rNRl67Qzr9KbmaRlRPO8dr4ezqLtJlGs31CAEWXbePr+7nNSWeNc5qf+xjdc4Ji2/xFOBAE5ZeWCntKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580457; c=relaxed/simple;
	bh=WSuzx82Jj4cok2A576fKk5hAJ0aYlOBtA38ZkPP3wmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wqz+2ryeN2QT4LGbo0JlaZe/5ZQaWAAHqC44aA3trNkwuprfp87NghzcJjBha7HCh0PHHSkhxKrzc3Sk84t9Ry9so0g84o6JiPpwJwkkSnKTWPjh+cUo1/qouqWcgd9F4YZh3wTLMOTw3Wsp2OPSVR3OoV+KhDmQ29lvWrcEgDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KErKEoSk; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KErKEoSk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmPeNLEP0OEFZIFhodIw2ruqCocV7qvLDi7xObf//oVFWK8/1tLGuSEOhD09xEcNBEB09Zk06uM6j4uUgYt/fwsNCqXtSsfd2ahsnvAFsH4vTSBAJP0Y5WEwXs+yWw3fTaR+KZY26O0L/hCX+WsfOgEYZ1dysi+a2i175YVCGNaUEDRqn15OO5CPnvqKx67CVgKV/ZyOAm1yb/uIgrrleyC3TleQZuY/08Wu9RrceSAcjV3ki/9AgHM8i6IBs/uxuV4WKlOVjEPYl/uvM/UT4sjas2mjL2uikfF45U4wQpumULNsz2ORQbSDSTSOW34eJANes02itnc4p43ouRahKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7OvgfBGGc7X2OwxgDCJZgqsT9D4rIGIsvZw2NqiJpA=;
 b=Oc5G5EvjeG5ZSiRXm8NpAd8Shvc5k6UVw6lUJDu96bKKwXZE9xZmN4aR/QI55u1M0pdKLbsPsfxLQVE/IE3zSk956I2gZQHBF/RubUqwqE/iv/H//HqCK2Y9OJbI6i2WKhSOrKJyxzbcfYkcuoq/7fTrfbvLTOftYdvWaLuABVRgNXNPbrW03Lm0BGpYiPboSRcjBDA9qZM8TO1bP4n/W2g9BqORJnRrVG5pC50P9D3rC1qmxN3rQ41UEes2+pm1jA84xOVH7vZQzUbh+vI9D1S9XRXj6rFus0bgWKmIBJk8Zz0VVtxMotIlM74RZz3No+ucUJq+Th3vr4BmFAOQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7OvgfBGGc7X2OwxgDCJZgqsT9D4rIGIsvZw2NqiJpA=;
 b=KErKEoSklbK6aDJ9vZqP5+RYuO5QV3x2iWs2pAsbqJfY1noiBOWVXYO6SJnmENa8XSw+Ia6KARv6oJm2rhI0RAP9l1/pDLIIci/6ZGAL1Ok4rZRciy5Je+n9bNMglinidWk5QQhOm9r2A2O71W9zqcchNc7bSjKqeZmAazRmDK1Z0Tn8IUBrBwAH7O+euDd+G6985MCIgY16pnMdf56CaAapnCjyXB9IDV2HGG2IrogdHlzdbsCTRxVaEBRV5OLe0NHQ8vykv/MKRFpQRIIrVhb5qNblZlbBXR8Zn/Wtdy2gfNeUXWnZddEopAOdbgeoP3HXRdQNOd19RvMSPElJOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 18:34:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 18:34:12 +0000
Message-ID: <d55a7d1b-d0c0-4c04-b69e-ca6737c98224@nvidia.com>
Date: Tue, 10 Jun 2025 14:34:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rcu: Enable rcu_normal_wake_from_gp on small systems
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250610173450.107293-1-urezki@gmail.com>
 <20250610173450.107293-2-urezki@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250610173450.107293-2-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0870.namprd03.prod.outlook.com
 (2603:10b6:408:13d::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ef16ae-3894-4d9d-3811-08dda84d6529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW81bWZvZTRGSlJoQXZFTHErSkZuT1dhTkpJNnR0WS9TbjZTMnZQc3E3VjhX?=
 =?utf-8?B?TlJjc2ovcW4rMXJ0cnB0K1p0NjFKakVMZTQ1UENxczhncW1raGxHWUgwcjZa?=
 =?utf-8?B?elh6MFhKWjlTVXNKNiszcWFnQm01U0ozdFZXeGJMWW1uaXFxREhDK0czeFI2?=
 =?utf-8?B?amJUbENyWWt0Szl4K3dVNURsZDhYL2drcXcyclh3Wm9tQmI1ZmQ5SVRtUmhJ?=
 =?utf-8?B?TkNraWVoV3RmV3dEWWU1VUVhZWFxeE1rOC9kOURzVDlaenlsLzREbHJqSENr?=
 =?utf-8?B?VUlkdnhxbFBZSVNHZ01YdkNQVmRTSC9uaFYrL0hlVXhpQldENlRNRlVNaHJZ?=
 =?utf-8?B?YlRGTHVCYkh4N1ZkNTI0dVA3MFFFOU5IbVkyckttbUV5c2NDM1R0d1BLNUlX?=
 =?utf-8?B?YmNmdjB6cXY2VkFudk5RY1NLWXdJRUR6TzlPNEZhYXFxL2paaXdvQVpaQnp4?=
 =?utf-8?B?b0xhN1V0K21KYmZqVDhpR2dWLy94dlo5eWJPczh4aS9HVjV0ZXJvZG5WQmxU?=
 =?utf-8?B?c085RjZiYVJKYjc1aTRqZzBwaTVpRVJjN1VFRDFLMGhZM1hJMXcraUtZbGUz?=
 =?utf-8?B?cXhSdUE3QzNzeTV3MmdtdVJHVXNuU2J1RHpqcWlGZFh4SDNOSVNOcWhlRGVU?=
 =?utf-8?B?V1NuUW1SVDhDeU0rWDJSWXVYRUsxNDJWQ1dhempBQmIwdTJxNG4raTFJWkcz?=
 =?utf-8?B?cWZiWkcvQXZmQ01tekhoRmM2RDlVZUJtbU5PUkJ6ZzY2WTlzVFgrOWJUMnd0?=
 =?utf-8?B?R3BUVVFid1AyVGJNdFpxL3NZU0dyYkh3WjVCeHlnNTNpbElhanlKN0RUOElT?=
 =?utf-8?B?RlRJQjhURG1naDNOM0NkWTlRS25vWS94U28zVFFPTUZEYSsyUnJDNmxjR2J0?=
 =?utf-8?B?cDY1bzFGaFN4aUl1Z0FtV2FjdjZMWGJDdTNsd1FFM0MzN0t1UEFHTEtOSnpu?=
 =?utf-8?B?Nk9UbWpnS0t1c2c0bHRKaTh2UWc0VmVENjY2UDl6N0d2RHgxM0hBZFh3ZDV6?=
 =?utf-8?B?TlZuazJvSEIwNGowaXJ3MXZkTnk3L2tjTE9NM2dXM0RmaCt5c2lNNzd2anhY?=
 =?utf-8?B?NWJDblZYbUN0R0prb2RWVjRFNGJ2T3phRW4wYm5OR3dqT001R0pHeUlRRWFq?=
 =?utf-8?B?OHphR053eEtRVzhDM0Z0NGs2TXl6c0g3VzRJemVLK3R0UjdKVWFIUUVKcmxT?=
 =?utf-8?B?OVhuVjZBTVJVdmptSit4a3hSOGtCTTlmTjNWRWQrYnk4R01lREVwQ2xhenA0?=
 =?utf-8?B?eVpXRmJsQjQvaGFrN1BzcDlzUmdzWk5vYXJobmNPd3BueFBCeFpObG9qMElv?=
 =?utf-8?B?V292VDVjajhnVk93dFBXeUMzRERsRlpYSWNlY2RESG84N2RzUEVWUGYvVWRI?=
 =?utf-8?B?U21nclBsckVHTmNKbEJOUHNVbzUzUU1mTlpWa2xKdG9jK0FIbG1nSmY3VzBt?=
 =?utf-8?B?ZDlTVllqM2xaa0ZmakRQTzdxTWtDQTJVczZibHl2bVdKbm9qYWQyc2syck1k?=
 =?utf-8?B?bDEvaWNNM2d1cmp1QzdOb2FjZGRDNC90TG1Pd21MVTVZOTF5WmJ1eXI0ZU9D?=
 =?utf-8?B?cFNmTUlDU0FaQXRpdWljVU5BMHZTcTRYZzJTSDZRdWVWZms3MTB3TVRNTzdG?=
 =?utf-8?B?elhvVitNdjNkL2Y2amdnQlRLTC9pK3ZOb01kV0FHUkVHMUtXRlJRdzZXNTJn?=
 =?utf-8?B?Z3hLb3htSGhnei9QYlg3RFBZMk9zZUMwQzRSdmRiWHhkNHJMN0xaaDIxZXY2?=
 =?utf-8?B?N2xtS3FUZndwN3Z4NU5YUUh6alVGSUxBdkc5NUIwaGdzWFpUdFV2OWJzUjNC?=
 =?utf-8?B?U01LVG01YzREVzRmSXZUdWlPd0cveFpHWUVQQ21ESUVxeFNkY1prL1c4ajVR?=
 =?utf-8?B?ZWVHQjVxb1ZvMmd1VHprV09naTdzcEJLT1VvZXBQaVZaakJIS21TQTYrTzVI?=
 =?utf-8?Q?QSTsvFS+ZFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZ0M2hrMHltZDBmU2hTUHBKRG5mRkhOOTBka3lWZUYwMThEb28wcDRkUjAr?=
 =?utf-8?B?QVhmczljUHhWN3pzdTlic09JVDRLWEp6Z1pZWEtaTnJ0bmZoelVOK1E2VGlV?=
 =?utf-8?B?MldVbnNWWVZ4VkJLeEFWTk1EWGh5WjdiWVhnZUYrekFHd1o0elJ3Z1VBaDJi?=
 =?utf-8?B?ODh2d0svamFuMXpXZXQ1bGlZa1NzNHNCY3pJeDIxVmp1S3dNak1DVmE5YWdH?=
 =?utf-8?B?YTg5anMrdVkvK0NSQjZlUEJOeWgrQ0Y5TUpFVUhmNUw4RTlCb3c0VUNhK1lp?=
 =?utf-8?B?Z2hkTURIUXVCeFJJYkF4a25XcTlwUTBkektleEcwNHpweE5nS0laVWtiRnVK?=
 =?utf-8?B?d2oyMDdiWGFTamhyaFdRYVk4VjFoL3FNbThBV3NoM1FnNVRtM3RmRUxNNjJs?=
 =?utf-8?B?RlJnM25RaFA5V3pHTnhoajFNTjljWDhQQ0J5eTEzaENtYWVJbXdUVzE4SGpw?=
 =?utf-8?B?YnpVR2Q1bEZyZElhOEk3dzQ3VnpSdkJ3a2N4WkRSSm9lOXhVN0wxdk1Vc2tO?=
 =?utf-8?B?OHlaMEQyWlpacGFNYXlqMm55elFCbW5FdUxaSXdQakQ2N3ozYmJQd1crVW5G?=
 =?utf-8?B?NDZ2UExrelRMQXE0amZwTFE4ZHhHK3VKNDNra2VreG5QbnJqRm5qQks4WWhN?=
 =?utf-8?B?eDBpQnJpS2FJYlV4SnJ6c2g0RFpaQUo5S2RjOUI5MWZNdks4SkU4MHo4UVJj?=
 =?utf-8?B?R2I1cjZBWmI1UjF6MjlWREFZRmJhdS94dmF2bnRlR3V5dzVRbUVQbWt0REo2?=
 =?utf-8?B?b09McnYzZ1RrdmlUQ0pNdUFldmVMenJ2b0tCdXVMbVRMOERGSUhOaDZjTkVT?=
 =?utf-8?B?bDZCOHlMdWNOTGJROEFITGF4MzA1YzY3Lzc2dXNyUy9LTlNiS0FHKzFOWEta?=
 =?utf-8?B?VElTOWlVOWVlc1drbWpWNnd3ZGt5R0doR2hKcjZnOElRSHM5Z3NGWGJYWmI2?=
 =?utf-8?B?OHluc0ZZdUkrU25VY1lsc0F0ZmNTZHV5S2VYYjNCQU9lMGdodWlwYUJTZWdC?=
 =?utf-8?B?WElwZXR5MXlUYUZpRndLT215NUhXd21TVHB5U3dZTFpUVE8yR0RISVA3T2pZ?=
 =?utf-8?B?cjZvMFVlVjJWanBsV2QxWDBQNmVsRzVMRWZWaHRhdktMTG5tTUp2RWd0VUlC?=
 =?utf-8?B?NVljMktiRTNZb1BSU250S3RnODJSV1Nzc2k5N0s2NDRRalM3RlB1WllRTSt3?=
 =?utf-8?B?NTJKQVpuN3FLUUlacnJaTU1vUGRBUXkrQ2dBajA5Vy9LYlZqSVI5N0ZRbFRC?=
 =?utf-8?B?R3NFYUcxd3VUWkwwM0YrWlM2cXVHQXJlZXZrUlg5OUF1OVNVWXRycXl5WmVX?=
 =?utf-8?B?dTZJa3JhVk9MSXlDc1pkV3N0eVVvSTJ5dVdyTmZ0YzdTYVBweDVVVk5rQXIx?=
 =?utf-8?B?Z21Ld2ZLcGdQVERjcVRQZXFLdWg2QkNweVpTQTk4SXo4aWJzbnlEaXZCRElP?=
 =?utf-8?B?RWZVNHF2UTlTbDJXRTNQaDR2WGJ3NC9CWHkvbFo3VExadUFPTjVSVlliSk1W?=
 =?utf-8?B?SW9Bb2Q4QmtZc1djemowUU8wNHFlRjVwMGd1RkhhR3NvOWVyOGJjMWpuNWtX?=
 =?utf-8?B?SzNDa3RPdEJIVENCRjBlNXBocjRSc1hZcll2YkJFVnBiS3dmYzVmalU5SXdZ?=
 =?utf-8?B?REMyV1ZiUzExekNEclZkV3B4cDZjUEsyUGl3dmpocnBiK3NBelRGbWVjSHR6?=
 =?utf-8?B?bklLUm45UUVTV3hxdUxGNDhHeE5HMlBicjlyWC92TFJ5TjlSYTJJTG1wUTlG?=
 =?utf-8?B?SUFwNklOTTJldkJNdlhaNWVNbEtJMHhTc3pVeUVoSGRiYVQyWFBHZGRtaG0v?=
 =?utf-8?B?aVVMTGVmTWl2bnJxWHBTcklFdTQyQzcwZ2diUGt4L1Axak5la0hSNWxlWldH?=
 =?utf-8?B?aWtCbCs5Q08vcTEzL1Mzc29QakhrQjJ5c1luanVpVFlnbU1IbFRvTXMvMTQr?=
 =?utf-8?B?TEVWbm5lRC90bFRhVVNkbWdzY2IxMW9raWpOVHZyVE90cHZXbXFZdDdkbUpu?=
 =?utf-8?B?RFhSb0Yya2E0bFkvdnBIQkZmNEFIWExqdkdKNUNQN050bE9ORUFOQVN1MGRB?=
 =?utf-8?B?SVY1OEJkRGRGT3JGVnU5UitYQnBHTlluMUFJcGYxelA2OG40S1A5anN4T2lO?=
 =?utf-8?Q?eMozALj+Woc+5Ov+Fn/bYw0Im?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ef16ae-3894-4d9d-3811-08dda84d6529
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:34:12.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbIDG9Zs+/OQrdoZYp7YwoqzZrl4L/Zd4kedhCmSRRbLNS/gn9NKUz80Meud1/zj0M0pz0/C7C5Q1m6VjIyMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738



On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> Automatically enable the rcu_normal_wake_from_gp parameter on
> systems with a small number of CPUs. The activation threshold
> is set to 16 CPUs.
> 
> This helps to reduce a latency of normal synchronize_rcu() API
> by waking up GP-waiters earlier and decoupling synchronize_rcu()
> callers from regular callback handling.
> 
> A benchmark running 64 parallel jobs invoking synchronize_rcu()
> demonstrates a notable latency reduction with the setting enabled.
> 
> Latency distribution (microseconds):
> 
> <default>
>  0      - 9999   : 1
>  10000  - 19999  : 4
>  20000  - 29999  : 399
>  30000  - 39999  : 3197
>  40000  - 49999  : 10428
>  50000  - 59999  : 17363
>  60000  - 69999  : 15529
>  70000  - 79999  : 9287
>  80000  - 89999  : 4249
>  90000  - 99999  : 1915
>  100000 - 109999 : 922
>  110000 - 119999 : 390
>  120000 - 129999 : 187
>  ...
> <default>
> 
> <rcu_normal_wake_from_gp>
>  0      - 9999  : 1
>  10000  - 19999 : 234
>  20000  - 29999 : 6678
>  30000  - 39999 : 33463
>  40000  - 49999 : 20669
>  50000  - 59999 : 2766
>  60000  - 69999 : 183
>  ...
> <rcu_normal_wake_from_gp>
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 14d4499c6fc3..c0e0b38a08dc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1625,7 +1625,9 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>  	atomic_set_release(&sr_wn->inuse, 0);
>  }
>  
> -/* Disabled by default. */
> +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> +
>  static int rcu_normal_wake_from_gp;
>  module_param(rcu_normal_wake_from_gp, int, 0644);
>  static struct workqueue_struct *sync_wq;
> @@ -4847,6 +4849,9 @@ void __init rcu_init(void)
>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!sync_wq);
>  
> +	if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> +		WRITE_ONCE(rcu_normal_wake_from_gp, 1);
> +
I think this will get weird if user explictly specifies
rcutree.rcu_normal_wake_from_gp=0 ? Then we're silently overriding the param.
Maybe, initialize it to -1, and then if it was set 0 by user, don't override it.
But otherwise, set it to 1.  Per your third patch, '1' is a default, not a
forced value.

thanks,

 - Joel





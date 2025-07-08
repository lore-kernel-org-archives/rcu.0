Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268382D613;
	Tue,  8 Jul 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983238; cv=fail; b=QWMeoQVDDciADUNZid71wLDeoX2H+m6gx7BoFSz4eHhHNEVvZM4Hp8HpnOr54r3VeUAn9MfDZk5mf25TGk/hJctaFSyORZkDprNi3MFfiKIIeTTfF/9zi4PIX/5AiPgUpguyOxwaliO/RHJxDzW6r3UHRtrvRcJsTTtcRMvqXiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983238; c=relaxed/simple;
	bh=ArIiZ3KkohNT2dXuwAGHcUloi+tQ9X8ty+trXiyOJ8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rO/6M4WMsbgYzfE1F8GkcYJ7e5CI+0gmlFfZUq7xrcN1VlaKt3TMmNVHYKmIh452NV9P9ppa4eieEQF8BzmbSwII2Cj+qp9s1+T3Uu4vs17QdiGlOfiHi0WhFDztqwFSe4UIZKDEhheZ3lH+vgDoSHb46ySKqyXDzQha3EMFvXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPZKfOd7; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPZKfOd7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsaNSzg5n+JgtVQoXAZ9nGwVXdMKLrdIIlvtdZrkDgonFu/rB3iAUvzVlB/HMSQOjTFe19jA179Y3bm6FK+BVQ/CYIMlZbvBqUZwPygFOpiR2i7mJBICaWKycBNw6bEQm98z3os7gBjW1uZOSowToPsCEl3UXzD6tA/2OV2U0yFm0akA/kS5G+Ur4NI6E4yL08NY+hZ7Ce75MrCuGvMLOEEUu2O/RYwANlxzwsoGWcz0UPfKbsx+aZt3tRmJVZuKzBGDCRPHlTVisFKrEf/a1SgibUdPUffpsuaKiA7P1TDdDuaC0tTlWat8cGZr/WEUir4ILL56BDBRezt5TWeMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1oa6OSdJp7dQh+Yn//WwiIYU6mU+CVe2xWeP8zFZjw=;
 b=E+hCMe9V74QeyJujOolzB/BWx8YL/+1VpItNUwAgqH5EmNuno1KyTPtx2mxyCVsij5rVgUd8eA58mN7u7I694gQ28B6koRXfDGf4GSoYmTv3HUOw54jznkfhUd5gnknY1+tnRgR2JgZDv5ryUhIBPpHA5oS8Fb+R4h9bZf5odwLsXKispwVHRrCyadsOWv48RdcpTrLWZhyi1ID/4iWqKuVvoBBRzkZpgrqqD2L4QxgQqPJh14+yDIIUDiEbgPD/ARWLGyFiHSEMX1g4urOoUWdK8GTxU3CYtx2tpWFXCwFYe1+YI+RQppgQoC8LCb/yRQexWJEVvZg3Htx6jlD7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1oa6OSdJp7dQh+Yn//WwiIYU6mU+CVe2xWeP8zFZjw=;
 b=KPZKfOd7mZwrM2r4xQ422dpQ29yID5wwVDv+9hXft4TrXfy+GjmSOQifKpUp89Bkf3AAxu1J7wWO0FA5YGpZNWw/OM40FjDcFeD30/978tEsXBxHuj+pg5xo0ozGqF7IBhQC54hEVU1OW++SDc/iG1ITKe1qpAkSGJqugLc04XcJWnJerH2Qau/XeJ7TraO2k5Q3Xzm/4p0dA15+tj0xY8cCv5Tdru+SXhBSFzGq+adtwGiosUQHtfgdoZdO/ykSqLyjtjH/lo8CLiC4mdMkJX31RrRlSlabSLaC/VxdaeXMd4kton6eudlpQpwgCVDGhpjmANdDY1M6WizJeG0ABw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS5PPFE52C859EE.namprd12.prod.outlook.com (2603:10b6:f:fc00::666) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:00:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:00:33 +0000
Message-ID: <664c73de-4ad5-4d39-b7aa-9d1a14559535@nvidia.com>
Date: Tue, 8 Jul 2025 10:00:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrea Righi <arighi@nvidia.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
 <20250707141952.GA3640857@joelbox2>
 <20250708072112.GA1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250708072112.GA1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS5PPFE52C859EE:EE_
X-MS-Office365-Filtering-Correlation-Id: c37af25c-4559-482c-8c70-08ddbe27cea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZ5ZUZsaTlDN3gxTHBoUU5tY3NVYTM4dExsbGxKeHhDeEduZ0tGUUpjWEJU?=
 =?utf-8?B?WHcrT1VDUjZodXExMG1SdzBUQk5mSkEyYzR3cVdQOGE4ZXROY1FBLzRUU2xT?=
 =?utf-8?B?MXdOclgvLzNPdTM0dGwwanpsQXNxWlJ0MDJxYmNhSW9tMEJPM0lsay9ENmpE?=
 =?utf-8?B?d2FjbEt4TEwvbnZMRmtBZ0RReTBVV1NiVE1pdlVZY0xLSVdrb2UxaUJJNStY?=
 =?utf-8?B?L1NvOUN1YTk2Z0g2VnE0UjIwMmdiOW5yMXF4bWh0T0c2WjBQWnlmZXZyZDdC?=
 =?utf-8?B?dTc5ZVZ6dElkV2VBRncxZ3RXUUNpK0t5eUZpWXI2MnhJeGNVYXpSVXhoVmtU?=
 =?utf-8?B?SEUrWmNqMjl2ckgrS09LcnhWbXNPV3Evb0hucElSNnpEWllqYkJMZHJ3eVFl?=
 =?utf-8?B?QXV4OWFvaERIbDd1M3ZkLzg2ZFJEeTBzc09ITUZvWXB6cEpLNXlRQkExdXpT?=
 =?utf-8?B?ekFnWFVMRE1SSlVoZFdlMDVJWnVpUGxLZkxzUXprTGZHMHp2Y0o3bGMxWFhS?=
 =?utf-8?B?c3REWnFGQXgrL0NRSk9pLzBNcWN4cjRJL2FIKzVCcVdCcGdwcVFHZ2dJM3Nt?=
 =?utf-8?B?RjF6QW80aU5aVHNlUHhvci9ueUZiZkZISVAzb3FrYzcxbi9yZXMySk1MeXI2?=
 =?utf-8?B?TEVYWDJoYTlWb1RxR2FoYi9hMVRIRzFtM1NuSkJlYVFhT0VrVFliTmwwUkF2?=
 =?utf-8?B?SGxkNGRlaW5wdS9mT2JubTlFN3RtM2dBN3RRTHNkeTN0ZFM3OUhDOS8xbVVH?=
 =?utf-8?B?MTl3ZTlqcVhzSFVqZ0NRaVp3VC9kTmJEejE1bDk4RHFCWWRpalpTZ3FsVmI5?=
 =?utf-8?B?eE9zekFjbXB5cFZzbm9CdTZXbjQ1QUg2Q0RHK2pQRXJPbkdJQXEwN01JNkZD?=
 =?utf-8?B?bm83MDZRZWxKSnB6NDhWdHpQVlVlZlhWWW1GVWN2aUhOSFBML1N5SXI3aEV3?=
 =?utf-8?B?OTlnYTV5SC9DbmozaWhUT3pLMzRndnVXdk0zbUNHaXRwMXRMamszaUMwTnNF?=
 =?utf-8?B?WDVpRjZsNEVNRzB6SjVOWE5YYnBJM0JBeXJtVWhiOXFKSm5IWTVqem5JdWtq?=
 =?utf-8?B?MHVVNHpyTUxwcCtLMkRaVHp5akdrM3R1MTViQVQ1Y1pIdFNSRjAxTUpLWVNi?=
 =?utf-8?B?dnFOMDFLRTMyODIvcWV5MnpiUG42WlAzVTJ5cldUd0JjK3FJRXkxcmg5ZGJM?=
 =?utf-8?B?RWlMUWFlTVZnVXRGZXkzOE94bjJhb0kxTVJ4eE91L2NsZlhVTkwyV0twVkJl?=
 =?utf-8?B?TVRqRDNlaytUNCtFU3VGWHVXTUN2S1d6MzJKT01Ka2ZURlk1N0NQZ1YwNXZa?=
 =?utf-8?B?MHdmWTJNRG5Ic2luYWwycDh3b0ZTeE4yMXkvWnc1NmZEc25qWEV0WVcyWHh2?=
 =?utf-8?B?NzRHVFI2QUkwY2lISVBRR1Z1TmJnbFJCdDZLcUJLL1cyNTd6bk1ERzRqYVY3?=
 =?utf-8?B?SlRBS3NScFRISTFYTUV0R1RtemxvdUVqTnRUejhhYXBQclVJdUsvTmVDTzF1?=
 =?utf-8?B?eDF0eUNES0ZHSkFNM2I3TDRTNGphN3FLVHNQZnRObURqNEVvaXQyeGJhbEhM?=
 =?utf-8?B?eW1RQjg4V0pESVBJa2JwZ3JJb0pSeUdFMzZJclVQdFRPSGY2clZ2bXpEdUx6?=
 =?utf-8?B?czF5QmE5bjM4RERqeTdFUzlSYXl2Q2dKVFR2Um5HdVdydWMwYWt0NEtjR0kx?=
 =?utf-8?B?UFB5S2NpNmpSY3NCendwRzNPb0hETlpBcktBdnR1YmcwVUJwVmNGZkJKWk85?=
 =?utf-8?B?KzgvN2xkbGdQWUxQSktlYkl1OERFSGErd01yTzhUQzlCSkpyUEx2b0VqR05C?=
 =?utf-8?B?UFFJUE5YS2lQeUdndXVZNkFleis2dDJQY0V5UTJjcWRsRG8ybHB1ckcyenk2?=
 =?utf-8?B?Tkw5bnpCdVVJT0lrb2hHeStZUTJWd2tkS3ZwODc5WDYvVG5KNUNBOUtiRUFZ?=
 =?utf-8?Q?8BZZAc5Bdtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UllDVzc2TlJmdE1pME9vSXhGdzZwS0ZISkEvSWM3NFZiUERCZ3p0bXRhVU8w?=
 =?utf-8?B?SlZDY3hITlI1MVNHVjd2QmFkT1psOUE4R3IvdmNyMVVzZjNEaE4wZGYzVFRQ?=
 =?utf-8?B?T2JZOURFZUYxYXhCVFpQQzg4T1VtNzNacWZxM0tVaW93UmhQV25EV2ZTV3Qy?=
 =?utf-8?B?RW83d0Z1UTVHWFhIaW8zWGJlcXh0VVM2Ulo4NkF3M3pQWFhidjNaWk4vc3Mx?=
 =?utf-8?B?VDJaR21jR0tsYVM3OFVnZm1PbUZDMXdYZFRtMzcrbXZIMmNmQVZGWGcvR1Jy?=
 =?utf-8?B?UEt1U1dhZUlSalEvSFo4b2N6OGdBOUQxVGpGZjE2Ujl0Q0lzZHpXUlFndUJ1?=
 =?utf-8?B?TWtFbTgvd0lodExnQWRpQkpsMERCT0crUzB0WjNUdFpzTXAvckpxcHl6VlVN?=
 =?utf-8?B?WWJ4V1RBRVFISkYwS0luWEtrTDhDaW5TNFpRTXk3MEZnSlVjRG1TZEpNN21K?=
 =?utf-8?B?c3F3TXJKVEV6Wlk5TWFmRFBJWGkzcmlMSTlCK2F0amdzWEcrMnZ1SGdHRmNP?=
 =?utf-8?B?dWZPUU9VdUg1MGc0Yk9kdGhQRng0K29NbzI2aU1BVENXczVsbGZXSmJjQVFC?=
 =?utf-8?B?T3JWM1g2S3BORU41eUtlL21zY0xMMU9wUUx0Zjhtb0tBTDRHbkFYc0hCNW1z?=
 =?utf-8?B?WEdsVnB5ejRPVU9NVHdYclp6NHppb3hRZHcxMTMvQTRIYVBTRTBLOERhV3dD?=
 =?utf-8?B?L0lOeE9TWnJLN0JpdWI3VThabUlZZGhlWTNtNndDWHljUXJ1SUtnMFk1cXlJ?=
 =?utf-8?B?Qm9pMk0vYVorYzhxdVVaTEczN2lTZGR0YzR1YzVLYmpQSnRwN2tXT01WMEhp?=
 =?utf-8?B?R2FubzNMOGhWL0Z1VThaSzJkR1JvekZqSUZmNWdEMTBQZ1dPbXc4citHU3lL?=
 =?utf-8?B?ZGhMTFFTYlloWUZWbWhTNE9XQmxWa282VFpQQ2Rhd1phOVFKUTFKb2d0UDBW?=
 =?utf-8?B?WXpvbHQ4SDVjTExVNDNKck5VaTJnRjBNOEJFK05PdHFFcE51V3RhN29YOGo0?=
 =?utf-8?B?V1dnU1dkd0I0cGRvUlpwRlBLRyt5T2hhc25tb1NRNjN3MFMva21UZmUvWFEy?=
 =?utf-8?B?cmFUNEVzUXh5NmZOVW8xUzFvUGhLdmRRdWdma0JTeXhCc3Y3SmxpalNkbzF6?=
 =?utf-8?B?eFdGSXZhMFR3OVE2NjI1cUFqSEVQNXdUc0hwSGlzdmpSZVpHd2RXSVNqQW5U?=
 =?utf-8?B?WWpwUC92eW95TFduVHJ6Viswcm9CVFRRNWlpVXdSb3hkKzdybmdNL3VzVEZP?=
 =?utf-8?B?Uk5BRXAxdGxnTjJqTjg3b3R1ZzIxdTdVRVB5VEdlTWJyT0RQUHVCMnJGWXZi?=
 =?utf-8?B?YlJzYU5zRithanF4ZXVMTWdZcUpJK1Vrbzd6QnVreWJtaHJReG5aNWlXMHR0?=
 =?utf-8?B?c2x6Vk43TFJNSmJLbFNjT0JCTTUyMzNyOVdCeUZ2MjE5eVIyekxhVE9lZ2JX?=
 =?utf-8?B?dzVxbk53UjI2Z2RaR21RNkVIVU9Ed3ZFK3Z6MmNlZGIrY1R1TW5FK1I5czRr?=
 =?utf-8?B?cE4zZi9xWjhiR0UrUi83RkUvcmFra1VXVEVrbEJYR1UzVFpaaEljOEdqOUc5?=
 =?utf-8?B?cFJ2K0k4ZEhPcC92UFdycHFaeXdheWo5S3o5cVIvUFdnVFhBeVMwbzRFaGlG?=
 =?utf-8?B?aHczc2pMWUdGMmovbVlMb1p1aWdiUFUvSFNaaEtZK1YrN1JIWjBOVjU5dHdi?=
 =?utf-8?B?K2JYQ2hRSTgrZmE4S0pVbXp2c2JOeGhwdjFwN1VzYUc2OER2dWx4c3hHMHRn?=
 =?utf-8?B?ZXl1cGRDNytUSkF1bmxGSncvckR6UFJxUnlNTUpJNUczTjArWlBTMTVNeUlZ?=
 =?utf-8?B?Zzk4NnN4eWQzWk04cTAzK3NhUFBmcTZ2Z3VoMmcrY0dGN3Z3ZDFoSFFyeWND?=
 =?utf-8?B?WXRXYTdsa1RCTlhyWVFsV25LbXZES3BvWlRaQXZGaThLekRFY3FuNjNuSWVY?=
 =?utf-8?B?S0h5UU9WcVNWY1FLVlNFOFNXMWhSYW4rSFlPcEY3RUFIV3FYUGxZeFUwdWdX?=
 =?utf-8?B?RVZKNTlPRWZlZzNORE5xNW9RVXhHZHMvUFJNYmtQZmgzREtpRWt6NTgzcnNX?=
 =?utf-8?B?Y0oxbHlob3dtVUR1WkxVYlBQazZsdW1mQ0F2dlV4bUNrR1FKeFJJdnFTbFJy?=
 =?utf-8?Q?tPOTE5+Gd+Q2sqvJ4DdCjtyIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37af25c-4559-482c-8c70-08ddbe27cea2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:00:33.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ea0fH7W3r0RTVdFRL3BWcKGusdyHSHrBiuLXYLeybcgsDwuxqprnS5kVxonb2LFFgh4+RQbcBaW2dXWJooBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFE52C859EE



On 7/8/2025 3:21 AM, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 10:19:52AM -0400, Joel Fernandes wrote:
> 
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>> Subject: [PATCH] smp: Document preemption and stop_machine() mutual exclusion
>>
>> Recently while revising RCU's cpu online checks, there was some discussion
>> around how IPIs synchronize with hotplug.
>>
>> Add comments explaining how preemption disable creates mutual exclusion with
>> CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
>> atomically updates CPU masks and flushes IPIs with interrupts disabled, and
>> cannot proceed while any CPU (including the IPI sender) has preemption
>> disabled.
>>
>> Cc: Andrea Righi <arighi@nvidia.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: rcu@vger.kernel.org
>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>> I am leaving in Paul's Ack but Paul please let me know if there is a concern!
>>
>>  kernel/smp.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 974f3a3962e8..957959031063 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -93,6 +93,9 @@ int smpcfd_dying_cpu(unsigned int cpu)
>>  	 * explicitly (without waiting for the IPIs to arrive), to
>>  	 * ensure that the outgoing CPU doesn't go offline with work
>>  	 * still pending.
>> +	 *
>> +	 * This runs with interrupts disabled inside the stopper task invoked
>> +	 * by stop_machine(), ensuring CPU offlining and IPI flushing are atomic.
> 
> So below you use 'mutual exclusion', which I prefer over 'atomic' as
> used here.

Sure, will fix.

> 
>>  	 */
>>  	__flush_smp_call_function_queue(false);
>>  	irq_work_run();
>> @@ -418,6 +421,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>>   */
>>  static int generic_exec_single(int cpu, call_single_data_t *csd)
>>  {
>> +	/*
>> +	 * Preemption already disabled here so stopper cannot run on this CPU,
>> +	 * ensuring mutual exclusion with CPU offlining and last IPI flush.
>> +	 */
>>  	if (cpu == smp_processor_id()) {
>>  		smp_call_func_t func = csd->func;
>>  		void *info = csd->info;
>> @@ -638,8 +645,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>>  	int err;
>>  
>>  	/*
>> -	 * prevent preemption and reschedule on another processor,
>> -	 * as well as CPU removal
>> +	 * Prevent preemption and reschedule on another processor, as well as
>> +	 * CPU removal.
> 
>>          Also preempt_disable() prevents stopper from running on
>> +	 * this CPU, thus providing atomicity between the cpu_online() check
>> +	 * and IPI sending ensuring IPI is not missed by CPU going offline.
> 
> That first sentence already covers this, no? 'prevents preemption' ->
> stopper task cannot run, 'CPU removal' -> no CPU_DYING (because no
> stopper).

Yeah I understand that's "implied" but I'd like to specifically call that out if
that's Ok :)

> Also that 'atomicy' vs 'mutual exclusion' thing.

Sure, will fix :)

Thanks!

 - Joel


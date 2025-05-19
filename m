Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349E1E4AB;
	Mon, 19 May 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686949; cv=fail; b=W2LSRM21auKZoyIatxk9CycVStblTqHavZtnpnSRI6JSe88Jll1RQ3QlnCIw+vmnTnG69bw02rscsm8j9/rhGAQqJtPbniBYwvFCpvX7IkvDn8sWcqSHJFew6DxXumFFHPuFfGYutA/4oSUVeV2xhHDPAlqe5UKrzBnhWXVI0q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686949; c=relaxed/simple;
	bh=5iPX1apg3DZMr2y7N//wgn3svFyv2BE8PbHmO+h/0xo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=p6/pRMbPpz8uQ067rVBKjweMr8tRIjpDiMVnA8p6rcWXdeMKjSGyVefp0VluT8PawvWFlL2zGGokOeSrkO/prWkD/ADmhyhJ5wZY4L8WbY2gxXxbi23atVhBmxxkKPcGEZGPQX1bOa5klAkcs4yRujhYAmG7Ph8LW4MOyABStuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kpBZgWqT; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpBZgWqT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upeCBIMf+WRQC4UF1YCwMS1NnJ0fvtyta6E8LFNSBXc0xcuvDCCNU1PPboWyHXoM3uZvo8j2j7zV0XPhAIFkdNBmUuGjUydY/YPig56ucOkKjV8MPSMHuzZ5RD7BRLSie77+7eOamD6TBAYwzZTBlmI0chOzyeM7WfoW8PBdoySnlZLU9I4gA5MM4F7NcoXHgtui50VlRCfqGphRdLQkYf3Hf0IY5KfFZx6XItV75hCfmkyMCIjY9ZnGdsGteFXsD6kwHDDgMoKeJVQ4Le4DYUn2drmMbXl9BJbEUb+4qgzorU0kITP/L3zUQRLj1C4U9gAHQUwqaZ6GZRnEf3GnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30sDslq/DSc+ad9VZfeHOZ0cGW+RrBPQoKXp8G3ya4M=;
 b=tS612ORAebBgC7m80LhIrHXc8ChKasgnrvb3V4uMY36cbjM5LJXP+BTNRq+DZfMNEqmZrEf1FMC30/VmU1ED4SfJEiBh44zEafYGdZPjyxa6kaKvYiMO9gR1vVJQGMayucCNrG/ARUE2LOjovJrZ4jrptj3kQIrz6WBRXKtUeOuhqkmTJLHFpNCVAVa5p6B50GXJe5y68L3nsrAQ5JfFvE977BvNXr6fKsuBeXvEB0DRBL2MH8WqKytVHNxp4JNPXHl+IvLtQyhUzBt3lPtOdENFAtAIDMBFlJDTmENXdls7TyLMg65u//tQd0yvXownQmlBLqPbH4l3RiwAdDdKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30sDslq/DSc+ad9VZfeHOZ0cGW+RrBPQoKXp8G3ya4M=;
 b=kpBZgWqTO7FUjclogWNqe4uR/GSLlWG5k91qVl37J37sDiOJtNvEGUe+if+OHRc62ori1X3EWppySNDq6efiTDE1eKX5RODMpJaTQbVyhNFAkxnsrM9ODiZ/enjzD05vjP5PpywNMHyd0PT8VGcFlVPHEhyygbAlh0DhhmPseKYqGo2FkKoSqWYOGeMXMZsXTxoSDMMar5/EVn2etE1yB+FXgZ3VMJELGyJcE+6KzVpHgNx5ufAHOYt4j4o8cZyQ5LRgvxL6ujPWX+O+Tcxd8kQeH3q0uESYeSIi4lmOBVYrEVjzIK7FuKg42cIaCMqU559SP0FVNfe2SyQrJqOqjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:35:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:35:43 +0000
Date: Mon, 19 May 2025 16:35:40 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, qiang.zhang1211@gmail.com
Subject: RCU changes for v6.16
Message-ID: <20250519203540.GA3639139@joelnvbox>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d56c05-6c37-4f71-d623-08dd9714b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pDR1VDY3pucXp2VDdXcytONkhMWExtNkZxTFF1R1lpTk93NzJCUVRvUCtR?=
 =?utf-8?B?ZHdFK2V2LzJwTHp1UWVibU9MQzN6U0xTV051b1BTclVDR3d1bEF3L2dOWGR1?=
 =?utf-8?B?ODZ4WDdGMnlMVldONnJBbW1VTFZNMUkyMmM0LzFMbEhLUzBoUHJMdFlyeE1L?=
 =?utf-8?B?dHVtSlVqeW1yZlVpMm5URGk1RlduSXBrdmtsZ2dXY3JRNDd4R0VvM2FkQmpT?=
 =?utf-8?B?Q1NaS2YxNjdEbVdMOStoWHo3ekk2ZkphanZtcDZJV3FXc1Q4THhOWU5LVkZN?=
 =?utf-8?B?cW5yRTNhMG5vempIVFZnQ2c0TjhPOEFzTDZFU2ZCRnJZYkJhVU9oV3JROHp0?=
 =?utf-8?B?WE9iWDVMaUx3VU9GTkVoMmN5by9LUklMZ2paamt4dzZBaW8xczdZcnI0YmlB?=
 =?utf-8?B?bXgyN3pJQ1J6NWFtd3N4SnZYanVQOElYYzk3dFROc0JqSUJzSzBpL0RiTHBT?=
 =?utf-8?B?UDFaOEhsSHJtMGNiYWFOTVVkQ3BaWU03MTM5T2U1c2h4QTlIVTBINzFVWnB4?=
 =?utf-8?B?TGpiZTg1NVFwT3FCL3RKWFlHTmlCQXlXTjRWNTlmYUdCY3RRWHZMVXhJS3RJ?=
 =?utf-8?B?VDNSYXpDWmdtTnhvdkhrS25HK0VHbEhkZXAzVUpVa0s5RmZsenJSa2dvV1R4?=
 =?utf-8?B?a1NQalBzMGdtVTJkWnJxYzRER0xjTE04d0RpdHRsdEZoOTJuL2tZL21xRWJO?=
 =?utf-8?B?U1RRbGEzTXg5WkZEbCs0WEpXcG91cGRxVks4d0RmRDdOQTV2R2dJUmxxbzBh?=
 =?utf-8?B?aHg5RVQybnlHNHMvRUlEM1U5cGZSMmZwUEo0aGdqTmd3ZmNRWmE3MTJlZDFQ?=
 =?utf-8?B?SzRDVnpRODJlVHllU3dBc0RmTnpwUUZEUTlVcnVPa3BMbXd6clUvL255TFBX?=
 =?utf-8?B?QncwS3JmeHpQSDJQczd4RnBhKytaTktSV0t1RXJkRUxHa1BxaXhyNmw2NGwx?=
 =?utf-8?B?MVNoMi9sSkV2Qk5IdW5KUnRNNUlwOG5EMlpaa3NuLzM0TUE0SHY5YXJzR0lr?=
 =?utf-8?B?am4wTmovOTRmZnZ5d2ljY3RyclRBNjJSdzdUaXNyTWRxZ2tGRG93eWFFZUJi?=
 =?utf-8?B?d1hEbW1PMmRQUGZrbXZibHVhVU9CRVl2OVZOY0Z5OWlRelRwTWVuUEdmZmRW?=
 =?utf-8?B?TGVTby9oclFLcURFWEwrdmdxbmZQYmVXUmVVQmtlWlZGVkZEMVIxZGlGa3BW?=
 =?utf-8?B?UVhvVGplOXVSbEVMTGtmaHBRU1pxWk5nQmNRemtzOFN2dWZJOHRSZ0FDRVBw?=
 =?utf-8?B?Z3FTUlIyK21LQlNHMnZYNTI5MFRQTFdGeVRnUVBkb1dQQ3pmSWtEWjc4UXc5?=
 =?utf-8?B?bTU4ZkhxdnVEMW9iZFVxa2VyNXNDd2hyOHBuVlZhZ2NVUmZOSEs3NTkyUzUv?=
 =?utf-8?B?OGc5MDJNYWFRaEZtUDNsOFltblMrdmNBTytoaTJ0TklaRWFvRllFRGxWZkF0?=
 =?utf-8?B?Y1VON1ZuN010RVprVmFzUDVVN1lPTDAyUGdiMWFrcDk0cUFidFBaTkMxVHdD?=
 =?utf-8?B?MWlQYWp5aUhDcG5BbFFRb0ZNZCsxL244blZVNjU4aDRnUVRLWkNMWVVmQjdR?=
 =?utf-8?B?clVEWFpGSjc5Z3htV0hKdFNmcmM1NVQ3UlVOQlNxbGhDWEJjUGpjOWNJNVlt?=
 =?utf-8?B?aU9aTURRWWtHQkhPSFFGYVQxbm04bDFRRmtzUlZ4ZkkrNE1HOUtseVJ4QUkw?=
 =?utf-8?B?cTlJeEg5MGk4SXNTMjJLZ0VVczNXRFJNNWdRV2tGeDhaL0dOdzQ3SEVKczdW?=
 =?utf-8?B?VXhXdlNnZFJIN0tLcHFXZjRpMU05eXBsUWxlZVRtSWFzalFXa1BtRWlPR1V0?=
 =?utf-8?B?MWx4STMvYytoS1h4TFZBNDhsMlAzRmFsZWtzZnV5NExITC9CZUJhYnVCMkxm?=
 =?utf-8?B?VCs3VURVVktjWW0xMTA5M1BLVEh6dWlEcS9nTE1kU2I3dnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJIcS9heFBzeXJXNytxL0loN2wra3dLbE9Mc2tUWFBWY1Q3YVZHUWRBdFJr?=
 =?utf-8?B?L1d2ZkhiQnlIamVtaWZDaEhmazNXWXJDMkhKUnpMQnNTZy9rWXdyOHk4TENS?=
 =?utf-8?B?UUZnWGpnYnNod2FxSWdPek5iN3FHTkZMY29yaWFBUnlBaE1HczE0bWg2R1lZ?=
 =?utf-8?B?enRDVkIzbHpFRjI4bGd2b1grSy9wMEFvdDBQckhyUVFLODhYTGFSMnM0S2NL?=
 =?utf-8?B?RlIvb2NTSjNGdGdQakhwR2w5WFZGQlRwaWQwNmp6bVhzVU5LWG1lc1lLM0hV?=
 =?utf-8?B?K3htbTk0enhNdFB6aWpIOTE2RkIrVnBxeEpBMENKeURhNkI0cnI1bzUvQlNX?=
 =?utf-8?B?Y2xWcHhlNmFYQW1kbU1NVXhOQmJFenhCdE9sV2lNbDBabjhuRTRJbXlheThZ?=
 =?utf-8?B?elhqK2ZRVE5JU3Y0QzZkbllyRnJtRkk3cGRlSXVLYmtCb0pqb0h6RWZaSWM5?=
 =?utf-8?B?cHlzR1lNamtkWmxvVHczNEo0T3dIdXVMc3VoN0tVZnpnS3FFbmp6YTlZcEVm?=
 =?utf-8?B?YjhBOXF2K1d6MDd6NUlCclhLTmw4QTVIbnZ4MnNNYW5nZmVJWHVZc0ppMnRB?=
 =?utf-8?B?WDdkT2J0WEhCK1AwYXNiY1FaN0Q4N2U3UFVaelZYalNRUi90WHg0eTNHTTA1?=
 =?utf-8?B?eU9oVjRMc1pKdFFUTkZMS0w2eEhOSXJRdkEvVzBlYkVMd1lwWTUzdWNBanJH?=
 =?utf-8?B?eUo0dC9RVEJjQXg5cjBtZkFzbStCbjhVc21DMTcwQ0p5NVlPWEtHbG1id0ZI?=
 =?utf-8?B?ck0yNk9uc20xb2pMR2dZY01jSlJYR3JEcW5tTnphczU5SUF0QUJQWW94enpj?=
 =?utf-8?B?Z1NxZW4rTnhlbDFqd2lTTHVWSjQvZ0VLR2hJK1JlMzJvNnFIWnk3TjlLbW5q?=
 =?utf-8?B?WG1rTUx0bVM5UDVGVko4SERLeGtjazNWa3pRRWxzZ0dOQ01Dd250d3p2b21l?=
 =?utf-8?B?cjk5bGtWZEczNmZ4QlpIMUVmelNneks4ODRUckM4TTRSc3dNaWhkeTRwTzJy?=
 =?utf-8?B?MFl4RFpLaWVrd3grQkRsOUtrZEVsN2pZUE1UUTRrT2YzSE5YOVBmSGh1dnlH?=
 =?utf-8?B?NUZ5Y21jOXZsRUdpMDRWTTFHR3BlN2h2L214eUp1d0J1aExPUHlJME9YdnUr?=
 =?utf-8?B?NlBsVmFrci9QanVhSWpNdktaczhQU2YwdzM4UWszc1oxcUpiOHVvbHh4eUo5?=
 =?utf-8?B?OTB1cWR2clRMNXJkMzgxeVZ0dFM1bjdvQmlhUE9BMkU2WWlMQkJ2M0dTc0xJ?=
 =?utf-8?B?MzQxYTR6ZzFZRXIzZ0ZTclE2aGxibTJrVWJiZTN0V2RBWEZOU2syOTk4aW5O?=
 =?utf-8?B?QnRHdEpGVXUrZlBEcCtlbUdYak5jeEpKcGREWForVmJFZU1RdW5RbW1PQmN5?=
 =?utf-8?B?eEk3RlRFZEswaVpRWXlxd1M3b1pIbTZFcmxPMjVGbnZLaHpCdWU3RWxySW94?=
 =?utf-8?B?WGk5bStVbXBKNXR4cmZQeDdLamhBNCtEaHVlVW9PWDhvNGJQZ3dMeDVrL3dv?=
 =?utf-8?B?MDZhTSszYnMwR0VCTGVibzljMGFyM3hQdFNvMnliTGEwd2hLSUhMYm9HMmI3?=
 =?utf-8?B?L25FQlZJWG9sSXlSaUM2UiszcERqQjQzVHlVQVlBUEo3Y01rRnJTUVNlbnJt?=
 =?utf-8?B?V3FiRzYrMGtBaWxrZUF5bTJxSGowZ0pOWUhnMlVwQmFub29vVmtKRXp6RmpH?=
 =?utf-8?B?Y0txbEllZi9md3E1Tit3WkpaZ2g3MmVsQ3cvWWM0dHZ6eHMzOFd3SWM0aUZh?=
 =?utf-8?B?dUM1VlpEQ3RpTy9GcC96MXZ6QlZpTEtUelpVa1dySXdmb05SK0o5NVFvQlVs?=
 =?utf-8?B?T0RKcmdFNkJ0VTVDMllwZUlONjNjRXZpbm45cTBLZ2lMMUVKUUxMd3RxMWUy?=
 =?utf-8?B?UUIvaFUwRlN3N1Rvek1mVjZjN1hubStoZ2tzQzhXR1dsbEk1N09CZXdFNlg5?=
 =?utf-8?B?S0JybURBYjJRZGJOcERXME13dVJlZWJUVjJCUVc5dmpQeDN5ZUdUbWwyNWdP?=
 =?utf-8?B?TkFlZHZjanRHQlNIejVzZ2V4Y1FrQXdTNDlpNVVOQS9RNDlwa2UzcUVxZjUz?=
 =?utf-8?B?UzBMMUJydm9vRkNsaWJzZmRVaGwzL2QzaWNRdVd3WktFZjdVTzRpaXBFSmFL?=
 =?utf-8?Q?IRUmoslQqn3w8L34usL18GzGO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d56c05-6c37-4f71-d623-08dd9714b9f4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:35:43.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4v8M5D6qoPHQmnJW+HiZuIr8cTa8mnzH55qg76A0CBXY/vtuTMSqezcCP4YZPgRKk4I+bIwUH8nbXnVIbj8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

Hi Linus,

When the merge window opens, please pull the RCU changes for v6.16:

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/next.2025.05.17a

for you to fetch changes up to 9c80e443379861a6b374db3c5bb830167cbe0676:

  Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and
  'rcu/torture-for-6.16' into rcu/for-next (2025-05-16 11:18:16 -0400)

We in the RCU maintainers crew have done rigorous testing of these patches on
both x86 and ARM, big and small machines, to ensure high quality so I am
confident this will go smoothly. Thanks!

----------------------------------------------------------------
RCU pull request for v6.16

Summary of changes:
- Removed swake_up_one_online() workaround
- Reverted an incorrect rcuog wake-up fix from offline softirq
- Rust RCU Guard methods marked as inline
- Updated MAINTAINERS with Joel’s and Zqiang's new email address
- Replaced magic constant in rcu_seq_done_exact() with named constant
- Added warning mechanism to validate rcu_seq_done_exact()
- Switched SRCU polling API to use rcu_seq_done_exact()
- Commented on redundant delta check in rcu_seq_done_exact()
- Made ->gpwrap tests in rcutorture more frequent
- Fixed reuse of ARM64 images in rcutorture
- rcutorture improved to check Kconfig and reader conflict handling
- Extracted logic from rcu_torture_one_read() for clarity
- Updated LWN RCU API documentation links
- Enabled --do-rt in torture.sh for CONFIG_PREEMPT_RT
- Added tests for SRCU up/down reader primitives
- Added comments and delays checks in rcutorture
- Deprecated srcu_read_lock_lite() and srcu_read_unlock_lite() via checkpatch
- Added --do-normal and --do-no-normal to torture.sh
- Added RCU Rust binding tests to torture.sh
- Reduced CPU overcommit and removed MAXSMP/CPUMASK_OFFSTACK in TREE01
- Replaced kmalloc() with kcalloc() in rcuscale
- Refined listRCU example code for stale data elimination
- Fixed hardirq count bug for x86 in cpu_stall_cputime
- Added safety checks in rcu/nocb for offloaded rdp access
- Other miscellaneous changes

----------------------------------------------------------------
Frederic Weisbecker (3):
      rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
      rcu: Remove swake_up_one_online() bandaid
      Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

I Hsin Cheng (1):
      rust: sync: rcu: Mark Guard methods as inline

Joel Fernandes (7):
      MAINTAINERS: Update Joel's email address
      rcu: Replace magic number with meaningful constant in rcu_seq_done_exact()
      rcu: Add warning to ensure rcu_seq_done_exact() is working
      srcu: Use rcu_seq_done_exact() for polling API
      rcutorture: Perform more frequent testing of ->gpwrap
      rcutorture: Fix issue with re-using old images on ARM64
      Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and 'rcu/torture-for-6.16' into rcu/for-next

Paul E. McKenney (12):
      rcutorture: Make srcu_lockdep.sh check kernel Kconfig
      rcutorture: Make srcu_lockdep.sh check reader-conflict handling
      rcutorture: Split out beginning and end from rcu_torture_one_read()
      rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
      doc: Update LWN RCU API links in whatisRCU.rst
      rcutorture: Comment invocations of tick_dep_set_task()
      checkpatch: Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite()
      torture: Add --do-{,no-}normal to torture.sh
      torture: Add testing of RCU's Rust bindings to torture.sh
      torture: Check for "Call trace:" as well as "Call Trace:"
      rcutorture: Reduce TREE01 CPU overcommit
      rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01

Su Hui (1):
      rcuscale: using kcalloc() to relpace kmalloc()

Wei Yang (1):
      doc/RCU/listRCU: refine example code for eliminating stale data

Yongliang Gao (1):
      rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture

Zqiang (2):
      MAINTAINERS: Update Zqiang's email address
      rcu/nocb: Add Safe checks for access offloaded rdp

 Documentation/RCU/listRCU.rst                      |  10 +-
 Documentation/RCU/whatisRCU.rst                    |   3 +
 Documentation/admin-guide/kernel-parameters.txt    |  25 +++
 MAINTAINERS                                        |   8 +-
 kernel/rcu/rcu.h                                   |  18 +-
 kernel/rcu/rcuscale.c                              |   2 +-
 kernel/rcu/rcutorture.c                            | 206 ++++++++++++++++-----
 kernel/rcu/srcutree.c                              |   2 +-
 kernel/rcu/tree.c                                  |  84 +++++----
 kernel/rcu/tree.h                                  |   3 +-
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_nocb.h                             |  10 +-
 kernel/rcu/tree_plugin.h                           |   2 +-
 kernel/rcu/tree_stall.h                            |   4 +-
 rust/kernel/sync/rcu.rs                            |   5 +
 scripts/checkpatch.pl                              |   2 +
 .../selftests/rcutorture/bin/console-badness.sh    |   2 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
 .../selftests/rcutorture/bin/srcu_lockdep.sh       |  42 ++++-
 tools/testing/selftests/rcutorture/bin/torture.sh  |  89 ++++++++-
 .../selftests/rcutorture/configs/rcu/TREE01        |   2 -
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   2 +-
 23 files changed, 403 insertions(+), 124 deletions(-)

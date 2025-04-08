Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701517A312;
	Tue,  8 Apr 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122565; cv=fail; b=pZRzaWCD7sBlB/O/jVsvq58pnB89ntt27k9D0nFlGvB4RbegQtvJaI2bTFCYOSL9BmqA4wA4BrJHhPF6xb0waAKu6Jc3odgerOrfKKUAsbLUBMfhWUnEDopZq+sal0auB37bN+vFqXEQyNnZPkkrEl1eS4FN8anw3oFEa/opiiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122565; c=relaxed/simple;
	bh=9ukfFOEn1zTk4PwKLwJr/5bCMul/3xz+SsLsylw41TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ieTfHYWQkArUB4T61FcxqrDTJG5thf5kprZwnsnTNSl+V4A85tx4C88B3/56hUt1gzeWT7HXWEtd6y6QoiFL2n9cpBwrQFuwClrIe2vD0cFHXJ7SkSIZEf+pnjAQAPYEHCa8Fdz3xBlhkRYyG/rG8PIp4Ev+iP25VvkHE6jLjCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXdNJX0B; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXdNJX0B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g08suA0Jn60q54dygEtE/l8NEjknHcGmAfepuGoIXCcu/TmVKYYKzdmMSXGUAJhUE8w7DQzvxftDSNPuPgW1qdmMfHDH1BBlQ+zj/plHWTeyrcDEAjABwX6PJf/MD6kI8kqIPPoQI5vVsAf4vHqfq+M6HTiIdZzic5bJa+atQQ29f6FRYxYTzSJC+d6CjyOwYjz3LPZshYtpgtVNS6T4NhaheZ9LQxi1771Ge1WLc86FXqfbTieIaIU+EzB5WQlJcCGsxcYq9G1IKIuB25Y5cf+VawsEz1BoJ/KstDI0cUYPncrau8S8TEUPfPERE2gd1I7Ts34gNGXX+/7jtRUeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DJvSqlYn8knmZZQzGlL9838DiYbFc7y2fF19tdng7o=;
 b=W3I/NUjARhbIcBnUsmz414Y2ciimLXAKDrXpGmOi4nb1xoNaQYxShyCP3UQ4mMPHkj1A3BbxE4+dTxhbbo26I8PI1zTdAPK9pjO3KBpEVTxnw7Ur7EmXP4MLxDq1jdEJUJ70XUZasJeOW6ZRMqafeTqEmNV3OZ6pmjAEKfHyz+um86h2s02RdwFFu5Zx6ivfL/ZVRwSzp7sMtSQhmoBNNTN+lY8GlSYRSyhoMUtm1I7H9TrsZWHzBgNXXE22EE9/pO2eGl49qC4DgPRDSWorRrSTPOfqtMwDNOg8RMpPXCVhN2CTIIAB+YP3Y+nvbmREIk6AwKUfV35JCc7y2Lcidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DJvSqlYn8knmZZQzGlL9838DiYbFc7y2fF19tdng7o=;
 b=hXdNJX0BLK8zycujMsZPn5odyoFe7K1Cob53FwlVkXT3iQuDIVLNjq79M5Ks/7UtVx5OhuwklUKFOXXnr0+06kPc4s2GIqNR/4IdjEGfVh1d4Do1W5i4xpMGAFsYGAUKokd7HodfKnaG7UM+2m+FnlQZwgLwGzg7W/dD46TLC/qbIyKDFCC2iOi4ZxvjwqdVPsy5Xtstxdx7HNqbVyV41vnprU8z7eIPubnG9MHDh8xjAgBmN2DBKRxvyg9i0IOkyk1Pik9Jr3E6C3GSgcXuQDGnrbjC2GMGnZHUL4XCXp7f5jBbTJE6iDxOwOItLX8GVPZWbx7C/gnydoemRJtt4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 14:29:21 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 14:29:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v3,4/12] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Tue, 08 Apr 2025 14:29:19 -0000
Message-ID: <174412255922.117.3971687661268349880@patchwork.local>
In-Reply-To: <20250407191221.28679-1-paulmck@kernel.org>
References: <20250407191221.28679-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN1PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:408:e0::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 805b6554-6a2b-4ddf-cdbd-08dd76a9c0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZ6a2drR1lhcWh1elhZOG1YclZkUjFLaG5YNGV5VWVDMWU2NWI0K3ZkWnlW?=
 =?utf-8?B?UFNpaDBnbWdNSmdGMEVVL1M1T0dzVE81di9BSW8yaWpsSVIrNEQ3dldUeldv?=
 =?utf-8?B?Zkd1WEUyakR2QlFkUlpERVNEcDVBRWlEem4rYnJOZzd3WUpVc3ArMzd2VDUz?=
 =?utf-8?B?ZWtNWkFKVHJSVTMyK0RKL2poeGhFc2NPeTgvQlJVTkpGaWdoajBHMlgvQTM3?=
 =?utf-8?B?WThoYjIvUnlwN2twVDZPcC90bU5YQ2ZSakRvNHpJdWRNZWY0dnhndzJrNExq?=
 =?utf-8?B?L2NBS1BJdExHczRZc3hSbkhnMnhDUVhnS0RtQkdLWWFLcEpqemo4K0hoUGdY?=
 =?utf-8?B?MXNLMlhVS3J0UXk3aTZPcU1QdUgxZzhBRGZQblpTOGlrcUhmQjRXa24xSEZT?=
 =?utf-8?B?NjBaMkZTRFErUCtDaTZPc1hQcGFjZU9HaHdINEE5SHR0cTJ0RmtDUGRteURt?=
 =?utf-8?B?SmRrVnlFcUhOWCtBM1k4ZTNIakJmWFRLdkl4bjBRRExHam5UUTVxVm1sRVF6?=
 =?utf-8?B?UnRVV0xiTHd6T0ZCZmdSQTAwQmlsQW9PcGoxZjR4NlVPV0dhdmxVM0Q4c0xs?=
 =?utf-8?B?ckRCUTNiSmdWOFgvYmhoR0hQNjNyWGtjYVhjdFdEWVhSdGhCenBCKzhkcjI5?=
 =?utf-8?B?WEVGTjhHZDB6TjJEL1l3aWQyUmU3M0t2OGNJRHVra3NUOHZrSDVSeCtBbUhP?=
 =?utf-8?B?L2F2djRhWTdTcmxYVk1mUkZuU3NqTjAwS2piTFBSb2x4TnhGQWFOU3NOUUpn?=
 =?utf-8?B?TTFrVlYwbVBHS3ljZVNiUURvL3ZTY3pZOElGSHJ6TXJ6YmJTbWpYZnJaVi9I?=
 =?utf-8?B?U1orNkkrTTkxWFRaT0FZdEQ4U2xDZzlQTEErczAvQk03aG9NODhnM2xTSEgz?=
 =?utf-8?B?K1VYMnVzNUNYYk1IRnAvcGdaUytXVVgxTmZCVnNkaUh1aVBwem1ZQlpxZjJn?=
 =?utf-8?B?ejQzQlZDVDJ1M2tlOGdFbjBpRHpYYzZoNVNWM3YxclB3ZktMWGJKMmZ3RlFX?=
 =?utf-8?B?eUVpellPZHNONkY5ZEp4bVg2cmxiYk9EZXJtbC9OR0tpN3JsdktGZWlxdkYr?=
 =?utf-8?B?d0laUXBuQ1RsVEpmSUtEbXZsMll2MUNYbHNQL1l6TlhodXhDVjNLelo2c0RX?=
 =?utf-8?B?cHNxanpVUnRLRER0cTl0RXQyZ290RW10SzBXRCtnVEdCcVU3VklIZUs3V3BT?=
 =?utf-8?B?eGZWQXlERmFPS0RpR29BQWNUeEl4enhqUFpmc2U2Nk8xQ0lRUHZ5T1VOaUFp?=
 =?utf-8?B?SytpNndNYzdNK3NQRmdMWnB1dnkrT2NIMUVUbEtxY1BialZIQzAvSWg4ZFg4?=
 =?utf-8?B?OHZiQy81ZXFkNmdUZW5iUkdXakpkbXNkNWNyYXp0NENKaTEvTndveUU2VC9k?=
 =?utf-8?B?ZUtuS3lnSU9jdFROMG5RQnM1Y0hQWVhqMlJVcWphOFVWNHpTSkxGMlZlK1RK?=
 =?utf-8?B?aVpkVnRsN01ZWE1LZDlwMk5ybXVRMmhmalBDWllKWVZ0LzdIQklVWUc1UTRq?=
 =?utf-8?B?TFhhNVc1a0xCUFpabkFJRTRJZ2UwMHlQRDRNcEtKaUdKVnFqaEgxL1d6dFdm?=
 =?utf-8?B?RWdLZUptMVRxU0NNRmJFUytiTnk1THZNaGEwR0dtUFI2ZTJtbjhmeG15SjhO?=
 =?utf-8?B?aTRKQlc2VU5vRE53d3hwQm5TRmJXcWg4cHVBSDBtY3NVd0VhNGsxcXpUekpu?=
 =?utf-8?B?aHYveHVqSHA2L3RnR1BiZmVvQkRtcnQ2US93dkRHd2tiUHJyM3N3MHBONFRU?=
 =?utf-8?B?bFJxSE1DdUEvUG1Qa3JMSklLeVJqUllUU0NrcUFScnJGRk5ORmIzNVAyZmZv?=
 =?utf-8?B?N1VLdDF5VVZRT1B5N2JJZkxNeWhHK3dEUnc5THdkRlpWc09RVjJ0SENGVmhj?=
 =?utf-8?Q?5UrMJ26JUtPIV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEEzVWdoVnRZYTBnYkhrY0t3OEtQMEt5SWFWYjFCZ2FtNXA2VXUvMnpXT2Fs?=
 =?utf-8?B?bkZBamk5bitjNWJkaGJTTU9VZVVjampwSjl4QlNMeFpzWTk1VFhtbkhnUVdG?=
 =?utf-8?B?SnR5ZVpkc1NHR0htNmtRZnlKV0lDY21kd3lubk1uRXRib2NDaVAvemhGZVdk?=
 =?utf-8?B?YXdzK2FuK1JQbk5GY01WQ1Fzd1lXd0tPbHVGREhXRjg3Rm1aWlNCR01xMjBx?=
 =?utf-8?B?dlkyYWd5WG4vamZTaVFKSTBJZUU5ZVlYZ2gwUnFBek5FWHNJc21jOURZT2RF?=
 =?utf-8?B?ZjFFWVJ3eUoyU2dkVnlXdWNQVExWZjBjNldUREhxZldDYnc0bVN4N1ZEdVZw?=
 =?utf-8?B?TWdZYUVDeVIraTE5OHhsUnNMOTZtS3V5Q3B5UUVzQkJUNlpHeEZyZnowVm82?=
 =?utf-8?B?alNFM0lFYWFPelBRWUlPN1l2bE5sbUFYOWl6cUhRY0kzNktVZW10dUdqUW1m?=
 =?utf-8?B?NjRLK0JTMktqOHlBNmgzYXd1TEN4Wm5sY3ovKzdaR3Z1OGFiSzN6VXZXQVlh?=
 =?utf-8?B?Y25aNTRxaWhXcFJsNVc4UDIvTFZMQU9aMkk4aTlNdFI5MGRkT2t4b0hRRGJh?=
 =?utf-8?B?aGVDNjlmZXRlbnBDWFAvOUozRkkxTDZKQXNGWlZGRFRYVkh3MGNCTzh2WmFX?=
 =?utf-8?B?K3VqRkJXYnNpNXpyaGpzRDVVNlpWajdvSGloTmxvRzlOY082ZDkwY1p6azFl?=
 =?utf-8?B?L2JwU1A1cFhCd3BhS2dldWZ4SXZaNTl5dDlnV0hva0dTNGR2REdxa2tiU0Zs?=
 =?utf-8?B?eHZTU0lVTUJ2SzYzYndvVDdIUFVvNXNlVEFXeGJ3dG0yWFRqTTI0TG8xbk0y?=
 =?utf-8?B?blNIcnJ5WDF6aWQ1ZVRyQ0JURjd1a29CcWhwRWMyNnpSYXpETG9YNVUvMHlO?=
 =?utf-8?B?RG5QUWE0M0pjcVRBWloxVER5cjd3REVBUFVtWW9saVI5L3Vac2s2YnZiUXdN?=
 =?utf-8?B?bjNzcjAvM3grTjk1c2VaeG55KzZ0RW5KTTJWL0xORmtmWmNWV1BPd1ZLbEZJ?=
 =?utf-8?B?M3o1dkMzOXFTQWoyWDM2bGVLMmEwN1RvTGpRTktCN2YwSnZMcGtXdTY4cXkv?=
 =?utf-8?B?elFpQVc1ZnZCcTVZVWk4aVYzUHNHQ294NjVWWStHL0ZqamFJQlN4MDVlK1py?=
 =?utf-8?B?YzVLTHRMRlFHOXdKNW80dkhFV0dYYlpocnNYUjJ5OFVMNm5mRHRRcWFreW5a?=
 =?utf-8?B?ZW1JdGNlQjJ6bHRVWGdZdzhmT05zV0N3TVZ4SzNFMFVQbWQxa2hCQ1pSSHZP?=
 =?utf-8?B?djNXZkp6TFlqNFRCQlpXTHFrSGIrQndndTFLZVUwNlgxU0IycEdHMlYvU0Vh?=
 =?utf-8?B?S3BYckR0cUtKVTIwT1NTbW1YeDVjL0pIbDVXZGVZeVE2RDhQZVhyMG1IZ2w2?=
 =?utf-8?B?TzhhVUVnNkNsM3dxd0tVM3AzYkFhQ2pQOVRQTmI4VTFKNHlCeUQyS25DYkd1?=
 =?utf-8?B?TGgzelFNZ29nSWM5aGhxS3U4MWRWY1NjNnpyWXBzem9tLzVIREtuL3ZXQmxQ?=
 =?utf-8?B?UEVweXpFaE9yQjVKRUJXajJzRmdTbjl5WWNRT016Y1J0cHlYSWdRdEVrZTNT?=
 =?utf-8?B?bDNVZ0p0RFRKUFBvNFY2NERZczVDWlVWT3crbFFDbDRjTXZrVWExZTlnL3VS?=
 =?utf-8?B?azAzeDhDeVdoS2pTUEQxNTc0a2dHUEw3L3c3TWhMZFhzVXRvbU15cFhnbTQ4?=
 =?utf-8?B?UEtOTlFmTER2YUNPUTJ1bmJaN2g2KzRXdFI2YkFKaWtWVXBBK0U1VElxencx?=
 =?utf-8?B?anA3bjhvSHlTelk0aUtQRFNqU1JJeFpodTVMcjF0clhGRXYxTk9yWTU0a1pS?=
 =?utf-8?B?TGh6d3ZmSnB6WGFzQlphR1pDYUdRS1pjemdFb2I3U1lYeGxKM2IxWG9Fby80?=
 =?utf-8?B?OEhYdlZwUzhHblRGSm9HTXNUUzFxd1h4ZHdVenlaUm1ETkhLcE0wN0lkNi9a?=
 =?utf-8?B?Nm1CVmlOc0RaRldnU3RmTnB4dGJIZXZZWS85VGU0YUNSczIyNG84WWNRTVQv?=
 =?utf-8?B?S3pnOVpvT3FISThsTnMxekdoZHF1amc3ZzJ5ejUxT29wZS95cEplS1o4bW1R?=
 =?utf-8?B?aFB3SU51cng0YjRrTk9RN29sME5LTlEzMW8rMEx1VEFPZ25oc3lDWVYxWWxQ?=
 =?utf-8?Q?HJtnh/h0+4ZwM3AXdkfIQZy1L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805b6554-6a2b-4ddf-cdbd-08dd76a9c0a3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:29:21.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/tur0w2evoEFDITjZg6SnTa76Q6GmZrKrodPuP351yq/C9hlxdM1w+q1LySE5FRfUXkpoDJpQsPi9siPzZkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004

Hello, Paul,

On Tue, 8 Apr 2025 14:23:32 GMT, "Paul E. McKenney" wrote:
> The torture.sh --do-rt command-line parameter is intended to mimic -rt
> kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> mimicking more precise.
> 
> Note that testing of RCU priority boosting is disabled in favor
> of forward-progress testing of RCU callbacks.  If it turns out to be
> possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> testing of both, both will be enabled.
> 
> [ paulmck: Apply Sebastian Siewior feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I pulled this from your -dev branch for 6.16. I checked and this patch is the
only one changed so feel free to not re-send the whole series (I will be
resending it anyway once I have all the topic branches).

Also, I added your sign off as it was missing:
[PATCH 03/12] rcutorture: Split out beginning and end from
rcu_torture_one_read()

thanks,

 - Joel

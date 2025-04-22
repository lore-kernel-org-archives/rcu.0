Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE17244695;
	Tue, 22 Apr 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362536; cv=fail; b=Dte4MpISHL5WV6I4UnzS7Mr7SMMpw0tStJ1K0Hs0GO4V+N8A3q4mvSiB9RsT6gUAosQjGSBhNaOIJu5qePpQDzKDg3uCE6akoA1PTs9K0UW98vsmzcMVkxLe4TDtDPndXHzQKFVYXHjQxZgdKKtzUKbbpz/HxvfX39Ar6CrmAfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362536; c=relaxed/simple;
	bh=4VNNtjZ/dE5gnkKmoMbm+EEPDl+ViVPWFzkkSUmuWiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNbqt+oZq6XEfxK65SGLV2XWdOmN8F0Fkborln+evExk6c9X4ffo+MfN5tr7y/s1mQE05dneKgskVKI2JCfs0jCYZoc5MSoF6mljnY19S6evxi+j9SNlJ/T5Mng5nuZtlAyBw9w/mIcWTtSgTSy+k2Eg+SX7xKpLhCopIdOLhIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oVWBkrkZ; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oVWBkrkZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs97DOadYsj5Ct/Wyt8dqbkfk9KvUHHbNqGuyo8NO3OUiqiPwPrH+NXBwi1hupTPFNTz95lsiECaei0CZ+biEE7yTg3xz3/rO/I6mnZvfx89rnD6/fYTD4sSk6+Z1E/KGcTCqRhKEUJbeT/i1TRTJaP30ke5iks8eHBCqLRndMKiznDOo1+lfYlxoG9AwM5HsNmfm5F50yAGSDJm9TROC6dsCEmr1d8owMxUCHUJpOVliTVEQudiQSU7pceJGeUXZdoPY3TGlVJFyfywT1cJIERT/swMq9Ws2yc1P50qIBCBcwlV7M9UKd7tLWsGojmsASnpsAK2gcTXeILuV0ZDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmjzfzNhVbwmKojPVrTL/ns2yJxqnDgMGcMTgEZ6iDg=;
 b=FrjxKqT6UGo1TD7jiev+61QV6iJ32FEi6pK3lPuswRrz329KTv1UGWjYxTIorZqIPcf9VoIypeifAmqkF58qfzvoeZTSz281uBq8H3g2ng5TRPmQkxI1rRvjLl2ORdSposLhtGLmVj60ler/suYRIVdBozDPuRnHPRFrCiNcyKXfXHJmAG6J/lT7r5A8KCDwtgkkdowSpSpTbhMADmGZcq8biy9iKa0jKG4QqbgG0jslY+1ej14O0dT5zJmD+chG24j5ipnx4UQVf2DLQBf328QsldB0SLQg3ycbpb9WQY/uD/37xAsirUCJvIELbZHMn+yPQKJupR7x2RLGdRtInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmjzfzNhVbwmKojPVrTL/ns2yJxqnDgMGcMTgEZ6iDg=;
 b=oVWBkrkZkgYqslj9AjGRZUeIAE0yajATqjkmaG1KCGsKDSVYqoUpG3f4u8IjVllj35L/oZoKdYj35uinbkYxLjW81geNxx1HSfKJj2Fp7OYLFQVPsQGFLPeOfnww2pOU25gLGwL4H8ieuI5GK0bYOKQvbrsdmWT2Hx+3UVk3aDv5hCk81gWd0TL39H0+rAwJ6qzMsvJmdXJhZLE3Yi+QvSaa/iaq3v48hdtWB1Q1Vw9MxMKy/0oBOMqMLHOLQWuQ8N1lAAUZLD6sjHshIlj5PKPdpQRuYJAOcSf7LuaNuqhpzglSb+wxPhNTjFRgHPDWIAXNL6Fc/rWec54A4UD6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 22:55:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 22:55:31 +0000
Message-ID: <04d03778-e40c-436c-9785-123af545252b@nvidia.com>
Date: Tue, 22 Apr 2025 18:55:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcuscale: using kcalloc() to relpace kmalloc()
To: paulmck@kernel.org, Su Hui <suhui@nfschina.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
 urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250421061508.718752-1-suhui@nfschina.com>
 <20250422015144.2012708-1-suhui@nfschina.com>
 <ae61d78a-e950-41e1-9a2c-afac2a385156@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <ae61d78a-e950-41e1-9a2c-afac2a385156@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a4bca7-eb54-45db-4971-08dd81f0c8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmlYdUpKN1JFcG5zUGNETDN1a0VFeEpqL0xxRjFlUkFwK3QvRVBuSHYybVF0?=
 =?utf-8?B?NTR1TkplWjlQVjZuM3ZOUlN5UjRoS3ZhOFlRbitwTU1EZHM5eEVwRlIxcVJh?=
 =?utf-8?B?M3M2dmliMGhwN0FZS1VzTW1qSnNLd0RNdytvVlRDd3VNSVlBQ2VzbzE5eVlP?=
 =?utf-8?B?NjNQaTZRTlZld09XNUdqeFJPZldPa0U1OHAwdUF4bjdzWnBiRkZ2cWVZOGtk?=
 =?utf-8?B?UmJSdHdDYzBQcGZyTW9YRG1ZRHE0b2Roa3hva3UzRUEzdWFkSjhCVytoTmVS?=
 =?utf-8?B?UXVRNkg2d0RUSHM1eGdyUnZvK1dvWUh0eW9iYTh2eTg1dU00VExGRFRjWXhz?=
 =?utf-8?B?NjZHeDc3c0dtOXZ0aXUzczlzZjV4QXM2TTlVMzBzSGNmZlZENE54UUpNRm45?=
 =?utf-8?B?YlBJSDViUmhmM01zWFlEUHpaYXB2QXRKUS9RdVlRZkNabXNLcUZxYUxiK3hE?=
 =?utf-8?B?SHdZLzBMQUFYRWRWYTFPM2pxWkQ1TVAyQ2V5YlBCcE9uOEtTeUxhdFpCNVVW?=
 =?utf-8?B?ZTZxMU5Hd1IxamJ0SG9VL1BySEt3L1hWQUpLUm1vU3gvSlZmMUhpeU1RTkhD?=
 =?utf-8?B?cnoxdC9xOVl4STVuMUZOQ3I1bTc0dnFUa2dDSWZSWUNUOUpaYTRpdWxFME1k?=
 =?utf-8?B?QzBkMXo5MWlXbmJhY2RFanIxRFptbVozRzRkZHRoaHlldzI0MU5UcFNSWTZB?=
 =?utf-8?B?R3hpWDFtRTdJL1VZdjlZWnh6N240d1laakNub0ZibnJXNGI4M1ZHUUZUWnMx?=
 =?utf-8?B?OUlnR1RPdkhmaXBGbE5idUp3T0pGWlV4N0ZxTDBDK1FFRnRRZXlPQ3ExMHpK?=
 =?utf-8?B?a3FTajZGS2hnU3RSVEVqMTNuT3FZQk9RN0w5VHVzTk9nVklJcVJNdmZHZWd1?=
 =?utf-8?B?dENWcmNRcFFaSWU1dmFWMWRGUUYyWTl4cE5YWjIzTTdCUDZ4Y0tsMW0va1pv?=
 =?utf-8?B?U1I0Z2lKMXdsNzBkcnFSTTRBMG9LcFJ4ckZkWVBrREp4OWllRm80TVZSTFhC?=
 =?utf-8?B?L2lzVzNyVTFXaCtvS0F1WWZoRDZ0b2t1Sy9BeHg5NWtVQlFLOUUzNnYrbGRZ?=
 =?utf-8?B?R2k0YkpCN0graVg2VENTc2VvUGN5LytWN2NFRG1sU1NLc1lBM0NHOFpJOEQr?=
 =?utf-8?B?YWZYalRNVElnT3ZIdlVSV3h1cnFFc2Z4VXdIVnlkTFhSQnJVV05BQ2xvRFhQ?=
 =?utf-8?B?TVZ2ZS80aWZqQWFaSkNFMnVmN1NkWGluUU1zZVBmc2lRUXRmMlU2SG5XUjhO?=
 =?utf-8?B?M2pVV0VTaG5zbUs2VlpNeDNDNVJwSUxpNmE0OFdqeEZ5czgxdkdCL2FKalVa?=
 =?utf-8?B?QmtxcWV2UkZLb3pQSmJWQ1BSWjVpSUhWeU8rQWhlT1dtR2psdGppVlRSWno4?=
 =?utf-8?B?VzJLOGo3cCszeU12ZVVSb0hmTCt1SmVTNGlvdERURkczRmp1VktmV2R3dFVx?=
 =?utf-8?B?cFI0QUIzYVAwaVA5VXk0Yk5XdkdJSDRNdVkwb2dwVGl1NXFtdVlBU0NPMkVQ?=
 =?utf-8?B?ZEdzMTVxakNKMjRrZ2ZDRmx5eEhFd3c2Tnl1bEpNOHFIWFMvZ0pFa3o5ZEdH?=
 =?utf-8?B?aGlPQWN3WEZvekQvMVMwMzNXRUtlV0NaTkNpNmlTZDZUb1J6YnFqY08wZmR6?=
 =?utf-8?B?TXcyc1JydUVmYUtXT0V0anlKREdhZkY5bEZ5RG1qMTkvbERjRDRVdXRleVhB?=
 =?utf-8?B?NTd2OXYyblB3UkdXcjFhaFJ3MWJycFdLd2VMNnRaVWRkekJlWjF6eXc0c0NC?=
 =?utf-8?B?azRmU3pDS3M2MmNjY3NJT0FKYXc5RmN0TktnV004dUJiQjRVS2xnSi9qRVl5?=
 =?utf-8?B?c2VZc0p6cGZkTHhNYldIUnN4TEI5YUR4amdNdnl6ekNDeTFCelUwY0tZaGRs?=
 =?utf-8?B?elFLRDJ1ZGdXQkwwL3U5VFVycjVaL2xUTVUxOG5PUzYvbWc3UjhyMXJnWEFo?=
 =?utf-8?Q?kA2jr9nBxO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTlQWTVXRkpIeWVaTXFoY2YxL0dMNlJWaEZYbTNGaktFa3lYUm4rZHFvU096?=
 =?utf-8?B?UkI5TWZsTG1OZUxiNkVWcGVod0QyV0hWN3F5SDdyNzFoQXBuUHZjQUFNZkFt?=
 =?utf-8?B?dTNZbHlWN0RlaDhlMjZTZEE5Tm5iOVdoS2xYdGhzei95YlVrYVlyUUhZSlVk?=
 =?utf-8?B?NndadlNWOGZvdzVldzd5VnNkRzMwOVRZK1E4VjR3eGJpOVpHeVUxQmxpaFU3?=
 =?utf-8?B?UU44S1FDM045VzhpTThhS29mYXAzTEdLb3BmZys1RjRlYnFyaXRFbkY4MkdV?=
 =?utf-8?B?T2xzZVlLajU2aVNIOUh6TW1mcWlkb1NlelJzZ0VRbGpWVXBWeDM0aUFCaFpT?=
 =?utf-8?B?WnNQaFREKzNDUVpKYlRNL3duRTVici9XOFlnRTBrMFZhOTlCM2ROQUpuVUIw?=
 =?utf-8?B?Tk1oTVdORkMxZ2NramVNNUNDWk0yMWxDWG92Z1hYTXVGL0hWZGRENEh3S1M5?=
 =?utf-8?B?WVNwYll1cDhaN0dDL2hnOFNQR3p5bE1xbEllQ3hmdFJVUHN5OWFzR05YY2N3?=
 =?utf-8?B?eGN4bkdGdC8raVRTWU1nY1YrajZiMWN1NG5JQmVVME9zaDhCMEEvbnY3a2dD?=
 =?utf-8?B?UEk5ZFlhK1FvVFR4K3hCUnQ4ZVJVc1dISXpKWlZnVld3aEIxNk5LaU9xZjl3?=
 =?utf-8?B?YUxiY1pCY2ZZQTRHY0xLSVJFeGhkdXpMN0lqSTU1cHUyNGVUYm1LNTZXNlRp?=
 =?utf-8?B?c0VCeWxmQTIrMHRGUlNWRGJSbURPQ3BteGJuYUJJWWdBL0x4UzJzUks5YW5F?=
 =?utf-8?B?YnFud3ZQeHFKUnZ2NWozRTlrLzU3Z0QyQ0JGMmxNd1lSUnFobExGcmRWc2NN?=
 =?utf-8?B?VVlMcTk1aVUzWHZQbmN2WmdPK2wrVGQ3TmJNRkpiT3BFWHRhb0NHMGZNMVQ4?=
 =?utf-8?B?NUxrVVZVNGtVbXp2UFU0a2ZIVkpkdGJPZzJOTnJ5NGI2U0NXY0g3TUw0Skhj?=
 =?utf-8?B?VCt1eEIwUC9ucXFzTDA5M0xBeVVWZ21pUjJxa04xSmFnRDF5RXd1T3Q3dmlh?=
 =?utf-8?B?R1lhOHBOaENGT01rYUYxejJDUnZwVDQvcDl3M3hScVRzUWVSNm1MZUNNSDVa?=
 =?utf-8?B?NzNNd3VHSnBpZkk2N2VPSEQwODZlUmttcnR0SUFtTi8vd2JhTUVlRzAwUG42?=
 =?utf-8?B?aWtjY2NMTkhCcFZmK3hpOHdDM3RidU5kSGYzd2xrZk8yOWlMV3NBOWdrbG4y?=
 =?utf-8?B?YUNFQVNvaVlPUlBBMUp4ZDFEYjFEdkpiK3lxRWFwTnRtbjR1VmJzZzZyemhz?=
 =?utf-8?B?SEJpSll1MDc4UHFPekx2cW5lYVQrc1o3VjhScnVCa1VQTDZPVFVwLzBGZGZy?=
 =?utf-8?B?MWRrVEh5T2VGQ1VWa2tZZnNNTlVVQndXa0RLeTdFSDlwUHFRQ1pvb1YzWUk0?=
 =?utf-8?B?NVJaMW5xNkZJMXdHTXVmaW83bWRBOUZuSGNnSjg3YzBGaFVhUFVHQlhvOGxo?=
 =?utf-8?B?Nmg5YTE0bVJlQk55OENUSUxPTWR2Zll6OTR1L0JUVG1PaU55WVdkY1c2WDlj?=
 =?utf-8?B?MU8zOUhDcnBETVVvTE03MlUycjQzaHRkVE1kVE5yMkE5RWhZeWFlWUxPbUZr?=
 =?utf-8?B?L296K2pRNGdBUkgvdSs4elNzNmVkL3l2Qk0zOGw0SmZONEtuTFVmbkoxNXNH?=
 =?utf-8?B?bWRoUVhaSzlBTDRGMktvbmVCNTljdmNraTNabTkzcVc4alhxSDdlR2oyemdu?=
 =?utf-8?B?S091SnJ5RXpYb29XZDZBS3BrbXVIV1FrMGRWNlhQRGYzby9TRUVyVnBxNEJ5?=
 =?utf-8?B?Z0thTkNVa1ZxeXlDV0g4eUVwMXE5LzRqWmZsWTBQcGdXYkFKdE9TZDcvY0Uv?=
 =?utf-8?B?YmZMcFFCWmdMMHNLQlBpMTIwNmNycHFNa01KWFRDZUoyZEppU0gxSUU4cXkz?=
 =?utf-8?B?L3JqWGsvbnU3UlFhNXFIM3dlNCtiMG1uZUVaS29FSEtkd2tPZHo3K0o2dlRT?=
 =?utf-8?B?M3paRS9FOVU2alFORXNyaE1ZWWdtZFVBUnhOcjdKYktybWtlekFSeHhIcmdr?=
 =?utf-8?B?VDUxNHc1OHdYa3ptN0pDcFJBQ29iY3llRmFORkRKRzJyWGtITkk3ZWNEQTRT?=
 =?utf-8?B?UDErdmJsL29UdjMrMnphV1hYUnR2WnNPRTRSMDZmRVRsK0NFTTNpM2VyODIy?=
 =?utf-8?Q?052BKXs88KbTJ8t6xWF7FnV2i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a4bca7-eb54-45db-4971-08dd81f0c8ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:55:31.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/jTrRFfU8JmZ/ocGhFi+bnMCgmdRYZj7MJLfvWwUD5EUWbx4HDxG47t3VjUslpDUiuVoNEyPkXvO4lq6RB1Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607



On 4/22/2025 1:58 PM, Paul E. McKenney wrote:
> On Tue, Apr 22, 2025 at 09:51:45AM +0800, Su Hui wrote:
>> It's safer to using kcalloc() because it can prevent overflow
>> problem.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Applied, thanks.



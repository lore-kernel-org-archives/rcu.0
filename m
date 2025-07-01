Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D351DAC92
	for <rcu@vger.kernel.org>; Tue,  1 Jul 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393885; cv=fail; b=Erv5ZN2wgGfLTLHzyMd2W2Irjh2u+EQeAHouxwNGi3K9nJ32KqKZSzWqlvghvuMtEGb8Hm8FpuU+fBtvUQYSC4gkeR13ajqJsuPPE7wL6MRp0M2MIbM6xwUIeLKwDefDJ08JgtHAMLktdhSTSpFwAZeoioYJfEVxsZHGtrhDqjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393885; c=relaxed/simple;
	bh=0YlrgvzIylLzNF2CT9QxFSTArzzSRgKKdjKS/1aZg+Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPWj98ssb4rxZlMpBcc7uOLnHahcd7jQEYiKabyV5/A15ixU17cZiUPjtXzGOqPiEq+j+uywcjIdQYHeVhD6X09/1g+6UiI+CldYi3JZx6tMM8aH0qw6GUyLW+9VCZjC/G/x6/VqzMb1zkdrCzG42/UibAsDglCq7o1rDxuqLgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beICjfYP; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beICjfYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjIrtGMNvvT1H1g5ISJw48CCzjuuHYj+Xyh7kO43kRi6ZqjjxPSTuEUQplEiSaz1/q7Y01iD/Vi4Ycm7zTSGjYmzjEppiyQYWAjsRAfndzINPYq2OMBfSFg4jciUT2H70QGHCafTOKqdUU5DG6XbVDXe6Bz4dNmWH4nKpAoWiAtVpWLr0Nom675TBOOhWbAnErdIabk7q9vXEB8Lv3U5esutnxdYs75SX7jX7AzbgIqilwYaurFR2uQVgBp77MXWSdZ5ST2oKJOgjQxw0Uo4leRas8nLfIfB3QDbeYBr/h/fWAEVtjHe9+FN9CcxCLeC1b2S0uCEoLwtu58F6mpIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEpVETQ5PWaJSE/IsKW5At8nzqOkuitsjfozVbmigOM=;
 b=jaP5vM81K/XAM81cNngf93FJItQuXQYjbIz4uJYjH6VkRlyR1E4OgJIxgmZnrYAuM7QP60V80hajuQ1UJQFgAKDIbQhNvtrGZmznwgJcCLQgDQxXhZ4jgaZ1N/uwpoE+Xuhlqj1zxV3XPD22iGiWhrG/kL2GH0AddEY2Alc6D5qtXxOTozxcBMhmQDNdHdAfRLi2KPtpiWtIT/uQlEjMsUDTo1ah0+NB1IWq/ktv7H7X6cJQ8wzWpaMlpmPTPmnrRYw7Ntk06da7vU/tgaEgWbIkNqmIyTjujxmiijICf9eBtZSGC5gAWjJjnXlAtLnLuM3gvsGuam8JkMSgrKxD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEpVETQ5PWaJSE/IsKW5At8nzqOkuitsjfozVbmigOM=;
 b=beICjfYPy3hpDksGncG9Ex67jnB9CBAbuaSb4JiDPK3OlkbyQLdGO+QUIfFzz29lvJZoOBU7ZABLnt45uRT4J8Si55wvJ56XDmTckZVdge9qNyduEkwzPD1vWdIsgckHWRBFXeoCRyrt6BKj5n3CYZUOkqkDeJmUVNEQwsP9plNmVlUXNIB9078Vbx2xJa40FEcE88Lo/rXgn2bv2OxntbgB3+EqYmMKXEfMYqS55wkIpxEa+dKoAssDqXIsmO5DcovisG/ifCNTCmMUFxUW61dsCE5UaS/ObxujaFGNKNdJLJRIQgt643gMBDlOKWfryOGbHaW114C/D+vVIExAeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 18:18:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 18:18:01 +0000
Message-ID: <11caba19-aeb8-4106-a097-89f6113dde08@nvidia.com>
Date: Tue, 1 Jul 2025 14:17:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: Statement
To: paulmck@kernel.org, rcu@vger.kernel.org
References: <7dab50cf-ec63-476a-85fa-6aa18995ad7c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <7dab50cf-ec63-476a-85fa-6aa18995ad7c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 715bfc0b-ed69-43f0-82f9-08ddb8cb9d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3lqUmllOG9ldklCUUE5UjNyRXJqNUVNSlZXWmRnY2dJRWFmd2sxYTNDaW93?=
 =?utf-8?B?TkVzOUlzVW9BbysrbmpKTXVuWElINFBuWmFyUzJOaENJanRTZ2FaQXlVRHRn?=
 =?utf-8?B?UzFEVVQwZUJHTjUyVVpLdFBtZmFGMUNxQWg0azdBenQyMXZ2bjF3UzZtYXM2?=
 =?utf-8?B?ei9VQUJtRXMvUVFRc1ZObXR0T3EySTBmVkxNSlFKT05PVTROYkFjWFp1S1lE?=
 =?utf-8?B?MkdCSXRMOXlPdmc0Wlc5ejNJamFVVmhKeHlFeWcxU0xuc1RMNTNNVG80aGNl?=
 =?utf-8?B?SGcrcXBOdnFJWW9RQzZNN3ZFaEtBbmlXZXpBQzZ0WUNxb0pEdTgzdHdUZXlu?=
 =?utf-8?B?aUh6SnB0WHpwT09IUng5TzBXRGVza2RGdTQ5RmgyZDVhUU9JRXFyWER1UEZp?=
 =?utf-8?B?a05FODZ0VDFNMXRhRXJiTG9KYTZWYkJzNUloTWV2VCszalUwV0tXcFNKWDNS?=
 =?utf-8?B?cGFwU0hZYWE1cFFTaHpIT2QvVDFuVzlwNk1CM3h0eHY5Wm0xcnZTaUFlWVFV?=
 =?utf-8?B?VEhZNndRTFdRUGQyQngySlNCclFPeWh2WXJ3dkFTTGNZcVhWT0FaNDYyalVr?=
 =?utf-8?B?a3oyYmMxUmc4WFdkWkIvMVVScG5oSXVDWFBpSCt0RWJhbEhTUjF2ZzJZYW96?=
 =?utf-8?B?TXJIUnI1SWk5SXQzT1ZXdUFIaVNnRHdnbUFidEtiQzRDMUh1bGFvUjZXV3NK?=
 =?utf-8?B?Yi8wa3h0VUtlUTRXT2NqdnFUbjlBQXo2MGEzZHpacVRMTnNlZ1NVVG9SVEs0?=
 =?utf-8?B?Q2I2MGI3YmdUV1lDTkh1R2R0OW1UUVV5c2ZLWjEvdXI5MFZ0Rk9UbW9ETThH?=
 =?utf-8?B?cHRCNHN1bEt4OHh4dGlzZ0RxeTBwbmxaM2pVUkVBcGdiNHBQMkJhSUx1bTRt?=
 =?utf-8?B?R05wSndHbElZQ1YvMTVZaldOZUFZK1dZRXVPOGhuTUNXakhnWjNYc0RGL1R6?=
 =?utf-8?B?S3U1N0hybm00OFZQU2wvTFpqZXdKVHVqaDFZclBib1daVnJMTjN6eklwL05I?=
 =?utf-8?B?aHJBelpTYmZnZUkrdm95UHU4cVREOURuOFJJKzFFSExJNWVxMHg2dDZ2Q1lM?=
 =?utf-8?B?NUpkTmdmTnFtdUIzLzFLc2JaZ2p4K2JLdTd2QUVoR20rdEN3WTR0NDBXQUJL?=
 =?utf-8?B?MFBLdHFqSHN3aUUyODhJVWdOV0ZNRlFwQ1RJVHZEWmVyWlZ5UFhzNEVqME01?=
 =?utf-8?B?dkRpZU9VZlJRUmlQM0M0SVVxRkJydjR6L21DYnhWNXVJVUlwa0wrY0N5Z1lB?=
 =?utf-8?B?eURjZmwydnVBb0srWE5uaGlZbXJ0S29vS0xsTmwrN2FuaWhpb2NUZXdsenAr?=
 =?utf-8?B?NVNqQWFNYWlsL1d3NGZNWmUyMUdJU01oRUtBdlI4Y081eDdyYTF6Y1dHRld2?=
 =?utf-8?B?Uy9EWWNnTk52dFluMmFRd0VuODdwaFhlV3BybzkzQ1BzWWRPb2wxb3BEc0tC?=
 =?utf-8?B?Ky9Mb1l1YnZScVN1ZWpoamlrZW1TWlk2MW91b1NabXJFNURvcW1qbStiOXpa?=
 =?utf-8?B?VThVMmRmSytNajdEa3ExbU9oMkQ0Zlh6NFRPTkh0SG52L0g5WEZ6M1pTYm1y?=
 =?utf-8?B?M2RxdjdTWWMySW5jWThrZjZWNEVhcW5LV0JUM3dGZUNSV1VlN0sySVAvQ0hP?=
 =?utf-8?B?ZlNPOHlCWk5FSzVvY0t6em5YVHRxRk9mRmZpUThoRWRYRFpCVE5id2o1NWZq?=
 =?utf-8?B?Zm5JdE84Tm5VekZLcVFzMS9GTEJMZGF6RXBqeXNsTE1GL0RZTlR2TCtIbjFS?=
 =?utf-8?B?bVQ4b2tlV21zdzZUNjF0UmpoZjc4bi9DR0ZheitZNmJNRklkeXBvZlRZZlJ0?=
 =?utf-8?B?TUZNY1M0SUpoT09hT0tVaVBOS3ZQTmc3OFRxQlBQRnJiKzNVQ3h1dzBWQSsv?=
 =?utf-8?B?QmV0bUJtM1JDQ1o4b1YrbThYVlRRWWl4REZ4d3dLVWR2LytsRUxkdVl6eklH?=
 =?utf-8?Q?Uo28Rg1QOYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWFMbzNZRmJheDFQZHhiVXhXZ1BKSVA2QnltSTJIYjd2SEdjSXNoWHhqNHF0?=
 =?utf-8?B?eWNSU2RTOEc4OHJUcnpwK1JmTDRxZXIydC9GZHJia2hxb0dsM2U1R0NjUEg4?=
 =?utf-8?B?MU9wbm9sMUk4TmRLVG83Wm1nb2NDMHZ3Nzd6cEoyNjRvZ3g3SnhTNzNWc3ls?=
 =?utf-8?B?QWUvNjB3dnpNSFM5TDYxTi84L3FQM3E4TlFOOWpIUGUyWHpUMU4vYW10Vmgy?=
 =?utf-8?B?c3RMd0g1ZnNFVDZJSzQ5QWM1NVg4QWt5dGg3bmNCZWJRMjJDanY0M01TUGZh?=
 =?utf-8?B?S1E2YmQzMVhsaUh0enhxNFA1bjBQRTA2aENqdTM5WHhWb3N6NzAvNEJRQ2Ey?=
 =?utf-8?B?Q05EeTFxTVFGdzBOMFIzemQycVRrZnNLczhydExFL2RMK25KMDlDcXk0N1Yw?=
 =?utf-8?B?TElmUk56dW9MbStTU09ES3dYbEN3NmVmTHRoa1hEUks3NXFZRGdCNEg0SXNn?=
 =?utf-8?B?a0FaV1ZyaFo3MzB6TmhGUit6b0xzTnBUbDJncVpSbHVRU3pHRG9BRGwyK2p3?=
 =?utf-8?B?YjVuK2ZjUnRhWE94aWxZaDdrTVIwQ2YzTUtoOHdQbi9wbWVwYmd2dnpGbGFl?=
 =?utf-8?B?Mzh3ZlVHL2VVcWlGWmNNNVNFUUJPVnR1T3BBcVk1bTE5U0hnL2NFWVBhVVU5?=
 =?utf-8?B?cG5xOU9oaHNYNnhuQmkxSDY0bDdpaEdtRk9HM1QxNFBMWHJqemgwMTFqdDA1?=
 =?utf-8?B?M294d2JpbmZaN0FCRUZXTlA5VGZxdXI2Slh1SzhyNXBad0hBblBOTEpuUEV6?=
 =?utf-8?B?NllTcVNmMzR5OTFhWGlmUVZZZGJrLzYrN3Y2WG1ZR3lRdmViVzNOci8rWGo3?=
 =?utf-8?B?anNGRGV5Z1A4dVRxRFpGeW9CUytGTEhtdXR3Mys0cE5DWnRsbW1lNGVZYXVD?=
 =?utf-8?B?UVYvYXVnWnB1dDFGay9Bd3F5Ly8zbnBrZjRBNW0xQ3VmTS9abDFWWlNzV0RB?=
 =?utf-8?B?bnZqM3RUT2VVaVllNmhNNTl0ZVRnclRYcCt3OEI2SlRjQmhRRWJWWGJlRk0w?=
 =?utf-8?B?Ry9CY0tWYzVIZklzRWloSWt0QmR6Q25OY1dDZ052cVU0d1B1VXRzTkxOTndX?=
 =?utf-8?B?YzBRdko5SHR0WUhsWStjdTV5czE0MUlLcDF3L3RIbVovMlAvYmZHaWpNQ3po?=
 =?utf-8?B?KzlUR3ZMNjhwcEY1SUdUb05lQ1d0R0RRSzdKQUhkamN1cXJXNkJ5Vmhhdldo?=
 =?utf-8?B?aXdIRVgwVGp4SnI0NWxXc2d2bVZoM2xaWlRObVUzbkxNUUZvR1pSNG9EV3h1?=
 =?utf-8?B?L1RldExxRFFOUEFBRDJwQ09jOVRzdjhFYWtLVFc5cU5MdktjSmlPTlBoalc2?=
 =?utf-8?B?b21IS01XWlN6Ym9PN1FqQlREeDAvQm0vZmpJUE5jTm9wWHlWc1FpVlRUSE9j?=
 =?utf-8?B?c21JOUNReGhkK3R0UXNzaU9DVS9ZTnFrTnVnZFF3c2p1ZVFyM3dVN0I5WUlh?=
 =?utf-8?B?T0tNV0RkL2ZJRlVBZmxwQnMyU3g2Rndabi91RkdJakg0cDVFa3FZYUxLL3Bk?=
 =?utf-8?B?d1FmUERnZlp6cTlJTC9tMmM1Slp6Rndlek1mWU9IdnpkMnRMRkNXWGlNdnIz?=
 =?utf-8?B?N1R4Tmc5a0d6em81UVQzYzV3aEhXZm4xY0l3S3FqRWVBVGRocTVHNnFsM01q?=
 =?utf-8?B?SEtYZzk0L2xZTGo1ZGVTZWU5cGpVbFJEZEk3cFNsWXJtdWJxdHRGM2RGV2dP?=
 =?utf-8?B?TVZzdFAvUGkwK0NNaGM5bnFZUnUxV2t3NGk1dVdxZUNGQkRxKzhUaHZUandt?=
 =?utf-8?B?bU8wd0szRjg3d2FnVEpmOVhTamZUZjAwMEVKclh5bWNvdzREaXgwSkgrc2lW?=
 =?utf-8?B?QVo2SmhtWmhFekRFUFVhck9DTzZJQmlDNnRkWTZuT0dCYnFJUnp0bTQ5NXlx?=
 =?utf-8?B?Tmg0cHdPWjF3SjZwaEFVK3ZHZUN3dW1FSFgzeWM5cTJ0MUM2OHRDWEZkZDA5?=
 =?utf-8?B?dGd6SzlBdWhiMzFzUGNydklKTmZoU3ZFM3JBVDlGOWN3bGpxVlBxRUVRTnMw?=
 =?utf-8?B?clpWT3VTSUlBdm9lZS9oQ1pkTS9PT2JaUUNNR3h6Yk4xZWZ2ajFibXNxYTJr?=
 =?utf-8?B?a3pEaGR1TjZ0RzJ3Vi8wVmRQWnVkS3UzY2swM25JRDlkQURIc2ZXMjNkMVBv?=
 =?utf-8?Q?b8omn/rfOYF9FP4xlCXMRFaX2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715bfc0b-ed69-43f0-82f9-08ddb8cb9d0a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:18:01.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x21jtHyNAGrHEOklVh/grBYby5k/EtQM2V/6WHj/kBR6dTQUVINo+nPv2vFDcD+iJDKO2m6Me51whmo08vvQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

They did say they appreciate your faith in their abilities ;-) ;-)

 - Joel

On 7/1/2025 2:11 PM, Paul E. McKenney wrote:
> They do seem to be getting better at getting through spam filters,
> don't they?  :-(
> 
> 							Thanx, Paul
> 
> ----- Forwarded message from Carline Hood <zaqergrd@gmail.com> -----
> 
> Date: Tue, 1 Jul 2025 13:55:54 -0400
> From: Carline Hood <zaqergrd@gmail.com>
> To: rcu@vger.kernel.org
> Subject: Statement
> 
> Hey there!
> 
> We have received and are now processing the latest order you placed.
> We take delight in making sure you're satisfied and appreciate your
> faith in our abilities.  Please contact us at any stage if you have
> any questions or concerns.
> 
> 
> Carline Hood
> 
> 
> 
> ----- End forwarded message -----
> 


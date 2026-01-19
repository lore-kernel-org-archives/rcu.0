Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25937C0FC;
	Mon, 19 Jan 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833954; cv=fail; b=cYnGMjkAXIQ3tm2YBqq05XsWaaafdv5+d+VA4d65Worex8bk6ScEg36Azx/gDM4RG1xXwDSHeIAgS4TafEiaGLZOIb4LFeJe8PKVwm+VnbtKc5PyueuToEhfv3pTY7UpG6TgMwfo8mEMNPaj0ivAkPhmgOut1juHETsdI9PPShU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833954; c=relaxed/simple;
	bh=ytA2h2ZJhXDpdC2payn2A+kUCKGHAsLoSG2V8kq0ly0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 Message-ID:MIME-Version; b=QtCJNDA2/w3+NOeok29y7IU1tapyI73MX7PGvd1ihf8HUSR82ios0hYi/xSv0Pe3W6EQ0xFHpvCTnPC4dpWps0ZP24H35vdvyuVvGK9ED0652xGpGpdibmrIFihQvCMbDZn9iF9KMLcj5dhCBtZAyUsbE3PhFYxiv7G2Bwdt7ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDDsM0PZ; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDDsM0PZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teYsU0d3LhyuztsMWYUohd71kn/B8WGJJfEvOM7cJJCevKuNUaFph86sisFftTsGom3l6feXB3W21QLUZ5e/Ra/MrhN8fFgQg5SPoFVC4vuPGxXnNuXsN+KOk6qkuIy3tNNwD4NarOApkoyOYeQeEJ+jgDAUmvAhp0kgL811B13Zjrqlp0GNADKGOA6u/jkidWZytE0JGVTUdNyP9elHBQzbLpOn63m6iryQCSNnaf09AzQu+i7ZLxVeCrn1mOoGvg73/iv6DG89LXekKh5vwHUnEvK2YeehBGJVNlzrgfk14juP1eLIBm6VfLm3WFU7qNBYlfVuLrKJ1aHCyNclcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIUaV6BB2TMqC13f+lF6akuksRLA6WPLje1Pnd+NlRg=;
 b=TMsWDlUduwhKqknbllQqeOwXLrt+nH4YYfBKSNOhDKTgaoaJs582q6r805XkVK1hWBS59rvvebnKHXOCEpCtpErtgO7Qmn8jBXAIiNLyn/6hPdcwt/tucOjVwJlByAdxosE0r29lGdyoJ1eh6GkvLHcIzJB++Ny4bxhD7njwceaEkWEqYG9+UMJzKDPydPmLPdNSbVwYU8giTC786DwnystDS0De6ZhaM6XYWjOcCH6ODbUmM83d0pd7vxwKdZhI7hZPog+2e5bsX3TcXTMckhfDB59NnoHgAYJmruaaTMpq0kVcHC2n7Dy+N8qywyvTZgnmRc+OePPKBzU9ZaCEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUaV6BB2TMqC13f+lF6akuksRLA6WPLje1Pnd+NlRg=;
 b=oDDsM0PZX115C+yAzPLc9HkRielG7UIdy2bZMPTB0xOh2nqIqM/eA+LE5334jv7UyUX74EIsz8TRlHlrYxDmBVEw2zG5cFYtphoElTR27eA8jTaXJ4xfgkaLuKmQvMREwvfNsY3PjobaENDSk4angeKFzk0sdFGeNZ/kZVenl2zk91MhfAnHewUj/TlmXMT3itmry/+9ePO3cJoB1Gjt0D5DYr9fpkMoNKlernDGoNzxyIfri0sAY+NdIyxarbXQYH/HT6CSe1JuFp8pV5s3PN4f8RNP/kq5dHPyROjXVdIG1j7sNtWRPkkLogboC7Foim4bp1G6xXs6n3AnH3qRcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:45:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 14:45:50 +0000
Date: Mon, 19 Jan 2026 09:45:48 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	srikar@linux.ibm.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	samir@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
In-Reply-To: <20260119141118.GF830229@noisy.programming.kicks-ass.net>
References: <20260119141118.GF830229@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Message-ID:
 <DS0PR12MB6486E6599B99D08C5E46EC06A388A@DS0PR12MB6486.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e929ca-2c34-4107-965e-08de57696ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkRJcjl3TVZXRDcwdGlmWVhXaU5EZ2cvK1lIZ2FuemVncmFKY2luVmxRbVZy?=
 =?utf-8?B?M1dxY1EvZ2dkR0huNDVyeDdIM0xvMFRCMmZHbWdHL2x2N1MrRTFjbVI4Ulln?=
 =?utf-8?B?SldtMlBvMjcxelhkYVU3b0MwT2E4WndjclMxS1I4MElVYUVsWTFNdXhHdFc0?=
 =?utf-8?B?eWcrQ3pFWC9PVm8wQUFLYnhQZUhVcW1laGZVbEVvMGRraVorVzlKQnNyZ3RW?=
 =?utf-8?B?WTZNUjVzTjZnSm95bFA3RWdkY1JSbVpBNFBnZ0NUc2lvdE5YMjVEYi9zU1F2?=
 =?utf-8?B?enYzc0piM0IvY0h1NGJIWXNCMHNjRkNFM1dCcUQra0NsRUttUko3VE1ydkNj?=
 =?utf-8?B?bVV2c244L3IxOFBWbkRka3hWbWVEK3VtT0RoZldMMEYrNENuYzhINDhLRkN2?=
 =?utf-8?B?WWs2RG9PTjhveVFtUk1CSXl3ZTR4RWdzMGt1b2YxRjlLSmxzZnJYbkVjMExZ?=
 =?utf-8?B?MFAxTlZzY0J3S0FVR1dYTU1sOXFycHB2dVZRSUs5T0p0eUhYK1c0UHlQVkx5?=
 =?utf-8?B?c3R5Y296OFA0amR5MURlQzZYNGU4cVdWT1lrdjR4dnlYQmREM0RqVDZXd080?=
 =?utf-8?B?STlaQzdMNndOa0lidUU2UWI2WmxpSlJzTkR5YWg1d0dGODk5cnE1VHAwT0hS?=
 =?utf-8?B?L3R5YjRmWXg4UkswMFZLemtsV2VuSjNJb216bVhiNi9KMFdNbWFCUG0vODVr?=
 =?utf-8?B?b3ZGNkxWUUpibmc5TFVwZWdtK2hlS1Y3MU96d0tUQlR4ak45SzRGQ2RVRUpE?=
 =?utf-8?B?Z2ZaUzFGRmVZbmJseEV4VTEwUktvS0MrOWlLKzR2c2Y5ai9oVUVmQXRPQnpP?=
 =?utf-8?B?ejhLa00vUXpwMlFoei9MQ2VmaTZCdDFvckFpWGZuSjFlVHc4OW5icVdjQTdi?=
 =?utf-8?B?YUxpZXAwV1RSUlU1NzJ1ZHB2blRZb0RVQUFXemlLRjV4c3hkWm5nMUxaSFJh?=
 =?utf-8?B?Y1JlUW9vWTM1dlRJUGRjTkMwZHUrN1VTSkcyelpyVHlVelg0N2RyVjM5WGZu?=
 =?utf-8?B?Mi9PQyt6YUF3RlBTdG1nY056UU44azFPb25rK1ZER3Fab0tudU9TbUhUVUxW?=
 =?utf-8?B?R0hmbXdmSUVUY21WdnVqZmdVR0wzL1AzeVp4dmNSWDk1QU5CV1dPRnlQMmhk?=
 =?utf-8?B?SzFuVWZ0OEVwTzlaUldqSC9Ed2hQR1BZbG12TVR4NHZOSmlucTFnNkZ2OGMx?=
 =?utf-8?B?YitXS0FUOGRLZXdzNjUyOHRnOStLRXBkdWJiVVlwbmpZUjFLZ2dqV2Z4REZC?=
 =?utf-8?B?Yko1eU01cVpwek9SaHRuZWZNRitFUEtpL0RUQzlqSS9EbTNEYlJtUHJPbmJl?=
 =?utf-8?B?ZTBGT3AwUC8rUWg2WEg1aEM2RFIzVWxMOS9vOUgvQVc5RUtzN1JUdyt0MzJh?=
 =?utf-8?B?dkRhSE9jVW1WWENpdm10bUJvUTFjeXpqQ2tlYTE3MFJIOVVqcmRNTmlUZVNh?=
 =?utf-8?B?eFFZOHpFbmVxcjNNaUVMTjZ1ZVdHS1ArOTB1ZTBZNGNYOGwrMUpjbnNnSjdG?=
 =?utf-8?B?SnlsVkUvT2dHSVZ3UE82RjloM2twQkdRdlRUNDhOelNoVHVEZ2RNeFZDRHhx?=
 =?utf-8?B?Uklyc0ExQTNucExvV0xsL1FUMGQ1M0FnKzdmNlZ5QStVVSs3N3lyVm53enR2?=
 =?utf-8?B?M0J6Y1FCMnhNZEZnRS9BTXBVQjUrRi8zbDJUZjlUSU45ZU9ORzFWRGh4Qito?=
 =?utf-8?B?b293MTc4ODR4eVVQcE9xOTZxdkQvSnNRN3RYa0d1MjlTWDBVcU9yQVVxSHBw?=
 =?utf-8?B?cVN3ejRTVFpQak1TL2ZDNm10dkhmYjg5WDYwckFsVkxjTFcwS3M2dmVVNFJ6?=
 =?utf-8?B?Y3VGeHFOenlPTWlBekdsZWdCbHIwM3Nwam1zYklaQnNOeWZWWjR3cWZ2K0xY?=
 =?utf-8?B?TGo5OFZGWk5Hdk8xc01wOHdqb290YmdxczI0T3VkYkRSRXVldmt5T1NsamRu?=
 =?utf-8?B?aFdIVnA3S2FBekdPUzdSZjZxMVBabmZjYjBMbW1qTTZnTmRNZU9zem5wRG5E?=
 =?utf-8?B?TWFLbnJBYktmbGpPTzh4YUZjcEZtVzNwR29UY3hmTGhsQVozM05WSk4ySXB3?=
 =?utf-8?B?OFVvYmptbzJLdmJYdE1wMlA5ZDdTQzdRT1pKVTlwNFpHS1ljREhJRERjSmps?=
 =?utf-8?Q?cG6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZ3bTZnQTdQTHp4SVN6bWYwUktUT1lwNmlWcTlBb2tJUDh6c0J1c1hhb2Vq?=
 =?utf-8?B?ejkwcnBsS2d5TFFpUFpXUElMWTJHWThlRGVwbmtVK20rSUp6RU5rcUpIblY0?=
 =?utf-8?B?akwxVVp4VldIdC9wK3dBYUxDUEVPZmR5YmgvTnBXK2E2UDFkMVJlWHVLNXh4?=
 =?utf-8?B?SmxyVDZwOHh3OWFucHZvekhlREYyb3E0dUdhbGpWdkQybzFqb1hrU1pXNklr?=
 =?utf-8?B?RTJ1WS93cXc5QzY3bFJLS3RoYTZGeEx6R0dTWkFHOUxLSGs5dVg2VGVObU90?=
 =?utf-8?B?RXRSajgwWEUyVHZ5OTVqUXJKaEhEQUtKRitVbVk1cGpiLzlDWFVKaDNnQUls?=
 =?utf-8?B?YXhhVWpBb2ZLT3EvUTJETFZnOGprV29WUnBqNE9QWERDOHowMTNmNy9PdExR?=
 =?utf-8?B?RnU3UWlJeUR0ZGZEZFk3bkxRYUh3ZEt4QWZyZFNKOEc1YTMxU0dJejRVdXdr?=
 =?utf-8?B?cVBRVngySmZRWXlYSXF4TUlIVmZkV25tT3lwWHhVOVNCelRQTThCaGNKZ1R3?=
 =?utf-8?B?b2xpWE1mU0NxZ08xNWRsbjdtMTlib05wZUNLN0MwTWEvK25oVVdWWHdPM2k5?=
 =?utf-8?B?dEExMFdEaklIcnNGSDl3b0FiMkZRNklna3ZKNm00WVBUWEpHNFZza09vUzVK?=
 =?utf-8?B?ai81VzFqSFV5NTZ3SWduK05jMXJqbW9VSEpwd0VKNEFSRm90VUQxb01BZktq?=
 =?utf-8?B?VE1zQVFnV05tUTVORWhFajdsajZmUnpTQ0ZMOGVGMTdCZUp1NVdCL0NSeGlM?=
 =?utf-8?B?YW15cWl5bjdJSHE3dDFuSFcvSGkxQUxycHI1MHNjNlBMTlVROTF1RGNsanh3?=
 =?utf-8?B?ZTk4M1dUVmdNSStDNHRSdnZKTTRvVDhmNkNTcEZYQjhaZ1F1NWhBMFJIcklq?=
 =?utf-8?B?ZEdMdGVzOVVkTUlqTDhzWVdFM2tJM1BrUmhzVHBaRDNvV2Y1NWhUOEh3RzVF?=
 =?utf-8?B?K3JQTWt4cllZTDdjUUoyVVF1SHpucHlXam04YzAzYW1PQmZpQTBtZVdqWVRZ?=
 =?utf-8?B?ZkJjSU0wck1FWnFJbUZsUnFEcXZRYjJGMFBVUlRXUzhqajdPTmtMZzZuUUw4?=
 =?utf-8?B?YkQyM0dtRVBBdy9ReitQSXhoUUpjZXZQZnl1SXJCQjB3SE1qWUN4aEV5OEtE?=
 =?utf-8?B?Q29kazlyeDd5NTl2akIzV3VYcGtBV2hTTmlFeGE3K1NmRkJMRTY4bUgwR3c0?=
 =?utf-8?B?OGFQTFR5NjY2eHVSU3RIUFRwKzdDK1ptYkRBU1dCSjJLb1Y1QWZYVzR6VWdy?=
 =?utf-8?B?TXhITFQ4Z1A0SXJTalZlYTJRK3VXa3NkajlXb3JoTEt6Vjc2YlZOR3JyUExS?=
 =?utf-8?B?V05tclFHWjNJeVNKNDliL1lSWkt0eEZmcTAvV2ZXeVlCWndndFhCVUJmeXdN?=
 =?utf-8?B?ZWN0OWUvMVFmUVNCZUhOVktPeisxQjNDVHNHOGlkVE51QkVkRHZMQWh5RTd3?=
 =?utf-8?B?MEt4aDRqcmNJVXdOSXJLYVNhRkFQcjJud0NNTks4dkpTaURXdTdzZlNKb2h5?=
 =?utf-8?B?V3BWMFBTanNWaFAyVERnN0VXb1BHdzFMMDQrUFRGSVNSZ2wxNHdYcmVBUnFh?=
 =?utf-8?B?ak11Ukc3Y09IYWdnbmk4UzZWNDljYmkzem1yTDFyV1ZDVWxyaTQrS0VOempm?=
 =?utf-8?B?SFhNbFlsWjlDNVlkQWd3VURSQ3dDRXJnRmhaRVBiSVRXOTVmT2RlamNuOFdn?=
 =?utf-8?B?Lzc1T3gydndjY2dKb3JWY0o2VnplVUt4UkVONmhDS2JSM1hTd1RKS1dpVmkx?=
 =?utf-8?B?NTZ6V21PRWhtaTV4WVE0VytkTkJJQ2FtM3VIRmpvOGF4L054N3FiRGtpR05h?=
 =?utf-8?B?VGZaR1QrRjg5N0tKYzE0RVBWTXczL05ib0Y2b2gwVkVuTDlDRmNMb3pTU0tX?=
 =?utf-8?B?enF4Qy8wUGxKbjBYWmJCc29vR1AyV2ZOdzhyUXNEbkhwc3FicWxPeVM4c2JX?=
 =?utf-8?B?U0doTVozWmlBT2pVdThHckI2S2p6ZXlwckJxVlA4c0xUU2I4M2NyMVNBVGR0?=
 =?utf-8?B?WjFHcU9TQ0krenhOR1JuQ01tekxJWjhTYnBEcngxY2ZhZGhNdW16UTlmc2xX?=
 =?utf-8?B?WjlQeEt1bmZJVXZKV0hPY3dlZVdaanNQdGplUGhlcHZMNkRYbkE1N2t1dkd6?=
 =?utf-8?B?bUxwVUpHY1Z6eGJBZ2ljVmlHOGJDOUNZanVVZ0NxeTBIdXdJYTFTN0pTZ1Az?=
 =?utf-8?B?OFBaSnNzOU1LODZPQWkzSzJ5NXNzcXpQUFRFaXBNdjNySmlSaktrZWI0ZFFI?=
 =?utf-8?B?OWV4VUEwMytwMGRpUy9NQ1NIOTAwemdyTEZWZFNaV3RwRFNtc1o2Mm40ckhq?=
 =?utf-8?B?ZE1yQzVpTGIzb0ZZWHJqa2RIcjAzdmFzR09xUENYWW0rR3dTaVNYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e929ca-2c34-4107-965e-08de57696ffc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:45:50.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm/t14+xhg05KYCnrEKEAVU4CKfYNfpbF+lPczF86yINjs4z4uGpgz7XRxgpu0j0u415svk+lyQwVCiObzYy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

On Sun, Jan 19, 2026 at 03:11:18PM +0100, Peter Zijlstra wrote:
> By holding an extra rcu_sync reference, the percpu rwsem is kept into
> the the slow path, avoiding the rcu-sync on down_write(), which was very
> prevalent per this:
>
>   https://lkml.kernel.org/r/aWU9HRcs4ghazIRg@linux.ibm.com

Makes sense, though I wonder if we should have a separate percpu-rwsem API
for this rather than directly accessing the lock-internal rcu_sync state?
Other future percpu_rw_semaphore users may benefit as well.

 - Joel

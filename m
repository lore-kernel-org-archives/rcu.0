Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBA23C507;
	Fri, 16 May 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399986; cv=fail; b=a0A4i+Hy6jt01mOaU+Pwe5gQrXQWWf2f+1FqVm//CIPxNw0Vg4zW54NYBjCYNQLaXuFvRY8boZIxoVqrWjvC8Fe1eW5hg9FtMoT7Ed7fTnqD8wVfcuoGbOkRQfWxxUMTao+EfxHK2p7gr3GDumHR7UvRUsmHsimUgokxzJk9Dvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399986; c=relaxed/simple;
	bh=kw5DTqf+IKSzYN9JoAbZnO0PWoFa6PdWcp7nW4ay4cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVEZ9vjwHqRoNo0106DMlamUf/8MYP1I8sYuKSfdefHj82zyAkuVBCtpERWaaJfnD2jcJ61W+bDTPGooTkRgUkejhSmKecOZPz47kRvr4OtJkenlh+mL12yZ8Q9ZfMJ/uS2ChJckuEvW8OO8Nk88oIUvAUbJ51IDlmUxNyfCs60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=STz1vK2P; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="STz1vK2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og7Px05XW6Y5yJU/hfKtT10Yoh6mqTlR+4RxV6AWF8yHs23GTW+4P03a7TUt2515/CXshaXcHHWPO/kI/1//+CDZC4mX1cBCbPOV96AqTJsu5iCCKQg29v/B10qqT2ON1B7emy76IWfAYJkLAX4xlJO7XRmmJPSOp/e1o3TcQkZ5Mq/3XqjBwIwln9QOrC/RiHT0f0OGCN0uh4Fi4n6UGKeL0mNp8gF6HrdQxZBRc2r0BRrVlQ32xmFcxrVX9fIuV2vR7TwbFJaZ4KhqKg/sgf21Ch6eZlCSZmZjCPDipDFF7WV+3IA++CeyNLR84tKjPaQwwoqVD+bENIYPeLAjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxTz4zSFpLb7PY5QlQ2BArGD5uub0eT/92vtnwShKyI=;
 b=LVON9F+wyCrkJ8AqR0JR1IEahvXCmd+Ro5ZhQnRRwzyewGQG475HhplkmgT9KXVJMo3Cul4dy4XqD7xna4vRyMEr1aWoHSH4YTmmGqMzHL6nfPvHCOB5XOVyVN4M1zvsQ8l0S6Z0Kmg7r5kNdkarfKZa/FAa8bUTopTFBIjvzvfwSW5pJDpoIRdAA/61sE+FNlSztXp22luWwQr2yps4yRKIrowoR4cxzTEpaGn/EePnjkdy7VdoCzZRSQdyOgdtpgIZoUy4p77kxdFEjeS/uEcgtp1k24v4JwJtux59nybHFFxPDLE9vWRKB1gxi9iRuNdXdoagsE1jEHKLZszH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxTz4zSFpLb7PY5QlQ2BArGD5uub0eT/92vtnwShKyI=;
 b=STz1vK2PC5EKKyh1xCXV/q2Ks/30tJK7U3R3OoV02VIB5XyL2KtcvPz0945nHf+5hFgSlwB4/n0ys7f7AlRau0UlI3jegpnNZ9ZX8/Y5TxUqJhXTj6tOzQTbly6Y6xFdBBQSbRYdYASAHA7c2kzAyoEqe/88J/LT5CXKHRbE27z/liGsFSNxqno4ScIXLmUOYhpj9LyERC//D+t1YjrnyOq4A4I0uuc9sbs5blkgfEcOp7PLygfMN+/nVvTp2/QD/Znta62VthLCZVbU+GpdSJLK6wHnMokgUg97+hhzgJnhVyg7DoxSqkU6zkhgb1Cg3Kh90AEQMuX4lPEt5RK8zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 16 May
 2025 12:53:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 12:53:00 +0000
Message-ID: <67180bd6-07c6-48b7-9676-32be0f8a43f9@nvidia.com>
Date: Fri, 16 May 2025 08:52:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Zqiang's email address
To: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, qiang.zhang@linux.dev
References: <20250516112024.12035-1-qiang.zhang1211@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250516112024.12035-1-qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d411585-be07-4674-04d8-08dd9478968c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZYV1J1KzJXVUZiMG9xKzg3SldySDJrc3p6WkdOOStYaDdGT3hSOFBBWDQ5?=
 =?utf-8?B?U2FYZkhNeTZ0bDBQQlU2aURhT1EzODk4RlIzVmUwMmQreUlvTzA2STN3ZGNr?=
 =?utf-8?B?OTlpU2FnWnVRblVHL1NNSkFlc25RUHRrWkNYbThSUCtuaXFTZFd6L2t4NmZL?=
 =?utf-8?B?a2hPY0ZxOGEzM3RtUThxRGZLNkZwSDY0Y0U0MUJ5b1lFcnluYVA1NFFDMUVK?=
 =?utf-8?B?QWVoMGFPZWI5RlJVRG92WDR3aC92TkE0SW1DVXpqT0piK244YkluS1NnY0Zq?=
 =?utf-8?B?R3JTblRwOEdYMkF1dHZ2V2pVLysxNFFrYi80WDVQazVBUVRkVE8vYUlkZEdh?=
 =?utf-8?B?cVdqSFlNZll4WkpGZ0xQZ1ZZa01sUllRUVpselhTUXlxR1Vsci9PeFJlYTZI?=
 =?utf-8?B?TFk2Vk94RVNaaG1jZW1XS2dpTk9qc2Rvc3ZDbjVjelJoSGo3Z2tNNTB6STly?=
 =?utf-8?B?QUdqWXhkMTQ2YTJCdzRaZnlkeVRnRUU2S3FDZjZCUkUva1loRXlxT2E0NUQz?=
 =?utf-8?B?ZFZGUVp1NkNlOWFsSmpTWndqSmlXbGdKTVh6TDllaHZ6NnRtWFlCQmJsdko0?=
 =?utf-8?B?ZDloME9tTGg5MHJjcmppWXRxYXI3YXNFVHN2ZVppK1JUM2F1Tzg4cEtmN1NB?=
 =?utf-8?B?alNpc0tUQk5VTHRiQWdaSEZsZmRXZGh2Sm80aGJQVERvUk1lcEdMNnRBM1JK?=
 =?utf-8?B?MGIza2l0WUJqV1JGdFVkSXl1RlB4WjNiT3FsTFArRjY4S1RrM0lVSzFWUmJw?=
 =?utf-8?B?U0M5bCs2TXlGUm9MMjZ5cVIzUjI1YktQd20xTmw3WE5DMXZGK1Qwbm5Cbnk3?=
 =?utf-8?B?UEh2Ukl5TkRDSjFBY2J5VUtONDlWT09mZEtSK1lLNXVXN1A4Nm51cGRCVGxB?=
 =?utf-8?B?eVJ2Z2hPbDRYcGRFQVFpTjcvYWdpRHpIYnFrVlpoU1QyY1NmQWFNQVU4MCtu?=
 =?utf-8?B?SzMxYk5OdmxqeTY3SXluenR0YThtWE9CL3Z3YnFCWGJzMGlLU0dxSFMxOWdQ?=
 =?utf-8?B?V2VZRVJCUW1QN1dhOFl0T0s3NjBaWW1RdWhaN0ZiUjVZWml1ZzQveFZPNDc5?=
 =?utf-8?B?eG12U0dabjdCbmFPWVBkOHRaSUxzU0dMNDZvdDVCb0xzVFJtdlJKYU8xYWh4?=
 =?utf-8?B?d3N4LzNhL2djNnYycEJBOFZqYTFmUUxFaFIzNm50V1RiZElkaFJMRnFMRk5h?=
 =?utf-8?B?eWdnS2dFMkpEUU9LSHV5T0UvRFk0WGlQb3hvZWxtd3NmeFZuR2ZKZ2wzeGdj?=
 =?utf-8?B?ZEw1NmFYK0x5dEtUY01GMkllNWN3MGVMcWszZCt3ZWhQQ0lsc3ZZaXpoY1ZR?=
 =?utf-8?B?TzdBempsVnVkTjVBQ0NaVkJHTEZoNThMMkFnNWhBZFJSU3ZGTWs5RG1HVEZF?=
 =?utf-8?B?aUJONUI1VXVrWnZnQkx0YnlzdTR0cmJxUzU3aUFGRFVXbVJhOW5lN2ZSRUdZ?=
 =?utf-8?B?dWRsNEFLdEEzamNhQ2tFU2kxait0TlRWU1BhTzAzUm16ZDZma0I3cHAzZmZP?=
 =?utf-8?B?Y2xkdy9HNk5XU1kwSXRwYzVxYWlLZ1BJZElYUEtsbHZQaWEvMWpvclR5dEVI?=
 =?utf-8?B?VUNpT0RxcXdyRVVndnhJdlUzcXdvOU9haFM2eEVhM0NjbVlzUmlOSDk0KzM4?=
 =?utf-8?B?cENvSnB5Wlg0ZjVDcTY3VHBuRFQrU2ZoNGV6ZzlQakcyKzJoMFZzRTZCQnNX?=
 =?utf-8?B?MzIvNUpMemtNbjloV00yS2p1c014a01MV3ZXMlg0RTRVRmxueSsvL29HYWR3?=
 =?utf-8?B?TnJZUE5PbDdzZTdyL0o3aHlCYTVVWGt6U1NWYjVacWNrMCtCYkNkQjNJcE9J?=
 =?utf-8?B?dDdLdyt2WU5uVVdiMWxyeHEzSWQyZ1ZHaG43dC9NVUxkd29NV1RSa3cxZi9K?=
 =?utf-8?B?WDk2UEkxaWpUbkpqWWxMcUFqRStGdWZNVEx6ejhld0JBdnRPRWtjV2p1eXdP?=
 =?utf-8?Q?kLE467GEGG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhuMUp0eFVGZUxrY01ZSzU5WWZ6c09XS1BnSkJObjE3OFZjSDVOUm16L003?=
 =?utf-8?B?NFV2RlpoVXkrTEh0WnYvNnpHTXdIVXJ0WDdIL0krMWdmSDl4MytYZFZLRU5Y?=
 =?utf-8?B?SkJyRytjZzZSb2tpOXQwcU5rb3U2RDhEN1hLT0srcVJ5UGo2UUszdlJIZ2tx?=
 =?utf-8?B?WklsWitsbHcxUDZDSUtNYUx1WDdnSTBWeG9JbEtkeDdYRG1uYzBySlhQN2Yv?=
 =?utf-8?B?R1BEclRmdERaOStLck9YWHdpQUpZTEw5TEMyb2RHV2c4c21maGlmdG02S09F?=
 =?utf-8?B?L1FkQkdqNVJaM3JyaStyU0FYTTBzekliVmxHSy8vbVJHYWIvNkNvdFFQVW12?=
 =?utf-8?B?UFZnUWJBK2UxTVoyY2Vxc2xGZGJYYXh4NjlUNnd4Mi9tb0NETEpPTzV3R1R2?=
 =?utf-8?B?SW5KcFU2ZU9RbE44OEZNYVFRSTZmWnZYMlFkb2QrdkFQKzhVejcyTGxNSEEr?=
 =?utf-8?B?WGdoYXBhbEZ3QUhOd0pxSDBQaEtITDMxcWJyT3dKMmJpc0ZpQWNkcHgvbENu?=
 =?utf-8?B?R3A2SjNHaU1kVGlHb2xQNVk3bFcwQ3ZlN3hQMWJGSUQycmc5SmdxK1NuS3oz?=
 =?utf-8?B?Q0pObW1SOFRkMlFQUWU4ZnhYK2h4N0dVZ3dvUHpxaWlDeUt2VHFCN0FaYTc3?=
 =?utf-8?B?aGxKcm1EL3VsdTJiNXdkRHZGQW4ydlVPMTZUV2pQR25RMXNCampod3BaUWQx?=
 =?utf-8?B?VHlHb21UWHRsbzJheTNiOGdkUXBSRnVmWEN3WDZ4WFJDNWJuc3Jyc3dnaUVq?=
 =?utf-8?B?WEFPMFJKS0wwTzYwWjlMYkhad1llbTJiSGhkNFBTdEdXdjNxOCt3aXBrbFRX?=
 =?utf-8?B?RFZTc1ZaTFV0NFVzcTN4UnNDZWVlTGlNVGFITGFzeGo1YzE3emFWSFp0ckds?=
 =?utf-8?B?VmVtakJBRUFFU1FBWGc1R3pVL3cxZ2p4V21saFpRajVsTUdKeG5jalhDOGxi?=
 =?utf-8?B?Y2FFN21FbTJGanV5bm9VTlhuQ3owTjlLOUxtUFdZdXZVZEF0N2RJdGx2RzBa?=
 =?utf-8?B?aFRoUTdWZlQ4dTFwUmNvTnB4a1d4UlVMZnVkdWVHRExkbWVBekVBU29nY2o2?=
 =?utf-8?B?aUZ4cW02ZTJTd0RYcDY4ODlsZlp6RjQ4M3ZwZDZjWUQ4MVVLMzhMWkFUMnY5?=
 =?utf-8?B?SlBOZnRFbitsdU5wTHM5dVkzN1NyMTlBYzhCbENOYWZ3OER4YTAxWUZudHJT?=
 =?utf-8?B?Mm92MXNET3E5cEZUMFNPQXV1Y2Q2TE9CcElmYzZyWkdGLzhaNENENjE4blVt?=
 =?utf-8?B?eGNqQlgxdElCYjUxOE1hMHRSc201bVdiYUVsNlhCdmR4Zm5aMEc5TERlMTBj?=
 =?utf-8?B?bjlIK3RlT014OXdyRVp4ckRuWXYwa0FYQ2lFZXp5Nkg0MTQ3WHpqQ1B0TE5j?=
 =?utf-8?B?Vkt6VlNBODEwRUxGcTIyc2QvUEliSmhWbGN5VUlIK2JsZWFxYllWZ2FGQmx2?=
 =?utf-8?B?VU14Ui9MZm5uTkFhSzVlS05OQkdvczJDOXluUnVNQ01Ud1Raa1p5cXpOVVp4?=
 =?utf-8?B?YXRqT3dwNkRTT0xhaVNPYWZDZS9YZndwdU9NYTZUVE5LMGRrRDhydXpRNUJw?=
 =?utf-8?B?amw0eTQyN0hGb2RaanU5V1Nrem9zbzJoNGVtd0U4MUdzTFJtcDZQYWM2ZUdj?=
 =?utf-8?B?ZldleGkxbjZ3TGQva0VOek9EeEp5Qmh2UHoyY29LNWlaMEVGb0J2RDN3YlBE?=
 =?utf-8?B?K0swdU1YRnJzVGNaZ0k5amV3Zll1Sys5ZVRlaVFQenF0ZFUxZ05lWWEwRXdF?=
 =?utf-8?B?ZFhCVTFqOCtJWFBvZmR4c0dSWk03OEVmcVJxNlNmRFRNaDFCZTlCU0ZaWTJu?=
 =?utf-8?B?OHk1MklOYUVLL2VWeWZtSGlSRFY1NlFhbDdWa1d2bkRzcXdsL3hZSG1CNmdZ?=
 =?utf-8?B?RG9rWG1XR25wVkJZNU9JMFZYcUZDWnRNbGNzZXVlLy9EQlg4a2VweldlMlMr?=
 =?utf-8?B?OTlhZzdMUHlGR00wckE5S24wZ21qUzROUHJkZE16dHFNbzFOM2laRndHZUV2?=
 =?utf-8?B?aVRrNHRRMW9qL0NJTHN6QnJPVEdyVzVrSG11anB1UFh5ZHJiQk9aSS8xbFpx?=
 =?utf-8?B?TXNTVEx0VWVQWDhQZzRTV09DdHFSanRDdDNnVTV1S0JlRUErWXpHbEJBSE9K?=
 =?utf-8?Q?WOlxwC9ePCrp0yzh89IiQCtlj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d411585-be07-4674-04d8-08dd9478968c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 12:53:00.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb47GNC/vott8/kU+wrWHg8p9I629YYdiiatiVzt6KqYdItIjeDupmBGGBCyql3oGnRcH02mV9zw1yRxUCdpKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771



On 5/16/2025 7:20 AM, Zqiang wrote:
> This patch updates Zqiang's email address to qiang.zhang@linux.dev.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Acked-by: Joel Fernandes <joelagnelf@nvidia.com>

Will apply for 6.16. Thanks,

 - Joel


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8eb7e057b8f9..901a54a633f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20298,7 +20298,7 @@ M:	Uladzislau Rezki <urezki@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
> -R:	Zqiang <qiang.zhang1211@gmail.com>
> +R:	Zqiang <qiang.zhang@linux.dev>
>  L:	rcu@vger.kernel.org
>  S:	Supported
>  W:	http://www.rdrop.com/users/paulmck/RCU/


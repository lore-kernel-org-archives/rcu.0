Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DF3A960B;
	Wed, 21 Jan 2026 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022846; cv=fail; b=tAmKpIgC1nv9D74gX5oz8WducXHdD97qdp8n17RJDv7s7mejyzpb7PPlpYR2v7qhq0AjfisrWqyF7HE/+pm6b9KUUNa2wBu+ukLEkwtuQeAJDe+2HHU2AI0gwB+Hd76sfJex03OFn8Rer6pHVgsfNrUBuKr82ioV+q9M0zZ+HH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022846; c=relaxed/simple;
	bh=ZdZ5ZWgLB2zLXzcstxSCaVsrN82Ys/iWW9jD0HpwphI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmWJCpnh/an+QNlKcoKJ6QtScnjrSb/hqncukhnnEjuNCKFR/pRWvR69zfJIzuyFEXalTKiP6J/pboyH17gjFuBBvJjuw10do2EIhfvKgOsfEszt22aUlgAzv5eV8EOIjFY+t5sRdIvwpuoQvD2XgW+D0G15WtkUJ8SOZzkoKFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BMUxmmmH; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BMUxmmmH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQxX7HV4d9qIQy/qnhGnyQPO4pbbmc2wJHcLP/udOD67IW72nkk+nTI3/r3cBvmnJHiFyCYxRBY+PnATuOgGNqLiuOux66vokD19In+JZ7xAE9sU41gYtNnQldW0Wnl2bMSi2+NMnGgT0qzM+dv5+eMwYYGRSei4Zxo8P2T6i72A96R2fP1/tGzSwqfkk7JDjXZmLTQg5lNxzi/yFj/GXNOOTMySJljhibt2BxpGQFcqnQF3M7sZVV01SJ7ircIeNDLd12BdD3SAWGCWno7ez5amneCYaZsyrNCgVJNngCHmrLxTm67hP2aTrNh5SFEdBWFG5tCXt7X7bP3huiWWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owa6uHUA0EbNeupIUmc6eqyBH5bT0S3yCtxho8T4mZw=;
 b=Ejo+nneLvZFHCDbewVpqUiZSZWTh2ygV4LsGb3XHBiQZb0kcmmSXiZ0D9HVlEBgaUolMaZz7xsiLUZvYiTwQhO1tbNX1OGvQAA1wowZ64Xpobbgo3S52IZy+wB2vWIfrjiEJ8LkBOFYM2nlIp2vB9LSkP7e3FZNZEk4YoiORSOtUlUJgo1mpE0rlcet+nnG+3Ea9HSPO+lRqrG23QXwEm3hfNFVkYw9R2fUDIwwKaM1G38BduNaoyX3a8jfog5Y4NEU/Iu6AENiQFXPfyHVUbXHu21uyPB5Ci+605VRiWrb0BKQwAby2r6X/klB/xgTrL97AW9dZcOCjRmMPkikgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owa6uHUA0EbNeupIUmc6eqyBH5bT0S3yCtxho8T4mZw=;
 b=BMUxmmmHpsCFqhngKL7abzyDlIXGi8rtOloLwXYbumhoE4ZpEu/daJPpU7i8btXe7Vw5Bn3viZTAciFoqYm5sQGgYhOmPeTVgzm9GTglhNuDU9qMLPKc3IPyd8C7xv/RoR1KOSHKgU+krFwETrWD2KjvOJE4DYzXuQQ8dw1PFJHYaTg2hTy0RZt30RdE0obDCGqZWPZa9L54mtoK1G0x+lOM2r/VIvsc00UgvD95KqgijaUgc0dCeTViU4SOvueUT9xlP16f6TZoW5QSrlL93I2qS/N3uIIA9Ovgq5pyHzEjMaonUwwGAyX7KgSwLiR3Ynyf6h07Db3K4jo2yIh1Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 19:13:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 19:13:59 +0000
Message-ID: <be3df000-915d-4fa1-b7e4-231df1344815@nvidia.com>
Date: Wed, 21 Jan 2026 14:13:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 0/3] rcu/nocb: Cleanup patches for next merge
 window
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <f568bee5-9cda-40bb-977a-a9063bd2c611@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <f568bee5-9cda-40bb-977a-a9063bd2c611@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 76af90dd-ea94-43f9-7860-08de59213acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3VUWmtyTmsrRnREVXBodTU1dlNJTXZEMUIvNEJIS1hyQVk5Y3FzWUliTnVl?=
 =?utf-8?B?Sk1CTG56WXh4QTdmQ0xtTFIwOGhId2t0dnRBTjJoS0N1UEhTYmVXcm1VUWtG?=
 =?utf-8?B?NnlEU2pOQTluR2R4cWFRMW1WODVIQlhvTUE3SmhJak9CNWpQRUlqZ3BsOWRM?=
 =?utf-8?B?RW1mSUtzakV6eVFTazdabHF5TWQweCs2K2VwSERDa1lxa1lWUTE4dlBLdHRX?=
 =?utf-8?B?K295S0w1UW9CZlN6VEgzNHBCb1JmVTBJL3R2OVdvdy8vMHlJYnJPc2VzTDZh?=
 =?utf-8?B?L0ppK1VyelpBSXVkbWc2eFJ0Yjl0KytDZkFHdjM3RkVsdy80dVVLWGtyU0tM?=
 =?utf-8?B?d0tyakN3YXZSZGFOajU0c0ZncWxCdG4zaklOSHVzV1A1cTI0alJwdFNReGNI?=
 =?utf-8?B?L1VBNnVCOUdtYlNZRHNHMCsxQzBsNHZyeUpIUTQ4dkxscnNlYlNrdGtTK2cy?=
 =?utf-8?B?Q1JNVXd4L0daR3NCMlVQdllEM21rcnJDNHFVR0VjQVdOMUFJRXZKeHlqTkRp?=
 =?utf-8?B?L01iRUdlYWYyL1dVK0VTNHNobkFoaE0zeDNISlYxUVUreG9nM0FjZGFuUjNt?=
 =?utf-8?B?U2xITGJpOFRvdUt3NzBYZ0FkTk9QT1QzK2N5cWRXdmluS3ZZdlpDanJXSytF?=
 =?utf-8?B?aVVBZlJ0S09NVVFnZGpBRFJZMUtxdjJ0a1hTM3BBRW9MOXViOWx0N1hGOHdE?=
 =?utf-8?B?eXJ5WkJQSU1peSt1a3Q0RWI0M0p0dEEyem5pa1lXWEpocVZndi9PandlckE0?=
 =?utf-8?B?RmRGQnpkaS8zNllJNXZUR2RMenM1ZzNYMHFVZTRMcElIMzF0UHpSSnErL1Jv?=
 =?utf-8?B?dzN2MWR6L3Z0NnhnTlJkc2hrSGd4enUwVTFvVjEwK0FRVmtKK1VNY0V6cVlS?=
 =?utf-8?B?NVN6M3JqbWdRdisxOEdiUm50TTU4VGJaQnlHREJaVVJsd2VZRFNpdmcxSmcv?=
 =?utf-8?B?Wm9BNmNiZTJnYjdka1hubmp4aER3N2kxWGNlR3hHbzJJaVlWNWtYVlhYN1Mw?=
 =?utf-8?B?QThrd2c2TzJrcEE4TUhWNS9BZGpzWmJwa3hiZ0dVRTE3cjRlRHVnZ3B0Q1F0?=
 =?utf-8?B?ZVRsWk1DY3JxcEZ0NG5ndWRQa3pLUC8zMjUycnhHbGJrbmFRQ3EvKzRDVzMr?=
 =?utf-8?B?RGlSYVdPRWU3U0VYRHBGU2hyaUcrR1RGZTNEcmIwZzRadVhKSWxFMTI5dktB?=
 =?utf-8?B?V1dnU1o4K0t0bmlLUEJabkNvL0FFTkJFQVROQVB5dnNXOEZmSFBka2ZMUzdk?=
 =?utf-8?B?anh0WXd4TEN1YmU3YXZMdmtlbm5BWC9LdjNUVnVxY0o3UnFmbFpXN1h3czI0?=
 =?utf-8?B?RG1uQTU5RW9yUmFVOTEza3dkcHpIMWZVSTErL3ZUamQ2bHh4bHVsVWlmVWMz?=
 =?utf-8?B?V1BUSTZ0RGFsU0NLcXBDaHVKR21rYVI2QXc1QUlQY0NPVEtMc2I5SmEvTjBW?=
 =?utf-8?B?VEZVbFZOalM4SVZpOTRpMzEwNUVPRHBBclRKS2twektoV05ycThIQWd5WjhQ?=
 =?utf-8?B?c0dDblF0WFBaemZJNkJNRkptcktyNzJNL2FkcVFvQm5SYVBpS2lhUXM3M2VE?=
 =?utf-8?B?Q2FXL1dTcWw3bkVZU3RYL0Z2SW5sNXpiNjNQL2pPdWtoTVB5NEh5WXErYjkw?=
 =?utf-8?B?NHg1N1NkdTB0TEFmeG5EM3NaQ0NhY1pra1lxMWhVM0R2Um12cXk0ZlpSbHh4?=
 =?utf-8?B?anU0SEdWM0xlT1VLTngySGlmcVVEWm1CUGYwbkU1WVRvS2U5cFJHUHF6NE1u?=
 =?utf-8?B?a0ttVjNTZ2luNll6N08zQlVOZ0NLQ2hoWU5PYWZMMUhINy9zeGk0ZnN5ZFM1?=
 =?utf-8?B?MDVaUUxIQ1BvbzZRUkd5VGowOXJZOXRkZ3pBM2Ztb3NQMVRtMTdOYzlQd3dX?=
 =?utf-8?B?cEpZcHJSUEJ3Q2Vvb1pWMTdtSlRmR3dLdTRFZ25ubnVXZWhDeG1KTzRPcDY3?=
 =?utf-8?B?azJEWnJpMWF2Wk0rQ3A0MDlOempaUGQ3dWNySVBLWTBGanl6M21aZEl3RUtE?=
 =?utf-8?B?ZXJ1dittNW93d0pDTS9YbFRJamk2SUUydjAyS0toOHRMejU3dUYzczBsTWFj?=
 =?utf-8?B?SUg0ZGkvZ0FJcFIycERUL3BiajJHMkgyZ2t1K0ZYR1VkWVFmKzFjQ012QTdW?=
 =?utf-8?Q?aUoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRIMWdpaGhVeHJUL1YxRk1sSUo2SFlWeDF3bjdsM1VPSTdwbEpMVDQ4bzNR?=
 =?utf-8?B?dkNueVFRZXVCL0RSOFlkZ1FIVFRpL0wwZEoyOTJLVEdzY3pWVlRYWDltVzc1?=
 =?utf-8?B?b3B5YzJzNVFkRmRNb1YyaHpzQTEvUTJ4VEt6cFh2MFp0VDNFaCtnRjBiUTFx?=
 =?utf-8?B?MFNLT2N0MlVHOE01Q1lWcHNRRFl1bkVxRUpPSXlpWklyUSsrbk5IMUZsTm14?=
 =?utf-8?B?dWlBWUdYYUZ6YmUvMkVzSXFZaFJMUUJkNE05VTRkZUU0SUE0WTlwTTd3dGMr?=
 =?utf-8?B?OTNoQy9sdmx2Y2pEV1pUR1NQRkR1NEswcEVFQzRoVzJEMEFMOUpHT1B1S3o1?=
 =?utf-8?B?Tzl0dnJ3N0M4TU1wd09Yb3drQUNmbXQ2M0V4bjU1N1dUSFBZN2RydmhKYkpF?=
 =?utf-8?B?cEt1TWRMY0dWMmdrWlBGR3dyeGhrWVJMUjdOUmdUOGhUelNkUEhmUFFtdzNt?=
 =?utf-8?B?OVhsMVcyZExuYkVkMDA5UjBDZHRtSjJiWlA1QW5zYnJTNVdPVXA5ekxjQ2Vz?=
 =?utf-8?B?eXVDWUlMYlNBZWgydlFNRGU4bUp1SExZblZyaENjRm1LeUV6NWt1MDhHOUho?=
 =?utf-8?B?YnhLK2d4eG1BSGxHamRTTll6UnZLajdQOWF0UGg4SWRCTEpaTDFBVWE0U29u?=
 =?utf-8?B?U1I5QUovdnlEVGlEaW1JOFR5ZVIrNEt6dCs4K2JwTVdETVZxNU93TmN4a0lJ?=
 =?utf-8?B?WDgzbG1kUkN1SFNqTk1TMzFzcHZlbVovcGlrS3lONlE2K3Q0WUJ2YjdCTlZl?=
 =?utf-8?B?dThkSHkwcEQ2OFc3T280dCt5bnhRczVHMWpyUktLOG1tTlhCeUJ4V0dyNUht?=
 =?utf-8?B?dHZvN0lJbkxZK05lU0hRQjI0c0U0aWJtOUJjb05YRDNwZVFhZ3lLSXk4Qko4?=
 =?utf-8?B?S3ZGYWhUMUZyREFsZS90bW82dXFSQWNPWFJ3M25QWGdDQ09LM1BsUHJwUllH?=
 =?utf-8?B?aEQwVDdoN0RvSnd0K0ZGQzNrQk1XWHhQUHk2K0w3NFQvZTRHM3Y1UmZzSTNa?=
 =?utf-8?B?bjBsK1JUclNTMWhZbU42OWRQMWVYamduMDlVWlJ5N1N4NDZnWm9leXYrTjE1?=
 =?utf-8?B?UDIrejc2YVY5dHp5UlhnK1BoeFVNUVlneG0vQktVU2g0cEFCYnU4cWJVK3Ra?=
 =?utf-8?B?ZmhrSHJ5ZStRaVdndFlVT0FQRGtid21wK2x0VFJYQUNEMnpsbDFXazBYNVla?=
 =?utf-8?B?UGZYRnhIa0w4TlRaVUYyV3VKelRxcmViNlliZUFRWkc2Umx6RnVzM2tFNlh6?=
 =?utf-8?B?dldjWEtjMVRmUXJMOHk1QnRrKzN2SmJNenFWZ2lxbFBmZ2NwcGorc3JGekla?=
 =?utf-8?B?OXd2R28rSkx6ZjBJMUFtNC9NdjJoTFNWOVRZQXM2aUp3ZzFFWDVydmdMMEZC?=
 =?utf-8?B?L0orN1ZjSENHb0hpVS84emlKc1hFcFZBL0trWGorU09rSDlOMHZKQTA2bFBV?=
 =?utf-8?B?OVU0SUZCZEFLayttWmVQRnB4Rmoxam1SQ2s2emZoRUZ5QVZwYWpWbzdhQ09F?=
 =?utf-8?B?QXlxMkwwbXNMYnh1UzZTL2tDOExjUzNIdEoyNlMwTm5HY1FMYkdVbjBBL0FV?=
 =?utf-8?B?bUlYVjFudTBTRHNCN2hpR01uaUNlR0hUUUJLSWVZZzZlTldBeHprZWJ6UUcz?=
 =?utf-8?B?Zmp3N0ozVThiYW9LUFBMYUVXT2VDTEtST0tINlAvaVZwc3k4aHZVMDVmY0dB?=
 =?utf-8?B?ZGhrbmFJVFc4T3NyS3VHTElEYTdjWnRtNS9RRGJlbVRIVTRNYXZLd0xBR3B5?=
 =?utf-8?B?VFBidFZERldSVGVxUlFYU09iUEl6dCs2bEhUYmlTZGNyVG82Z0FVSmZScWhV?=
 =?utf-8?B?UG9vd3FNN2NycDNYMm5jNlJEMEdJNGlCeEc5UVg1VjBIUTBVaHhHUjlUNDRN?=
 =?utf-8?B?NlVZeDlCeHhCbWFVZ0paSDZtL29EYThoWmNTWWIxcFpTZlhYTUZkNnY4NWpz?=
 =?utf-8?B?SkVhYWhkd1RlclJnamJ3OTdVMjdDcm9rRmdITmo0eTVYWjhHbGVYaDlTSG12?=
 =?utf-8?B?NVlCTlNWclYrMjNWcmxBR3d6WCs4Qm92MlJKZnMreGtvRjd1ZitHVmVncEFW?=
 =?utf-8?B?V2lIVTE0TVpyVi9lOUcxcGpxVXJQeFJKcHZUdjlsb1NiUE9waDE0VFZrbWtV?=
 =?utf-8?B?MXdhMnM2cm02aFNWSGRteC9tR0s5M2JFMXJmQ1F3K3ViR2I1RzhxQlkwVjlt?=
 =?utf-8?B?OWE4NWZTc3Z5T25LL1pUQUw5N1kxd0x0c2pPeWhZT2E1VmViTjlaOUpBR0tT?=
 =?utf-8?B?bGt6OUpzTS81R0Q0S1NrZnNIOG9LeEVyTGZZQ2dJQTJBMW5TUWF4Tk5aa2ht?=
 =?utf-8?B?UmRqUGZIZHhtT3hpcFUxc2lJckU0SDZhVlhqa09GYkpRb3BPaUpIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76af90dd-ea94-43f9-7860-08de59213acf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:13:59.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95Bq0t6T2WVqq5+7w1HlFgoet1TRXJeRIeNcwjmQFAPAvpSu3wsAX14YDSHWCU3drSAHt+rlBAlwXit5cb+Scw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077



On 1/21/2026 2:09 PM, Paul E. McKenney wrote:
> On Mon, Jan 19, 2026 at 06:12:20PM -0500, Joel Fernandes wrote:
>> These are a few nocb related cleanup patches for the next merge window.
>>
>> Also Frederic please object to the second patch ("Remove dead callback overload
>> handling") if you would like, but I think based on our discussion I have
>> implemented your suggestion, so it should be good.
>>
>> Changes from v2:
>> - Dropped patch 2 "Add warning if no rcuog wake up attempt happened during
>>   overload" as it was not needed since we removed the dead CB overload handling.
>> - Replaced "Add warning to detect if overload advancement is ever useful" with
>>   "Remove dead callback overload handling" per Frederic's feedback - instead of
>>   adding a warning, just remove the dead code path entirely.
>>
>> nocb rcutorture scenarios passed overnight testing on my system.
> 
> I reverted three of your earlier patches in order to apply this, only
> one of which I am really confident in.  Please check my -rcu tree to see
> if any of the three should be added back in, and I am starting tests in
> the meantime.Age	Commit message (Expand)	Author	Files	Lines

Per your latest /dev branch
(https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev),
you have the latest 3 patches:

Extract nocb_defer_wakeup_cancel() helperdev	Joel Fernandes	1	-8/+11
rcu/nocb: Remove dead callback overload handling	Joel Fernandes	1	-12/+0
rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path	Joel Fernandes	3	-36/+18

thanks,
-- 
Joel Fernandes


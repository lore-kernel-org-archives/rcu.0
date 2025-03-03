Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB724EF6B;
	Mon,  3 Mar 2025 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023058; cv=fail; b=oq+cHD0oKGP7V7FAWXdmZwoDnbUs7vNYbsUS9ojPVpBeAYGjSoWsO+jUmp/cF8xwGv1ARMsADgzwR2cRmtqxMxwPiY6GM/s3oCz6xajzRTHEitEg94dqVkm7lHF7TcKoyniCRaK+O22TWAoXwetPaSM7CwR235NWjH04wZltEgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023058; c=relaxed/simple;
	bh=NHPYpRCAa1F+eDaCvCUQqjctw06vvRswgzGOwTrKyZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6DvxJemLK9YsfcqaeVR8R9DgibkZPjynWqJtEryxRsAXbdTTIf3kKuRg2fO2TUOvRqsPQUsgFiJDRQu5Nve3Lx09+xbPbfAstyNQqJ3b6ZSP9x4ZHx8D3Tpx7qFggj8SH8wLAWFi8ffXiKpLydBQwLqaV4QGPf7qJNk45s51iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DW8nZsHG; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DW8nZsHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4GUT35jg/pwFCfAKNFA85Kfe/VaTOe17I26/Q/bsdMb549+ujaOd7TznVeKYx/1Y8MRcmlAqmpvv+jr0qVMAmIPkVecnAZ2C+QYa8LPgrOKHnz6lPrZhUCOSnPsTtHTid0KvPi45xxjNPkd539FKDD5KoWJwWM1o/l/yMfxQGDvNg6o1CGhA/wBNF0k76AuP7pu5vG9eNEo73P1EwV0zI2EiuZCtNhcTXc0ttT3JW8D60W8qwgvtaupoykFjsEug3F4DdIxtVHhNJuc2VbSj2imzDClrDqKXuGT0F24QC0cRdoDDklrv2Gg9GhraJP568HeWxiU3dDfsx4Z1Z5mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWr3Ew1FIec2nVR1hOXg7CQCiB87KYWLT3afRRAd/HE=;
 b=U1XSp4kjmcPik6ZU4i6UyDSDkWPuWuQMk6cE/WCL8mn2zqxQHDMIrPKkX1cyD4UazFiT+H+bCad9HGYF+GvPkZsEPNFKN6KG8tAhCj7DHrojejTmepKCdYmJAVhiWSiDxCcoCLDA8gW4l8uGSPhmDkCW0YxFpml/mB0Ife37Z2MuL8inRmYBojjja0mzLAAMPH+XhfJ+o5Bi0oPYnTK5fyL7xFxZAdlSERHfVgHl9r09u6mRzOvwDdTi9zZv/qzMRtW0TpvNZDE0Xcz0zTBUwuthR39maV+u86yM5UkIwmuPP6tae+SK9yi9snXL6+l367Lseo4lxgWA8dUWePfcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWr3Ew1FIec2nVR1hOXg7CQCiB87KYWLT3afRRAd/HE=;
 b=DW8nZsHGUwDX8G6unrszhBvzoYJc44mfN85Ex3waFwgVtpOSjgryeIi1wuZoYmaJH1a5ITEEmYyAvlJ7Pp3tF29yU72dw/qdlNH7Vdoa4eoqpVFG9f4U6VsQ4EbKjy3d58rm0s2IlXIX3YHDt/GiwzqzSVdr1VwbjWTY63apB5Ayuga7n7qbwMlNhdEBvvDWLUOkjkdKDbd6WnOtWbY2U752DRpvQPVvek0bihz+YY5wQw2XMus3GVohPAdeNG7PiEFS97ybCSBXAP90E5piFJ4Kou1xv8I6ZR1xTab/zrW9QW0u4NMje0JXcxH9Izmm5yDTCoajrTXIdUKFxRKyzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:30:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 17:30:53 +0000
Message-ID: <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>
Date: Mon, 3 Mar 2025 12:30:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox> <20250303001710.GA3997787@joelnvbox>
 <20250303170040.GA31126@joelnvbox> <Z8Xh0pP4xaFm0nEV@tardis>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z8Xh0pP4xaFm0nEV@tardis>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c9520f-7817-4780-4202-08dd5a7925cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?andpM1N6Qk5BNkt2RmpaOHNDclFBTzQxOFpkZ0F6ZHg0Wm00ZUkvTDJGait0?=
 =?utf-8?B?endGU2xUMkJRZVZrNmYrVnYwa2Z5YXNXais1WWYxTFBNcTR0dmNYSnZYQTBU?=
 =?utf-8?B?UlNQV1BRcm9EeHU0WW1wdVRoSlNDWm5rQjRuRVRzL0ViSkNFQXFSUExmZjVC?=
 =?utf-8?B?djVUY2lMdFdGWWh4OXpPYTZ4YlhVejZHS21rbFd3TVpyZXRMNUdNSFgxdkQ3?=
 =?utf-8?B?WTFITFBFT0pYTlhydGQwL3FWa25ZWEJKY0VVWVZZa1M0amxlQytTSEhGMHRV?=
 =?utf-8?B?bWxCZXV6eFh2bTBrVzRZQVZtOU1Sb1AyMXBjUG1Ed09nSXhEYU5FUVFMN3Zn?=
 =?utf-8?B?Rmhha3E3bVlkKzlFTUlaOE9xTmVjdVJpblREdXhoNmpPK1VxK2d1MWViZHZZ?=
 =?utf-8?B?aHJtRms3RFZBWGhFQnRrY0grR1BjMDBZM0h0RUpSczFJM1FRbS9nN2N0SGhp?=
 =?utf-8?B?Vm90OGNyMHJIKzNEbi83bnpBcXJZMXQ4aHRBNUpoVFFJKzdhbDlHYVZOZ054?=
 =?utf-8?B?UE9FL1dUR3NjbnR0SGVGK1FSRXBxT1JpSStZcUZNaUxjTHlnR0lHZUlPQXA4?=
 =?utf-8?B?bXdvd0NIeGVFMmlHNzFFb3gxUUVKUDlOcTFwLy9scy9EL0JpQUNRMEdna0Q1?=
 =?utf-8?B?dS9zQ0dxMmcvcUJOWFlWTWxyOE5tWnM5dDQwUFlOYUFraTd2WlVWajlycEdP?=
 =?utf-8?B?dUNIdFB3TjdnNWgyMFNXamVOVEN5ZWk5YjhrWXVScS9MbkdueGxnc0ZiN3pz?=
 =?utf-8?B?U1JrK1pOOHZxWWFvbTYvSnRBTlE2MlVCNHFydmhyYXZLNmlmbkhMQ3dIZGkz?=
 =?utf-8?B?REl6QUdlM2cyaCtCQWxSZkN6OGtSKzBkcFNMVytlSlBpM21WTS9BaVArd21J?=
 =?utf-8?B?L0VPUEJPUzV6M005WlQ4djJXajBiczBSK3h0a1Jza1pyKzZ2NWxnaDlJc1hy?=
 =?utf-8?B?UHgxNFpzMldRb2huSWpJK09lNGtZZSttaDZidzRvQ242dmZPVElXelJPY0lF?=
 =?utf-8?B?L0F3UFBDQjd3d2k4Q0N4enQ0ZW9sRVROQ3dsdytOcmJWZUZVOVdKYmFwM2s5?=
 =?utf-8?B?NUpQSGlEbEd2WnNacGtCNVExeWYxcHQ3MmlhSi9YeDV3RlNFVU1lNDVhaU1H?=
 =?utf-8?B?WExRT0k1UnR6bVArdms0S3FRRXhnUjF4SWZReWRUNTBPUzEzNStWUndYNFJG?=
 =?utf-8?B?bXVXMzBxOE8zSTgwSm9FMmRKQjdxd3A4ei9vRDUvRk1mN2o5cUhBNVVtenRE?=
 =?utf-8?B?YUcwbnBJRmNBOGozbk5zcytMTDB0SHlRaDFXc3NmYnNpd2g4bnppT0dnbkNo?=
 =?utf-8?B?T1dBYlltWk5iQVkwMm01WVFYbklRYlJnYUdLaWhnTXpZdVZ2dFBwenYybExK?=
 =?utf-8?B?KzVYSFZKUmpHa2k4TkRRb1NEUG41VDl1M2VEckpoRHNST1ljQldDa1puSzUx?=
 =?utf-8?B?ZVpSZGdLUUF4SFROaWdiSlZrWmc1RWloRVVsS2svTUNHakVCT2N4eG0vaHB5?=
 =?utf-8?B?VzAzMFRUeGRvbkVPcFQzQ1NNejM5eVZ1aTBqTDN1dytCd3J0N0dGeUJBQlBq?=
 =?utf-8?B?cUdLRWtIczIzbDdwL3JOcm9vR2RLNTU4RmlzNDJmWFoxajBEVG9Rc3E0NTNv?=
 =?utf-8?B?UEJVVVhYM0NYcW1YNk9WQ290TjNNOWRyYW1QTzNQVXN4T2U3U0Q3aGw5TjV1?=
 =?utf-8?B?WStmdzJwcjN0ZDVJT3dQRUk5MzF6NVZZd1Jad1QrTE5zMjhnNnljU1U5LzNE?=
 =?utf-8?B?M3pMM3dkSXpUWVpHWlRGUVU3TUdYQTBBd3ZTYzVudUV1QzR1VU4vdzcwZWZ4?=
 =?utf-8?B?Y1c0L2c3dW1XT2s3T1E1ZnduUmxzbWQxTzVQVmpMcFFCeHQzc21tcUFmNThT?=
 =?utf-8?Q?HopnbOKIrItgc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODRIVzBhRWQyQk5aZlZlQURISy8vWWZ6eExjbW5oWVV6STVUajRRcVJrSDN2?=
 =?utf-8?B?cFgwNnhoeEFPWHR5dVcxb2pzU0pNK0VGbzFFdkx3RmJESDBxZ1Z1U3A1di8x?=
 =?utf-8?B?bUxTNmxvTTVkSnhDeVJJNVJIak9xRzYvVGZTUVFJcSs1V2d4NW9SZldqZFVT?=
 =?utf-8?B?cjVsblFKdlREeWIvTFN0Sk83dVV3N2JKc2RKSHYrcUpNcVp4K25QaDYyTm80?=
 =?utf-8?B?VTRTUmY5UTJIT2xENktTaGtYQVJuUkJkdFJzZGhtN2lXVk5oaGdTK250L2JZ?=
 =?utf-8?B?eXR1YkxLTnlMNHh1czJoNlNFTmhrS3IzVlNHdEVUMFFsVURKYkZWSEQyZkhv?=
 =?utf-8?B?bjRaTkUxcjRZUU1QVGlYUWlrbFhCb1c1YUlGbU55VTZ6TDZWUUw5NDlMZUE1?=
 =?utf-8?B?Qlp3UDVWYmEzbG0zRGdGNXNJQXkvOUJSRTNtRUp1ZSsxUE56cUMwMXBJdTgv?=
 =?utf-8?B?emR5SlR2a3h0VHQzdEVPMVZwTUhMNFJmbE9aVFRyd2dBeEgrM3VDdXZCNk5a?=
 =?utf-8?B?d1BZejdqUWN1WjFOOC9aTjhlMmt4Y2h6Rm55eTFwRDRMb1hpcUlrMW9MKzhU?=
 =?utf-8?B?RXhOc1JxeEw4OTBkdEhhOW9td2RXOUtneFdWUGJFU1dBRmRXSGlKYkgxREtU?=
 =?utf-8?B?WElTSHB5dHYwTUYxUjFPWkRJMzIyV3huckFHYURablNPaGFSRnBxZ2R6ODk0?=
 =?utf-8?B?c1RCQ25PbERrSEwrUTJWUG1IVGhsejluczFUS294WitDdFNRMkNKL3lHRzZa?=
 =?utf-8?B?YTdTdTRobzF5Y2ZucmIvL2VBaDBPY3hKa1N5M092eWx3TTgrWTdESjFnbUpZ?=
 =?utf-8?B?K3NLVGNGUFhIdTFZd2lQaTlPYzFGSHFuTzk3TGNLZ1RtVWN2bWU2bXc5bkNa?=
 =?utf-8?B?SGlidEJCUlpHc2RFT0UvL1V5czQ4SnlWMTQydnQ4Qmd2ck80WmhVSkZSTVF5?=
 =?utf-8?B?TFdoVmo0WEh6V1A4WWtDelc5N2RPSmE3T3l2bXhlK2JEQ2FaZCtMMWlaMEp1?=
 =?utf-8?B?UDk4SWxpSVZMRmZXb2s1Q3FKQXBCUUErUjhtN1pxblo2eWVQVm9TK0FRRk9R?=
 =?utf-8?B?K1JzVFcrM3BtdUlubEhzZzJTYk9GbmpwSDZMdDQ4dGNabW5Pb3VTM1dWWGNx?=
 =?utf-8?B?N2hUQjM5R25RalgxdDEwNnJaRTd5c0RNZFJyR2tWMEFqaC9LTUtMV3ZJR0JR?=
 =?utf-8?B?aCsxdHByZm9BbmhCdWsycmUrZzF1UGFzakExSlFBY2pPcFExRkliU055cmtN?=
 =?utf-8?B?b0h1UVE1a0svMUpVZmd4aDBSenAzMC96ay8vR2M2VEZ4MjNsMlNhZnczbVdh?=
 =?utf-8?B?REl6bFBkTWNiV2JFVDV6cWpSb2U2bGtPbDhUTW9wUmNOOFhCSnZkb3IyamxC?=
 =?utf-8?B?SVBkejFLTG9HVDRaaHg2VVYxK2dTK2RXdXZsa01DZmxycmZIVkZyYjRHSDZo?=
 =?utf-8?B?bmdLclNCcUdFOEVnckE1TDdWVjN4VW5JU1JoNjFEVUIrK3FsaUZCRjdVSE5n?=
 =?utf-8?B?TklFUkpMalBZTVlCaHJtTDRVSzQ5OEFuTDRkNzFUSERsSHY0NWJBSEFkU0p2?=
 =?utf-8?B?QUxQQzVvczl1WDZGS2lHbkcyeDBwbVhrTnBOLzg1UUlIOUJlUHV5aG1peWtG?=
 =?utf-8?B?SGFORk5sYW0zQWppNE5pOEtFeU5SczJmb0prOE5LVDF0aUtmYTdxOGhKanZU?=
 =?utf-8?B?aEtuRXNMcnkrek1vemoxaTM0ZlZCT2pSbzNicmhYdTQ0cW5QNmVvM1ZCK2lT?=
 =?utf-8?B?T1ExRFJGMXdRMnBKcGNUemtHaDQvZGpLZVE1akJQczF5OFk3Ujc5NWN4K2F5?=
 =?utf-8?B?em9uZGxiTWd6bEtlTThQOXRWSGRwOFA2bDhOSytMTkVqRlVvK2syM2pVUjZt?=
 =?utf-8?B?Z3YvbTBPdDQ2V3BjdmZiamRRQzVUTFdBOCtQeTZ1eUxSK29lOG95bkgxY3Ur?=
 =?utf-8?B?TS9GQWdlbEtaZEJXc1FCQlZQcjNWeDJSQTNabHQrU2V6ME1ZOU5FQXoweDJY?=
 =?utf-8?B?Wkp5TlVvNjY1c0FWL1BMWGhBZk91SHdXWWxVR3VMVHNJUDZGYy9YanM3aFJ4?=
 =?utf-8?B?MVhqVmhaclFGZG14djc4NlZYcERHNzlLTVE4OUhOeVAzSDZoNnVMeGN4aXB5?=
 =?utf-8?Q?dTJP/DKpzPHgxSPvNRk0ffxSX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c9520f-7817-4780-4202-08dd5a7925cf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:30:52.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43Fiz6n/PUvE3WstJqPIgjRCksb/GvSFyvBpi9DGL/eawlDwOMZqln479lyW008kpyd6M+0E63vckPVK5I1DJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458



On 3/3/2025 12:07 PM, Boqun Feng wrote:
> On Mon, Mar 03, 2025 at 12:00:40PM -0500, Joel Fernandes wrote:
> [...]
>>
>> I see the original patch "rcu: Fix get_state_synchronize_rcu_full() GP-start
>> detection" is not yet on -next. Once we are convinced about the fix, do we
>> want to squash the fix into this patch and have Boqun take it?
>>
> 
> Which "-next" are you talking about? The original patch and the fix is
> already in next-20250303 of linux-next:
> 
> 	https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20250303&qt=range&q=153fc45000e0058435ec0609258fb16e7ea257d2
I see it now during manual inspection, but I'm confused why git cherry tells me
otherwise.

I tried the following command and it shows the patch in question in the first
line of output. Basically the question that the command asks is "What is in
Paul's dev branch that is not in RCU tree's -next branch".  This question is
asked for the obvious raisins.
So I am obviously missing something in the command. Thoughts?

(rcugit is the RCU tree, and paul/dev is Paul's dev branch)

git cherry --abbrev -v rcugit/next paul/dev | grep "^+" | cut -d' ' -f2,3-

012f47f0f806 rcu: Fix get_state_synchronize_rcu_full() GP-start detection
2ada0addbdb6 tools/memory-model: Add atomic_and()/or()/xor() and add_negative
e176ebffc3f4 tools/memory-model: Add atomic_andnot() with its variants
de6f99723392 tools/memory-model: Legitimize current use of tags in LKMM macros
723177d71224 tools/memory-model: Define applicable tags on operation in tools/...
29279349a566 tools/memory-model: Define effect of Mb tags on RMWs in tools/...
d80a8e016433 MAINTAINERS: Update Joel's email address
fafa18068359 tools/memory-model: Switch to softcoded herd7 tags
dcc5197839f2 tools/memory-model: Distinguish between syntactic and semantic tags
fa9e35a0772a tools/memory-model/README: Fix typo
a2bfbf847c96 tools/memory-model: glossary.txt: Fix indents
3839dbb05869 rcutorture: Make srcu_lockdep.sh check kernel Kconfig
b5aa1c489085 rcutorture: Make srcu_lockdep.sh check reader-conflict handling
9a5720bad9ed rcu: Remove swake_up_one_online() bandaid
04159042a62b Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
fdc37fed1c81 rcutorture: Split out beginning and end from rcu_torture_one_read()
3c6b1925361e rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
fadc715785cc rcutorture: Add tests for SRCU up/down reader primitives
90a8f490324c rcutorture: Pull rcu_torture_updown() loop body into new function
5fbaa5179f6a rcutorture: Comment invocations of tick_dep_set_task()
461810471faa rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
35e1a180319d rcutorture: Check for ->up_read() without matching ->down_read()
0676ba797dfa EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels
c8fff13fd2fd EXP rcutorture: Add SRCU-V scenario for preemptible Tiny SRCU
910a5f9ebf5f EXP rcutorture: Limit callback flooding for Tiny SRCU in
preemptible kernels
8979a891a365 EXP hrtimers: Force migrate away hrtimers queued after
CPUHP_AP_HRTIMERS_DYING



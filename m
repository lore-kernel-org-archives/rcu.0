Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7585155A4E
	for <rcu@vger.kernel.org>; Thu,  1 May 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746102339; cv=fail; b=Htywx08n1hiW9wyvxy2oDcfm/vwdYA+AwdJMwZpNF1WFifM8uQdnoRGyZdl7CFgbHg93PugiTp0VRoP0RIKh50orEKp1gSWWvagASEn97GnB56efrehhpp44ZR2eo7x7EPR5HCO5SPDAK1aDzn5TkjIdZMCUN5ksBTxkLcnS8y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746102339; c=relaxed/simple;
	bh=/AvXrOiJIMxuWfmNpyGayzTh7Z290eLtm+gdKfnDmro=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=E5IhLxP4vdwne0MaplQrPaQYpY3ff8RST2Kkz06lwVfjZ4i6QTpun5W12LFDf7f/kjTmYziv/FgG5wGG/5CPPdUvScYNFiwFQ5+JbZ1PRgKp8nZLeY8FbTi4ajRKbsuOkNZom6PwL4vvKuZMa2ZP7IxHzkZGxsLJzXfgCNvMwMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsSP1gW2; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsSP1gW2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2D3p6HvvM+7/RNt3Yt5CxN7pRZwiI8p0kD9gZDp8DAusjBmj7zy2f26M0arWX/r+FwZSY6o04Q0VyNgmqjzl8OWmys959ldseJTE0RUVKbhajg99MP+/Br0js7XQ9+KlVotWqy2LZy9ULGNnFG/1flwgERj85H57HcdCwK/c/dN0GvPF4LvXnIa1fIbyvCoiYw6C7hwlY6MBZk/IzBdHwear0SmY++TFpmxW2CUwM5jdIvqnJJB/GxfG1DAtM2sBneMn17VfRP3JTt52tQhsULWIOKPk1riU+HQdnweZkU2zJPCOQ+hNcjMyDTYQZi2U5fKCAq9i6+zPULoMyjHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wFKqkabTBlDGlNHc/2obTSlsfl0dwWAKUPdFU+wUdA=;
 b=Nod0YzAbA/NdFrhExNkB2snSXKltFMut3TYeTYZFnmrUdsxhmUEX//OkddPmHSwiJWYcUhRoyztzg1CSzj0R+WYa6D7NrmKF/hiHv2Z/e6ORgvrzuZfTJ8JbRkrGtsfq045o+D7aTiY0RMjhWHfR1bWn6IbZ169/M/GqMXfE+inLaorDQSMLtYgq5CL+2JmM+b1jcyFM/bDWs0O1OiTLuAenSnXojHMGMJBNVgQJ/kWEfK6qjbZiTr7sB8zxWT7vG6iSXoAauDPqXCntS1TpmQg8DafLd0ChhN9eqQ34PSH48tNYmGq950Ne26l8ISGjPDz6YgmBYRTA3LqKQKORdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wFKqkabTBlDGlNHc/2obTSlsfl0dwWAKUPdFU+wUdA=;
 b=tsSP1gW2qZI1Mk0VsW8Kbz7tM1svrxb/2bs2E6Iz6sILb5hURr8/74UkZNQdPhXy6na5GKzFyNGCDQv5VqMPo1wb73k6acCtD+eiM1mUak9peCf/4wUXxS7QMlSlFzNGylGangg//82cgIvPxbO0SyjAcULiRo3Rgei1ax/LVhQMlDrPE5qPgP7wP5Iv+3s3iWms1DNkBV8b52zBfhTow76LVVCmDnqYDPf2Y7/NyI7fH6kpnsDgyvE56QplmKRBdsNnhJOrgIEZOMVbbh32lpHwVUJn4tpOsqCN4OAD/+vndf9rzjfmtUHiuinwtz1udLoqoPijH5qFtkWxdh80Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 1 May
 2025 12:25:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Thu, 1 May 2025
 12:25:31 +0000
Message-ID: <ce1f98cb-265d-4415-b9a2-39c9d4116af1@nvidia.com>
Date: Thu, 1 May 2025 08:25:30 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rcu <rcu@vger.kernel.org>
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Overnight rcutorture tests pass on ARM64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 105f29e6-9586-42bb-d488-08dd88ab438e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODVXaU9CNGhHdEtqTVlCWk5oeWxMVjg4S0l3eWxRRkJpRi9ma2dPOU4rQ2lX?=
 =?utf-8?B?SThnYVJCMEFsNU9XMlk0M3lUT1JKbC9rYUY0akd3bDZWOWk0QlVRZjNHcFZG?=
 =?utf-8?B?K0JNeTVvYW45V01OcDg5WktuZ0lycEd6OU1JWE1XS0k1QytoaWUxcytBNm5S?=
 =?utf-8?B?eUNVZ1BNVGxBKzRVY096UmJsY0ZNU0c5U3dTZzNzNitLSzZuYkZzUG5jeHI1?=
 =?utf-8?B?RGNxK203UlRQM0pSNkJFcW9QRys1a28vRVhneVBJREVKZVYzS3N0QUY2ZHpr?=
 =?utf-8?B?TWhPNFllV3lWYU8zelh3Uk8xc2U0ZElMMkZsMVlmakNBVTIzZ0FlaDRtZk5C?=
 =?utf-8?B?czFTbWJrWjB0eHVNOXZCaFFrSXh3Q1h1emQ2VnZkSlIzbklycitVbG9TQ1dP?=
 =?utf-8?B?aCt5TnZKTVZ3K1lWaURMMXVORmhrNVBkcEI2cDVmaTVRMVJPeXdoeVlQWFRo?=
 =?utf-8?B?b0k5YktKK1F6cGs3bDh3Rmo4V0JvcitwdWZOSDdnYWtDVHJ2T2FseklNbDRo?=
 =?utf-8?B?TUxVSEZvU08zeHcxQWYwN3gzNkZ5RHduYXhXTlNiUmNTOVZDbUtmMjBDRFkv?=
 =?utf-8?B?dGNKREcwN3hEemJlOUxhUDV6VEgvL1IxMm5DdHZ5Q1RJY2JOZkNlMW8rallu?=
 =?utf-8?B?TDZVMlFVTU1STFFDWExKakUyS0xvN1NNRHhTNGdUVFVTaCsrbWlndVNBb2ZY?=
 =?utf-8?B?MWZ1K2dQTjFXU2RlSzdxZ21hODVMd2lBSkhiMXdvcWRGdTB4R0dGQU9VK1V1?=
 =?utf-8?B?RGNrQW1wSVR2TzFleDllVHljdnRsUFBsUmlWak16N3Y5NDFaVW5BSHdGTGhw?=
 =?utf-8?B?cTVSaUMzcitJenRNdnJKbEsyQWJVdHVsVUNKbXFZdEJNcnNoQjFIRUpSejlE?=
 =?utf-8?B?UWJMZjNQU0k1ekx6OXdMVnM0NEJkQmt1MjZRR0ZHYndTN3BHWVBpb2ZXTEF3?=
 =?utf-8?B?dXNFcWdZL0RsVHBBMS8wK0VGMDFLMS9paWF3MWdhRkdkNlBCMzYraXFIcnAw?=
 =?utf-8?B?bmxkeFRNRXVVWVF2b1BqYStrRzJENTNqR1RacXZaSG5XOExKOERENDlEWWhr?=
 =?utf-8?B?NVJkcEtOelIxZ2J4Wkg2OUx1VFR2cjRuV3dXY3FDY001cWpVUUt2cDQxbkpp?=
 =?utf-8?B?c09xeGk2QXUzSnJ0QlQ5S3o5cFNVRGRYalhyMlVhTHgwcFpxSkwyMU5uMWRv?=
 =?utf-8?B?Q3lPZWwwY1l0OXhvNUlHSnJQTEtDRW54TXdkbkE0cm5VcUNnclZhUStvb0RY?=
 =?utf-8?B?OEN4WXNlQXVIL0NLTUJnL1B2amI3OFIxcTgvY1U4SnV5OXVTRzRkdmZtT1Zl?=
 =?utf-8?B?dUh3MC94SHJxMERxWnZhYWZHVTVLeE1GZTFXamdnMGM4SGpCTEpZSVFXZEdW?=
 =?utf-8?B?b1FzbG5GaTM3cWMxdFJpK0RCKy91Q2x4MnFNdytuL2piSmtEcy94WElNeUJx?=
 =?utf-8?B?L0JLOFNzWi95NllRZDVXT0d4UHVXRjZESDFUbk1OQVU1VjlNWkNDNkhSaDJs?=
 =?utf-8?B?dDVVd2tJV1JWY21SRENxRzdsTTk2aDBIb1FjeHRQam1tSER6Smk4eFlxRHdZ?=
 =?utf-8?B?c1A5VGQ4dVNyc0ZQRmtoZUc5VExWbW9Da093UVVtaFBCekxvcUxkK2FXR0Zp?=
 =?utf-8?B?cm12YTduekNuWmpNdTJqM1ZOSURPbFJ0UTBKaXN3aTlxanNHdGplSlNIS0pZ?=
 =?utf-8?B?bTBBMHYzM1NOd1VBZ24rRk1sUWs3ZFYxc1Z0bXRqMk52VXpFNUNTaitHRmZG?=
 =?utf-8?B?TElpOFBKa3MvZEN4VTBWNVhobkNwOWM0SFpNUUY5MHJlVjVUbEY2VkZ5bHpt?=
 =?utf-8?B?UFdFVWIxcE9oNktCdyt3WkFIdkNyWG1Dd1FSNDlCYlhPZkw4RFdwemMyTUlR?=
 =?utf-8?B?S29XcjJyMTNORWljOGRuSUZyYW54ckhqSUtDcmF3ejk4Mjc4cVRaVU0zZmV6?=
 =?utf-8?Q?9OKV9ON0hyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVBKRTJYbzQvdVFnUzBSa3loa3puNk0rakp1cTE0WlcxMHFnMitnN0d0U2l3?=
 =?utf-8?B?amRmY0g3OWJHTEI5YkJxR2ovZGJpRGxiMFd2TjB4ZFdJdE1oY2Y1NkUvdlNs?=
 =?utf-8?B?WXI5Lzg3M0cveWthR3Y0ZFkwMVl2NTVMdmYrSi9sZkF1bURud2JYQ01rR0gw?=
 =?utf-8?B?cmN6YU43aHh1dUdSb3hFVGUrRXlFSXVCZUIrRUd1Y2IyNUx2cy9GOUdzVGFs?=
 =?utf-8?B?S0VtSndLc1N4NW0yM1F6NWQ2VWplTW54Uk1SbjFTeGpyeEVWOVRvNFdGbTZP?=
 =?utf-8?B?MWpnditwTFEwVk1JN2dLdUY2RW84a3pSSDYxRUQydGg3dnFjWjNsU0RuOGxZ?=
 =?utf-8?B?Z1hveHVjS3c4MWVrWDdVOEtlcXE5Q0lTMEJmT0h0cmIvd2c5allRTWd4aHVJ?=
 =?utf-8?B?Y0s0OGJyQXNBUUIvbEVoSDlvYUs0OTVXWHFOWTVUNDN2cXNEVW53NXloa2ZG?=
 =?utf-8?B?SXQxblhrMmRXUVVrTnUyR3VaTWZWcXN2cVlpR2Y0Y3pQNWZOSkdOU0U2enk0?=
 =?utf-8?B?UzRZeEN0OHNWWkw5bDU4eGhlYWloaC93dFhaYmZlcWNHYjM1QXMwWkt1TVVN?=
 =?utf-8?B?Mk9pQTFUQ3VtTGFKWVhjeXVkdlFLSXMvREJoS2t3QStGOGhtaUZSODFIcGxY?=
 =?utf-8?B?bTVNY3B5Vm0razBQZEw2MnQ5bmVCbTJmRDdNMVFpbVlYcTN6M3daUmhvd1BN?=
 =?utf-8?B?WUNSbWVGRzRiUlJGVzF5TWM1SFBsRHN1MFhJZU5vd1JxdFVHMUtJRHRUZ1J0?=
 =?utf-8?B?R3RYTlhmMGxkZWZjZDhzNk1laWxKWEtaNnU0VEs3bEwzc2F1aFNLZDhabFVJ?=
 =?utf-8?B?Ukd5V3h3bHlyQ01WZGUyWWp1VGtzOFFWUGNjWU9VWFdmbGxpcUc3eXduQis3?=
 =?utf-8?B?N0Y0MFVJWFIyd3MvV09WQkU5Ujg3Y0RrdVBMVytDMmhVcjFOWjVydkFHNStW?=
 =?utf-8?B?UE5zdUhUd0gxSWdYZS9lak1yTG1mR2JGY0VmaytHOG10WHMzeDQwTE9oN2sz?=
 =?utf-8?B?QVlVb3YzSlFrazRlemIzaStqa01YM1MvajJaV2FKNU9WREd6ZWxYRjNERVFG?=
 =?utf-8?B?UEtsUlk0WTdMVkFjeHc2emxmQkU2alZZSjJMOEcwbVBZVzBERm1HaFppTHVq?=
 =?utf-8?B?TytuR1RDU1BhNHY0K2hxSTJVL3p5U1JEVlZnSHFlQndLTzk2WXFLeE9VeGEy?=
 =?utf-8?B?UWNNdmtXY1JRd0s2dWJSTzdPdXh3QzFrYUpwNFNyS3ZUYS9XeUl5ajFYMTVQ?=
 =?utf-8?B?NHM3YmdOYjF1UEdZNnFrRlVkblM0TGh2ZklOMVZVTkowYVFBajgxOE5QeGxK?=
 =?utf-8?B?dFBjODB3ZHRRUUpvYURnMG1yK3UrWS9KbndFKzEraUh4RmdtMldtbkVGeWFL?=
 =?utf-8?B?ZUxRY3NzTXJGYzI4TG9waGVubkk1TTdhWHY1ZDROSklyc2FEeFYyeFVsVElH?=
 =?utf-8?B?VXp6bEZOMzk5OXNuRlhyRC9tek8yd0xMQnduZnB3eFBWU1BJMnJFZzJMYmhY?=
 =?utf-8?B?Mk1UL2pIcDJseGFmYjUzak9sQ2M2VkMrRUZKTHRiWGNUdnhadVc4SkFNWUtR?=
 =?utf-8?B?UUlGRUZUTG1rVzV0RUY5MjBGMFBvVzdnSFh0NHBnZDNhSE4yeGdWdE1CUmxv?=
 =?utf-8?B?N3lkR1NMWThXVVhIQVhGYlZpY1ZWb2FDN2tmT1Y3MDN1R0QvRWZWUDBtK0NV?=
 =?utf-8?B?MS8weTRUVmRHS3pLS1lScDY2eGI2bUN6eDVZZUl6TlhNejJWbkZtM3prZmFk?=
 =?utf-8?B?WW1DYVpQNnF2UEkzem9OM1hlT0JMb3RzeEdBd3N1dWQxVjlNcTd5Mmp0WUsx?=
 =?utf-8?B?TmJUOG9wejRzRXBFSHJiMmdqSlhiL0NhZHNFVjVmVE83WFFiZVdoWkRudCtM?=
 =?utf-8?B?b1IvZWpnTDRBVk1aSXhPV09FNDlwYU9MS3VUWmJ2aXk4aFVKYmVIUXdCZG52?=
 =?utf-8?B?dlhXWHQ1L1IwdEtXZnpwR25iSkdpWHNHODRGSGQ5ZkNUUC9XcWJMci9TOXNB?=
 =?utf-8?B?U3Jtb0c5Rzg2SzcyZEhpVkFPQ3d2R1BkM0NneWUwekQ2c0RzZHF4L21wK2JR?=
 =?utf-8?B?NHdXWi9qaEVTalEzd2UwMUFiU2t4MEZScGpWeFFqQWJEVmxTc0cvMUthRWwy?=
 =?utf-8?Q?AspHm/FH35T0Bnu01kPWx/1ej?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105f29e6-9586-42bb-d488-08dd88ab438e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 12:25:31.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UBSslxeYzZtuJZdOmx01DbMxVIQPcJsYA4nFaDuNqzxHGSQzlHfMMgElU4yERz3oYenmv7sRvCMt4h1ovpFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

Hello,
Just want to report that my overnight tests on [1] with rcutorture on all
scenarios are passing.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
    tag: next.2025.04.29a

 sudo ./tools/testing/selftests/rcutorture/bin/kvm.sh --duration 720 --cpus 288

As such, I am planning to freeze new patches for 6.16 (except for maybe Z's
patch fixing the nocb warning) at this.

thanks,

- Joel

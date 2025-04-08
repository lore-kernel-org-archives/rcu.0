Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7A2185BC;
	Tue,  8 Apr 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149925; cv=fail; b=Ks+Wkdq/uKoZRtZHI6O+sejWaNRh9okcsYs/zYTdK8WWJKrQ6jg0Bo9zkzOpthzm5HIShDowCSiBr9zgKCm/oV80rnL+m+dXRJSuJ0WnMBwBIqAXrsYf5cIxbapWhoVkVvZKmCqZ2Dd34oO2rPU9Dw17xuxSeEqsx8uP0IA6dxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149925; c=relaxed/simple;
	bh=J+w6LUC/mydHn1pp/67I6hrpBrGLLPDOl1/MqSgcXlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kqTodLJAXdPHmjYGjCLupoQbj9Rywqnuv7p1vu8SmSPhyf/qj9R1fs/j7NueHTVNLHI/EwHfnIQOcp3LNzC3fqKd5K5ldzkyYO0zxkiwvCJKorfsbUZWf6RxSasD0AZvktp6wFVZD6XXcRrYZ2LyT2Mkayh+Gt0timE6g+I0yyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqNSeLHC; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqNSeLHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft4g9VRVfCuUcyRVdeXZbLhJkxiBXVkESc9L3lm8V7UqUVfexYGHJ1BVXt4QuFHBpt5qAQ6DKDfH+kJiQ7Ma4291q7GlOuBu/nGI1F8zFHrbrW6cYXMWJQJFayTpJOyQTqAHS0uncolmT4oz/q0jbkoBmpLuJIg4XHQlOn6uZSdeSs30quO7mNywt0zbWAZlc+2l+LL7U1iRlOzCX2svLHRprvzMeDYWfX/L299inHWv3T9uhD9zgS8J58acX1khXCoIAs/tGXEoSa7wEexOiJQ5LBjl8rIas24idkNuFY7fxOrvETFlgBKtJuXP5ELCAYKORfoCx85+w+DAmmoKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lklTDQVcd7xqlFm0zfzcuxdzUl17yhmThGAToM3BeP4=;
 b=qrDP7LoLccpkiwNpeILYBrG7cL1TzMfLS8yK2723FNvJxlYrSSB8SGDBrQ/BWb8bfiLCVDc0ENjLixmUcfEK6f6xwUgCFncSZXSwy7jObogJNDX5gMcykVA87JQQJgEWxSlKFcW4bz+puz1Of7+T3iTe+XBJOMoLxwA6bXZSpucfXAacV4+chPcopc81Sns/5GRRbHVg7fi5zIHyM95Vd5+TV19WiDAkS0b1r+qnQnpO/SVBq3tOp8XgyoRn9H7ot+d4DPp5fLdp+T6BiXv2wtHA0tKLta4IcFEYk+fzzQeBT3QVTlrDF4TVzVYSf+NPcJdbUZ51xzRvQeXTYQDJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lklTDQVcd7xqlFm0zfzcuxdzUl17yhmThGAToM3BeP4=;
 b=aqNSeLHCjSltMzx5ovbdkLm64O86BOZpzrcNqvpRynk1XNyc7m2VEMtrscDrtL4X1HgrPNtPxa8rgwXGip9ZspfLp0xbY0y83f+b2+8kcG9nLqBq2SNyZmexMWnM1tIPL/9/4PqED6BVqzOjh4kM6wqjr4z2jyQGFKzi+HsoFC9xWTLMzIA2co4aHb1Z3dy2RTF67fUz8dx7Xic2ndbM5fcFO+yJPu29YvI6ChZ7ym7cJJPCUOGc8+yezndK8FqfdRGom59wmFHCec/rG7VD8Tq2x2YCWHbCytoV0ifQ7He/o6xnd2S/051hL9v5JqStzuBHdULZGWFL/J6Dw5do0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 22:05:21 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 22:05:21 +0000
Message-ID: <702640f3-170c-41be-861c-7ec436a02dad@nvidia.com>
Date: Tue, 8 Apr 2025 18:05:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
To: paulmck@kernel.org
Cc: rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
References: <20250331210314.590622-5-paulmck@kernel.org>
 <174414348524.117.7223153072511748144@patchwork.local>
 <8ee04d0a-dc22-4eb1-8c22-1777f94fd9fb@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <8ee04d0a-dc22-4eb1-8c22-1777f94fd9fb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0035.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7165eeab-cdb2-4e22-e8eb-08dd76e9749f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDd3eVFOVldVbXVEeVhqd2x4bW1FL0JjcUxCa2dnaENGekozVzJ0L21tQnZx?=
 =?utf-8?B?ODRtK1NUYjRBeGpZaUVWVk9LNER5S09FSUdoZU5uOU1kckMzV1BXU0N1WWZ2?=
 =?utf-8?B?SXpXeFArVE5VbWFRczlsanFOQnYxTmF3aUd6bDZyYVNGcW5FZ1p2cFBZVXlB?=
 =?utf-8?B?STZUUlB3SHc1ZDJzcmEyL3U0Ym13WjQxRzNQNXM3WnprMnMweFNhT3BxZlN3?=
 =?utf-8?B?ckw2Tk1ONkhKUmNXM1JuNWRhLzFkcHZ1OXhxcGdaU1N5VW1BblBSbEdSMVh5?=
 =?utf-8?B?SkRHZUswdFkveEZxc0h2dmhsTnQzem1RdndWT0lRaUZmckcyekxqUXBPV1Qv?=
 =?utf-8?B?aXpJc010MkhwR1hwcDNPOTNGcHU3c2hsb2lXVWg2TDF2Umo2Z1JFVEtJZTJ4?=
 =?utf-8?B?OHRUK3ROMlNCUjRLMVY1MW9jb2ZPZk94UEw4ZFFUS1IyVEx0eXl3QzN6aEVl?=
 =?utf-8?B?L0ozb1NEdzR5QkFKQVN5ekRLb3puaDBMMVErQnBtQzRxc1JIL3E2OEJVTUNt?=
 =?utf-8?B?Rzhia3pKalBtOUszKzZhZU83MnVKc2txN0lGbEc4UTl2RDBndzA3bDlIZ041?=
 =?utf-8?B?eEU5RnFBTC9PcXdmaXlaVVVObHB2MlZKMkpscmc1M0grcW9yblNlTEpXMHpm?=
 =?utf-8?B?cFBrQ3hYTTdla1hLYUJYNDd2S09rVGlZUWx5MDBRL1FHc1cvcVB2OUhvRDIx?=
 =?utf-8?B?bUI4dnNxcDdpbFZPdCs5eDNLbWUzTXh2aVRDVWdDeHBNRHoyYkk0akpDUUp6?=
 =?utf-8?B?TEN6SUZFZGRWSVlyWk1Ga2JrYU1xZE5LTXdwaHo1SzIyUmlGaHNmVHlLZDIz?=
 =?utf-8?B?OS8wN1ZrWFJpNDZYc0hoWnJONDBaOWpsUWRQK1pIOXJNMUlrOXYwdEdOTHc2?=
 =?utf-8?B?bFhtM2lja2p4Sk1VZXFieHhHaWZ2VnBNY0F5Y0h4dnAyYnlYQ2ljb1RkVi9P?=
 =?utf-8?B?T1prZmFWK1U0ZWtPM1JHWUhtalhpSlIxUWNobG5Ia3FtV2hxQ1BxYW5MZTFt?=
 =?utf-8?B?WDZ1cnFsTVF2SEpDMlJuRGRGemZhcGx4cXlYcU9nT280d21pR095djArTXNN?=
 =?utf-8?B?WTE5RHNHcGpkN21IQzBrdERxdGcrQmk3TzNFcFlGSFluVVJlNW95bXBDRDA3?=
 =?utf-8?B?Sk5nSjE0QTlrcmRxWEJIdzdYY0plbVJGUUkvU1hvM3JBVmxMV2hwVDBkT01j?=
 =?utf-8?B?S3V6anNCQlV6bUZLWWtKaFBJdjdrdlppTno1Q1ptaWVSZmRFUVZuTys0dGU4?=
 =?utf-8?B?V0NwS3IrV05YUG5zSko1aE5zRHJLQmdYMjBBNWJyN0dyWm03ZnVpZjdSd04r?=
 =?utf-8?B?bEppOWZqbTRpOGN3SWVWWWNLakE3N3BQR0ltbUJlYjVBWWhWa0ZINVZyVXJH?=
 =?utf-8?B?LzhzbXhLTlVkWmdnaElDTUUzVlJKZlFNN3lHQVlMY1ZPTEFkcSs5cHBVUU90?=
 =?utf-8?B?UnJkbzZ0RkJZWktETXJFQ2czM1lkVTN0QzkzOGZCeG5Ic3BtQ1BKUldFTnVk?=
 =?utf-8?B?OEpGOFZXcHdqWmJuU3Uvd0lRQndSYnFGSTl6QUtXWkxOSW1nM0s4ZmVaQWQz?=
 =?utf-8?B?anhqaitIOWVUb0pYSVdwTzg5ZnFpNE92QU5WZVpSK3plSWRHTG5jTEh1bEFt?=
 =?utf-8?B?VHVWRS8weW1iYUJWeUt3OHRyWE02eG9wbFFaMUhXanRsd1pTZmk2emV6Rkdr?=
 =?utf-8?B?aEMzYmxHU1UxbTN3RGNyNGdaZXZjSlluVzhhQ1duLzIrR1ZPUG5WZHFKRElD?=
 =?utf-8?B?UlVzZkw0WDZTRU1EaGJoTTlCM29jaXBubFpXNlFvcTNVdkU5NUNBMiswMW5Q?=
 =?utf-8?B?UEFZTndYcWhRR3lIclZyNUp1T24wdHlwbGUvUm00cDJGYU1UNVdyelhPa1ZV?=
 =?utf-8?Q?J0SCmGg+UAOKR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNIRW9QeUM3U3FycDQrZUp4ZVY4dElOMFBzaXBhWFk5ZUxRTDdzR1JVOXZp?=
 =?utf-8?B?WDREUlMwbGFNK2RDcmhQNXEwQTJpTCtFajhPTWF3WkowVmMwNlRKN0JrTUZH?=
 =?utf-8?B?d2pHaisza3JpSzNXazRoemF2SlN4ZWNXVTBpS2poNEFodGtIOW9aOEpZdXJ3?=
 =?utf-8?B?SzZIUGlnM2IxbWRqc1FmY2JFb3NreDBvTVdtZTNnM1FLMytWNGZ5RzN2VWh0?=
 =?utf-8?B?Z3YzZTFsNGlIb0FpT0xSdStPczRibnhvRTc3WXVHZUdGQ3RIY3NCeEc1aU5i?=
 =?utf-8?B?ckdvanNFZDdZT2RDY21tQkx0VDhydmpHUTZKRTM5LzF6ZHcyejZ3dHJTLysr?=
 =?utf-8?B?OVVETjBiT1ZRMFRGMXNFUERIQWI3a2JHcGdGblo3WkFzZERqdWNPVlpUaFEw?=
 =?utf-8?B?UG5IM0FQRm1NUnVWa0t4UE1ueEw2ZHpaRnJBL1hxT3B0MVAwV1RVdE92V2VR?=
 =?utf-8?B?OGw1MkFEdms0NTFRa3ZuR0xZR0FtUDhqZzAveEwzcTN2WFZ4VHI1OXZ0a1Q4?=
 =?utf-8?B?TlpGdTd3VnJYa0svZys1UzdBSFhLUml6L200M2dDc2RlY01LVXNqQjlJQ0x3?=
 =?utf-8?B?UWZDT0RhQzU0cVNHaDg4ckptZ0ZhQnFYRmU1cTZ6YzhqUHA2TGVqMVYzaGUr?=
 =?utf-8?B?dkNPRjdLVE11aFF2M2ZqYW4rQXlTckwxWHFxeXBXMWR0YlRWMUxRNUFYNnZv?=
 =?utf-8?B?VWlSbGNPOGFkU2tSZFpmQ1JTNEJwQzEvNWxBSDNZWnZXaUtHQXRiOVlKWHBo?=
 =?utf-8?B?WHZCZmQ5dkZqNUlaUGxNY1Z1SGQ4RGtUNjZ2YkFNWkJXSlZ2SGtxeHlSQ2Vx?=
 =?utf-8?B?TUw4VXVnUnBpZExJRndpV0JicUQ1Qnh6U0tIa0dtTURUTEtEVEtrSzdJQmQ0?=
 =?utf-8?B?blJhTnhBbFlvQmUydVg3MWNNcUl2L3dqV0g3ZHJLNEhjQUZRTjNPQ2dIY1E3?=
 =?utf-8?B?R21qUkE2THo0aDcyNzk5elo1eFNzekFIbjAxRjBYeEtXM1d6Z2dQOUdUL0g3?=
 =?utf-8?B?OHd5OVM2b1pDaXBHV2tnb1ZCckllQWdyWVVnYTcrTjRNVkpmSEJYSWFHaTlY?=
 =?utf-8?B?dUk4WVV2TmQzK3JMN1h3dyt2VTBQNjRhTUZkY1JGN0grcU5PTnZjQUIwM29J?=
 =?utf-8?B?TDhJVlFkczI4TjduZXpDZUc1ZjMzWlB4NXY0Yy9Ub3ZGSktIR2hKM0ZrSEpq?=
 =?utf-8?B?WTFRTk5adzFIaWEvRXRoZUVBUkE1cnpoL0sxVk1tQUQ1M0hnMnFjRmk5OVJp?=
 =?utf-8?B?VHFNUzQxUDhvcng4VzV1YmNlVEFObzlNM1BwMXVRRVlINStYWVMyRG9ieExN?=
 =?utf-8?B?bWZENEVsaWt0cy9sZmZjYVN1WUhjd2F1WFZuZTZvR0ozakdrZ0gxU2Z2QkhS?=
 =?utf-8?B?a0xmK3ltL3ZCYklTM0Z2ejNOaDRMT2FEVSsxd3M1UjJLZ3orUkREMU13ZHpn?=
 =?utf-8?B?QUFNWWVIVjA3dUQvNjZLcGFxZU5rREFOU3E4amNsQjY1VWc1OTZhQm1MRWJk?=
 =?utf-8?B?K3grcUFEcTUzV1FpcVZNOWdpclVQdHhYVzQ4WjZwVWZ5Sk5lR2I4SGhMdzVx?=
 =?utf-8?B?Ulp1YXl1TzRkb2ErRjREdXNBdUhUWEtsNkNONHp0aTFkZ2FseFJ2R0ZxdjdV?=
 =?utf-8?B?dmQ3c0FWNStZVzQzaVc0dnNTWkhpL0VxcStUNnY5YnNUWHNRbmNUSTJvaHdV?=
 =?utf-8?B?OTJuLzVMbE5teCs3NmltV3czb09QMjd4a3dkZzczOXgwMFVaOVJlWlRqQ1FN?=
 =?utf-8?B?VXczSzdjQVZyeXpRQTdGTVkzWHJ2UXFscEhmNDR4VDdOaCtITXJudXU3SWNm?=
 =?utf-8?B?MmY3QmorcGVCZXYxNGNDdFo4M0paZExjUGY2OWxnR3k1TEt4NGIzT29Ddkox?=
 =?utf-8?B?VXdTMTh3eWJCcEFjT21yOTFJNDJWSDJFbFUydnNOK0RIUzk1NUVJL09oeW5p?=
 =?utf-8?B?dGxqRTlmeWRjTElnM2hDVm9QVVQ3Uko1OGltVXB6RVN2emxwaG54SEtwZ1NM?=
 =?utf-8?B?NHBUZnBRczRyM3h1VW5xVmlNc1FCdGNXVjV2L0I1QmpkMU5ncU03eW9vUzdZ?=
 =?utf-8?B?ZDJ1dXgyZjNibTlqOW9iTVg2RDQxaElSR2wwWHJIQXFSbnpScWE5MWo4dExN?=
 =?utf-8?Q?y52k2fUhK0/tqANeTKsLjmZct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7165eeab-cdb2-4e22-e8eb-08dd76e9749f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 22:05:21.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TC375qvRbHMjwdGoawUD5O4hYCo4x+PL83dqKAtkTYknXv19x4bSMqLwAg/XZeEe8KVYEJe3aVI9uIP/Bh2xKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513



On 4/8/2025 4:58 PM, Paul E. McKenney wrote:
> On Tue, Apr 08, 2025 at 08:18:05PM -0000, Joel Fernandes wrote:
>> Hello, Paul,
>>
>> On Tue, 8 Apr 2025 20:16:08 GMT, "Paul E. McKenney" wrote:
>>> This commit adds a new rcutorture.n_up_down kernel boot parameter
>>> that specifies the number of outstanding SRCU up/down readers, which
>>> begin in kthread context and end in an hrtimer handler.  There is a new
>>> kthread ("rcu_torture_updown") that scans an per-reader array looking
>>> for elements whose readers have ended.  This kthread sleeps between one
>>> and two milliseconds between consecutive scans.
>>>
>>> [ paulmck: Apply kernel test robot feedback. ]
>>> [ paulmck: Apply Z qiang feedback. ]
>>>
>> [...]
>>> +	for (i = 0; i < n_up_down; i++) {
>>> +		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
>>> +		hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
>>> +			     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
>>
>> This will now fail to build and needs the following: I will squash it into my
>> for-next branch into this patch, but let me know if you prefer to provide an
>> update.
> 
> Please feel free to squash it in with your "[]" tag like shown above.

Yep done already. :-)

> 
> As you say, you will be sending them all out soon enough anyway.  ;-)

True. ;-)

> 
> My plan is to rebase on your stack once you finish your first long-form
> round of testing.

Perfect, my first long-form test should be done by tomorrow AM.

 - Joel


> 
> 							Thanx, Paul
> 
>>     Fix build error by converting hrtimer_init to hrtimer_setup, see:
>>     https://lore.kernel.org/all/174384280127.31282.2714486346304643188.tip-bot2@tip-bot2/
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 4f0a00a8bdee..14a22ef3b56f 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -2480,9 +2480,8 @@ static int rcu_torture_updown_init(void)
>>         }
>>         for (i = 0; i < n_up_down; i++) {
>>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
>> -               hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
>> -                            HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
>> -               updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
>> +               hrtimer_setup(&updownreaders[i].rtorsu_hrt,
>> rcu_torture_updown_hrt, CLOCK_MONOTONIC,
>> +                             HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
>>                 torture_random_init(&updownreaders[i].rtorsu_trs);
>>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
>>                                                 &updownreaders[i].rtorsu_trs);
>>
>> Thanks.


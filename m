Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430B20C48C;
	Tue,  1 Apr 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525047; cv=fail; b=KUS9uqWg5BzfUstoG/UXa5zKSbpE+VfAo8QiSodR2D+Nq/4yLE+nVUDlQtxMzXpxqn9BpvD4qxIAZp8/KyCcKeEHIUf5GO5l76B/fffjoufVJLWqZDx8ae98wOwQcGM8WUKHsaeVsIMYQog70PqaU++AguSB0G1+qiasdPkjnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525047; c=relaxed/simple;
	bh=BJsGYQAJeIPdL+Ga7o9/pAbpdTW8oiJm3M5u2KH/Gyk=;
	h=Date:Message-ID:Content-Type:From:To:Cc:Subject:MIME-Version; b=SSIIZof+2v7MMYcCl7dhSMnsyfvpsgAZFxQi/tKoI3GM0sl3SR0B1hAnCjXH5tHz9HTeiOtZuh3oOyyfw6g8pZ+/s+2G6CRYR3Bw6yMDuIE9bXMzxRLX+Uw84cOy8KOFeLf8wwWE2jrpxH7Ic2q2T0BQ+Fc3xuI2SbiEf6xdylw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZTzdtsd; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZTzdtsd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUC6xRVAH/pxHb9VTdcE5RsTFp3MmSlVl+AFYfmMdBFfnABylx4XonXIXtUZkLUHzXSjVCP9fvC5nEohKA79j1rOn2qdsEZzlgB6HEmoU+7so3h/fllJRhRegv/Okw0YHxRA7FijSdAkpIHR6Y6GIvLfe06tmWwv+G57QQyuTZ7rrl3tZeBMuJEAVFtmwhN5KCGv/A4SVPQu2YXN927SUrcmaH6VXqyXaRsSV+C1fqJhjvb13+jVaMHfwQxffntMOmWrICmlLSahFyij+zGmDQl+5IjqXh9frisZueaQFNexQ+lMJnOKRVyQzeEiC4GOxOEH+RqE9yeUizDOA3SWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJsGYQAJeIPdL+Ga7o9/pAbpdTW8oiJm3M5u2KH/Gyk=;
 b=o2X1fLeb5WlxVmVUcYHUCZNuJBZ2cL61o9U2rsGslZqGmeZaqEdXCvIJXt6WJ2Pd42kErutpAq639R0q01a62f4nF1gdl5vHlsdT+qQl3OoxaFv3MUgrBDnE+X9DlgsiNCnQlL0OORdWvExyrtwZFsuL8OVtziV8wq8vcNmEmrYh9tdKZQwem4DiaGoW6S4dFJ0l/v+HEpxjJnAsUbVsQhSUafoJUDZ7v/tFVhlFgBjDqOlwSgsOzfqYI+9isTt9NLmN9qm7iyKJmd6O5/hHcM9+1OyqtKrd+tHv3ku27XpP/OiOFy6QImuT+w+EDfDwck3im+AEKs8H6T7a5xNeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJsGYQAJeIPdL+Ga7o9/pAbpdTW8oiJm3M5u2KH/Gyk=;
 b=aZTzdtsdXx+1I7euh99GiridHVu0d9XudYPjeJj1d9vWmufHwjXHN5msul/bF/5mYOUQ66/hw1DvsQeYnzl9G+oJSuTqci3MPhUgLeXE94cYoQhhMbbi1w9CY+icL8lon0nmwYnx1BMHs4Uj5QO9Vfw8lnmfNSHU3JPC0A5sKbW9KAyQQoziOda2JTmyWM6W9lR71ufZdxoUfxSomaLx5XxsHaYNOGfJpN6gezgen8R24NcpwWJlTfsmXxWYMf+LZB0VQIlSyPT6pF4z66HRJ8xQympLPg2pYF9tFWb4qJNxEo8oSTcyKhjLKK75OBj93rqZChpUkI73+Fv3eXkEPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 16:30:42 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:30:42 +0000
Date: Tue, 01 Apr 2025 12:30:40 -0400
Message-ID: <8c8932fd34334718e94f979f9bab2fb7.joelagnelf@nvidia.com>
Content-Type: multipart/mixed; boundary="===============0629731459990192381=="
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [1/3] rcu: Replace magic number with meaningful constant in rcu_seq_done_exact() - Patchwork
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4b0595-d8b9-49d0-b75d-08dd713a8b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anFYY0xpTU0yb1VDRTNUS0lMZys3SjJIb2JNZHAzb3N5b08zdS9JVGFiVDlT?=
 =?utf-8?B?VWlObTZFbmp6OGhPd01Hc2pNNDZSWVdUUXkyMFlwaUZDUGw4bTN4TVhpVjdV?=
 =?utf-8?B?QXhpRUc1NVBxY1ozOXl1S1pzVlhMczdYbDFodEgyUFRvOHdKRFRGc0wxdzF3?=
 =?utf-8?B?SGRtTHNCaWVWMEc1NnJtT01XMXNyRUhsRXlEVDNGd3Fla2RPYXl3VFZyYVht?=
 =?utf-8?B?NnZwQkU1azQyUE1HdmQwQjFXRmsxUkt4RE0rZlFsQlpsUUtOcEdUZmk0THZh?=
 =?utf-8?B?UDU1emRCWEYremxYaStnd3FVNzNyUGxKNkFmaEFxbktwMU8wNkRhQVo1emRV?=
 =?utf-8?B?aGJuTXZkbnJzYlFtcUhtQ0sxckFTaDhZT2d2SDExVktmS0IwYjFyYU11UW9E?=
 =?utf-8?B?MFk2QjNpYUtFZEpFVmVxMnpnMnArUkRzdzNYVXdkMzdzT2Y3SFpOVmg5eGRW?=
 =?utf-8?B?UUEvNW43M0ZTMmloUGxJUEZibURxdDZSNjdiK2xFemR6Y2JpVUFxclJXaXVn?=
 =?utf-8?B?L3pPVENqb2pQYk8vdCtTV055U1M2WVZaWVFQZlp6QWd3S1pXT3ZBejN3WHJ3?=
 =?utf-8?B?OFh5VHNUTWVRM2d4V1FBL0sveWhDSExRbDc4YXlTNEMzMmlzV2s0MFBsamF2?=
 =?utf-8?B?NVhJODd1WnBGa3RnZDVUT1ArWEVvMzNsWEttZFBQMXFCRnB5bC82YnJFU1l5?=
 =?utf-8?B?WmRHc0lyOC9nTkVMSjEzR1U0T2JEZmZ2c3R3NXMwQ0RmUFE0V29EcG1vRmJj?=
 =?utf-8?B?L2xvMDVOOEdPelEvSlNMdTY5ajVzaUNEekhwL3BCVU9yRFNhYnF5c3EwY3Za?=
 =?utf-8?B?TGhDbVRCTWUvU2h6YTQzRDJKLy80c1hoRS9jcy8vbCszUXB4N1lMUUt0cmd1?=
 =?utf-8?B?YWFRSkxnT09VeVF6ZWVIcnB6MGFvTTlidXhKRW1qRFhwbngvRTArMkN4a2tC?=
 =?utf-8?B?VHdqUmJvdEZoNXVUSmtVVzgwRWVOZ3g5REdDWGcxTGMvVExzblhIK3RlaGkz?=
 =?utf-8?B?YkcwVTRuUDFxQ1JReWtRenNNTXUrOUwxUnYyYVE0Y3V1SkRwS1F0MFZoSkpI?=
 =?utf-8?B?RXNoY2VsV0RpNTNHeTdsWkJhYXpEUDBzQXFCNTBPNDg5a0czSjBjeWJJM3Zl?=
 =?utf-8?B?dmZXOXppZTdBcGNIb3Fla1FyMjN5NzU3eEJoYmhIM1paNDc3QUl4M2pKUERY?=
 =?utf-8?B?TUtSSGxhbzB4VUhQbXA5NHBmQW5tZ2l2czFPQjZHSEdnWXdCcUVQWGcrT1k5?=
 =?utf-8?B?eXo3eEdPVVNOWkZlTkRKSHR1RVM1bDNxN0I4V0VXZU01Tml1V3didFZpMVMv?=
 =?utf-8?B?VStKb1EzVzZtbEhFT0RhZ3ZNS2xpaVN6OVg5aUMwSTI4MHc2dW9xSTFQLy9J?=
 =?utf-8?B?Snl3V0xtQkdId2hXQWtkWUdXVVA5dFM3U3Z0OEg5a2d2d3J2OGRuR3Zrbnlu?=
 =?utf-8?B?TWpHbStFa2YyK0RSQndVM09nLzBXNDZXRnVkRkxTcW9hckJZQ2hKUGtNKzBm?=
 =?utf-8?B?ZHJuMkZNeTJFcDJEbjhaQ1NNWWhoL3EwYXUvclBOWkN2d0pzMjdycWRQUXRu?=
 =?utf-8?B?M0NpVjZ2dUs3bU5YTjNMVlNXdkl5L2QwVVBSdVBYTVNpc3czejhBbHF0STRi?=
 =?utf-8?B?bUpibDkrUC9tbGd3akd1L05Eazk3QVQ5dEZsYUpLSERld1Njbi9XUFA4b3Y5?=
 =?utf-8?B?ZGcra2dzVE9xU2l0ZjNDOGFQaE01dmljQ0VWOWppMlBoY0FYekRhTkorQk43?=
 =?utf-8?B?Mk1DTldPaG9JaGRGYnJqRzZ1RE1CUlFPRDkxZ0dwVjZLNENsSHQ2TG12N0lw?=
 =?utf-8?B?dlRBdHc3VW5nV2ZZTkcrMkFNcTc3UjZWOEl5eU93L0VhWFZFejlUaE9tTjMx?=
 =?utf-8?Q?rpe+W5sdkN3jw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BuMFI0QXZyRVBleTh0K1hJNHkxanNSTzk4cnlwWC9ZUnQydWUwV2wzTXZs?=
 =?utf-8?B?UlQ4WVhWSksvY3d6RWJXNTdhS2MzVzBxUkdTWFdZS0o2aVNHVHFTMGJCNy9q?=
 =?utf-8?B?YzcwRC9ZZnBFRnlFZjVDYzhhbVFGM2p4OG53V21xTVEzWnptT1ZWUFRNNGxI?=
 =?utf-8?B?eXgzOU9YM1pyaUFNc2JGVTE1QUtQR2dMU2pldEQzVXk3TXlPbWJKWXQzMlNr?=
 =?utf-8?B?TzNzS1hqclVWemlETi9BODQxRW14NWw3dTRxNkg4a3p6VWg2d0RYRXZDNm1T?=
 =?utf-8?B?Qkp1NVIvV0dyVnJadUxiR1RGenhzQTFPUGlTRG41UkhXVjdtYjNMYU80OXFK?=
 =?utf-8?B?K0piTkJBMnNBWEtqT1ZhQ0lzNnRlVG1FTEpxTUtwQ2dmT0dwV3pjcE4rOXFm?=
 =?utf-8?B?N01rVFJGNHoreE5iTDExWE9tT3dKdnMwL1V5YXpyNUJIblV6bCtacDdxeDFl?=
 =?utf-8?B?OWwzemtwbHVtV1IxdGNFMkJKempWbGQ1VjYrbHpNUnVlN3lsNFk3Qm5TeUZX?=
 =?utf-8?B?Z0NzR1FIRzdlc2hXQzZuSVpEYWFCcmdybE1NTlozdUhsT1piOGdMVGVOd2Jk?=
 =?utf-8?B?UWFiQll3Q0piRzVMUDhLT2xDNDRqSzhFeG84WmQ1QXdROXJDVXljaThQc3hI?=
 =?utf-8?B?Mms0M1RkVWw4bzFqMlNQclYxaDJLMytXQUJ2ckI1WldVOVJ1dUx6MHh2UEJn?=
 =?utf-8?B?blE1RFN2ZzRZZ3phKy9hUnlnQWV5MGtmb1BJNmpQc3pHSnAvTDBBWDJsRmkx?=
 =?utf-8?B?L1cyYWcxdVB6NEI4cHhVeWw0QUZhUHZPT2VITUNXZlV1QzZ5RkN4djU2aUxS?=
 =?utf-8?B?S1Vqb3F2MTB3M0gxOE41M2FJUjRMWDVSVWtPOWRNRmFFWWN5NjVYanVIZ0Zw?=
 =?utf-8?B?Q1RtMXMzcmJ1NXhMUk1JMHdLU1VqcFhEak5zWTJjWThGS1kxb2ZpWmRyZzFv?=
 =?utf-8?B?WVV2NFV6YzV6VXYwNTdONlh6MVJuS2V1NjhGMGFSQkJxRWhFMWN3RGtORDhV?=
 =?utf-8?B?dlRVaHVHaE5CMDhoMjZLVjN3a3dsRmNJY3Y3NVExOWVKS0c5VnhDdWFaSTY1?=
 =?utf-8?B?L2QwdlVGMnFEdGlBT1pOakRPaTlkTTZXY25DWG5hd2p0L3dVdjlBWHRLUiti?=
 =?utf-8?B?WWkzV1pmS1Fqb290S3dzbmJMRTFLNVZKOS9vUXlJNXlOMWVCZ1RKZTc2U3F3?=
 =?utf-8?B?SjA1c0ZMdHdqbEw3eVY5dWFIMEd1MWwxOVdRSW9ybG1TR1dmdnNiRVNZY05Q?=
 =?utf-8?B?NUVOWFV4WlV6aHUyREN2SXBkaDlhczNvWXJKdXNhZlNINlRYUGc4NHlSWjVR?=
 =?utf-8?B?Y2FUN0Y0UURoTTd4VlBRTUJWWE55SkdrZjBOWVJLdzZlNXVSWlIwZjA3WURr?=
 =?utf-8?B?YW1LRlk4cWRWUi9Wb0hUOWlWbFU5WUlZQmxzMDZmY01GUE1Od0ExeGorWmtw?=
 =?utf-8?B?RTFVa1BQK28rK2h6dWVPOXd3UUliTCs0NWliNDMva2J1TDN3dEc3VTJiMGhO?=
 =?utf-8?B?TEZ2Tm1Dd3YvQjI3MWpOK3lCNWlTbjFYQS9MK1ZCaHNXYUh3WFVMcmQxaFc2?=
 =?utf-8?B?OG1uS1NzTmFVSmdwOGx1OHkxOVcxeS91MzRObE52cHdobEdpMmlycm1yM0Jt?=
 =?utf-8?B?YlNEdHR6UXMxVGtaY2xtWjRSS3hoZURqMEIyWk9kcGZYVVVVcDBsWnMxMlds?=
 =?utf-8?B?czcxemdBMWNYZ0dHNGdhbSt2dVFyelVKK0FaN2g0c0thc2pYSXJ6UWlQVDMv?=
 =?utf-8?B?SE1CRVM2V0lCRTRaNWpMQzg4YUJCcHRURi9tVHYvblF2Qk9WMTFaaXVsbWxJ?=
 =?utf-8?B?SFBWby9oWU5YZGZsSzVYS2tSTXRJSWpEelRlNXF2S010MWNtckZ3a04wQm1s?=
 =?utf-8?B?UUVYN21tUm0rTG4wK1BWVGtzbFB4ZDBQN1Q4cUtXQ3RvMVJJRDhIbmhsTXkx?=
 =?utf-8?B?MEVoV240R25BenNPYWFTQkNKeTI3QTA4L29IRUpoQ1RjQ1FCYW5PY3E2eDlt?=
 =?utf-8?B?Q0VhejBOK2lZdWFlSkJIL0IrYlpLekdBSStJUzh3cmhKeEpHb05sc1JIZGsx?=
 =?utf-8?B?Z2x6NTZTUEZTOWVNc0ZJS21icEFjeGxBTWFpaUljLzhOSmwvWkJXbGtVSVJz?=
 =?utf-8?Q?y0a7k5T0PO7oj4/snhD1eFwmy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4b0595-d8b9-49d0-b75d-08dd713a8b6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:30:42.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXh/MGO9PPBrBxpJqFOTQTJlxzi8TCuMXZ/N/3JFSO4WzztRmkA+s7hA37jvMadaUJwJmfNKHAlL2DdqRLwJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

--===============0629731459990192381==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sIEZyZWRlcmljLAoKT24gVHVlLCAxIEFwciAyMDI1IDE2OjI3OjM2IEdNVCwgRnJlZGVy
aWMgV2Vpc2JlY2tlciB3cm90ZToKPiBMZSBNb24sIE1hciAzMSwgMjAyNSBhdCAwMjoyOTo1MlBN
IC0wNzAwLCBQYXVsIEUuIE1jS2VubmV5IGEgw6ljcml0IDoKPiA+IFRoZSBkaXNhZ3JlZW1lbnQg
aXMgYSBmZWF0dXJlLCBhdCBsZWFzdCB1cCB0byBhIHBvaW50LiAgVGhhdCBmZWF0dXJlCj4gPiBh
bGxvd3MgQ1BVcyB0byBnbyBpZGxlIGZvciBsb25nIHBlcmlvZHMgd2l0aG91dCBSQ1UgaGF2aW5n
IHRvIGJvdGhlcgo+ID4gdGhlbSBvciB0byBtZXNzIHdpdGggdGhlaXIgcGVyLUNQVSBkYXRhIChn
aXZlIG9yIHRha2UgLT5ncHdyYXApLiAgSXQgYWxzbwo+ID4gYWxsb3dzIHBlci1yY3Vfbm9kZS1s
ZWFmIGxvY2tpbmcsIHdoaWNoIGlzIGltcG9ydGFudCBvbiBsYXJnZSBzeXN0ZW1zLgo+ID4gCj4g
PiBUcnlpbmcgdG8gbWFrZSBwcmVjaXNlbHkgZ2xvYmFsbHkgYWdyZWVkLW9uIGJlZ2lubmluZ3Mg
YW5kIGVuZHMgb2YKPiA+IFJDVSBncmFjZSBwZXJpb2RzIHdpbGwgbm90IGVuZCB3ZWxsIGZyb20g
cGVyZm9ybWFuY2UsIHNjYWxhYmlsaXR5LAo+ID4gb3IgcmVhbC10aW1lLXJlc3BvbnNlIHZpZXdw
b2ludHMuICA7LSkKPiAKPiBUaGUgZGlzdHJpYnV0ZWQgZGlzYWdyZWVtZW50IGlzIGRlZmluZXRs
eSBhIGZlYXR1cmUuIFRoZSBkdXBsaWNhdGUgcm9vdAo+IGlzIG1vcmUgZGViYXRhYmxlLgo+IAo+
ID4gQnV0IHNpbXBsaWZpY2F0aW9ucyB0aGF0IGRvbid0IGh1cnQgcGVyZm9ybWFuY2UsIHNjYWxh
YmlsaXR5LCBhbmQKPiA+IHJlYWwtdGltZS1yZXNwb25zZSBhcmUgb2YgY291cnNlIHdlbGNvbWUu
Cj4gCj4gSSdtIG5vdCBldmVuIHN1cmUgbXkgcHJvcG9zYWwgaXMgYSBzaW1wbGlmaWNhdGlvbi4g
UGVyaGFwcyBpdCBpcy4gQW5vdGhlcgo+IGhvcGUgaXMgdGhhdCBpdCBjb3VsZCBhdm9pZCBmdXR1
cmUgYWNjaWRlbnRzLgo+IAoKQXNpZGUgZnJvbSB0aGUgcGVyZm9ybWFuY2UgY29uY2VybnM6CgpT
b3JyeSBpZiB0aGlzIGlzIHNpbGx5IGJ1dCBjb3VsZCB5b3UgcHJvdmlkZSBhIHNtYWxsIGhpbnQg
YXMgdG8gaG93CnVuaWZ5aW5nIHRoZSBnbG9iYWwgY291bnRlciB3aXRoIHRoZSBub2RlIGFmZmVj
dHMgUVMgcmVwb3J0aW5nIG9yIGhvdHBsdWc/Ckl0IHdhcyBub3QgaW1tZWRpYXRlbHkgb2J2aW91
cyB0byBtZS4gVGhhbmtzIGZvciB0aGUgaGVscC4KClRoYW5rcyEKCiAtIEpvZWwKCgoKCj4gPiBJ
bmRlZWQsIHRoaXMgcHJvYmFibHkgbmVlZHMgYWN0dWFsIHBlcmZvcm1hbmNlIHJlc3VsdHMgc2hv
d2luZyB0aGF0Cj4gPiBpdCBpcyBuZWVkZWQuICBNeSBndWVzcyBpcyB0aGF0IG9ubHkgc3lzdGVt
cyB3aXRoIGEgc2luZ2xlIHJjdV9ub2RlCj4gPiBzdHJ1Y3R1cmUgdGhhdCBpcyBib3RoIGxlYWYg
YW5kIHJvb3Qgd291bGQgaGF2ZSBhbnkgY2hhbmNlIG9mIG5vdGljaW5nLgo+ID4gQW5kIHRob3Nl
IHRlbmQgdG8gaGF2ZSBmZXcgQ1BVcywgc28gdGhleSBtaWdodCBub3QgY2FyZS4KPiAKPiBEbyB5
b3UgaGF2ZSBhbnkgaWRlYSBmb3IgYSBiZW5jaG1hcmsgdG8gdGVzdCBoZXJlPwo+IAo+IFRoYW5r
cy4KPiAKPiA+IAkJCQkJCQlUaGFueCwgUGF1bA==

--===============0629731459990192381==--

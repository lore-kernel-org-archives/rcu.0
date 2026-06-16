Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BA34A773;
	Tue, 16 Jun 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648791; cv=fail; b=IIzIPpJRzL7ViC/lS2e91gNLyhIpV5oUIGZVZZ+U+wVJGSDvcKNfH0xFNA+e0YNTI2usLCR/T0Yz5pu94+x96pLcoMcT7KWkVrx8P4DbGoIU2CuCXOcp3B87zNMFkrJDjPfDqwR2O2/vxbVl4r5B5zdMQkQ/Xi21EXmRTbPPS7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648791; c=relaxed/simple;
	bh=NEhsYsMSuI2Df1YX9el99cohkRpVJrzRPpmu60XTx/w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pwK3ihvV3r9Omsne1T0LiNuB/cxjklUP80UyDgmx7fGleLbQUYgBZyqUfCt2HleuxC21ue6XSY4dm/X010SWVf7GxP90+dj9o5MM6pFs87vtmDV+euGEBj8g2TQUHzP1WqhuKzYN8v1bu+jknnP5iFxAd59e/FkLi2lErhvXogo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBFqzngp; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBFqzngp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP4opltp4DuPYDBTA9RHD+qQ1iXRHKp8N8VfPsNtJucnWGttyTIvkbMKSKwDM136IVZqbw7cWQEJ2IyzItRnt2uRTtvY/1ZyhFp0Yc604/J8SyKSNGjsze5VORTrGkcivtC2gDaXW02rUvUOAzR1iACo6moxHT037Rdo/6CRrwwjVvsiLnInavV50x/1wumQghfeD4Bl6xyRLLXSGGvmthF8lIaGUwraRrTeduY5orZOrp794iTFQfR2CncjFhVTt9T84Qf6LrO0iCn6uAatqaWy2bmEssufFHgNaMf6zrc418xkPlLhFsUJUtffdHT9ywtSq9HZPd5D0AyDoNdaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ZM5625+z5H34IrxrvosgxnpLOrqmjIaY6T0IdQXCU=;
 b=wlcRAPLC7VF/9IFlSxfoUhlRkptvf89rUKTlAe1crY7wHY0mRc0Ub7vFBRJPMQDYEcT3OOtdZkzmPsacaslYNpMRUu1EGCNNgzaYVAb7ahUJ4DOm3l2TFmQ/VUP8cw36mnSPS9m5FlHimIsQ/N3qtDLW40Ig8ZZTUOOFehIw6cEno8lAwCXJoKZApcFt2VMY4bkBdEOmldvY3fbVI82ePTD+P6296fOd6W1blW2I7+HFvuprYrGPUanQHKP4ZdBFf0r1p+UwohWt7LXFevg1ki1RtMZ5PWrxgkEPgNjYjBskZExviVaNOyVz2bhy7XgA4CCmS8Uu5/k3TqT68QR5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4ZM5625+z5H34IrxrvosgxnpLOrqmjIaY6T0IdQXCU=;
 b=oBFqzngpGBaJmQE/vJQhBLUdZPohHYk2c8wnIvRTOh0oS50HmPCsBRRKM2D5Wv7BVuHmL8uL/2Hp+SHC+J1uEYF5NZBn0plU10zrJobpCZycd1peQ9TaZ4Xn8uK6huwpnTXVPmNIuExGJqKiuwxTa47xQoNFOUbD1zvvGm7HVYEAxJ7sSf3nngW9ye+Q9iUTWmiTriNHBJ5auImT/cXKpvF5hIwapru6h2Q3k8HacnQhHQ2hg9kp6WI0yveJiPArPxhL0wckUPYsTCoTbLUxlu4lTAsr79NDFbAws/A9c6a3me0qoQzXUTx8qPBaPuScK+dA8iO7Cq7A6N48fw5hAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 22:26:24 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: [PATCH RFC v1 0/5] Reader end deboost testing
Date: Tue, 16 Jun 2026 18:26:17 -0400
Message-Id: <20260616222622.2981876-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:52c::29) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb6fc66-e8b9-44f1-ba0e-08decbf64cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0SQsUjKdyti6y301JRV/04cLiRJTlfX7hKpa8bRnl96msyPiQrlIvR+D4Ymo3JpR4AAzcSj1obiH3VPlTwuTHw1/pTFHlTEAWFbo7OWprLI79zHjQl6oZQJ38ig7j+LDzYYMbpIcxZPNE5ErachXJm95beVUisKRsxL25jN/gZtQ/j+Fgae/5f7km+I9QzzJ/WqRIvw51Ejup9XRvX1BubN6LNGXCxdkiBnZ49Zluj09E9rVjFDlMgUJ5PhkjcP3ndP6j7KYWMqDZUEhKF18m8XxWWhVpQqEvlCPJcsXLTWDV4B2BQsi4PN+NGK7z+2535umX0De/lnWdimQK+ndCHFcqZR2Lrm+Ie3cP6fc9dUXNPr97wEl2uOCeVAcAvyUebOXEuVXIcqHlYe9KmWXzfvWEpM1brs3imbykAfjAOC4fDTxuZSTXTPUbrdZRCQYi1Zo4zTF47ZK0EqWFYcZiowih+DyncQfACfRi+NgXwwmuhOzbiLwL9/pP5gb/q9LgtdcDinCGs3KQ17eWR4wCaptdVjN4bSmPHLWMRrU6Q6cLV+JwulndJkgdAqwW2cA2rmNU6wOYBbBNaG+pjOuKJjjaAB7kDuhprlH7IY4z16NR9YZiLLvzozEVxNCxrjOtPUKIPlZt7Uf0fagiZhc6welCo8I64r/PfGjJRRImH+z+k1zpofY2RtGlcS/ZwC6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Z2eXpaQzBOcTZxZ1crNE9LT1JPZldoMzVoQUx6QnFRdlN4dStTaXlqbWFi?=
 =?utf-8?B?V2J5OFpiRFFZL2pZd1ZkWkdZWDgrUlc1eTNDSk9NTEZnRitwUTBobTQwWjUy?=
 =?utf-8?B?V0xxQ3I5WHN6WXNQVkxRR1kxMk9xY0VkQmtjTjlpQUhGaDI5QkhuMGNiREs5?=
 =?utf-8?B?RTNqYnZuMG1BYzVrcXhZT2NKeFVPVFpidEV4ZUZ5ekxpd09zTFhIM2Q3U043?=
 =?utf-8?B?UHo1RWdPU2J6ZzhzVm1IOU1jUlI1YnJuclYwR0RKbk5ObVNEU3p0OFpCQTNQ?=
 =?utf-8?B?T1NmQVZvQmcwazJLMHIwYkw0SEwydUZoNEp6ODUrWGpnY042R0haYmk4aEhz?=
 =?utf-8?B?dG9PZjBmQlNrNWQ5TEI5Uk1DK21adjdGZWJFak9sMnJFNFdSL3kvdCtFbmU4?=
 =?utf-8?B?dzJzMTdvSWtGc0NTMHFVVWVrTUdNcDFyNFZPa09EZS9GT25NUXQydzRaTHdH?=
 =?utf-8?B?dndkdTg1NnNkL2s0YUF4U2RUcloxbUJMT2FvOHVWRko0cm5jYTBRYUM3c2Zl?=
 =?utf-8?B?WWNPR1hvd3VsMkxKNWpTNVJCcUFhQTZ3OHUrQ0UwNkg0VGgyMmpOSkFvc24x?=
 =?utf-8?B?WHZlSGNuT0ZkWkF6MlVCaTdzblgyRWZJM1hXb1o3YlpLT2lXMGVjbksydzdN?=
 =?utf-8?B?L1hjMkMyN3FOTGtDNnBNci8rbEVYUzNTN1N2T1lLSEVhZExsUURxZStkVXNr?=
 =?utf-8?B?eTk5NUJrS2sxWlh3aDhNTENqc1o3Y1dodVVlMk9rWVVrRWErYzhLUVpyM0Fy?=
 =?utf-8?B?MUsxUjZuV3B5TTFva0ttZjgzeGIrSTNRMVpBbmdUTFBLKzk5YWlHb3NUanI3?=
 =?utf-8?B?MmVsMWMxaE80elhTZUZXWGtudmt2TVdTQ3VMWVdqV0xQWDNXaFlxaDUzbXE3?=
 =?utf-8?B?Y1NpSnA1SngvWGxoM2lVNDlxUDhLa0V4NXhLdmtlMk80N2hPTVNwa0gyK1NS?=
 =?utf-8?B?RUlmRzU4NXE5Q0JyUGR0dHhTS2pmVUNsQk8wM0poVE0yeFZpWHRNSFBUT2hz?=
 =?utf-8?B?ZjBHUUVDUFl5eUd5SitpZkI0NlY4K1BJTG90NlkzZmZ2dldGQ1BIdGNuZDYr?=
 =?utf-8?B?WHF3ZmtPdUpra2s5Y1FKS0M1Z0U4aEtwK2h3cm8vNGdYb2ZaMU9uUUtjWEdt?=
 =?utf-8?B?Q2drM3FjbVo4bHh1NHlpU0tFeHUwV2puWmZ3K0dDc25oK0l3RkU1TTRod2Zv?=
 =?utf-8?B?SEFyMkFUQkxENnhWanFrMWRlc2hYWFp4VHhjWmRtb01IRGlUTU9MakVZSkx4?=
 =?utf-8?B?SDNoN1c3clVpenZzRTVVN2hYeU9XNGVOTS9tekN0MEJWOVVSZENpSWxmU09i?=
 =?utf-8?B?R2FzUGhmR3QwNjBNRGJrU0VaYUQvZ2QyNHZIc3hDRUNNNDlicVlvMFkybVhT?=
 =?utf-8?B?b1o1eVZQV29pUzlwU2xQak5rcm1hMkpmSDlObEVza1JuQ0FFbFRhU2szVGJu?=
 =?utf-8?B?dktsV2UvbGs5N0V0S3REbnFnb25pblVzVU95c243MzZMNlB4UG5uaGZIWmMv?=
 =?utf-8?B?bFZZWmxQSWovLzM1aXZnQURkZitoc09VbGNycjhXYUpkcFNhKzhtdlB2ZVlR?=
 =?utf-8?B?ZVh5TndIUG1KbDVYM0V1ME0rTC84ZzBBdlZEakpWOUd4VTNSenVvRi9Vak5h?=
 =?utf-8?B?Und6TXo3Z0hLeWZ0L3RmNFdsKzFHOFplZ3lPRG9hODVsKysrZnByYVd6Z3VB?=
 =?utf-8?B?SGFucHJId3dmN2UzWlhWaEE0N2RnTlUwYzJaZUZLMitud3JvbjYrcS9RV1ly?=
 =?utf-8?B?K1ZyZlZYT0tpWlMvVHdWR0xqQ2ZOdFF6UURnandrcTAvQitkalk4dkM1SGNJ?=
 =?utf-8?B?SUFURWgwdXJVcnBreW1tay9hSWxGRG9POGxTV0NHeGJ5MUw0eExURmFpc25N?=
 =?utf-8?B?blJ0aGlIaFJiNVh2QzBtNnI5K3VEcHVyNCtEM2FFQTNoYTR3QkZ5clk5QlFq?=
 =?utf-8?B?b3R6eGJLU09TZzlabjdCR2xVM05CT2NNK2hkYjBJS2hsTXZDLzR1MWtOVjM5?=
 =?utf-8?B?Qmx0RlJ6aXhaS1N5eWVVOWxjMEVBdzRvUUNxWmY0VVRMcXZqY0lhWDZPL1Mw?=
 =?utf-8?B?c1Z3SXA4UldYYlQvaUF3RzhCTnRRTUt6WkVPNytOb2JhSW1UVXcxbVgvc2lh?=
 =?utf-8?B?bitiUVZaQ1NXU1ZPTE1UcVYzN0xyNFR5b0F0V1hoMEd4TUkvZ0NaQ3NONjZw?=
 =?utf-8?B?WFZFem0xSDV3bm1pQXlEYyt4NndEN1ZOWVpVdXJPTzZ5UGwzK2pZdnRaOFdr?=
 =?utf-8?B?VE03Rm5PTC9mVlFWdUYvTm5RQlJMUFRhajhHZ2tnVGtKVkdDMkNIRFc5Zy91?=
 =?utf-8?B?enIyQytERGJJWUNEZEFXUnpkcm9vdjdEK203ZlM3U0h3T09aZ2VPQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb6fc66-e8b9-44f1-ba0e-08decbf64cb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:24.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVNjGvAnPoi4aHBGQ9R5kLED/zFvHg2brpFWVNxhqwMeHkvrG+Zqrw6bb0e8PFRA3IkBD08PwL9WeOJkeq8GBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

This series adds rcutorture coverage for the RCU priority-boosting "tardy
deboost" issue. The first 3 patches are Paul's and the next 2 are fixes I had
to make to the test, so that another patch series (I haven't posted yet) can
correctly be tested. I am posting just the test patches first in advance, which
can go in independently if we agree on the changes.

Joel Fernandes (2):
  rcutorture: tighten boost-WARN to exclude any implicit-reader context
  rcutorture: give async deboost mechanisms up to 500us before WARN

Paul E. McKenney (3):
  rcutorture: Abstract reader-segment dump into
    rcu_torture_dump_read_segs()
  rcutorture: Check for immediate deboosting at reader end
  rcutorture: Test RCU readers from hardware interrupt handlers

 kernel/rcu/rcu.h         |   7 ++
 kernel/rcu/rcutorture.c  | 257 +++++++++++++++++++++++++++------------
 kernel/rcu/tree_plugin.h |  32 ++++-
 3 files changed, 218 insertions(+), 78 deletions(-)

-- 
2.34.1


Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6450411666;
	Thu, 18 Jun 2026 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808710; cv=fail; b=hBfIzjXDIp2VHerCJDiWrUlY1Q76za5zr1nCIpvMe/Tez8OChUVXCGe+R1GZVmrEHERCtt+hYvmcvtm7+vQfciGDRbpjOj/rSw77UIB7OhMaFAti7/+AMjYtmz17UgK9Pi5yDHtNOAPMubjySEDzEUQZPn+uYTyyynhI04NF1xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808710; c=relaxed/simple;
	bh=6/YWWMDLKs9DnEFldbk23nR8KqyhTnP/2Ef3cbAaRIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCjENmU1+yTw/arSORH7jKdvyf1+zE0SNVcTzw6mxph2xEqovOLAljbrJXlL6GSlBFFM97+NK8V0JS7xBqElS3ZdXjWDW8RlFwHNJpU4RQMeYCkBWE+rQDb6tPNjXyPWHxsHO05fe4UwlcuNC6ZCy+t3p9j3ndwA0svx72/bfE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLIxR0Mm; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLIxR0Mm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE3GYmDclfQJNin961eVoGBJXPoMFwhQI+UIMSunV/yEXE+js2P0SFF/78KVxyX7fVzGXLTTANkd0Y3dYcVZkSqigvHd2F2nidawhn1F/PegT+A4JnFPiNbUH2ZvqpvYKfiLUhLq0HUd61nCre2/1SQaK1l/q8TOYDhcX/AwwxsVW8hKkVwsbnxNVIZDRLZ40/iNOuU4/HNxFDWn71hFeTA2GSKPByLoacSUTRlr/vAA6lmyxdvO8bCSTOqMbrcc8uVzFT1znGGG5lfFDgULjI6yDHjq7CdOLTw7N3zLMfPalZHcIuyMD9UY5oDSs+3gEoh+JswKmqIjeOZzOLlPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfSdkXRFp8fyGyAGQv4PDPhSyJSJOtnhSFK5XvTSVfE=;
 b=XPlxlStMWCktrDipm54DaPfgd+JvLLDUf2gufSshAxW0cHnRPktpS1a7eTUncHnsfELLeyyLDmuCCmy3A8lEbHhbcqo2Af1/L2lKsZIK5uJveuJfVqs9hbsssGTMNhx7PIfzjoWK0qQETkooe7ANRkIj3Zc/NSD7rtbn/m3s5WRg24zambkNM3cHS6VTWeIBIr79wWdzS7QF5ju8mlnCbiLhqdiy+3Hv3QzXludHc4vd0ZNecYkVq2A0XOPWLMPh7KSOQJZaPFkrJ6s7c/4oNxghlvHwhLNgIS2IK8T7UbjkZOGRQ+3102lrmAzenNiC6w5/p3zX1IEWFYxVHKksrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfSdkXRFp8fyGyAGQv4PDPhSyJSJOtnhSFK5XvTSVfE=;
 b=uLIxR0MmYYH4exHaqpkPl0FGM0SxiCLT7HrV2gZoTBauBHRVgkpFnFNYJsRAmwQXI/zCulLTjlu9GWUQXLsfNtNNNKmhKQvjJfiYWMqz6ag22rC4e1ToBNIQkcSnXLZquReTN067fS5UX0CpiLZ3LHdZat/aCX4NlIGSx/doHlBIneVKIWXz/qfWIV2uNNlGnsTQ02SUFlp3oNLN0qK/TLGBGSSR1tDcI/J+kjoaWqY65b3lfygfk6+7zUTrpNlG8RWy/p5o4QVerOyb1OchO3LleoOkM5DJt6mMOyBfWk9+999ZfwQYqFf/NSMLoFc46Txlm31DmceG8TGw1NXW4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:33 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:33 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 12/14] rcutorture: tighten boost-WARN to exclude any implicit-reader context
Date: Thu, 18 Jun 2026 14:50:28 -0400
Message-Id: <20260618185030.376450-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 708559b4-09ea-418a-aa1b-08decd6a9e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uFSGvqdY1T44AarO/i01lSl1PquUWu7StNs4xWU2dUz5/97bwjnNRFHnDA/5ic3C5jpnfXIvA/QVku/6Q+wqcw6mciQ+BkAD8aErMHjcfjewdNI+vDO5HIErzXefbmlAbDGzq9Vp/YaG65RQNFILgL4fbhKI6TugEJTwdrgqG+lhc43eaNwU5ORM8xApjT+DaxGxKvlDjBgAtrsfHG8Ii6jmfBx8RJdCUAa2iXo87s61RDT6VMceuOiU8U0SCJ8PYTgg1nIUJ/dWSuvQ2BZUp3mj/s3pJTJuZUuHQI9h98WRZ/3QekZNSZxzIugKmjBpP5s9MH6ERCqyunNio5JfGhNUIzFqsHJTta2mhRobTwRavPUPfvmLg6o43tGkGy6Tw3YGFL5oOTxJmu0rTaWjESV1TshMdqz/5fRRmqNrHT8fJTX9NEDo2ZENe1uBMGznPpUqbWed4mS9VBtEbUpW2QjAnVEgti5FcE77Gb5SX8kKgORSudL183t8eZTnhw5WXbZrBoonOXI+mv5QcH5YM/B/GWqJiZV9YReu0vWXVIYt2fOqtkz1wD56yAbYH13p+zzqHhu+NfBUnjZnW0wKVI0WCz7yQ7u8177/Qd1EKjAYfPrABKVKBhvsuMwhCQ4WxVh8xil4vYJfbF5q5G+UdNDmH5oCeNaQA2Y4rAoD0pMgzoCc7Nx4PxpEsthPIvMm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5DTVdKOStzWm9oVjVDMm11SHByTFdqWmJtWDY4UTB4eHlEQkk2UGgyUnpG?=
 =?utf-8?B?NkR0TW9KUit3QmlIUmZiS2hKcmticUFsS2wwNWo5dVVNbk44Z0U3RGVTQzBM?=
 =?utf-8?B?V29ESTQxNjhHUW5rNXJ6L2Fxd21ZanJrN2ZqT1F4RjdzSjBLbS85cSsxV290?=
 =?utf-8?B?NkRKakYwTzJPbzBuVVRBNUxseVVqSVFtYWNiRy93K2ZxWE9GMWE3TlFJcHlF?=
 =?utf-8?B?OENGdnpXUHc3Qmxpd0s3NVJ5RWJVcTFkL0J2amduUHphdGxzYTFPbEpVdUFp?=
 =?utf-8?B?K1VJZWt6TnErOGExYmZXUFhycFhCdElQb3hsRmx1RGNQYiswOU5uRUxEL0hP?=
 =?utf-8?B?VXcreDYxOFRIZjJtSXdPaXkyK1A3K3JFdDVmbXEwWk9iVFNDTE9KVXkxUTh5?=
 =?utf-8?B?UDV1RHNNQ2dFSmIyZTFxMEtYdUhYNEVMSHlLS0tkTWVGb2d0eTZpS1JpcDEx?=
 =?utf-8?B?WVorRm9rMG4rL0hwb2tZckQ5VDVkdWc3YWo2ZnpCaHorUE9LY3c2Z3hhN2dH?=
 =?utf-8?B?ZUh2Vmh2S1JvWldWbE1hOHBwb2VqejRSWXVSVTFJa2o3dkFvRjBBUzhnUmM5?=
 =?utf-8?B?N01nOURiY3o0NGNzclVxbjVMTDhzd0hkcHpZbHJBVVd5TldqNHQzVnR2SFU4?=
 =?utf-8?B?NnpWaktydE9YdnlqYzRkSWtBeXVhYU9UVFFXWmN3RzhnY00ramlqSkJIbFpD?=
 =?utf-8?B?RDZRaHRFYzJrbHVkd0tJTFpYQ2RVdXcwVDFQWkRrM0htMUpFU3JNWER1ZlBU?=
 =?utf-8?B?YnBDR1Y4dmxreFIrNGRLNzJHeWpZY1RxcjZIQjk4c2t1WVZ1dmd3T0dleUpQ?=
 =?utf-8?B?M1FqcTBkbXhubDhWMkdFbUpKOUJZTldCZnV6UlBMdVdmT3VERHFZeGdzUktm?=
 =?utf-8?B?TGtHalY4VytvcW90cTg4cUhQUHBDR0pQblNrRjNSdFlHZ0JmdjhyTXJPVS9P?=
 =?utf-8?B?SlZTOHBUQzFRTXpxWU9kNFQydWl1d2N4a1lpSTdQU25USFJTc21FakpxNVF1?=
 =?utf-8?B?RWxqd1FkUXpodmNucGp6bStEWXVwdU05cERuOTRBUURTcHB0bGhjQ1BTYm9E?=
 =?utf-8?B?cmZraW1jME11QWVqandKbFdxYVZGV2FLVFpBNno4VmRkNE81TjJKbmx1VGlx?=
 =?utf-8?B?OGFRYnVvcnpHWlFMRXM0ZHZIQ2NUa3V3VGYzUkFlTzdLOU9SQXFPaHIxVkR4?=
 =?utf-8?B?RHR1WmhHdHdEbTZDN0pSamluMGh1cmtiSEoyMHEvVDByeVdsNFp4dTBlRDZQ?=
 =?utf-8?B?eFJ5clVpd2NseUJMS004N2dWZ2M1MWJJSERzMEs5cVRVZm94WTR5ZHlPWkJD?=
 =?utf-8?B?UDlsSXJodkQ4bXRadXo3N3ZZbENvemJMVFJnZTFPbjd2TEs5czFZOEF0MGY0?=
 =?utf-8?B?NUdtQXFhL1J6NUVxUFErTkJZSzRjL0x4ZSsyRTdwRVdQV1E2L01POTdldUxo?=
 =?utf-8?B?QUxGRTNyeUh6VnFXcFRKOGJ2K1NJR24yTThMUnQ0Ui80RXJiblZSd0kyR2M1?=
 =?utf-8?B?alNxUzVPWTNjYkxLRzNkL1FLemJvS1FaS0dETVUzOGdjOWEvRFpQNmFPRFc4?=
 =?utf-8?B?TDFIUUV5TW1CSmNyR0dXd0xvUHNDcnU1VnhGZmd3MU50THVUWHdjOWVxUDl2?=
 =?utf-8?B?THRRMEJubFk5ajQ4SUxpbDlYc0t6WEV1bDByRGtwM2NsaWQxNmVKWmIrYVM4?=
 =?utf-8?B?bER1QzI5eTcxVG94ZzFDeEI0Vmh6VlVqcG0ycFRNa1BDVEx5djVqUE8rb0NP?=
 =?utf-8?B?Vk9zRTRvL1hTYTZ5M1UvS3dFemh0emZCcFNBMVVGbjI3M3JlS0U4cVYvcEox?=
 =?utf-8?B?QXhxYmJ3WmNoblhEdEpKaW8wVng4dHlGL3lUUGI5N3JZMmJJOVcxM0NSY0dR?=
 =?utf-8?B?N1ZCY1ZPbWxFVExYejJWRVlmQ3NrMWFSU1dsSVNMZkdGanZYQ3B1TEFyVkpo?=
 =?utf-8?B?UHhCZm5ON3d3dy9va09yUFhCMHQ2Uzd1WlV2ODlBL1h1bU4wZXJ5VGZNRFQv?=
 =?utf-8?B?ajFWL21HSEViOFNPQUlOUDNIejhML3BjUFBNdGh5aC9Xdm9aY1ZRTDBsd25p?=
 =?utf-8?B?RXJ4cERIUXRpb1pJQU1SQVFzbDEwckJHR2NkVHdBSmUwS3NZTWQ2T09VRWVv?=
 =?utf-8?B?S1gwdWlVN1ZMYTJyeWNQOTJveTRRNnRtM0liNXk2WUNrbkxuUXdqQWJ1N2Nv?=
 =?utf-8?B?VjNCRGhYbllwc24xNkUyY2ZNL3lBbzNKUlpUL05yQTJvN09JMnB6djh1dWJz?=
 =?utf-8?B?TmZxYnZBWE83K1Z6Yjh6U0hFVFB1b0xBcXZmSGlJKzAyMXI5OXlOYmQzSVpC?=
 =?utf-8?B?L0NkZDlJNlYxRERsTzJ1TU8yTUlmdzFCYTlNNGo5ckl3cEE0UlE2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708559b4-09ea-418a-aa1b-08decd6a9e07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:33.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHBK+Pum9SYQDWyXNMWFF6lg+jCmAYk2eogsQN8OajvX1OustpgMdf3Vy+q370l+h4eam1ILzNsrRfeDSrZwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The Slow-deboost WARN_ON_ONCE in rcu_torture_one_read() currently uses
only the handler-context predicates to decide whether the calling
context is "safe" to assert immediate deboosting:

    !in_serving_softirq() && !in_hardirq() && !in_nmi()

They do NOT exclude several other contexts in which the task is still
holding an implicit RCU read-side critical section.

  1. local_bh_disable()-but-not-in-softirq.

  2. preempt_disable()-held.

  3. irqs_disabled().

  4. rcu_preempt_depth() > 0.

The current predicate set lets the WARN fire while these implicit
readers are still active, which is a false positive: the user-visible
"tardy deboost" finding becomes ambiguous between an actual
deferred-QS bug and a valid caller still inside an implicit-reader
section.

Replace the three handler-only predicates with the following which
covers everything.

    preempt_count() == 0 && !irqs_disabled() && rcu_preempt_depth() == 0

Note that we only check in contexts where rcu_read_unlock_special() deboosts
synchronously, i.e. where it is not inside an implicit RCU read-side
critical section. This matches rcu_read_unlock_special()'s own gate
and rcu_flavor_sched_clock_irq()'s:
 "rcu_preempt_depth() > 0 || (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))".

Also note, in PREEMPT_RT, softirqs always run under local_bh_disable(),
which itself takes rcu_read_lock() to satisfy RCU's bottom-half
requirement (see softirq.c) — so rcu_preempt_depth() is non-zero
throughout any RT softirq thus making in_serving_softirq() redundant.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 13e0eec1e1ce..e0bea4039c42 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2603,7 +2603,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	// rcu_read_unlock() does not end the full segmented RCU read-side
 	// critical section.
 	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
-			 !in_serving_softirq() && !in_hardirq() && !in_nmi()) &&
+			 preempt_count() == 0 && !irqs_disabled() &&
+			 rcu_preempt_depth() == 0) &&
 	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
 		nsegs = rtors.rtrsp - rtors.rtseg;
 		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
-- 
2.34.1


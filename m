Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C63B4E8A;
	Mon, 20 Jul 2026 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578178; cv=fail; b=NNEY3Fr4+jilL2JC+JSiRnXKrvC0dLfXFyd63gUXbvNrfBY/TyQZzfQcgAphF+3QYL1ArKepmnzr66ob7BSpHZbDpjnjP++b9zS7p58CFB0fm37vlQ+quHqa7sc+6L1bM1ZNfOVE0SywuNMSKozaFTcrTp+N/ImQk1jHWHHDXFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578178; c=relaxed/simple;
	bh=2RKqQWEXZLaMAHYfHArsbhdI+oNQCwjAqJcyHm7bocc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nrxq8DKxO6+M48tmTvqc2DqGrUL3QnH1LV7jq5diUiEh49kFvokMmqPCY6OUVBG8R5rFhKRi6KYXWwBEXfm4VyM2WJYZAkZAWXpAIlzByjWCOXXIvDKEgkyH+gtVS47rtQqtk87zsNfugbRT8tUaFs4m7qz2A92lfcSreRJi7Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOmL5lC1; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOmL5lC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRrtqY7fAMsUmbCXG2DeUPhXRXp2TrOocmPBbShsYlLCmk3eqlI1NfAKZEl87T/PXIi1Jcig4R3HDPAPaV+d7Uk3sjLEaThDIHHE+ron7+sva9xUhqx9rkUFdttoE6MesuU9x26ojy3/zOukdXh9Gskk53s4YM0p2qxKRXfaKxJziy3KE17lgdJn4hG1vNy8zB5PvinkBewYq6fmqpf5YYSrYFjYfeWNnCXCBIXo6C1+CD/Cs69u4Gaz96JiO5Co0I9+lQHYSOb1XUMIShZZjLAy5Whmnq6lypj8aw4OFhsM6+khB6bMq7vXexF2KMCMNowYjsZP3iDgkEAtf29LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kLYHERzJShf+Ye0xCvyP0jkzscXJ23A6ZpdyjhFcKM=;
 b=STLPl+4CIAJi7qy2GFiePsJ4vRjx48x3NE9JtvauOtV3EPGb6jcVmRdb7G2JrbwoFYbWMSci7QpUvHHxY14NIvDTnj7i9RFz0hDUN/5N1s5psoQmnysi9RMFrGwCnxLvvnjh55f3ZFe0/eoidBvmILTD4Uye+9/WdqNS85kKQMvzeni9WxDDHx8Qp+reFWIWgggxFZSpFk600rTEtzgltlrkb2ExrQTwabNZD9mkL/0vjYtUSFzDIe61dSHfPl/Etaiu0k2zULMqX1UW97Io0OpB5otlAEUElDnScwsjiEhiZVbLJ9cxHy3alKveSJZ/feI2iAp6bBf7LI6VjkYEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kLYHERzJShf+Ye0xCvyP0jkzscXJ23A6ZpdyjhFcKM=;
 b=UOmL5lC16SemYjAoak7umUSqL5PyIoIyHeIDSDf41HnUiyCbYAtIHu73ITtFRm3cYFFLWANBOCBOcHHM2tVEIFkuJPVCPnQcB8y2Q7jrDM5YI3HfKYt/CxR+pH+rKBnVfM7ZAH1yNP1FbzN+OjRhWYUHYA3GtbnuKtwe6GWY633CNz0jnf1G4jl67sKj0qyk7+mbNEZzEXLS8dsdwUJ3XS8ytH8lkZxwobJWN6nPqbDDbPdW36CP7T28Uz4d8SM0v2SxGvHvJimpAXNzAjEOcSj/9CukX+uXwWrXJYYWtBGq3X+cd5hn8WqsmscamncyPzhH/43b4hPNYDCugZkc2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 20:09:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:09:34 +0000
Message-ID: <92bc2631-35d4-4307-87c7-15922b60c21e@nvidia.com>
Date: Mon, 20 Jul 2026 16:09:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] rcu: clear defer_qs_pending when notifying GP
 changes
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-3-joelagnelf@nvidia.com>
 <b4a72949-d816-447f-9c9e-93b33ddf6aae@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <b4a72949-d816-447f-9c9e-93b33ddf6aae@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e0a455-901d-468e-1886-08dee69ad0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|4143699003|5023799004|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	icXyLV7nmQtroDvXx6LhxOmZGgju+rk+NaItsvRQFBJyasmMLZJehNDDc31z45QzJGV8NhMqR3g+vSldQsrBLgAcHaXtehRH51hU9i2Sc/rhJCXZ+loApovqVSMnYxDN6rTjjjwP6JlCCIl5CsVNcFHBcW+++K0/ZKpwYcelRnMuPHd9mNe6jcGV4S+zdF7h9i734hsVZ7qNRuWbezepGFqxRsf+Q3RTHNU0VqmQ59yYKZv5pxFru/W/nJarEYP0vYAYvUsqdgVHF0VK+1hAeEXjSy1CUi3ZyRRfjvZ0esT/76XvoIFHIio7ZfO1pDcG3OyLzdOsmOlb69rscUVCFFZ+5YAp0788OACoTl4dmGo0WYekYIYifFY/3X9ZVGpm/37NkLdiG490mzjEIOD+1knHsc28UuR2WqYPk1F1i3RhpeOsTjJMlwr7eD4OmdCjSCWddcBB2jrTUP7BCMkpBskxDOy2yqTJ57kfoL865y+s6zOnyKs2z/IMBiu8FY/o6AebWvdQzEGBwbrzFYhpkbBsa7bUtyCxfqiMDhW1/l8IrCrGm43N/sqScTjBGl6xPbXiI3HWh+T2n5WziYNdR1Tj4tpQheXDRpcLKX0d0ZH2/25N0OZgIRVppdSrizJuQqJgLqWte2m1Sosw2RLBSebvlvAO2OGL+ShSF30yYgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWhRZnlTa3dKRTlpQjNNVldaNWlnY1BMdW8zcDM0YzBaRXNMbUQ2NmxmNlk2?=
 =?utf-8?B?eGJXcUtoS0M2amh0NCtLNlJ0a3JRMlpaT0IwN3hSdFVuN250Tm1TU0VRNXFa?=
 =?utf-8?B?TzZDcmZacUd2cEEzYW5qeTdYZ3VyV3M3SVJlVmxMdVUwNGpyMWowNktPNEo5?=
 =?utf-8?B?alRnbXpMYlRCREQ0RnZKdlc4L05PNlhCWWxzUjVRLzU3UGw4NWI2cnpBdEFl?=
 =?utf-8?B?VHd5TXJUVVZFYk5WVnB0MnF5allFWmk2VHF1YjIyZTBKekxkMUhKRHRwVWc4?=
 =?utf-8?B?YWFHRnA1VUpDcmNScnYxNWREbEJGNTVIWER1b3RCWWEzSTk0RHNZTlJ4NHUz?=
 =?utf-8?B?YlZEM2FVUkhvVXdDNktrVDdOZWdjWG4rcU11TTdGSkpYOE5CQ3M2d1MyLzJ6?=
 =?utf-8?B?UmQ2eXRVZnIzbDlNWEFGeEJHOVpiU2NQYmNVUDBuYzRRUGd6VmY0dW96ZVdz?=
 =?utf-8?B?b3pyV2V2Uk01NWRqTTlWSk03bW9NUExoL1BHQVZUTzNpL1Z3RDN3NkgrUUpR?=
 =?utf-8?B?OVVtWFNVeDF2UVRzQUVUSHZGbTRocUFNOFpQSm5KRjc0eTVtdUZOTVJSQzJZ?=
 =?utf-8?B?SU9ERGxGQzVRSE0zTmUwMEUrc2R1YnJxYnNLVFlDcmpXTEVmUFZWdEk4aDhE?=
 =?utf-8?B?aFhhWlk2Y3NGWkg2VmZWZDJiQVVVRW03Q2daUEdQVGNpR1NOSXliY0UyRWZQ?=
 =?utf-8?B?QmttU2VOL05hc2Q5VXA5Rk5TOE5WZC9nd25vRTd3WE9VSk1PYnZraHRYZERx?=
 =?utf-8?B?N1RoN0g0djN0eWVRR09vaU13YnBXZlc4NE1JTzVoT3JOY1JSdW4rRmlYNVFI?=
 =?utf-8?B?cTVQWHl0Y1g3NHJnSGdoamZ2UHg2TzJuQzdmcXA3dnN3MEttYnd6aXZsNDhx?=
 =?utf-8?B?dVZkbzFXU2EzUnFNUVh1ZnREL1ZGWVFuM244UHhVUlJQT0lhbHozRUdBckJU?=
 =?utf-8?B?UGtxcHJvNDgrbFFwY0FGWHVzSHNhYjZza3FySmJON0FUNlk2NmF4eWdQVFJr?=
 =?utf-8?B?U0xaMUNHUWRXZW5zRVpkcWsvRHpuMm1jQUdKVERvQ3RuZ2xNd3F2Rk5PK0VR?=
 =?utf-8?B?S3hqRHR5ZkRZWENpSlZac1VhQjZXYUZRUStuSFpVTHZiNzFFTVV5bS9GaU5R?=
 =?utf-8?B?RUtVUUVRNWJGU1NlVm9WZHpTUVhRdlVvOWVKbmNJRkhwRUdEUC9QUlNHZ1Jo?=
 =?utf-8?B?bDlmRURxM1ZtMUExVmg5ekhzTDVIUjFHY3VGL3I3bTZJUEN5dXd6ZitYTkxj?=
 =?utf-8?B?YnEwdmFONnBzcGNNZG0vVkpESmVqQkY3Tk8vMjcwUHFpem14aGdldTcweWR4?=
 =?utf-8?B?Z1pEcUNzNVN6aTdUUHVBL2gveWdGQmpqamMzNTNIWCtFYU9OTVpJMElvaHdo?=
 =?utf-8?B?N0dUWXpEZmt0bi9nT2lraDNGRnlwNklmYW9ReEpkekQ1Z0t3UTdWcTNyZk1E?=
 =?utf-8?B?MHVQODN1SG42UTM2d1dZRUFUamxTNFl2MmxTREQwcE9OeGl6S21ZSjNzZEov?=
 =?utf-8?B?aUZETXNmV2NJSXlIaEVmZXVyZWJpSkkyZXpwRmpsN0NVcHR4dTM0bkc5UmVn?=
 =?utf-8?B?alhzSzRNWkVKbHBkd3lZUW9ZSm1laWdSK0J4VTAvVEhCY2ZDN1pidk0rMHVH?=
 =?utf-8?B?cE1Cakd6Nndud2FQOWo5dHJ5SWJENVJMVnJtaEkrNU9RM3h0TmFTM1dNVW9p?=
 =?utf-8?B?YXVDdVdjTWlXeGZJUlZ0QmJxeVlvV2tFU09UVDdDNk50cFdTaURPNWo4RkhZ?=
 =?utf-8?B?eHloMzdERnlEZ0ZxZXUvRzl2UjVVL3hXaXZ3UVBOZVhmQkU1R0ZHY0ZuTmxH?=
 =?utf-8?B?aWZiYUc3QVZvSTRTQkdiNm9lUVhTVlZ6dnp1bUFqUEM3dXowNkRZa090N1dv?=
 =?utf-8?B?bDNrR3dObVRKdWVMWVNOV2VHVldrZ0p6cDRKQWlPREdOUU5lcDBzSTlVZGRw?=
 =?utf-8?B?QmNQRG5la0Y4TVhqL2s5SHFneEdURjBaTlJEeXdGVzJqWC9Pb1VRaUpEcWhn?=
 =?utf-8?B?dnRGRks2MHRlTHozcHJLUFBTb1pGWHdUUnhIZHRBK3dCUXdDL3Q0eWNJUFZa?=
 =?utf-8?B?QVU1YWV5RHZKOFFZaGtSQTVFaXM5N1djMDNEUjFsZlk4ZTROZTBKSXcvVVds?=
 =?utf-8?B?THAvMFVHK1NKM2lpcitHWDNjS05oZWRTS2JnYlZtZFZVWE5kWlNybnhDNnVQ?=
 =?utf-8?B?YkovdkU3MXkrWUIrTUNXellWWU5MNTJoL2FheU54Rjl6NEJVUEtydVlHSDlh?=
 =?utf-8?B?d2U4L2V0eVRmaHYxckgwMWFnaHhkV0Ezc1luS1hnTXFrcmRQamdoSXFMU3Zx?=
 =?utf-8?B?VFdTSklMK3JHMm1lZnkvZWNsTlR5bFZCZ09DV1lXQUJyaVgxdUJjQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e0a455-901d-468e-1886-08dee69ad0ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:09:33.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVIN2h5dUfmzGakVKzWy97BOpzhqk/NYYh/8/RVdlTnS9JYGgwFD/c2AfDCbiAFKAUSyka6veHzrh5EjPKq7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167

Hi Paul,

On 7/15/2026 4:45 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:42:55PM -0400, Joel Fernandes wrote:
>> Prior to this commit, defer_qs_pending was an unbalanced flag:
>> rcu_read_unlock_special() set it to PENDING whenever a deferred-QS
>> mechanism was scheduled, but the clear paths did not cover every
>> up-tree quiescent-state reporting site. In those cases the flag stays
>> PENDING after the QS is reported, and rcu_read_unlock_special()'s
>> pending-gate then silently rejects all future arming attempts.
>>
>> A test patch confirms TREE03 can have get into the problematic stuck
>> state very quickly (< 5 minutes).
>>
>> Clear the flag in __note_gp_changes(), right after the nothing-to-do
>> early return.  This is the natural per-CPU "GP transitioned, sync local
>> state" hook, called from the GP-kthread's rcu_gp_init()/rcu_gp_cleanup()
>> paths, and other GP advancement paths.
>>
>> For dynticks-idle CPUs, they do not call __note_gp_changes(), but they
>> also do not arm new PENDING work (no readers running), and on wake-up,
>> note_gp_changes() is called before any new reader runs.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> This looks plausible, but suppose we have the following:
> 
> 	rcu_read_lock();
> 	// expedited GP plus preemption.
> 	preempt_disable();
> 	rcu_read_unlock(); // Sets ->defer_qs_pending
> 	// CPU takes unrelated interrupt, softirq handled, kicks
> 	// scheduler, and clears ->defer_qs_pending. Note that preemption
> 	// is disabled, so rcu_core() does set_need_resched_current()
> 	local_irq_disable();
> 	preempt_enable(); // Cannot reschedule here.
> 	local_irq_enable();
> 
> When do quiescent states get reported?
In the regular paths? That is eventually a scheduling clock interrupt,
transition to idle, or context switch. This patch doesn't handle the above
scenario, that would be done by the timer patch.

This patch handles the case where if the ->defer_qs_pending flag was not
cleared, then it remains stuck forever.

In this patch series, we avoid clearing it once the deferred work runs,
since we don't want to re-run it to reduce/eliminate recursion risk. The
only case where we'd allow to re-run in the same GP (by clearing this flag)
it, is if it ran but did not do any work. So the idea of this patch is,
making __note_gp_changes() as the single point of clearing.

That's why "rcu: drop redundant defer_qs_pending clear in irqrestore
handler" is subsequently added later (it depends on this patch).

Thanks.


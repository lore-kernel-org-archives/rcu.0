Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1325A640;
	Tue,  3 Feb 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100350; cv=none; b=HzDcWxntEAlhO5K9NChGUWEgL9HCs0KRwJuwiWqjZfKbOYvhjimjUddGBqnI6Ce8EJt2+ExgNBNrvgbj/srJTOtarAmqh8Z+eZM4NfnbcxHnK+QAHk3OX0uNOac6ZNHGj34DQ+DlDgGUsG3iT+TqSVVFZpIzRYBtpXdT0++oOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100350; c=relaxed/simple;
	bh=PYaicRzS3nW4/jrb6UmqmLg+UWUDNRXj2v+MzkaFnH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=usYeqo4LPjKAJ8tULiaiaFKB80ppehr12I9zP2lefYC9mYk/BSL64pnmnoHaKw4MhGH1xhwHwdP/klAJV13A0m/BGwWL60jbhRR47yc/tSB3SbK0ANIQOlXj+4rGN0KhLLoexs58jVKqFBt7xNWLDgL8Gw9SsxwqG+/bIGd3GCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PhG3S+N5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PhG3S+N5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612Et0dE024345;
	Tue, 3 Feb 2026 06:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QLDoHy
	S73YRwzZGtmZgTz7ply/XQ3ejuAKgdIiwNfvM=; b=PhG3S+N50G8eezpdVrr01x
	LPdK8gl+274T+zbkNlr+ZDF7UtazVWyiCtOB4rSBdIPdhCQxIxlXVvp81nJtAbqG
	FfL0fSmX+EpPu24SQuuPQ0cNkCKnTNvQolqK7cxVQYS4fwR880aQwnaPQWiF0T1v
	KuV2GG3rweVSOLH+Cgwut3O9LVCdVkoU1t84tgP5C03VbuSecYcozUWEbSE9P6B3
	gVpcKYP4ahPVe1FRGs/Phpnd2ECy4/gqMmXU/slfmXMbHIXy1Mq6su4eAD+QgMi0
	EpAcTfVXP9xj8dn7WLcPGH1qVhQ4+em2UOlJxWtBSoJvvD0sDFxJL44kzwLMl4TQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mt496-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 06:31:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6136Vf2C007759;
	Tue, 3 Feb 2026 06:31:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175mt494-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 06:31:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6131nVC7027348;
	Tue, 3 Feb 2026 06:31:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs17r2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 06:31:40 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6136Vdgv17891922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 06:31:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 133D35805F;
	Tue,  3 Feb 2026 06:31:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90FC058059;
	Tue,  3 Feb 2026 06:31:34 +0000 (GMT)
Received: from [9.150.1.160] (unknown [9.150.1.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 06:31:34 +0000 (GMT)
Message-ID: <367a0168-be38-48ad-b55e-688d8eaaca49@linux.ibm.com>
Date: Tue, 3 Feb 2026 12:01:33 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
From: Samir M <samir@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Vishal Chourasia <vishalc@linux.ibm.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com
References: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
 <20260119104739.439799-2-vishalc@linux.ibm.com>
 <20260119114333.GI1890602@noisy.programming.kicks-ass.net>
 <068ef765-8999-41c0-8733-1184df2adb3a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <068ef765-8999-41c0-8733-1184df2adb3a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZPpv-DvlvvnrTnrApgk14ju2MJab7r9M
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=6981964e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=TamxRIn04D4bn7PoTbwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _UFiijC8M9ddTgXw8q2tReZkb3ywrYqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA0OSBTYWx0ZWRfXyGSe5i9nB+CX
 1UlOOkVInYy5+6UQpYPssmysvk1yAgp4QnD6pCjMU3kbNQeNMTjnXj2tds1LtEjPwKcvXJ8OhIR
 ZIB+FYkcwvQT8QKaQjRc0olCnoreLMJ0QCwhes0RuBGYWKNrLn2G8+6oTA5iP4P/hfY2rlPakm7
 Oqy08e7XEZf4SZEgW0+6v1DwVSk7h6xgf4pEPYc7QkG9hvBVnbEfDFtdb1VGPr4z6EEp9NeDMBI
 wQTABl6Yup5gJhAgu389HMCX2bWVUzlE59HSFj7u3KBbiRc/uCDafG3j7xjVoPNY4Xzq62yPa6Y
 7bIp6e5GvNyibvJzTv6mPCcGj5ulgCIEUHJTpwoG3sxJr+gWD1V2Wr3yJbMPeLX/N2wsm/N4NmG
 JjwI5UI1OpeDEgE91ZJQfMWEDsat7YJrCLtVvEeTvJLFVjihvjrWiLIRbxlGD1Mel9hDvInasJk
 CvafNhsZ23yGhFKX1/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030049


On 27/01/26 11:18 pm, Samir M wrote:
>
> On 19/01/26 5:13 pm, Peter Zijlstra wrote:
>> On Mon, Jan 19, 2026 at 04:17:40PM +0530, Vishal Chourasia wrote:
>>> Expedite synchronize_rcu() during the cpuhp_smt_[enable|disable] 
>>> path to
>>> accelerate the operation.
>>>
>>> Bulk CPU hotplug operations—such as switching SMT modes across all
>>> cores—require hotplugging multiple CPUs in rapid succession. On large
>>> systems, this process takes significant time, increasing as the number
>>> of CPUs to hotplug during SMT switch grows, leading to substantial
>>> delays on high-core-count machines. Analysis [1] reveals that the
>>> majority of this time is spent waiting for synchronize_rcu().
>>>
>> You seem to have left out all the useful bits from your changelog again
>> :/
>>
>> Anyway, ISTR Joel posted a patch hoisting a lock; it was a icky, but not
>> something we can't live with either.
>>
>> Also, memory got jogged and I think something like the below will remove
>> 2/3 of your rcu woes as well.
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 8df2d773fe3b..1365c19444b2 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2669,6 +2669,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control 
>> ctrlval)
>>       int cpu, ret = 0;
>>         cpu_maps_update_begin();
>> +    rcu_sync_enter(&cpu_hotplug_lock.rss);
>>       for_each_online_cpu(cpu) {
>>           if (topology_is_primary_thread(cpu))
>>               continue;
>> @@ -2698,6 +2699,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control 
>> ctrlval)
>>       }
>>       if (!ret)
>>           cpu_smt_control = ctrlval;
>> +    rcu_sync_exit(&cpu_hotplug_lock.rss);
>>       cpu_maps_update_done();
>>       return ret;
>>   }
>> @@ -2715,6 +2717,7 @@ int cpuhp_smt_enable(void)
>>       int cpu, ret = 0;
>>         cpu_maps_update_begin();
>> +    rcu_sync_enter(&cpu_hotplug_lock.rss);
>>       cpu_smt_control = CPU_SMT_ENABLED;
>>       for_each_present_cpu(cpu) {
>>           /* Skip online CPUs and CPUs on offline nodes */
>> @@ -2728,6 +2731,7 @@ int cpuhp_smt_enable(void)
>>           /* See comment in cpuhp_smt_disable() */
>>           cpuhp_online_cpu_device(cpu);
>>       }
>> +    rcu_sync_exit(&cpu_hotplug_lock.rss);
>>       cpu_maps_update_done();
>>       return ret;
>>   }
>
>
> Hi,
>
> I verified this patch using the configuration described below.
> Configuration:
>     •    Kernel version: 6.19.0-rc6
>     •    Number of CPUs: 1536
>
> Earlier verification of an older version of this patch was performed 
> on a system with *2048 CPUs*. Due to system unavailability, the 
> current verification was carried out on a *different system.*
>
>
> Using this setup, I evaluated the patch with both SMT enabled and SMT 
> disabled. patch shows a significant improvement in the SMT=off case 
> and a measurable improvement in the SMT=on case.
> The results indicate that when SMT is enabled, the system time is 
> noticeably higher. In contrast, with SMT disabled, no significant 
> increase in system time is observed.
>
> SMT=ON  -> sys 50m42.805s
> SMT=OFF -> sys 0m0.064s
>
>
> SMT Mode    | Without Patch    | With Patch   | % Improvement   |
> ------------------------------------------------------------------
> SMT=off     | 20m 32.210s      |  5m 30.898s  | +73.15%         |
> SMT=on      | 62m 46.549s      | 55m 45.671s  | +11.18%         |
>
>
> Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>
>
> Regards,
> Samir
>
Hi All,


Apologies for the confusion in the previous report.
In the previous report, I used the b4 am command to apply the patch. As 
a result, all patches in the mail thread were applied, rather than only 
the intended one.
Consequently, the results that were posted earlier included changes from 
multiple patches, and therefore cannot be considered valid for 
evaluating this patch in isolation.
We have since tested Peter’s patch separately, applied in isolation. 
Based on this testing, we did not observe any improvement in the SMT 
timing details.

Configuration:
     •    Kernel version: 6.19.0-rc6
     •    Number of CPUs: 1536

SMT Mode    | Without Patch    | With Patch  | % Improvement  |
------------------------------------------------------------------
SMT=off     | 20m 32.210s      |  20m22.441s  | +0.79%         |
SMT=on      | 62m 46.549s      |  63m0.532s  | -0.37%         |

Regards,
Samir





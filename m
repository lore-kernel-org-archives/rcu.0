Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF437998C;
	Thu, 29 Jan 2026 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670488; cv=none; b=JTSjE4ultYrmKkfVlrtKJLjAJMUwkrv9IFiJLG20JJ5XB09K6ZMdcJyR6LGVPbXZMLGlCqK7SlXnhlVsg6wuiWzcTNOKQJ0U4QBBUgU/a+tyudVaOawJLv7FGBHw6y9ZxIl3qg/q6dlzimgDuVM6P+7o6t3r3Jd2QYHivSoIyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670488; c=relaxed/simple;
	bh=GEY/UJRx/l0XxMMxR3tacqoOO5xJgtoA23hXybVHO1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nMRp0LySJThevNobWU1oJeowxICNrNWsTlX1vOxOBeiRIl8QoNzBm1aJJzLRP7I0LcXOeKlfgOmbhV5V56+PBTk3ikSJrUcbJbm2ID9Bu40UPa/IG+6PNKBy4rGDYfxCrYPn4bpdkGvquRBGwZ3MfKl2OMtgMmHoHHnBvg7uHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B23zJvix; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B23zJvix"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SLbE73011234;
	Thu, 29 Jan 2026 07:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IEjNpV
	uG4lDL3xvKfVKYXqo8aTrPUCFVqE5m9s0ghhM=; b=B23zJvixnMrWX6/2MjF6Sh
	lnAeUB307BhiVg5Bi4vOs6LveksiPzkbz027fZx81+XTs1ReocRKaquFvpbOXTyQ
	6V1BxZ4VtsXJHV9M1lvmNr+77gouXEgl/0MTDaMfM+F7HXdTLtPr+j9MPY2rQ1qE
	/GmIYNVP1+VQWsQdWqfPTQNdC/H7xqG+pSbOa5sdve800rJ0+mvMT0Eyq3+d/wX3
	Ur30iLuXMmdUW/ESPjTk2YK6xB1Nv/IQOLaAsrVau6FgebQGw9YEzXKLGwqFdwZR
	mLjNl3Rc+7XLIkCtVtM5U5cwJckcnGEHnpbwnW/dNTcAf+RdWoDtKAZqVOmJyUdQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg4vxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 07:05:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60T75MLE021539;
	Thu, 29 Jan 2026 07:05:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg4vxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 07:05:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60T2MFlj023624;
	Thu, 29 Jan 2026 07:05:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk0hpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 07:05:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60T75Iau19202570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 07:05:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA6B58059;
	Thu, 29 Jan 2026 07:05:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDACD58058;
	Thu, 29 Jan 2026 07:05:13 +0000 (GMT)
Received: from [9.109.204.91] (unknown [9.109.204.91])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Jan 2026 07:05:13 +0000 (GMT)
Message-ID: <e2cca734-9191-4073-ba9d-936014498645@linux.ibm.com>
Date: Thu, 29 Jan 2026 12:35:12 +0530
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
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697b06b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=TamxRIn04D4bn7PoTbwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0AIWiM_93sMYOUDDyp1bTQN6qvrnN5qE
X-Proofpoint-ORIG-GUID: XzeQFtLTqQKCU8i-Y9kHn6zKN5V-rOWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzOSBTYWx0ZWRfX7zAx5xl/9Owd
 klqmb1EfiQwincWr1qMxRGWmWspjZOJMjdhR8EPwu8cYSZRWw/9vxhl4eXQJ65FWBQhi+/yLa4m
 UBsIw1dud3kFPldRT/BPJJrkU54/M6iTv6L0OZWfkYnFWVcJ9/YlsXJpBcATWwmhYZVzJVPqHBw
 6J3cFQUxPBvT5CHaP/XWdw32oiEBWitDJ0LMMLaltFQLk9WuI7VM4klIgv78p6ya22vDMUaMert
 eRCGLAfuaDdZBsg4HOvIm+OkSKCljRboaxzM2qyyzpVdiE7zEMLHl+nnyl0tN7s/Dk/+tkUPOHq
 5FR7FLW/9mpqos2nocjAVnY1ex7tjQfQ6UPdxb9kcyb/Uhxhj0tzP2Qp/BdCI8oBFP/NDVbdLWN
 E2kuNQGq/YslDul3cuAV1fZxKHCHCoi3qcZ3VajK4v5/5PBkFt2x3S5yNK3nZkgj1VUnp54s3AM
 q3APuLuHhWGhecPK+zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290039


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

For reference, I am updating the results for the Vishal and Rezki patches.

Configuration:
Kernel version: 6.19.0-rc6
Number of CPUs: 1536

Earlier verification of an older revision of this patch was performed on 
a system with 2048 CPUs*.* Due to system unavailability, the current 
verification was carried out on a different**system. For reference, I am 
updating the results corresponding to the patches verified using the 
above configuration.


Patch: 
https://lore.kernel.org/all/20260112094332.66006-2-vishalc@linux.ibm.com/
SMT Mode    | Without Patch    | With Patch  | % Improvement   |
------------------------------------------------------------------
SMT=off     | 20m 32.210s      |  5m 31.807s | +73.09%        |
SMT=on      | 62m 46.549s      | 55m 48.801s  | +11.08%        |

SMT=ON  -> sys 50m44.105s
SMT=OFF -> sys 0m0.035s


patch: https://lore.kernel.org/all/20260114183415.286489-1-urezki@gmail.com/
SMT Mode    | Without Patch    | With Patch  | % Improvement   |
------------------------------------------------------------------
SMT=off     | 20m 32.210s      | 18m 2.012s  | +12.19%         |
SMT=on      | 62m 46.549s      | 62m 35.076s | +0.30%         |

SMT=ON  -> sys 50m43.806s
SMT=OFF -> sys 0m0.109s


Regards,
Samir





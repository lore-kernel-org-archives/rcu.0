Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A421ADB7;
	Tue, 27 Jan 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536168; cv=none; b=CjYgqM+YIQ16rT2dEYkZ4K0x+joC1eak1doHUhXWXYGGGwu3gvZdrUYdpAzbO/aiC4JoeZB9JG6qThZw44nKpIj/S8XHb0yipwFrg5GsbLfs+iYEdaJzwJUrBM/LfhNU0DnN0iKjMzFs2OlPN+g6jeviVeULbHm2EpE0+X80Y5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536168; c=relaxed/simple;
	bh=QFxYuOb1sSL/KhoMhpDSpWc2zTYnLDPJaQmjqWvxVbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjQ1Aao1yLCq5WTYSGdJJYxh59YuwHS7OSAId8ryjjTNI+u3xA7WZoFUtQM4Ege3m8/iWNP6cnfeo8GAhN0Tuc9HHA4bsGPLfM8MonJdSeeEVSxDU0aM1pAQGVPsMVeWvYTLc2HKsJtWXi97GA0crWgI/fO2I013sm5Mlyk7Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kETodJEh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kETodJEh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RFrT34012473;
	Tue, 27 Jan 2026 17:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8/W3k+
	m/3uCbsmjXH0PkXudXaBF0GjW0Bl/I9k5UE+8=; b=kETodJEh13n4T56kKGBh4y
	uXfYP9llrQ6ZVIm2XVLM6JsAJu1QlWYwPX6xOpETH8y92jeSg8B8WyeZDaDfF/OB
	V2n2DHq6QxnySAW6feg5Ef/03gX08LeBLGx/aKAxYyohrOpGarFcINN+JTe0AIkK
	FPKdkbQXiKZQnU/YOtVPMqhsAUBQDm5RhdQeOei0N1Q2gPbzkSNNNSTA2tBP0A3k
	1UQuAVL93UXgyrbGVHqObtBttxbTYaPvAsYvGPyWWGNpmiGdtgsMNuPHkU8a2UGZ
	7aVt+zZxPGGB6ufdIkJiyDGUAoqdhDS3/Fjam2KM2Un/fEBtgLSdGvIuoEYy1RtA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7pw3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 17:49:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RHn9Uu022686;
	Tue, 27 Jan 2026 17:49:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7pw39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 17:49:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RF43vx018045;
	Tue, 27 Jan 2026 17:49:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41sds7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 17:49:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RHn79g58458500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:49:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5357B58052;
	Tue, 27 Jan 2026 17:49:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8C958056;
	Tue, 27 Jan 2026 17:49:02 +0000 (GMT)
Received: from [9.39.16.196] (unknown [9.39.16.196])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 17:49:02 +0000 (GMT)
Message-ID: <068ef765-8999-41c0-8733-1184df2adb3a@linux.ibm.com>
Date: Tue, 27 Jan 2026 23:18:59 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
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
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260119114333.GI1890602@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VSVA5Pt4waT0GTjRba9DyLa10-NF6LT9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX+FPVZHEaLt5c
 8GiMX+NnoLdc6RcucS0sSOhXo3sLjOdP+xRAERiMqR6kEhH3JUp4V+QxOsNvrAQtMf2m1/PtT5k
 MMnJoTf5pa87LpLA/O1athwDLibmU9Y2wFbuTx5LaTIhADsQ8OSa85ZtFv+IHC8VGdtb/lAuk28
 D6JDAH8E5S3wchZKgZGH2LVBMHBUw6wljLTJWE2t/gaHgZGWxYRCfETWsdzowvD/OIUas3aekSp
 0TvOVAQYXZnHfb8CEv+Od8GsCkdSNg5r13KvCsuAKywjzcCQP5WrcGpQ9KFneexeVnZD1MzL2FG
 P4izP3d50RniXPO/z/3YXTEPWY2iLndmZexzxbNieKdvR0ochcZkOJoMDrcAtuhWaK/TEUbjVtY
 qh1fhRSH0cvBfVecrENWS9O3GgIiSqhof2MaCspUNVUqBR430RF7Tnye3DhHRwQd7QSRlBfNU5G
 6YxgXJiwEoRV69G8RFA==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978fa95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jech3N7oF3ey5JcaSQoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QBtS7R_aSLaw1Kl5N-wEnVzClK1Tb6ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270145


On 19/01/26 5:13 pm, Peter Zijlstra wrote:
> On Mon, Jan 19, 2026 at 04:17:40PM +0530, Vishal Chourasia wrote:
>> Expedite synchronize_rcu() during the cpuhp_smt_[enable|disable] path to
>> accelerate the operation.
>>
>> Bulk CPU hotplug operations—such as switching SMT modes across all
>> cores—require hotplugging multiple CPUs in rapid succession. On large
>> systems, this process takes significant time, increasing as the number
>> of CPUs to hotplug during SMT switch grows, leading to substantial
>> delays on high-core-count machines. Analysis [1] reveals that the
>> majority of this time is spent waiting for synchronize_rcu().
>>
> You seem to have left out all the useful bits from your changelog again
> :/
>
> Anyway, ISTR Joel posted a patch hoisting a lock; it was a icky, but not
> something we can't live with either.
>
> Also, memory got jogged and I think something like the below will remove
> 2/3 of your rcu woes as well.
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8df2d773fe3b..1365c19444b2 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2669,6 +2669,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_sync_enter(&cpu_hotplug_lock.rss);
>   	for_each_online_cpu(cpu) {
>   		if (topology_is_primary_thread(cpu))
>   			continue;
> @@ -2698,6 +2699,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	}
>   	if (!ret)
>   		cpu_smt_control = ctrlval;
> +	rcu_sync_exit(&cpu_hotplug_lock.rss);
>   	cpu_maps_update_done();
>   	return ret;
>   }
> @@ -2715,6 +2717,7 @@ int cpuhp_smt_enable(void)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_sync_enter(&cpu_hotplug_lock.rss);
>   	cpu_smt_control = CPU_SMT_ENABLED;
>   	for_each_present_cpu(cpu) {
>   		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2728,6 +2731,7 @@ int cpuhp_smt_enable(void)
>   		/* See comment in cpuhp_smt_disable() */
>   		cpuhp_online_cpu_device(cpu);
>   	}
> +	rcu_sync_exit(&cpu_hotplug_lock.rss);
>   	cpu_maps_update_done();
>   	return ret;
>   }


Hi,

I verified this patch using the configuration described below.
Configuration:
     •    Kernel version: 6.19.0-rc6
     •    Number of CPUs: 1536

Earlier verification of an older version of this patch was performed on 
a system with *2048 CPUs*. Due to system unavailability, the current 
verification was carried out on a *different system.*


Using this setup, I evaluated the patch with both SMT enabled and SMT 
disabled. patch shows a significant improvement in the SMT=off case and 
a measurable improvement in the SMT=on case.
The results indicate that when SMT is enabled, the system time is 
noticeably higher. In contrast, with SMT disabled, no significant 
increase in system time is observed.

SMT=ON  -> sys 50m42.805s
SMT=OFF -> sys 0m0.064s


SMT Mode    | Without Patch    | With Patch   | % Improvement   |
------------------------------------------------------------------
SMT=off     | 20m 32.210s      |  5m 30.898s  | +73.15%         |
SMT=on      | 62m 46.549s      | 55m 45.671s  | +11.18%         |


Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>

Regards,
Samir


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EB36E475;
	Mon, 19 Jan 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830870; cv=none; b=pGpadao3aQv6mXUd2pfnans8235mnfB6I+tmj2TG5+W39j4BAsm/SSF6JmyRe1ju2J3Z1EZFMM0PIqJ/OKChteRxD7xS2gXeMt53VIXfEBOvNpYkfx+jw78YItbnlrtxOjT9TI7Bb4Hzfm7M1SwXz1cdni8u0gw7v1bhfUYeFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830870; c=relaxed/simple;
	bh=Ce2+EHKj9C9gTv9bq33F/89L847h95ZVNMPz+v1zTHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGjA5eaBf+dfQc0Q2FLYHv5PqFm6kuXg8nOlrddYfO7fzvxi3KJdxvMU5nV0U9X/ZvlfMwB2zRQcY1ZUWswIXMz1iUWwR4bfd+OKg1HCGBYCXkZ5dzYEjgy5KuAQrZAJq+/nymyYsKgpGoBEZnS+TX9fz5a5e71+n2AQODKk4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ksTrbPBQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ksTrbPBQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDC6Gt016569;
	Mon, 19 Jan 2026 13:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u9+iCg
	IMH/ivaMoYk8Ob4c5Bnyc9tfVJ4+G3ACKm5KI=; b=ksTrbPBQlKNopSSmYYMCHc
	PX5AhpT8UyhVOHASNDE2LzIhG1H6bNzlrClKgeqLD+RrZR/39pOVFIUFg7ILkLP5
	sEXPWr8SoX8ZP0tN4fGH6O9OsBur2JkNwbetOwQPMJfCIMC+qXFuRd84ZLpJh6TV
	UHF3/pHyyRl6KZ3tFRArthFgwIAp1d3oenR2CPSaMLH/EXNDtwyXYIWT523J/zhw
	B5Xa6ifDsxTgcD4BQlV/2oRgM5jkWdPnQiIZxITGopsLsvVaKBH4NB/dBIV3gbBk
	6Ll79YhQX2WyfQ9Y9vr3Ck28aGH7xaI5c/ZBepbLNo3ArJ1H1YThiKRFICW3OPnw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255rhne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:53:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JDbHFa013326;
	Mon, 19 Jan 2026 13:53:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255rhna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:53:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JAkNeL009273;
	Mon, 19 Jan 2026 13:53:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8jxwgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:53:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JDrlH315270328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 13:53:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0750420043;
	Mon, 19 Jan 2026 13:53:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC00E20040;
	Mon, 19 Jan 2026 13:53:43 +0000 (GMT)
Received: from [9.124.220.45] (unknown [9.124.220.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 13:53:43 +0000 (GMT)
Message-ID: <90ff4c0e-bef7-46e5-b183-54b2ded3b00e@linux.ibm.com>
Date: Mon, 19 Jan 2026 19:23:43 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
        rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        srikar@linux.ibm.com, Samir M <samir@linux.ibm.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <9e57a091-2f34-402a-972a-31dd9a10664b@linux.ibm.com>
 <20260119051835.GA696111@joelbox2>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260119051835.GA696111@joelbox2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExNSBTYWx0ZWRfX5hwq+P0tsJJa
 wBy+Gy/YYrtR2nq0k0bNtsGVc9Dm3Ep3QqFyoXx2QbLqHL9fW/fqtyBFrGs6HsFNnbFa7Y2rqd9
 oNQ9CsaKV82RG80kYxPlTu2WudNkEVbg16UFI9P+P8Rb8w5cRApIPcROroWilvZcUxq7NXId2vH
 CafBYurrkwYFtHDtMUpgkPVD4xLNl0hhQWmy2jUyu01CwfCSnzlmti7SNFY9dH4NOMXmzE6K6cF
 XRPR9O43Ak/zWtXVrL8ZB5LpuHm4RIzdM6nCNuNFAM58I3YV0T7PeR5MPP3Fib5d4LJZ0HJDIl8
 Im0u0cP6JoHseXQeRkm6kfBqco3oTGWqYTNoqgIcniC2KcIa2apDcSzQNy33eOmB5A6g2qImIMf
 vWfw+4qQLlfZ0Te0xfholtL7KtIPoLlKgtCRyJkKcQV7IIYl+WiPDdkB1fSu19SHt4isPoAF+Z7
 1cj7gGpmm6KIhUJd3uw==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696e3770 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=WsHKUha7AAAA:8 a=JfrnYn6hAAAA:8
 a=GZT8CYxAIrFVk51x1UwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H4LAKuo8djmI0KOkngUh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: JYcQYfIhPJgguV65W4BKW2dcMAnGRfc_
X-Proofpoint-ORIG-GUID: DTIG8jeTA4a6ymAkYBnYxMrC_w9LegWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190115



On 1/19/26 10:48 AM, Joel Fernandes wrote:
> On Sun, Jan 18, 2026 at 05:08:44PM +0530, Samir M wrote:
>> On 12/01/26 3:13 pm, Vishal Chourasia wrote:
>> > Bulk CPU hotplug operations--such as switching SMT modes across all
>> > cores--require hotplugging multiple CPUs in rapid succession. On large
>> > systems, this process takes significant time, increasing as the number
>> > of CPUs grows, leading to substantial delays on high-core-count
>> > machines. Analysis [1] reveals that the majority of this time is spent
>> > waiting for synchronize_rcu().
>> >
>> > Expedite synchronize_rcu() during the hotplug path to accelerate the
>> > operation. Since CPU hotplug is a user-initiated administrative task,
>> > it should complete as quickly as possible.
>>
>> Hi Vishal,
>>
>> I verified this patch using the configuration described below.
>> Configuration:
>>      *    Kernel version: 6.19.0-rc5
>>      *    Number of CPUs: 2048
>>
>> SMT Mode    | Without Patch    | With Patch | % Improvement    |
>> ------------------------------------------------------------------
>> SMT=off     | 30m 53.194s      |  6m 4.250s  | +80.40%          |
>> SMT=on      | 49m 5.920s       | 36m 50.386s | +25.01%          |
> 
> Hi Vishal, Samir,
> 
> Thanks for the testing on your large CPU count system.
> 
> Considering the SMT=on performance is still terrible, before we expedite 
> RCU, could we try the approach Peter suggested (avoiding repeated
> lock/unlock)? I wrote a patch below.
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
>    tag: cpuhp-bulk-optimize-rfc-v1
> 
> I tested it lightly on rcutorture hotplug test and it passes. Please share
> any performance results, thanks.
> 
> Also I'd like to use expediting of RCU as a last resort TBH, we should
> optimize the outer operations that require RCU in the first place such as
> Peter's suggestion since that will improve the overall efficiency of the
> code. And if/when expediting RCU, Peter's other suggestion to not do it in
> cpus_write_lock() and instead do it from cpuhp_smt_enable() also makes 
> sense
> to me.
> 
> ---8<-----------------------
> 
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] cpuhp: Optimize batch SMT enable by reducing lock 
> acquiring
> 
> Bulk CPU hotplug operations such as enabling SMT across all cores
> require hotplugging multiple CPUs. The current implementation takes
> cpus_write_lock() for each individual CPU causing multiple slow grace
> period requests.
> 
> Therefore introduce cpu_up_locked() that assumes the caller already
> holds cpus_write_lock(). The cpuhp_smt_enable() function is updated to
> hold the lock once around the entire loop rather than for each CPU.
> 
> Link: https://lore.kernel.org/ 
> all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>   kernel/cpu.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8df2d773fe3b..4ce7deb236d7 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1623,34 +1623,31 @@ void cpuhp_online_idle(enum cpuhp_state state)
>       complete_ap_thread(st, true);
>   }
> 
> -/* Requires cpu_add_remove_lock to be held */
> -static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state 
> target)
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
> +static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
> +             enum cpuhp_state target)
>   {
>       struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>       struct task_struct *idle;
>       int ret = 0;
> 
> -    cpus_write_lock();
> +    lockdep_assert_cpus_held();
> 
> -    if (!cpu_present(cpu)) {
> -        ret = -EINVAL;
> -        goto out;
> -    }
> +    if (!cpu_present(cpu))
> +        return -EINVAL;
> 
>       /*
>        * The caller of cpu_up() might have raced with another
>        * caller. Nothing to do.
>        */
>       if (st->state >= target)
> -        goto out;
> +        return 0;
> 
>       if (st->state == CPUHP_OFFLINE) {
>           /* Let it fail before we try to bring the cpu up */
>           idle = idle_thread_get(cpu);
> -        if (IS_ERR(idle)) {
> -            ret = PTR_ERR(idle);
> -            goto out;
> -        }
> +        if (IS_ERR(idle))
> +            return PTR_ERR(idle);
> 
>           /*
>            * Reset stale stack state from the last time this CPU was 
> online.
> @@ -1673,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int 
> tasks_frozen, enum cpuhp_state target)
>            * return the error code..
>            */
>           if (ret)
> -            goto out;
> +            return ret;
>       }
> 
>       /*
> @@ -1683,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int 
> tasks_frozen, enum cpuhp_state target)
>        */
>       target = min((int)target, CPUHP_BRINGUP_CPU);
>       ret = cpuhp_up_callbacks(cpu, st, target);
> -out:
> +    return ret;
> +}
> +
> +/* Requires cpu_add_remove_lock to be held */
> +static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state 
> target)
> +{
> +    int ret;
> +
> +    cpus_write_lock();
> +    ret = cpu_up_locked(cpu, tasks_frozen, target);
>       cpus_write_unlock();
>       arch_smt_update();
>       return ret;
> @@ -2715,6 +2721,8 @@ int cpuhp_smt_enable(void)
>       int cpu, ret = 0;
> 
>       cpu_maps_update_begin();
> +    /* Hold cpus_write_lock() for entire batch operation. */
> +    cpus_write_lock();
>       cpu_smt_control = CPU_SMT_ENABLED;
>       for_each_present_cpu(cpu) {
>           /* Skip online CPUs and CPUs on offline nodes */
> @@ -2722,12 +2730,14 @@ int cpuhp_smt_enable(void)
>               continue;
>           if (!cpu_smt_thread_allowed(cpu) || ! 
> topology_is_core_online(cpu))
>               continue;
> -        ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
> +        ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
>           if (ret)
>               break;
>           /* See comment in cpuhp_smt_disable() */
>           cpuhp_online_cpu_device(cpu);
>       }
> +    cpus_write_unlock();
> +    arch_smt_update();
>       cpu_maps_update_done();
>       return ret;
>   }

What about cpuhp_smt_disable?


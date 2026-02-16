Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C2309B9;
	Mon, 16 Feb 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246690; cv=none; b=DsXtKflYlVJnzes1KcmCy0K8uJNA8XhI4Z1TAopsFuebdxgmiBXLH9ewsvYmselOR8HfcoHrQJ2ZJUp88xsUOUskn1Qe9faT8noG8zHWYIzXjF3I2p6B5PJLnn5N6X5n0cmQ5fCFp+grvl1IV7ZUqr3WfZ4ON4qDPVLhQ8mSj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246690; c=relaxed/simple;
	bh=K1fDMhirs1fQRbIX0U/VrgUrbptwuS6KMtObPC8kwpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRNxK0KfV8PHOLQm5lMwso0VtLVigAlOxAc0xzm395347RQwikokXMQ/iiJmhDjz0Z6bKwDNPqG/sX+Bzkb89sgH7OzlZUnl/SgyaNfn3rskKNHbOl4F6G71fj5SQ2G6olmKAE+4JpdXToysddZnOgY2sToPJcUTYYrk9xYT5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMCEsXvJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMCEsXvJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FLEWCV3447192;
	Mon, 16 Feb 2026 12:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zyVZw7
	QTfOfBCFSilj7k/0tnCcevDMChkE2+zY9x4/g=; b=gMCEsXvJkxIk0c3drbmvOY
	PBrWsrf4N3leRVJlKWiM9s9SqmXJwNggDJkpF5qDApDzFAV29RoUfDak1qwCzzbQ
	sd9M63WFsEtvrFQXvv+uF1sI2HACB+Xp91NCFhKDzGI8ZMx8ejjZpj2r7vnme//P
	2s15JiraTST3cX0/vWUFtaW/hGhVzF3ym7HEJbKklNYWdf023pxiab4JQv+wGqU4
	7Iu0qA/2gFuEaZRyV2KiJe1Vm9nEMZ6FSvBScO/aRwzkciFW/EsaUrd32jAJuTcv
	6wWb9eOi2GEFLiJpls2a7iBo/tw2m00LGB5ILLPSSu8wBFLdWw4hLImIwbi0Amyw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rqmn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:57:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8I6is029084;
	Mon, 16 Feb 2026 12:57:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb63154uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:57:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GCvlbS29033184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 12:57:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 739702004B;
	Mon, 16 Feb 2026 12:57:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12FA620043;
	Mon, 16 Feb 2026 12:57:43 +0000 (GMT)
Received: from [9.111.89.117] (unknown [9.111.89.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 12:57:42 +0000 (GMT)
Message-ID: <e90f73b8-744f-4522-a9b5-55b924671072@linux.ibm.com>
Date: Mon, 16 Feb 2026 18:27:41 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpuhp: Optimize SMT switch operation by batching
 lock acquisition
To: Vishal Chourasia <vishalc@linux.ibm.com>, peterz@infradead.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com, aboorvad@linux.ibm.com
References: <20260216121927.489062-2-vishalc@linux.ibm.com>
 <20260216121927.489062-4-vishalc@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260216121927.489062-4-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69931450 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=u4DcNoN2nYi8Y6meJpQA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 4tv-tisl0OUtQ-H0Eg9245zlCiwoIca6
X-Proofpoint-ORIG-GUID: jzoOUvcDARYXevnmepIcwPrlWVz9RDiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwNyBTYWx0ZWRfX9xoGS1WI9r61
 FFqGRwx9g7JPH03zbeAkIJr+VCmppRpwem2aqtKaP+TWY+GzclfGNoXhJ1/JX8cVnq8I5Y1wApo
 IZSMfByTGOWbxxRN7g3ELHJFx2EzlurkKbZru8JJnopRdBHOvboYookHSoo4npaBiu4lL27rSFQ
 VyL9EOuwwBNyc3tZyLCLbw0+Qaj78PF8tNT7GQcf1om9yUuc5gZx5QsaGkdCusjvxz0vHIHBs6y
 VtrU8L9L1bcbU/E/tQuBRI7P9xBVIPToEtk59uirAc/NYY3nHXek5xnqnbm67EIbgIkFQSp4lid
 gZBEo8NFLiWdhMhU51CQ7nEankhe7rOQTNBTF55JcAI4UQ7i/rD0zh3OHUK2hnOs3fK76Mu/+rt
 0ZlUNL1DKVZ0itWzAbXVk6TD59gWEZnuhNP6Heu7GvSLnfOStbzpv2NR/dIZ9q+tXrTw1DJwiBP
 1s18EfDn5kSzbu7yFxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160107



On 2/16/26 5:49 PM, Vishal Chourasia wrote:
> Bulk CPU hotplug operations, such as an SMT switch operation, requires
> hotplugging multiple CPUs. The current implementation takes
> cpus_write_lock() for each individual CPU, causing multiple slow grace
> period requests.
> 
> Introduce cpu_up_locked() and cpu_down_locked() that assume the caller
> already holds cpus_write_lock(). The cpuhp_smt_enable() and
> cpuhp_smt_disable() functions are updated to hold the lock once around
> the entire loop, rather than for each individual CPU.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   kernel/cpu.c | 73 ++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 01968a5c4a16..edaa37419036 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1400,8 +1400,8 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
>   	return ret;
>   }
>   
> -/* Requires cpu_add_remove_lock to be held */
> -static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held */
> +static int __ref cpu_down_locked(unsigned int cpu, int tasks_frozen,
>   			   enum cpuhp_state target)
>   {
>   	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
> @@ -1413,7 +1413,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   	if (!cpu_present(cpu))
>   		return -EINVAL;
>   
> -	cpus_write_lock();
> +	lockdep_assert_cpus_held();
>   
>   	/*
>   	 * Keep at least one housekeeping cpu onlined to avoid generating
> @@ -1421,8 +1421,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   	 */
>   	if (cpumask_any_and(cpu_online_mask,
>   			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
> -		ret = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>   	}
>   
>   	cpuhp_tasks_frozen = tasks_frozen;
> @@ -1440,14 +1439,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   		 * return the error code..
>   		 */
>   		if (ret)
> -			goto out;
> +			return ret;
>   
>   		/*
>   		 * We might have stopped still in the range of the AP hotplug
>   		 * thread. Nothing to do anymore.
>   		 */
>   		if (st->state > CPUHP_TEARDOWN_CPU)
> -			goto out;
> +			return 0;
>   
>   		st->target = target;
>   	}
> @@ -1464,8 +1463,17 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   			WARN(1, "DEAD callback error for CPU%d", cpu);
>   		}
>   	}
> +	return ret;
> +}
>   
> -out:
> +static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +			   enum cpuhp_state target)
> +{
> +

Extra line isn't needed.
Please run checkpatch.pl --strict to fix some of these checks.

> +	int ret;
> +
> +	cpus_write_lock();
> +	ret = cpu_down_locked(cpu, tasks_frozen, target);
>   	cpus_write_unlock();
>   	arch_smt_update();
>   	return ret;
> @@ -1613,18 +1621,18 @@ void cpuhp_online_idle(enum cpuhp_state state)
>   	complete_ap_thread(st, true);
>   }
>   
> -/* Requires cpu_add_remove_lock to be held */
> -static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
> +static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
> +			 enum cpuhp_state target)
>   {
>   	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>   	struct task_struct *idle;
>   	int ret = 0;
>   
> -	cpus_write_lock();
> +	lockdep_assert_cpus_held();
>   
>   	if (!cpu_present(cpu)) {
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>   	}
>   
>   	/*
> @@ -1632,14 +1640,13 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   	 * caller. Nothing to do.
>   	 */
>   	if (st->state >= target)
> -		goto out;
> +		return 0;
>   
>   	if (st->state == CPUHP_OFFLINE) {
>   		/* Let it fail before we try to bring the cpu up */
>   		idle = idle_thread_get(cpu);
>   		if (IS_ERR(idle)) {
> -			ret = PTR_ERR(idle);
> -			goto out;
> +			return PTR_ERR(idle);
>   		}
>   
>   		/*
> @@ -1663,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   		 * return the error code..
>   		 */
>   		if (ret)
> -			goto out;
> +			return ret;
>   	}
>   
>   	/*
> @@ -1673,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   	 */
>   	target = min((int)target, CPUHP_BRINGUP_CPU);
>   	ret = cpuhp_up_callbacks(cpu, st, target);
> -out:
> +	return ret;
> +}
> +
> +/* Requires cpu_add_remove_lock to be held */
> +static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
> +{
> +	int ret;
> +
> +	cpus_write_lock();
> +	ret = cpu_up_locked(cpu, tasks_frozen, target);
>   	cpus_write_unlock();
>   	arch_smt_update();
>   	return ret;
> @@ -2659,6 +2675,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	if (cpu_hotplug_offline_disabled) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +	if (cpu_hotplug_disabled) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	/* Hold cpus_write_lock() for entire batch operation. */
> +	cpus_write_lock();
>   	for_each_online_cpu(cpu) {
>   		if (topology_is_primary_thread(cpu))
>   			continue;
> @@ -2668,7 +2694,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   		 */
>   		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
>   			continue;
> -		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);

If you see comment in cpu_down_maps_locked, It says.

          * Ensure that the control task does not run on the to be offlined
          * CPU to prevent a deadlock against cfs_b->period_timer.
          * Also keep at least one housekeeping cpu onlined to avoid generating
          * an empty sched_domain span

Now, instead of running on the online_CPU you are now doing the _cpu_down
functionality in the cpu which is going offline.

How are you preventing that deadlock?

> +		ret = cpu_down_locked(cpu, 0, CPUHP_OFFLINE);
>   		if (ret)
>   			break;
>   		/*
> @@ -2688,6 +2714,9 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	}
>   	if (!ret)
>   		cpu_smt_control = ctrlval;
> +	cpus_write_unlock();
> +	arch_smt_update();
> +out:
>   	cpu_maps_update_done();
>   	return ret;
>   }
> @@ -2705,6 +2734,8 @@ int cpuhp_smt_enable(void)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	/* Hold cpus_write_lock() for entire batch operation. */
> +	cpus_write_lock();
>   	cpu_smt_control = CPU_SMT_ENABLED;
>   	for_each_present_cpu(cpu) {
>   		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2712,12 +2743,14 @@ int cpuhp_smt_enable(void)
>   			continue;
>   		if (!cpu_smt_thread_allowed(cpu) || !topology_is_core_online(cpu))
>   			continue;
> -		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
> +		ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
>   		if (ret)
>   			break;
>   		/* See comment in cpuhp_smt_disable() */
>   		cpuhp_online_cpu_device(cpu);
>   	}
> +	cpus_write_unlock();
> +	arch_smt_update();
>   	cpu_maps_update_done();
>   	return ret;
>   }


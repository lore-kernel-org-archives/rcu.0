Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E846BF;
	Mon, 16 Feb 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246125; cv=none; b=jRvo2czCI/9xtNloKuo2cG1am8N0627iVAIn8kq2QFrh5YwScyXOXqa7Oh23toRpfgN4J9lTe8cTGcHLJEfL9t8Vm/EBG/3UnA58BnDszyQZnP8HgWrn/fnOZ64nRXhYn2niQ9XbcaeecA9xnja3PS9oK5PatrPWFenQcrHylPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246125; c=relaxed/simple;
	bh=h+yZFOgIeOTXoqu5ADtGiKt9kRh4QNnYCP6P7p438wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drZ/6lxjmZ9koq3wrQhlDhWECyFu+YARz1St8bsu8RnuvSp/lanEmiF5toBiV5ZOYI/KBJLREXFP69VUTJHlsnX9svbjA4N0ee10Lkf4bLYc9jnVkbP1nrF3Xa4oV8RK7T/c1/eTZ9OXapPhVv7aHmoogCDw8nZO8DMW4jVg7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XKptEEyP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XKptEEyP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G89TNN2438279;
	Mon, 16 Feb 2026 12:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=X/XcoKvjABTs+AHqcnrJGSyitKlrAW
	sGrM0jr1s116w=; b=XKptEEyPcIpqPeZaC7GVqF2dw+bYrMk9+kpO3KPk0nTwJ7
	VP/43ODyfjsJSCtovIQxE2DB3zuAQEy1oYgiyxkkMwHMV7kcByiynBHrQyLg4vmB
	Ds7yv1NTUAxTwSYGy1yD6y1KaZpAp6QMmuADMKNaUtB4qBr36RBZ5vmA9Dk4nUnj
	aGVRhJGoGg9/PmXBIarSUeM37T2IT0FLmCh4BsfS0yEnp3si6AcPMAZwSaHeDyeh
	Is+6vyHJ1YMAEHIhnJJK32eiq7pk1E7A6ew/kpOMqHKKxnVUQRPDUUvCvotws2yI
	jMEQt355GHD6WBalGlmdpJoq/UvqYDTmIeg5ITkg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqqkka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:48:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8JQ6L002893;
	Mon, 16 Feb 2026 12:48:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj56e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:48:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GCmSif26607992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 12:48:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF42720040;
	Mon, 16 Feb 2026 12:48:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D8520043;
	Mon, 16 Feb 2026 12:48:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.25.42])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Feb 2026 12:48:23 +0000 (GMT)
Date: Mon, 16 Feb 2026 18:18:38 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com
Subject: Re: [PATCH v2 1/2] cpuhp: Optimize SMT switch operation by batching
 lock acquisition
Message-ID: <aZMSJo-1mZCdHwsi@linux.ibm.com>
References: <20260216121927.489062-2-vishalc@linux.ibm.com>
 <20260216121927.489062-4-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216121927.489062-4-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tQFIoqxYjXBdpufYeZJV8z1gXw-N9LQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwNyBTYWx0ZWRfX+zrh+4uu2H8X
 zAxHH8Lm0bNxXIN6VOT9Ykw7D2K20hqy49Lwh46K6Qs7tFVPPemWw88/NI4W3Bz5xx2TbN3DU3b
 Zyxpi2k+WBF1eWET1Vl1PQl4esIc8FYR7avHKBg9WxAFeDp4DNvaijwc0zmM5RS2tlljsHnS5kD
 f1+eitQhejDvpkxcRB4DvomK5igBDbEqlmU/P81Wy4gcsZVGnibBt7r8BeQJWOH3NDqky0JHFiU
 xiN/PDEzw5bRue0E2VbJXd+31/ykKnw8DIjI2+x9unse0yjvvgtSD84YsKxopsAOADKWj7VVUAA
 QEXjA4JMtE7u7Hzd/Q2+x0IslbU/qhsUhc1C2PDsH0inln4c5ypRPJhP2wsZVuKHTlWuog6Ynb6
 s3m9E+kn34VXoD63n+COG5GdfvvZa5nj0cqexz58N7Tx+Y5Az2A7U8UTmanB2R0XWD7XMzAkiZx
 pb9T2cfgie80GOilqSA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69931222 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=vXEV8NY02OEYcHdzmrUA:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 7SM--IHStvHQxpaQk0euTe_HPju9Va55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160107

On Mon, Feb 16, 2026 at 05:49:28PM +0530, Vishal Chourasia wrote:
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
The code hositing the cpus_write_lock up in the cpuhp_smt_enable() was
provided by Joel [1]. Thanks Joel.

I missed adding an appropriate tag for it.

Originally-by: Joel Fernandes <joelagnelf@nvidia.com>

[1] https://lore.kernel.org/all/20260119051835.GA696111@joelbox2/

> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/cpu.c | 73 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 01968a5c4a16..edaa37419036 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1400,8 +1400,8 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
>  	return ret;
>  }
>  
> -/* Requires cpu_add_remove_lock to be held */
> -static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held */
> +static int __ref cpu_down_locked(unsigned int cpu, int tasks_frozen,
>  			   enum cpuhp_state target)
>  {
>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
> @@ -1413,7 +1413,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  	if (!cpu_present(cpu))
>  		return -EINVAL;
>  
> -	cpus_write_lock();
> +	lockdep_assert_cpus_held();
>  
>  	/*
>  	 * Keep at least one housekeeping cpu onlined to avoid generating
> @@ -1421,8 +1421,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  	 */
>  	if (cpumask_any_and(cpu_online_mask,
>  			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
> -		ret = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  
>  	cpuhp_tasks_frozen = tasks_frozen;
> @@ -1440,14 +1439,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  		 * return the error code..
>  		 */
>  		if (ret)
> -			goto out;
> +			return ret;
>  
>  		/*
>  		 * We might have stopped still in the range of the AP hotplug
>  		 * thread. Nothing to do anymore.
>  		 */
>  		if (st->state > CPUHP_TEARDOWN_CPU)
> -			goto out;
> +			return 0;
>  
>  		st->target = target;
>  	}
> @@ -1464,8 +1463,17 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  			WARN(1, "DEAD callback error for CPU%d", cpu);
>  		}
>  	}
> +	return ret;
> +}
>  
> -out:
> +static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> +			   enum cpuhp_state target)
> +{
> +
> +	int ret;
> +
> +	cpus_write_lock();
> +	ret = cpu_down_locked(cpu, tasks_frozen, target);
>  	cpus_write_unlock();
>  	arch_smt_update();
>  	return ret;
> @@ -1613,18 +1621,18 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  	complete_ap_thread(st, true);
>  }
>  
> -/* Requires cpu_add_remove_lock to be held */
> -static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
> +static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
> +			 enum cpuhp_state target)
>  {
>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>  	struct task_struct *idle;
>  	int ret = 0;
>  
> -	cpus_write_lock();
> +	lockdep_assert_cpus_held();
>  
>  	if (!cpu_present(cpu)) {
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
>  	/*
> @@ -1632,14 +1640,13 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>  	 * caller. Nothing to do.
>  	 */
>  	if (st->state >= target)
> -		goto out;
> +		return 0;
>  
>  	if (st->state == CPUHP_OFFLINE) {
>  		/* Let it fail before we try to bring the cpu up */
>  		idle = idle_thread_get(cpu);
>  		if (IS_ERR(idle)) {
> -			ret = PTR_ERR(idle);
> -			goto out;
> +			return PTR_ERR(idle);
>  		}
>  
>  		/*
> @@ -1663,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>  		 * return the error code..
>  		 */
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/*
> @@ -1673,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>  	 */
>  	target = min((int)target, CPUHP_BRINGUP_CPU);
>  	ret = cpuhp_up_callbacks(cpu, st, target);
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
>  	cpus_write_unlock();
>  	arch_smt_update();
>  	return ret;
> @@ -2659,6 +2675,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
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
>  	for_each_online_cpu(cpu) {
>  		if (topology_is_primary_thread(cpu))
>  			continue;
> @@ -2668,7 +2694,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  		 */
>  		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
>  			continue;
> -		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> +		ret = cpu_down_locked(cpu, 0, CPUHP_OFFLINE);
>  		if (ret)
>  			break;
>  		/*
> @@ -2688,6 +2714,9 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	}
>  	if (!ret)
>  		cpu_smt_control = ctrlval;
> +	cpus_write_unlock();
> +	arch_smt_update();
> +out:
>  	cpu_maps_update_done();
>  	return ret;
>  }
> @@ -2705,6 +2734,8 @@ int cpuhp_smt_enable(void)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	/* Hold cpus_write_lock() for entire batch operation. */
> +	cpus_write_lock();
>  	cpu_smt_control = CPU_SMT_ENABLED;
>  	for_each_present_cpu(cpu) {
>  		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2712,12 +2743,14 @@ int cpuhp_smt_enable(void)
>  			continue;
>  		if (!cpu_smt_thread_allowed(cpu) || !topology_is_core_online(cpu))
>  			continue;
> -		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
> +		ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
>  		if (ret)
>  			break;
>  		/* See comment in cpuhp_smt_disable() */
>  		cpuhp_online_cpu_device(cpu);
>  	}
> +	cpus_write_unlock();
> +	arch_smt_update();
>  	cpu_maps_update_done();
>  	return ret;
>  }
> -- 
> 2.53.0
> 

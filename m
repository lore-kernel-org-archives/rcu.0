Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8D286D5E;
	Mon,  2 Feb 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022061; cv=none; b=ksfuJqtCy7bBn+3ztdV92NiK0utNomrPd5zCYf6PQvsD6p6TKPjGrOJE9q+px2/jje7G5um4e8lHsN+qe/U2yQkiRQ2pm/dhe++XMb3xHsWcr7A+y1nW4WfxXtANcdMo8xWAQ1ckt2hc1HUM3HwEz7W9iBHOxbJNPwkT8Mo/t7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022061; c=relaxed/simple;
	bh=KAvoBnIeG0u4QwfD94o9lb5Z/uUHfyFNsV9Fc9EoJvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu/+e31oHMPDo8UjAAU22Z8UUD9h9FHVCns7J6tpizydHJW1mmGM8PHBIfZQVKcGJk5DNNX6HdXdkEhm4hYhmyXVNDe3iQVEXXnj0fC62rslIitn9k/szJdUqGDmWfNumZn5Frt2fxLbjT9RHDrhH1hwJ8Vc2vXSs6/ylNAf7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WoWuqQKm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WoWuqQKm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6121ssgA019976;
	Mon, 2 Feb 2026 08:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eUmmrP/lACeLPLowXo/tF1TltBLVBR
	sDv43qh+4QmU0=; b=WoWuqQKmHFktQpFQ7i5AQZdjhvdRoBjmEuxV7k9tZIm83F
	+6/+76IUhEBq73zM9yEwDDAkBr9ruRAfCKnWQRnmqIMfG1SC9Mwg1/+4BDSIMc+i
	bbKC9tZCde0xSrrtdfFAWRreRbM9BUtXo+CWI3g+tLEnHy0/wweDQZ8FhWDLpxh6
	PwllJ+4WY+b8dftlwJjFzyvZ25yXXG/RF/DIjnKhwODCJcfUGDcfoVn+MBvrxgpY
	XRhTSC3jM7T4sZoxcQYj07dFnaWWP3aiVHoDTmOCHJ2MFdmb0mLlsBFf4jnTwm2I
	pf8xzVrEDLCXrSjMzQgec2A6lNBR4za5pEZiGTxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gp5kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 08:47:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6128l65k022473;
	Mon, 2 Feb 2026 08:47:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gp5kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 08:47:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6124DF96004466;
	Mon, 2 Feb 2026 08:47:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjm7sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 08:47:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6128l1lp39846218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 08:47:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E8320040;
	Mon,  2 Feb 2026 08:47:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E097420043;
	Mon,  2 Feb 2026 08:46:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.20.97])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Feb 2026 08:46:56 +0000 (GMT)
Date: Mon, 2 Feb 2026 14:16:53 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Samir M <samir@linux.ibm.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org, frederic@kernel.org,
        neeraj.upadhyay@kernel.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
        tglx@linutronix.de, peterz@infradead.org, sshegde@linux.ibm.com,
        srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aYBkfZnP6zmWCaTX@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <9e57a091-2f34-402a-972a-31dd9a10664b@linux.ibm.com>
 <20260119051835.GA696111@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119051835.GA696111@joelbox2>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6980648b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=Ikd4Dj_1AAAA:8 a=JfrnYn6hAAAA:8
 a=wyJNnMxBMtNC30dW1EAA:9 a=CjuIK1q_8ugA:10 a=H4LAKuo8djmI0KOkngUh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: UDQsHu8C4d1knV8RVi6l1-FltSHG_Vdt
X-Proofpoint-ORIG-GUID: zsotYwV3u_GoeaZOkVCep4xw725zfPcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA3MSBTYWx0ZWRfX5YYXxuSrL+AZ
 RrEVNXYsZEmVDRG12ogGGpx8/Sh93LDO7emVnvrfg8nhb52TMCm2AWiNaBGCQC/3X1JJy1ToMxu
 gmSIiQmUbSTZDwgvr8JHhaxcXnynznBygt7aaLt1FKBg7cEtpywZxdY/WzAYftiCJKHngu1SY+I
 YrL2/lcDoxWW89LletT0StiyeIFo5M3DoG9D+NoQs8NUz480sgQa7DwsLnNVuY1bA6OyBlpspz6
 5wTiKdgtuWjzSQn4MFNqmiC/whqAD95bQaZecwRygEUzX9WNjkkxHtyw0RY1YAGuohDaG/7C3p6
 J9mYX2etDDAjcGXyCm4TbwcUUm+WuLyvTXAwTkav9d5xhCXKWK7rPj00/Qj2NbvfAGge/z+Ua+V
 t8eyvn1ze5uLrQyaxEq/lL/YK5guylUjlCANH+AysMFlU2KXHyySW+T4Ddm3yke8d0QNlyPZ/pp
 esP53v1czoW3XeuE4gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020071

On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> Performance data on a PPC64 system with 400 CPUs:
> 
>+ ppc64_cpu --smt=1 (SMT8 to SMT1)
>Before: real 1m14.792s
>After:  real 0m03.205s  # ~23x improvement
>
>+ ppc64_cpu --smt=8 (SMT1 to SMT8)
>Before: real 2m27.695s
>After:  real 0m02.510s  # ~58x improvement
>
>Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b

On Mon, Jan 19, 2026 at 12:18:35AM -0500, Joel Fernandes wrote:
> Hi Vishal, Samir,
> 
> Thanks for the testing on your large CPU count system.
> 
> Considering the SMT=on performance is still terrible, before we expedite
> RCU, could we try the approach Peter suggested (avoiding repeated
> lock/unlock)? I wrote a patch below.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
>   tag: cpuhp-bulk-optimize-rfc-v1
> 
> I tested it lightly on rcutorture hotplug test and it passes. Please share
> any performance results, thanks.
> 
> Also I'd like to use expediting of RCU as a last resort TBH, we should
> optimize the outer operations that require RCU in the first place such as
> Peter's suggestion since that will improve the overall efficiency of the
> code. And if/when expediting RCU, Peter's other suggestion to not do it in
> cpus_write_lock() and instead do it from cpuhp_smt_enable() also makes sense
> to me.
> 
> ---8<-----------------------
> 
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] cpuhp: Optimize batch SMT enable by reducing lock acquiring
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
> Link: https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/cpu.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8df2d773fe3b..4ce7deb236d7 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1623,34 +1623,31 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  	complete_ap_thread(st, true);
>  }
> -/* Requires cpu_add_remove_lock to be held */
> -static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
> +static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
> +			 enum cpuhp_state target)
>  {
>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>  	struct task_struct *idle;
>  	int ret = 0;
> -	cpus_write_lock();
> +	lockdep_assert_cpus_held();
> -	if (!cpu_present(cpu)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!cpu_present(cpu))
> +		return -EINVAL;
>  	/*
>  	 * The caller of cpu_up() might have raced with another
>  	 * caller. Nothing to do.
>  	 */
>  	if (st->state >= target)
> -		goto out;
> +		return 0;
>  	if (st->state == CPUHP_OFFLINE) {
>  		/* Let it fail before we try to bring the cpu up */
>  		idle = idle_thread_get(cpu);
> -		if (IS_ERR(idle)) {
> -			ret = PTR_ERR(idle);
> -			goto out;
> -		}
> +		if (IS_ERR(idle))
> +			return PTR_ERR(idle);
>  		/*
>  		 * Reset stale stack state from the last time this CPU was online.
> @@ -1673,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>  		 * return the error code..
>  		 */
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  	/*
> @@ -1683,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
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
> @@ -2715,6 +2721,8 @@ int cpuhp_smt_enable(void)
>  	int cpu, ret = 0;
>  	cpu_maps_update_begin();
> +	/* Hold cpus_write_lock() for entire batch operation. */
> +	cpus_write_lock();
>  	cpu_smt_control = CPU_SMT_ENABLED;
>  	for_each_present_cpu(cpu) {
>  		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2722,12 +2730,14 @@ int cpuhp_smt_enable(void)
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
> 2.34.1
> 


Hi Joel,

I tested above patch on 400 CPU machine that I had originally posted the
numbers for.

# time echo 1 > /sys/devices/system/cpu/smt/control
real    1m27.133s # Base 
real    1m25.859s # With patch

# time echo 8 > /sys/devices/system/cpu/smt/control
real    1m0.682s  # Base           
real    1m3.423s  # With patch



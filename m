Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB63DCD90;
	Thu, 26 Mar 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519607; cv=none; b=rOsVn+/rcjqSK5T7TQIGfCSsnXFSGU0sW3I43FP0uolk5TTqj+eyEmNl1+XDNqpWmhZGZEMt9iol9Wpzhc1+G8xQrWJk41h0e2LHiLxVnDgbOlAPqQHUj2LKFIaVuS9trQkUQ2vM0LUslJ04a6sq9UuboDSe3qGl6DApHpipg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519607; c=relaxed/simple;
	bh=E37ar7Ha3IozvtO5LCoLYHJZf+cAnGxdsrxkWJ49dHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W29w7L4MjUrqF+RMKOF85cPOK40oP1LRSImRrFDrRv024M+Sa8iVWZbMeRdVzKM1K9QWeTt9isaVq8xpRjKekNiOxz1qImHp08X9MhQulgQimNHSKvv6nYDDl6YBPXSF1xnZfU9EIGB5CLNrrfJrc049WLnnpv7X0AaJIPvbVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=syXbvFmr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="syXbvFmr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJeAEW4102573;
	Thu, 26 Mar 2026 10:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5v3kTDbosdfAQE1DBZ/Edpr9e9Fapq
	8SWKP6vK+DMpA=; b=syXbvFmrl9Ei3yiloVNUyrMQuLUSmWze1fdtvu58GEM3F4
	5t5Rgu5NniswO3Ec/rXfPlBkXa9MLHiRB0e9Cxt2llL2RUQOqm7309N9pteinPIm
	z4BlqvnA1KQ/iEmUwIEBdjsPXwggP0nNHf598AN5pEM+mzjSCLgcsaebQDgQnHa1
	Nt0g9yxouMaxGwAz9OQXQTyjEkKYKDxUS4yS58Qj93SgF11xzTwZssvdG6WrVYT+
	AP41rbt3aK1fDnpS69lKIwK6W6ONmsSiszPW9jz846v/PgMyzJQcbkN4QFdClZ7r
	8pl4A1eVtfSBhmNkGiqjR7INE89EsTsLb8CzKFQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0bjyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 10:06:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q7QkRr026771;
	Thu, 26 Mar 2026 10:06:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m2bf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 10:06:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QA6KHq30343854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 10:06:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4504C2004E;
	Thu, 26 Mar 2026 10:06:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C1E220040;
	Thu, 26 Mar 2026 10:06:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.221.129])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Mar 2026 10:06:15 +0000 (GMT)
Date: Thu, 26 Mar 2026 15:36:12 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, aboorvad@linux.ibm.com, boqun.feng@gmail.com,
        frederic@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, sshegde@linux.ibm.com, urezki@gmail.com,
        samir@linux.ibm.com
Subject: Re: [PATCH v3 1/2] cpuhp: Optimize SMT switch operation by batching
 lock acquisition
Message-ID: <acUFFEab8b_OLqJg@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-4-vishalc@linux.ibm.com>
 <87ikajenfm.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikajenfm.ffs@tglx>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2OSBTYWx0ZWRfXx8o/l7PLrObs
 UV2wRQ61dxLoxKgy7Jf2QnHqtUP8iPJsucBWtripQICRGsCON6onzVTYImdQcXQKCBX2DH7yeN/
 xskB58wem+RlkyTz1V7gMcWtEO5zWwl2UhP4GMQjBAGgPoGe6pw72CGp0q5tq9bXfgJgs1Ru526
 XbYZ2sq3YdlSd5kil9PimtCHI5Y9wEXrd60FctJoHIvo4gPtgk8zUHCyqR9BeVjkKAtr9UOX2he
 OmjhSV+0RaFT2aakA8gVibek9Fx9SeYJfRkc0lKMPDwolzXUdcKa1lSE86ibH0sjJU47MXFcaXY
 0NPjqjx3naWKE25r4KvlJdVBATjIwiEz+tJNgq6flhi+IL5f7hg6u9ubLyHVmJjuDVxooW4Sl1j
 ECjq0yZ+ofzDF7grvij4EwsOFxrNuX9IgC3KqPgWMLp7yhyoNEUEFQNk6uWpyA1UrlDG4KuDzJ4
 R0ldJV5wnsgqgDMoImg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c50521 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=WsHKUha7AAAA:8 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=JfrnYn6hAAAA:8
 a=z0wIWYloHvcrv3Mza3wA:9 a=CjuIK1q_8ugA:10 a=H4LAKuo8djmI0KOkngUh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: YfkD5ESqtPwxpO7cZxkJKiU5NiJvylZH
X-Proofpoint-GUID: tIrUXWpimd0KHjqg2DHyY9HWgixI97rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260069

Hi Thomas, Thank you for the review.

Numbers from 400 CPUs that I had while back,
baseline: Linux 6.19.0-rc4-00310-g755bc1335e3b

On PPC64 system with 400 CPUs:
SMT8 to SMT1:
  baseline:        real 1m14.792s
  baseline+patch:  real 0m03.205s  # ~23x improvement

SMT1 to SMT8:
  baseline:        real 2m27.695s
  baseline+patch:  real 0m02.510s  # ~58x improvement

Note: We observe huge improvements for max config system which
originally took approx to 1 hour to switch SMT states, with GPs
expedited is taking 5 to 6 minutes.

Analysis: why expediting GPs improves time to complete
By expediting the grace period, we force an immediate IPI-driven
quiescent state detection across all CPUs rather than lazily waiting,
which dramatically reduces the time the calling thread remains blocked
in synchronize_rcu()

Why holding the cpus_write_lock() for the duration of SMT switch will
not work? [1] This causes hung-task timeout splats [2] because there are
threads blocked on cpus_read_lock(). Expediting grace periods shrinks
the window but doesn't eliminate it. I plan to drop this patch and the
next version will only carry the expedited RCU grace period change.

I will incorporate all your other suggestions in the next version.

[1] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
[2] https://lore.kernel.org/all/aapprY-prH0l_WeK@linux.ibm.com/

On Wed, Mar 25, 2026 at 08:09:17PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 18 2026 at 14:09, Vishal Chourasia wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> >
> > Bulk CPU hotplug operations, such as an SMT switch operation, requires
> > hotplugging multiple CPUs. The current implementation takes
> > cpus_write_lock() for each individual CPU, causing multiple slow grace
> > period requests.
> >
> > Introduce cpu_up_locked() and cpu_down_locked() that assume the caller
> > already holds cpus_write_lock(). The cpuhp_smt_enable() and
> > cpuhp_smt_disable() functions are updated to hold the lock once around
> > the entire loop, rather than for each individual CPU.
> >
> > Link: https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> You dropped Joel's Signed-off-by ....
Sorry for messing up the changelog w.r.t to signed-off-by tag.
Will take care in future.
> 
> > -/* Requires cpu_add_remove_lock to be held */
> > -static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> > +/* Requires cpu_add_remove_lock and cpus_write_lock to be held */
> > +static int __ref cpu_down_locked(unsigned int cpu, int tasks_frozen,
> >  			   enum cpuhp_state target)
> 
> No line break required. You have 100 chars. If you still need one:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
Ack.
> 
> >  	 */
> >  	if (cpumask_any_and(cpu_online_mask,
> >  			    housekeeping_cpumask(HK_TYPE_DOMAIN)) >= nr_cpu_ids) {
> > -		ret = -EBUSY;
> > -		goto out;
> > +		return -EBUSY;
> >  	}
> 
> Please remove the brackets. They are not longer required. All over the place.
Ack.
> 
> > +static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
> > +			   enum cpuhp_state target)
> > +{
> > +
> > +	int ret;
> > +	cpus_write_lock();
> 
> Coding style...
Ack.
> 
> > +	ret = cpu_down_locked(cpu, tasks_frozen, target);
> >  	cpus_write_unlock();
> >  	arch_smt_update();
> >  	return ret;
> > @@ -2659,6 +2674,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >  	int cpu, ret = 0;
> >  
> >  	cpu_maps_update_begin();
> > +	if (cpu_hotplug_offline_disabled) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out;
> > +	}
> > +	if (cpu_hotplug_disabled) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +	/* Hold cpus_write_lock() for entire batch operation. */
> > +	cpus_write_lock();
> 
>  .... for the entire ...
> 
> And please visiually separate things. Newlines exist for a reason.
Sure. 
> 
> Thanks,
> 
>         tglx

Thanks and Regards!

Vishalc

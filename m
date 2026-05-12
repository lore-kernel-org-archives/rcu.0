Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A44357D11;
	Tue, 12 May 2026 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567631; cv=none; b=tYycJsWBC4v8yxYwAtFyzwoIv0fqZYfDZNaw1/gzTkLEup8qHy/R1Y0xvCnIzmj5ktAH5m5LOMRw3l2xDCp5X8Pg9Pv/4tVKXbGp2Ojrp02LdG910N/5flddklay7q81YoBz2qDuqzDn8M3cmlCTlLLWh/GkfTWuiuwBFkpChE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567631; c=relaxed/simple;
	bh=HPwNYRfUmkAZG7P6usrqyLpWyxp1mo1x/x+oUoOYLVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saedrhuOUZsBGTyq/eTEVQV52x2JsQmGwjTiy3IKmJpULbiTRnOhbe0LL9nwz/az6A/R9/+DfFX00ImGReO5FM8oBcTfE8OlzRm7NO0y+NoHY8fydrdmyVNFfINMCuTGsejwJcFCDJ/mVgDRAtcCiyR6AIyIkDPiYaDGEpk9L54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KryvoZc4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KryvoZc4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7FE53179846;
	Tue, 12 May 2026 06:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gtwogu
	9gLKM6otmUXk5BM1iWME/djxYLitKViq+ElJc=; b=KryvoZc4lyWCOk6Hj+0quq
	tY+PDkeS0KAHolvjRkzZisPcIc/qo1qgArAtpghubdPIfDBFciMG9GT2XxYkVA+i
	ELjpRJOg7DglbmNtLNP3hPWrn/TMhTMUsqTvc79O2Oie2ACKGoZ02cdg6peutMyq
	aQzh23hco/HgVhTsBoagl5P3ODWR/vphC4DoQ9t4lr4Ln0Qmp4kFg1o6kCuPY71c
	WffzCu0n0UNXoQN0xkINCFLWlHMt5CAjaojX+aWWdqDf0pYW9G10i3pROKDb8B6X
	w7DaZcPpwZ0ZlXGH0shhmdJGSZEaFqyog8CgPZAkH+vEyFmvoNi9qGG4DPttLxTg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6hmfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:32:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C6OSMC032007;
	Tue, 12 May 2026 06:32:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfghxm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:32:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C6WsBV40632760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 06:32:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F349520040;
	Tue, 12 May 2026 06:32:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94B3A20043;
	Tue, 12 May 2026 06:32:50 +0000 (GMT)
Received: from [9.124.213.250] (unknown [9.124.213.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 06:32:50 +0000 (GMT)
Message-ID: <0ca9a5aa-5457-4dc4-b78a-450827542320@linux.ibm.com>
Date: Tue, 12 May 2026 12:02:49 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
To: Vishal Chourasia <vishalc@linux.ibm.com>, peterz@infradead.org,
        aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com
References: <20260507053928.2975867-2-vishalc@linux.ibm.com>
 <20260507053928.2975867-4-vishalc@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260507053928.2975867-4-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a02c99a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=sR7HqLe5bqO4WV0gnZ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8L5Rp3fvOcUifOLL-_shW0igtZuDykf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1NyBTYWx0ZWRfX6kLEkCg0CHJy
 6N6Ci1fQtQov7f0ME9IRuPDSrxY0pri7o4I5BJi7gO9NSUgdTTq6o4s8jXoK5xbTeXtgMsyXNdS
 evU0h3R5K/KOYbBT8LeQ3sqAiiikVhEIuwLdPbCpo+Os9Lyc5ruV+2zgbcJ/ldFJp/Y4ciddwst
 lp7gl7+0rmfWBpOrLJ3xK+xq46iSlbfHyK0HRWP+ZuOYdXkok27bUErIc6S6AxoEqBHJM5ZqdDk
 asLswrjW8kbYNAHl+USJ7x7IdavKXM+kmS8wvjmjpgL59tilY7HAWlEXqiOJDMlRTifXLDCIRkl
 ehWWSlx7WoEQi68Gv/UciruGypb3LA1vDS2iDm63Bj93vub4+jwcUdmbB5Ls7ZnOqz4mkeNDi8Q
 JH2YYDXec08yYBBlhH2Z+wvB2GvsjeOAbsIUvZaNjqC788tR/wTunfoeZtMB9cvw8/6uewum3xQ
 kZl8koRO+sLKwUmHiPw==
X-Proofpoint-ORIG-GUID: hQ9bhBrsP-NV1hHr_VvJJtDnEd8EWP1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120057



On 5/7/26 11:09 AM, Vishal Chourasia wrote:
> On large idle systems, changing system-wide SMT level using the sysfs
> control interface still takes approximately 40-55 minutes. Changing SMT
> levels is a user triggered operation generally done when systems are
> fairly idle. This causes users to be blocked from doing other subsequent
> work.
> 
> Analyzing the collected profile data during SMT level switch, showed
> that CPU hotplug machinery was blocked on synchronize_rcu() calls.
> 
> Expedite RCU grace periods for the entire duration of triggered SMT
> switch operation via the sysfs control interface. Individual CPU hotplug
> operations via the online/offline interface are not affected.
> 
> On a PPC64 system with 400 CPUs:
> 
>    SMT8 to SMT1:
>      before:  1m14s
>      after:   3.2s   (~23x faster)
> 
>    SMT1 to SMT8:
>      before:  2m27s
>      after:   2.5s   (~58x faster)
> 
> On a large config system with 1920 CPUs, completion time improves from
> ~1 hour to 5-6 minutes.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   include/linux/rcupdate.h | 8 ++++++++
>   kernel/cpu.c             | 4 ++++
>   kernel/rcu/rcu.h         | 4 ----
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index bfa765132de8..b6bccf131f1c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1178,6 +1178,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>   extern int rcu_expedited;
>   extern int rcu_normal;
>   
> +#ifdef CONFIG_TINY_RCU
> +static inline void rcu_expedite_gp(void) { }
> +static inline void rcu_unexpedite_gp(void) { }
> +#else
> +void rcu_expedite_gp(void);
> +void rcu_unexpedite_gp(void);
> +#endif
> +
>   DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>   DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
>   
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bc4f7a9ba64e..6351da9dffdc 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2658,6 +2658,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_expedite_gp();
>   	for_each_online_cpu(cpu) {
>   		if (topology_is_primary_thread(cpu))
>   			continue;
> @@ -2687,6 +2688,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	}
>   	if (!ret)
>   		cpu_smt_control = ctrlval;
> +	rcu_unexpedite_gp();
>   	cpu_maps_update_done();
>   	return ret;
>   }
> @@ -2704,6 +2706,7 @@ int cpuhp_smt_enable(void)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_expedite_gp();
>   	cpu_smt_control = CPU_SMT_ENABLED;
>   	for_each_present_cpu(cpu) {
>   		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2717,6 +2720,7 @@ int cpuhp_smt_enable(void)
>   		/* See comment in cpuhp_smt_disable() */
>   		cpuhp_online_cpu_device(cpu);
>   	}
> +	rcu_unexpedite_gp();
>   	cpu_maps_update_done();
>   	return ret;
>   }
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index fa6d30ce73d1..d6a63ee60bc0 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -521,8 +521,6 @@ do {									\
>   static inline bool rcu_gp_is_normal(void) { return true; }
>   static inline bool rcu_gp_is_expedited(void) { return false; }
>   static inline bool rcu_async_should_hurry(void) { return false; }
> -static inline void rcu_expedite_gp(void) { }
> -static inline void rcu_unexpedite_gp(void) { }
>   static inline void rcu_async_hurry(void) { }
>   static inline void rcu_async_relax(void) { }
>   static inline bool rcu_cpu_online(int cpu) { return true; }
> @@ -530,8 +528,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
>   bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>   bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>   bool rcu_async_should_hurry(void);  /* Internal RCU use. */
> -void rcu_expedite_gp(void);
> -void rcu_unexpedite_gp(void);
>   void rcu_async_hurry(void);
>   void rcu_async_relax(void);
>   void rcupdate_announce_bootup_oddness(void);


Given the context that,
- System is expected to be idle.
- It is user triggered event.

It makes sense to expedite the RCU at the cost of additional
IPI's. So

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

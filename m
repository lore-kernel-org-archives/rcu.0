Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642B313E1D;
	Thu,  7 May 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180873; cv=none; b=XIHENMBZz5zRwBt2XE7PWF0TBdb3fVHmhdJIdz6lmFwVfAKAXMEsoTlNS2s0LhFIMQSxmI2+A1m+Ys4+oJYhot48CNcoMSEXDswEdnzk+9j47CFS+grQ5E91G+pS/5JgZJgMWeVX3hSiXSX2Y/O1v4J3gMjdhVc/jv5VDQVopuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180873; c=relaxed/simple;
	bh=rX1ynBMFV//UMsmL/gmyWvarR3ad2RdqdtOVK6hRoys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZSGDSM3D+S1fgiGdyj2Euh52NoYvwTDLbnFIqKKjpZQEXzzigwKTjJDXRE5hdnD9Tyfc0A7QtIs3Ctg7YeTiBnn/K3n9xKAbaOCSLprIKpjX8kQ8uRf9zAAkxkEWzafMK43o+xg1KNQebF/OJ8eKMuLPSHakMpl/AuY5TWMpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpis7C9R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpis7C9R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Cw1Ut001076;
	Thu, 7 May 2026 19:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rYt8Ce
	JwPi+RpGtvHkHg8iJ/mvJNvSB0+Dp1mn+mdyM=; b=gpis7C9RnPVgkP++tj/HkP
	PATVA47+OcEPr/73k8Qhw3UbgI/wTIZ8ZMk+fBYIqFjGPBl8RFKSzlG+GuGRbL9m
	YR5EqLfrSQbaUeHF4PKZrLv1cGC3T4Sm8Wjsqo7Datt1DERMafkZc2+6Pa8SY9kR
	zQfptb/Q0ys4UXXFi8w0zUQFZnf1mkcpY6PAtqr2Q+Qgwk9JaFrVeIWCYKQJmuVE
	QiuIj4NNwQpe8H/TrZULP/hSUFGAtD0ugqkmOYCpkb20p97JDYkA4ApGQwqsmz8B
	jCf7MjU60OawyAJXhJ4/GRfRe72vAFC9KMyLgQMNE/MrsZ88XkiRIgxxUAMmx3Uw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1rdea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 19:07:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647IsTTP011327;
	Thu, 7 May 2026 19:07:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywd81b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 19:07:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647J7LwZ25363008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 19:07:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92475803F;
	Thu,  7 May 2026 19:07:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF8C58056;
	Thu,  7 May 2026 19:07:14 +0000 (GMT)
Received: from [9.39.24.71] (unknown [9.39.24.71])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 19:07:13 +0000 (GMT)
Message-ID: <c37b8da5-2e18-4988-9f7d-1ff3bf5fb02b@linux.ibm.com>
Date: Fri, 8 May 2026 00:37:11 +0530
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
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com
References: <20260507053928.2975867-2-vishalc@linux.ibm.com>
 <20260507053928.2975867-4-vishalc@linux.ibm.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260507053928.2975867-4-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bI6n8Nhil7rg__nL-gFgDlSC51QWDT8q
X-Proofpoint-GUID: Kigy5TsegIPT7wzRixoorQDGTImHCfbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5MyBTYWx0ZWRfX5ekt5JyuEzTW
 +fp28NvgtPmfBsQLiMd3vEZa+Bdyo5b0RTocNCrYmDPx+GHEzvT/912Pk1TXte/5FF3ifyQI8iD
 lwPsCIzUGhhXlxtVRVbK8704dMeSb30+JUvwMYDUkjveOqEsFLuTjvreLY1ZLfHbwiUECL1XO+h
 p2kBBQnqZGtCAi8ZCXUvn5R9OOiFjLvAJvcmt02TLhKyCC9e2eVWY6NW128/zvee3yGW9xahosY
 oZQoigTvDdVL2v5Vj0PclOwF4DdrjxePmH1kC2bcDRoDPXOm4NvjQljcw1K42lLO+xuxeaN82sN
 aXAj05Ij7Q/8VSz/HXHHx5qHpFDF6YJLkPs0voj7PrnVvFmUOQp0dcrjSQPliAgoLj6mdOBZAuO
 Ka/ot6az7Zavj/+epM5Q8kmRsf4dfUvNAsVI8E9FBWFZ1xDjqOX+1wIBLaNUk/D6vcwc05t9nAi
 /CMiTdrlXEuBBphgjKw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fce2ec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=X_LXuewp6dCWBlW58UUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070193


On 07/05/26 11:09 am, Vishal Chourasia wrote:
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
Hi Vishal,

I verified the patch on PPC64 system using the configuration described 
below.
Configuration:
     •    Kernel version: 7.1.0-rc2+
     •    Number of CPUs: 960

Using this setup, I evaluated the patch with both SMT enabled and SMT 
disabled. patch shows a significant improvement in the both SMT=on/off 
case.


SMT Mode    | Without Patch    | With Patch | % Improvement     |
-------------------------------------------------------------------
SMT=off     | 3m 56.174s       | 0m 34.284s | +85.48%           |
SMT=on      | 3m 47.322s       | 0m 35.583s | +84.35%           |


Regards,
Samir
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

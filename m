Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FB3630B9;
	Mon,  2 Mar 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452081; cv=none; b=hE9B5cym1/NqZcyZzGnxgSCewccwgtufsXiC2BCDvrhjD/sMlqt7733+UgswE4llzq+iOVyEIiyDgTV7JgBhoJ2IZm3PTU9iw5OaG3b0GCMYKDMR2TuTalcNeJDTmcb4IPMtBpZUXv3/KzslCM9vU2CK42YNSvFI1hUX2O3ZBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452081; c=relaxed/simple;
	bh=WnhUbHQfyQJIDPrp/Y2GjvWsSQVvMy90HVppVYh0lXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0KxnH1MoY8D29uWid2GmlEXVU6NchT0AHQVyqdmobbtouPKRT6pKGY5DVBXqMZQh7AMvWQNy/apLnkfWoXGt2V6y/pAW3t3N+tRoEdDvuqibjYcp+tYKKM237iXxsJZiAmdXm5iQsyixce7B/C6HC73jVjprEZw3m5qRF5B0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TgKxA4MW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TgKxA4MW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622BZReh967095;
	Mon, 2 Mar 2026 11:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VsZVFl
	zdbS72RyVCs0xyfxyJ5KUyp1s5WmJPWr9w/j0=; b=TgKxA4MWLOw8cJ0djmrUVg
	56koEF56R+ZGVMY++x/r8O5tXVjH2IDc7EpCeuTySiUVpxma8dBs0PYv2Tkwc2s3
	FhRNAiXHUVQoWF/dIb1peYX+nZ8rU5BddmnWMk60os9jg/v+ASS+6Y/zJGyvTBlk
	QSNhZeP+n5UZ+Rsa8RFkP5qsAkorqb3jd6TK7JPjpkULBMq9CxtrYoA70t0Lo2GN
	CnKmvFs27IJjrZoN99pug6hsmMbXslYtOgOMiMzNh8GX3VL5GLQHyo+mqXcWEpzk
	GDCa4Rl7YFt0FL+GHTSrkb+AYLBjxq77ef7sJ78kvu+XIcqP9X1usqxnNCsy+zfA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbp3gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 11:47:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6229NIrd003275;
	Mon, 2 Mar 2026 11:47:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xwwsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 11:47:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622BlPqW15729256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 11:47:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ABC058063;
	Mon,  2 Mar 2026 11:47:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D18EE58053;
	Mon,  2 Mar 2026 11:47:17 +0000 (GMT)
Received: from [9.39.17.112] (unknown [9.39.17.112])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 11:47:17 +0000 (GMT)
Message-ID: <94b3284b-885d-4263-99ed-728375c1a2b7@linux.ibm.com>
Date: Mon, 2 Mar 2026 17:17:16 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
To: Joel Fernandes <joelagnelf@nvidia.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>
Cc: peterz@infradead.org, aboorvad@linux.ibm.com, boqun.feng@gmail.com,
        frederic@kernel.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, sshegde@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
 <20260227011352.GA1089964@joelbox2>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260227011352.GA1089964@joelbox2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KvOpgJqZ1zlyzYK-3_Cfbd3EqA70ln14
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a578cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=sl4Q1M6oHhL7dvQWE3AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NyBTYWx0ZWRfX4s5QDiwffLbh
 wAejgv0dSaotM8mT0VZ8d9RSKWFBgGU52tRr/Fgz4vT50iG1YW9Hhbj3yRSuxWKUaWRYgDmbuXB
 GSFcVK3/JAnpbycmo5e7Sg6fdeWytQHCbXvpAnL9542SGhR8R+0cMntCWLlj7y8O2BnHeXyv6rN
 cHKvkhOT/2/5/Z9DXM9mPH2q6rMTYkrUNxPtOa5IVExoJQu7jWWZ2AiKmuG0LggIg4t5yXueh2j
 L1NumwVzFw/u99DL3gHP9jUvV4nWYFdUauOkGZv7InES6zr+3zuHdMzDysBHLSIca50W9ztzPgM
 2k1dxrzEqqpBLXKmysdJpaRNukdZLYisJ539uSYCNqmloRHDoMUS+f2U6vYMCteMRG9GcgGET0Z
 igxf5+6t3qRuLRArj5TvKhjubP8ZAxQKQ32j7PUhdAWPrYut/s4qJdsWJGOSw38FXjtk3saZvGp
 +ylmnxYBRxXN3qjQt0A==
X-Proofpoint-GUID: Mw_V7Jj6Xi8v1BbmJgaQBejTDGqtMq7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020097


On 27/02/26 6:43 am, Joel Fernandes wrote:
> On Wed, Feb 18, 2026 at 02:09:18PM +0530, Vishal Chourasia wrote:
>> Expedite synchronize_rcu during the SMT mode switch operation when
>> initiated via /sys/devices/system/cpu/smt/control interface
>>
>> SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
>> others are user driven operations and therefore should complete as soon
>> as possible. Switching SMT states involves iterating over a list of CPUs
>> and performing hotplug operations. It was found these transitions took
>> significantly large amount of time to complete particularly on
>> high-core-count systems.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>>   include/linux/rcupdate.h | 8 ++++++++
>>   kernel/cpu.c             | 4 ++++
>>   kernel/rcu/rcu.h         | 4 ----
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index 7729fef249e1..61b80c29d53b 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -1190,6 +1190,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>>   extern int rcu_expedited;
>>   extern int rcu_normal;
>>   
>> +#ifdef CONFIG_TINY_RCU
>> +static inline void rcu_expedite_gp(void) { }
>> +static inline void rcu_unexpedite_gp(void) { }
>> +#else
>> +void rcu_expedite_gp(void);
>> +void rcu_unexpedite_gp(void);
>> +#endif
>> +
>>   DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>>   DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
>>   
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 62e209eda78c..1377a68d6f47 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2682,6 +2682,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>>   		ret = -EBUSY;
>>   		goto out;
>>   	}
>> +	rcu_expedite_gp();
> After the locking related changes in patch 1, is expediting still required? I
> am just a bit concerned that we are papering over the real issue of over
> usage of synchronize_rcu() (which IIRC we discussed in earlier versions of
> the patches that reducing the number of lock acquire/release was supposed to
> help.)
>
> Could you provide more justification of why expediting these sections is
> required if the locking concerns were addressed? It would be great if you can
> provide performance numbers with only the first patch and without the second
> patch. That way we can quantify this patch.
>
> thanks,
>
> --
> Joel Fernandes
>
Hi Vishal/Joel,


Configuration:
     •    Kernel version: 7.0.0-rc1
     •    Number of CPUs: 1536

I have verified the below two patches together and observed improvements,
Patch 1: 
https://lore.kernel.org/all/20260218083915.660252-4-vishalc@linux.ibm.com/

Patch 2: 
https://lore.kernel.org/all/20260218083915.660252-6-vishalc@linux.ibm.com/
SMT Mode    | Without Patch(Base) | both patch applied | % Improvement  |
------------------------------------------------------------------------|
SMT=off     | 16m 13.956s         |     6m 18.435s     |  +61.14 %      |
SMT=on      | 12m 0.982s          |     5m 59.576s     |  +50.10 %      |

When I tested the below patch independently, I did not observe any 
improvements for either smt=on or smt=off. However, in the smt=off 
scenario, I encountered hung task splats (with call traces), where some 
threads were blocked on cpus_read_lock. Please also refer to the 
attached call trace below.
Patch 1: 
https://lore.kernel.org/all/20260218083915.660252-4-vishalc@linux.ibm.com/

SMT Mode    | Without Patch(Base) | just patch 1 applied   | % 
Improvement  |
----------------------------------------------------------------------------|
SMT=off     | 16m 13.956s         |     16m 9.793s         |  +0.43 %    
    |
SMT=on      | 12m 0.982s          |     12m 19.494s        |  -2.57 %    
    |


Call traces:
12377] [  T8746]    Tainted: G      E 7.0.0-rc1-150700.51-default-dirty #1
[ 1477.612384] [  T8746] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1477.612389] [  T8746] task:systemd     state:D stack:0   pid:1 
  tgid:1   ppid:0   task_flags:0x400100 flags:0x00040000
[ 1477.612397] [  T8746] Call Trace:
[ 1477.612399] [  T8746] [c00000000cc0f4f0] [0000000000100000] 0x100000 
(unreliable)
[ 1477.612416] [  T8746] [c00000000cc0f6a0] [c00000000001fe5c] 
__switch_to+0x1dc/0x290
[ 1477.612425] [  T8746] [c00000000cc0f6f0] [c0000000012598ac] 
__schedule+0x40c/0x1a70
[ 1477.612433] [  T8746] [c00000000cc0f840] [c00000000125af58] 
schedule+0x48/0x1a0
[ 1477.612439] [  T8746] [c00000000cc0f870] [c0000000002e27b8] 
percpu_rwsem_wait+0x198/0x200
[ 1477.612445] [  T8746] [c00000000cc0f8f0] [c000000001262930] 
__percpu_down_read+0xb0/0x210
[ 1477.612449] [  T8746] [c00000000cc0f930] [c00000000022f400] 
cpus_read_lock+0xc0/0xd0
[ 1477.612456] [  T8746] [c00000000cc0f950] [c0000000003a6398] 
cgroup_procs_write_start+0x328/0x410
[ 1477.612462] [  T8746] [c00000000cc0fa00] [c0000000003a9620] 
__cgroup_procs_write+0x70/0x2c0
[ 1477.612468] [  T8746] [c00000000cc0fac0] [c0000000003a98e8] 
cgroup_procs_write+0x28/0x50
[ 1477.612473] [  T8746] [c00000000cc0faf0] [c0000000003a1624] 
cgroup_file_write+0xb4/0x240
[ 1477.612478] [  T8746] [c00000000cc0fb50] [c000000000853ba8] 
kernfs_fop_write_iter+0x1a8/0x2a0
[ 1477.612485] [  T8746] [c00000000cc0fba0] [c000000000733d5c] 
vfs_write+0x27c/0x540
[ 1477.612491] [  T8746] [c00000000cc0fc50] [c000000000734350] 
ksys_write+0x80/0x150
[ 1477.612495] [  T8746] [c00000000cc0fca0] [c000000000032898] 
system_call_exception+0x148/0x320
[ 1477.612500] [  T8746] [c00000000cc0fe50] [c00000000000d6a0] 
system_call_common+0x160/0x2c4
[ 1477.612506] [  T8746] ---- interrupt: c00 at 0x7fffa8f73df4
[ 1477.612509] [  T8746] NIP: 00007fffa8f73df4 LR: 00007fffa8eb6144 CTR: 
0000000000000000
[ 1477.612512] [  T8746] REGS: c00000000cc0fe80 TRAP: 0c00 Tainted: G    
   E    (7.0.0-rc1-150700.51-default-dirty)
[ 1477.612515] [  T8746] MSR: 800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE> 
CR: 28002288 XER: 00000000



Regards,
Samir
>>   	/* Hold cpus_write_lock() for entire batch operation. */
>>   	cpus_write_lock();
>>   	for_each_online_cpu(cpu) {
>> @@ -2714,6 +2715,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>>   	if (!ret)
>>   		cpu_smt_control = ctrlval;
>>   	cpus_write_unlock();
>> +	rcu_unexpedite_gp();
>>   	arch_smt_update();
>>   out:
>>   	cpu_maps_update_done();
>> @@ -2733,6 +2735,7 @@ int cpuhp_smt_enable(void)
>>   	int cpu, ret = 0;
>>   
>>   	cpu_maps_update_begin();
>> +	rcu_expedite_gp();
>>   	/* Hold cpus_write_lock() for entire batch operation. */
>>   	cpus_write_lock();
>>   	cpu_smt_control = CPU_SMT_ENABLED;
>> @@ -2749,6 +2752,7 @@ int cpuhp_smt_enable(void)
>>   		cpuhp_online_cpu_device(cpu);
>>   	}
>>   	cpus_write_unlock();
>> +	rcu_unexpedite_gp();
>>   	arch_smt_update();
>>   	cpu_maps_update_done();
>>   	return ret;
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index dc5d614b372c..41a0d262e964 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -512,8 +512,6 @@ do {									\
>>   static inline bool rcu_gp_is_normal(void) { return true; }
>>   static inline bool rcu_gp_is_expedited(void) { return false; }
>>   static inline bool rcu_async_should_hurry(void) { return false; }
>> -static inline void rcu_expedite_gp(void) { }
>> -static inline void rcu_unexpedite_gp(void) { }
>>   static inline void rcu_async_hurry(void) { }
>>   static inline void rcu_async_relax(void) { }
>>   static inline bool rcu_cpu_online(int cpu) { return true; }
>> @@ -521,8 +519,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
>>   bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>>   bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>>   bool rcu_async_should_hurry(void);  /* Internal RCU use. */
>> -void rcu_expedite_gp(void);
>> -void rcu_unexpedite_gp(void);
>>   void rcu_async_hurry(void);
>>   void rcu_async_relax(void);
>>   void rcupdate_announce_bootup_oddness(void);
>> -- 
>> 2.53.0
>>


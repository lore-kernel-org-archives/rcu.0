Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812083DA7D1;
	Tue, 16 Jun 2026 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590234; cv=none; b=AkDHFawd4PQ24skGHvHS39qSjnHoi/evIb1IaTVCR+Y3tTH93sjCrWkit5r6cMrwSqRne00DcnlTk2hv/BFBfXhtSnI35BC3Xu8xpJHwhR10ngT7XuyB6sAtyESLVDwvKJw94NLVbTKTjDgqE+S5eEx4Qr9lM3NyLYFQH5xrDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590234; c=relaxed/simple;
	bh=FJ3XO5+CsVhYrUtvIWsI3MycqxYWA3mgfm8Uk0SE/gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU0zcOfItgCpeMQKQ6Degtw7Ulp58FBuH39G8lLVUgtGmT6pOFNJMJbOkT1Jnq9sjWvihWn+sKo8LjxdbgWykjXep23iznO+UvaRuN4Vbkb2bjs+L/1Qk+QaVsYJ05R+7CHI6Bolq/YMbTjQle2HOcnmZrdk6JQFfpnD6YegjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uygj5XhI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uygj5XhI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0mMMn3975754;
	Tue, 16 Jun 2026 06:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rnzOq1
	/Bd0unfJsQNHBjAvB63vbUrAPXSl6+fyLHbO8=; b=Uygj5XhI+m+Lka06KdWhm9
	DkYhQ1MbqAdUH2XcUhCwgi0YvCXPQTk4B49XtVaop4iBXDffLp6QcoI1AIoIbbbO
	g4nwTLKnbd5qzYtzK8vApcfrjuzehqUPIhM5xbDzmXEh04Yc3pNEpHB2LB9rEmRf
	smYb9Ile5HnbeJAUD5Krp64Z89ccTh0sQpChtrSwSp8cxo4f9mncr5PVhxbhq0aZ
	PJPSzwjvlHmR08tsDpmsnbJSUoFx8vM5dtprYKIZ1Migm1WS+rLUD11XWUp2IdXd
	F1bP+qOt4a6sXviJzL5uiTgoTxxqKHQANo3Lk3NekneZD3e29rXf++QGM6xpOTUw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2bmrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:10:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G65sXi002122;
	Tue, 16 Jun 2026 06:09:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww23qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:09:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G69tHC51446084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:09:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD00F20040;
	Tue, 16 Jun 2026 06:09:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 953F320043;
	Tue, 16 Jun 2026 06:09:50 +0000 (GMT)
Received: from [9.39.31.192] (unknown [9.39.31.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:09:50 +0000 (GMT)
Message-ID: <4bd12c51-414d-49b5-8fce-2a6e73a479fa@linux.ibm.com>
Date: Tue, 16 Jun 2026 11:39:49 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
To: paulmck@kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>,
        tglx@linutronix.de, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, aboorvad@linux.ibm.com,
        boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, urezki@gmail.com, samir@linux.ibm.com
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
 <20260615042514.694993-4-vishalc@linux.ibm.com>
 <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX2kLA9BegRX3r
 qPTZnfhTV2SSck0zjST+jIQnCkqcifEQWR4P5H+bTHLrtQ7aAXBq6edqZ6o1NIQy1umD0jreBP8
 QVaOZ7Maa5BpZdsfLn62xL01ZmNo9+A=
X-Proofpoint-GUID: s467W7Ue9ESbhLKDM8nwVNXAvkJ84KUg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX4z2ZtblGAkzR
 hDbwFGc3MSiQnvrDXHkXscDd+JxLljk/8w4oPnBo39svNEk+FCUIFK7NJIe0IVzwQCP4vchAx9h
 HRGLuSJnFP8m3oVkTTylB7cYgSuNf7bVI/PGaxcHGa1sJtWMotXGxfiEIzcYYdaKX6hZjKgaBUp
 3T6ez3RbJmyH7Pu3qbv6XBPLKYnvL7jTj2U0zy26CGvktpJlA2F9sML8nNKMKmz0F/4MyQwuuKq
 IV1GGrMouUJXghAzSZJvF5qGEkCAWX6XM0o2HEOBe9DNA0kNIgnXRvaVd9tizvzlDg+wZRj9kCL
 nRhyFXRNcMYjOw2dEa9dqq9EQUSSKjnuj3ulNn5qGPGJGXzUw55jaIAXuHYdsWNr8hhDZPhjX9O
 Ovavlqw+rhVyomqxvT/HkXvd5PNZtiWdo7niYmszAMv6gKLiGKmPQ1Xu262JNxUagr/720tN67J
 aLq3I3dmQ3Xu798Oe1w==
X-Proofpoint-ORIG-GUID: QvrHqgGOQjiPi6_n-JQ0jj7BQtsN91Nw
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a30e8b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=axXu-iBfu26a61bggtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160055



On 6/15/26 8:35 PM, Paul E. McKenney wrote:
> On Mon, Jun 15, 2026 at 09:55:16AM +0530, Vishal Chourasia wrote:
>> On large idle systems, changing system-wide SMT level using the sysfs
>> control interface still takes approximately 40-55 minutes. Changing SMT
>> levels is an user triggered operation generally done when systems are
>> fairly idle. This causes users to be blocked from doing other subsequent
>> work.
>>
>> Analyzing the collected profile data during SMT level switch, showed
>> that CPU hotplug machinery was blocked on synchronize_rcu() calls.
>>
>> Expedite RCU grace periods for the entire duration of triggered SMT
>> switch operation via the sysfs control interface. Individual CPU hotplug
>> operations via the online/offline interface are not affected.
>>
>> On a PPC64 system with 400 CPUs:
>>
>>    SMT8 to SMT1:
>>      before:  1m14s
>>      after:   3.2s   (~23x faster)
>>
>>    SMT1 to SMT8:
>>      before:  2m27s
>>      after:   2.5s   (~58x faster)
>>
>> On a large config system with 1920 CPUs, completion time improves from
>> ~1 hour to 5-6 minutes.
>>
>> Tested-by: Samir <samir@linux.ibm.com>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
>  From an RCU viewpoint:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thank you Paul for reviewing this.

> 
> I am guessing that you will be taking this up some other path, but if
> you would like it to to via RCU, please let me know.
> 
> 							Thanx, Paul
> 

I would prefer this to go via tip tree since main change is in cpu.c

Thomas, peter,
What do you guys suggest? can this go via tip tree?

Also, do you have any other review comments on this or test to be done?

>> ---
>>   include/linux/rcupdate.h | 8 ++++++++
>>   kernel/cpu.c             | 4 ++++
>>   kernel/rcu/rcu.h         | 4 ----
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index bfa765132de8..b6bccf131f1c 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -1178,6 +1178,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
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
>> index bc4f7a9ba64e..6351da9dffdc 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2658,6 +2658,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>>   	int cpu, ret = 0;
>>   
>>   	cpu_maps_update_begin();
>> +	rcu_expedite_gp();
>>   	for_each_online_cpu(cpu) {
>>   		if (topology_is_primary_thread(cpu))
>>   			continue;
>> @@ -2687,6 +2688,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>>   	}
>>   	if (!ret)
>>   		cpu_smt_control = ctrlval;
>> +	rcu_unexpedite_gp();
>>   	cpu_maps_update_done();
>>   	return ret;
>>   }
>> @@ -2704,6 +2706,7 @@ int cpuhp_smt_enable(void)
>>   	int cpu, ret = 0;
>>   
>>   	cpu_maps_update_begin();
>> +	rcu_expedite_gp();
>>   	cpu_smt_control = CPU_SMT_ENABLED;
>>   	for_each_present_cpu(cpu) {
>>   		/* Skip online CPUs and CPUs on offline nodes */
>> @@ -2717,6 +2720,7 @@ int cpuhp_smt_enable(void)
>>   		/* See comment in cpuhp_smt_disable() */
>>   		cpuhp_online_cpu_device(cpu);
>>   	}
>> +	rcu_unexpedite_gp();
>>   	cpu_maps_update_done();
>>   	return ret;
>>   }
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index fa6d30ce73d1..d6a63ee60bc0 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -521,8 +521,6 @@ do {									\
>>   static inline bool rcu_gp_is_normal(void) { return true; }
>>   static inline bool rcu_gp_is_expedited(void) { return false; }
>>   static inline bool rcu_async_should_hurry(void) { return false; }
>> -static inline void rcu_expedite_gp(void) { }
>> -static inline void rcu_unexpedite_gp(void) { }
>>   static inline void rcu_async_hurry(void) { }
>>   static inline void rcu_async_relax(void) { }
>>   static inline bool rcu_cpu_online(int cpu) { return true; }
>> @@ -530,8 +528,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
>>   bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>>   bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>>   bool rcu_async_should_hurry(void);  /* Internal RCU use. */
>> -void rcu_expedite_gp(void);
>> -void rcu_unexpedite_gp(void);
>>   void rcu_async_hurry(void);
>>   void rcu_async_relax(void);
>>   void rcupdate_announce_bootup_oddness(void);
>> -- 
>> 2.54.0
>>


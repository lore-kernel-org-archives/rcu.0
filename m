Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0730CD82;
	Mon, 16 Feb 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248508; cv=none; b=VL0C7JiSO4nszKPyVrHl1IbmTnZLgx1MI5Uu9HN17Z057T1CGPJBrpuoL63pwQkqYqDgBW0z/dwn7AkQM2RAR8uSWWFt0YjzYonbt8Pjdi3/c6ChzY8OdY9lYz7UIG+zbNbHhBWf/maJsrjqwd9MEZwctaImWH5I0/K8T4wUS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248508; c=relaxed/simple;
	bh=L3Zzrt/ZXDR3Yng6+HkQ/OpXJIemo7a+P7SkqV+uu+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eKXvbU5tlLSUc8ADAIkFpRLGN7crDAGTj4i6yBYSPKTyoxgPjTNJ/Civ8NmKmFN1jmAmThYw3n1V3SF1WzuhI29ZnDLCJiAAGUNYCVEehmBiwhnbxnPdQ/nwnVKfdDce5V/6ZVXq93FTUP1r/VZ1IK9KSHr6ucMkk0PdLFZ8vmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N3dIuZGW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N3dIuZGW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNjK433723169;
	Mon, 16 Feb 2026 13:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0ht8e4
	BfusQZlB/YM/QHjf2Q15H/aquQ7NM5nxL1H6A=; b=N3dIuZGWnakAuXoF2l53zv
	uoXBkc8oNqiSVWdBM8gFDuzjatQrbA4dt3oMf3LfGLcyIGFbTcMqNyZnmpBEj5zz
	GrFQJEtNMlnGt2zF20n0pq5/4H8GhTtNHj9RGlWHuB5j5OxSzQZUEgh7AdwRbnQK
	orgTOltD3KqXecb4gPdYqfL9IeRODoNpDw6LBprEdJzfOpqb9yyiP2T7J/H7zCyS
	y05tFaIevb0RuJFrmq7WqkMjhmMVsPOsKC/R0yJq5JTVIrtiq6Lc7L/y+h4EfOu3
	N31gIdl9PquUhUJzrrpQk0xkH3IAZLpzl04KDp8m+7J3FydrQo+ABCqSaW2upAxg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rqr1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 13:28:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GBVrU5025024;
	Mon, 16 Feb 2026 13:28:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb3rxnm5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 13:28:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GDS8Vt47186274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 13:28:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB872004E;
	Mon, 16 Feb 2026 13:28:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E5DA2004B;
	Mon, 16 Feb 2026 13:28:03 +0000 (GMT)
Received: from [9.111.89.117] (unknown [9.111.89.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 13:28:02 +0000 (GMT)
Message-ID: <8a13e96a-101e-42bd-97d3-dd1682d40a3a@linux.ibm.com>
Date: Mon, 16 Feb 2026 18:58:02 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpuhp: Optimize SMT switch operation by batching
 lock acquisition
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com, aboorvad@linux.ibm.com,
        peterz@infradead.org
References: <20260216121927.489062-2-vishalc@linux.ibm.com>
 <20260216121927.489062-4-vishalc@linux.ibm.com>
 <e90f73b8-744f-4522-a9b5-55b924671072@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e90f73b8-744f-4522-a9b5-55b924671072@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69931b6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fK6Ux09ZcTRJb3aLEdYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IwAXk8uUI5EzmL7I53AiGt5eUAh4dtwm
X-Proofpoint-ORIG-GUID: GlLlqTMFVRDXULyS68EwfS-_byIQOlv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDExMiBTYWx0ZWRfX1UNfk5cqr3BU
 GeTg1jBUlrGgdzLWB2tOF1vJ14m68QiRnI4EiwObxGBCqNBj2mbhTws8A8HGibCFvJiTqLDEWWF
 tV4oghfe4sLM5qJeFOAYzRPORdh4CgRLstoNUDc6U2I4jeKt/A/uUYlerKfZ+xRBM4DQcz0Y/BI
 4Dhq2wy+Y6wqHwy4NGBhhszy/iNN3KlSvE0EI1s57sqQJSpjfFLqKL8xpR0Qnn11zyx0Dm1f3Cb
 BZzOFO3AiqsmArPrh9pguq913oAVDYo1ZJnyek8nd2TkvkzHzyr0Ppu5tfzzQ/WFmtI2PG/6GPt
 +hZH2Uf1f/ae8BFTvvXcGZuI7iCTzs7I/OMYD+dEQduZN9i8uF41SLBG0Q0stp9Iu7tKwc2n9EF
 ivYDHUB2DduWtFYiH+opsVC4d5rpz1DEEtoHlbmnfJLflDOAUYJAx+eVxpMcGtTJcDDf2l1CZ3r
 mDXbbLOdXdPf8+U/32Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160112



On 2/16/26 6:27 PM, Shrikanth Hegde wrote:
> 

>>            */
>>           if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
>>               continue;
>> -        ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> 
> If you see comment in cpu_down_maps_locked, It says.
> 
>           * Ensure that the control task does not run on the to be offlined
>           * CPU to prevent a deadlock against cfs_b->period_timer.
>           * Also keep at least one housekeeping cpu onlined to avoid 
> generating
>           * an empty sched_domain span
> 
> Now, instead of running on the online_CPU you are now doing the _cpu_down
> functionality in the cpu which is going offline.
> 
> How are you preventing that deadlock?

Ok. I should have looked at updated code. My bad.

This is no longer true after below commit.
de715325cc47 cpu: Revert "cpu/hotplug: Prevent self deadlock on CPU hot-unplug"

> 
>> +        ret = cpu_down_locked(cpu, 0, CPUHP_OFFLINE);
>>           if (ret)
>>               break;
>>           /*
>> @@ -2688,6 +2714,9 @@ int cpuhp_smt_disable(enum cpuhp_smt_control 
>> ctrlval)
>>       }
>>       if (!ret)
>>           cpu_smt_control = ctrlval;
>> +    cpus_write_unlock();
>> +    arch_smt_update();
>> +out:
>>       cpu_maps_update_done();
>>       return ret;
>>   }
>> @@ -2705,6 +2734,8 @@ int cpuhp_smt_enable(void)
>>       int cpu, ret = 0;
>>       cpu_maps_update_begin();
>> +    /* Hold cpus_write_lock() for entire batch operation. */
>> +    cpus_write_lock();
>>       cpu_smt_control = CPU_SMT_ENABLED;
>>       for_each_present_cpu(cpu) {
>>           /* Skip online CPUs and CPUs on offline nodes */
>> @@ -2712,12 +2743,14 @@ int cpuhp_smt_enable(void)
>>               continue;
>>           if (!cpu_smt_thread_allowed(cpu) || ! 
>> topology_is_core_online(cpu))
>>               continue;
>> -        ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
>> +        ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
>>           if (ret)
>>               break;
>>           /* See comment in cpuhp_smt_disable() */
>>           cpuhp_online_cpu_device(cpu);
>>       }
>> +    cpus_write_unlock();
>> +    arch_smt_update();
>>       cpu_maps_update_done();
>>       return ret;
>>   }
> 


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE322258C;
	Mon, 12 Jan 2026 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222000; cv=none; b=XNe21mH2+ZNIwq3DVi2VchwLWdLK+Q7y6uiBzqI3MbLQEMAnAvShzc4LtnICR+If92mH0okb4/rvwQHM+POoT+6YUvy/8daUgONPqxKQ/YFCvI5FBUZ73s8U7b+fKLewYWEM1GDR7+ggA9om6z1b/YdOsXtlubjlIfEwv4/qPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222000; c=relaxed/simple;
	bh=ACBIUDse+JUzZyQISu792gLY11Lo2PG2ditpMDBm+rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lavkYC/KX4P+TWYkg1cSxw3B0+KyYyK1cJCWW2Kvc+L1c98Oe/h4YPprSdZ9K5nCp8X6i46tO8nLUpV/3cUh37djqRNyIgoF5frnaVXby7/XDV4fSKYZ1GFBut/PFxKTuZtyoh+iO4TNzirdtmgHzuH4CpQULwHxRNVL8/xC/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a/QP0y0Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a/QP0y0Q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BMkMNU023089;
	Mon, 12 Jan 2026 12:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n65erF
	421JM1WzsBAPPeQpfijff483LkeBlnwU4AoQo=; b=a/QP0y0QGyLXdO3Y7bBLJd
	rG4lwCAzBhELb0BGPio0pVao/dFR6AzJUSPqDUOkqaAJQc7VSBV7xSdjrg63wFM9
	XWbu+jSP0xur2JRDkX0yIMzWkvGNxcN35nBoZ/SXsz+ehAl98Ah6/cp5nvdpw3Y3
	YMXR79CQpav16B3s6YF55D6ldXy5HoCQ2TDpfJGEU+jVMJumdlXIaEZvcfby3MsR
	Eu5l82WpzOUUW3BxJNYLL2ESJ/EtinHDUIC8t7VPFZFE14XKh3ewA1vnGhnj49Qb
	NGCKByEdjqsb1QXCEADbdTOYLUqhXcTR9vLTKMSicvjUGA3cfDm3MuPop4rd+DyA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxv1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:46:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CCE2S7019908;
	Mon, 12 Jan 2026 12:46:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxv1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:46:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CB3xFd031299;
	Mon, 12 Jan 2026 12:46:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1dm1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:46:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CCkLjg26608072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 12:46:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6B6820043;
	Mon, 12 Jan 2026 12:46:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FB020040;
	Mon, 12 Jan 2026 12:46:17 +0000 (GMT)
Received: from [9.39.17.9] (unknown [9.39.17.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 12:46:17 +0000 (GMT)
Message-ID: <00c9096d-20cc-4584-a413-74e60995c3d8@linux.ibm.com>
Date: Mon, 12 Jan 2026 18:16:16 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Shrikanth Hegde <sshegde@linux.ibm.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
        joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
        urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
        peterz@infradead.org, srikar@linux.ibm.com
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <595f2ecd-020c-44f2-ba51-39a54c0e656f@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <595f2ecd-020c-44f2-ba51-39a54c0e656f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i8fCodDk0Q-zBAUmRv1R3SrAGSVw0nwk
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964ed23 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8 a=Vfsp1XFiFrZfeqIENTQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5OCBTYWx0ZWRfX7NSNns84qoyg
 dfAdV5rj7OEEMgl+qanPH9c/09uZUFtbcrddqnsB5KLVESgp4JNQ1qikiLhbU57/dDy0Q4JHgx5
 ZOcHGiM4lH7/nZNmookjVpqoAOVadMCgpODDslNVbg6RJp7wUmYItZLjL5WKzujy3uFQwgYNoIg
 dusJrKo/HvOJZp58j7DQxeCcAms1NpQTMmWWcVm/HjhNTsAZkym58el/BfElhfLTWxeeZNkhum/
 kskfnicTGzFtncUFTHqUoLAEtJq0/YpuNbJTUsfHik9JjO4q+H9eskEMazEUdB41q2OyILi9qQ5
 LkxcWihFa+lJwblHQ8OovYu9s6sCkYUxbyaec+HVdjB7W6+/OP8RRBKcxIvuqeC80gFv6QN5UtZ
 aAS5ndkwDpH7B5NSE1M6wK9Y31uCChLnsiWCqWx3MvpIf0reEZc0vFQUaAVbLrTcxJudJf+wnyt
 uD8V+KVHKv58JSFvqtA==
X-Proofpoint-ORIG-GUID: Y4nqisoM6wqGXkbOsnQVkTqwT12Jxju1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120098


On 12/01/26 17:51, Shrikanth Hegde wrote:
>
>
> On 1/12/26 3:13 PM, Vishal Chourasia wrote:
>> Bulk CPU hotplug operations—such as switching SMT modes across all
>> cores—require hotplugging multiple CPUs in rapid succession. On large
>> systems, this process takes significant time, increasing as the number
>> of CPUs grows, leading to substantial delays on high-core-count
>> machines. Analysis [1] reveals that the majority of this time is spent
>> waiting for synchronize_rcu().
>>
>> Expedite synchronize_rcu() during the hotplug path to accelerate the
>> operation. Since CPU hotplug is a user-initiated administrative task,
>> it should complete as quickly as possible.
>>
>> Performance data on a PPC64 system with 400 CPUs:
>>
>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
>> Before: real 1m14.792s
>> After:  real 0m03.205s  # ~23x improvement
>>
>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
>> Before: real 2m27.695s
>> After:  real 0m02.510s  # ~58x improvement
>>
>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
>>
>
> Hi Vishal,
>
> I tried on tip/master at 315f416d3e26.
> It fails to apply. is rcu tree updated?
I'm currently working off the GitHub mirror (|github.com/torvalds/linux)|
>
>
>> [1] 
>> https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>>   include/linux/rcupdate.h | 3 +++
>>   kernel/cpu.c             | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index c5b30054cd01..03c06cfb2b6d 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -1192,6 +1192,9 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, 
>> rcu_callback_t f)
>>   extern int rcu_expedited;
>>   extern int rcu_normal;
>>   +extern void rcu_expedite_gp(void);
>> +extern void rcu_unexpedite_gp(void);
>> +
>
> Why extern is needed? All it needs is declarations no?
Already declared in kernel/rcu/rcu.h

kernel/cpu.c already includes linux/rcupdate.h, therefore
added an extern.

>
>
>>   DEFINE_LOCK_GUARD_0(rcu,
>>       do {
>>           rcu_read_lock();
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 8df2d773fe3b..6b0d491d73f4 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -506,12 +506,14 @@ EXPORT_SYMBOL_GPL(cpus_read_unlock);
>>     void cpus_write_lock(void)
>>   {
>> +    rcu_expedite_gp();
>>       percpu_down_write(&cpu_hotplug_lock);
>>   }
>>     void cpus_write_unlock(void)
>>   {
>>       percpu_up_write(&cpu_hotplug_lock);
>> +    rcu_unexpedite_gp();
>>   }
>>     void lockdep_assert_cpus_held(void)
>
> Have you tested kexec path or suspend/resume path?
I did test kexec patch by booting into another kernel via kexec path.
But, I didn't test suspend/resume.

> Seems like the counter can nest, but would be good to verify.

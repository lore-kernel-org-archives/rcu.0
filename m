Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3F1E4AF;
	Mon, 12 Jan 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220489; cv=none; b=CYPkefK9f+91mez+lt9cqAaWsyU0XukDL0qCy0MAozEO3UlsZe42frF3vMFcw7csmAlvJY3XD6twmlmqHRfqXNPh0zMdGlDsknph6BcLPSMD47Q6dyBzA4E/VRyoFSPkkWFh4Gvsz3KRN+JyWC1DuiX5yPZ2dyby62w48Fmm6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220489; c=relaxed/simple;
	bh=FtH1Ht+976pIc2CMgm4kAhNt7aUueSWvyEw210G+NWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHVdr8NOFhq5U0wqsa4I3nEmWkz7PXLqdpS/MNm3JC8q1XVKnoBmC2zwX4BjdLnQZEKbvAOKsG5OoeY6FFYi4xEyzpMx7R7jgxaHy4TbKBhjj3h638Zi23ynkjfwrHQwFy0ykVvDklCkvuD3xzf9yQTtNSu4/Qtr9NA7M7X29pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JcOvWPcD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JcOvWPcD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BMkMLf023089;
	Mon, 12 Jan 2026 12:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TcOkFq
	BqzTUlqCfv5BH84nNdSsKLVeceT6jpmtpZE70=; b=JcOvWPcDuIUegqtKadDQr0
	uOnY18NA5YmJAJVBi0wqpYA7LdZ6/5VEo0WzCRtgOyG9xjJ/oEurg69RNkbeGmez
	6MzmIBgdkVqhUf+weTqP6k7yXfZFkNeb9J3Zd9f7S9tXnw3oR3F8G/U/mqt0FD6z
	oz7HfWAXYYL+8HNg75w/gntRnr/gfWdh934oveT4BL8aT7mGGidSzZ6x4vTfPtGq
	qHgtBU7HLZno4ibTJDqibsNHmjc6SEKtwevN4hvdCcpC9kfvCYypj51MmiDMEmqS
	0PBm0cbKlHnvkugGCr2+9G1H21r9B/1k4k/l5EHOH7DmpSUF42jFrP1gHmBSzKiQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxsba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:21:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CCLENt002926;
	Mon, 12 Jan 2026 12:21:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxsb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:21:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAJcaG025838;
	Mon, 12 Jan 2026 12:21:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk5ry8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:21:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CCL9wg28967598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 12:21:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B87A20040;
	Mon, 12 Jan 2026 12:21:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B5E920043;
	Mon, 12 Jan 2026 12:21:06 +0000 (GMT)
Received: from [9.124.219.252] (unknown [9.124.219.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 12:21:06 +0000 (GMT)
Message-ID: <595f2ecd-020c-44f2-ba51-39a54c0e656f@linux.ibm.com>
Date: Mon, 12 Jan 2026 17:51:05 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Vishal Chourasia <vishalc@linux.ibm.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
        joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
        urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
        peterz@infradead.org, srikar@linux.ibm.com
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260112094332.66006-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F1AuUaqSRYwScsBe-G1tSlaxYB5Wi6E-
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964e73a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3PIjFlzdpYnZ60iAWMMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5OCBTYWx0ZWRfXzb6qnokQ2huv
 tON0BkFPiXl5KlIEZ0DtZ+7+tCT1PWo0xqRGdiHQb6bYYWUb1Lw24wKnLenI0R2kXleDWWrE3Bf
 pBs5gr6bgExDH876Gmvweq6+JYjA6rNHAweUKEhjTm4ijIYpEW7lC1tLfZDQIYZrbfCGVbns6fl
 lGZ/MbQ6uDc0yosBrW0PX3jOYlMMZgnvFC+QeLiWueXbpAC6QDrt8pvYU5MSpJCSe2fbEuxBUYE
 MpSsSrm7QWg2UbDKK6JX/vpAmP0SO/zyza8m1mw4P28SGZVf2cJyPDSJ1khyIMdiQuc3fpzMKJU
 qZzDWbSEypD8WZ1ZQZCkq90G97k3P0WDAXGCfG+kULpjDr0G2Yx18mEFBPMKlC4Qkbx/62f+BXN
 hMlxRhs+3nVvGcT4rR33sk8s+pVYnfARi2GrTlhIC2J135uyZu0iwxaKx7q8Su5Lrbe5YNBPRcF
 UqM4gW6mXKzmGSMHZuw==
X-Proofpoint-ORIG-GUID: IGFioE-0YPMVREHmMGzghMk3y_-tMaYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120098



On 1/12/26 3:13 PM, Vishal Chourasia wrote:
> Bulk CPU hotplug operations—such as switching SMT modes across all
> cores—require hotplugging multiple CPUs in rapid succession. On large
> systems, this process takes significant time, increasing as the number
> of CPUs grows, leading to substantial delays on high-core-count
> machines. Analysis [1] reveals that the majority of this time is spent
> waiting for synchronize_rcu().
> 
> Expedite synchronize_rcu() during the hotplug path to accelerate the
> operation. Since CPU hotplug is a user-initiated administrative task,
> it should complete as quickly as possible.
> 
> Performance data on a PPC64 system with 400 CPUs:
> 
> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> Before: real 1m14.792s
> After:  real 0m03.205s  # ~23x improvement
> 
> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> Before: real 2m27.695s
> After:  real 0m02.510s  # ~58x improvement
> 
> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> 

Hi Vishal,

I tried on tip/master at 315f416d3e26.
It fails to apply. is rcu tree updated?


> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   include/linux/rcupdate.h | 3 +++
>   kernel/cpu.c             | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index c5b30054cd01..03c06cfb2b6d 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1192,6 +1192,9 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>   extern int rcu_expedited;
>   extern int rcu_normal;
>   
> +extern void rcu_expedite_gp(void);
> +extern void rcu_unexpedite_gp(void);
> +

Why extern is needed? All it needs is declarations no?


>   DEFINE_LOCK_GUARD_0(rcu,
>   	do {
>   		rcu_read_lock();
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8df2d773fe3b..6b0d491d73f4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -506,12 +506,14 @@ EXPORT_SYMBOL_GPL(cpus_read_unlock);
>   
>   void cpus_write_lock(void)
>   {
> +	rcu_expedite_gp();
>   	percpu_down_write(&cpu_hotplug_lock);
>   }
>   
>   void cpus_write_unlock(void)
>   {
>   	percpu_up_write(&cpu_hotplug_lock);
> +	rcu_unexpedite_gp();
>   }
>   
>   void lockdep_assert_cpus_held(void)

Have you tested kexec path or suspend/resume path?
Seems like the counter can nest, but would be good to verify.

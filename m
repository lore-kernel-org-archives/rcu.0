Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B7325484;
	Sun, 18 Jan 2026 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768736370; cv=none; b=GY1/8DezDbCQa0qcinPOQ/SyKhy2TA2oGdwJLZREgWlFVtYXV8ixGpbgTFJq8flM7D0z2kyaoR83oyZSBX1CR+S33Le5N75utoB0gUe8xN8HSANDVfZpB77h0wAmogBdeNnTWIMIZbUGNZI3/tWMNayzYKILj9y1tBb9/RDDFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768736370; c=relaxed/simple;
	bh=SrTfe38BQW+VIfFMsO1Xl/ff9iVrGkUd8PiPrEDb+x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSZmf10s38w5UsOEYWzPANDdZJx6gfM8FLjYrIpVa+S5tVKVoo3fYvCh/nS+wR9jdrQ8MniYW+TR+Y2HJoxCXUTZt9SxYWmN9ubLHyeV5XgPxpMEDxkNmxS95V0T8J29sVoJEUDK0EhmW+47JAjZ9Aep8I7TbKkzVXlxHF8iZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z62ZAl9L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z62ZAl9L"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60I3QOTh001993;
	Sun, 18 Jan 2026 11:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0t3OUn
	pno9QKPfYdYLct7kfN9FSEcnFnQR60H8ObpsQ=; b=Z62ZAl9LoTsolevhXiCFWh
	DnXfCNrLnpOvIrMDaaxrS0LrB6O1V/0NaHbe9MqWcXHGJqN1mQZqkUBvoPUd09LJ
	xHpJxqKXRqI8OM9Ys2ZW2tLuYEYGSrpQ9Q0Hzx4L4OE+eGmKytTL769+Y4htyUtf
	u+IxiBppY3SzfDdYHG4WZnvIAKVrykFitbHtQAbXoSNXEa3hG4Es0Cc5ENoeieAj
	7b3jKUEqlOCDLJJln7Hi9uDBzqQQNYSM/Vsq045Vp/N9ovrJP9Favi8CFX53j//2
	eZSSnQ7KeC/wwouhhCKVL0PgYROm72qZDlFy8TCoEIQugtJPt5lJTiWgj56qGcbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4v1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 11:38:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60IBVjX7019126;
	Sun, 18 Jan 2026 11:38:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4v1sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 11:38:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60I86UPx001168;
	Sun, 18 Jan 2026 11:38:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyj9gax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 11:38:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60IBcqVw22086346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Jan 2026 11:38:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA6258059;
	Sun, 18 Jan 2026 11:38:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C8F058058;
	Sun, 18 Jan 2026 11:38:46 +0000 (GMT)
Received: from [9.39.20.96] (unknown [9.39.20.96])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Jan 2026 11:38:45 +0000 (GMT)
Message-ID: <9e57a091-2f34-402a-972a-31dd9a10664b@linux.ibm.com>
Date: Sun, 18 Jan 2026 17:08:44 +0530
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
        peterz@infradead.org, sshegde@linux.ibm.com, srikar@linux.ibm.com
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260112094332.66006-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696cc64f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ArEKAlU64k2IArq-_hAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gTdBpOLtDbNqIDyUPfxyF0SUuYg5md2V
X-Proofpoint-GUID: 2pL37gvZZ0bmC6VEQmuBN-Q1i0d449eV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDA5OCBTYWx0ZWRfX+JIbVukPV5jS
 /TZXnbkmOooB+xXU9loXFpWydPSD1QDVkEkgoDwfij8//KjudQzffrwfYTqqKmUqQ096HmtFc1S
 gzc8YH+i7PQNyzk6xM5YzPQaHJOD8MLy54WBnKdZoSCp6AI+WKUohhdJ7c3n9DHEnKnQaYYGrMd
 BENoymrninYbJIFhEqZqkQX4Y1Cr8OvlXLtDrhT/3ZdGcpRwfFzibeAikya80HOB4IoW5xcfDeJ
 xurBfGYNigegh4jJ4oC3VQk7gKlQbmotGKe3BJYOT8LOUA0N2FbfSjM0iIVevHx0L4+0op8VL6l
 jK8rRSdpftPVipJeuuKm7AXl/WUpAT88lGOYlL4bVkjWxYE1g2bKOcBqGOzit+uxbBKbaUNsgkD
 QysZk5ftL6rj5MDx+Eu0ouaY6mIqI9ab3dEELszsjW01yjAevN84Cx1LsUuWVUYUaawetRKkdQq
 N0IrJNAZD6xpBkwvWrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601180098


On 12/01/26 3:13 pm, Vishal Chourasia wrote:
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
Hi Vishal,

I verified this patch using the configuration described below.
Configuration:
     •    Kernel version: 6.19.0-rc5
     •    Number of CPUs: 2048


Using this setup, I evaluated the patch with both SMT enabled and SMT 
disabled. patch shows a significant improvement in the SMT=off case and 
a measurable improvement in the SMT=on case.
The results indicate that when SMT is enabled, the system time is 
noticeably higher. In contrast, with SMT disabled, no significant 
increase in system time is observed.

SMT=ON  -> sys 31m18.849s
SMT=OFF -> sys 0m0.087s


SMT Mode    | Without Patch    | With Patch | % Improvement    |
------------------------------------------------------------------
SMT=off     | 30m 53.194s      |  6m 4.250s  | +80.40%          |
SMT=on      | 49m 5.920s       | 36m 50.386s | +25.01%          |


Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>

Regards,
Samir



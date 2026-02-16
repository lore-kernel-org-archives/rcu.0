Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4082BE031;
	Mon, 16 Feb 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261852; cv=none; b=BExkrWPWiaa59wOBeM0/ZDFRtRmurSK62VTUH/q7nCA7LcaG9ow6m+rlzKmifPisD6D0XHMOLU5BsEBh3XDbZar8AVI0yw4+GbLukiyALTlcGeANAOfbuHOquaI28938qJmIivSU4Dc5e6x5WHxljO4x2UZfjngw1WWd8udEAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261852; c=relaxed/simple;
	bh=RvLLu6r2oYeJMaO2NJ8pMKxwEQj80Vq+zYa9R99DmjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmVs1LmyBnVw0vuhR6D272AgprxF3wMJnBFluNeG4nfJChe6g4xlZ0zotHbRnjBqS467LXMaVqlX30U+MnNbrk1nk1EBFWSCmCuAmROjNiIYF5XoCTnpaCjrxdL2PcFk8AyK96ryW65EAsLL7Dy0t9Be7tdwt/8S6m2VkW+RO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XP1WgaQw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XP1WgaQw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GEuRfU3334363;
	Mon, 16 Feb 2026 17:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D2498H
	+pEG1GxRux5/u/M81KOFrsycBPA91ghkRtxpk=; b=XP1WgaQwJgyCNHSyZnoCpS
	lnOMqgXYE4UpIsBenNT5/RLlxG1rPucWYLNyfuhkFa/2REdPMTvDtFs4jaoWqrPL
	/KgeZ77HTiJ62KpzwuIkvfsaRq26ZAnU6iyZm+ctcdYL8zzebKL6w0OmNQdLOXoy
	BCc+rIt1Zzql05+UKC40UzKVSW1ixDDUGAtnu8wsniaxQvnz1GZqT1Z/fqFcTe2/
	AOA4oHkNtI4VHX7zrsV5jCcijTgKlv8iY8ViUqit8XQj7iV8HcKyiPo081F5ClIr
	tnwMDb2aHRUsuaP9vvXvXNndC8svw8b7zmk+iNX6u61olo/MmcRaXAX5zqLou6JQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k83pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 17:10:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GGoFHn004255;
	Mon, 16 Feb 2026 17:10:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmx6ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 17:10:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GHAWVE37814740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 17:10:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D293D20043;
	Mon, 16 Feb 2026 17:10:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B94720040;
	Mon, 16 Feb 2026 17:10:28 +0000 (GMT)
Received: from [9.111.89.117] (unknown [9.111.89.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 17:10:27 +0000 (GMT)
Message-ID: <ba470918-0ad9-4548-9161-826948462f73@linux.ibm.com>
Date: Mon, 16 Feb 2026 22:40:26 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
To: Vishal Chourasia <vishalc@linux.ibm.com>, rcu@vger.kernel.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, srikar@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        aboorvad@linux.ibm.com, peterz@infradead.org, joelagnelf@nvidia.com
References: <20260216121927.489062-2-vishalc@linux.ibm.com>
 <20260216121927.489062-6-vishalc@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260216121927.489062-6-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE0NyBTYWx0ZWRfX75Mmj0SCq21A
 4PzkTbnVbnQs3aI/XTRWjgHF39Bt8s1ZOHkRac1zqFON48TA1mLUkAjbaYmQqHtvXAtjIcqpmVa
 HonlKRccGl+LvD1Th+x8tZ6g2lbRoMew1ZLEAwserijkq1qDj1xPmDfYhGpQCe6bI3jzpXpjJhq
 ne5fs0l0W2t03BrEgbCUUCXvRYf+594NvFjQU7IDVQ0yiEReIbmfFaFZMedXSw+2PfDJm0freYV
 TMGyxeEaHiTmC5e+zWZ2tVhHdwbz27H4geCfpy91KpxBBuHC0+KLPP/3U+ney8sq5eAEXP+SLdT
 DBjMi/BES2fV7vkStPzctRH9LCXFi9KflkrR1QCZEunw1xtO/scUp4s/FrRce7HrLYFmwH1LXxC
 EY3u1BI/xM6//8Iq803+AHDrqds6JPP+2gRVx1YJb8H8krw+1Qs4smvUv/GJ6pcoltIlrJ/m5z7
 YH5Er9HpxPjnpkxKnmw==
X-Proofpoint-ORIG-GUID: ug069sof1ZF3P-X34wiHyOMmI6PZAdb3
X-Proofpoint-GUID: LDi1a-DKdQB4fQIFtgJHGa3GLF20ABgz
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69934f8d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=bHnMymmFoG_4sP2WlFgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_05,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160147



On 2/16/26 5:49 PM, Vishal Chourasia wrote:
> Expedite synchronize_rcu during the SMT mode switch operation when
> initiated via /sys/devices/system/cpu/smt/control interface
> 
> SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
> others, are user driven operations and therefore should complete as soon
> as possible. Switching SMT states involves iterating over a list of CPUs
> and performing hotplug operations. It was found these transitions took
> significantly large amount of time to complete particularly on
> high-core-count systems because system was blocked on synchronize_rcu
> calls.
> 
> Below is one of the call-stacks that accounted for most of the blocking
> time overhead as reported by offcputime bcc script for CPU offline
> operation,
> 
>      finish_task_switch
>      __schedule
>      schedule
>      schedule_timeout
>      wait_for_completion
>      __wait_rcu_gp
>      synchronize_rcu
>      cpuidle_uninstall_idle_handler
>      powernv_cpuidle_cpu_dead
>      cpuhp_invoke_callback
>      __cpuhp_invoke_callback_range
>      _cpu_down
>      cpu_device_down
>      cpu_subsys_offline
>      device_offline
>      online_store
>      dev_attr_store
>      sysfs_kf_write
>      kernfs_fop_write_iter
>      vfs_write
>      ksys_write
>      system_call_exception
>      system_call_common
>     -                bash (29705)
>          5771569  ------------------------>  Duration (us)
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   include/linux/rcupdate.h | 3 +++
>   kernel/cpu.c             | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 7729fef249e1..f12d0d0f008d 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1190,6 +1190,9 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>   extern int rcu_expedited;
>   extern int rcu_normal;
>   
> +extern void rcu_expedite_gp(void);
> +extern void rcu_unexpedite_gp(void);
> +
>   DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>   DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
>   

IMHO, below maybe better.

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f12d0d0f008d..61b80c29d53b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1190,8 +1190,13 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, 
rcu_callback_t f)
  extern int rcu_expedited;
  extern int rcu_normal;

-extern void rcu_expedite_gp(void);
-extern void rcu_unexpedite_gp(void);
+#ifdef CONFIG_TINY_RCU
+static inline void rcu_expedite_gp(void) { }
+static inline void rcu_unexpedite_gp(void) { }
+#else
+void rcu_expedite_gp(void);
+void rcu_unexpedite_gp(void);
+#endif

  DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
  DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), 
__releases_shared(RCU))
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index dc5d614b372c..41a0d262e964 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -512,8 +512,6 @@ do { 
                        \
  static inline bool rcu_gp_is_normal(void) { return true; }
  static inline bool rcu_gp_is_expedited(void) { return false; }
  static inline bool rcu_async_should_hurry(void) { return false; }
-static inline void rcu_expedite_gp(void) { }
-static inline void rcu_unexpedite_gp(void) { }
  static inline void rcu_async_hurry(void) { }
  static inline void rcu_async_relax(void) { }
  static inline bool rcu_cpu_online(int cpu) { return true; }
@@ -521,8 +519,6 @@ static inline bool rcu_cpu_online(int cpu) { return 
true; }
  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
  bool rcu_async_should_hurry(void);  /* Internal RCU use. */
-void rcu_expedite_gp(void);
-void rcu_unexpedite_gp(void);
  void rcu_async_hurry(void);
  void rcu_async_relax(void);
  void rcupdate_announce_bootup_oddness(void);


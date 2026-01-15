Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E239E199;
	Thu, 15 Jan 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497841; cv=none; b=XnP5Zunni+IRCkkLH4/7+WDWlSh85BSrXrnuLOeYaReC7mVRqzCF8pcLa0dyRI5VaxMP497Q8Kkghu0NHbQ2SLuW60v6qp9GnrnDsRQTN2ql3Hiw3iJZYSHg22lmXIruR14X3uvRN25o0qGyWlSio3hHcoNHZpUWkCFPkXoIaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497841; c=relaxed/simple;
	bh=66etxKRvxNvn3ET7c3iGJMDT/K63hJo5EWSo3U9elms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hakHAvUk3mjbL0s7YAeNJySrZ8rGEXA+AsaGZIqPA4nP6BxJNQQhZWVONDE9/F3gww8w105rCDdVOPmN6Pw/v+lCK5yYrWUNZtIOKzktH2SkmjxcRqXQohsZf2GVTOTLXNBwTL23AeF01eIMGdKSp7VeBolUtLDj0h8UY8Lxslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nF0RvZQy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nF0RvZQy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FF6SBI019683;
	Thu, 15 Jan 2026 17:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+MG2uv
	NuGtt+P6RPKwJUgABSvjOlAjkmli0DsIAbPF0=; b=nF0RvZQyUbM/Bi9OElNaNF
	+jHVb1R3rjlNJoUPQdjzu0AvY3ZsdzXsOOh89jYcsJuZgDYi5aDJheBUeFp/PdSg
	ZDDE0x6/Qn/fCLn9K+qzRMfSJcvBrMJOmifXVGhw7akLKwz4nn3Qwwxe9GTZ2qr5
	TPUjvQZtommaPHfV3O9DC+EXf50WkA59p1YY8r/BAYTBrs/JpkL2jlJf2urMWUIF
	u0JDBEwvoX+fbcE/zWJU9lD1m0WIbTKRo4r6r7bh57pPSFsx+zTov5gWWaCY7DFb
	TpavIKAGHvqCXSrmlPa2S+oNl1iwcqX7tcynPD506ZOiNICpY5791hx0PDHxeWeg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hfh8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 17:23:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60FHNsNg024760;
	Thu, 15 Jan 2026 17:23:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hfh8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 17:23:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FFnxRQ030153;
	Thu, 15 Jan 2026 17:23:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ak15rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 17:23:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60FHNnr130933756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 17:23:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6DEC20043;
	Thu, 15 Jan 2026 17:23:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E874320040;
	Thu, 15 Jan 2026 17:23:47 +0000 (GMT)
Received: from [9.124.218.20] (unknown [9.124.218.20])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Jan 2026 17:23:47 +0000 (GMT)
Message-ID: <f83b53da-7812-4285-a1db-2fa0fb8d611a@linux.ibm.com>
Date: Thu, 15 Jan 2026 22:53:47 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir@linux.ibm.com
Cc: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>
References: <20260114183415.286489-1-urezki@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260114183415.286489-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GuUHrssUNCWRsQFe-dB7KVlUOT3cEnOf
X-Proofpoint-ORIG-GUID: FCxUpRQTA7kC5804mrP6jDJkMyVb0iaO
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=696922ab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=-__R_ZiZeJJP44i4oVMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEzMiBTYWx0ZWRfXyZbFcilgBJtW
 +6+/WCyHyUV6fdoFLhFZ/yuJaYfomna8/vOUjEEbCA4QtOHpfEKSlj1zr58QT6jyQth3ucJu4sV
 5FP2XrtxvfX7Jgq20XLCaJnGTQYa9aPLAJ6nF/SVg3Wg/0Z7JhJEUHkziUmIij9xPKlQ2HPY6Uf
 7Q/xNp9X7bODo4DOyjQQz4+79oiW6eSlMqdB3QtTF8hKgktXrnCRpcRvp3Nrcro6CFeG5N97Jh4
 EQG8GhtXf5peuoR4X9YbqeKpBLmc4EMR2mcUZpePC7uQMJQ360cxyO8qG6rvIkMKsAwZhaCt3qG
 SQvaM9lnGnj9SL8i9ggDW2Xv2j4PolTt7kOllNgfdv+0ogq3RUgFuEDwOxObCTheMByJDVMnFwk
 WwEtxynKHqJe54DYeWfkjiivRVmNPIrWAfEaLpIICOJ8OAEe6dKuvpuaKMRlmIUCHHDzT6EIQeg
 tGWG8IEhsYueR2zROGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150132

+samir

On 1/15/26 12:04 AM, Uladzislau Rezki (Sony) wrote:
> Currently, rcu_normal_wake_from_gp is only enabled by default
> on small systems(<= 16 CPUs) or when a user explicitly set it
> enabled.
> 
> This patch introduces an adaptive latching mechanism:
>   * Tracks the number of in-flight synchronize_rcu() requests
>     using a new atomic_t counter(rcu_sr_normal_count);
> 

is this atomic variable getting updated by multiple CPUs at the
same time? We had seen in past such updates tend to be very costly.

>   * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
>     the rcu_sr_normal_latched, reverting new requests onto the
>     scaled wait_rcu_gp() path;
> 
>   * The latch is cleared only when the pending requests are fully
>     drained(nr == 0);
> 
>   * Enables rcu_normal_wake_from_gp by default for all systems,
>     relying on this dynamic throttling instead of static CPU
>     limits.
> 
> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>   kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 293bbd9ac3f4..c42d480d6e0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>   	atomic_set_release(&sr_wn->inuse, 0);
>   }
>   
> -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> -
> -static int rcu_normal_wake_from_gp = -1;
> +static int rcu_normal_wake_from_gp = 1;
>   module_param(rcu_normal_wake_from_gp, int, 0644);
>   static struct workqueue_struct *sync_wq;
>   
> +#define RCU_SR_NORMAL_LATCH_THR 64
> +
> +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> +static atomic_long_t rcu_sr_normal_count;
> +static atomic_t rcu_sr_normal_latched;
> +
>   static void rcu_sr_normal_complete(struct llist_node *node)
>   {
>   	struct rcu_synchronize *rs = container_of(
>   		(struct rcu_head *) node, struct rcu_synchronize, head);
> +	long nr;
>   
>   	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
>   		!poll_state_synchronize_rcu_full(&rs->oldstate),
> @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>   
>   	/* Finally. */
>   	complete(&rs->completion);
> +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> +	WARN_ON_ONCE(nr < 0);
> +
> +	/*
> +	 * Unlatch: switch back to normal path when fully
> +	 * drained and if it has been latched.
> +	 */
> +	if (nr == 0)
> +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
>   }
>   
>   static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
>   
>   static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>   {
> +	long nr;
> +
>   	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> +
> +	/* Latch: only when flooded and if unlatched. */
> +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
>   }
>   
>   /*
> @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
>   
>   	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>   
> -	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> +			atomic_read(&rcu_sr_normal_latched)) {
>   		wait_rcu_gp(call_rcu_hurry);
>   		goto trace_complete_out;
>   	}
> @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
>   	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>   	WARN_ON(!sync_wq);
>   
> -	/* Respect if explicitly disabled via a boot parameter. */
> -	if (rcu_normal_wake_from_gp < 0) {
> -		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> -			rcu_normal_wake_from_gp = 1;
> -	}
> -
>   	/* Fill in default value for rcutree.qovld boot parameter. */
>   	/* -After- the rcu_node ->lock fields are initialized! */
>   	if (qovld < 0)


Samir,
Could you please give this patch a try on 1000+ cpu system?

Specifically test time taken for SMT1 to SMT8 and SMT8 to SMT1 switching
time.


Uladzislau, Is there any specific testing(other than above) you are looking for?



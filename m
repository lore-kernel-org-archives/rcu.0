Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BE76025;
	Sat, 17 Jan 2026 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768630645; cv=none; b=IqjyGEyJrlP8w13N9DmgxHGBLAWIpA/rE2kXVuW7cEu5pXoIBqK1/bpuDwLQEUq2YtnCtA1fE9+ancZYqA2uwtQu6hX6cOjAj1/AP5BdcS5ELxzP6rB5flqI85jRxvcrOF/RSFH6RwxxZpvhslus6d1maSPyBdWquQFxqzKLs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768630645; c=relaxed/simple;
	bh=b/EGeRYQWPoccEXboQOiVBy9D3GvFkTKA8pB2s0sO7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtlMnYqwRICV42+droejVViTc3EOH9j6d0RjJl8iVq/b3OufoXva0Ka8OTjUa395G2sCZDZhMQJhvMFRHc1p5miIut5k5mFTbb1qQGgAu2Zu6LXE/sP2C3ePo57c2AfXnmxMARTOud8QePlUPzvft+EH3XjuGjBDzzFhypKvKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7y0/xS1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7y0/xS1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H4GexN003326;
	Sat, 17 Jan 2026 06:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OoGMwF
	5TVC0GXgjbBEsXmg5NZt8mZQNK0WEVYj3TmT0=; b=R7y0/xS1x9L0EUz4e69NQ0
	g1G9NTL+lh5TbR+wO+l+BnTm/VoDXiAYIj9Hex6DJf1G8QgX18jlmxtm3KyxZgkp
	bSW/Fu71TusI8192aZrxIgKORSx/R6DIcAtPv1rDyvMP1T53C9/Cz4DFeLPEvml3
	eNulzokAuI2zZyZjDL2AwAHfH7I4UnnWwJiBowO71xIlCNbKysQDjV7fZX8wNaFe
	0n2lt+eN7ZkQGm7iOf40CEVKlosshgoBS8DDZ9uaUh50Rg/daWjsdEGMFeX1xHZd
	dppE3/22OwnVEc8llGAfcNOJZ+bx3V5i+8GFN9amFRCrNpuf3lMC5VgZrfoQoo0g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf0hbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 06:17:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60H6HGbh006963;
	Sat, 17 Jan 2026 06:17:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf0hba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 06:17:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5LgTV009128;
	Sat, 17 Jan 2026 06:17:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bqv8xhw95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 06:17:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60H6HEa720513500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 06:17:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5645803F;
	Sat, 17 Jan 2026 06:17:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E5258055;
	Sat, 17 Jan 2026 06:17:10 +0000 (GMT)
Received: from [9.124.219.237] (unknown [9.124.219.237])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 06:17:10 +0000 (GMT)
Message-ID: <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
Date: Sat, 17 Jan 2026 11:47:08 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20260114183415.286489-1-urezki@gmail.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260114183415.286489-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xsE9CC8_N_syRNw1-perRmYPrVSGKIa4
X-Proofpoint-ORIG-GUID: xCTfnxv50avBj2Wtn0ipKUdAR7173DQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA0OSBTYWx0ZWRfX/xDpqCYW758p
 XmVeo64QRZf3lOFAa7ZB3F8IxaW/3DK9XIgxmMKogKMhDWez4RE8500hZ0mzkSWLfzp10Ueij+Z
 yBsYifz4G63E3U/JuXqZwraqKZ4COsnCdVgHqfEhfgTZrkCBw/Ef2noaSSIga0a9Yb70a/Atki5
 B4FdSqfP7rwZq30ckYYThe6O10IxNduQfp6zpdKFMLtd90u5yB6oyI7NQul2vjnXPpzB3rxD8i6
 ZhCur444Hh3S8AMEyjcqBOUGc/+tmX+xilaJ0BnQGnlIbpVt576uqMV6EYEUDxMR+Ag493h36tg
 gAmCgr85Y1au5clATG6YFWUEsBwH6KGkB4T/s/H8QmnQlp/OR+cBVHbRdeLfPonxWiSaMmIgS9Z
 BQlBbEFw0jvhHwEVobNlOHqzjG4hiWXp3TD92Kj7CKcfUCdXnu1kBXo4dde131d9cl9JHEse2UM
 U8Nsl2D+BApL2RiE0vw==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696b296d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=-__R_ZiZeJJP44i4oVMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601170049


On 15/01/26 12:04 am, Uladzislau Rezki (Sony) wrote:
> Currently, rcu_normal_wake_from_gp is only enabled by default
> on small systems(<= 16 CPUs) or when a user explicitly set it
> enabled.
>
> This patch introduces an adaptive latching mechanism:
>   * Tracks the number of in-flight synchronize_rcu() requests
>     using a new atomic_t counter(rcu_sr_normal_count);
>
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


Hi Uladzislau,

I verified this patch using the configuration described below.
Configuration:
     •    Kernel version: 6.19.0-rc5
     •    Number of CPUs: 2048

Using this setup, I evaluated the patch with both SMT enabled and SMT 
disabled. The results indicate that when SMT is enabled, the system time 
is noticeably higher. In contrast, with SMT disabled, no significant 
increase in system time is observed.

SMT=ON  -> sys 31m22.922s
SMT=OFF -> sys 0m0.046s


SMT Mode    | Without Patch    | With Patch   | % Improvement    |
------------------------------------------------------------------
SMT=off     | 30m 53.194s      | 26m 24.009s  | +14.53%          |
SMT=on      | 49m 5.920s       | 47m 5.513s   | +4.09%           |


Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>

Regards,
Samir



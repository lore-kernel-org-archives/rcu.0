Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6219AD5C;
	Sat, 17 Jan 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652355; cv=none; b=NTZEyHb9JWTEcCHMB29vphsaKvws5gsMDIJt/BC0qrM99rH5tLpsW1J11DayDVBdeKanjsAdDr0hz85UZqsE099fXGz/bJcs6zANNyexmtuUe9qR1XjqvkREOxEbLLDAwSM2hD8vjvfbjFBRAMWkk020ewqLkAFIuxsnTFC24+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652355; c=relaxed/simple;
	bh=lUtDE7G+o+yg5gTMC5yu0v0IXP/lPo62j+tZSonLD48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4Wj3zuPoe70q0wobaCR4MPRHz0355AgFmbJf97d68BRXp4mCi09yYM9WC6MnW+VYnfNWzDStS4YxcVJpginhIkm/FzPmJuqX9zHACRirDCUstOIh6oC0btuf25oRQFfFABHoNTC6zNdvgiEebfeAaatkZkAHhZVNUTxW6BUlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=odi1HpSW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="odi1HpSW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H4wimw024657;
	Sat, 17 Jan 2026 12:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sRNfiT
	9AZHbvku7XXddktnPcFtdkHPLA0D5ppUwG/W4=; b=odi1HpSW+IusbKDxhcRnXc
	U/Nu0h/ilvSplw9l7rm3V0swz0/AmkMeJrSV33JCqDaH/YWzUhZWQbemboMcupD3
	WppvfZtE05HUWpm+GuYXFJ973d1KHUiMjiTmgcKrVFxzFy3lw94k05vgQ9mwx1Lv
	Eoj1qqKIdF/Ttxp4GkxhBUeSCW0cnehwGp1xCSaMa7GnDs726eaLqG0RhDtWn3Lc
	17WRs9NlTnBW3FTwCbdqlpBP7L1h3AijnMBEgV8kFpOzNmcGzt3B3KPX9Yb81TIT
	3Ub5ohnHuCazc3H4PxXpN4X/JETLWgCjBNBI7Bb9MYgbe9Cy8x8uIX2q7AgPhZoA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rh68b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 12:19:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60HCJ4HK019224;
	Sat, 17 Jan 2026 12:19:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rh688-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 12:19:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60HASd4q014010;
	Sat, 17 Jan 2026 12:19:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bqv8utw2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 12:19:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HCIxLY56295850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 12:18:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49DAA20043;
	Sat, 17 Jan 2026 12:18:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC6220040;
	Sat, 17 Jan 2026 12:18:57 +0000 (GMT)
Received: from [9.39.20.22] (unknown [9.39.20.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 12:18:57 +0000 (GMT)
Message-ID: <00e91ebc-0783-4519-9727-53dd3a625298@linux.ibm.com>
Date: Sat, 17 Jan 2026 17:48:56 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
To: Joel Fernandes <joelagnelf@nvidia.com>, Samir M <samir@linux.ibm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Paul E McKenney
 <paulmck@kernel.org>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20260114183415.286489-1-urezki@gmail.com>
 <1c6b741e-acfd-432b-bd04-4534c2e2511a@linux.ibm.com>
 <B7C99D22-0544-4177-A299-E3D458EA55F6@nvidia.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <B7C99D22-0544-4177-A299-E3D458EA55F6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LduQfPOYC426AD_BLQSoYo_x9yVBxdqI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDEwMSBTYWx0ZWRfX40hPwgHyEvHA
 RK2ND5xSoZTC2SZZX43n5hOXHFxYyHPpqRHaUgwiqmP5DS0p2FQvgIEp8kmACKNccwJHOd3ffl9
 FSiMQlVL2SrPodJmFL+9Js40D61Sn21dULqUoZHbuK7tbgAK1XXAZi57v2DCpAojUaH+hwnCXAy
 ZNzcsB7R4yRxzs7WLIw3uKiw7d8Sr8e0d/xbS935k/mok83wktEwgw2ed336Pa6MKuoV+ReiYLU
 /rk8TL5zohfbd73y0WujYXz1+Wh8SC5Q6OXd8NCM/ajxEkFTCCXg/yZ9xna3OTjnqcNJFounh6N
 s3HxlLGRpdXcIEJZqI8hmRMpkkIvQ8bdePYTt/2M7GajcdNOxQFGRFcCst5dKgr+5hrSEdAVUGq
 YqqokT2LMRlTW2CuskD+/3Ej4KcNWEY/W8i7POUoy9k8Q9qhjz1I3wgXjW6nyphO1BrmMnvnjh9
 DqqDX5+uZJx+5KIZwwQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696b7e38 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=DiE8bJjBprXz9EmmcpMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 01AzHJlL39lPlsmTZgzEAgoiX7aUWt8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601170101



On 1/17/26 2:18 PM, Joel Fernandes wrote:
> 
> 
>> On Jan 17, 2026, at 1:17 AM, Samir M <samir@linux.ibm.com> wrote:
>>
>> ﻿
>>> On 15/01/26 12:04 am, Uladzislau Rezki (Sony) wrote:
>>> Currently, rcu_normal_wake_from_gp is only enabled by default
>>> on small systems(<= 16 CPUs) or when a user explicitly set it
>>> enabled.
>>>
>>> This patch introduces an adaptive latching mechanism:
>>>   * Tracks the number of in-flight synchronize_rcu() requests
>>>     using a new atomic_t counter(rcu_sr_normal_count);
>>>
>>>   * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
>>>     the rcu_sr_normal_latched, reverting new requests onto the
>>>     scaled wait_rcu_gp() path;
>>>
>>>   * The latch is cleared only when the pending requests are fully
>>>     drained(nr == 0);
>>>
>>>   * Enables rcu_normal_wake_from_gp by default for all systems,
>>>     relying on this dynamic throttling instead of static CPU
>>>     limits.
>>>
>>> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>   kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
>>>   1 file changed, 26 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 293bbd9ac3f4..c42d480d6e0b 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>>>       atomic_set_release(&sr_wn->inuse, 0);
>>>   }
>>>   -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
>>> -#define WAKE_FROM_GP_CPU_THRESHOLD 16
>>> -
>>> -static int rcu_normal_wake_from_gp = -1;
>>> +static int rcu_normal_wake_from_gp = 1;
>>>   module_param(rcu_normal_wake_from_gp, int, 0644);
>>>   static struct workqueue_struct *sync_wq;
>>>   +#define RCU_SR_NORMAL_LATCH_THR 64
>>> +
>>> +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
>>> +static atomic_long_t rcu_sr_normal_count;
>>> +static atomic_t rcu_sr_normal_latched;
>>> +
>>>   static void rcu_sr_normal_complete(struct llist_node *node)
>>>   {
>>>       struct rcu_synchronize *rs = container_of(
>>>           (struct rcu_head *) node, struct rcu_synchronize, head);
>>> +    long nr;
>>>         WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
>>>           !poll_state_synchronize_rcu_full(&rs->oldstate),
>>> @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>>>         /* Finally. */
>>>       complete(&rs->completion);
>>> +    nr = atomic_long_dec_return(&rcu_sr_normal_count);
>>> +    WARN_ON_ONCE(nr < 0);
>>> +
>>> +    /*
>>> +     * Unlatch: switch back to normal path when fully
>>> +     * drained and if it has been latched.
>>> +     */
>>> +    if (nr == 0)
>>> +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
>>>   }
>>>     static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>>> @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
>>>     static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>>>   {
>>> +    long nr;
>>> +
>>>       llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
>>> +    nr = atomic_long_inc_return(&rcu_sr_normal_count);
>>> +
>>> +    /* Latch: only when flooded and if unlatched. */
>>> +    if (nr >= RCU_SR_NORMAL_LATCH_THR)
>>> +        (void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
>>>   }
>>>     /*
>>> @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
>>>         trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>>>   -    if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
>>> +    if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
>>> +            atomic_read(&rcu_sr_normal_latched)) {
>>>           wait_rcu_gp(call_rcu_hurry);
>>>           goto trace_complete_out;
>>>       }
>>> @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
>>>       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>>>       WARN_ON(!sync_wq);
>>>   -    /* Respect if explicitly disabled via a boot parameter. */
>>> -    if (rcu_normal_wake_from_gp < 0) {
>>> -        if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
>>> -            rcu_normal_wake_from_gp = 1;
>>> -    }
>>> -
>>>       /* Fill in default value for rcutree.qovld boot parameter. */
>>>       /* -After- the rcu_node ->lock fields are initialized! */
>>>       if (qovld < 0)
>>
>>
>> Hi Uladzislau,
>>
>> I verified this patch using the configuration described below.
>> Configuration:
>>      •    Kernel version: 6.19.0-rc5
>>      •    Number of CPUs: 2048
>>
>> Using this setup, I evaluated the patch with both SMT enabled and SMT disabled. The results indicate that when SMT is enabled, the system time is noticeably higher. In contrast, with SMT disabled, no significant increase in system time is observed.
>>
>> SMT=ON  -> sys 31m22.922s
>> SMT=OFF -> sys 0m0.046s
>>
>>
>> SMT Mode    | Without Patch    | With Patch   | % Improvement    |
>> ------------------------------------------------------------------
>> SMT=off     | 30m 53.194s      | 26m 24.009s  | +14.53%          |
>> SMT=on      | 49m 5.920s       | 47m 5.513s   | +4.09%
> 
> So it takes you 47 minutes to offline CPUs and you are Ok with that?
> 
> - Joel
>


This is certainly quite long. IMO not worth the added complexity
of atomic inc/dec reads happening(even though till 64 CPUs)

Samir,
can you post number's with vishal's patch of using rcu expedited?


> 
> 
>>         |
>>
>>
>> Please add below tag: Tested-by: Samir M <samir@linux.ibm.com>
>>
>> Regards,
>> Samir
>>
>>


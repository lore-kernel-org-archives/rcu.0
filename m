Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F029A2;
	Sun, 11 Jan 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126425; cv=none; b=rbYGwccaGwYSu39XNKrHXMmrvi4NKGDjtUXmonTuPzRJPhWpwbtVZgIc9ShjP8YyZiEWiPzCEx/ilIZA2qDEk353mVQFXFomJFQ7YyFGLgHImTCV49VFYBFk0Y7denOt+mLFk4VsfMgOBjuXCJMURKysr/FjDFKTzyka8gL825k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126425; c=relaxed/simple;
	bh=Y6L3xEiopzU/sRGnyVxOrORAaarG8jVvoSsLoGOwBL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NTfo/Xt+bFhwmos3hqdFmYw4Znr+hyhiDVirtx4g3d+2MbkW/P2ytOSYpUFQih1iBrYuIbslLy5OXSjPbmjcyVgkVWGGpTyzmrwT4FePOXz26fcliy+Vam3/Yz/00cOvHIHxGstdWEJnkieYptMT1bYJVUoN+L/m3l1EgzCD+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TQhjQqi8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TQhjQqi8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60ANhPbY020499;
	Sun, 11 Jan 2026 10:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b3mErA
	yhg43lzv1C7vLVNc1KC7UhA1N9bRuZl0A2raE=; b=TQhjQqi8pvA0LjHzFFcbpX
	iKPnBOf1mZ0bML1xMVum0E7I4J1ea6YG5w/48X5aZi7tI5prYaWfu+pZC4TyoUkg
	oD7vhtjX3FQm569QDC0Al0HLcZBi/glblesIzv2FFnmzD6xfF4P/+6fqWpxseDUv
	OPjOcSUwh5z4TtbjnxoDAwiDLm/tjzjeFmK9ila2AeRwaI/4odckmXrzzbog7t6U
	aWyR8D1fJJTrrj7ySxgUAxucGCpFvi8UrFUlHVz5yFgCjUyysewu6Ced+/ZdrneJ
	BXOKG82ZYGBBqK2E6eUsbethfO241Cp4x0GYAu5fn7uv0qQWC72w/+MPLN1xq/TQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6ducva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 10:12:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60BACj0W024734;
	Sun, 11 Jan 2026 10:12:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6ducv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 10:12:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60B7nWcl025866;
	Sun, 11 Jan 2026 10:12:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk188q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 10:12:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60BAChUo30409396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Jan 2026 10:12:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46D058056;
	Sun, 11 Jan 2026 10:12:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69CF5803F;
	Sun, 11 Jan 2026 10:12:38 +0000 (GMT)
Received: from [9.124.218.241] (unknown [9.124.218.241])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Jan 2026 10:12:38 +0000 (GMT)
Message-ID: <02d29108-e145-4513-a378-e2dc353b1ef3@linux.ibm.com>
Date: Sun, 11 Jan 2026 15:42:36 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
To: Joel Fernandes <joelagnelf@nvidia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        vishalc@linux.ibm.com
References: <20251230004124.438070-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20251230004124.438070-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _mFI_p59X70qyBwn9gUQYD-vMYEwQOQI
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6963779d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=m0FgJEIhpw_KhDw-Zv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDA4OCBTYWx0ZWRfX7u78/azMI3K6
 Fbc4t6SWGj80jzPHKYdwF9RY+5n63pxbBsxdJ5FPWQv+4b/03b9yiWOTvGBuj6WIUhhbZ2uiHIo
 tvQ7pghOwrYOEovAYFOIah3XzzWeKVpiRAKIGlHiHPumt73I+4gXhTLY9aGjuryKavQdiOd40nC
 ysf5oligCnaOR+hGVmu1AvnCOR+8I5lPM5Hsa2IKogm1S/LciPHvFtXmRdQuadoab9yDUiR2WYE
 1JjFCVGYgzbtFdlGCuyIB44lQRG8m65iITdmu4Aeco69hZZhgYyfaXujQfeebDq9nBgsidNnY6f
 tM/Yee0v1kWCpqoby2ypnPHSjnRQfgSkyr1xTO7yvhBLo370Pf5WlaVw97J4RU5GrXYk75W03SL
 nKMRKCABCD1036SgwqioaVIqkP4sXscoe9tpkdP0lUN6pm/N3nebr1oIZVOq6iP4onvsYZKWDGZ
 ErCxZLhswfAm7pyZ2Xw==
X-Proofpoint-ORIG-GUID: 1D5br22Ey5nXlbXc8hIAh7LEHnLtlKvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601110088


On 30/12/25 6:11 am, Joel Fernandes wrote:
> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> State) design where the first FQS saves dyntick-idle snapshots and
> the second FQS compares them. This results in long and unnecessary latency
> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> 1000HZ) whenever one FQS wait sufficed.
>
> Some investigations showed that the GP kthread's CPU is the holdout CPU
> a lot of times after the first FQS as - it cannot be detected as "idle"
> because it's actively running the FQS scan in the GP kthread.
>
> Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> GP kthread cannot be in an RCU read-side critical section while running
> GP initialization, so this is safe and results in significant latency
> improvements.
>
> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> showing significant latency improvements (default settings for fqs jiffies):
>
> Baseline (without fix):
> | Run | Mean      | Min      | Max       |
> |-----|-----------|----------|-----------|
> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
>
> With fix:
> | Run | Mean     | Min      | Max       |
> |-----|----------|----------|-----------|
> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
>
> Summary:
> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
>
> Additional bridge setup/teardown testing by Uladzislau Rezki on x86_64
> with 64 CPUs (100 iterations of bridge add/configure/delete):
>
>                                 real time
> 1 - default:                   24.221s
> 2 - this patch:                20.754s  (14% faster)
> 3 - this patch + wake_from_gp: 15.895s  (34% faster)
> 4 - wake_from_gp only:         18.947s  (22% faster)
>
> Per-synchronize_rcu() latency (in usec):
>                1         2         3       4
> median: 37249.5   31540.5   15765   22480
> min:    7881      7918      9803    7857
> max:    63651     55639     31861   32040
>
> This patch combined with rcu_normal_wake_from_gp reduces bridge
> setup/teardown time from 24 seconds to 16 seconds.
>
> Tested rcutorture TREE and SRCU configurations.
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>   kernel/rcu/tree.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 78c045a5ef03..b7c818cabe44 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
>   			      unsigned long gps, unsigned long flags);
>   static void invoke_rcu_core(void);
>   static void rcu_report_exp_rdp(struct rcu_data *rdp);
> +static void rcu_report_qs_rdp(struct rcu_data *rdp);
>   static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>   static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
> @@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
>   	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>   		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
>   
> +	/*
> +	 * Immediately report QS for the GP kthread's CPU. The GP kthread
> +	 * cannot be in an RCU read-side critical section while running
> +	 * the FQS scan. This eliminates the need for a second FQS wait
> +	 * when all CPUs are idle.
> +	 */
> +	preempt_disable();
> +	rcu_qs();
> +	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
> +	preempt_enable();
> +
>   	return true;
>   }
>   

Hi,


I verified this patch on ppc64 systems and observed consistent 
performance improvements.

The testing was conducted on Power LPARs using 20 cores (160 CPUs) with 
SMT enabled and disabled. All tests were performed on the latest 
upstream kernel (v6.19.0-rc3+), and the patch showed measurable 
improvements in both SMT configurations.

SMT Mode   |      With Patch (s)    |    Without Patch (s)  | 
Improvement (%)
————————————————————————————————————
SMT ON.      |    51.662               |      75.540  |       31.61% faster
SMT OFF      |    44.246               |      59.933  |       26.18% faster

Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>

Thanks,
Samir


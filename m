Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A282AD0C;
	Mon,  8 Jun 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910197; cv=none; b=EpSWm01z0xqXutMUvTdE15eRTttRueXplf+w8kFElyiUnH1pNQ2Ubj2prKKNRKRE3tbZx/5gnIYanRd/Ql6jjGYojabZ2XDP+XdXqyaMpMWSBP+VSimmXCskops3/PconrNL0c2ufJJq8dkwSc0YSCYbH1i28QXk74nLYboW+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910197; c=relaxed/simple;
	bh=Fc4Hzd5WS7zNcoerRKsEPWoQCH2DM3ophsDO2DDX2BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWQu3h/+oBJNgWDq0xzaP4888yTT+wVQqcey11/V2jxwgSWOEkTUVkUG664uNS7NtuHuPYdmNtk1db5G3x90TjSW0lgdU2sKZvM/RHpnxe432OQ957/VJ27DoAeJ+t2EQCAunqaGkNYUVVs8e+taed/B8yrt0fvmsDWGuRimgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sPEMxKVH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sPEMxKVH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586c5Yh2323666;
	Mon, 8 Jun 2026 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BWrIZy
	JXZYhOWZXAGvXikimc9ccv2vD3i2Nd1K8LAO0=; b=sPEMxKVHGnjFDHF2TuUYRc
	qZdNeFArOGDX6oxc5eGY9+Q8cYd7bX5fsbbNKnhGRi8jFxVMjxXb4/i/b7gsJTrM
	3pfMgBm83k9//M/Jq8GRT66hCQ3XjLJKPS7t/OnjDcNgCrJGNH1PwDEUMo+AMdUz
	oPAcCuCQvwuDyYbB3iHygeH1VHy2Y0EVjw03pSNb4nXmBbUuvxcS6raib3rZN3cx
	lV1gQGg28ZobcUrOCHR0f6rHa0aVg/GsL3d1I4Ect/fd6xbeK+TDMkdyutr6ChIB
	8T/hII+iY2fTQ6RLYv+cDd1IuuF9xvr2FSpHf53gDmRSK9sqIhyF3+uBcw+wCe4g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhppjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 09:16:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65894sOg012179;
	Mon, 8 Jun 2026 09:16:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fverw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 09:16:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6589G2dv42795448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 09:16:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5612004B;
	Mon,  8 Jun 2026 09:16:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA0D20040;
	Mon,  8 Jun 2026 09:15:58 +0000 (GMT)
Received: from [9.123.2.84] (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 09:15:58 +0000 (GMT)
Message-ID: <f54ab277-cd9f-4d09-86ba-ea74a9648547@linux.ibm.com>
Date: Mon, 8 Jun 2026 14:45:57 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
To: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, sshegde@linux.ibm.com, urezki@gmail.com,
        samir@linux.ibm.com
References: <20260507053928.2975867-2-vishalc@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20260507053928.2975867-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX/sUPJY2jyhq0
 q4kk0ENrY4lbMMQeMO3F/zEwET7CeQbwYTBwNFZzGrEzRzyT0lXbJV8aGiqyLwiLEKz5hwW/i7m
 KCOCxR1aQVIkG4RZO0FObseWt3Tu6G+a6tpin02L2G+4NoUct9D3c+7U52J2p8COVQnhsgwrHfG
 QMchmOPRLhI82EUKlq98D4IG4RHF7cWEsCouUAlux3Ib3vsntfPCcZfeZ6oEx+ZuU1kmBYs+bDk
 /8nRjiHfQNLkiD2PR4a/dm7fjBEy6mZo2g8MjHURGllF2PYnMKTum7kyusE5yfX1bjoW22wtL/m
 0xt3lDwz/Kube2uZALc6f8/szOAesizpNK1pLmP2dvGNqrWgu4SyIsocqun7xpwU9AnZ0cW1MMX
 OudV8IozhItLkwU75KpbfZyRQY47QJUaoGzI0pWa3uRMPXCMbNLwnoAoUpFkzbEk/wy6G0BDIqE
 M840TeV/whtcRlqQBag==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a268856 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8 a=Ikd4Dj_1AAAA:8 a=zGnbNwYJTL78zy_cPoEA:9
 a=QEXdDO2ut3YA:10 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-ORIG-GUID: mHm5t7NZY69TceaBj6OMPvH-CpNV272h
X-Proofpoint-GUID: LJVZVlNuRsXOi0k36eJExYOQZRXCqxz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084

Hi All,

Gentle ping.
Should I send another version with the tags?

Thanks,
vishalc

On 07/05/26 11:09, Vishal Chourasia wrote:
> Hello All,
>
> SMT mode switch operation on a large CPU count system takes close to an
> hour to complete. Initial debugging root caused the delay to the CPU
> hotplug subsystem being blocked on numerous synchronize_rcu() calls.
> Simply enabling system-wide RCU expediting reduced the switch time to
> 5-6 minutes. Since then, different approaches have been explored, of
> which some had their own side effects and others didn't work as
> expected.
>
> Approaches explored:
>
> 1. Expedited individual CPU hotplug operations by wrapping
> _cpu_up()/_cpu_down() with rcu_expedite_gp()/rcu_unexpedite_gp() [0].
> Peter suggested expediting only when SMT switch is triggered via the
> sysfs control interface, not for individual hotplug operations [1].
>
> 2. Replacing synchronize_rcu() calls in the CPU hotplug codepath with
> their expedited variants. This is not viable because one
> synchronize_rcu() is invoked inside cpus_write_lock(), which is shared
> with other kernel subsystems [5].
>
> 3. Hoisting cpus_write_lock() to be taken once for the entire SMT switch
> operation instead of per-CPU [3][4]. On large systems where the SMT
> switch can still take 5-6 minutes, holding the lock for that duration
> causes hung task splats and starves other subsystems depending on the
> read lock.
>
> 4. Peter has also suggested using rcu_sync_{enter|exit}() which as is
> doesn't help as is, but can be paired the approach 2 from above.
>
> Current approach: expedite RCU grace periods around the SMT switch
> operation in the sysfs control interface path, per Peter's suggestion
> [1], with Aboorva's analysis confirming synchronize_rcu() as the
> bottleneck [2].
>
> [0] https://lore.kernel.org/all/20260218083915.660252-2-vishalc@linux.ibm.com
> [1] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
> [2] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> [3] https://lore.kernel.org/all/20260119114333.GI1890602@noisy.programming.kicks-ass.net/
> [4] https://lore.kernel.org/all/ba470918-0ad9-4548-9161-826948462f73@linux.ibm.com/
> [5] https://lore.kernel.org/all/804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com/
> [6] https://lore.kernel.org/all/e2cca734-9191-4073-ba9d-936014498645@linux.ibm.com/
>
> Vishal Chourasia (1):
>    cpuhp: Expedite RCU when toggling system-wide SMT mode
>
>   include/linux/rcupdate.h | 8 ++++++++
>   kernel/cpu.c             | 4 ++++
>   kernel/rcu/rcu.h         | 4 ----
>   3 files changed, 12 insertions(+), 4 deletions(-)
>

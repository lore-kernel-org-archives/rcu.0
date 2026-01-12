Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F03090D4;
	Mon, 12 Jan 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240409; cv=none; b=KA2EwcQ4YWraYz3Yp5ZqG0IMQIUV2NPJzU3PnAXN7qY6QSlNruRA8h7l54j8cmLbkLcMerMWkfcYP2A89D5QD9GPctOVClwQ209qSmarJDM8POgLbEextXHS63sf+pUjCcwlIVY1hgiT+KfvEsr0HguwjjPRaY6YY8DZPEVl7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240409; c=relaxed/simple;
	bh=9tFeR/624zMyQnAsopib4yxsLLLn7O+wlj0O/ePAUYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTAr07N8oSO86UBjdmoN2k3Yx2cb/2PgSgboxJy3L/kIUjKw6uroUvhM+4vFSmwhjXlKs4G9DjUl5Lx6Bowv+k2X8YO1KW+hQjUPpesvTuZ6/7in0QLWYeWmBDRhz9Yu8HSOJ85jlPHi029iz5PltlVzOvRKcLWo7oWN6t7S5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nFY03ivM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nFY03ivM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CEIdtB025420;
	Mon, 12 Jan 2026 17:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5BPS7L
	X1IGFyTUvFRHqLiYRPjDPgqliDpmnzbD1R9S4=; b=nFY03ivM9HmBvq2DsO0Byq
	BhRQTncZ5C70f6jzm2KEZIZbCIdNKzGsBxh5O5J3p3MoXZdv6Kfmaj7yu8KNi5Zf
	NSp5F0gZ3CT2rV0MtpG1VesLDYv5HAk5mN4K0DcqMPGuI8SD7Su5n/b9vYcsw+ng
	c/XAKhqUHjjfBiVAsz4zOvTdKqs5BTUGvtHfRp5AKRxaBdvQoJ1fVI6TynbfLbuR
	LXYKxg346t0QCiawKfMAFPyykW1cwzgWa3EtJLTrvnArn4CyJeOwDmXBtpyGEqhF
	XRIcUNpEfmtMcaqollyero6oZhnNx6dYcsRWut7zZ4A/jJXXOwuHOrs2EYDPRWwg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsr3ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 17:53:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CHqiFF002035;
	Mon, 12 Jan 2026 17:53:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsr3ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 17:53:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CH0aMd030146;
	Mon, 12 Jan 2026 17:53:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajf8e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 17:53:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CHr4I615466986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 17:53:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78CA820040;
	Mon, 12 Jan 2026 17:53:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDBF2004B;
	Mon, 12 Jan 2026 17:53:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.219.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 17:52:59 +0000 (GMT)
Date: Mon, 12 Jan 2026 23:22:57 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sshegde@linux.ibm.com" <sshegde@linux.ibm.com>,
        "srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWU0-WmIQMrKj8zL@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
 <804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com>
 <20260112142350.GM830755@noisy.programming.kicks-ass.net>
 <A80BD0D2-181C-4C63-92F0-0B9E52F68F8F@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A80BD0D2-181C-4C63-92F0-0B9E52F68F8F@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE0NyBTYWx0ZWRfX80icYQjA/+Ns
 j4dB9Vlw+axIz3kX/GC0xOjFgbUg2Tgw963Ewp/1JUW/qMVxd+Cr0yb+mNQ4HL+S2DRqGdwtYX9
 2mOlV4OVTUM6fVcmM1UlgxyYzjFtgYP9HA2hpVYYfx7f+MGhAZAwnMo5lBdvlwnIUR2RqtVPOG9
 9pxrWuZ1+fJaaTkehOD027ZI1tGakkLXhxMWvGoIOL0mW6dNSHtRGtNIKTUnTgRzj9k1yupUuUX
 zTGIu5DQFeOzI5iMOm71RMp5iOw/RJP3ltxGsBu3HuLfpUsF7zfi4Ue1E3MNO3DH6Pp7wXQcJFe
 QvsM1+/vZ5uSqWdUaSoKBlQMslxdKsUEMmJMAMTuNSpCND4XELgtAhGAuqOrVYtyYWnLSdZhk7v
 hCIEOelMr3iFCxVEnIg9zcZnzaql8Y1/QLT7Mn538idzN/aMX0H51dkwM28JfAK2eKo3PUYeO/p
 5J/jrrqhb1iv01Sufag==
X-Proofpoint-GUID: V0vXH1QVWoE1w6Kq6clEUHGEIujdw841
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=69653505 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=IuDSSwbg3ngUWycUSDIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: xabCpLyIuD4Tw-yzJfX4kDYt24FMa7oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120147

Hello Joel, Peter

On Mon, Jan 12, 2026 at 02:37:14PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 9:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Mon, Jan 12, 2026 at 02:20:44PM +0000, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Jan 12, 2026, at 9:03 AM, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >>> 
> >>> ﻿
> >>> 
> >>>> On Jan 12, 2026, at 4:44 AM, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >>>> 
> >>>> ﻿Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>> systems, this process takes significant time, increasing as the number
> >>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>> waiting for synchronize_rcu().
> >>>> 
> >>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>> it should complete as quickly as possible.
> >>> 
> >>> When does the user initiate this in your system?
Workloads exhibit varying sensitivity to SMT levels. Users dynamically
adjust SMT modes to optimize performance.

> >>> 
> >>> Hotplug should not be happening that often to begin with, it is a slow path that
> >>> depends on the disruptive stop-machine mechanism.
Yes, it doesn't happen too often, but when it does, on machines with 
(>= 1920 CPUs) it takes more than 20 mins to finish.

> >>> 
> >>>> 
> >>>> Performance data on a PPC64 system with 400 CPUs:
> >>>> 
> >>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>> Before: real 1m14.792s
> >>>> After:  real 0m03.205s  # ~23x improvement
> >>>> 
> >>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>> Before: real 2m27.695s
> >>>> After:  real 0m02.510s  # ~58x improvement
> >>> 
> >>> This does look compelling but, Could you provide more information about how this was tested - what does the ppc binary do (how many hot plugs , how does the performance change with cycle count etc)?
The ppc64_cpu utility generates a list of target CPUs based on the
requested SMT state and writes to their corresponding sysfs online
entries.

Sorry, I didn't get your second question about the performance change
with cycle count.
> >>> 
> >>> Can you also run rcutorture testing? Some of the scenarios like TREE03 stress hotplug.
Sure, I will get back with the numbers.

> >> 
> >> Also, why not just use the expedite api at the callsite that is slow
> >> than blanket expediting everything between hotplug lock and unlock.
> >> That is more specific fix than this fix which applies more broadly to
> >> all operations. It appears the report you provided does provide the
> >> culprit callsite.
I initially attempted to replace synchronize_rcu() with
synchronize_rcu_expedited() at specific callsites. However, the primary
bottlenecks are within percpu_down_write(), called via _cpu_up() and
try_online_node(). Please refer to the callstack shared below. Since
percpu_down_write() is used throughout the kernel, modifying it directly
would force expedited grace periods on unrelated subsystems.

@[
    synchronize_rcu+12
    rcu_sync_enter+260
    percpu_down_write+76
    _cpu_up+140
    cpu_up+440
    cpu_subsys_online+128
    device_online+176
    online_store+220
    dev_attr_store+52
    sysfs_kf_write+120
    kernfs_fop_write_iter+456
    vfs_write+952
    ksys_write+132
    system_call_exception+292
    system_call_vectored_common+348
]: 350
@[
    synchronize_rcu+12
    rcu_sync_enter+260
    percpu_down_write+76
    try_online_node+64
    cpu_up+120
    cpu_subsys_online+128
    device_online+176
    online_store+220
    dev_attr_store+52
    sysfs_kf_write+120
    kernfs_fop_write_iter+456
    vfs_write+952
    ksys_write+132
    system_call_exception+292
    system_call_vectored_common+348
]: 350


> > 
> > Because hotplug is not a fast path; there is no expectation of
> > performance here.
True.

> 
> Agreed, I was just wondering if it was incredibly slow or something. Looking forward to more justification from Vishal on usecase,
> 
>  - Joel
> 
> 
> > 

- vishalc

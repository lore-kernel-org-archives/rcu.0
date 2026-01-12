Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D723876A7;
	Mon, 12 Jan 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242492; cv=none; b=JBN2kCt2BfyloBeZiydgGHn7HUQiE16QtNTdJGJ6uBrEBwNBJPGLFn+otQ3rQhNtv66oxoA8+slFYAs6JP9fGPvriCaaw20Ea4lJUDdY1ZqeWWDcXoZdZoW0dVyx8+PLq025pA7oNTqwG38UgumY0wyE/ytwbBpdHJ+Po5l+Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242492; c=relaxed/simple;
	bh=vUCWSFBA5wLaF5nouDQXhD9wXgppU6eLXNQYkMUJiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1vN9dmZD5VGweE4FhIYA3AZ1HjxhE1hwW8ixUDL1vonuKaooByKcgx+ARlc3Z8uxE8wCd5GsCPAA+yzDO1QWLDvgZvLTD8rhqOP/eFAPQUCStIm4PPUKU22XCWXNP1uTLDvmJ7Y3dC7P3efcPhH57IODFdfEAoZSXoLoFjNoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bZM6uiU6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bZM6uiU6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CEfBdr027622;
	Mon, 12 Jan 2026 18:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gz2vF8
	aN2uxxBRZt5KwvxEzHrDZhngjjqLpgkYrjpxc=; b=bZM6uiU6H4QMobZv92ilNJ
	BjEEHL0RX2393bFmmRuBdTfi0WkMrrz1+9NKiO3EAoZNLxCOGHwIkiVwNzYL6b9O
	YV6YCrD/qs7eJp3VrlCGqRLV4XDPlZtAUbjCakYayaXQV02ypecmAkUy7ht2R9GA
	6A4NLB2/DeFRfiwxqEfy9qWK9pC9mjENgxxWvjXsPC0x94DS6GKcuJNmC/fy3uts
	BY5+36pVEP5H/9i7kQbak95hH6E6zemgiojXpCRzXEb8kpQN+CB5RpfDavmxcmQO
	gxsJepgeIbeBB+HAbIxfxVnLHhdwTvAYJ83hLU3VVbGgT4HOLXopB/oLyEFTdQSw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92rhwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:27:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CIPUYR001643;
	Mon, 12 Jan 2026 18:27:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92rhwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:27:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CGSMEi025566;
	Mon, 12 Jan 2026 18:27:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23myjdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:27:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CIRnCK28901754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 18:27:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC5120043;
	Mon, 12 Jan 2026 18:27:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A200D20040;
	Mon, 12 Jan 2026 18:27:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.219.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 18:27:44 +0000 (GMT)
Date: Mon, 12 Jan 2026 23:57:41 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWU9HRcs4ghazIRg@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <aWUp2kDi5gjGKOtR@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWUp2kDi5gjGKOtR@milan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ieAc3U3gfD7Eoz848lJItRWSC83f23YX
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=69653d2b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=3fAPb923sxGvbwOllI0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1MSBTYWx0ZWRfX7MFvdURX7nxS
 mV9OxPtx/d9z3waH/46LHxhZV5E6usadgDeVuAPehYXGsmY9bu6X2DLpSvxj7mIfBfxys/oWwsW
 IoYL2Fx+EhhWI5qnqEONHFC32w7fMB2ct6+zJ7PWALVKQQItxeaQbiNElifvipJq1Rk5r9oWpJs
 MYmyzwKn/8JU/E7dx+fpDGhsiEOuXQcFFo0yXDK/J1EU4oI7FiJLj82vnWezZlasDUnqkHPcyEn
 iZO4uIGPPb5q8WyZf12uHfKv/7TCN/VsUtBdCH0ntuJGgXapIK6nU5UKGqGxa1YA+xS3yOt72l1
 AyNSO9SIDrmAojDrBkkppJbIUHkORVPazPj/5grrmZNR+IxwUS7MdyXo+td3DNRU3hF6F32HcZh
 JDqeu1f98sJ/ZuplJI1Zp1ZIWUkMWwXgkn+C9xCBFwkw65TihCfsgy4eibboIpMsOm7GifqK8WO
 j4o3RiTAEnjl4PuD2sw==
X-Proofpoint-GUID: XtC4UOu2COnH6TjVxidz-DfGMYQXgOvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120151

Hello Joel, Paul, Uladzislau,

On Mon, Jan 12, 2026 at 06:05:30PM +0100, Uladzislau Rezki wrote:
> On Mon, Jan 12, 2026 at 08:48:42AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > 
> > > >> 
> > > > Sounds good to me. I agree it is better to bypass parameters.
> > > 
> > > Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> > > 
> > > I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
> > 
> > This would require increasing the scalability of this optimization,
> > right?  Or am I thinking of the wrong optimization?  ;-)
> > 
> I tested this before. I noticed that after 64K of simultaneous
> synchronize_rcu() calls the scalability is required. Everything
> less was faster with a new approach.

It is worth noting that bulk CPU hotplug represents a different stress
pattern than the "simultaneous call" scenario mentioned above.

In a large-scale hotplug event (like a SMT mode switch), we aren't
necessarily seeing thousands of simultaneous synchronize_rcu() calls.
Instead, because CPU hotplug operations are serialized, we see a
"conveyor belt" of sequential calls. One synchronize_rcu() blocks, the
hotplug state machine waits, it unblocks, and then the next call is
triggered shortly after.

The bottleneck here isn't RCU scalability under concurrent load, but
rather the accumulated latency of hundreds of sequential Grace Periods.

For example, on pSeries, onlining 350 out of 400 CPUs triggers exactly
350 calls at three different points in the hotplug state machine. Even
though they happen one at a time, the sheer volume makes the total
operation time prohibitive.

Following callstack was collected during SMT mode switch where 350 out
of 400 CPUs were onlined,

@[
    synchronize_rcu+12
    cpuidle_pause_and_lock+120
    pseries_cpuidle_cpu_online+88
    cpuhp_invoke_callback+500
    cpuhp_thread_fun+316
    smpboot_thread_fn+512
    kthread+308
    start_kernel_thread+20
]: 350
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

Following callstack was collected during SMT mode switch where 350 out
of 400 CPUs where offlined,

@[
    synchronize_rcu+12
    rcu_sync_enter+260
    percpu_down_write+76
    _cpu_down+188
    __cpu_down_maps_locked+44
    work_for_cpu_fn+56
    process_one_work+508
    worker_thread+840
    kthread+308
    start_kernel_thread+20
]: 1
@[
    synchronize_rcu+12
    sched_cpu_deactivate+244
    cpuhp_invoke_callback+500
    cpuhp_thread_fun+316
    smpboot_thread_fn+512
    kthread+308
    start_kernel_thread+20
]: 350
@[
    synchronize_rcu+12
    cpuidle_pause_and_lock+120
    pseries_cpuidle_cpu_dead+88
    cpuhp_invoke_callback+500
    __cpuhp_invoke_callback_range+200
    _cpu_down+412
    __cpu_down_maps_locked+44
    work_for_cpu_fn+56
    process_one_work+508
    worker_thread+840
    kthread+308
    start_kernel_thread+20
]: 350


- vishalc

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4318DF80;
	Fri,  6 Mar 2026 05:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775933; cv=none; b=lgLlW+8li5sPj8S+bCo7nDMPXU7/BD6Mw04Yjd2v84n0Pm/r6w16nym7nJDph1tnlBs622tm0tg/lE+33DlKOUGU4U1nJzpYGoVMKzzQBao7/7qULyEWhZl801phNRmX7G+ypVctFuiXwNbaoP8KHtgS2QPQeRVhwhdz87He6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775933; c=relaxed/simple;
	bh=itF4KUG16cCX3NRAbLtqsKOUWA2L3xqd5kI/CS1hy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTktAey6j1NQEHFZVXpEqh/R1gN8I6DBkTK9Rm7+nwu4xEE+OtPa/OpRuagIGzAO23fm4D2o28t14d4SncML2pAfm0mTieutEvfy9XAbPWwuEgLxiFTrKydg9bf+86+NSRrc+/tLwzQiVRaT7thpi7HeMutc+rsZWDNIoQsB9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eh65aNfc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eh65aNfc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264TYi61195516;
	Fri, 6 Mar 2026 05:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lKW1cY
	CKI+OJi3IerQUKzwDxKJLEF0ZOKDC+6nNPz6Q=; b=Eh65aNfciGVGCnUpEUlJjt
	kOEHJrqAZZzTElE51qnQPpRHBiGTxMscF736pSqJvH14a835STq1zeNHbBA07wsE
	f3KcAWhY3FP0GxeQ0XfS22NtrxT9dP2UWIZ25t5AM63lBminXget7BXSFK4ccaKC
	tmYCbKDiaqn09+whcrpJl/QY7iIitHkam5MB7AA/Ba+Zn7wwWU9Kn0rNyHF0y5VE
	sHMssQ4eYwMMJH+QaLiEz0x2mc+TZ0mn2wGd1GOX/mfZ35cGzSmaAeSJpTO5PEcA
	UhivucJsYW+lm8GIvdyJpWgQI6Xy6B6ic6b1kqQBo0CcPyAqVRiGx4rBBlgaTLDQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc6ge5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:44:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6262wEkO029112;
	Fri, 6 Mar 2026 05:44:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapserng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:44:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6265iWUV37814754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 05:44:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C025E2004B;
	Fri,  6 Mar 2026 05:44:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094352004F;
	Fri,  6 Mar 2026 05:44:20 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.212.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 05:44:19 +0000 (GMT)
Date: Fri, 6 Mar 2026 11:14:13 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Samir M <samir@linux.ibm.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, peterz@infradead.org,
        aboorvad@linux.ibm.com, boqun.feng@gmail.com, frederic@kernel.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
Message-ID: <aapprY-prH0l_WeK@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
 <20260227011352.GA1089964@joelbox2>
 <94b3284b-885d-4263-99ed-728375c1a2b7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94b3284b-885d-4263-99ed-728375c1a2b7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jCZZt-urDO_FlLW-3BYUVjUwy2oMTJZz
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69aa69c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qa_zn0d_QxpL_5bZ3r8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA0NyBTYWx0ZWRfX1K6AlmxOQbJQ
 rqWRUrGsEgfP+N+NtmpX+qknwsYgDpC4mz7hh/SaUI5osQj9WDQlNj0/McyIgJly1XdEhufCC6u
 azk/GmMfYfg2iIxKptHpqxmSVRjF3PGxkJvthup2NsxS4qfW4slhvqxJQKp813SRYPvUs9OA8En
 wIl45PkKrVGw+sVT9bPIaShqp/VV7nSZ9vU9QVULHt/o9F5eid+C5CCcoyoH7FDOwi01FizPj2u
 g1iGXQwCWcp2faCtrWqYljuDeEPh5flq1DtICnAPSTMTS1J6B33Mah7ZOyrnGZgZvkBBOIRotlH
 pMBgVD7cYhmGf7B6cZwYedEIWhs2I16MUhWs9v0RvN2I8eWbnKXu9G9/gN0HjPpte2HLBPir225
 xbIGvnspJqDxFoQyVMIAC5QQuYgb4hzdJYkTS+Og0WBpnjDaPO13c2xLXys+4Bm6/EM1ZXVYHoc
 1q5Q4aSKoHrxh5uH3+Q==
X-Proofpoint-GUID: k279IMPVZRj_TANi2xld2cRgjCh3CNdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060047

On Mon, Mar 02, 2026 at 05:17:16PM +0530, Samir M wrote:
> 
> On 27/02/26 6:43 am, Joel Fernandes wrote:
> > On Wed, Feb 18, 2026 at 02:09:18PM +0530, Vishal Chourasia wrote:
> > > Expedite synchronize_rcu during the SMT mode switch operation when
> > > initiated via /sys/devices/system/cpu/smt/control interface
> > >
> > After the locking related changes in patch 1, is expediting still required? I
Yes.
> > am just a bit concerned that we are papering over the real issue of over
> > usage of synchronize_rcu() (which IIRC we discussed in earlier versions of
> > the patches that reducing the number of lock acquire/release was supposed to
> > help.)
At present, I am not sure about the underlying issue. So far what I have
found is when synchronize_rcu() is invoked, it marks the start of a new
grace period number, say A. Thread invoking synchronize_rcu() blocks
until all CPUs have reported QS for GP "A". There is a rcu grace period
kthread that runs periodically looping over a CPU list to figure out all
CPUs have reported QS. In the trace, I find some CPUs reporting QS for
sequence number way back in the past for ex. A - N where N is > 10.

> > 
> > Could you provide more justification of why expediting these sections is
> > required if the locking concerns were addressed? It would be great if you can
> > provide performance numbers with only the first patch and without the second
> > patch. That way we can quantify this patch.
> > 
> > 
> SMT Mode    | Without Patch(Base) | both patch applied | % Improvement  |
> ------------------------------------------------------------------------|
> SMT=off     | 16m 13.956s         |     6m 18.435s     |  +61.14 %      |
> SMT=on      | 12m 0.982s          |     5m 59.576s     |  +50.10 %      |
> 
> When I tested the below patch independently, I did not observe any
> improvements for either smt=on or smt=off. However, in the smt=off scenario,
> I encountered hung task splats (with call traces), where some threads were
> blocked on cpus_read_lock. Please also refer to the attached call trace
> below.
> Patch 1:
> https://lore.kernel.org/all/20260218083915.660252-4-vishalc@linux.ibm.com/
> 
> SMT Mode    | Without Patch(Base) | just patch 1 applied   | % Improvement 
> |
> ----------------------------------------------------------------------------|
> SMT=off     | 16m 13.956s         |     16m 9.793s         |  +0.43 %     
>  |
> SMT=on      | 12m 0.982s          |     12m 19.494s        |  -2.57 %     
>  |
> 
> 
> Call traces:
> 12377] [  T8746]    Tainted: G      E 7.0.0-rc1-150700.51-default-dirty #1
> [ 1477.612384] [  T8746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1477.612389] [  T8746] task:systemd     state:D stack:0   pid:1  tgid:1 
>  ppid:0   task_flags:0x400100 flags:0x00040000
> [ 1477.612397] [  T8746] Call Trace:
> [ 1477.612399] [  T8746] [c00000000cc0f4f0] [0000000000100000] 0x100000
> (unreliable)
> [ 1477.612416] [  T8746] [c00000000cc0f6a0] [c00000000001fe5c]
> __switch_to+0x1dc/0x290
> [ 1477.612425] [  T8746] [c00000000cc0f6f0] [c0000000012598ac]
> __schedule+0x40c/0x1a70
> [ 1477.612433] [  T8746] [c00000000cc0f840] [c00000000125af58]
> schedule+0x48/0x1a0
> [ 1477.612439] [  T8746] [c00000000cc0f870] [c0000000002e27b8]
> percpu_rwsem_wait+0x198/0x200
> [ 1477.612445] [  T8746] [c00000000cc0f8f0] [c000000001262930]
> __percpu_down_read+0xb0/0x210
> [ 1477.612449] [  T8746] [c00000000cc0f930] [c00000000022f400]
> cpus_read_lock+0xc0/0xd0
> [ 1477.612456] [  T8746] [c00000000cc0f950] [c0000000003a6398]
> cgroup_procs_write_start+0x328/0x410
> [ 1477.612462] [  T8746] [c00000000cc0fa00] [c0000000003a9620]
> __cgroup_procs_write+0x70/0x2c0
> [ 1477.612468] [  T8746] [c00000000cc0fac0] [c0000000003a98e8]
> cgroup_procs_write+0x28/0x50
> [ 1477.612473] [  T8746] [c00000000cc0faf0] [c0000000003a1624]
> cgroup_file_write+0xb4/0x240
> [ 1477.612478] [  T8746] [c00000000cc0fb50] [c000000000853ba8]
> kernfs_fop_write_iter+0x1a8/0x2a0
> [ 1477.612485] [  T8746] [c00000000cc0fba0] [c000000000733d5c]
> vfs_write+0x27c/0x540
> [ 1477.612491] [  T8746] [c00000000cc0fc50] [c000000000734350]
> ksys_write+0x80/0x150
> [ 1477.612495] [  T8746] [c00000000cc0fca0] [c000000000032898]
> system_call_exception+0x148/0x320
> [ 1477.612500] [  T8746] [c00000000cc0fe50] [c00000000000d6a0]
> system_call_common+0x160/0x2c4
> [ 1477.612506] [  T8746] ---- interrupt: c00 at 0x7fffa8f73df4
> [ 1477.612509] [  T8746] NIP: 00007fffa8f73df4 LR: 00007fffa8eb6144 CTR:
> 0000000000000000
> [ 1477.612512] [  T8746] REGS: c00000000cc0fe80 TRAP: 0c00 Tainted: G     
> E    (7.0.0-rc1-150700.51-default-dirty)
> [ 1477.612515] [  T8746] MSR: 800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE> CR:
> 28002288 XER: 00000000
> 
> 

Default timeout is set to 8 mins.

$ grep . /proc/sys/kernel/hung_task_timeout_secs
/proc/sys/kernel/hung_task_timeout_secs:480

Now that cpus_write_lock is taken once, and SMT mode switch can take
tens of minutes to complete and relinquish the lock, threads waiting on 
cpus_read_lock will be blocked for this entire duration.

Although there were no splats observed for "both patch applied" case
the issue still remains.

regards,
vishal
